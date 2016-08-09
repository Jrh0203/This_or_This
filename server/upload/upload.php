<?php
define("UPLOAD_DIR", "/Applications/XAMPP/xamppfiles/htdocs/images/");

if (!empty($_FILES["myFile"])) {
    $myFile = $_FILES["myFile"];

    if ($myFile["error"] !== UPLOAD_ERR_OK) {
        echo "ERR: An error occurred.\n";
        exit;
    }

    $array = explode('.', $myFile['name']);
    $extension = end($array);

    $image_number = 0;
    for($image_number = 0; file_exists(UPLOAD_DIR."img$image_number.$extension");$image_number++){}

    $name = "img$image_number.$extension";

    // preserve file from temporary directory
    $success = move_uploaded_file($myFile["tmp_name"],
        UPLOAD_DIR . $name);
    if (!$success) {
        echo "ERR: Unable to save file.\n";
        exit;
    }else{
      echo $name;
    }

    // set proper permissions on the new file
    chmod(UPLOAD_DIR . $name, 0644);
}
