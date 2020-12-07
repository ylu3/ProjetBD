import java.sql.*;

public class TestInsertionJDBC{
    static final String URL = "jdbc:oracle:thin:@oracle1.ensimag.fr:1521:oracle1";
    static final String USER = "luy";
    static final String PASSWD = "luy";

    public static void insertionFilm(Statement stmt) throws SQLException{
        stmt.addBatch("INSERT INTO Artiste VALUES(5, 'George', 'Mackay', to_date('03/05/1992','dd/mm/yyyy'), 'Film', 'un acteur britannique', 5)");
        stmt.addBatch("INSERT INTO Artiste VALUES(6, 'Sam', 'Mendes', to_date('01/08/1965','dd/mm/yyyy'), 'Réalisation', 'un réalisateur et producteur de cinéma britannique', 1)");
        stmt.addBatch("INSERT INTO Film VALUES(2, '1917', 2019, 'histoire de deux jeunes soldats ', 17, 3)");
        stmt.addBatch("INSERT INTO CategorieFilm VALUES(5, 'Guerre')");
        stmt.addBatch("INSERT INTO FilmCategorie VALUES(2, 5)");
        stmt.addBatch("INSERT INTO FilmArtiste VALUES(2, 5, 'Role : Schofield')");
        stmt.addBatch("INSERT INTO FilmArtiste VALUES(2, 6, 'Réalisateur')");
        stmt.addBatch("INSERT INTO Fichier VALUES (5, 400, SYSDATE, 'Film2', 2, 2, null, null)");
        stmt.addBatch("INSERT INTO Flux VALUES (5, 1, 'DivX', 300, 'Video', null, 1200, 800, null)");
        stmt.executeBatch();
    }

    public static void insertionAlbum(Statement stmt) throws SQLException{
        stmt.addBatch("INSERT INTO Artiste VALUES(4, 'Davis', 'Miles', to_date('26/05/1926','dd/mm/yyyy'), 'Jazz', 'un compositeur et trompettiste de jazz américain', 1)");
        stmt.addBatch("INSERT INTO Album VALUES (2, 'Kind of Blue', 'Miles Davis', to_date('17/08/1959','dd/mm/yyyy'), 5)");
        stmt.addBatch("INSERT INTO CategorieMusique VALUES(5, 'Jazz')");
        stmt.addBatch("INSERT INTO AlbumCategorie VALUES(2, 5)");
        stmt.addBatch("INSERT INTO Piste VALUES (1, 'So What', 9, 2)");
        stmt.addBatch("INSERT INTO Piste VALUES (2, 'Freddie Freeloader', 9, 2)");
        stmt.addBatch("INSERT INTO PisteArtiste VALUES(2, 1, 4, 'Chanteur', null)");
        stmt.addBatch("INSERT INTO PisteArtiste VALUES(2, 2, 4, 'Chanteur', null)");
        stmt.addBatch("INSERT INTO PisteCategorie VALUES(2, 1, 5)");
        stmt.addBatch("INSERT INTO PisteCategorie VALUES(2, 2, 5)");
        stmt.addBatch("INSERT INTO Fichier VALUES (6, 500, SYSDATE, 'Album2 piste1', 1, null, 2, 1)");
        stmt.addBatch("INSERT INTO Fichier VALUES (7, 500, SYSDATE, 'Album2 piste2', 1, null, 2, 2)");
        stmt.addBatch("INSERT INTO Flux VALUES (6, 1, 'MP3', 200, 'Audio', 16, null, null, 3)");
        stmt.addBatch("INSERT INTO Flux VALUES (7, 1, 'MP3', 200, 'Audio', 16, null, null, 3)");
        stmt.addBatch("INSERT INTO Flux VALUES (7, 2, 'ACC', 200, 'Audio', 16, null, null, 3)");
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
            System.out.println("Insertion un nouveau film '1917' et les autres donnes néccessaires(Categorie, Artiste...)");
            insertionFilm(stmt);
            System.out.println("Insertion un nouveau album 'Kind of blue' et les autres donnes néccessaires(Categorie, Artiste)");
            insertionAlbum(stmt);

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