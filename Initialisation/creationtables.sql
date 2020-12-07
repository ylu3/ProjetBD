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