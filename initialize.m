function PtXYZ=initialize(left_L,right_L,Pt)
left_x=Pt(2);
left_y=Pt(3);
right_x=Pt(4);
right_y=Pt(5);
% W
W(1)=left_L(4)+left_x;
W(2)=left_L(8)+left_y;
W(3)=right_L(4)+right_x;
W(4)=right_L(8)+right_y;

% M
% LEFT
M(1,1)=left_L(1)+left_x*left_L(9);
M(1,2)=left_L(2)+left_x*left_L(10);
M(1,3)=left_L(3)+left_x*left_L(11);
M(2,1)=left_L(5)+left_y*left_L(9);
M(2,2)=left_L(6)+left_y*left_L(9);
M(2,3)=left_L(7)+left_y*left_L(9);
% RIGHT
M(3,1)=right_L(1)+right_x*right_L(9);
M(3,2)=right_L(2)+right_x*right_L(10);
M(3,3)=right_L(3)+right_x*right_L(11);
M(4,1)=right_L(5)+right_y*right_L(9);
M(4,2)=right_L(6)+right_y*right_L(10);
M(4,3)=right_L(7)+right_y*right_L(11);
% INITIALIZE
PtXYZ=-inv(M'*M)*M'*W';
end