<?php

$host = "localhost";
$username = "root";
$password = "";
$database = "digital_connect";

$conn = new mysqli($host, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

?>
register.php
<?php
include 'db_connect.php';

if(isset($_POST['register'])){

    $fullname = $_POST['fullname'];
    $email = $_POST['email'];
    $phone = $_POST['phone'];
    $password = password_hash($_POST['password'], PASSWORD_DEFAULT);

    $sql = "INSERT INTO users(full_name,email,password,phone)
            VALUES('$fullname','$email','$password','$phone')";

    if($conn->query($sql)){
        echo "Registration Successful";
    }else{
        echo "Registration Failed";
    }
}

$conn->close();
?>
login.php
<?php
session_start();
include 'db_connect.php';

if(isset($_POST['login'])){

    $email = $_POST['email'];
    $password = $_POST['password'];

    $sql = "SELECT * FROM users WHERE email='$email'";
    $result = $conn->query($sql);

    if($result->num_rows > 0){

        $user = $result->fetch_assoc();

        if(password_verify($password,$user['password'])){

            $_SESSION['user'] = $user['full_name'];
            header("Location: ../index.html");

        }else{
            echo "Incorrect Password";
        }

    }else{
        echo "User Not Found";
    }
}

$conn->close();
?>
booking.php
<?php
include 'db_connect.php';

if(isset($_POST['book'])){

    $user_id = $_POST['user_id'];
    $booking_date = $_POST['booking_date'];
    $booking_time = $_POST['booking_time'];
    $computer_number = $_POST['computer_number'];
    $hours = $_POST['hours'];

    $sql = "INSERT INTO bookings(user_id,booking_date,booking_time,computer_number,hours)
            VALUES('$user_id','$booking_date','$booking_time','$computer_number','$hours')";

    if($conn->query($sql)){
        echo "Booking Successful";
    }else{
        echo "Booking Failed";
    }
}

$conn->close();
?>
contact.php
<?php
include 'db_connect.php';

if(isset($_POST['send'])){

    $fullname = $_POST['fullname'];
    $email = $_POST['email'];
    $subject = $_POST['subject'];
    $message = $_POST['message'];

    $sql = "INSERT INTO contact_messages(full_name,email,subject,message)
            VALUES('$fullname','$email','$subject','$message')";

    if($conn->query($sql)){
        echo "Message Sent Successfully";
    }else{
        echo "Failed to Send Message";
    }
}

$conn->close();
?>
payment.php
<?php
include 'db_connect.php';

if(isset($_POST['pay'])){

    $booking_id = $_POST['booking_id'];
    $amount = $_POST['amount'];
    $payment_method = $_POST['payment_method'];

    $sql = "INSERT INTO payments(booking_id,amount,payment_method)
            VALUES('$booking_id','$amount','$payment_method')";

    if($conn->query($sql)){
        echo "Payment Recorded Successfully";
    }else{
        echo "Payment Failed";
    }
}

$conn->close();
?>
logout.php
<?php
session_start();
session_destroy();

header("Location: ../login.html");
exit();
?>
