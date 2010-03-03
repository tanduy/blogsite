{application, psql, [
    {description, "psql application"},
    {vsn, "0.0.2"},
    {modules, []},
    {registered, [psql_sup]},
    {applications, [kernel, stdlib]},
    {mod, {psql, []}},
    {env, [
        {erlydb_psql, {"localhost", 5432, "postgres", "postgres", "blogdb"}},
        {pools, [{erlydb_psql, 1}]}
    ]}
]}.
