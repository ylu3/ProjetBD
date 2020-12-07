/* PisteArtiste */
DELETE FROM PisteArtiste WHERE IdAlbum = 1;

/* AlbumCategorie */
DELETE FROM AlbumCategorie WHERE IdAlbum = 1;

/* Flux */
Delete FROM Flux WHERE IdFichier IN (SELECT IdFichier FROM Fichier WHERE Fichier.IdAlbum = 1);

/* Fichier */
Delete FROM Fichier WHERE IdAlbum = 1;

/* PisteCategorie */
Delete FROM PisteCategorie WHERE IdAlbum = 1;

/* Piste */
DELETE FROM Piste WHERE IdAlbum = 1;

/* Album */
Delete From Album WHERE IdAlbum = 1;

/* CategorieMusique */
DELETE FROM CategorieMusique WHERE IdCategorieMusique NOT IN (SELECT CM.IdCategorieMusique FROM CategorieMusique CM, AlbumCategorie AC 
                                                              WHERE AC.IdCategorieMusique = CM.IdCategorieMusique 
                                                              GROUP BY CM.IdCategorieMusique
                                                              UNION
                                                              SELECT CM.IdCategorieMusique FROM CategorieMusique CM, PisteCategorie PC 
                                                              WHERE PC.IdCategorieMusique = CM.IdCategorieMusique 
                                                              GROUP BY CM.IdCategorieMusique); 

/* Artiste */
DELETE FROM Artiste WHERE IdArtiste NOT IN(SELECT IdArtiste FROM PisteArtiste GROUP BY IdArtiste 
                                           Union 
                                           SELECT IdArtiste FROM FilmArtiste GROUP BY IdArtiste);


Commit;