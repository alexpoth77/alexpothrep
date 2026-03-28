import java.sql.*;
import java.util.Scanner;

public class DeleteCardApp {
    public static void main(String[] args) {
        String connectionUrl = "jdbc:sqlserver://sqlserver.dmst.aueb.gr:1433;databaseName=DB09;encrypt=true;trustServerCertificate=true;";
        String dbUser = "";
        String dbPwd = "";

        Scanner scanner = new Scanner(System.in);
        System.out.println("=== ΔΙΑΓΡΑΦΗ ΠΙΣΤΩΤΙΚΗΣ ΚΑΡΤΑΣ ===");
        System.out.print("Δώσε τον αριθμό της πιστωτικής κάρτας: ");

        long cardNumber;
        try {
            cardNumber = Long.parseLong(scanner.nextLine());
        } catch (NumberFormatException e) {
            System.out.println("Λάθος μορφή αριθμού.");
            return;
        }

        Connection conn = null;
        try {
            conn = DriverManager.getConnection(connectionUrl, dbUser, dbPwd);
            conn.setAutoCommit(false);

            String deleteExchangeSQL = "DELETE FROM EXCHANGE WHERE card_number = ?";
            try (PreparedStatement pstmt1 = conn.prepareStatement(deleteExchangeSQL)) {
                pstmt1.setLong(1, cardNumber);
                int rows = pstmt1.executeUpdate();
                System.out.println("Διαγράφηκαν " + rows + " συναλλαγές (agores).");
            }

            String deleteCardSQL = "DELETE FROM CREDIT_CARD WHERE card_number = ?";
            try (PreparedStatement pstmt2 = conn.prepareStatement(deleteCardSQL)) {
                pstmt2.setLong(1, cardNumber);
                int rows = pstmt2.executeUpdate();

                if (rows > 0) {
                    System.out.println("Η κάρτα " + cardNumber + " διαγράφηκε επιτυχώς.");
                    conn.commit();
                } else {
                    System.out.println("Δεν βρέθηκε κάρτα με αυτόν τον αριθμό.");
                    conn.rollback();
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null)
                    
                    conn.rollback();
                System.out.println("Προέκυψε σφάλμα. Έγινε επαναφορά (Rollback).");
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
