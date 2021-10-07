script_name="KK's Test"
script_description="自动添加code&template行、双语字幕校对及Test"
script_author="IKK"
script_version="alpha0.1"
au_return="\n\n+──────────+\n| Powered By IKK  |\n+──────────+\n|       2021.5.29      |\n+──────────+"

function NO(subs)
    local i=1
    while i<=#subs do
        local l=subs[i]
        if l.comment then
            subs.delete(i)
        else i=i+1
        end
    end
end




-- 自动添加自动化脚本行

function insert_auto_codeline(subs,sel)
        local l=subs[sel[1]]
        l.comment=true
        l.effect="code line"
        l.text=""
        l.start_time=0
        l.end_time=0
        subs[-sel[1]]=l
end

function insert_auto_codesyl(subs,sel)
        local l=subs[sel[1]]
        l.comment=true
        l.effect="code syl"
        l.text=""
        l.start_time=0
        l.end_time=0
        subs[-sel[1]]=l
end

function insert_auto_codeonce(subs,sel)
        local l=subs[sel[1]]
        l.comment=true
        l.effect="code once"
        l.text=""
        l.start_time=0
        l.end_time=0
        subs[-sel[1]]=l
end

function insert_auto_template_line(subs,sel)
        local l=subs[sel[1]]
        l.comment=true
        l.effect="template line"
        l.text=""
        l.start_time=0
        l.end_time=0
        subs[-sel[1]]=l
end

function insert_auto_template_noblank(subs,sel)
        local l=subs[sel[1]]
        l.comment=true
        l.effect="template noblank"
        l.text=""
        l.start_time=0
        l.end_time=0
        subs[-sel[1]]=l
end

function insert_auto_template_line_noblank_notext(subs,sel)
        local l=subs[sel[1]]
        l.comment=true
        l.effect="template line noblank notext"
        l.text=""
        l.start_time=0
        l.end_time=0
        subs[-sel[1]]=l
end

function insert_auto_template_char(subs,sel)
        local l=subs[sel[1]]
        l.comment=true
        l.effect="template char"
        l.text=""
        l.start_time=0
        l.end_time=0
        subs[-sel[1]]=l
end

-- 添加AutoTags函数 

function insert_autotags_0(subs,sel)
        local l=subs[sel[1]]
        l.comment=true
        l.effect="code once"
        l.text="function AutoTags(Intervalo,Dato1,Dato2)            local RESULTADO=\"\"     local SUERTE = 0     local CONTADOR = 0     local ARREGLO = 0                           local count = math.ceil(line.duration/Intervalo)                         ARREGLO = {Dato1,Dato2}                            for i = 1, count do               CONTADOR = i                            if Dato1 and Dato2 then                     if  CONTADOR%2 ==0 then                                    SUERTE = ARREGLO[1]                                            else                                    SUERTE = ARREGLO[2]                            end                    end                     RESULTADO = RESULTADO ..\"\\\\t(\" ..(i-1)*Intervalo.. \",\" ..i*Intervalo.. \",\\\\\" ..SUERTE..\")\"..\"\"                      end                 return RESULTADO                                     end"
        subs[-sel[1]]=l
end

function insert_autotags_1(subs,sel)
        local l=subs[sel[1]]
        l.comment=true
        l.effect="code once"
        l.text="function AutoTags1(Intervalo,Dato1,Dato2,Pause)  local RESULTADO=\"\"  local SUERTE = 0  local CONTADOR = 0  local ARREGLO = 0  local count = math.ceil(line.duration/(Intervalo+Pause))  ARREGLO = {Dato1,Dato2}  for i = 1, count do          CONTADOR = i          if Dato1 and Dato2 then                  if  CONTADOR%2 ==0 then                  SUERTE = ARREGLO[1]                  else                  SUERTE = ARREGLO[2]                  end          end          RESULTADO = RESULTADO ..\"\\\\t(\" ..(i-1)*(Intervalo+Pause).. \",\" ..i*Intervalo+Pause*(i-1).. \",\\\\\" ..SUERTE..\")\"..\"\"  end  return RESULTADO  end"
        subs[-sel[1]]=l
