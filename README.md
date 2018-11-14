# PL/SQL
Script PL/SQL da criação de um banco de dados relacional como trabalho final da disciplina de tópicos em PL/SQL da URI Erechim - Ano 2018

## Modelagem
Modelo Entidade-Relacional do Banco de Dados criado:
https://www.lucidchart.com/documents/view/e0849a89-69ab-41d0-8e72-5ff125431cc2/0

## Especificações
Este script contém a criação e exclusão de 10 tabelas, sendo elas:
```
curso_disciplinas
matricula_disciplinas
curso_professores
professor_disciplinas
matriculas
alunos
professores
disciplinas
cursos
departamentos
```

Criação e exclusão de sequences: 
```
cursos_id_seq
departamentos_id_seq
professores_id_seq
matriculas_id_seq
alunos_id_seq
disciplinas_id_seq
```

Criação de índices:
```
cursos_dept_index
professores_dept_index
matriculas_aluno_index
matriculas_curso_index
```

Criação de triggers nas tabelas
```
departamentos
cursos
alunos
professores
matriculas
disciplinas
```
para autoincrementação dos identificadores.

Inserção dos registros em cada uma das tabelas criadas, juntamente com primary key e foreign key.
Por fim, cursor para exibir o departamento em que cada curso pertence e também as disciplinas, carga horária e créditos que pertencem à cada curso. Professor e cada disciplina que ele administra, carga horária e quantidade de créditos da disciplina, juntamente com exception em caso de não encontrar registro daquele professor, e exibição dos dados dos alunos e suas matrículas.