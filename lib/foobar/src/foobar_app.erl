-module(foobar_app).

-behaviour(application).

%% Application callbacks
-export([start/0, start/2, stop/1, routes/0, port/0]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start() ->
    application:ensure_all_started(foobar).

start(_StartType, _StartArgs) ->
		R = cowboy_router:compile(routes()),
    Port = port(),
		cowboy:start_http(foobar, 100, [{port, Port}], [{env, [{dispatch, R}]}]),
    foobar_sup:start_link().

stop(_State) ->
		cowboy:stop(foobar),
    ok.

routes() ->
		[{'_', 			
			[{<<"/static/[...]">>, cowboy_static, {priv_dir, foobar, "assets"}},
			 {<<"/:who">>, foobar_index, [{<<"what">>, <<"fsck">>}]},
       {<<"/">>, foobar_index, [{<<"what">>, <<"fsck">>}, {who, <<"George">>}]}]}].

port() ->
    case os:getenv("PORT") of
      X when is_list(X) -> list_to_integer(X);
      X when is_binary(X) -> binary_to_integer(X);
      _X -> 8080
    end.
