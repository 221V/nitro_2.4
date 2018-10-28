-module(element_time).
-author('Vladimir Galunshchikov').
-include_lib("nitro/include/nitro.hrl").
-compile([export_all, nowarn_export_all]).

render_element(Record) ->
    List = [
      %global
      {<<"accesskey">>, Record#time.accesskey},
      {<<"class">>, Record#time.class},
      {<<"contenteditable">>, case Record#time.contenteditable of true -> "true"; false -> "false"; _ -> undefined end},
      {<<"contextmenu">>, Record#time.contextmenu},
      {<<"dir">>, case Record#time.dir of "ltr" -> "ltr"; "rtl" -> "rtl"; "auto" -> "auto"; _ -> undefined end},
      {<<"draggable">>, case Record#time.draggable of true -> "true"; false -> "false"; _ -> undefined end},
      {<<"dropzone">>, Record#time.dropzone},
      {<<"hidden">>, case Record#time.hidden of "hidden" -> "hidden"; _ -> undefined end},
      {<<"id">>, Record#time.id},
      {<<"lang">>, Record#time.lang},
      {<<"spellcheck">>, case Record#time.spellcheck of true -> "true"; false -> "false"; _ -> undefined end},
      {<<"style">>, Record#time.style},
      {<<"tabindex">>, Record#time.tabindex},
      {<<"title">>, Record#time.title},
      {<<"translate">>, case Record#time.contenteditable of "yes" -> "yes"; "no" -> "no"; _ -> undefined end},      
      % spec
      {<<"datetime">>,Record#time.datetime} | Record#time.data_fields
    ],
    wf_tags:emit_tag(<<"time">>, nitro:render(Record#time.body), List).
