%Step 1: Read control points and object points
controlPts='controlPts2.txt';

left_ctrl='station2.txt';
left_obj='station1obj.txt';
[left_ctrl_pts,left_obj_pts]=readPts(left_ctrl,left_obj,controlPts);

%Step 2: DLT Resection
[left_L,left_x0,left_y0]=Resection(left_ctrl_pts);

