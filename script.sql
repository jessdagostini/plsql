--DROP TABLE curso_disciplinas;
--DROP TABLE matricula_disciplinas;
--DROP TABLE curso_professores;
--DROP TABLE professor_disciplinas;
--DROP TABLE matriculas;
--DROP TABLE alunos;
--DROP TABLE professores;
--DROP TABLE disciplinas;
--DROP TABLE cursos;
--DROP TABLE departamentos;

--DROP SEQUENCE cursos_id_seq;
--DROP SEQUENCE departamentos_id_seq;
--DROP SEQUENCE professores_id_seq;
--DROP SEQUENCE matriculas_id_seq;
--DROP SEQUENCE alunos_id_seq;
--DROP SEQUENCE disciplinas_id_seq;

CREATE TABLE departamentos
(
    id INTEGER,
    nome VARCHAR2(100),
    status SMALLINT DEFAULT 1,
    CONSTRAINT departamentos_pkey PRIMARY KEY (id) USING INDEX TABLESPACE USERS
) TABLESPACE USERS;

CREATE TABLE cursos
(
    id INTEGER NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    departamento_id INTEGER NOT NULL,
    status SMALLINT DEFAULT 1,
    CONSTRAINT cursos_pkey PRIMARY KEY (id) USING INDEX TABLESPACE USERS,
    CONSTRAINT cursos_departamento_fkey FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
)TABLESPACE USERS;

CREATE TABLE professores
(
    id INTEGER NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    departamento_id INTEGER NOT NULL,
    CONSTRAINT professores_pkey PRIMARY KEY (id) USING INDEX TABLESPACE USERS,
    CONSTRAINT professores_departamento_fkey FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
)TABLESPACE USERS;

CREATE TABLE disciplinas
(
    id INTEGER NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    carga_horaria INTEGER, -- horario em minutos, sistema faria a conversao pra horas (no caso de horas "quebradas")
    creditos INTEGER,
    status SMALLINT DEFAULT 1,
    CONSTRAINT disciplinas_pkey PRIMARY KEY (id) USING INDEX TABLESPACE USERS
)TABLESPACE USERS;

CREATE TABLE alunos
(
    id INTEGER NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    RG VARCHAR2(12),
    CPF VARCHAR2(15),
    nascimento DATE,
    endereco VARCHAR2(55),
    sexo VARCHAR2(1),
    email VARCHAR2(55),
    celular VARCHAR(12),
    filiacao VARCHAR2(55),
    senha VARCHAR2(255),
    status SMALLINT DEFAULT 1,
    CONSTRAINT alunos_pkey PRIMARY KEY (id) USING INDEX TABLESPACE USERS
)TABLESPACE USERS;

CREATE TABLE matriculas
(
    id INTEGER NOT NULL,
    aluno_id INTEGER NOT NULL,
    curso_id INTEGER NOT NULL,
    data_matricula DATE,
    semestre INTEGER,
    status SMALLINT DEFAULT 1,
    CONSTRAINT matriculas_pkey PRIMARY KEY (id) USING INDEX TABLESPACE USERS,
    CONSTRAINT matriculas_aluno_fkey FOREIGN KEY (aluno_id) REFERENCES alunos(id),
    CONSTRAINT matriculas_curso_fkey FOREIGN KEY (curso_id) REFERENCES cursos(id)
)TABLESPACE USERS;

CREATE TABLE curso_professores
(
    professor_id INTEGER NOT NULL,
    curso_id INTEGER NOT NULL,
    CONSTRAINT curso_professores_pkey PRIMARY KEY (professor_id, curso_id) USING INDEX TABLESPACE USERS,
    CONSTRAINT curso_profs_professor_fkey FOREIGN KEY (professor_id) REFERENCES professores(id) ON DELETE CASCADE,
    CONSTRAINT curso_profs_curso_fkey FOREIGN KEY (curso_id) REFERENCES cursos(id)
)TABLESPACE USERS;

CREATE TABLE curso_disciplinas
(
    disciplina_id INTEGER NOT NULL,
    curso_id INTEGER NOT NULL,
    CONSTRAINT curso_disc_pkey PRIMARY KEY (disciplina_id, curso_id) USING INDEX TABLESPACE USERS,
    CONSTRAINT curso_disc_disciplina_fkey FOREIGN KEY (disciplina_id) REFERENCES disciplinas(id),
    CONSTRAINT curso_disc_curso_fkey FOREIGN KEY (curso_id) REFERENCES cursos(id)
)TABLESPACE USERS;

