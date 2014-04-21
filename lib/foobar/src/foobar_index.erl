-module(foobar_index).
-export([init/3, handle/2, terminate/3]).

init(_Type, Req0, State0) ->
		{Bindings, Req1} = cowboy_req:bindings(Req0),
		{QsVals, Req2} = cowboy_req:qs_vals(Req1),
		State1 = State0 ++ Bindings ++ QsVals,
		{ok, Req2, State1}.

handle(Req0, State0) ->
		{ok, Html} = foobar_index_dtl:render(State0),
		{ok, Req1} = cowboy_req:reply(200, [{<<"document-type">>, <<"text/html">>}], Html, Req0),
		{ok, Req1, State0}.

terminate(_Reason, _Req, _State) ->
		ok.
