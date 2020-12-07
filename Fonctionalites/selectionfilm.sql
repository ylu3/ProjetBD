SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

/* Affichage film et fichier*/
SELECT Film.IdFilm, TitreFilm, Fichier.IdFichier, DescriptionFichier
FROM Film, Fichier, Flux, UtilisateurClient U, Client C, ClientCodec CC, Codec Co
WHERE Fichier.IdFilm = Film.IdFilm
AND Fichier.IdFichier = Flux.IdFichier
/* Premiere selection */
AND Film.IdFilm IN ( SELECT DISTINCT Film.IdFilm
                        FROM FilmCategorie FC, CategorieFilm CF, Film
                        WHERE CF.IdCategorieFilm = FC.IdCategorieFilm
                        AND FC.IdFilm = Film.IdFilm
                        AND AgeMin > 12
                        AND NomCategorieFilm IN ('Guerre', 'Documentaire'))
/* Verification de codec */
AND U.IdUtilisateur = 1
AND U.IdClient = C.IdClient
AND C.IdClient = CC.IdClient
AND CC.IdCodec = Co.IdCodec
AND Flux.TypeFlux = Co.TypeCodec
AND Co.NomCodec = CodecFlux
AND ((RESOLUTIONHAUTEUR < RESOLUTIONHAUTEURMAX AND RESOLUTIONLARGEUR < RESOLUTIONLARGEURMAX)
      OR (RESOLUTIONHAUTEUR IS NULL AND RESOLUTIONLARGEUR IS NULL));

Commit;