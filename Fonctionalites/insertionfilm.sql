/* Artiste */
INSERT INTO Artiste VALUES(5, 'George', 'Mackay', to_date('03/05/1992','dd/mm/yyyy'), 'Film', 'un acteur britannique', 5);
INSERT INTO Artiste VALUES(6, 'Sam', 'Mendes', to_date('01/08/1965','dd/mm/yyyy'), 'Réalisation', 'un réalisateur et producteur de cinéma britannique', 1);

/* Film */
INSERT INTO Film VALUES(2, '1917', 2019, 'histoire de deux jeunes soldats ', 17, 3);

/* CategorieFilm */
INSERT INTO CategorieFilm VALUES(5, 'Guerre');

/* FilmCategorie */
INSERT INTO FilmCategorie VALUES(2, 5);

/* FilmArtiste */
INSERT INTO FilmArtiste VALUES(2, 5, 'Role : Schofield');
INSERT INTO FilmArtiste VALUES(2, 6, 'Réalisateur');

/* Fichier */
INSERT INTO Fichier VALUES (5, 400, SYSDATE, 'Film2', 2, 2, null, null);

/* Flux */
INSERT INTO Flux VALUES (5, 1, 'DivX', 300, 'Video', null, 1200, 800, null);

Commit;