CREATE TABLE matricula_disciplinas
(
    disciplina_id INTEGER NOT NULL,
    matricula_id INTEGER NOT NULL,
    CONSTRAINT matricula_disc_pkey PRIMARY KEY (disciplina_id, matricula_id) USING INDEX TABLESPACE USERS,
    CONSTRAINT matricula_disc_disciplina_fkey FOREIGN KEY (disciplina_id) REFERENCES disciplinas(id),
    CONSTRAINT matricula_disc_matricula_fkey FOREIGN KEY (matricula_id) REFERENCES matriculas(id)
)TABLESPACE USERS;

CREATE TABLE professor_disciplinas
(
    disciplina_id INTEGER NOT NULL,
    professor_id INTEGER NOT NULL,
    CONSTRAINT professor_disc_pkey PRIMARY KEY (disciplina_id, professor_id) USING INDEX TABLESPACE USERS,
    CONSTRAINT professor_disc_disciplina_fkey FOREIGN KEY (disciplina_id) REFERENCES disciplinas(id),
    CONSTRAINT professor_disc_professor_fkey FOREIGN KEY (professor_id) REFERENCES professores(id) ON DELETE CASCADE
)TABLESPACE USERS;

CREATE SEQUENCE cursos_id_seq
START WITH 1
MINVALUE 1
INCREMENT BY 1;

CREATE SEQUENCE departamentos_id_seq
START WITH 1
MINVALUE 1
INCREMENT BY 1;

CREATE SEQUENCE professores_id_seq
START WITH 1
MINVALUE 1
INCREMENT BY 1;

CREATE SEQUENCE matriculas_id_seq
START WITH 1
MINVALUE 1
INCREMENT BY 1;

CREATE SEQUENCE disciplinas_id_seq
START WITH 1
MINVALUE 1
INCREMENT BY 1;

CREATE SEQUENCE alunos_id_seq
START WITH 1
MINVALUE 1
INCREMENT BY 1;

CREATE INDEX cursos_dept_index ON cursos(departamento_id);
CREATE INDEX professores_dept_index ON professores(departamento_id);
CREATE INDEX matriculas_aluno_index ON matriculas(aluno_id);
CREATE INDEX matriculas_curso_index ON matriculas(curso_id);

CREATE OR REPLACE TRIGGER dept_id_trig
BEFORE INSERT ON departamentos 
FOR EACH ROW
BEGIN
    SELECT departamentos_id_seq.NEXTVAL
    INTO   :new.id
    FROM   dual;
    
END;
/

CREATE OR REPLACE TRIGGER cursos_id_trig 
BEFORE INSERT ON cursos 
FOR EACH ROW
BEGIN
    SELECT cursos_id_seq.NEXTVAL
    INTO   :new.id
    FROM   dual;
    
END;
/

CREATE OR REPLACE TRIGGER alunos_id_trig
BEFORE INSERT ON alunos 
FOR EACH ROW
BEGIN
    SELECT alunos_id_seq.NEXTVAL
    INTO   :new.id
    FROM   dual;
    
END;
/

CREATE OR REPLACE TRIGGER professores_id_trig
BEFORE INSERT ON professores 
FOR EACH ROW
BEGIN
    SELECT professores_id_seq.NEXTVAL
    INTO   :new.id
    FROM   dual;
    
END;
/

CREATE OR REPLACE TRIGGER matriculas_id_trig
BEFORE INSERT ON matriculas 
FOR EACH ROW
BEGIN
    SELECT matriculas_id_seq.NEXTVAL
    INTO   :new.id
    FROM   dual;
   
END;
/

CREATE OR REPLACE TRIGGER disciplinas_id_trig
BEFORE INSERT ON disciplinas 
FOR EACH ROW
BEGIN
    SELECT disciplinas_id_seq.NEXTVAL
    INTO   :new.id
    FROM   dual;
    
END;
/

