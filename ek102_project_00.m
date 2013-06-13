%{ 
EK102: Final Project - [Title Here]

Group Members: 
Jacob Janco, J. Vandame, Michael Webster, Trent Merrell, Stan Ng
%}

% MAIN FUNCTION
function ek102_project_00

% Global & Default Variables, Preallocation Block
% Preallocation of Steps...500 steps, dynamic allocation after
global ctrack
ctrack=0;

global ROWS
global COLUMNS

ROWS = 3; 
COLUMNS = 3;

data_in = zeros( 3, 3 );

% GUI Element block
f = figure;
set( f,...
    'Visible', 'off',...
    'MenuBar', 'none',...
    'Units', 'Pixels',...
    'NumberTitle','off',...
    'Name','EK 102 Final Project',...
    'Position', [ 0 0 1000 550 ],...
    'Color', [ 0.8 0.8 0.8 ],...
    'InvertHardCopy', 'off' );

row_box_name = uicontrol(...
    'Style', 'text',...
    'String', 'Number of Rows',...
    'Background',[ 0.8 0.8 0.8 ],...
    'Position', [ 750, 490, 100, 25 ] );

col_box_name = uicontrol(...
    'Style', 'text',...
    'String', 'Number of Columns',...
    'Background',[ 0.8 0.8 0.8 ],...
    'Position', [ 875, 490, 100, 25 ] );

row_box = uicontrol( ...
    'Style', 'edit',...
    'Background', 'White',...
    'Position', [ 750, 450, 100, 50 ] );

col_box = uicontrol(...
    'Style', 'edit',...
    'Background', 'White',...
    'Position', [ 875, 450, 100, 50 ] );

rxc_button = uicontrol(...
    'Style', 'pushbutton',...
    'String' , 'Set Rows and Columns',...
    'Position', [ 750, 400, 125, 25 ],...
    'CallBack', @cb_rxc_button );

entry_table_text = uicontrol(...
    'Style', 'text',...
    'String', 'Enter Values Here',...
    'Background',[ 0.8 0.8 0.8 ],...
    'FontSize',14,...
    'Position', [ 50, 500, 300, 25 ] );

output_table_text = uicontrol(...
    'Style', 'text',...
    'String', 'Output Matrix',...
    'Background',[ 0.8 0.8 0.8 ],...
    'FontSize',14,...
    'Position', [ 375, 500, 300, 25 ] );

entry_table = uitable(...
    'Data', data_in,...
    'Position', [ 50, 300, 300, 200],...
    'ColumnWidth', {87},...
    'ColumnEditable', [ true true true ] );

output_table = uitable(...
    'Data', data_in,...
    'Position', [ 375, 300 300, 200],...
    'ColumnWidth', {87} );
   
mock_cout = uicontrol(...
    'Style', 'edit',...
    'Enable', 'inactive',...
    'Max', 2,...
    'Background', 'White',...
    'Position', [ 50, 75, 300, 200 ] );

explain_out = uicontrol(...
    'Style', 'edit',...
    'Enable', 'inactive',...
    'Max', 2,...
    'Background', 'White',...
    'Position', [ 375, 75, 300, 200 ] );

% Operation Block
op00 = uicontrol(...
    'Style', 'pushbutton',...
    'String' , 'op00',...
    'Position', [ 750, 350, 75, 25 ],...
    'CallBack', @cb_op00);

op01 = uicontrol(...
    'Style', 'pushbutton',...
    'String' , 'op01',...
    'Position', [ 750, 300, 75, 25 ],...
    'CallBack', @cb_op01);

op02 = uicontrol(...
    'Style', 'pushbutton',...
    'String' , 'op02',...
    'Position', [ 750, 250, 75, 25 ],...
    'CallBack', @cb_op02);

%Step showing
stepback = uicontrol(...
    'Style', 'pushbutton',...
    'String' , 'Previous',...
    'Position', [ 50, 25, 75, 25 ],...
    'CallBack', @previousshow);

stepforward = uicontrol(...
    'Style', 'pushbutton',...
    'String' , 'Next',...
    'Position', [ 275, 25, 75, 25 ],...
    'CallBack', @forwardshow);

resetstep = uicontrol(...
    'Style', 'pushbutton',...
    'String' , 'Reset',...
    'Position', [ 162, 25, 75, 25 ],...
    'CallBack', @resetshow);

movegui(f, 'center')
set(f,'visible', 'on') 

function cb_rxc_button( ~, ~ )
    set ( entry_table, 'Visible', 'off' ) 

    ROWS = str2double( get( row_box, 'String' ) );
    COLUMNS = str2double( get( col_box, 'String' ) );

    data_in = zeros( ROWS, COLUMNS );

    col_edit_string = true( 1, COLUMNS );
    
    %Dynamic column resizing depending on the number of columns
    setwidth=ceil(260/COLUMNS);

    set( entry_table,...
        'ColumnEditable', col_edit_string,...
        'Data', data_in,...
        'ColumnWidth', {setwidth},...
        'Visible', 'on' );
    
    set( output_table,...
        'ColumnEditable', col_edit_string,...
        'Data', data_in,...
        'ColumnWidth', {setwidth},...
        'Visible', 'on' );
