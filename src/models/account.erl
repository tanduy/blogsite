-module(account).

-compile(export_all).

relations() -> [{one_to_many, [entry]}].