<?php
// Create connection

include "dbinfo.inc.php";

$conn = mysqli_connect($servername, $username, $password, $dbname);

$result = mysqli_query($conn,"SELECT question FROM Questions LIMIT 1");

if(mysqli_num_rows($result) == 0){
	die("0\n");
}

$row = mysqli_fetch_row($result);

//print stuff
echo ($row[0]);

mysqli_close($conn);
?>
