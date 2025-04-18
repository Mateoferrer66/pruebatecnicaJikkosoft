CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Posts (
    PostID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    Title VARCHAR(200) NOT NULL,
    Content TEXT NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Comments (
    CommentID INT PRIMARY KEY IDENTITY(1,1),
    PostID INT,
    UserID INT,
    Content TEXT NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (PostID) REFERENCES Posts(PostID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Tags (
    TagID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE PostTags (
    PostID INT,
    TagID INT,
    PRIMARY KEY (PostID, TagID),
    FOREIGN KEY (PostID) REFERENCES Posts(PostID),
    FOREIGN KEY (TagID) REFERENCES Tags(TagID)
);



-------------------CONSULTAS NECESARIAS-----------------------------------


-- Crear un usuario
INSERT INTO Users (Username, Email, PasswordHash)
VALUES ('mateoferrer', 'mateo@prueba.com', 'hash_123');

-- Crear una publicacion
INSERT INTO Posts (UserID, Title, Content)
VALUES (1, 'Mi primer post', 'Hola mundo desde mi blog!');

-- Crear un comentario
INSERT INTO Comments (PostID, UserID, Content)
VALUES (1, 1, 'Gracias por leer mi post');

-- Crear una etiqueta
INSERT INTO Tags (Name) VALUES ('Programacion');

-- Asociar una etiqueta a una publicacion
INSERT INTO PostTags (PostID, TagID) VALUES (1, 1);


-------------------VALIDAR FUNCIONAMIENTO--------------------------------


-- OBTENER POST CON SU AUTOS

SELECT p.PostID, p.Title, p.Content, u.Username, p.CreatedAt
FROM Posts p
JOIN Users u ON p.UserID = u.UserID;


--  OBTENER COMENTARIOS DE UN POST

SELECT c.Content, u.Username, c.CreatedAt
FROM Comments c
JOIN Users u ON c.UserID = u.UserID
WHERE c.PostID = 1;

-- OBTENER ETIQUETAS DE UN POST

SELECT t.Name
FROM PostTags pt
JOIN Tags t ON pt.TagID = t.TagID
WHERE pt.PostID = 1;

-- BUSCAR POST POR ETIQUETA


SELECT p.Title, p.Content, u.Username
FROM Posts p
JOIN PostTags pt ON p.PostID = pt.PostID
JOIN Tags t ON pt.TagID = t.TagID
JOIN Users u ON p.UserID = u.UserID
WHERE t.Name = 'Programacion';

