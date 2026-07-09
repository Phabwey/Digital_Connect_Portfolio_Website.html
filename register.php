<?php
include 'db_connect.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST["username"];
    $email = $_POST["email"];
    $password = $_POST["password"];

    $query = "INSERT INTO users (username, email, password)
              VALUES ('$username', '$email', '$password')";

    if (mysqli_query($conn, $query)) {
        echo "Registration successful";
    } else {
        echo "Registration failed";
    }
}
?>