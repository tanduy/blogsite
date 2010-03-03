-module(web_lostpass).

-compile(export_all).

-include_lib("nitrogen/include/wf.inc").

main() ->
	#template{file = "./wwwroot/template.html"}.

css() -> "<link rel = 'stylesheet' href = '/css/account.css' type = 'text/css' media = 'screen' charset = 'utf-8'>".


body() ->
	Body=[
		#panel {
			class = "info",
			body = "Please enter your username or email address. You will receive a new password via email."
		},
		#panel {
			class = "register",
			body = [
				#label {text = "Username or Email"},
				#textbox {id = "txb_username_email", class="inp" },
				#br{},
				#button {
					id = "btn_newpass", 
					class = "submit", 
					text = "Get New Password", 
					postback = getnewpass
				}
			]
		},
		#link {class = "login", text = "Login", url = "/web_login"}, " | ",
		#link {text = "Register", url = "/web_register"}
	],
	wf:wire(btn_newpass, txb_username_email, #validate {validators=[
			#is_required { text = "Required." }]}),
	wf:render(Body).

event(getnewpass) ->
	[UsrEmail] = wf:q(txb_username_email),
	RecUsrs = account:find({username, '=', UsrEmail}, 'or', {email, '=', UsrEmail}),
	case (RecUsrs) of
		[] ->
		  	wf:flash("Username or Email is not exist.");
	  	true ->
			%% must implement functions send new password to user's email.
			wf:flash("Check email to get new password.")
	end,
    ok.
