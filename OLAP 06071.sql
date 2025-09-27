CREATE TABLE DIM_CLIENT (
    client_id INT PRIMARY KEY,
    nom NVARCHAR(100),
    age INT,
    nbr_enfants INT,
    ville NVARCHAR(100),
    pays NVARCHAR(100),
    revenu DECIMAL(10, 2)
);

CREATE TABLE DIM_DATE (
    date_id INT PRIMARY KEY,
    jour INT,
    mois INT,
    trimestre INT,
    année INT
);

CREATE TABLE DIM_DESTINATION (
    destination_id INT PRIMARY KEY,
    hotel NVARCHAR(100),
    ville NVARCHAR(100),
    pays NVARCHAR(100)
);

CREATE TABLE DIM_COMPAGNIE (
    compagnie_id INT PRIMARY KEY,
    nom NVARCHAR(100),
    pays NVARCHAR(100)
);


CREATE TABLE FACT_SEJOURS (
    sejour_id INT PRIMARY KEY,
    client_id INT,
    date_id INT,
    destination_id INT,
    compagnie_id INT,
    montant DECIMAL(10,2),
    nbr_jours INT,
    FOREIGN KEY (client_id) REFERENCES DIM_CLIENT(client_id),
    FOREIGN KEY (date_id) REFERENCES DIM_DATE(date_id),
    FOREIGN KEY (destination_id) REFERENCES DIM_DESTINATION(destination_id),
    FOREIGN KEY (compagnie_id) REFERENCES DIM_COMPAGNIE(compagnie_id)
);

