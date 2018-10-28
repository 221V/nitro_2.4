-module(element_fieldset).
-author('Vladimir Galunshchikov').
-include_lib("nitro/include/nitro.hrl").
-compile([export_all, nowarn_export_all]).

render_element(Record) ->
    List = [
      %global
      {<<"accesskey">>, Record#fieldset.accesskey},
      {<<"class">>, Record#fieldset.class},
      {<<"contenteditable">>, case Record#fieldset.contenteditable of true -> "true"; false -> "false"; _ -> undefined end},
      {<<"contextmenu">>, Record#fieldset.contextmenu},
      {<<"dir">>, case Record#fieldset.dir of "ltr" -> "ltr"; "rtl" -> "rtl"; "auto" -> "auto"; _ -> undefined end},
      {<<"draggable">>, case Record#fieldset.draggable of true -> "true"; false -> "false"; _ -> undefined end},
      {<<"dropzone">>, Record#fieldset.dropzone},
      {<<"hidden">>, case Record#fieldset.hidden of "hidden" -> "hidden"; _ -> undefined end},
      {<<"id">>, Record#fieldset.id},
      {<<"lang">>, Record#fieldset.lang},
      {<<"spellcheck">>, case Record#fieldset.spellcheck of true -> "true"; false -> "false"; _ -> undefined end},
      {<<"style">>, Record#fieldset.style},
      {<<"tabindex">>, Record#fieldset.tabindex},
      {<<"title">>, Record#fieldset.title},
      {<<"translate">>, case Record#fieldset.contenteditable of "yes" -> "yes"; "no" -> "no"; _ -> undefined end},      
      % spec
      {<<"disabled">>, if Record#fieldset.disabled == true -> "disabled"; true -> undefined end},
      {<<"form">>,Record#fieldset.form},
      {<<"name">>,Record#fieldset.name} | Record#fieldset.data_fields
    ],
    wf_tags:emit_tag(
      <<"fieldset">>,
      [
        case Record#fieldset.legend of 
          undefined -> [];
          B -> wf_tags:emit_tag(<<"legend">>, nitro:render(B), [])
        end, 
        nitro:render(case Record#fieldset.body of undefined -> []; B -> B end)
      ], 
      List).
