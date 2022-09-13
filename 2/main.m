clear; 

% initial point
x = [0;0;10];
% intial t
t = 1;
% Newton interation
l = 0;
% Outer loop update
mu = 20;
% Stopping criterion
SC_inner = 10^(-5); SC_outer = 10^(-8);
% Backtracking line search
alpha = 0.1; beta = 0.7;

m=3;
P1 = [2 1;1 2]; P2 = [2 0;0 3]; P3 = [2 -1;-1 3];
y1 = [1;0];     y2 = [-1;2];    y3 = [-1;-2];    r1 = 0; r2 = 1; r3 = -1;

while 1
       
    while 1
        [f, g, H] = my_objective_with_log_barrier(x, t);
        
        % Newton step
        delta_x = -(H \ g);

        % Decrement square
        De = g.'*(H \ g); 

        if De/2 <= SC_inner
            break
        end
        
        s = 1;
        x1 = x;
        while 1
            
            while 1
                % x must in dom f
                x1 = x + s * delta_x;

                x1_tilde = [x1(1);x1(2)];
                f1b = ((x1_tilde - y1).' * P1 * (x1_tilde - y1)) / 2 + r1 - x1(3);
                f2b = ((x1_tilde - y2).' * P2 * (x1_tilde - y2)) / 2 + r2 - x1(3);
                f3b = ((x1_tilde - y3).' * P3 * (x1_tilde - y3)) / 2 + r3 - x1(3);
                
                if f1b<0 && f2b<0 && f3b<0
                    break
                end
                s = beta * s;
            end

            [fb, ~, ~] = my_objective_with_log_barrier(x1, t);

            % backtracking
            if fb <= f - alpha*s*De
                break
            end
            s = beta * s;
        end
        
        x = x + s * delta_x;
        l = l + 1;
    end
    
    if m/t < SC_outer
        break
    end
    
    t = mu * t; 
    l = l + 1;
end



    
    

