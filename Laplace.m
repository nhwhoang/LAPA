% FINITE DIFFERENCE MODEL OF LAPLACE EQUATION IN 2D

set(0,'DefaultFigureWindowStyle','docked')

% Constant and parameters
N = 100;  % number of iteration
nx = 100;      
ny = 100;
V = zeros(nx,ny);   % voltage matrix

% Boundary conditions
% % First part
parta = 1;
% V(:,1) = 1;     % left boundary
% V(:,ny) = 0;    % right boundary

% % Second part
partb = 0;
% V(:,1) = 1;     % left boundary
% V(:,ny) = 1;    % right boundary
% V(1,:) = 0;     % top boundary
% V(nx,:) = 0;    % bottom boundary


for i = 1:N
    for m = 1:nx
        for n = 1:ny
            if parta == 1 
                if n == 1       % left BC
                    V(m,n) = 1;
                elseif n == ny % right BC
                    V(m,n) = 0;     
                elseif (m == 1) && (n ~= 1 && n ~= ny)  % top BC
                    V(m,n) = (V(m+1,n) + V(m,n+1) + V(m,n-1))/3;
                elseif (m == nx) && (n ~= 1 && n ~= ny) % bottom BC
                    V(m,n) = (V(m-1,n) + V(m,n+1) + V(m,n-1))/3;
                else
                    V(m,n) = (V(m+1, n) + V(m-1, n) + V(m, n+1) + V(m, n-1))/4;
                end
            end
            
            if partb == 1
                if (n == 1) || (n == ny)    % left and right BC
                    V(m,n) = 1;
                elseif (m == 1 || m == nx) && (n ~= 1 && n ~= ny)  % top and bottom BC
                    V(m,n) = 0;    
                else
                    V(m,n) = (V(m+1, n) + V(m-1, n) + V(m, n+1) + V(m, n-1))/4;
                end
            end   
        end
    end
    
    subplot(3,1,1)
    surf(V')

    % Electric field
    [Ex,Ey] = gradient(V);

    subplot(3,1,2)
    title('Vector field');
    quiver(Ex',Ey')

    subplot(3,1,3)
    surf(imboxfilt(V,3));

    pause(0.02)
end