end

function insert_autotags_2(subs,sel)
        local l=subs[sel[1]]
        l.comment=true
        l.effect="code once"
        l.text="function AutoTags2(Intervalo,Dato1,Dato2,Delay)            local RESULTADO=\"\"     local SUERTE = 0     local CONTADOR = 0      local ARREGLO = Layer                            local count = math.ceil(line.duration/Intervalo)                                         ARREGLO = {Dato1,Dato2}                                          for i = 1, count do               CONTADOR = i                                            if Dato1 and Dato2 then                                             if  CONTADOR%2 ==0 then                                                                    SUERTE = ARREGLO[1]                                            else                                                                    SUERTE = ARREGLO[2]                                            end                            end                                                 RESULTADO = RESULTADO ..\"\\\\t(\" ..(i-1)*Intervalo+Delay.. \",\" ..i*Intervalo+Delay.. \",\\\\\" ..SUERTE.. \")\"..\"\"                                  end                              return RESULTADO                                             end"
        subs[-sel[1]]=l
end

function insert_autotags_3(subs,sel)
        local l=subs[sel[1]]
        l.comment=true
        l.effect="code once"
        l.text="function AutoTags3(Intervalo1,Intervalo2,Dato1,Dato2)  local RESULTADO=\"\"                 local SUERTE = 0                 local CONTADOR = 0                 local ARREGLO = 0                               local count = 2*math.ceil(line.duration/(Intervalo1+Intervalo2))            local d=math.ceil((Intervalo2-Intervalo1)/count)  local t={}  ARREGLO = {Dato1,Dato2}                                                      for i = 1, count do                                   CONTADOR = i  t[1]=0  t[i+1]=t[i]+Intervalo1+(i-1)*d  if Dato1 and Dato2 then            if  CONTADOR%2 ==0 then                                                                                        SUERTE = ARREGLO[1]            else                                                                                        SUERTE = ARREGLO[2]                                                        end            end                                                             RESULTADO = RESULTADO ..\"\\\\t(\" ..t[i].. \",\" ..t[i+1].. \",\\\\\" ..SUERTE..\")\"..\"\"                                              end                                          return RESULTADO                                                         end"
        subs[-sel[1]]=l
end

--添加Firstsyl
function insert_firstsyl(subs,sel)
        local l_1=subs[sel[1]]
        local l_2=subs[sel[1]]
        l_1.comment=true
        l_1.effect="code syl all"
        l_1.text="fxgroup.firstsyl = syl.i == 1"
        l_2.comment=true
        l_2.effect="template notext fxgroup firstsyl"
        l_2.text="{\\pos($x,$y)\\p1}"        
        subs[-sel[1]]=l_2
        subs[-sel[1]]=l_1
end

--添加计数器ci
function insert_ci(subs,sel)
        local l_1=subs[sel[1]]
        local l_2=subs[sel[1]]
        local l_3=subs[sel[1]]
        l_1.comment=true
        l_1.effect="code once"
        l_1.text="function char_counter(ref) ci[ref] = ci[ref] + 1; return \"\" end"
        l_2.comment=true
        l_2.effect="code line"
        l_2.text="ci = {0}; cn = _G.unicode.len(orgline.text_stripped:gsub(\" \",\"\"))"
        l_3.comment=true
        l_3.effect="template char"
        l_3.text="!char_counter(1)!!ci[1]!"                
        subs[-sel[1]]=l_3
        subs[-sel[1]]=l_2
        subs[-sel[1]]=l_1
end

--添加图形codeonce
function insert_shape_code_once(subs,sel)
        local l_1=subs[sel[1]]
        l_1.comment=true
        l_1.effect="code once"
        l_1.text="shape={\"\"}"             
        subs[-sel[1]]=l_1
end

--添加保留指定小数fix函数
function insert_number_fix(subs,sel)
        local l_1=subs[sel[1]]
        l_1.comment=true
        l_1.effect="code once"
        l_1.text="function fix(origin,count) a=origin*(10^count); a_j=a-math.modf(a); if math.abs(a_j)>=0.5 then num_out=math.modf(a+origin/math.abs(origin))/(10^count); else num_out=math.modf(a)/(10^count);end; return num_out; end;"             
        subs[-sel[1]]=l_1
