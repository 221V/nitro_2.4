-module(action_confirm).
-author('Rusty Klophaus').
-include_lib("nitro/include/nitro.hrl").
-compile([export_all, nowarn_export_all]).

render_action(#confirm{target=Control,text=Text,postback=Postback,delegate=Delegate}) -> 
    PostbackScript = wf_event:new(Postback, Control, Delegate, event, "[]", []),
    ["if (confirm(\"",nitro:js_escape(Text),"\")) {",PostbackScript,"}"].

