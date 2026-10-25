
function tic_tac_toe

% PART 1: Create the GUI and initialize the game
clc;
board = zeros(3,3);
player = 1;
moves = 0;

fig = uifigure('Name','Tic-Tac-Toe', ...
    'Position',[400 200 350 420]);

titleLabel = uilabel(fig,'Text','TIC-TAC-TOE', ...
    'Position',[50 370 250 30], ...
    'FontSize',20,'FontWeight','bold', ...
    'HorizontalAlignment','center');

status = uilabel(fig,'Text','Player X turn', ...
    'Position',[50 335 250 25], ...
    'HorizontalAlignment','center');

% PART 2: Create the 3x3 grid of buttons
buttons = gobjects(3,3);

for r = 1:3
    for c = 1:3
        buttons(r,c) = uibutton(fig,'push', ...
            'Text','', ...
            'Position',[55+(c-1)*80 90+(3-r)*80 75 75], ...
            'FontSize',24, ...
            'ButtonPushedFcn', ...
            @(src,event) play(r,c));
    end
end

uibutton(fig,'push','Text','Restart Game', ...
    'Position',[100 25 150 40], ...
    'ButtonPushedFcn',@restart);

% PART 3: Handle moves and switch players
    function play(r,c)
        if board(r,c) ~= 0
            return;
        end

        board(r,c) = player;
        moves = moves + 1;

        if player == 1
            buttons(r,c).Text = 'X';
        else
            buttons(r,c).Text = 'O';
        end

        % PART 4: Check for a winner or a draw
        win = false;

        for k = 1:3
            if all(board(k,:) == player) || ...
               all(board(:,k) == player)
                win = true;
            end
        end

        if all(diag(board) == player) || ...
           all(diag(fliplr(board)) == player)
            win = true;
        end

        if win
            if player == 1
                status.Text = 'Player X wins!';
            else
                status.Text = 'Player O wins!';
            end

            for a = 1:3
                for b = 1:3
                    buttons(a,b).Enable = 'off';
                end
            end
            return;
        elseif moves == 9
            status.Text = 'Match Draw!';
            return;
        end

        % PART 5: Update turn and restart the game
        player = 3 - player;

        if player == 1
            status.Text = 'Player X turn';
        else
            status.Text = 'Player O turn';
        end
    end

    function restart(~,~)
        board(:) = 0;
        player = 1;
        moves = 0;
        status.Text = 'Player X turn';

        for a = 1:3
            for b = 1:3
                buttons(a,b).Text = '';
                buttons(a,b).Enable = 'on';
            end
        end
    end
end
