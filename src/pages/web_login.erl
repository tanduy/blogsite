-module(web_login).

-compile(export_all).

-include_lib("nitrogen/include/wf.inc").

main() ->#template{file = "./wwwroot/template.html"}.
css() -> "<link rel = 'stylesheet' href = '/css/account.css' type = 'text/css' media = 'screen' charset = 'utf-8'>".

body() ->
	Body = [	
		#panel{
			class = "info",
			id = "info",
			body = [#br{},getTitle()]
		},
		#panel{
			class = "login",
			body = [
				#label {text = "Username"},
				#textbox {id = "txb_username", class = "inp" },
				#label {text = "Password"},
				#password {id = "txb_password", class = "inp"},
				#br{}, #br{},
				#checkbox {id = "ckb_remember", class = "info", text = "Remember Me"},
				#button {id = "btn_login", class = "submit", text = "Log In", postback = login}
			]
		},
		#link {class = "register", text = "Register", url = "/web_register"}, " | ",
		#link {text = "Lost your password?", url = "/web_lostpass"}
	],
	wf:wire(btn_login, txb_username, #validate{
		validators = [#is_required{text = "Username is required."}]
	}),
	wf:wire(btn_login, txb_password, #validate{
		validators = [#is_required{text = "Password is required."}]
	}),
	wf:render(Body).

event(login) ->
	[Username] = wf:q(txb_username),
	[Password] = wf:q(txb_password),
	Recs = account:find({{username, '=', Username}, 'and', {password, '=', Password}}),
	case (Recs) of
		[] ->
			wf:flash("Login fail.");
		[_] ->
			wf:flash("Login successful.")
	end,
    ok.

getTitle()->
	case (wf:q("register")) of
		[] -> "Login for blog site";
		_ -> "Register successful, check email to get password"
	end.
	
	
