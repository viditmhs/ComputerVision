%--------------------------------------------------------------------------------------------%
% Author: Vidit Maheshwari
% Created: 
% Explaination: Diffusion of an image over a time
%--------------------------------------------------------------------------------------------%
% Usage:
%--------------------------------------------------------------------------------------------%
% History:
%--------------------------------------------------------------------------------------------%

function ImageDiffusion(imgName)

	%Load Image matrix
	imgMat = LoadImage(imgName);
	[r,c,h] = size(imgMat);
	initialCond1 = double(reshape(imgMat(:,:,1)',[r*c,1]));
	initialCond2= double(reshape(imgMat(:,:,2)',[r*c,1]));
	initialCond3 = double(reshape(imgMat(:,:,3)',[r*c,1]));
	image(imgMat);


	% Based on image create a sparse diffusion matrix
	disp('[INFO] Base matrix generation started');
	Base = GenerateAMatrix([r,c], 0, 1,1,0.1);
	disp('[INFO] Base matrix has been generated');
	
	% Apply diffusion algorithm on an image
	for i = 0:0.1:2
		disp(['[INFO] Calculation for iteration time', num2str(i)])
		r_sol1 = Base*initialCond1;
		r_sol2 = Base*initialCond2;
		r_sol3 = Base*initialCond3;
		initialCond1 = r_sol1;
		initialCond2 = r_sol2;
		initialCond3 = r_sol3;
	end
	
	imgMat(:,:,1) = reshape(initialCond1, [c,r])';
	imgMat(:,:,2) = reshape(initialCond2, [c,r])';
	imgMat(:,:,3) = reshape(initialCond3, [c,r])';
	figure;
	image(imgMat);

end