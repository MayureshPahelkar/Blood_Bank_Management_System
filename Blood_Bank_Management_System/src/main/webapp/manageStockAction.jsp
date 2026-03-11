<%@page import="Project.ConnectionProvider" %>
<%@page import="java.sql.*" %>

<%
String bloodgroup = request.getParameter("bloodgroup");
String indec = request.getParameter("incdec");
String units = request.getParameter("units");

int units1 = Integer.parseInt(units);

try {
    Connection con = ConnectionProvider.getCon();

    // Check if bloodgroup already exists
    PreparedStatement checkPs = con.prepareStatement("SELECT * FROM stock WHERE bloodgroup = ?");
    checkPs.setString(1, bloodgroup);
    ResultSet rs = checkPs.executeQuery();

    if(rs.next()) {
        // Bloodgroup exists → Update

        int currentUnits = rs.getInt("units");
        int newUnits = 0;

        if(indec.equals("inc")) {
            newUnits = currentUnits + units1;
        } else {
            newUnits = currentUnits - units1;

            // Prevent negative stock
            if(newUnits < 0) {
                response.sendRedirect("manageStock.jsp?msg=invalid");
                return;
            }
        }

        PreparedStatement updatePs = con.prepareStatement(
            "UPDATE stock SET units = ? WHERE bloodgroup = ?"
        );
        updatePs.setInt(1, newUnits);
        updatePs.setString(2, bloodgroup);
        updatePs.executeUpdate();

    } else {
        // Bloodgroup does not exist → Insert new row

        if(indec.equals("dec")) {
            // Cannot decrease if no record exists
            response.sendRedirect("manageStock.jsp?msg=invalid");
            return;
        }

        PreparedStatement insertPs = con.prepareStatement(
            "INSERT INTO stock (bloodgroup, units) VALUES (?, ?)"
        );
        insertPs.setString(1, bloodgroup);
        insertPs.setInt(2, units1);
        insertPs.executeUpdate();
    }

    response.sendRedirect("manageStock.jsp?msg=valid");

} catch(Exception e) {
    e.printStackTrace();   // helpful for debugging
    response.sendRedirect("manageStock.jsp?msg=invalid");
}
%>