function [ctrl_pts,obj_pts]=readPts(ctrl_file,obj_file,controlPts)
    %ctrl_file(imagePts)
    fid=fopen(ctrl_file);
    C=textscan(fid, '%f32%f32%f32');
    fclose(fid);
    imgcptsID=C{1,1};
    imgcptsX=C{1,2};
    imgcptsY=C{1,3};  
    ctrl_pts=zeros(size(imgcptsID,1),6);
    
    %obj_file(imagePts)
    fid=fopen(obj_file);
    C=textscan(fid, '%f32%f32%f32');
    fclose(fid);
    imgoptsID=C{1,1};
    imgoptsX=C{1,2};
    imgoptsY=C{1,3};
    obj_pts=zeros(size(imgoptsID,1),3);
    
    for i=1:size(imgoptsID)
        obj_pts(i,1)=imgoptsID(i);
        obj_pts(i,2)=imgoptsX(i);
        obj_pts(i,3)=imgoptsY(i);
    end

    %ControlPts
    fid=fopen(controlPts);
    C=textscan(fid, '%f32%f32%f32%f32');
    fclose(fid);
    cptsID=C{1,1};
    cptsX=C{1,3};%origin Y
    cptsY=C{1,4};%origin Z
    cptsZ=-C{1,2};%origin X
    
    for i=1:size(imgcptsID,1)
        for j=1:size(cptsID,1)
            if(imgcptsID(i)==cptsID(j))
                ctrl_pts(i,1)=imgcptsID(i);%ID
                ctrl_pts(i,2)=imgcptsX(i);% x
                ctrl_pts(i,3)=imgcptsY(i);% y
                ctrl_pts(i,4)=cptsX(j);% X
                ctrl_pts(i,5)=cptsY(j);% Y
                ctrl_pts(i,6)=cptsZ(j);% Z
            end
        end
    end
    
end