INSERT INTO departamentos (nome) VALUES ('Ciências Exatas e da Terra');
INSERT INTO departamentos (nome) VALUES ('Engenharias');
INSERT INTO departamentos (nome) VALUES ('Ciências Biológicas');
INSERT INTO departamentos (nome) VALUES ('Ciências da Saúde');
INSERT INTO departamentos (nome) VALUES ('Ciências Sociais');

INSERT INTO cursos(nome, departamento_id) VALUES ( 'Ciência da Computação', 1);
INSERT INTO cursos(nome, departamento_id) VALUES ( 'Biologia Licenciatura', 3);
INSERT INTO cursos(nome, departamento_id) VALUES ( 'Direito', 5);
INSERT INTO cursos(nome, departamento_id) VALUES ( 'Fisioterapia', 4);
INSERT INTO cursos(nome, departamento_id) VALUES ( 'Engenharia Elétrica', 2);

INSERT INTO professores(nome, departamento_id) VALUES ( 'Malomar Seminotti', 1);
INSERT INTO professores(nome, departamento_id) VALUES ( 'Fabio Zanin', 1);
INSERT INTO professores(nome, departamento_id) VALUES ( 'Fulaninho de Tal', 2);
INSERT INTO professores(nome, departamento_id) VALUES ( 'Enzo Duarte', 3);
INSERT INTO professores(nome, departamento_id) VALUES ( 'Maria da Conceição', 3);
INSERT INTO professores(nome, departamento_id) VALUES ( 'Juliana Kaotnfd', 4);

INSERT INTO disciplinas(nome, carga_horaria, creditos) VALUES ( 'Algoritmos e Estrutura de Dados 1', 240, 4);
INSERT INTO disciplinas(nome, carga_horaria, creditos) VALUES ( 'Sociologia', 240, 4);
INSERT INTO disciplinas(nome, carga_horaria, creditos) VALUES ( 'Anatomia 1', 240, 4);
INSERT INTO disciplinas(nome, carga_horaria, creditos) VALUES ( 'Introdução a Informática', 120, 2);
INSERT INTO disciplinas(nome, carga_horaria, creditos) VALUES ( 'Empreendedorismo', 240, 4);
INSERT INTO disciplinas(nome, carga_horaria, creditos) VALUES ( 'Física 1', 360, 6);
INSERT INTO disciplinas(nome, carga_horaria, creditos) VALUES ( 'Metodologia da Pesquisa', 120, 2);

INSERT INTO alunos(nome, RG, CPF, nascimento, endereco, sexo, email, celular, filiacao, senha) VALUES ( 'Jessica Dagostini', '1234567890', '09876543210', TO_DATE('1997-04-04', 'yyyy-mm-dd'), 'Rua Monteiro Lobato, 389', 'F', 'jessicadagostini@gmail.com', '54996192242', 'Elaine Dagostini', 'senhaaa');

INSERT INTO alunos(nome, RG, CPF, nascimento, endereco, sexo, email, celular, filiacao, senha) VALUES ( 'Enzo de Alguma Coisa', '0203010504', '45678912309',
        TO_DATE('1999-02-14', 'yyyy-mm-dd'), 'Rua Jacinto Pinto, 99', 'M', 'enzoalgumacoisa@gmail.com', '54991396242', 'Pai do Enzo', 'senhaaasadasda');

INSERT INTO alunos(nome, RG, CPF, nascimento, endereco, sexo, email, celular, filiacao, senha) VALUES ( 'Valentina de Alguma Coisa', '7879747576', '02314569781',
        TO_DATE('2000-01-14', 'yyyy-mm-dd'), 'Rua Jacinto Pinto, 99', 'F', 'valentinaalgumacoisa@gmail.com', '54991396243', 'Pai do Enzo', 'dasdasenhaaasadasda');

INSERT INTO alunos(nome, RG, CPF, nascimento, endereco, sexo, email, celular, filiacao, senha) VALUES ('Amadeu Fernandes', '1543425781', '78455146812',
        TO_DATE('1997-02-17', 'yyyy-mm-dd'), 'Germano Dalastra, 157', 'M', 'amadeufernandes@gmail.com', '55998781415', 'Pai do Amadeu', 'dasdsdyhsdasda');

INSERT INTO alunos(nome, RG, CPF, nascimento, endereco, sexo, email, celular, filiacao, senha) VALUES ('Anita Garibaldi', '1231247914', '41479347821',
        TO_DATE('1997-04-29', 'yyyy-mm-dd'), 'Sao Desiderio Caminha, 12', 'F', 'anita21@gmail.com', '49992296753', 'Antonia mae da anita', 'dasdassdasasadasda');

