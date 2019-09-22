function [L,x0,y0] = Resection(Pts)
%Step 1. Initialize L0 & x0,y0   
x0=0;
y0=0;
x0_last=x0;
y0_last=y0;
%1.1 Initialize L
L=Initialize_L(Pts);
%1.2 Initialize x0 y0
[x0,y0]=Update_InteriorElement(L);

%Step 2. Iteration 
equationNum=size(Pts,1)*2;
M=zeros(equationNum,15);
W=zeros(equationNum,1);
% 2.1 first iteration
x0_last=x0;
y0_last=y0;
[L,~,~]=Update_L(Pts,L,x0,y0);
[x0,y0]=Update_InteriorElement(L);
[L,M,W]=Update_L(Pts,L,x0,y0);
[x0,y0]=Update_InteriorElement(L);
iteration=2;
V=M*L-W;

%2.2 loop
dx0=x0-x0_last;
dy0=y0-y0_last;
while(max(abs(dx0),abs(dy0))>1e-5&& iteration<50)
    x0_last=x0;
    y0_last=y0;
    %2.2.1 Update L
    [L,M,W]=Update_L(Pts,L,x0,y0);
    %2.2.2 Update x0 y0
    [x0,y0]=Update_InteriorElement(L);
    dx0=x0-x0_last;
    dy0=y0-y0_last;
    iteration=iteration+1;
    V=M*L-W;
end
%Evaluation
M0=(V'*V)/(equationNum-1);
m=sqrt(M0(1,1));
fid=fopen('ResectionResults.csv','a');
fprintf(fid,'Finish Resection after %d iteration\n',iteration);
fprintf(fid,'residual:\n');
fprintf(fid,'ID,x,y\n');
for i=1:size(Pts,1)
    fprintf(fid,'%g,%g,%g\n',Pts(i,1),V(2*i-1),V(2*i));
end
%Exterior
%line
Ex_A=[L(1),L(2),L(3);L(5),L(6),L(7);L(9),L(10),L(11)];
Ex_L=[-L(4);-L(8);-1];
Ex_X=(Ex_A)\Ex_L;
fprintf(fid,'Xs,%g,mm\nYs,%g,mm\nZs,%g,mm\n',Ex_X(1),Ex_X(2),Ex_X(3));
%angle
line=sqrt(L(9)^2+L(10)^2+L(11)^2);
a3=L(9)/line;
b3=L(10)/line;
c3=L(11)/line;
b1=L(2)/sqrt(L(1)^2+L(2)^2+L(3)^2);
b2=L(6)/sqrt(L(5)^2+L(6)^2+L(7)^2);
fprintf(fid,'Phi,%g,rad\nOmega,%g,rad\nKappa,%g,rad\n',atan(a3/c3), asin(-b3), atan(b1/b2));

%Interior
r= -1 * (a3*Ex_X(1,1) + b3*Ex_X(2, 1) + c3*Ex_X(3, 1));
A1 = r^2*(L(1)^2 + L(2)^2 + L(3)^2) - x0^2;
B1 = r^2*(L(5)^2 + L(6)^2 + L(7)^2) - y0^2;
C1 = r^2*(L(1)*L(5) + L(2)*L(6) + L(3)*L(7)) - x0*y0;
ds = sqrt(A1 / B1) - 1;
db=0;
if (C1 > 0)
    db = asin(sqrt(C1^2 / (A1*B1)));
end
if (C1<=0)
    db = asin(-1 * sqrt(C1^2 / (A1*B1)));
end
fx = sqrt((A1*B1 - C1*C1) / B1);
fy = sqrt((A1*B1 - C1*C1) / A1);
fprintf(fid, "x0,%g,pix\ny0,%g,pix\n", x0, y0);
fprintf(fid, "m,%g,pix\n",m);
fprintf(fid, "fx,%g,pix\nfy,%g,pix\n", fx, fy);
fprintf(fid, "dB,%g\nds,%g\n", db, ds);
fprintf(fid, "k1,%g\nk2,%g\n", L(12), L(13));
fprintf(fid, "p1,%g\np2,%g\n", L(14), L(15));

Q=inv(M'*M);
MM=sqrt(diag(Q))*m;
fprintf(fid,'L1M,%g\n',MM(1));
fprintf(fid,'L2M,%g\n',MM(2));
fprintf(fid,'L3M,%g\n',MM(3));
fprintf(fid,'L4M,%g\n',MM(4));
fprintf(fid,'L5M,%g\n',MM(5));
fprintf(fid,'L6M,%g\n',MM(6));
fprintf(fid,'L7M,%g\n',MM(7));
fprintf(fid,'L8M,%g\n',MM(8));
fprintf(fid,'L9M,%g\n',MM(9));
fprintf(fid,'L10M,%g\n',MM(10));
fprintf(fid,'L11M,%g\n',MM(11));
fprintf(fid,'p1M,%g\n',MM(12));
fprintf(fid,'p2M,%g\n',MM(13));
fprintf(fid,'k1M,%g\n',MM(14));
fprintf(fid,'k2M,%g\n',MM(15));

fclose(fid);
end