% Plot a block on the given figure handle h
% p1, xmin ymin zmin
% p2, xmax ymax zmax
% c, color in r g b (0-255)

function block_plot(h, p1, p2, c)

    v = [0 0 0; ...
         1 0 0; ...
         1 1 0; ...
         0 1 0; ...
         0 0 1; ...
         1 0 1; ...
         1 1 1; ...
         0 1 1];
    f = [1 2 6 5; ...
         2 3 7 6; ...
         3 4 8 7; ...
         4 1 5 8; ...
         1 2 3 4; ...
         5 6 7 8];
    c  = c / 255;
    fc = [c';c';c';c';c';c'];
     
    d = p2 - p1;
    v(:,1) = v(:,1) * d(1);
    v(:,2) = v(:,2) * d(2);
    v(:,3) = v(:,3) * d(3);         
    v(:,1) = v(:,1) + p1(1);
    v(:,2) = v(:,2) + p1(2);
    v(:,3) = v(:,3) + p1(3);     
    
    figure(h);
    hold on;
    patch('Vertices',v,'Faces',f,'FaceColor','flat','FaceVertexCData',fc);
    hold off;
end