
do

--------------------------
local function clean_msg(extra, suc, result)
  for i=1, #result do
    delete_msg(result[i].id, ok_cb, false)
  end
  if tonumber(extra.con) == #result then
    send_msg(extra.chatid, ''..#result..' پیام اخیر گروه حذف شد', ok_cb, false)
  else
    send_msg(extra.chatid, 'Error Deleting messages', ok_cb, false)  
end 
end
-----------------------
function run(msg, matches) 
	 --------------------------
  if matches[1] == 'clean' and matches[2] == "msg" and is_momod(msg) or matches[1] == 'حذف' and matches[2] == "پیام ها" and is_momod(msg) or matches[1] == 'rm' and matches[2] == "sg" and is_momod(msg) then
    if msg.to.type == "user" then 
      return 
      end
    if msg.to.type == 'chat' then
      return  "Only in the Super Group" 
      end
    if not is_momod(msg) then 
      return "》You Are Not Allow To clean Msgs!\n》شما مدیر ربات نیستید"
      end
    if tonumber(matches[3]) > 200 or tonumber(matches[3]) < 1 then
      return "》maximum clean is 200\n》حداکثر تا 200 پیام قابل حذف است."
      end
   get_history(msg.to.peer_id, matches[3] + 1 , clean_msg , { chatid = msg.to.peer_id,con = matches[3]})
   end
  --------------------------
    if matches[1] == 'addplugin' and is_sudo(msg) then
        if not is_sudo(msg) then
           return "You Are Not Allow To Add Plugin"
           end
   name = matches[2]
   text = matches[3]
   file = io.open("./plugins/"..name, "w")
   file:write(text)
   file:flush()
   file:close()
   return "Add plugin successful "
end
------------------------
local receiver = get_receiver(msg)

------------------------
if matches[1] == "get" then 
    local file = matches[2] 
    if is_sudo(msg) or is_vip(msg) then 
      local receiver = get_receiver(msg) 
      send_document(receiver, "./plugins/"..file..".lua", ok_cb, false) 
    end 
  end 
------------------------
if matches[1] == "delplugin" and is_sudo(msg) then
	      if not is_sudo(msg) then 
             return "You Are Not Allow To Delete Plugins!"
             end 
        io.popen("cd plugins && rm "..matches[2]..".lua")
        return "Delete plugin successful "
     end
end
end

return {               
patterns = {
   "^[#!/]([Aa]ddplugin) (.+) (.*)$",
    "^[#!/]([Dd]l) ([Pp]lugin) (.*)$",
   "^[!#/]([Cc]lean) (msg) (%d*)$",
   "^[!#/](rm)(sg) (%d*)$",
   "^[!#/](حذف) (پیام ها) (%d*)$",
   "^[!#/]([Dd]elplugin) (.*)$",
 }, 
run = run,
}

--edited by @blackwolf_admin 
--Create by @solid021
--edit by @mrr619
-- channel @antispamandhack
