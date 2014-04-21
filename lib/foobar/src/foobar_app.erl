-module(foobar_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1, routes/0]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
		R = cowboy_router:compile(routes()),
		cowboy:start_http(foobar, 100, [{port, 8080}], [{env, [{dispatch, R}]}]),
    foobar_sup:start_link().

stop(_State) ->
		cowboy:stop(foobar),
    ok.

routes() ->
		[{'_', 			
			[{<<"/static/[...]">>, cowboy_static, {dir, "assets"}},
			 {<<"/:who">>, foobar_index, [{<<"what">>, <<"fsck">>}]}]}].
