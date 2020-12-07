/* Artiste */
INSERT INTO Artiste VALUES(4, 'Davis', 'Miles', to_date('26/05/1926','dd/mm/yyyy'), 'Jazz', 'un compositeur et trompettiste de jazz américain', 1);

/* Album */
INSERT INTO Album VALUES (2, 'Kind of Blue', 'Miles Davis', to_date('17/08/1959','dd/mm/yyyy'), 5);

/* CategoeirMusique */
INSERT INTO CategorieMusique VALUES(5, 'Jazz');

/* AlbumCategorie */
INSERT INTO AlbumCategorie VALUES(2, 5);

/* Piste */
INSERT INTO Piste VALUES (1, 'So What', 9, 2);
INSERT INTO Piste VALUES (2, 'Freddie Freeloader', 9, 2);

/* PisteArtiste */
INSERT INTO PisteArtiste VALUES(2, 1, 4, 'Chanteur', null);
INSERT INTO PisteArtiste VALUES(2, 2, 4, 'Chanteur', null);

/* PisteCategorie */
INSERT INTO PisteCategorie VALUES(2, 1, 5);
INSERT INTO PisteCategorie VALUES(2, 2, 5);

/* Fichier */
INSERT INTO Fichier VALUES (6, 500, SYSDATE, 'Album2 piste1', 1, null, 2, 1);
INSERT INTO Fichier VALUES (7, 500, SYSDATE, 'Album2 piste2', 1, null, 2, 2);


/* Flux */
INSERT INTO Flux VALUES (6, 1, 'MP3', 200, 'Audio', 16, null, null, 3);
INSERT INTO Flux VALUES (7, 1, 'MP3', 200, 'Audio', 16, null, null, 3);
INSERT INTO Flux VALUES (7, 2, 'ACC', 200, 'Audio', 16, null, null, 3);

Commit;
