clear;

A = [1 3; 1 -3; -1 0];
b = [0.1; 0.1; 0.1];
c = [1; 2];

% initial point
x = [0; 0];

% Stopping criterion
SC = 1e-10;

% Backtracking line search
alpha = 0.1; 
beta = 0.7;


while 1
    [f, g, H] = my_objective(x, A, b, c);

    % Newton step
    delta_x = -H \ g;

    % Decrement square
    De = g.'*(H \ g);
    
    if De/2 <= SC
        break
    end

    t = 1;
    x1 = x;
    while 1
        x1 = x1 + t*delta_x;
        
        % x must in dom f
        while 1
            if -(A(1,1)*x1(1)+A(1,2)*x1(2))+b(1)>0 && -(A(2,1)*x1(1)+A(2,2)*x1(2))+b(2)>0 && -(A(3,1)*x1(1)+A(3,2)*x1(2))+b(3)>0
                break
            end
            t = beta*t;
        end
        
        [f1, ~, ~] = my_objective(x1, A, b, c);
        
        % backtracking
        if f1 <= f + alpha*t*g.'*delta_x 
            break
        end
        t = beta*t;
    end
    
    x = x + t*delta_x;
end