INSERT INTO alunos(nome, RG, CPF, nascimento, endereco, sexo, email, celular, filiacao, senha) VALUES ('Ana Rita Theo', '7894562791', '41479347821',
        TO_DATE('1997-04-29', 'yyyy-mm-dd'), 'Sao Desiderio Caminha, 12', 'F', 'anita21@gmail.com', '49992296753', 'Antonia mae da Ana Rita', 'dasdadasda');

INSERT INTO alunos(nome, RG, CPF, nascimento, endereco, sexo, email, celular, filiacao, senha) VALUES ('Bernardo da Silva', '04258791457', '7114583079',
        TO_DATE('1997-04-29', 'yyyy-mm-dd'), 'Sao Pedro, 12', 'F', 'bernardo21@gmail.com', '49992296753', 'Cecília da Silva', 'dasdasenhaaasadasda');

INSERT INTO alunos(nome, RG, CPF, nascimento, endereco, sexo, email, celular, filiacao, senha) VALUES ('Cassiane Nodari', '7114426071', '04258702005',
        TO_DATE('1997-01-09', 'yyyy-mm-dd'), 'Rua Maranhao, 279', 'F', 'cassi.nodari@hotmail.com', '54992082255', 'Elaine Avozani Nodari', 'dasdasenhaaasadasda');

INSERT INTO alunos(nome, RG, CPF, nascimento, endereco, sexo, email, celular, filiacao, senha) VALUES ('Pedro Vento', '7148579026', '05879801406',
        TO_DATE('1997-04-29', 'yyyy-mm-dd'), 'Santa Rita do Cacequi, 231', 'M', 'pedro21@gmail.com', '49992296753', 'Antonia Vento', 'dasdasenhaaasadasda');

INSERT INTO alunos(nome, RG, CPF, nascimento, endereco, sexo, email, celular, filiacao, senha) VALUES ( 'Samanta Vieira', '8496257034', '46259703609',
        TO_DATE('1989-09-29', 'yyyy-mm-dd'), 'Rua Almeira Prado, 1258', 'F', 'samanta01@gmail.com', '42999179410', 'Armando Vieira', 'dasdasenhaaasadasda');

INSERT INTO alunos(nome, RG, CPF, nascimento, endereco, sexo, email, celular, filiacao, senha) VALUES ('Leonardo Gallardo', '4895782136', '04587123601',
        TO_DATE('1997-11-04', 'yyyy-mm-dd'), 'Sao Jose da Esquerda, 26', 'M', 'leonardo@gmail.com', '67999140291', 'Pai do Leonardo', 'dasdasenhaaasadasda');

INSERT INTO alunos(nome, RG, CPF, nascimento, endereco, sexo, email, celular, filiacao, senha) VALUES ('Luana Silveira', '1234567897', '36958412308',
        TO_DATE('1997-04-29', 'yyyy-mm-dd'), 'Rua Padre Cacique, 09', 'F', 'luana_silveira@hotmail.com', '42991396865', 'Silva e Roberto Silveira', 'dasdasenhaaasadasda');

INSERT INTO alunos(nome, RG, CPF, nascimento, endereco, sexo, email, celular, filiacao, senha) VALUES ('Giuseppe Fiorentin', '1231247914', '41479347821',
        TO_DATE('1997-04-29', 'yyyy-mm-dd'), 'Sao Pedro Fagundes, 7', 'M', 'fiorentin@gmail.com', '65989714578', 'Antony Fiorentin', 'dasdasenhaaasadasda');

INSERT INTO matriculas(aluno_id, curso_id, data_matricula, semestre) VALUES (1, 1,  TO_DATE('2015-02-23', 'yyyy-mm-dd'), 8);

INSERT INTO matriculas(aluno_id, curso_id, data_matricula, semestre) VALUES (2, 5,  TO_DATE('2014-02-22', 'yyyy-mm-dd'), 9);

INSERT INTO matriculas(aluno_id, curso_id, data_matricula, semestre) VALUES (3, 2,  TO_DATE('2015-03-01', 'yyyy-mm-dd'), 7);

