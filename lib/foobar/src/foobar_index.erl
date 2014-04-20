-module(foobar_index).
-export([init/3, handle/2, terminate/3]).

init(_Type, Req0, State0) ->
		{ok, Req0, State0}.

handle(Req0, State0) ->
		{ok, Req1} = cowboy_req:reply(200, [], <<"Hello, World!">>, Req0),
		{ok, Req1, State0}.

terminate(_Reason, _Req, _State) ->
		ok.
