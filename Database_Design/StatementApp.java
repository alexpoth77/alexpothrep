import java.sql.*;
import java.util.Scanner;

public class StatementApp {
    public static void main(String[] args) {
        String connectionUrl = "jdbc:sqlserver://sqlserver.dmst.aueb.gr:1433;databaseName=DB09;encrypt=true;trustServerCertificate=true;";
        String dbUser = "";
        String dbPwd = "";

        Scanner scanner = new Scanner(System.in);
        System.out.println("=== ΜΗΝΙΑΙΟ STATEMENT ===");
        System.out.print("Δώσε αριθμό κάρτας: ");
        long cardNum;
        try {
            cardNum = Long.parseLong(scanner.nextLine());
        } catch (NumberFormatException e) {
            System.out.println("Λάθος μορφή αριθμού.");
            return;
        }

        System.out.print("Δώσε μήνα (1-12): ");
        int month = scanner.nextInt();

        String sql = "SELECT " +
                "   CL.client_name, CL.surname, " +
                "   E.exchange_date, E.exhange_amount, " +
                "   S.shop_name, S.shops_service, " +
                "   C.card_balance " +
                "FROM CREDIT_CARD C " +
                "JOIN CLIENT CL ON C.client_id = CL.client_id " +
                "LEFT JOIN EXCHANGE E ON C.card_number = E.card_number " +
                "LEFT JOIN SHOPS S ON E.shop_id = S.shop_id " +
                "WHERE C.card_number = ? " +
                "AND (E.exchange_date IS NULL OR MONTH(E.exchange_date) = ?)";

        try (Connection conn = DriverManager.getConnection(connectionUrl, dbUser, dbPwd);
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, cardNum);
            pstmt.setInt(2, month);

            ResultSet rs = pstmt.executeQuery();

            boolean headerPrinted = false;
            double totalSpent = 0;
            double currentBalance = 0;

            System.out.println("\n-------------------------------------------------------------");
            System.out.printf("%-12s %-25s %-15s %-10s\n", "Ημ/νία", "Κατάστημα", "Υπηρεσία", "Ποσό");
            System.out.println("-------------------------------------------------------------");

            while (rs.next()) {
                if (!headerPrinted) {
                    System.out.println("Πελάτης: " + rs.getString("surname") + " " + rs.getString("client_name"));
                    System.out.println("Κάρτα: " + cardNum);
                    currentBalance = rs.getDouble("card_balance");
                    headerPrinted = true;
                }

                Date date = rs.getDate("exchange_date");
                if (date != null) {
                    String shop = rs.getString("shop_name");
                    int service = rs.getInt("shops_service");
                    double amount = rs.getDouble("exhange_amount");
                    totalSpent += amount;

                    System.out.printf("%-12s %-25s %-15d %-10.2f€\n", date, shop, service, amount);
                }
            }

            if (!headerPrinted) {
                System.out.println("Δεν βρέθηκε η κάρτα ή δεν υπάρχουν κινήσεις.");
            } else {
                System.out.println("-------------------------------------------------------------");
                System.out.printf("Σύνολο Κινήσεων Μήνα: %.2f€\n", totalSpent);
                System.out.printf("Τρέχον Υπόλοιπο Κάρτας: %.2f€\n", currentBalance);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