INSERT INTO matriculas(aluno_id, curso_id, data_matricula, semestre) VALUES (4, 2,  TO_DATE('2015-07-18', 'yyyy-mm-dd'), 6);

INSERT INTO matriculas(aluno_id, curso_id, data_matricula, semestre) VALUES (5, 4,  TO_DATE('2016-02-08', 'yyyy-mm-dd'), 7);

INSERT INTO matriculas(aluno_id, curso_id, data_matricula, semestre) VALUES (6, 3,  TO_DATE('2017-02-28', 'yyyy-mm-dd'), 3);

INSERT INTO matriculas(aluno_id, curso_id, data_matricula, semestre) VALUES (7, 4,  TO_DATE('2014-08-08', 'yyyy-mm-dd'), 9);

INSERT INTO curso_professores(professor_id, curso_id) VALUES (1, 1);
INSERT INTO curso_professores(professor_id, curso_id) VALUES (2, 1);
INSERT INTO curso_professores(professor_id, curso_id) VALUES (3, 3);
INSERT INTO curso_professores(professor_id, curso_id) VALUES (4, 5);
INSERT INTO curso_professores(professor_id, curso_id) VALUES (5, 4);
INSERT INTO curso_professores(professor_id, curso_id) VALUES (6, 2);

INSERT INTO professor_disciplinas(disciplina_id, professor_id) VALUES (1, 1);
INSERT INTO professor_disciplinas(disciplina_id, professor_id) VALUES (2, 5);
INSERT INTO professor_disciplinas(disciplina_id, professor_id) VALUES (3, 3);
INSERT INTO professor_disciplinas(disciplina_id, professor_id) VALUES (4, 2);
INSERT INTO professor_disciplinas(disciplina_id, professor_id) VALUES (5, 6);
INSERT INTO professor_disciplinas(disciplina_id, professor_id) VALUES (6, 4);
INSERT INTO professor_disciplinas(disciplina_id, professor_id) VALUES (7, 1);

INSERT INTO curso_disciplinas(disciplina_id, curso_id) VALUES (1, 1);
INSERT INTO curso_disciplinas(disciplina_id, curso_id) VALUES (3, 2);
INSERT INTO curso_disciplinas(disciplina_id, curso_id) VALUES (5, 3);
INSERT INTO curso_disciplinas(disciplina_id, curso_id) VALUES (7, 4);
INSERT INTO curso_disciplinas(disciplina_id, curso_id) VALUES (4, 1);
INSERT INTO curso_disciplinas(disciplina_id, curso_id) VALUES (6, 1);
INSERT INTO curso_disciplinas(disciplina_id, curso_id) VALUES (2, 5);

INSERT INTO matricula_disciplinas(disciplina_id, matricula_id) VALUES (1, 2);
INSERT INTO matricula_disciplinas(disciplina_id, matricula_id) VALUES (2, 5);
INSERT INTO matricula_disciplinas(disciplina_id, matricula_id) VALUES (3, 3);
INSERT INTO matricula_disciplinas(disciplina_id, matricula_id) VALUES (4, 1);
INSERT INTO matricula_disciplinas(disciplina_id, matricula_id) VALUES (5, 4);
INSERT INTO matricula_disciplinas(disciplina_id, matricula_id) VALUES (6, 6);
INSERT INTO matricula_disciplinas(disciplina_id, matricula_id) VALUES (7, 1);
COMMIT;

-- Exibie o departamento em que cada curso pertence e também as disciplinas, carga horária e créditos que pertencem à cada curso. 
SET SERVEROUTPUT ON;
DECLARE
CURSOR cursordept IS (SELECT id, nome FROM departamentos);
vid departamentos.id%type;
vnome departamentos.nome%type;

BEGIN
	OPEN cursordept;
	LOOP
    	FETCH cursordept INTO vid, vnome;
        IF cursordept%found THEN
            DBMS_OUTPUT.PUT_LINE('Departamento: ' || vnome);
            FOR c IN (SELECT id, nome FROM cursos WHERE departamento_id = vid) LOOP
                DBMS_OUTPUT.PUT_LINE('	Curso: ' || c.nome);
                FOR d IN (SELECT d.id, d.nome, d.carga_horaria, d.creditos FROM disciplinas d INNER JOIN curso_disciplinas cd ON cd.disciplina_id = d.id WHERE cd.curso_id = c.id) LOOP
                    DBMS_OUTPUT.PUT_LINE('    	Disciplina: ' || d.nome || ' Carga horária: ' || d.carga_horaria || ' Créditos: ' || d.creditos);
                END LOOP;
            END LOOP;
        ELSE
            DBMS_OUTPUT.PUT_LINE('----------------');
            EXIT;
        END IF;
    END LOOP;
	CLOSE cursordept;