end

--添加文字转图形
function insert_Yutils_text_to_shape(subs,sel)
        local l_1=subs[sel[1]]
        local l_2=subs[sel[1]]
        l_1.comment=true
        l_1.effect="code line"
        l_1.text="function shape() text = _G.decode.create_font(line.styleref.fontname, line.styleref.bold, line.styleref.italic, line.styleref.underline, line.styleref.strikeout, line.styleref.fontsize).text_to_shape(syl.text_stripped) text=string.gsub(text,\" c\",\"\") text=_G.Yutils.shape.filter(text, function(x,y) return math.round(x),math.round(y) end) return text end" 
        l_2.comment=true
        l_2.effect="template char notext"
        l_2.text="{\\p1\\pos($left,$top)\\an7}!shape()!"    
        subs[-sel[1]]=l_2
        subs[-sel[1]]=l_1
end


-- 以下为中日双语轴处理相关

jp_cn_config1=
  {

	[1]={class="label",x=0,y=0,label="输入普通日文轴的样式名"},
	[2]={class="textbox",name="日",x=0,y=1,width=1,height=1,items={},value="TEXT-JP",hint="日文轴样式"},
    [3]={class="label",x=0,y=2,label="输入普通中文轴的样式名"},
	[4]={class="textbox",name="中",x=0,y=3,width=1,height=1,items={},value="TEXT-CN",hint="中文轴样式"},
    [5]={class="label",x=0,y=4,label="输入日文轴-UP的样式名"},
	[6]={class="textbox",name="日上",x=0,y=5,width=1,height=1,items={},value="TEXT-JP-U",hint="日上轴样式"},
    [7]={class="label",x=0,y=6,label="输入中文轴-UP的样式名"},
	[8]={class="textbox",name="中上",x=0,y=7,width=1,height=1,items={},value="TEXT-CN-U",hint="中上轴样式"},

  }


