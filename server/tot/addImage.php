<?php
function image_fix_orientation(&$image, $filename) {
	$exif = exif_read_data($filename);

	if (!empty($exif['Orientation'])) {
		switch ($exif['Orientation']) {
			case 3:
				$image = imagerotate($image, 180, 0);
				break;

			case 6:
				$image = imagerotate($image, -90, 0);
				break;

			case 8:
				$image = imagerotate($image, 90, 0);
				break;
		}
	}
}
function compress($source, $destination, $quality) {
	$info = getimagesize($source);

	if ($info['mime'] == 'image/jpeg')
		$image = imagecreatefromjpeg($source);
	elseif ($info['mime'] == 'image/gif')
		$image = imagecreatefromgif($source);
	elseif ($info['mime'] == 'image/png')
		$image = imagecreatefrompng($source);
	
	image_fix_orientation($image,$source);
	
	$image_number = 0;
	for($image_number = 0; file_exists(UPLOAD_DIR."img$image_number.png");$image_number++){}
	
	$destination = UPLOAD_DIR."img$image_number.png";

	imagejpeg($image, $destination, $quality);
	
	return "img$image_number.png";
}
$questionid = $_POST["questionid"];
$left_or_right = $_POST["side"];

define("UPLOAD_DIR", "/Applications/XAMPP/xamppfiles/htdocs/images/");

if (!empty($_FILES["myFile"])) {
	$myFile = $_FILES["myFile"];

	if ($myFile["error"] !== UPLOAD_ERR_OK) {
		echo "ERR: An error occurred.\n";
		exit;
	}

	
	// preserve file from temporary directory
	$destination = compress($myFile["tmp_name"],
			UPLOAD_DIR . $name,60);
	include "dbinfo.inc.php";
	$conn = mysqli_connect($servername, $username, $password, $dbname);
	//upload complete
	$query = mysqli_query($conn,"UPDATE Questions SET ".$left_or_right."_answer = '$destination' WHERE id = $questionid");
	if(!query){
		die ("can't update db");
	}
	
	echo "success";

}
?>