end

function forwardshow(~,~)
    
    showstepmat=get(entry_table,'Data');
    outmat=get(output_table,'Data');
    
    set (mock_cout, 'Visible', 'off');
    
    if ctrack>=1 && ctrack<=numel(showstepmat)
        showstepmat=showstepmat';
        outmat=outmat';
        showstepmat(1:ctrack)=outmat(1:ctrack);
        showstepmat=showstepmat';

        ctrack=ctrack+1;

        set( mock_cout,'String', num2str(showstepmat));
    elseif ctrack>numel(showstepmat)
        ctrack=numel(showstepmat);
    else
        ctrack=1;
        set( mock_cout,'String', num2str(showstepmat));
    end
    
	set( mock_cout,'Visible', 'on' ); 

end

function previousshow(~,~)

    showstepmat=get(entry_table,'Data');
    outmat=get(output_table,'Data');
    
    set (mock_cout, 'Visible', 'off');
    
    if ctrack>=1 && ctrack<=numel(showstepmat)
        showstepmat=showstepmat';
        outmat=outmat';
        showstepmat(1:ctrack)=outmat(1:ctrack);
        showstepmat=showstepmat';

        ctrack=ctrack-1;

        set( mock_cout,'String', num2str(showstepmat));
	elseif ctrack>numel(showstepmat)
        ctrack=numel(showstepmat);
    else
        ctrack=0;
        set( mock_cout,'String', num2str(showstepmat));
    end
    
    set( mock_cout,'Visible', 'on' ); 

end

function resetshow(~,~)

	ctrack=1;

    set (mock_cout, 'Visible', 'off');
    
    showstepmat=get(entry_table,'Data');
    
    set( mock_cout, ...
        'String', num2str(showstepmat),...
        'Visible', 'on' ); 
end

function cb_op00( ~, ~ )
    set ( output_table, 'Visible', 'off' ); 
    set ( mock_cout, 'Visible', 'off' );

    % Start operation (Required: op_data, STEP_CELL_ARRAY)

    %{
    Ok quick explanation...
    temp_mat is essentially an output matrix of each step
    so 2*0 on row 1, column 1 is recorded as a whole matrix
    this matrix is then concatenated to a display matrix which 
    grows for each step...
    When the code finishes, the huge display matrix is then output 
    to a textbox showing each step
    Step Splitter just visually splits up the steps in the matrix
    %}
    
    % mock code: scalar multiplication by 2 
    temp_mat = get( entry_table, 'Data' );

    % Split steps up
    step_splitter=zeros(1,COLUMNS);
    step_splitter(1,:)=01010;
    
    disp_array = zeros( 1, (ROWS * COLUMNS) ); % pre-allocation
    disp_mat = vertcat( temp_mat, step_splitter ); 

    count = 0;
    for i = 1:ROWS 
        for j = 1:COLUMNS
            count = count + 1;
            temp_mat( i, j ) = temp_mat ( i, j ) * 2;

            % Display matrix code here...records each step
            disp_mat = vertcat( disp_mat, temp_mat );
            disp_mat = vertcat( disp_mat, step_splitter );

        end
    end

    op_data = temp_mat;

    % End of Operation
    
    % Step to text display
    set( mock_cout, ...
        'String', num2str( disp_mat ),...
        'Visible', 'on' );
   
    % Display answer on main table
    set( output_table,...
        'Data', op_data,...
        'Visible', 'on' ); 

end

function cb_op01( ~, ~ )
    set ( output_table, 'Visible', 'off' ); 
    set ( mock_cout, 'Visible', 'off' );

    % Start operation (Required: op_data, STEP_CELL_ARRAY)
    temp_mat = get( entry_table, 'Data' );

    % Split steps up 
    step_splitter=zeros(1,COLUMNS);
    step_splitter(1,:)=01010;
    
    disp_array = zeros( 1, (ROWS * COLUMNS) ); % pre-allocation
    disp_mat = vertcat( temp_mat, step_splitter ); 

    op_data = temp_mat;

    % End of Operation
    
    % Step to text display
    set( mock_cout, ...
        'String', num2str( disp_mat ),...
        'Visible', 'on' );
   
    % Display answer on main table
    set( output_table,...
        'Data', op_data,...
        'Visible', 'on' ); 
end 

function cb_op02( ~, ~ )
    set ( output_table, 'Visible', 'off' ); 
    set ( mock_cout, 'Visible', 'off' );

    % Start operation (Required: op_data, STEP_CELL_ARRAY)
    temp_mat = get( entry_table, 'Data' );

    % Split steps up 
    step_splitter=zeros(1,COLUMNS);
    step_splitter(1,:)=01010;
    
    disp_array = zeros( 1, (ROWS * COLUMNS) ); % pre-allocation
    disp_mat = vertcat( temp_mat, step_splitter ); 

    op_data = temp_mat;

    % End of Operation
    
    % Step to text display
    set( mock_cout, ...
        'String', num2str( disp_mat ),...
        'Visible', 'on' );
   
    % Display answer on main table
    set( output_table,...
        'Data', op_data,...
        'Visible', 'on' ); 
end 

end
