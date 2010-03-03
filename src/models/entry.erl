-module(entry).

-compile(export_all).

relations() -> [{many_to_one, [account]}].
