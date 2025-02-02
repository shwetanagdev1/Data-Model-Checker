DROP DATABASE IF EXISTS `assignment2`;
CREATE DATABASE `assignment2`;
USE `assignment2`;

-- Tables for confirmSuperkey()

CREATE TABLE R1( `e` INT
	           , `f` INT AUTO_INCREMENT
	           , `g` INT
	           , `h` INT
	           , PRIMARY KEY(`f`)
	           );

CREATE TABLE R2( `e` INT
	           , `f` INT AUTO_INCREMENT
	           , `g` INT
	           , `h` INT
	           , PRIMARY KEY(`f`)
	           );

CREATE TABLE R3( `e` INT
	           , `f` INT AUTO_INCREMENT
	           , `g` INT DEFAULT 3
	           , `h` INT
	           , PRIMARY KEY(`f`, `g`)
	           );

CREATE TABLE R4( `e` INT
	           , `f` INT AUTO_INCREMENT
	           , `g` INT UNIQUE DEFAULT 4
	           , `h` INT
	           , PRIMARY KEY(`f`)
	           );

CREATE TABLE R5( `e` INT
	           , `f` INT AUTO_INCREMENT
	           , `g` INT UNIQUE DEFAULT 4
	           , `h` INT
	           , PRIMARY KEY(`f`, `g`)
	           );

CREATE TABLE R1N( `a` INT AUTO_INCREMENT
	            , `b` INT
	            , `c` INT
	            , `d` INT
	            , PRIMARY KEY(`a`)
	            );

CREATE TABLE R2N( `a` INT AUTO_INCREMENT
	            , `b` INT
	            , `c` INT
	            , `d` INT
	            , PRIMARY KEY(`a`)
	            );

CREATE TABLE R3N( `e` INT
	            , `f` INT AUTO_INCREMENT
	            , `g` INT DEFAULT 3
	            , `h` INT
	            , PRIMARY KEY(`f`, `g`)
	            );

CREATE TABLE R4N( `e` INT AUTO_INCREMENT
	            , `f` INT UNIQUE DEFAULT 4
	            , `g` INT
	            , `h` INT
	            , PRIMARY KEY(`e`)
	            );
CREATE TABLE R5N( `e` INT
	           , `f` INT AUTO_INCREMENT
	           , `g` INT UNIQUE DEFAULT 4
	           , `h` INT
	           , PRIMARY KEY(`f`, `e`)
	           );

-- Tables for confirmForeignKey()

CREATE TABLE R6( `x` INT AUTO_INCREMENT
	           , `y` INT
	           , `z` INT
	           , PRIMARY KEY(`x`)
	           );
CREATE TABLE S6( `v` INT AUTO_INCREMENT
	           , `w` INT
	           , `x` INT
	           , PRIMARY KEY(`v`)
	           , FOREIGN KEY(`x`)
	               REFERENCES `R6`(`x`)
	           );

CREATE TABLE R7( `x` INT AUTO_INCREMENT
	           , `y` INT DEFAULT 7
	           , `z` INT
	           , PRIMARY KEY(`x`, `y`)
	           );
CREATE TABLE S7( `a` INT AUTO_INCREMENT
	           , `b` INT
	           , `c` INT
	           , PRIMARY KEY(`a`, `b`, `c`)
	           , FOREIGN KEY(`b`, `c`)
	               REFERENCES `R7`(`x`, `y`)
	           );

CREATE TABLE R8( `x` INT AUTO_INCREMENT
	           , `y` INT DEFAULT 8
	           , `z` INT
	           , PRIMARY KEY(`x`, `y`)
	           );
CREATE TABLE S8( `a` INT AUTO_INCREMENT
	           , `b` INT
	           , `c` INT
	           , PRIMARY KEY(`a`)
	           , FOREIGN KEY(`b`, `c`)
	               REFERENCES `R8`(`x`, `y`)
	           );

CREATE TABLE R9( `x` INT AUTO_INCREMENT
	           , `y` INT DEFAULT 9
	           , `z` INT
	           , PRIMARY KEY(`x`, `y`)
	           );
CREATE TABLE S9( `a` INT AUTO_INCREMENT
	           , `b` INT
	           , `c` INT
	           , PRIMARY KEY(`a`)
	           , FOREIGN KEY(`b`, `c`)
	               REFERENCES `R9`(`x`, `y`)
	           );
CREATE TABLE R10( `x` INT AUTO_INCREMENT
	           , `y` INT DEFAULT 9
	           , `z` INT
	           , PRIMARY KEY(`x`, `y`)
	           );
