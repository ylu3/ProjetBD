SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

/* Affichage Album et fichier*/
SELECT Distinct Album.TitreAlbum, Fichier.IdFichier, DESCRIPTIONFICHIER
FROM Album, Piste, Fichier, Flux, UtilisateurClient U, Client C, ClientCodec CC, Codec Co
WHERE Fichier.IdAlbum = Album.IdAlbum
AND Album.IdAlbum = Piste.IdAlbum
AND Fichier.IdFichier = Flux.IdFichier
AND Fichier.IdPiste = Piste.IdPiste
AND Album.IdAlbum IN ( SELECT DISTINCT AC.IdAlbum
                        FROM AlbumCategorie AC, CategorieMusique CM
                        WHERE AC.IdCategorieMusique = CM.IdCategorieMusique
                        AND NomCategorieMusique IN ('Jazz', 'Rock'))
AND U.IdUtilisateur = 1
AND U.IdClient = C.IdClient
AND C.IdClient = CC.IdClient
AND CC.IdCodec = Co.IdCodec
AND Flux.TypeFlux = Co.TypeCodec
AND Co.NomCodec = CodecFlux
AND ((RESOLUTIONHAUTEUR < RESOLUTIONHAUTEURMAX AND RESOLUTIONLARGEUR < RESOLUTIONLARGEURMAX)
      OR (RESOLUTIONHAUTEUR IS NULL AND RESOLUTIONLARGEUR IS NULL));

Commit;