function check_jp_cn(subs)  --检查中日匹配
    buttons,results =aegisub.dialog.display(jp_cn_config1,{"OK","Cancel"})
    if buttons=="OK" then
        local i=1
        local jp_lines_num={}
        local cn_lines_num={}
        local jp_up_lines_num={}
        local cn_up_lines_num={}

        local jpcnt=0
        local cncnt=0
        local jpupcnt=0
        local cnupcnt=0

        local jp_lines_time_start={}
        local cn_lines_time_start={}
        local jp_up_lines_time_start={}
        local cn_up_lines_time_start={}

        local jp_lines_time_end={}
        local cn_lines_time_end={}
        local jp_up_lines_time_end={}
        local cn_up_lines_time_end={}

        local jp_style = results["日"]
        local cn_style = results["中"]
        local jp_up_style = results["日上"]
        local cn_up_style = results["中上"] 
        for i=1,#subs do
            local l=subs[i]
            if l.style==jp_style --处理JP轴
            then
                table.insert(jp_lines_num, i)
                jpcnt=jpcnt+1
                jp_lines_time_start[jpcnt]=l.start_time
                jp_lines_time_end[jpcnt]=l.end_time                
            elseif l.style==cn_style --处理CN轴
            then
                table.insert(cn_lines_num, i)
                cncnt=cncnt+1
                cn_lines_time_start[cncnt]=l.start_time
                cn_lines_time_end[cncnt]=l.end_time                                  
            elseif l.style==jp_up_style --处理JP-UP轴
            then
                table.insert(jp_up_lines_num, i)
                jpupcnt=jpupcnt+1          
                jp_up_lines_time_start[jpupcnt]=l.start_time
                jp_up_lines_time_end[jpupcnt]=l.end_time                                 
            elseif l.style==cn_up_style --处理CN-UP轴
            then
                table.insert(cn_up_lines_num, i)
                cnupcnt=cnupcnt+1       
                cn_up_lines_time_start[cnupcnt]=l.start_time
                cn_up_lines_time_end[cnupcnt]=l.end_time                                        
            end
        end
        -- 数量比对
        if jpcnt==cncnt and jpupcnt==cnupcnt 
        then
            aegisub.debug.out("中日轴数量相符，")
                                    -- 如果数量一致，则进行时间对比
                                    local lp=1
                                    local wrongtimecnt=0
                                    local wrongtimesel={}
                                    for lp=1,jpcnt do
                                        if jp_lines_time_start[lp]~=cn_lines_time_start[lp] or jp_lines_time_end[lp]~=cn_lines_time_end[lp]
                                        then
                                            wrongtimecnt=wrongtimecnt+1
                                            table.insert(wrongtimesel,jp_lines_num[lp])
                                        end
                                    end
                                    local lp=1
                                    for lp=1,jpupcnt do
                                        if jp_up_lines_time_start[lp]~=cn_up_lines_time_start[lp] or jp_up_lines_time_end[lp]~=cn_up_lines_time_end[lp]
                                        then
                                            wrongtimecnt=wrongtimecnt+1
                                            table.insert(wrongtimesel,jp_up_lines_num[lp])
                                        end
                                    end
                                    if wrongtimecnt==0 
                                    then
                                        aegisub.debug.out("且时间均匹配。"..au_return)
                                    else
                                        -- 给时间错误的行打上actor
                                        local i=1
                                        for i=1, wrongtimecnt do
                                            local tempnum=wrongtimesel[i]
                                            local tempsub=subs[tempnum]
                                            tempsub.actor="此行时间有误["..tostring(i).."/"..tostring(wrongtimecnt).."]"
                                            subs.delete(tempnum)
                                            subs[-tempnum]=tempsub
                                        end
                                        aegisub.debug.out("但有"..tostring(wrongtimecnt).."句时间不匹配。已自动选择并标出错误的日文轴\n按照先普通轴后UP轴的顺序检索，错误标号可能不连续。\n")
                                        aegisub.debug.out(au_return)                                        
                                        return wrongtimesel
                                    end

    



        else
            aegisub.debug.out("【警告！！】中日轴数量不相符。\n共发现日文轴"..tostring(jpcnt).."行，")
            aegisub.debug.out("中文轴"..tostring(cncnt).."行；\n")
            aegisub.debug.out("日UP轴"..tostring(jpupcnt).."行，")
            aegisub.debug.out("中UP轴"..tostring(cnupcnt).."行。\n\n")
            aegisub.debug.out(au_return)            
        end
    end
end



