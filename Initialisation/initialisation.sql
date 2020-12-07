DROP TABLE PisteArtiste;
DROP TABLE FilmArtiste;
DROP TABLE FilmCategorie;
DROP TABLE PisteCategorie;
DROP TABLE AlbumCategorie;
DROP TABLE ClientCodec;
DROP TABLE UtilisateurClient;
DROP TABLE Flux;
DROP TABLE Fichier;
DROP TABLE Piste;
DROP TABLE Album;
DROP TABLE Utilisateur;
DROP TABLE Film;
DROP TABLE Artiste;
DROP TABLE CategorieMusique;
DROP TABLE CategorieFilm;
DROP TABLE Image;
DROP TABLE Codec;
DROP TABLE Client;
DROP TABLE Langue;


CREATE TABLE Langue(
    IdLangue INT PRIMARY KEY,
    NomLangue VARCHAR(255) NOT NULL UNIQUE
);


CREATE TABLE Client(
    IdClient INT PRIMARY KEY,
    Marque VARCHAR(20) NOT NULL,
    Modele VARCHAR(20) NOT NULL,
    ResolutionHauteurMax INT,
    ResolutionLargeurMax INT,
    CONSTRAINT unicite_Client UNIQUE(Marque, Modele)
);


CREATE TABLE Codec(
    IdCodec INT PRIMARY KEY,
    NomCodec VARCHAR(20) NOT NULL,
    TypeCodec VARCHAR(20)
);


CREATE TABLE Image(
    IdImage INT PRIMARY KEY,
    UrlImage VARCHAR(255)
);


CREATE TABLE CategorieFilm(
    IdCategorieFilm INT PRIMARY KEY,
    NomCategorieFilm VARCHAR(20) NOT NULL UNIQUE
);


CREATE TABLE CategorieMusique(
    IdCategorieMusique INT PRIMARY KEY,
    NomCategorieMusique VARCHAR(20) NOT NULL UNIQUE
);


CREATE TABLE Artiste(
    IdArtiste INT PRIMARY KEY,
    NomArtiste VARCHAR(20),
    PrenomArtiste VARCHAR(20),
    DateNaissance Date,
    Specialite VARCHAR(20),
    Biographe VARCHAR(255),
    IdPhote INT REFERENCES Image(IdImage)
);


CREATE TABLE Film(
    IdFilm INT PRIMARY KEY,
    TitreFilm VARCHAR(20) NOT NULL,
    AnneeSortie NUMBER(4) NOT NULL,
    Resume VARCHAR(255),
    AgeMin INT,
    IdAffiche INT REFERENCES Image(IdImage)
);


CREATE TABLE Utilisateur(
    IdUtilisateur INT PRIMARY KEY,
    NomUtilisateur VARCHAR(20),
    PrenomUtilisateur VARCHAR(20),
    MailUtilisateur VARCHAR(50) NOT NULL UNIQUE,
    AgeUtilisateur INT,
    CodeAcces VARCHAR(20) NOT NULL UNIQUE,
    IDLanguePreferee INT REFERENCES Langue(IdLangue)
);


CREATE TABLE Album(
    IdAlbum INT PRIMARY KEY,
    TitreAlbum VARCHAR(20) NOT NULL,
    NomArtiste VARCHAR(20),
    DateSortie Date,
    IdProchette INT REFERENCES Image(IdImage)
);


CREATE TABLE Piste(
    IdPiste INT NOT NULL,
    TitrePiste VARCHAR(20) NOT NULL,
    DureePiste INT,
    IdAlbum INT REFERENCES Album(IdAlbum) NOT NULL,
    CONSTRAINT pk_Piste PRIMARY KEY (IdAlbum, IdPiste)
);


