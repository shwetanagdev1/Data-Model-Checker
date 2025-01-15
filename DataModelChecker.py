import mysql.connector

from DataTypes import *


# Bundles together functions for probing a MySQL database to confirm
# whether or not it adheres to specific properties of a logical/relational schema.
# Can be used to verify that a MySQL database correctly implements a design.
class DataModelChecker:

    # Ctor sets the connection details for this model checker
    def __init__( self, host, username, password, database ):
        self.host = host
        self.username = username
        self.password = password
        self.database = database
        # TODO: Implement me!
    
    def _execute_query(self, query):
        conn = mysql.connector.connect(host= self.host, username= self.username,password= self.password, database= self.database)
        my_cursor= conn.cursor()
        my_cursor.execute(query)
        result = my_cursor.fetchall()
        my_cursor.close()
        conn.close()
        return result

    def _get_primary_key(self, table_name):
        query = f"SHOW KEYS FROM {table_name} WHERE Key_name = 'PRIMARY'"
        result = self._execute_query(query)
        primary_key_columns = [row[4] for row in result]
        return primary_key_columns

    def _get_unique_keys(self, table_name):
        query = f"SHOW KEYS FROM {table_name} WHERE Non_unique = 0 AND Key_name != 'PRIMARY'"
        result = self._execute_query(query)
        unique_keys = {row[4] for row in result}
        return unique_keys


    # Predicate function that connects to the database and confirms
    # whether or not a list of attributes is set up as a (super)key for a given table
    # For example, if attributes contains table_name R and attributes [x, y],
    # this function returns true if (x,y) is enforced as a key in R
    # @see Util.Attributes
    # @pre the tables and attributes in attributes must already exist
    def confirmSuperkey( self, attributes ):

        primary_key = self._get_primary_key(attributes.table_name)
        unique_keys = self._get_unique_keys(attributes.table_name)

        # Check if the attribute set is a superset of primary key or any unique key
        attribute_set = set(attributes.attributes)
        return attribute_set.issuperset(primary_key) or any(attribute_set.issuperset(key) for key in unique_keys)
    
    
    def _get_foreign_keys(self, table_name):
        
        query = f"SHOW CREATE TABLE {table_name}"
        result = self._execute_query(query)
        create_table_statement = result[0][1]

        foreign_key_columns = []

        # Find foreign key constraints in the CREATE TABLE statement
        lines = create_table_statement.splitlines()
        for i, line in enumerate(lines):
            if "FOREIGN KEY" in line:
                key_info = line.strip().split("(")
                column_names = key_info[1].split(")")[0].strip('`').split(', ')
                for column_name in column_names:
                    foreign_key_columns.append(column_name.strip('`'))

        return foreign_key_columns

    # Predicate function that connects to the database and confirms
    # whether or not `referencing_attributes` is set up as a foreign
    # key that reference `referenced_attributes`
    # For example, if referencing_attributes contains table_name R and attributes [x, y]
    # and referenced_attributes contains table_name S and attributes [a, b]
    # this function returns true if (x,y) is enforced as a foreign key that references
    # (a,b) in R
    # @see Util.Attributes
    # @pre the tables and attributes in referencing_attributes and referenced_attributes must already exist
    def confirmForeignKey( self, referencing_attributes, referenced_attributes ):
        # TODO: Implement me! 

        # Get primary key columns from referenced table 
        referenced_primary_key = self._get_primary_key(referenced_attributes.table_name)
        # et foreign key columns from referencing table
        referencing_foreign_key = self._get_foreign_keys(referencing_attributes.table_name)

        
        referencing_columns = referencing_attributes.attributes
        referenced_columns = referenced_attributes.attributes
       
        
        if len(referencing_columns) == 1: 
            if set(referencing_columns) == set(referenced_columns):
                return True

        if len(referencing_columns) > 1:
            # checking if the referencing columns and the foreign key columns are reversed
            if referencing_columns == referencing_foreign_key[::-1]:
                # checking if the referenced columns match the referenced primary key in reverse order
                if referenced_columns == referenced_primary_key[::-1]:
                    return True

            # check if the referencing columns and the foreign key columns are not reversed
            if referencing_columns == referencing_foreign_key:
                # check if the referenced columns match the referenced primary key in the original order
                if referenced_columns == referenced_primary_key:
                    return True

        return False
    
    def _checkForeignKeyExists(self, referencing_attributes, referenced_attributes):
        query = f"SHOW CREATE TABLE {referencing_attributes.table_name}"
        result = self._execute_query(query)
        create_stmt = result[0][1]

        foreign_key_line = f"FOREIGN KEY (`{', '.join(referencing_attributes.attributes)}`) " \
                           f"REFERENCES `{referenced_attributes.table_name}` (`{', '.join(referenced_attributes.attributes)}`)"

        return foreign_key_line in create_stmt

    # Predicate function that connects to the database and confirms
    # whether or not `referencing_attributes` is set up as a foreign key
    # that reference `referenced_attributes` using a specific referential integrity `policy`
    # For example, if referencing_attributes contains table_name R and attributes [x, y]
    # and referenced_attributes contains table_name S and attributes [a, b]
    # this function returns true if (x,y) the provided policy is used to manage that foreign key
    # @see Util.Attributes, Util.RefIntegrityPolicy
    # @pre The foreign key is valid
    # @pre policy must be a valid Util.RefIntegrityPolicy
    
    def confirmReferentialIntegrity( self, referencing_attributes, referenced_attributes, policy ):
        # TODO: Implement me!
        
        if not (policy.operation == "UPDATE" or policy.operation == "DELETE" or policy.operation == "INSERT"):
            raise ValueError("Invalid policy operation")

        if not (policy.policy == "CASCADE" or policy.policy == "REJECT" or policy.policy == "SET NULL" or policy.policy == "NO ACTION" or policy.policy == "RESTRICT"):  
            raise ValueError("Invalid policy")
        
        if not self._checkForeignKeyExists(referencing_attributes, referenced_attributes):
            return False

        referencing_table = referencing_attributes.table_name

        query = f"SHOW CREATE TABLE {referencing_table}"
        result = self._execute_query(query)
        create_stmt = result[0][1]


        on_update_action = "NO ACTION"
        on_delete_action = "NO ACTION"
        on_insert_Action = "NO ACTION"

        for line in create_stmt.splitlines():
            if "ON UPDATE" in line:
                on_update_action = line.split("ON UPDATE")[1].strip() 
                if policy.operation in ("DELETE", "INSERT"):
                    return False
            elif "ON DELETE" in line:
                on_delete_action = line.split("ON DELETE")[1].strip()
                if policy.operation in ("UPDATE", "INSERT"):
                    return False
            elif "ON INSERT" in line:
                on_insert_action = line.split("ON INSERT")[1].strip()
                if policy.operation in ("UPDATE", "INSERT"):
                    return False

                
        if policy.operation == "DELETE" and on_delete_action == policy.policy:
            return True
        
        elif policy.operation == "DELETE" and on_delete_action in ("RESTRICT", "NO ACTION", "REJECT") and policy.policy not in ("CASCADE", "SET NULL"):
            return True
        
        if policy.operation == "UPDATE" and on_update_action == policy.policy:
            return True
        
        elif policy.operation == "UPDATE" and on_update_action in ("RESTRICT","NO ACTION", "REJECT") and policy.policy not in ("CASCADE", "SET NULL"):
            return True 
        
        if policy.operation == "INSERT" and on_insert_action == policy.policy:
            return True
        
        elif policy.operation == "INSERT" and on_insert_action in ("RESTRICT", "NO ACTION", "REJECT") and policy.policy not in ("CASCADE", "SET NULL"):
            return True 
        
        return False
    
    
    # Predicate function that connects to the database and confirms
    # whether or not `referencing_attributes` is set up in such as way as to
    # functionally determine `referenced_attributes`
    # For example, if referencing_attributes contains table_name R and attributes [x, y]
    # and referenced_attributes contains table_name S and attributes [a, b]
    # this function returns true if (x,y) is enforced to functionally determine (a,b) in R
    # @see Util.Attributes
    # @pre the tables and attributes in referencing_attributes and referenced_attributes must already exist
    def confirmFunctionalDependency( self, referencing_attributes, referenced_attributes ):
        # TODO: Implement me!
        # Citaton: ChatGPT prompt- How to use referencing attributes and referenced attributes to check functional dependency? 
        if referencing_attributes.table_name != referenced_attributes.table_name:

            result = self._execute_query(f"SHOW KEYS FROM {referencing_attributes.table_name} WHERE Key_name = 'PRIMARY'")
            primary_keys = [row[4] for row in result]

            if all(attr in primary_keys for attr in referencing_attributes.attributes):
               
                query_table = f"SHOW CREATE TABLE {referencing_attributes.table_name}"
                result = self._execute_query(query_table)
                create_statement = result[0][1]
                
                if f"REFERENCES `{referenced_attributes.table_name}`" in create_statement:
                    return True

            return False
        
        else:
            
            query = f"SHOW KEYS FROM {referencing_attributes.table_name} WHERE Key_name = 'PRIMARY'"
            result = self._execute_query(query)
            primary_keys = [row[4] for row in result]

            if not all(attr in primary_keys for attr in referencing_attributes.attributes):
                return False
            
            return True
     