function cover_cn_by_jp(subs)  --日语轴样式和时间覆盖中文轴
    buttons,results =aegisub.dialog.display(jp_cn_config1,{"OK","Cancel"})
    if buttons=="OK" then
        local i=1
        local jp_lines_num={}
        local cn_lines_num={}
        local jp_up_lines_num={}

        local jpcnt=0
        local cncnt=0
        local jpupcnt=0

        local jp_lines_time_start={}
        local jp_up_lines_time_start={}
        local jp_lines_time_end={}
        local jp_up_lines_time_end={}

        local jp_style = results["日"]
        local cn_style = results["中"]
        local jp_up_style = results["日上"]
        local cn_up_style = results["中上"] 

        local styles={} -- 0 for normal, 1 for up
        local cntalljp=0

        for i=1,#subs do
            local l=subs[i]
            if l.style==jp_style --处理JP轴
            then
                table.insert(jp_lines_num, i)
                jpcnt=jpcnt+1
                jp_lines_time_start[jpcnt]=l.start_time
                jp_lines_time_end[jpcnt]=l.end_time
                cntalljp=cntalljp+1
                styles[cntalljp]=0
            elseif l.style==jp_up_style --处理JP-UP轴
            then
                table.insert(jp_up_lines_num, i)
                jpupcnt=jpupcnt+1          
                jp_up_lines_time_start[jpupcnt]=l.start_time
                jp_up_lines_time_end[jpupcnt]=l.end_time  
                cntalljp=cntalljp+1
                styles[cntalljp]=1                              
            elseif l.style==cn_style --处理CN轴
            then
                table.insert(cn_lines_num, i)
                cncnt=cncnt+1
            end
        end

        --数量比对
        if jpcnt+jpupcnt==cncnt
        then aegisub.debug.out("中日轴数量相符，")
            -- 如果数量一致，则进行样式和时间的覆盖
            -- 处理轴
            local i=1
            local jp=0
            local jp_up=0
            for i=1, cntalljp do
                if styles[i]==0 then
                    jp=jp+1
                    local jptmpnum=jp_lines_num[jp]
                    local cntmpnum=cn_lines_num[i]
                    local tmp_cn_sub=subs[cntmpnum]
                    tmp_cn_sub.start_time=jp_lines_time_start[jp]
                    tmp_cn_sub.end_time=jp_lines_time_end[jp]
                    tmp_cn_sub.style=cn_style
                    tmp_cn_sub.layer=1
                    subs.delete(cntmpnum)
                    subs[-cntmpnum]=tmp_cn_sub
                else
                    jp_up=jp_up+1
                    local jptmpnum=jp_lines_num[jp_up]
                    local cntmpnum=cn_lines_num[i]
                    local tmp_cn_sub=subs[cntmpnum]
                    tmp_cn_sub.start_time=jp_up_lines_time_start[jp_up]
                    tmp_cn_sub.end_time=jp_up_lines_time_end[jp_up]
                    tmp_cn_sub.style=cn_up_style
                    tmp_cn_sub.layer=1
                    subs.delete(cntmpnum)
                    subs[-cntmpnum]=tmp_cn_sub  
                end                  
            end

            aegisub.debug.out("处理完成。共覆盖了"..tostring(cntalljp).."句字幕。")
            aegisub.debug.out(au_return)
        else
            aegisub.debug.out("中日字幕数量不匹配，请检查。\n注意：应用此脚本时，所有的中文字幕都应当被设置为默认格式（例如所有中文都是\"TEXT-CN\"样式），而不应有\"TEXT-CN-U\"格式出现。")
            aegisub.debug.out(au_return)
        end
    end
end
















aegisub.register_macro(script_name.."/去注释","删除所有的注释行",NO)
aegisub.register_macro("Kamigami/日文轴覆盖中文轴","Kamigami JP&CN",cover_cn_by_jp)
aegisub.register_macro("Kamigami/检查中日匹配","Kamigami JP&CN",check_jp_cn)
aegisub.register_macro("Auto Template/code line","添加code line",insert_auto_codeline)
aegisub.register_macro("Auto Template/code syl","添加code syl",insert_auto_codesyl)
aegisub.register_macro("Auto Template/code once","添加code once",insert_auto_codeonce)
aegisub.register_macro("Auto Template/template line","添加template line",insert_auto_template_line)
aegisub.register_macro("Auto Template/template char","添加template char",insert_auto_template_char)
aegisub.register_macro("Auto Template/template noblank","添加template noblank",insert_auto_template_noblank)
aegisub.register_macro("Auto Template/template line noblank notext","添加template line noblank notext",insert_auto_template_line_noblank_notext)
aegisub.register_macro("Auto Template/FirstSyl","添加FirstSyl和对应Template",insert_firstsyl)
aegisub.register_macro("Auto Template/Counter:ci","添加计数器ci和对应Template",insert_ci)
aegisub.register_macro("Auto Template/Shape","添加Shape",insert_shape_code_once)
aegisub.register_macro("Auto Template/Fix","添加fix函数",insert_number_fix)
aegisub.register_macro("Auto Template/Text to Shape","文字转图形",insert_Yutils_text_to_shape)
aegisub.register_macro("Auto Template/AutoTags/原版","原始Autotags",insert_autotags_0)
aegisub.register_macro("Auto Template/AutoTags/Pause","Pause",insert_autotags_1)
aegisub.register_macro("Auto Template/AutoTags/Delay","Delay",insert_autotags_2)
aegisub.register_macro("Auto Template/AutoTags/AP","AP",insert_autotags_3)