CREATE TABLE Fichier(
    IdFichier INT PRIMARY KEY,
    TailleFichier INT,
    DateDepot Date,
    DescriptionFichier VARCHAR(255),
    IdUtilisateur INT REFERENCES Utilisateur(IdUtilisateur),
    IdFilm INT REFERENCES Film(IdFilm),
    IdAlbum INT,
    IdPiste INT,
    CONSTRAINT fk_piste FOREIGN KEY (IdAlbum, IdPiste) REFERENCES Piste(IdAlbum, IdPiste),
    CONSTRAINT check_association CHECK ((IdAlbum IS NOT NULL AND IdPiste IS NOT NULL AND IdFilm IS NULL)
                                        OR (IdAlbum IS NULL AND IdPiste IS NULL AND IdFilm IS NOT NULL))
);


CREATE TABLE Flux(
    IdFichier INT REFERENCES Fichier(IdFichier) NOT NULL,
    IdFlux INT NOT NULL,
    CodecFlux VARCHAR(20),
    DebitFlux INT,
    TypeFlux VARCHAR(20),
    Echantillonnage INT,
    ResolutionHauteur INT,
    ResolutionLargeur INT,
    IdLangue INT REFERENCES Langue(IdLangue),
    CONSTRAINT pk_flux PRIMARY KEY (IdFichier, IdFlux)
);


CREATE TABLE UtilisateurClient(
    IdUtilisateur INT REFERENCES Utilisateur(IdUtilisateur),
    IdClient INT REFERENCES Client(IdClient),
    CONSTRAINT pk_UC PRIMARY KEY(IdUtilisateur, IdClient)
);


CREATE TABLE ClientCodec(
    IdClient INT REFERENCES Client(IdClient),
    IdCodec INT REFERENCES Codec(IdCodec),
    CONSTRAINT pk_CC PRIMARY KEY(IdClient, IdCodec)
);


CREATE TABLE AlbumCategorie(
    IdAlbum INT REFERENCES Album(IdAlbum),
    IdCategorieMusique INT REFERENCES CategorieMusique(IdCategorieMusique),
    CONSTRAINT pk_AC PRIMARY KEY (IdAlbum, IdCategorieMusique)
);


CREATE TABLE PisteCategorie(
    IdAlbum INT,
    IdPiste INT,
    IdCategorieMusique INT REFERENCES CategorieMusique(IdCategorieMusique),
    CONSTRAINT fk_PC FOREIGN KEY (IdAlbum, IdPiste) REFERENCES Piste(IdAlbum, IdPiste),
    CONSTRAINT pk_PC PRIMARY KEY (IdAlbum, IdPiste, IdCategorieMusique)
);


CREATE TABLE FilmCategorie(
    IdFilm INT REFERENCES Film(IdFilm),
    IdCategorieFilm INT REFERENCES CategorieFilm(IdCategorieFilm),
    CONSTRAINT pk_FC PRIMARY KEY (IdFilm, IdCategorieFilm)
);


CREATE TABLE FilmArtiste(
    IdFilm INT REFERENCES Film(IdFilm),
    IdArtiste INT REFERENCES Artiste(IdArtiste),
    RoleArtiste VARCHAR(20),
    CONSTRAINT pk_FA PRIMARY KEY (IdFilm, IdArtiste)
);


CREATE TABLE PisteArtiste(
    IdAlbum INT,
    IdPiste INT,
    IdArtiste INT REFERENCES Artiste(IdArtiste),
    RoleArtiste VARCHAR(20),
    Instrument VARCHAR(20),
    CONSTRAINT fk_PA FOREIGN KEY (IdAlbum, IdPiste) REFERENCES Piste(IdAlbum, IdPiste),
    CONSTRAINT pk_PA PRIMARY KEY (IdAlbum, IdPiste, IdArtiste)
);

/* Langue */
INSERT INTO Langue VALUES(1, 'Français');
INSERT INTO Langue VALUES(2, 'Chinois');
INSERT INTO Langue VALUES(3, 'Anglais');
INSERT INTO Langue VALUES(4, 'Allemand');
INSERT INTO Langue VALUES(5, 'Espagnol');

