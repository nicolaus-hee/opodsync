{include file="_head.tpl"}

<p class="center" aria-hidden="true">
	<img src="icon.svg" width="150" />
</p>

<p class="center">
	<a href="login.php" class="btn">Login</a>
{if $canSubscribe}
	<a href="register.php" class="btn">Create account</a>
{/if}
</p>

{include file="_foot.tpl"}
