-module(web_register).

-compile(export_all).

-include_lib("nitrogen/include/wf.inc").

main() ->
	#template{file = "./wwwroot/template.html"}.

css() -> "<link rel = 'stylesheet' href = '/css/account.css' type = 'text/css' media = 'screen' charset = 'utf-8'>".

body() ->
	Body = [
		  #panel{
				  	class = "info",
					body = [#br{},"Register for this blog site."]
				},
		  #panel{
				 	class = "register",
				 	body = [
						#label {text = "Username"},
						#textbox {id = "txb_username", class = "inp" },
						#label {text = "Email"},
						#textbox {id = "txb_email", class = "inp"},
						#br{}, #br{},
						#label{ 
								class = "info",
								text = "A password will be emailed to you."
						},
						#button{
							id = "btn_register", 
							class = "submit", 
							text = "Register", 
							postback = register
						}
					]
				},
		  #link {class = "login", text = "Login", url = "/web_login"}, " | ",
		  #link {text = "Lost your password?", url = "/web_lostpass"}
	],
	wf:wire(btn_register, txb_username, #validate {validators = [
		#is_required {text = "Username is required."}]}),
	wf:wire(btn_register, txb_email, #validate {validators = [
		#is_required {text = "Required." },
		#is_email {text = "Enter a valid email address."}]}),
	wf:render(Body).

event(register) ->
	[Username] = wf:q(txb_username),
    [Email] = wf:q(txb_email),
	case account:find({username, '=', Username}) of
		[] ->
			case account:find({email, '=', Email}) of
				[] ->
					Password = random_password(Username),
					account:insert(account:new_with([
						{username, Username},
						{password, encrypt_password(Password)},
						{nicename, Username},
						{email,    Email}
					])),
					wf:redirect("/login?register=true"),
					wf:flash("register successful, check email to get password.");
				true ->
					wf:flash("Email exists")
			end;
		true ->
			wf:flash("Username" ++ wf:html_encode(Username) ++ " exist")
	end,
    ok.

random_password(Prex) ->
	{_, _, C} = now(),
	Prex ++ integer_to_list(C).

encrypt_password(Str) ->
	Md5 = erlang:md5(Str),
	Base64 = base64:encode_to_string(Md5),
	Base64.
