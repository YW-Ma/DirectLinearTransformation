function L=Initialize_L(Pts)
equationNum=size(Pts,1)*2;
M=zeros(equationNum,11);
W=zeros(equationNum,1);
% V = ML-W
%In fact, Least Square is unneccesary,
%because we only need a coarse initial value.
for i=1:length(Pts)
    x=Pts(i,2);
    y=Pts(i,3);
    X=Pts(i,4);
    Y=Pts(i,5);
    Z=Pts(i,6);
    %M
    %to x
    M(i*2-1,1)=X;
    M(i*2-1,2)=Y;
    M(i*2-1,3)=Z;
    M(i*2-1,4)=1;
    M(i*2-1,5)=0;
    M(i*2-1,6)=0;
    M(i*2-1,7)=0;
    M(i*2-1,8)=0;
    M(i*2-1,9)=x*X;
    M(i*2-1,10)=x*Y;
    M(i*2-1,11)=x*Z;
    %to y
    M(i*2,1)=0;
    M(i*2,2)=0;
    M(i*2,3)=0;
    M(i*2,4)=0;
    M(i*2,5)=X;
    M(i*2,6)=Y;
    M(i*2,7)=Z;
    M(i*2,8)=1;
    M(i*2,9)=y*X;
    M(i*2,10)=y*Y;
    M(i*2,11)=y*Z; 
    % W
    W(i*2-1)=x;
    W(i*2)=y;
end
L=-(M'*M)\M'*W;%Only calculate 1-11 
end