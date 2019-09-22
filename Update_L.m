function [L,M,W]=Update_L(Pts,L,x0,y0)
equationNum=size(Pts,1)*2;
M=zeros(equationNum,15);
W=zeros(equationNum,1);
for i=1:length(Pts)
    x=Pts(i,2);
    y=Pts(i,3);
    X=Pts(i,4);
    Y=Pts(i,5);
    Z=Pts(i,6);
    
    A=L(9)*X+L(10)*Y+L(11)*Z+1;
    r=sqrt((x-x0)^2+(y-y0)^2);
    
    %M
    %to x
    M(i*2-1,1)=-X/A;
    M(i*2-1,2)=-Y/A;
    M(i*2-1,3)=-Z/A;
    M(i*2-1,4)=-1/A;
    M(i*2-1,5)=0;
    M(i*2-1,6)=0;
    M(i*2-1,7)=0;
    M(i*2-1,8)=0;
    M(i*2-1,9)=-x*X/A;
    M(i*2-1,10)=-x*Y/A;
    M(i*2-1,11)=-x*Z/A;
    M(i*2-1,12)=-(x-x0)*r^2;
    M(i*2-1,13)=-(x-x0)*r^4;
    M(i*2-1,14)=-(r^2+2*(x-x0)^2);
    M(i*2-1,15)=-2*(x-x0)*(y-y0);
    %to y
    M(i*2,1)=0;
    M(i*2,2)=0;
    M(i*2,3)=0;
    M(i*2,4)=0;
    M(i*2,5)=-X/A;
    M(i*2,6)=-Y/A;
    M(i*2,7)=-Z/A;
    M(i*2,8)=-1/A;
    M(i*2,9)=-y*X/A;
    M(i*2,10)=-y*Y/A;
    M(i*2,11)=-y*Z/A;
    M(i*2,12)=-(y-y0)*r^2;
    M(i*2,13)=-(y-y0)*r^4;
    M(i*2,14)=-2*(x-x0)*(y-y0);
    M(i*2,15)=-(r^2+2*(y-y0)^2);
    
    % W
    W(i*2-1)=x/A;
    W(i*2)=y/A;
end
L=(M'*M)\M'*W;%Matrix is close to singular, use '\' instead of 'inv()'
end