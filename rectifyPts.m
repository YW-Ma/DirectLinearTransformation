function xyPts_rectified=rectifyPts(xyPts,L,x0,y0)
xyPts_rectified=zeros(size(xyPts));
for i=1:length(xyPts)
    x=xyPts(i,1);
    y=xyPts(i,2);
    r=sqrt((x-x0).^2+(y-y0).^2);
    dx=(x-x0)*(r^2*L(12)+r^4*L(13))+L(14)*(r^2+2*(x-x0)^2)+2*L(15)*(x-x0)*(y-y0);
    dy=(y-y0)*(r^2*L(12)+r^4*L(13))+L(14)*(r^2+2*(y-y0)^2)+2*L(15)*(x-x0)*(y-y0);
    x=x+dx;
    y=y+dy;
    xyPts_rectified(i,1)=x;
    xyPts_rectified(i,2)=y;
end
end