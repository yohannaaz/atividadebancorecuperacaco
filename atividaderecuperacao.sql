-- Criação do banco de dados
CREATE DATABASE GerenciamentoEventos;
USE GerenciamentoEventos;

-- Criação das tabelas

-- Tabela: Locais
CREATE TABLE Locais (
    LocalID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(255) NOT NULL,
    Capacidade INT NOT NULL
);

-- Tabela: Categorias
CREATE TABLE Categorias (
    CategoriaID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL
);

-- Tabela: Eventos
CREATE TABLE Eventos (
    EventoID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Data DATE NOT NULL,
    LocalID INT,
    CategoriaID INT,
    FOREIGN KEY (LocalID) REFERENCES Locais(LocalID),
    FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID)
);

-- Tabela: Participantes
CREATE TABLE Participantes (
    ParticipanteID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Telefone VARCHAR(15) NOT NULL
);

-- Tabela: Inscrições
CREATE TABLE Inscrições (
    InscricaoID INT AUTO_INCREMENT PRIMARY KEY,
    EventoID INT,
    ParticipanteID INT,
    DataInscricao DATE NOT NULL,
    FOREIGN KEY (EventoID) REFERENCES Eventos(EventoID),
    FOREIGN KEY (ParticipanteID) REFERENCES Participantes(ParticipanteID)
);

-- Inserção de dados de exemplo

-- Dados para Locais
INSERT INTO Locais (Nome, Endereco, Capacidade) VALUES
('Centro de Convenções', 'Av. Paulista, 1000', 500),
('Auditório Central', 'Rua da Liberdade, 150', 200);

-- Dados para Categorias
INSERT INTO Categorias (Nome) VALUES
('Programação'),
('Tecnologia');

-- Dados para Eventos
INSERT INTO Eventos (Nome, Data, LocalID, CategoriaID) VALUES
('Conferência Tech', '2024-09-01', 1, 2),
('Workshop Python', '2024-10-15', 2, 1);

-- Dados para Participantes
INSERT INTO Participantes (Nome, Email, Telefone) VALUES
('Ana Silva', 'ana@example.com', '123-456-7890'),
('João Souza', 'joao@example.com', '234-567-8901');

-- Dados para Inscrições
INSERT INTO Inscrições (EventoID, ParticipanteID, DataInscricao) VALUES
(1, 1, '2024-08-20'),
(2, 2, '2024-08-25');

-- Consultas SQL

-- 1. Mostrar todo o conteúdo das tabelas
SELECT * FROM Eventos;
SELECT * FROM Participantes;
SELECT * FROM Locais;
SELECT * FROM Categorias;
SELECT * FROM Inscrições;

-- 2. Filtragem por período de data (exemplo para eventos)
SELECT * FROM Eventos
WHERE Data BETWEEN '2024-09-01' AND '2024-10-31';

-- 3. Filtragem por valores maiores (exemplo para capacidade de locais)
SELECT * FROM Locais
WHERE Capacidade > 300;

-- 4. Filtragem por adição de valores (exemplo para somar inscrições por evento)
SELECT EventoID, COUNT(*) AS TotalInscricoes
FROM Inscrições
GROUP BY EventoID;

-- 5. Filtragem entre tabelas (exemplo para eventos e suas inscrições)
SELECT E.Nome AS EventoNome, P.Nome AS ParticipanteNome
FROM Inscrições I
JOIN Eventos E ON I.EventoID = E.EventoID
JOIN Participantes P ON I.ParticipanteID = P.ParticipanteID;

-- 6. Filtragem de campos de texto (exemplo para participantes cujo nome contém "Ana")
SELECT * FROM Participantes
WHERE Nome LIKE '%Ana%';
