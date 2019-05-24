<!DOCTYPE html>
<html lang="<?php echo $langID[$pageLangID]; ?>">
<head>
<meta charset="UTF-8">
<?php
if ($_SERVER["SCRIPT_NAME"] === "/news.php") {
  $categoryName = " - News";
} elseif (isset($categoriesName) && $categoriesName !== "top" && $categoriesName !== "") {
  $categoryName = " - " . $categoriesTitle;
} else {
  $categoryName = "";
}
?>
<title><?php echo $pageTitle . $categoryName . ": " . $siteName; ?></title>
<meta name="viewport" content="width=device-width">
<meta name="format-detection" content="telephone=no">
<meta property="og:type" content="website">
<meta property="og:title" content="<?php echo $pageTitle . ": " . $siteName; ?>">
<meta property="og:url" content="https://www.xxx.xxx<?php echo $_SERVER["REQUEST_URI"]; ?>">
<?php
  if (isset($pagesOgpDescription) && $pagesOgpDescription != "") {
    echo "<meta property=\"og:description\" content=\"" . $pagesOgpDescription . "\">\n";
  } else {
    echo "<meta property=\"og:description\" content=\"" . $description . "\">\n";
  }
?>
<meta property="og:image" content="https://www.xxx.xxx/view/images/ogp.png">
<meta property="og:site_name" content="<?php echo htmlspecialchars($siteName, ENT_QUOTES, 'UTF-8'); ?>">
<meta name="twitter:card" content="summary">
<link rel="stylesheet" href="/<?php echo $viewPath; ?>/css/common.css" media="all">
<?php if ($_SERVER['SCRIPT_NAME'] === "/contact.php") { ?><link rel="stylesheet" href="/<?php echo $viewPath; ?>/css/style.css" media="all"><?php } ?>
<?php if ($_SERVER["SERVER_NAME"] === "xxx.xxx" || $_SERVER["SERVER_NAME"] === "www.xxx.xxx") {?>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=xxxxxx"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'xxxxxx');
</script>
<?php }
if ($customHeader != null || $customHeader != "") { echo $customHeader."\n"; } ?>
</head>
<body>
<?php if ($backUrlReferer == true ) {
	$backUrl = $_SESSION['refererUrl'];
} else {
	$backUrl = "http://" . $_SERVER['SERVER_NAME'] . "/";
}
?>
<header>
<?php if (isset($pagesDescriptionFlag) && $pagesDescriptionFlag > 0) { ?>
  <div id="headerUpper">
    <div id="headerUpperInner">
      <p><?php echo $description; ?></p>
      <!-- /#headerUpper --></div>
    <!-- /#headerUpperInner --></div>
<?php } ?>
  <div id="headerUnder">
    <div id="headerUnderInner">
      <h1><a href="<?php echo $backUrl; ?>"><img src="/<?php echo $viewPath; ?>/images/logo.svg" alt="<?php echo $siteName; ?>" width="220"></a></h1>
      <!-- /#headerUnderInner --></div>
  <!-- /#headerUnder --></div>
</header>
<div id="contents">
<?php
  if (isset($pagesTopicPath) && (int)$pagesTopicPath === 1) {
    if (isset($pagesCategoriesID) && (int)$pagesCategoriesID === 1) {
      echo "<p class=\"topicPath\"><a href=\"/\">" . $siteName . "</a>&nbsp;&gt;&nbsp;" . $pageTitle . "</p>\n";
    } else {
      echo "<p class=\"topicPath\"><a href=\"/\">" . $siteName . "</a>&nbsp;&gt;&nbsp;<a href=\"/" . $categoriesName . ".html\">" . $categoriesTitle . "</a>&nbsp;&gt;&nbsp;" . $pageTitle . "</p>\n";
    }
  }
?>