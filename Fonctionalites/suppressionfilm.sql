/* FilmArtiste */
DELETE FROM FilmArtiste WHERE IdFilm = 1;

/* FilmCategorie */
DELETE FROM FilmCategorie WHERE IdFilm = 1;

/* Flux */
Delete From Flux WHERE IdFichier IN (SELECT IdFichier FROM Fichier WHERE Fichier.IdFilm = 1);

/* Fichier  */
Delete FROM Fichier WHERE IdFilm = 1;

/* Film */
Delete From Film WHERE IdFilm = 1;

/* CategorieFilm */
DELETE FROM CategorieFilm WHERE IdCategorieFilm NOT IN (SELECT CF.IdCategorieFilm 
                                                        FROM CategorieFilm CF, FilmCategorie FC 
                                                        WHERE FC.IdCategorieFilm = CF.IdCategorieFilm 
                                                        GROUP BY CF.IdCategorieFilm); 

/* Artiste */
DELETE FROM Artiste WHERE IdArtiste NOT IN(SELECT IdArtiste FROM PisteArtiste GROUP BY IdArtiste
                                           Union 
                                           SELECT IdArtiste FROM FilmArtiste GROUP BY IdArtiste);


Commit;