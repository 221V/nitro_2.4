-module(element_radio).
-author('Rusty Klophaus').
-include_lib("nitro/include/nitro.hrl").
-compile([export_all, nowarn_export_all]).

render_element(Record) ->
    ID = case Record#radio.id of
        undefined -> nitro:temp_id();
        RadioID -> RadioID
    end,

    case Record#radio.postback of
        undefined -> ignore;
        Postback -> nitro:wire(#event{type=change, postback=Postback, target=ID, delegate=Record#radio.delegate })
    end,

    Content = nitro:render(Record#radio.body),
    TypeChecked = case Record#radio.checked of
         true -> [{<<"checked">>, <<"">>},{<<"type">>, <<"radio">>}];
            _ -> [{<<"type">>, <<"radio">>}] end ++ case Record#radio.disabled of
         true -> [{<<"disabled">>, <<"disabled">>}];
            _ -> [] end,

    [
        wf_tags:emit_tag(<<"input">>, Content, TypeChecked ++ [
            {<<"id">>, ID},
            {<<"value">>, Record#radio.value},
            {<<"name">>, nitro:coalesce([Record#radio.html_name,Record#radio.name])},
            {<<"class">>, Record#radio.class},
            {<<"style">>, Record#radio.style},
            {<<"onclick">>, Record#radio.onclick},
            {<<"required">>,if Record#radio.required == true -> "required"; true -> undefined end}
        ])

    ].