CREATE TABLE S10( `a` INT AUTO_INCREMENT
	           , `b` INT
	           , `c` INT
			   , `d` INT 
			   ,`e` INT
	           , PRIMARY KEY(`a`, `b`)
	           , FOREIGN KEY(`b`, `c`)
	               REFERENCES `R9`(`x`, `y`)
	           );

CREATE TABLE R6N( `x` INT AUTO_INCREMENT
	            , `y` INT
	            , `z` INT
	            , PRIMARY KEY(`x`)
	            );
CREATE TABLE S6N( `v` INT AUTO_INCREMENT
	            , `w` INT
	            , `x` INT
	            , PRIMARY KEY(`v`)
	            , FOREIGN KEY(`x`)
	                REFERENCES `R6N`(`x`)
	            );

CREATE TABLE R7N( `x` INT AUTO_INCREMENT
	            , `y` INT DEFAULT 7
	            , `z` INT
	            , PRIMARY KEY(`x`, `y`)
	            );
CREATE TABLE S7N( `a` INT AUTO_INCREMENT
	            , `b` INT
	            , `c` INT
	            , PRIMARY KEY(`a`, `b`, `c`)
	            , FOREIGN KEY(`b`, `c`)
	                REFERENCES `R7N`(`x`, `y`)
	            );

CREATE TABLE R8N( `x` INT AUTO_INCREMENT
	            , `y` INT DEFAULT 8
	            , `z` INT
	            , PRIMARY KEY(`x`, `y`)
	            );
CREATE TABLE S8N( `a` INT AUTO_INCREMENT
	            , `b` INT
	            , `c` INT
	            , PRIMARY KEY(`a`)
	            , FOREIGN KEY(`b`, `c`)
	                REFERENCES `R8N`(`x`, `y`)
	            );

CREATE TABLE R9N( `x` INT AUTO_INCREMENT
	            , `y` INT DEFAULT 9
	            , `z` INT
	            , PRIMARY KEY(`x`, `y`)
	            );
CREATE TABLE S9N( `a` INT AUTO_INCREMENT
	            , `b` INT
	            , `c` INT
	            , PRIMARY KEY(`a`)
	            , FOREIGN KEY(`b`, `c`)
	                REFERENCES `R9N`(`x`, `y`)
	            );

CREATE TABLE R10N( `x` INT AUTO_INCREMENT
	           , `y` INT DEFAULT 9
	           , `z` INT
	           , PRIMARY KEY(`x`, `y`)
	           );
CREATE TABLE S10N( `a` INT AUTO_INCREMENT
	           , `b` INT
	           , `c` INT
			   , `d` INT 
			   ,`e` INT
	           , PRIMARY KEY(`a`, `b`)
	           , FOREIGN KEY(`c`, `d`)
	               REFERENCES `R9`(`x`, `y`)
	           );


-- Tables for confirmReferentialIntegrity()

CREATE TABLE R11( `x` INT AUTO_INCREMENT
	            , `y` INT
	            , `z` INT
	            , PRIMARY KEY(`x`)
	            );
CREATE TABLE S11( `a` INT AUTO_INCREMENT
	            , `b` INT
	            , `c` INT
	            , PRIMARY KEY(`a`)
	            , FOREIGN KEY(`c`)
	                REFERENCES `R11`(`x`)
	                ON DELETE RESTRICT
	            );

CREATE TABLE R12( `x` INT AUTO_INCREMENT
	            , `y` INT
	            , `z` INT
	            , PRIMARY KEY(`x`)
	            );

CREATE TABLE S12( `a` INT AUTO_INCREMENT
	            , `b` INT
	            , `c` INT
	            , PRIMARY KEY(`a`)
	            , FOREIGN KEY(`c`)
	                REFERENCES `R12`(`x`)
	                ON DELETE CASCADE
	            );		

CREATE TABLE R13( `x` INT AUTO_INCREMENT
	            , `y` INT
	            , `z` INT
	            , PRIMARY KEY(`x`)
	            );
CREATE TABLE S13( `a` INT AUTO_INCREMENT
	            , `b` INT
	            , `c` INT
	            , PRIMARY KEY(`a`)
	            , FOREIGN KEY(`c`)
	                REFERENCES `R13`(`x`)
	                ON UPDATE RESTRICT
	            );

CREATE TABLE R14( `x` INT AUTO_INCREMENT
	            , `y` INT
	            , `z` INT
	            , PRIMARY KEY(`x`)
	            );
CREATE TABLE S14( `a` INT AUTO_INCREMENT
	            , `b` INT
	            , `c` INT
	            , PRIMARY KEY(`a`)
	            , FOREIGN KEY(`c`)
	                REFERENCES `R14`(`x`)
	                ON UPDATE CASCADE
	            );

