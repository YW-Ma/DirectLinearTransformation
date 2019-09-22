function [world_obj,homoPts]=ForwardIntersection(left_obj_pts,left_L,left_x0,left_y0, ...
                                   right_obj_pts,right_L,right_x0,right_y0,...
                                   left_ctrl_pts,right_ctrl_pts)

%Step 1: Extract Homonymy points.[input: obj_pts;  output: homoPts]
loc=1;
for i = 1:length(left_obj_pts)
    ID=left_obj_pts(i,1);
    [row,~]=find(right_obj_pts(:,1)==ID);%Find homonymy pts
    [row1,~]=find(left_ctrl_pts(:,1)==ID);%delete 
    [row2,~]=find(right_ctrl_pts(:,1)==ID);%delete
    if(isempty(row1)==0&&isempty(row2)==0)%delete
        homoPts(loc,6:8)=left_ctrl_pts(row1,4:6); %delete
        homoPts(loc,9:11)=right_ctrl_pts(row2,4:6);%delete
    end%delete
    if(isempty(row)==0)%if exists.
        homoPts(loc,1:3)=left_obj_pts(i,1:3); 
        homoPts(loc,4:5)=right_obj_pts(row,2:3);
        loc=loc+1;
    end
end

world_obj=zeros(size(homoPts,1),4);%[ID,X,Y,Z]
%Step 2: Recify Points according to L.
homoPts(:,2:3)=rectifyPts(homoPts(:,2:3),left_L,left_x0,left_y0);
homoPts(:,4:5)=rectifyPts(homoPts(:,4:5),right_L,right_x0,right_y0);

%Step 3: Start iteration point by point
%for each point
for i=1:length(homoPts)
    % 3.1 Initialize XYZ
    PtXYZ=initialize(left_L,right_L,homoPts(i,:));
    PtXYZ_last=PtXYZ;
    PtXYZ=Update_XYZ(PtXYZ,left_L,right_L,homoPts(i,:));
    iteration=0;
    dXYZ=max(abs(PtXYZ_last-PtXYZ));
    while(dXYZ>1e-9 && iteration<50)
        PtXYZ_last=PtXYZ;
        PtXYZ=Update_XYZ(PtXYZ,left_L,right_L,homoPts(i,:));
        iteration=iteration+1;
        dXYZ=max(abs(PtXYZ_last-PtXYZ));
    end
    world_obj(i,1)=homoPts(i,1);%ID
    world_obj(i,2:4)=PtXYZ';%[;;]-->[,,]
    fprintf('Point No.%d: itr = %d\n',i,iteration);
end
end