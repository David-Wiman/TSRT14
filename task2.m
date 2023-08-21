% h-function for toa
h_tdoa1 = inline('[sqrt((x(1,:)-th(1)).^2+(x(2,:)-th(2)).^2) + x(3,:) ; sqrt((x(1,:)-th(3)).^2+(x(2,:)-th(4)).^2)+ x(3,:) ; sqrt((x(1,:)-th(5)).^2+(x(2,:)-th(6)).^2)+ x(3,:) ; sqrt((x(1,:)-th(7)).^2+(x(2,:)-th(8)).^2)+ x(3,:)]', 't', 'x', 'u', 'th');

% h-function for tdoa2
h_tdoa2 = inline('[sqrt((x(1,:)-th(1)).^2+(x(2,:)-th(2)).^2) - sqrt((x(1,:)-th(3)).^2+(x(2,:)-th(4)).^2) ; sqrt((x(1,:)-th(1)).^2+(x(2,:)-th(2)).^2) - sqrt((x(1,:)-th(5)).^2+(x(2,:)-th(6)).^2) ; sqrt((x(1,:)-th(1)).^2+(x(2,:)-th(2)).^2) - sqrt((x(1,:)-th(7)).^2+(x(2,:)-th(8)).^2)]', 't', 'x', 'u', 'th');