CREATE TABLE R15( `x` INT AUTO_INCREMENT
	            , `y` INT
	            , `z` INT
	            , PRIMARY KEY(`x`)
	            );
CREATE TABLE S15( `a` INT AUTO_INCREMENT
	            , `b` INT
	            , `c` INT
	            , PRIMARY KEY(`a`)
	            , FOREIGN KEY(`c`)
	                REFERENCES `R15`(`x`)
	                ON DELETE SET NULL
	            );

CREATE TABLE R11N( `x` INT AUTO_INCREMENT
	             , `y` INT
	             , `z` INT
	             , PRIMARY KEY(`x`)
	             );
CREATE TABLE S11N( `a` INT AUTO_INCREMENT
	             , `b` INT
	             , `c` INT
	             , PRIMARY KEY(`a`)
	             , FOREIGN KEY(`c`)
	                REFERENCES `R11N`(`x`)
					
	             );

CREATE TABLE R12N( `x` INT AUTO_INCREMENT
	             , `y` INT
	             , `z` INT
	             , PRIMARY KEY(`x`)
	             );
CREATE TABLE S12N( `a` INT AUTO_INCREMENT
	             , `b` INT
	             , `c` INT
	             , PRIMARY KEY(`a`)
	             , FOREIGN KEY(`c`)
	                 REFERENCES `R12N`(`x`)
					 ON UPDATE CASCADE
	             );

CREATE TABLE R13N( `x` INT AUTO_INCREMENT
	             , `y` INT
	             , `z` INT
	             , PRIMARY KEY(`x`)
	             );
CREATE TABLE S13N( `a` INT AUTO_INCREMENT
	             , `b` INT
	             , `c` INT
	             , PRIMARY KEY(`a`)
	             , FOREIGN KEY(`c`)
	                 REFERENCES `R13N`(`x`)
					ON DELETE SET NULL
	             );

CREATE TABLE R14N( `x` INT AUTO_INCREMENT
	             , `y` INT
	             , `z` INT
	             , PRIMARY KEY(`x`)
	             );
CREATE TABLE S14N( `a` INT AUTO_INCREMENT
	             , `b` INT
	             , `c` INT
	             , PRIMARY KEY(`a`)
	             , FOREIGN KEY(`c`)
	                 REFERENCES `R14N`(`x`)
					ON DELETE SET NULL
	             );

CREATE TABLE R15N( `x` INT AUTO_INCREMENT
	             , `y` INT
	             , `z` INT
	             , PRIMARY KEY(`x`)
	             );
CREATE TABLE S15N( `a` INT AUTO_INCREMENT
	             , `b` INT
	             , `c` INT
	             , PRIMARY KEY(`a`)
	             , FOREIGN KEY(`c`)
	                 REFERENCES `R15N`(`x`)
					 ON UPDATE CASCADE
	             );

-- Tables for confirmFunctionalDependency()

CREATE TABLE R16( `x` INT AUTO_INCREMENT
	            , `y` INT
	            , `z` INT
	            , PRIMARY KEY(`x`)
	            );

CREATE TABLE R17( `x` INT AUTO_INCREMENT
	            , `y` INT
	            , `z` INT
	            , PRIMARY KEY(`x`, `y`)
	            );
CREATE TABLE R18( `x` INT AUTO_INCREMENT
	            , `y` INT
	            , `z` INT
	            , PRIMARY KEY(`x`)
	            );
CREATE TABLE S18( `a` INT AUTO_INCREMENT
	            , `b` INT
	            , `c` INT
	            , PRIMARY KEY(`a`)
	            , FOREIGN KEY(`c`)
	                REFERENCES `R18`(`x`)
	            );

CREATE TABLE R16N( `x` INT
	             , `y` INT
	             , `z` INT AUTO_INCREMENT
	             , PRIMARY KEY(`z`)
	             );

CREATE TABLE R17N( `x` INT
	             , `y` INT
	             , `z` INT AUTO_INCREMENT
	             , PRIMARY KEY(`z`, `y`)
	             );


CREATE TABLE R18N( `x` INT AUTO_INCREMENT
	             , `y` INT
	             , `z` INT
	             , PRIMARY KEY(`x`)
	             );
CREATE TABLE S18N( `a` INT AUTO_INCREMENT
	             , `b` INT
	             , `c` INT
	             , PRIMARY KEY(`a`)
	             , FOREIGN KEY(`c`)
	                 REFERENCES `R18N`(`x`)
	             );

DROP USER IF EXISTS 'student'@'localhost';
CREATE USER IF NOT EXISTS 'student'@'localhost' IDENTIFIED BY 'stud3nt';
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON `assignment2`.* TO 'student'@'localhost';
SHOW GRANTS FOR 'student'@'localhost';
