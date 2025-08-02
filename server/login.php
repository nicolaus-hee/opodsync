<?php

namespace OPodSync;

require_once __DIR__ . '/_inc.php';

if (isset($_GET['logout'])) {
	$gpodder->logout();
	header('Location: ./');
	exit;
}

$token = isset($_GET['token']) ? '?oktoken' : '';

$error = null;
if (!empty($_POST)) {
	if ($gpodder->requireCaptchaAtLogin() && !$gpodder->checkCaptcha($_POST['captcha'] ?? '', $_POST['cc'] ?? '')) {
		$error = 'Invalid captcha';
	} else {
		$error = $gpodder->login();	
	}
	if ($error) {
		http_response_code(401);
	}
}

if ($gpodder->isLogged()) {
	header('Location: ./' . $token);
	exit;
}

$token = isset($_GET['token']) ? true : false;

$captcha = $gpodder->requireCaptchaAtLogin() ? $gpodder->generateCaptcha() : null;

$tpl->assign(compact('error', 'token', 'captcha'));
$tpl->display('login.tpl');
?>