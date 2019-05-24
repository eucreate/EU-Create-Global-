<?php include_once($realPath. "include_file/header.tpl");
echo readContents($pagesContents, $pagesPhpScript, $realPath, $viewPath);
include_once($realPath. "include_file/footer.tpl");