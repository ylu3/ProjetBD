import java.sql.*;

public class TestSelectionJDBC{
    static final String URL = "jdbc:oracle:thin:@oracle1.ensimag.fr:1521:oracle1";
    static final String USER = "luy";
    static final String PASSWD = "luy";

    public static void selectionFilm(Statement stmt, ResultSet rs) throws SQLException{
        String sql = "";
        sql += "SELECT Film.IdFilm, TitreFilm, Fichier.IdFichier, DescriptionFichier\n";
        sql += "FROM Film, Fichier, Flux, UtilisateurClient U, Client C, ClientCodec CC, Codec Co\n";
        sql += "WHERE Fichier.IdFilm = Film.IdFilm\n";
        sql += "AND Fichier.IdFichier = Flux.IdFichier\n";
        sql += "AND Film.IdFilm IN ( SELECT DISTINCT Film.IdFilm\n";
        sql += "FROM FilmCategorie FC, CategorieFilm CF, Film\n";
        sql += "WHERE CF.IdCategorieFilm = FC.IdCategorieFilm\n";
        sql += "AND FC.IdFilm = Film.IdFilm\n";
        sql += "AND AgeMin > 12\n";
        sql += "AND NomCategorieFilm IN ('Guerre', 'Documentaire'))\n";
        sql += "AND U.IdUtilisateur = 1\n";
        sql += "AND U.IdClient = C.IdClient\n";
        sql += "AND C.IdClient = CC.IdClient\n";
        sql += "AND CC.IdCodec = Co.IdCodec\n";
        sql += "AND Flux.TypeFlux = Co.TypeCodec\n";
        sql += "AND Co.NomCodec = CodecFlux\n";
        sql += "AND ((RESOLUTIONHAUTEUR < RESOLUTIONHAUTEURMAX AND RESOLUTIONLARGEUR < RESOLUTIONLARGEURMAX)\n";
        sql += "OR (RESOLUTIONHAUTEUR IS NULL AND RESOLUTIONLARGEUR IS NULL))\n";
        rs = stmt.executeQuery(sql);
        System.out.println("IdFilm" + " " + "titreFilm" + " " + "idFichier" + " " + "descriptionFichier");
        while (rs.next()){
            int idFilm = rs.getInt(1);
            String titreFilm = rs.getString(2);
            int idFichier = rs.getInt(3);
            String descriptionFichier = rs.getString(4);
            System.out.println(idFilm + "  " + titreFilm + "  " + idFichier + "  " + descriptionFichier);
        }
    }

    public static void selectionAlbum(Statement stmt, ResultSet rs) throws SQLException{
        String sql = "";
        sql += "SELECT Distinct Album.TitreAlbum, Fichier.IdFichier, DESCRIPTIONFICHIER\n";
        sql += "FROM Album, Piste, Fichier, Flux, UtilisateurClient U, Client C, ClientCodec CC, Codec Co\n";
        sql += "WHERE Fichier.IdAlbum = Album.IdAlbum\n";
        sql += "AND Album.IdAlbum = Piste.IdAlbum\n";
        sql += "AND Fichier.IdFichier = Flux.IdFichier\n";
        sql += "AND Fichier.IdPiste = Piste.IdPiste\n";
        sql += "AND Album.IdAlbum IN ( SELECT DISTINCT AC.IdAlbum\n";
        sql += "FROM AlbumCategorie AC, CategorieMusique CM\n";
        sql += "WHERE AC.IdCategorieMusique = CM.IdCategorieMusique\n";
        sql += "AND NomCategorieMusique IN ('Jazz', 'Rock'))\n";
        sql += "AND U.IdUtilisateur = 1\n";
        sql += "AND U.IdClient = C.IdClient\n";
        sql += "AND C.IdClient = CC.IdClient\n";
        sql += "AND CC.IdCodec = Co.IdCodec\n";
        sql += "AND Flux.TypeFlux = Co.TypeCodec\n";
        sql += "AND Co.NomCodec = CodecFlux\n";
        sql += "AND ((RESOLUTIONHAUTEUR < RESOLUTIONHAUTEURMAX AND RESOLUTIONLARGEUR < RESOLUTIONLARGEURMAX)\n";
        sql += "OR (RESOLUTIONHAUTEUR IS NULL AND RESOLUTIONLARGEUR IS NULL))\n";
        rs = stmt.executeQuery(sql);
        System.out.println("TitreAlbum" +  " " + "idFichier" + " " + "descriptionFichier");
        while (rs.next()){
            String titreAlbum = rs.getString(1);
            int idFichier = rs.getInt(2);
            String descriptionFichier = rs.getString(3);
            System.out.println(titreAlbum + "  " + idFichier + "  " + descriptionFichier);
        }
    }


    public static void main(String[] args){
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try{
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
            conn = DriverManager.getConnection(URL, USER, PASSWD);
            conn.setAutoCommit(false);

            stmt = conn.createStatement();
            System.out.println("Tous les films aceessible par utilisateur1(avec ses clients) et de type Guerre ou Documentaire ayant un âge minimum de 12 ans");
            selectionFilm(stmt, rs);
            System.out.println("Tous les albums aceessible par utilisateur1(avec ses clients) et de type Jazz ou Rock");
            selectionAlbum(stmt, rs);

            stmt.close();
            conn.close();

        } catch (SQLException se){
            System.out.println("Rollback!");
            se.printStackTrace();
            try {
                if (conn != null)
                    conn.rollback();
            } catch (SQLException se2){
                se2.printStackTrace();
            }
        } catch (Exception e){
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException se3){
                se3.printStackTrace();
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException se2){
                se2.printStackTrace();
            }
        }

    }

}