END;
/

-- Exibe todos os professores e quais as disciplinas de cada curso ele administra. 
DECLARE
CURSOR cursorteac IS (SELECT id, nome FROM professores);
vid professores.id%type;
vnome professores.nome%type;

BEGIN
	OPEN cursorteac;
	LOOP
    	FETCH cursorteac INTO vid, vnome;
        IF cursorteac%found THEN
            DBMS_OUTPUT.PUT_LINE('Professor: ' || vnome || ' ID: ' || vid);
            FOR d IN (SELECT d.id, d.nome, d.carga_horaria, d.creditos FROM disciplinas d INNER JOIN professor_disciplinas pd ON pd.disciplina_id = d.id WHERE pd.professor_id = vid) LOOP
                DBMS_OUTPUT.PUT_LINE('    	Disciplina: ' || d.nome || ' Carga horária: ' || d.carga_horaria || ' Créditos: ' || d.creditos);
            END LOOP;
        ELSE
            DBMS_OUTPUT.PUT_LINE('----------------');
            EXIT;
        END IF;
	END LOOP;
	CLOSE cursorteac;

    BEGIN
        DBMS_OUTPUT.PUT_LINE('Removendo professor Malomar Seminotti (para delete cascade)');
        DBMS_OUTPUT.PUT_LINE('--------------------------------');
        DELETE FROM professores WHERE nome = 'Malomar Seminotti';        
    EXCEPTION
        WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Professor nao encontrado!');
        ROLLBACK;
    END;

    BEGIN
        FOR p IN (SELECT id, nome FROM professores) LOOP
        	DBMS_OUTPUT.PUT_LINE('Professor: ' || p.nome);
        	FOR d IN (SELECT d.id, d.nome, d.carga_horaria, d.creditos FROM disciplinas d INNER JOIN professor_disciplinas pd ON pd.disciplina_id = d.id WHERE pd.professor_id = p.id) LOOP
            	DBMS_OUTPUT.PUT_LINE('    	Disciplina: ' || d.nome || ' Carga horária: ' || d.carga_horaria || ' Créditos: ' || d.creditos);
        	END LOOP;
        END LOOP;
    END;
END;
/

-- Exibe alunos e suas matrículas
SET SERVEROUTPUT ON;
DECLARE
CURSOR cursormat IS (SELECT id, aluno_id, curso_id, semestre FROM matriculas);
vid matriculas.id%type;
valuno_id matriculas.aluno_id%type;
vcurso_id matriculas.curso_id%type;
vsemestre matriculas.semestre%type;

BEGIN
	OPEN cursormat;
	LOOP
    	FETCH cursormat INTO vid, valuno_id, vcurso_id, vsemestre;
        IF cursormat%found THEN
            FOR a IN (SELECT id, nome, DECODE(sexo, 'F', 'Feminino', 'M', 'Masculino') as sexo, email FROM alunos WHERE id = valuno_id) LOOP
                DBMS_OUTPUT.PUT_LINE('	Matricula [' || vid || '] - Nome: ' || a.nome || ' | Sexo: ' || a.sexo || ' | Email: ' || a.email);
                DBMS_OUTPUT.PUT_LINE('Disciplina(s):');
                FOR d IN (SELECT d.id, d.nome, d.carga_horaria, d.creditos FROM disciplinas d INNER JOIN matricula_disciplinas md ON md.disciplina_id = d.id WHERE md.matricula_id = vid) LOOP
                    DBMS_OUTPUT.PUT_LINE('    ' || d.nome || ' | Carga horária: ' || d.carga_horaria || ' | Créditos: ' || d.creditos);
                END LOOP;
            END LOOP;
        ELSE
            DBMS_OUTPUT.PUT_LINE('----------------');
            EXIT;
        END IF;
	END LOOP;
	CLOSE cursormat;
END;
/