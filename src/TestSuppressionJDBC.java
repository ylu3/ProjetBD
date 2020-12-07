import java.sql.*;

public class TestSuppressionJDBC{
    static final String URL = "jdbc:oracle:thin:@oracle1.ensimag.fr:1521:oracle1";
    static final String USER = "luy";
    static final String PASSWD = "luy";

    public static void suppressionFilm(Statement stmt) throws SQLException{
        stmt.addBatch("DELETE FROM FilmArtiste WHERE IdFilm = 1");
        stmt.addBatch("DELETE FROM FilmCategorie WHERE IdFilm = 1");
        stmt.addBatch("Delete From Flux WHERE IdFichier IN (SELECT IdFichier FROM Fichier WHERE Fichier.IdFilm = 1)");
        stmt.addBatch("Delete FROM Fichier WHERE IdFilm = 1");
        stmt.addBatch("Delete From Film WHERE IdFilm = 1");
        stmt.addBatch("DELETE FROM CategorieFilm WHERE IdCategorieFilm NOT IN (SELECT CF.IdCategorieFilm\n" + 
                        "FROM CategorieFilm CF, FilmCategorie FC\n" + 
                        "WHERE FC.IdCategorieFilm = CF.IdCategorieFilm\n" + 
                        "GROUP BY CF.IdCategorieFilm)\n");
        stmt.addBatch("DELETE FROM Artiste WHERE IdArtiste NOT IN(SELECT IdArtiste FROM PisteArtiste GROUP BY IdArtiste\n" + 
                        "Union\n" + 
                        "SELECT IdArtiste FROM FilmArtiste GROUP BY IdArtiste)\n");
        stmt.executeBatch();
    }

    public static void suppressionAlbum(Statement stmt) throws SQLException{
        stmt.addBatch("DELETE FROM PisteArtiste WHERE IdAlbum = 1");
        stmt.addBatch("DELETE FROM AlbumCategorie WHERE IdAlbum = 1");
        stmt.addBatch("Delete FROM Flux WHERE IdFichier IN (SELECT IdFichier FROM Fichier WHERE Fichier.IdAlbum = 1)");
        stmt.addBatch("Delete FROM Fichier WHERE IdAlbum = 1");
        stmt.addBatch("Delete FROM PisteCategorie WHERE IdAlbum = 1");
        stmt.addBatch("DELETE FROM Piste WHERE IdAlbum = 1");
        stmt.addBatch("Delete From Album WHERE IdAlbum = 1");
        stmt.addBatch("DELETE FROM CategorieMusique WHERE IdCategorieMusique NOT IN (SELECT CM.IdCategorieMusique FROM CategorieMusique CM, AlbumCategorie AC\n" + 
                        "WHERE AC.IdCategorieMusique = CM.IdCategorieMusique\n" + 
                        "GROUP BY CM.IdCategorieMusique\n" + 
                        "UNION\n" + 
                        "SELECT CM.IdCategorieMusique FROM CategorieMusique CM, PisteCategorie PC\n" +
                        "WHERE PC.IdCategorieMusique = CM.IdCategorieMusique\n" +
                        "GROUP BY CM.IdCategorieMusique)\n");
        stmt.addBatch("DELETE FROM Artiste WHERE IdArtiste NOT IN(SELECT IdArtiste FROM PisteArtiste GROUP BY IdArtiste\n" + 
                       "Union\n" + 
                       "SELECT IdArtiste FROM FilmArtiste GROUP BY IdArtiste)\n");
        stmt.executeBatch();
    }


    public static void main(String[] args){
        Connection conn = null;
        Statement stmt = null;
        try{
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
            conn = DriverManager.getConnection(URL, USER, PASSWD);
            conn.setAutoCommit(false);

            stmt = conn.createStatement();
            System.out.println("Supprimer le film id: 1");
            suppressionFilm(stmt);
            System.out.println("Supprimer le Album id: 1");
            suppressionAlbum(stmt);

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