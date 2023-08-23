<?php
require_once(dirname(__FILE__).'/../xxx.xxx/include_app/config.php');
require_once(dirname(__FILE__).'/include_app/config.php');

$fileName = pathinfo(__FILE__, PATHINFO_FILENAME);
$pageTitle = "";
$displayPageType = 1;
$pageLangID = 1;

list($uaBrowserInfo, $viewDir) = getBrowserInfo($viewDir);

if (empty($_SERVER['HTTPS'])) {
  header("Location: https://{$_SERVER['HTTP_HOST']}{$_SERVER['REQUEST_URI']}");
  exit;
}

parse_str($_SERVER["QUERY_STRING"], $qs);
if (array_key_exists("pages", $qs) === false && count($qs) === 0) {
  $pages = "index";
} elseif (isset($_GET["pages"]) && $_GET["pages"] != "index" && preg_match('/^[a-zA-Z0-9_\-]*$/', $_GET["pages"])) {
  $pages = $qs["pages"];
} else {
  $pages = "";
}

if (isset($_GET["categoriesName"]) && $_GET["categoriesName"] != "" && preg_match('/^[a-zA-Z0-9_\-]*$/', $_GET["categoriesName"])) {
  $pagesCategory = $_GET["categoriesName"];
} else {
  $pagesCategory = "top";
}

$db = new dbc();
if (isset($_GET["preview"]) && (int)$_GET["preview"] === 1) {
  $getPagesSql = "SELECT * FROM pages INNER JOIN pagesCategories ON pages.pagesCategoriesID = pagesCategories.pagesCategoriesID WHERE name = ? AND categoriesName = ? AND type = ? AND langID = ?";
  $getPagesParam = array($pages, $pagesCategory, $displayPageType, 1);
} else {
  $getPagesSql = "SELECT * FROM pages INNER JOIN pagesCategories ON pages.pagesCategoriesID = pagesCategories.pagesCategoriesID WHERE name = ? AND categoriesName = ? AND status = ? AND type = ? AND langID = ?";
  $getPagesParam = array($pages, $pagesCategory, 1, $displayPageType, 1);
}
$result = $db->getRow($getPagesSql, $getPagesParam);
if (count($result) > 0) {
  foreach ($result as $row) {
    $pageTitle = $row["title"];
    $customHeader = $row["header"];
    $pagesContents = $row["contents"];
    $pagesPhpScript = $row["phpScript"];
    $pagesOgpDescription = $row["ogpDescription"];
    $pagesTopicPath = $row["topicPath"];
    $pagesCategoriesID = $row["pagesCategoriesID"];
    $categoriesName = $row["categoriesName"];
    $categoriesTitle = $row["categoriesTitle"];
    $pagesDescriptionFlag = (int)$row["pagesDescriptionFlag"];
    $pageLangID = (int)$row["langID"];
  }
} else {
  $pageTitle = "Not Found";
  $pagesContents = "<p>Not Found</p>\n<p><a href=\"/\">" . $siteName . " Front Page</a></p>\n";
  $pagesPhpScript = 0;
}

include_once($realPath.$viewDir."/".$fileName.$viewFileExt);
$db->disconnect();
