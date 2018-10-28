-module(action_event).
-author('Maxim Sokhatsky').
-author('Andrey Martemyanov').
-include_lib("nitro/include/nitro.hrl").
-compile([export_all, nowarn_export_all]).

-define(B(E), nitro:to_binary(E)).

render_action(#event{source=undefined}) -> [];
render_action(#event{postback=Postback,actions=_A,source=Source,target=Control,type=Type,delegate=D,validation=V}) ->
    E = ?B(Control),
    ValidationSource = [ S || S <- Source, not is_tuple(S) ],
    PostbackBin = wf_event:new(Postback, E, D, event, data(E,Source), ValidationSource, V),
    ["{var x=qi('",E,"'); x && x.addEventListener('",?B(Type),"',function (event){ ",PostbackBin,"});};"].

data(E,SourceList) ->
    Type=fun(A) when is_atom(A) -> [ "atom('",atom_to_list(A),"')" ]; (A) -> [ "utf8_toByteArray('",A,"')" ] end,
    list_to_binary(["[tuple(tuple(utf8_toByteArray('",E,"'),bin('detail')),[])",
        [ case S of {Id,Code} -> [ ",tuple(",Type(Id),",",Code,")" ];
                            _ -> [ ",tuple(",Type(S),",querySource('",?B(S),"'))" ]
          end || S <- SourceList ],"]"]).
