%--------------------------------------------------------------------------------------------%
% Author: Vidit Maheshwari
% Created: 
% Explaination: Given a size of 2D Matrix generate a A matrix
%--------------------------------------------------------------------------------------------%
% Usage:
%--------------------------------------------------------------------------------------------%
% History:
%--------------------------------------------------------------------------------------------%

function A = GenerateAMatrix(size, boundaryType, deltaX, deltaY, deltaT);

	r = size(1);
	c = size(2);
	
	sizeA = r*c;
	deltaX2 = deltaX^2;
	deltaY2 = deltaY^2;
	
	disp(['Base matrix size ', num2str(sizeA)]);
	A = sparse(sizeA, sizeA);
	
	
	% All internal domain
	
	disp('[INFO] Generating base matrix inner conditions');
	for i = 2:r-1
		for j = 2:c-1
			row = (i-1)*c + j;
			A(row,row) 				= -deltaT*( 2/deltaX2 + 2/deltaY2) + 1; 	% Y(i,j)
			A(row,(i-2)*c + j) 		= deltaT/deltaX2;							% Y(i-1,j)
			A(row,(i)*c + j) 		= deltaT/deltaX2;  							% Y(i+1,j)
			A(row, (i-1)*c + j+1) 	= deltaT/deltaY2;							% Y(i,j+1)
			A(row, (i-1)*c + j-1) 	= deltaT/deltaY2;							% Y(i,j-1)
		end
	end
	
	% All boundary
	
	% Drichlet boundary condition
	if(boundaryType==0)
		disp('[INFO] Generating base matrix drichlet boundary conditions');
		for j = 1:c
			A(j,j) = 1;
			A((r-1)*c + j, (r-1)*c + j) = 1;
		end
	
		for j = 1:r
			A((j-1)*c + 1,(j-1)*c + 1) = 1;
			A((j-1)*c + c,(j-1)*c + c) = 1;
			
		end
	end
	disp('[INFO] GenerateAMatrix Ends');

end