/* Client */
INSERT INTO Client VALUES(1, 'Apple', 'XS', 1920, 1080);
INSERT INTO Client VALUES(2, 'Apple', 'Mac', 5120, 2880);
INSERT INTO Client VALUES(3, 'Apple', 'Ipod', 400, 300);

/* Codec */
INSERT INTO Codec VALUES(1, 'MP3', 'Audio');
INSERT INTO Codec VALUES(2, 'MPEG4', 'Audio');
INSERT INTO Codec VALUES(3, 'ACC', 'Audio');
INSERT INTO Codec VALUES(4, 'AC3', 'Audio');
INSERT INTO Codec VALUES(5, 'MPEG2', 'Video');
INSERT INTO Codec VALUES(6, 'MPEG4', 'Video');
INSERT INTO Codec VALUES(7, 'DivX', 'Video');
INSERT INTO Codec VALUES(8, 'H264', 'Video');
INSERT INTO Codec VALUES(9, 'AQTitle', 'Texte');
INSERT INTO Codec VALUES(10, 'DKS', 'Texte');
INSERT INTO Codec VALUES(11, 'Kate', 'Texte');

/* Image */
INSERT INTO Image VALUES(1, 'https://chamilo.grenoble-inp.fr/web/css/themes/chamilo_inp/images/header-logo.png');
INSERT INTO Image VALUES(2, 'https://chamilo.univ-grenoble-alpes.fr/app/upload/users/1/1/my_files/simsu.png');
INSERT INTO Image VALUES(3, 'https://chamilo.grenoble-inp.fr/main/img/icons/22/new-message.png');
INSERT INTO Image VALUES(4, 'https://chamilo.grenoble-inp.fr/main/img/icons/22/edit-profile.png');
INSERT INTO Image VALUES(5, 'https://chamilo.grenoble-inp.fr/main/img/icons/22/invitations.png');

/* CategorieFilm */
INSERT INTO CategorieFilm VALUES(1, 'Animation');
INSERT INTO CategorieFilm VALUES(2, 'Comédie');
INSERT INTO CategorieFilm VALUES(3, 'Science-fiction');
INSERT INTO CategorieFilm VALUES(4, 'Documentaire');

/* CategorieMusique */
INSERT INTO CategorieMusique VALUES(1, 'Rock');
INSERT INTO CategorieMusique VALUES(2, 'Populaire');
INSERT INTO CategorieMusique VALUES(3, 'Classique');
INSERT INTO CategorieMusique VALUES(4, 'Opéra');

/* Artiste */
INSERT INTO Artiste VALUES(1, 'Roger', 'Waters', to_date('06/09/1943','dd/mm/yyyy'), 'Rock', 'un musicien et auteur-compositeur-interprète britannique', 2);
INSERT INTO Artiste VALUES(2, 'David', 'Gilmour', to_date('06/05/1946','dd/mm/yyyy'), 'Rock', 'un guitariste britannique, chanteur, compositeur et producteur de disques', 3);
INSERT INTO Artiste VALUES(3, 'Robot', 'Downey', to_date('04/04/1965','dd/mm/yyyy'), 'Film', 'un acteur américain', 4);

/* Film */
INSERT INTO Film VALUES(1, 'Avengers', 2012, 'super-héros', 13, 1);

/* Utilsateur */
INSERT INTO Utilisateur VALUES(1, 'LU', 'Yan', 'yan.lu1@grenoble-inp.fr', 23, '0001', 2);
INSERT INTO Utilisateur VALUES(2, 'Pierre', 'PORCEAU', 'Pierre.Pocreau@grenoble-inp.org', 23, '0002', 1);
INSERT INTO Utilisateur VALUES(3, 'Johan', 'PARDON', 'Johan.Pardon@grenoble-inp.org', 23, '0003', 1);

/* Album */
INSERT INTO Album VALUES (1, 'The Wall', 'Pink Floyd', to_date('30/11/1979','dd/mm/yyyy'), 3);

