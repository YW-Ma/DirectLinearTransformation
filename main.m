function main()
%Step 1: Read control points and object points
controlPts='controlPts.txt';

left_ctrl='left_ctrl.txt';
left_obj='left_obj.txt';
[left_ctrl_pts,left_obj_pts]=readPts(left_ctrl,left_obj,controlPts);

right_ctrl='right_ctrl.txt';
right_obj='right_obj.txt';
[right_ctrl_pts,right_obj_pts]=readPts(right_ctrl,right_obj,controlPts);

%Step 2: DLT Resection
[left_L,left_x0,left_y0]=Resection(left_ctrl_pts);
[right_L,right_x0,right_y0]=Resection(right_ctrl_pts);

%Step 3: DLT Forward Intersection
[world_obj,homoPts]=ForwardIntersection(left_obj_pts,left_L,left_x0,left_y0, ...
                             right_obj_pts,right_L,right_x0,right_y0,...
                             left_ctrl_pts,right_ctrl_pts);
%Step 4: Justifying: Calculating the distance 
%        between each points and Point No.52                         
[row,~]=find(52==world_obj(:,1));
Pt52=world_obj(row,2:4);
distance=world_obj(:,2:4)-Pt52;
scatter3(-world_obj(:,4),-world_obj(:,2),-world_obj(:,3),'bo');
hold on;scatter3(-world_obj(11,4),-world_obj(11,2),-world_obj(11,3),'rx');
hold on;scatter3(-world_obj(11,4),-world_obj(11,2),-world_obj(11,3),'ro');
for i=1:size(world_obj)
%     if(world_obj(i,1)>100)
%         hold on;scatter3(-world_obj(i,4),-world_obj(i,2),-world_obj(i,3),'rx');
%     end
    hold on;text(-world_obj(i,4),-world_obj(i,2),-world_obj(i,3)+40,num2str(world_obj(i,1)),'Color','black');
end
hold on;text(-world_obj(11,4),-world_obj(11,2),-world_obj(11,3)+40,num2str(world_obj(11,1)),'Color','red');
set(gca,'xlabel',[],'ylabel',[]);
grid on;
