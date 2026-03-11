<%@page import="Project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%@include file="header.html"%>
<html>
<head>
<title>Manage Stock</title>
<link rel="stylesheet" href="style.css" type="text/css" media="screen">
<style>

body {
    background-color: #e8dfcf;
    font-family: Arial, Helvetica, sans-serif;
}

.container {
    width: 100%;
    text-align: center;
}

/* Headings */
h2 {
    margin-top: 15px;
    margin-bottom: 8px;
    font-weight: 600;
}

/* Form group */
.form-group {
    margin-top: 10px;
}

/* Input + Select Styling */
input[type="number"],
select {
    width: 38%;
    height: 50px;
    border: none;
    border-radius: 50px;
    background-color: #cfcfcf;
    padding: 0 20px;
    font-size: 16px;
    outline: none;
    margin-bottom: 15px;
}

/* Save Button */
.button {
    width: 140px;
    height: 40px;
    background-color: black;
    color: white;
    border: none;
    font-size: 16px;
    cursor: pointer;
    border-radius: 4px;
    margin-top: 5px;
}

.button:hover {
    background-color: #333;
}

/* Table Styling */
#customers {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 55%;
    margin-top: 30px;
}

#customers td, #customers th {
    border: 1px solid #ddd;
    padding: 8px;
}

#customers tr:nth-child(even) {
    background-color: #f2f2f2;
}

#customers tr:hover {
    background-color: #ddd;
}

#customers th {
    padding-top: 12px;
    padding-bottom: 12px;
    text-align: center;
    background-color: #4CAF50;
    color: white;
}

</style>
</head>
<body>

<div class="container">
<br>
<%
String msg = request.getParameter("msg");
if ("invalid".equals(msg)) {
%>
    <center><font color="red" size="5">Something went wrong! Try Again!</font></center>
<%
} else if ("valid".equals(msg)) {
%>
    <center><font color="green" size="5">Successfully Updated</font></center>
<%
}
%>

<form action="manageStockAction.jsp" method="post">
    <div class="form-group">
        <center><h2>Select Blood Group</h2></center>
        <select name="bloodgroup" required>
            <option value="A+">A+</option>
            <option value="A-">A-</option>
            <option value="B+">B+</option>
            <option value="B-">B-</option>
            <option value="O+">O+</option>
            <option value="O-">O-</option>
            <option value="AB+">AB+</option>
            <option value="AB-">AB-</option>
        </select>

        <center><h2>Select Increase/Decrease</h2></center>
        <select name="incdec" required>
            <option value="inc">Increase</option>
            <option value="dec">Decrease</option>
        </select>

        <center><h2>Units</h2></center>
        <input type="number" placeholder="Enter Units" name="units" min="1" required>

        <center><button type="submit" class="button">Save</button></center>
    </div>
</form>

<br>

<center>
    <table id="customers">
        <tr>
            <th>Blood Group</th>
            <th>Units</th>
        </tr>
        <%
        try {
            Connection con = ConnectionProvider.getCon();
            Statement st = con.createStatement();
            //ResultSet rs = st.executeQuery("SELECT * FROM stock");
            
            ResultSet rs = st.executeQuery("SELECT bloodgroup, units FROM stock ORDER BY bloodgroup");
            while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getString(1) %></td>
                <td><%= rs.getString(2) %></td>
            </tr>
        <%
            }
            
            rs.close();
            st.close();
            con.close();
            
        } catch (Exception e) {
        %>
            <tr><td colspan="2"><b>Error:</b> <%= e.getMessage() %></td></tr>
        <%
            e.printStackTrace(); // for development log
        }
        %>
    </table>
</center>

<br><br><br><br>
<h3><center>All Right Reserved @ Chetan Yadav 2026</center></h3>
</div>
</body>
</html>