/* Piste */
INSERT INTO Piste VALUES (1, 'In the Flesh?', 3, 1);
INSERT INTO Piste VALUES (2, 'Empty Spaces', 2, 1);
INSERT INTO Piste VALUES (3, 'Young Lust', 3, 1);

/* Fichier */
INSERT INTO Fichier VALUES (1, 200, SYSDATE, 'Film1', 1, 1, null, null);
INSERT INTO Fichier VALUES (2, 500, SYSDATE, 'Album1 piste1', 3, null, 1, 1);
INSERT INTO Fichier VALUES (3, 500, SYSDATE, 'Album1 piste2', 3, null, 1, 2);
INSERT INTO Fichier VALUES (4, 500, SYSDATE, 'Album1 piste3', 3, null, 1, 3);


/* Flux */
INSERT INTO Flux VALUES (1, 1, 'MGPEG2', 500, 'Video', null, 1800, 1600, null);
INSERT INTO Flux VALUES (1, 2, 'MGPEG2', 300, 'Video', null, 1200, 800, null);
INSERT INTO Flux VALUES (2, 1, 'MP3', 200, 'Audio', 32, null, null, 1);
INSERT INTO Flux VALUES (3, 1, 'MP3', 200, 'Audio', 32, null, null, 1);
INSERT INTO Flux VALUES (4, 1, 'MP3', 200, 'Audio', 32, null, null, 1);


/* UtilisateurClient */
INSERT INTO UtilisateurClient VALUES (1, 1);
INSERT INTO UtilisateurClient VALUES (1, 2);
INSERT INTO UtilisateurClient VALUES (1, 3);
INSERT INTO UtilisateurClient VALUES (2, 1);
INSERT INTO UtilisateurClient VALUES (3, 2);

/* ClientCodecAudio */
INSERT INTO ClientCodec VALUES(1, 1);
INSERT INTO ClientCodec VALUES(1, 2);
INSERT INTO ClientCodec VALUES(1, 3);
INSERT INTO ClientCodec VALUES(1, 4);
INSERT INTO ClientCodec VALUES(2, 1);
INSERT INTO ClientCodec VALUES(2, 3);
INSERT INTO ClientCodec VALUES(3, 1);
INSERT INTO ClientCodec VALUES(3, 2);
INSERT INTO ClientCodec VALUES(1, 5);
INSERT INTO ClientCodec VALUES(1, 6);
INSERT INTO ClientCodec VALUES(1, 7);
INSERT INTO ClientCodec VALUES(2, 5);
INSERT INTO ClientCodec VALUES(2, 6);
INSERT INTO ClientCodec VALUES(2, 8);
INSERT INTO ClientCodec VALUES(1, 9);
INSERT INTO ClientCodec VALUES(1, 10);
INSERT INTO ClientCodec VALUES(2, 9);
INSERT INTO ClientCodec VALUES(2, 10);
INSERT INTO ClientCodec VALUES(3, 9);

/* AlbumCategorie */
INSERT INTO AlbumCategorie VALUES(1, 2);

/* PisteCategorie */
INSERT INTO PisteCategorie VALUES(1, 1, 2);
INSERT INTO PisteCategorie VALUES(1, 2, 2);
INSERT INTO PisteCategorie VALUES(1, 3, 2);

/* FilmCategorie */
INSERT INTO FilmCategorie VALUES(1, 4);
INSERT INTO FilmCategorie VALUES(1, 2);

/* FilmArtiste */
INSERT INTO FilmArtiste VALUES(1, 3, 'Role : Iron Man');

/* PisteArtiste */
INSERT INTO PisteArtiste VALUES(1, 1, 1, 'Chanteur', null);
INSERT INTO PisteArtiste VALUES(1, 2, 1, 'Chanteur', null);
INSERT INTO PisteArtiste VALUES(1, 3, 2, 'Chanteur & Musicien', 'Guitare');

