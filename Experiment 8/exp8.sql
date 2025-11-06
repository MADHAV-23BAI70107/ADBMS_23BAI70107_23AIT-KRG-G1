--hard problem 

DROP TABLE IF EXISTS students;

CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE,
    age INT,
    class INT
);

-- CORRECTED EXCEPTION HANDLING

DO $$
BEGIN
    -- Start a transaction
    BEGIN 
        -- Insert multiple students
        INSERT INTO students(name, age, class) VALUES ('Anisha',16,8);
        INSERT INTO students(name, age, class) VALUES ('Neha',17,8);
        INSERT INTO students(name, age, class) VALUES ('Mayank',19,9);

        -- If all succeed
        RAISE NOTICE 'Transaction Successfully Done';
        
        -- Commit the transaction
        COMMIT;

    EXCEPTION WHEN OTHERS THEN
        -- If any insert fails
        RAISE NOTICE 'Transaction Failed! Rolling back changes.';
        -- Rollback is automatic in case of exception
        RAISE;  -- re-raise the exception
    END;
END;
$$;

SELECT * FROM students;



-- CORRECTED VIOLATED SCENARIO
DO $$
BEGIN
    -- Start a transaction
    BEGIN 
        -- Insert multiple students
        INSERT INTO students(name, age, class) VALUES ('Anisha',16,8);
        INSERT INTO students(name, age, class) VALUES ('Mayank',19,9);
        INSERT INTO students(name, age, class) VALUES ('Anisha',17,8); -- This will cause ERROR due to duplicate name
        INSERT INTO students(name, age, class) VALUES ('Mayank',19,9);

        -- If all succeed
        RAISE NOTICE 'Transaction Successfully Done';
        
        -- Commit the transaction
        COMMIT;

    EXCEPTION WHEN OTHERS THEN
        -- If any insert fails
        RAISE NOTICE 'Transaction Failed! Rolling back changes.';
        -- Rollback is automatic in case of exception
        RAISE;  -- re-raise the exception
    END;
END;
$$;

SELECT * FROM students;
