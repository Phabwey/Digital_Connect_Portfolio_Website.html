db_connect.php
<?php

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "CollaborateX";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

?>
2. register.php
<?php
include 'db_connect.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    $full_name = $_POST['full_name'];
    $email = $_POST['email'];
    $password = password_hash($_POST['password'], PASSWORD_DEFAULT);
    $role = $_POST['role'];

    $sql = "INSERT INTO users (full_name, email, password, role)
            VALUES ('$full_name', '$email', '$password', '$role')";

    if ($conn->query($sql) === TRUE) {
        echo "Registration successful!";
    } else {
        echo "Error: " . $conn->error;
    }
}

$conn->close();
?>
3. login.php
<?php
session_start();
include 'db_connect.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    $email = $_POST['email'];
    $password = $_POST['password'];

    $sql = "SELECT * FROM users WHERE email='$email'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {

        $user = $result->fetch_assoc();

        if (password_verify($password, $user['password'])) {

            $_SESSION['user'] = $user['full_name'];

            echo "Login Successful";

        } else {
            echo "Incorrect Password";
        }

    } else {
        echo "User not found";
    }
}

$conn->close();
?>
4. contact.php
<?php
include 'db_connect.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    $full_name = $_POST['full_name'];
    $email = $_POST['email'];
    $subject = $_POST['subject'];
    $message = $_POST['message'];

    $sql = "INSERT INTO contact_messages(full_name,email,subject,message)
            VALUES('$full_name','$email','$subject','$message')";

    if ($conn->query($sql) === TRUE) {
        echo "Message sent successfully.";
    } else {
        echo "Error sending message.";
    }
}

$conn->close();
?>
5. forgot-password.php
<?php
include 'db_connect.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    $email = $_POST['email'];
    $token = md5(rand());

    $sql = "INSERT INTO password_resets(email,reset_token)
            VALUES('$email','$token')";

    if ($conn->query($sql) === TRUE) {
        echo "Password reset request submitted.";
    } else {
        echo "Error.";
    }
}

$conn->close();
?>
