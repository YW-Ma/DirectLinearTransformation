function PtXYZ_updated=Update_XYZ(PtXYZ,left_L,right_L,Pt)
% Extract elements
lx=Pt(2);
ly=Pt(3);
lL=left_L;
rx=Pt(4);
ry=Pt(5);
rL=right_L;
X1=PtXYZ(1);
Y1=PtXYZ(2);
Z1=PtXYZ(3);

% Construct equation
N=zeros(4,3);
Q=zeros(4,1);

lA=lL(9)*X1+lL(10)*Y1+lL(11)*Z1+1;
rA=rL(9)*X1+rL(10)*Y1+rL(11)*Z1+1;
% N 
% Left
N(1,1)=-(lL(1)+lx*lL(9))/lA;
N(1,2)=-(lL(2)+lx*lL(10))/lA;
N(1,3)=-(lL(3)+lx*lL(11))/lA;
N(2,1)=-(lL(5)+ly*lL(9))/lA;
N(2,2)=-(lL(6)+ly*lL(10))/lA;
N(2,3)=-(lL(7)+ly*lL(11))/lA;
% Right
N(3,1)=-(rL(1)+rx*rL(9))/rA;
N(3,2)=-(rL(2)+rx*rL(10))/rA;
N(3,3)=-(rL(3)+rx*rL(11))/rA;
N(4,1)=-(rL(5)+ry*rL(9))/rA;
N(4,2)=-(rL(6)+ry*rL(10))/rA;
N(4,3)=-(rL(7)+ry*rL(11))/rA;
% Q
Q(1)=-(lL(4)+lx)/lA;
Q(2)=-(lL(8)+ly)/lA;
Q(3)=-(rL(4)+rx)/rA;
Q(4)=-(rL(8)+ry)/rA;

% UPDATE
PtXYZ_updated=(N'*N)\N'*Q;
end