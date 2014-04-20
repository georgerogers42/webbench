-module(foobar_index).
-export([init/3, handle/2, terminate/3]).

init(_Type, Req0, State0) ->
		State1 = dict:new(State0),
		{ok, Req0, State1}.

handle(Req0, State0) ->
		{ok, Who} = State0:find(<<"who">>),
		{ok, Req1} = cowboy_req:reply(200, [], [<<"Hello, ">>, Who] , Req0),
		{ok, Req1, State0}.

terminate(_Reason, _Req, _State) ->
		ok.
