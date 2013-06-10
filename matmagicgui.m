function matmagicgui
f=figure('visible','off','color','white','position',[400,400,600,450]);
set(f,'name','Matrix Operations')
movegui(f,'center')

data=zeros(3,3);
myt=uitable('Data',data,'Position',[150,350,300,75],'ColumnWidth',{85},'ColumnEditable',[true true true]);

hbutton=uicontrol('style','pushbutton','string','Push for matrix operation','position',[400,50,150,25],'callback',@cbfn);

set(f,'visible','on')

function cbfn(source,eventdata)
set([myt hbutton],'visible','off')
    
editdata=get(myt,'data');
editdata=editdata+randi([1 10]);

htext=uicontrol('style','text','backgroundcolor','white','position',[200,275,200,25],'string','Matrix with a Random Integer Added');

myta=uitable('Data',editdata,'Position',[150,200,300,75],'ColumnWidth',{85},'ColumnEditable',[true true true]);
set([myt myta hbutton htext],'visible','on')
end

end