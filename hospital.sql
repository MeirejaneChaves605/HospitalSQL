-- Tabela Hospital
CREATE TABLE Hospitais (
    hospital_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(200)
);

-- Tabela Pacientes
CREATE TABLE Pacientes (
    paciente_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(20)
);

-- Tabela Médicos
CREATE TABLE Medicos (
    medico_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    crm VARCHAR(20) UNIQUE NOT NULL,
    especialidade VARCHAR(50)
);

-- Tabela Consultas (Ligação entre Pacientes, Médicos e Hospitais)
CREATE TABLE Consultas (
    consulta_id SERIAL PRIMARY KEY,
    paciente_id INTEGER REFERENCES Pacientes(paciente_id),
    medico_id INTEGER REFERENCES Medicos(medico_id),
    hospital_id INTEGER REFERENCES Hospitais(hospital_id),
    data_consulta TIMESTAMP NOT NULL,
    diagnostico TEXT,
    valor DECIMAL(10, 2)
);


-- Inserir Hospitais
INSERT INTO Hospitais (nome, endereco) VALUES
('Hospital Geral da Paz', 'Rua das Flores, 123, Centro'),
('Clínica Vida Nova', 'Av. Principal, 456, Bairro Novo');

-- Inserir Pacientes
INSERT INTO Pacientes (nome, data_nascimento, cpf, telefone) VALUES
('Ana Silva', '1985-10-20', '111.222.333-44', '(11) 98765-4321'),
('Bruno Costa', '1992-03-15', '555.666.777-88', '(21) 99887-7665');

-- Inserir Médicos
INSERT INTO Medicos (nome, crm, especialidade) VALUES
('Dr. Carlos Ferreira', 'CRM/SP 123456', 'Cardiologia'),
('Dra. Diana Santos', 'CRM/RJ 654321', 'Pediatria');

-- Inserir Consultas (depende dos IDs gerados. Se for a primeira inserção, os IDs serão 1 e 2)
INSERT INTO Consultas (paciente_id, medico_id, hospital_id, data_consulta, diagnostico, valor) VALUES
(1, 1, 1, '2025-11-10 10:00:00', 'Dor no peito, necessidade de exames.', 300.00),
(2, 2, 2, '2025-11-11 14:30:00', 'Gripe forte.', 250.00);


-- Selecionar todos os pacientes
SELECT * FROM Pacientes;
SELECT
    C.data_consulta,
    P.nome AS nome_paciente,
    M.nome AS nome_medico,
    H.nome AS nome_hospital,
    C.diagnostico
FROM Consultas C
JOIN Pacientes P ON C.paciente_id = P.paciente_id
JOIN Medicos M ON C.medico_id = M.medico_id
JOIN Hospitais H ON C.hospital_id = H.hospital_id
WHERE C.data_consulta > '2025-11-01' -- Exemplo de filtro (WHERE)
ORDER BY C.data_consulta;


UPDATE Pacientes
SET telefone = '(11) 99999-0000'
WHERE nome = 'Ana Silva';

-- Verificar a atualização
SELECT nome, telefone FROM Pacientes WHERE nome = 'Ana Silva';


UPDATE Consultas
SET valor = 350.00
WHERE consulta_id = 1;

-- Verificar a atualização
SELECT consulta_id, valor FROM Consultas WHERE consulta_id = 1;
