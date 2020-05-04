%define total number of elements in combined matrix
%DX = 10;
%DY = 4;
%DZ =2;
ne = DX3DC*DY3DC*DZ3DC;
%Allocate space for large sparse matrix A
STUte = zeros(1,ne);
%A = zeros(ne,ne);
    %-------------for a 3D matrix only-------------------------------------
    %----solve for global grid elements
            %----------------defines boundaries of global matrix ---------
%Activate 4 cores for parallel processing
spmd(4)
%Assign parts of sparse matrix to 1st core
if labindex==1
   for i=1:floor(DX3DC/4)
       for j = 1:DY3DC
           for k = 1:DZ3DC
%determine position within sparse matrix for each global element, using n as a pointer                
               n=(k-1)*(DY3DC*DX3DC)+(i-1)*DY3DC+j;               
               %----------------defines corners of resistance matrix ---------               
               %NW corner*******from top view NW corner
               %min z
               if (i==1 && j==1) && k==1
                  HOSTCELL = HOSTNUM_C(j,i,k); 
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k);
                  kpr=kparent(j,i,k);
                  stute_Wx = Uten(HOSTCELL-DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DY3D)*(y(j+1)-y(j))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(xp(ipr)-xp(ipr-1))+sigman(HOSTCELL-DY3D)*0.5*(x(i+1)-x(i)));    
                  stute_Wy = Uten(HOSTCELL-1)*sigma(j,i,k)*sigman(HOSTCELL-1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr)-yp(jpr-1))+sigman(HOSTCELL-1)*0.5*(y(j+1)-y(j)));      
                  stute_Wz = Uten(HOSTCELL-DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr)-zp(kpr-1))+sigman(HOSTCELL-DX3D*DY3D)*0.5*(z(k+1)-z(k)));  
                  stute_P  = (stute_Wx + stute_Wy + stute_Wz);
                STUte(n) = stute_P;
               %max z
               elseif (i==1 && j==1) && k==DZ3DC
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Wx = Uten(HOSTCELL-DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DY3D)*(y(j+1)-y(j))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(xp(ipr)-xp(ipr-1))+sigman(HOSTCELL-DY3D)*0.5*(x(i+1)-x(i)));      
                  stute_Wy = Uten(HOSTCELL-1)*sigma(j,i,k)*sigman(HOSTCELL-1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr)-yp(jpr-1))+sigman(HOSTCELL-1)*0.5*(y(j+1)-y(j)));        
                  stute_Ez = Uten(HOSTCELL+DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr+2)-zp(kpr+1))+sigman(HOSTCELL+DX3D*DY3D)*0.5*(z(k+1)-z(k)));     
                  stute_P  = (stute_Wx + stute_Wy + stute_Ez);
                STUte(n) = stute_P;
               %SW corner*******from top view SW corner
               %min z
               elseif (i==1 && j==DY3DC) && k==1
                 HOSTCELL = HOSTNUM_C(j,i,k);
                 ipr=iparent(j,i,k); 
                 jpr=jparent(j,i,k); 
                 kpr=kparent(j,i,k);
                 stute_Wx = Uten(HOSTCELL-DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DY3D)*(y(j+1)-y(j))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(xp(ipr)-xp(ipr-1))+sigman(HOSTCELL-DY3D)*0.5*(x(i+1)-x(i)));     
                 stute_Ey = Uten(HOSTCELL+1)*sigma(j,i,k)*sigman(HOSTCELL+1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr+2)-yp(jpr+1))+sigman(HOSTCELL+1)*0.5*(y(j+1)-y(j)));      
                 stute_Wz = Uten(HOSTCELL-DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr)-zp(kpr-1))+sigman(HOSTCELL-DX3D*DY3D)*0.5*(z(k+1)-z(k))); 
                 stute_P  = (stute_Wx + stute_Ey + stute_Wz);
               STUte(n) = stute_P; 
               %max z
               elseif (i==1 && j==DY3DC) && k==DZ3DC
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k);
                  kpr=kparent(j,i,k);
                  stute_Wx = Uten(HOSTCELL-DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DY3D)*(y(j+1)-y(j))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(xp(ipr)-xp(ipr-1))+sigman(HOSTCELL-DY3D)*0.5*(x(i+1)-x(i)));     
                  stute_Ey = Uten(HOSTCELL+1)*sigma(j,i,k)*sigman(HOSTCELL+1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr+2)-yp(jpr+1))+sigman(HOSTCELL+1)*0.5*(y(j+1)-y(j)));      
                  stute_Ez = Uten(HOSTCELL+DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr+2)-zp(kpr+1))+sigman(HOSTCELL+DX3D*DY3D)*0.5*(z(k+1)-z(k)));     
                 stute_P  = (stute_Wx + stute_Ey + stute_Ez);
               STUte(n) = stute_P; 
               %----------------defines edges of resistance matrix -----------
               %NW edge*******from top view NW corner
               elseif (i==1 && j==1)
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k);
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Wx = Uten(HOSTCELL-DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DY3D)*(y(j+1)-y(j))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(xp(ipr)-xp(ipr-1))+sigman(HOSTCELL-DY3D)*0.5*(x(i+1)-x(i)));     
                  stute_Wy = Uten(HOSTCELL-1)*sigma(j,i,k)*sigman(HOSTCELL-1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr)-yp(jpr-1))+sigman(HOSTCELL-1)*0.5*(y(j+1)-y(j)));       
                  stute_P  = (stute_Wx +  stute_Wy);
               STUte(n) = stute_P; 
               %SW edge*******from top view SW corner 
               elseif (i==1 && j==DY3DC)
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k);
                  jpr=jparent(j,i,k);
                  kpr=kparent(j,i,k);
                  stute_Wx = Uten(HOSTCELL-DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DY3D)*(y(j+1)-y(j))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(xp(ipr)-xp(ipr-1))+sigman(HOSTCELL-DY3D)*0.5*(x(i+1)-x(i)));     
                  stute_Ey = Uten(HOSTCELL+1)*sigma(j,i,k)*sigman(HOSTCELL+1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr+2)-yp(jpr+1))+sigman(HOSTCELL+1)*0.5*(y(j+1)-y(j)));     
                  stute_P  = (stute_Wx +  stute_Ey);
               STUte(n) = stute_P; 
               %W edge min z*******from top view W edge top 
               elseif (i==1 && k==1)
                  HOSTCELL = HOSTNUM_C(j,i,k); 
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Wx = Uten(HOSTCELL-DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DY3D)*(y(j+1)-y(j))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(xp(ipr)-xp(ipr-1))+sigman(HOSTCELL-DY3D)*0.5*(x(i+1)-x(i)));     
                  stute_Wz = Uten(HOSTCELL-DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr)-zp(kpr-1))+sigman(HOSTCELL-DX3D*DY3D)*0.5*(z(k+1)-z(k))); 
                  stute_P  = (stute_Wx +  stute_Wz);
               STUte(n) = stute_P; 
               %W edge max z******from top view W edge bottom
               elseif (i==1 && k==DZ3DC)
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k);
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Wx = Uten(HOSTCELL-DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DY3D)*(y(j+1)-y(j))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(xp(ipr)-xp(ipr-1))+sigman(HOSTCELL-DY3D)*0.5*(x(i+1)-x(i)));     
                  stute_Ez = Uten(HOSTCELL+DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr+2)-zp(kpr+1))+sigman(HOSTCELL+DX3D*DY3D)*0.5*(z(k+1)-z(k)));    
                  stute_P  = (stute_Wx +  stute_Ez);
               STUte(n) = stute_P; 
               %N edge min z******from top view N edge top
               elseif (j==1 && k==1)
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k);
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Wy = Uten(HOSTCELL-1)*sigma(j,i,k)*sigman(HOSTCELL-1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr)-yp(jpr-1))+sigman(HOSTCELL-1)*0.5*(y(j+1)-y(j)));       
                  stute_Wz = Uten(HOSTCELL-DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr)-zp(kpr-1))+sigman(HOSTCELL-DX3D*DY3D)*0.5*(z(k+1)-z(k))); 
                  stute_P  = (stute_Wy +  stute_Wz);
               STUte(n) = stute_P;              
               %N edge max z******from top view N edge bottom
               elseif (j==1 && k==DZ3DC)
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Wy = Uten(HOSTCELL-1)*sigma(j,i,k)*sigman(HOSTCELL-1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr)-yp(jpr-1))+sigman(HOSTCELL-1)*0.5*(y(j+1)-y(j)));       
                  stute_Ez = Uten(HOSTCELL+DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr+2)-zp(kpr+1))+sigman(HOSTCELL+DX3D*DY3D)*0.5*(z(k+1)-z(k)));    
                  stute_P  = (stute_Wy +  stute_Ez);
               STUte(n) = stute_P; 
               %S edge min z******from top view S edge top
               elseif (j==DY3DC && k==1)
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Ey = Uten(HOSTCELL+1)*sigma(j,i,k)*sigman(HOSTCELL+1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr+2)-yp(jpr+1))+sigman(HOSTCELL+1)*0.5*(y(j+1)-y(j)));     
                  stute_Wz = Uten(HOSTCELL-DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr)-zp(kpr-1))+sigman(HOSTCELL-DX3D*DY3D)*0.5*(z(k+1)-z(k))); 
                  stute_P  = (stute_Ey +  stute_Wz);
               STUte(n) = stute_P; 
               %S edge max z******from top view S edge bottom 
               elseif (j==DY3DC && k==DZ3DC)
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Ey = Uten(HOSTCELL+1)*sigma(j,i,k)*sigman(HOSTCELL+1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr+2)-yp(jpr+1))+sigman(HOSTCELL+1)*0.5*(y(j+1)-y(j)));     
                  stute_Ez = Uten(HOSTCELL+DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr+2)-zp(kpr+1))+sigman(HOSTCELL+DX3D*DY3D)*0.5*(z(k+1)-z(k)));    
                  stute_P  = (stute_Ey +  stute_Ez);
               STUte(n) = stute_P;
               %----------------define surface boundaries
               %W face******from top view W face 
               elseif i==1
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Wx = Uten(HOSTCELL-DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DY3D)*(y(j+1)-y(j))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(xp(ipr)-xp(ipr-1))+sigman(HOSTCELL-DY3D)*0.5*(x(i+1)-x(i)));     
                  stute_P  = (stute_Wx);
               STUte(n) = stute_P;
               %N face******from top view N face
               elseif j==1
                  HOSTCELL = HOSTNUM_C(j,i,k); 
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Wy = Uten(HOSTCELL-1)*sigma(j,i,k)*sigman(HOSTCELL-1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr)-yp(jpr-1))+sigman(HOSTCELL-1)*0.5*(y(j+1)-y(j)));       
                  stute_P  = (stute_Wy);
               STUte(n) = stute_P;
               %S face******from top view S face    
               elseif j==DY3DC
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k);
                  jpr=jparent(j,i,k);
                  kpr=kparent(j,i,k);
                  stute_Ey = Uten(HOSTCELL+1)*sigma(j,i,k)*sigman(HOSTCELL+1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr+2)-yp(jpr+1))+sigman(HOSTCELL+1)*0.5*(y(j+1)-y(j)));     
                  stute_P  = (stute_Ey);
               STUte(n) = stute_P;
               %near face******from top view top face
                elseif k==1
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Wz = Uten(HOSTCELL-DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr)-zp(kpr-1))+sigman(HOSTCELL-DX3D*DY3D)*0.5*(z(k+1)-z(k))); 
                  stute_P  = (stute_Wz);
               STUte(n) = stute_P;
               %far face******from top view bottom face                
                elseif k==DZ3DC
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k);
                  kpr=kparent(j,i,k);
                  stute_Ez = Uten(HOSTCELL+DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr+2)-zp(kpr+1))+sigman(HOSTCELL+DX3D*DY3D)*0.5*(z(k+1)-z(k)));    
                  stute_P  = (stute_Ez);
               STUte(n) = stute_P;             
               end
           end
        end
   end
   for i=2:floor(DX3DC/4)
       for j = 2:DY3DC-1
           for k = 2:DZ3DC-1
                n=(k-1)*(DY3DC*DX3DC)+(i-1)*DY3DC+j;
                %---------this deals with all the non-boundary elements
                STUte(n) = 0;
                                       
            end
        end
    end
end
%Assign parts of sparse matrix to 2nd core
if labindex==2
   for i=floor(DX3DC/4)+1:floor(DX3DC/2)
       for j = 1:DY3DC
           for k = 1:DZ3DC
                n=(k-1)*(DY3DC*DX3DC)+(i-1)*DY3DC+j;
               %----------------defines edges of resistance matrix -----------                
               %N edge min z******from top view N edge
               if (j==1 && k==1)
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k);
                  kpr=kparent(j,i,k);
                  stute_Wy = Uten(HOSTCELL-1)*sigma(j,i,k)*sigman(HOSTCELL-1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr)-yp(jpr-1))+sigman(HOSTCELL-1)*0.5*(y(j+1)-y(j)));       
                  stute_Wz = Uten(HOSTCELL-DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr)-zp(kpr-1))+sigman(HOSTCELL-DX3D*DY3D)*0.5*(z(k+1)-z(k))); 
                  stute_P  = (stute_Wy +  stute_Wz);
               STUte(n) = stute_P;              
               %N edge max z******from top view N edge
               elseif (j==1 && k==DZ3DC)
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Wy = Uten(HOSTCELL-1)*sigma(j,i,k)*sigman(HOSTCELL-1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr)-yp(jpr-1))+sigman(HOSTCELL-1)*0.5*(y(j+1)-y(j)));       
                  stute_Ez = Uten(HOSTCELL+DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr+2)-zp(kpr+1))+sigman(HOSTCELL+DX3D*DY3D)*0.5*(z(k+1)-z(k)));    
                  stute_P  = (stute_Wy +  stute_Ez);
               STUte(n) = stute_P; 
               %S edge min zz******from top view S edge
               elseif (j==DY3DC && k==1)
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Ey = Uten(HOSTCELL+1)*sigma(j,i,k)*sigman(HOSTCELL+1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr+2)-yp(jpr+1))+sigman(HOSTCELL+1)*0.5*(y(j+1)-y(j)));     
                  stute_Wz = Uten(HOSTCELL-DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr)-zp(kpr-1))+sigman(HOSTCELL-DX3D*DY3D)*0.5*(z(k+1)-z(k))); 
                  stute_P  = (stute_Ey +  stute_Wz);
               STUte(n) = stute_P; 
               %S edge max z******from top view S edge 
               elseif (j==DY3DC && k==DZ3DC)
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Ey = Uten(HOSTCELL+1)*sigma(j,i,k)*sigman(HOSTCELL+1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr+2)-yp(jpr+1))+sigman(HOSTCELL+1)*0.5*(y(j+1)-y(j)));     
                  stute_Ez = Uten(HOSTCELL+DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr+2)-zp(kpr+1))+sigman(HOSTCELL+DX3D*DY3D)*0.5*(z(k+1)-z(k)));    
                  stute_P  = (stute_Ey +  stute_Ez);
               STUte(n) = stute_P;
               %----------------define surface boundaries               
               %N face******from top view N face 
               elseif j==1
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k);
                  kpr=kparent(j,i,k);
                  stute_Wy = Uten(HOSTCELL-1)*sigma(j,i,k)*sigman(HOSTCELL-1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr)-yp(jpr-1))+sigman(HOSTCELL-1)*0.5*(y(j+1)-y(j)));       
                  stute_P  = (stute_Wy);
               STUte(n) = stute_P;
               %S face******from top view S face    
               elseif j==DY3DC
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k);
                  jpr=jparent(j,i,k);
                  kpr=kparent(j,i,k);
                  stute_Ey = Uten(HOSTCELL+1)*sigma(j,i,k)*sigman(HOSTCELL+1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr+2)-yp(jpr+1))+sigman(HOSTCELL+1)*0.5*(y(j+1)-y(j)));     
                  stute_P  = (stute_Ey);
               STUte(n) = stute_P;
               %near face******from top view top face
                elseif k==1
                 HOSTCELL = HOSTNUM_C(j,i,k);
                 ipr=iparent(j,i,k); 
                 jpr=jparent(j,i,k); 
                 kpr=kparent(j,i,k);
                 stute_Wz = Uten(HOSTCELL-DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr)-zp(kpr-1))+sigman(HOSTCELL-DX3D*DY3D)*0.5*(z(k+1)-z(k))); 
                 stute_P  = (stute_Wz);
               STUte(n) = stute_P;
               %far face******from top view bottom face                
                elseif k==DZ3DC
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Ez = Uten(HOSTCELL+DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr+2)-zp(kpr+1))+sigman(HOSTCELL+DX3D*DY3D)*0.5*(z(k+1)-z(k)));    
                  stute_P  = (stute_Ez);
               STUte(n) = stute_P;                
               end
           end
       end
   end
   for i=floor(DX3DC/4)+1:floor(DX3DC/2)
       for j = 2:DY3DC-1
           for k = 2:DZ3DC-1
                n=(k-1)*(DY3DC*DX3DC)+(i-1)*DY3DC+j;
                %---------this deals with all the non-boundary elements
                  STUte(n) = 0; 
                                       
            end
        end
    end   
end
%Assign parts of sparse matrix to 3rd core
if labindex==3
   for i=floor(DX3DC/2)+1:floor(0.75*DX3DC)
       for j = 1:DY3DC
           for k = 1:DZ3DC
                n=(k-1)*(DY3DC*DX3DC)+(i-1)*DY3DC+j;
               %----------------defines edges of resistance matrix -----------                
               %N edge min z******from top view N edge
               if (j==1 && k==1)
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k);
                  kpr=kparent(j,i,k);
                  stute_Wy = Uten(HOSTCELL-1)*sigma(j,i,k)*sigman(HOSTCELL-1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr)-yp(jpr-1))+sigman(HOSTCELL-1)*0.5*(y(j+1)-y(j)));       
                  stute_Wz = Uten(HOSTCELL-DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr)-zp(kpr-1))+sigman(HOSTCELL-DX3D*DY3D)*0.5*(z(k+1)-z(k))); 
                  stute_P  = (stute_Wy +  stute_Wz);
               STUte(n) = stute_P;                
               %N edge max z******from top view N edge
               elseif (j==1 && k==DZ3DC)
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k);
                  jpr=jparent(j,i,k);
                  kpr=kparent(j,i,k);
                  stute_Wy = Uten(HOSTCELL-1)*sigma(j,i,k)*sigman(HOSTCELL-1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr)-yp(jpr-1))+sigman(HOSTCELL-1)*0.5*(y(j+1)-y(j)));       
                  stute_Ez = Uten(HOSTCELL+DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr+2)-zp(kpr+1))+sigman(HOSTCELL+DX3D*DY3D)*0.5*(z(k+1)-z(k)));    
                  stute_P  = (stute_Wy +  stute_Ez);
               STUte(n) = stute_P; 
               %S edge min z******from top view S edge
               elseif (j==DY3DC && k==1)
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Ey = Uten(HOSTCELL+1)*sigma(j,i,k)*sigman(HOSTCELL+1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr+2)-yp(jpr+1))+sigman(HOSTCELL+1)*0.5*(y(j+1)-y(j)));     
                  stute_Wz = Uten(HOSTCELL-DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr)-zp(kpr-1))+sigman(HOSTCELL-DX3D*DY3D)*0.5*(z(k+1)-z(k))); 
                  stute_P  = (stute_Ey +  stute_Wz);
               STUte(n) = stute_P; 
               %S edge max z******from top view S edge 
               elseif (j==DY3DC && k==DZ3DC)
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Ey = Uten(HOSTCELL+1)*sigma(j,i,k)*sigman(HOSTCELL+1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr+2)-yp(jpr+1))+sigman(HOSTCELL+1)*0.5*(y(j+1)-y(j)));     
                  stute_Ez = Uten(HOSTCELL+DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr+2)-zp(kpr+1))+sigman(HOSTCELL+DX3D*DY3D)*0.5*(z(k+1)-z(k)));    
                  stute_P  = (stute_Ey +  stute_Ez);
               STUte(n) = stute_P;
               %----------------define surface boundaries               
               %N face******from top view N face
               elseif j==1
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k);
                  kpr=kparent(j,i,k);
                  stute_Wy = Uten(HOSTCELL-1)*sigma(j,i,k)*sigman(HOSTCELL-1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr)-yp(jpr-1))+sigman(HOSTCELL-1)*0.5*(y(j+1)-y(j)));       
                  stute_P  = (stute_Wy);
               STUte(n) = stute_P;
               %S face******from top view S face    
               elseif j==DY3DC
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Ey = Uten(HOSTCELL+1)*sigma(j,i,k)*sigman(HOSTCELL+1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr+2)-yp(jpr+1))+sigman(HOSTCELL+1)*0.5*(y(j+1)-y(j)));     
                  stute_P  = (stute_Ey);
               STUte(n) = stute_P;
               %near face******from top view top face
                elseif k==1
                  HOSTCELL = HOSTNUM_C(j,i,k); 
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Wz = Uten(HOSTCELL-DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr)-zp(kpr-1))+sigman(HOSTCELL-DX3D*DY3D)*0.5*(z(k+1)-z(k))); 
                  stute_P  = (stute_Wz);
               STUte(n) = stute_P;
               %far face******from top view bottom face                
                elseif k==DZ3DC
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k);
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Ez = Uten(HOSTCELL+DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr+2)-zp(kpr+1))+sigman(HOSTCELL+DX3D*DY3D)*0.5*(z(k+1)-z(k)));    
                  stute_P  = (stute_Ez);
               STUte(n) = stute_P;                 
               end
           end
       end
   end
   for i=floor(DX3DC/2)+1:floor(0.75*DX3DC)
       for j = 2:DY3DC-1
           for k = 2:DZ3DC-1
                n=(k-1)*(DY3DC*DX3DC)+(i-1)*DY3DC+j;
                %---------this deals with all the non-boundary elements
                  STUte(n) = 0;
                                       
            end
        end
    end   
end
%Assign parts of sparse matrix to 4th core
if labindex==4
   for i=floor(0.75*DX3DC)+1:DX3DC
       for j = 1:DY3DC
           for k = 1:DZ3DC
                n=(k-1)*(DY3DC*DX3DC)+(i-1)*DY3DC+j;
               %NE corner******from top view NE corner
               %min z
               if (i==DX3DC && j==1) && k==1
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Ex = Uten(HOSTCELL+DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DY3D)*(y(j+1)-y(j))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(xp(ipr+2)-xp(ipr+1))+sigman(HOSTCELL+DY3D)*0.5*(x(i+1)-x(i)));    
                  stute_Wy = Uten(HOSTCELL-1)*sigma(j,i,k)*sigman(HOSTCELL-1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr)-yp(jpr-1))+sigman(HOSTCELL-1)*0.5*(y(j+1)-y(j)));        
                  stute_Wz = Uten(HOSTCELL-DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr)-zp(kpr-1))+sigman(HOSTCELL-DX3D*DY3D)*0.5*(z(k+1)-z(k))); 
                  stute_P  = (stute_Ex + stute_Wy + stute_Wz);
                STUte(n) = stute_P;
               %max z
               elseif (i==DX3DC && j==1) && k==DZ3DC
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k);
                  jpr=jparent(j,i,k);
                  kpr=kparent(j,i,k);
                  stute_Ex = Uten(HOSTCELL+DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DY3D)*(y(j+1)-y(j))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(xp(ipr+2)-xp(ipr+1))+sigman(HOSTCELL+DY3D)*0.5*(x(i+1)-x(i)));    
                  stute_Wy = Uten(HOSTCELL-1)*sigma(j,i,k)*sigman(HOSTCELL-1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr)-yp(jpr-1))+sigman(HOSTCELL-1)*0.5*(y(j+1)-y(j)));        
                  stute_Ez = Uten(HOSTCELL+DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr+2)-zp(kpr+1))+sigman(HOSTCELL+DX3D*DY3D)*0.5*(z(k+1)-z(k)));    
                  stute_P  = (stute_Ex + stute_Wy + stute_Ez);
                STUte(n) = stute_P;
               %SE corner******from top view SE corner
               %min z
               elseif (i==DX3DC && j==DY3DC) && k==1
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k);
                  kpr=kparent(j,i,k);
                  stute_Ex = Uten(HOSTCELL+DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DY3D)*(y(j+1)-y(j))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(xp(ipr+2)-xp(ipr+1))+sigman(HOSTCELL+DY3D)*0.5*(x(i+1)-x(i)));    
                  stute_Ey = Uten(HOSTCELL+1)*sigma(j,i,k)*sigman(HOSTCELL+1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr+2)-yp(jpr+1))+sigman(HOSTCELL+1)*0.5*(y(j+1)-y(j)));      
                  stute_Wz = Uten(HOSTCELL-DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr)-zp(kpr-1))+sigman(HOSTCELL-DX3D*DY3D)*0.5*(z(k+1)-z(k))); 
                  stute_P  = (stute_Ex + stute_Ey + stute_Wz);
                STUte(n) = stute_P; 
               %max z
               elseif (i==DX3DC && j==DY3DC) && k==DZ3DC
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Ex = Uten(HOSTCELL+DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DY3D)*(y(j+1)-y(j))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(xp(ipr+2)-xp(ipr+1))+sigman(HOSTCELL+DY3D)*0.5*(x(i+1)-x(i)));    
                  stute_Ey = Uten(HOSTCELL+1)*sigma(j,i,k)*sigman(HOSTCELL+1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr+2)-yp(jpr+1))+sigman(HOSTCELL+1)*0.5*(y(j+1)-y(j)));      
                  stute_Ez = Uten(HOSTCELL+DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr+2)-zp(kpr+1))+sigman(HOSTCELL+DX3D*DY3D)*0.5*(z(k+1)-z(k)));    
                  stute_P  = (stute_Ex + stute_Ey + stute_Ez);
                STUte(n) = stute_P; 
               %----------------defines edges of resistance matrix -----------
               %NE edge******from top view NE corner
               elseif (i==DX3DC && j==1)
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k);
                  jpr=jparent(j,i,k);
                  kpr=kparent(j,i,k);
                  stute_Ex = Uten(HOSTCELL+DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DY3D)*(y(j+1)-y(j))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(xp(ipr+2)-xp(ipr+1))+sigman(HOSTCELL+DY3D)*0.5*(x(i+1)-x(i)));   
                  stute_Wy = Uten(HOSTCELL-1)*sigma(j,i,k)*sigman(HOSTCELL-1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr)-yp(jpr-1))+sigman(HOSTCELL-1)*0.5*(y(j+1)-y(j)));       
                  stute_P  = (stute_Ex +  stute_Wy);
               STUte(n) = stute_P;
               %SE edge******from top view SE corner 
               elseif (i==DX3DC && j==DY3DC)
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Ex = Uten(HOSTCELL+DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DY3D)*(y(j+1)-y(j))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(xp(ipr+2)-xp(ipr+1))+sigman(HOSTCELL+DY3D)*0.5*(x(i+1)-x(i)));   
                  stute_Ey = Uten(HOSTCELL+1)*sigma(j,i,k)*sigman(HOSTCELL+1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr+2)-yp(jpr+1))+sigman(HOSTCELL+1)*0.5*(y(j+1)-y(j)));     
                  stute_P  = (stute_Ex +  stute_Ey);
               STUte(n) = stute_P;
               %E edge min z******from top view E egde  
               elseif (i==DX3DC && k==1)
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Ex = Uten(HOSTCELL+DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DY3D)*(y(j+1)-y(j))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(xp(ipr+2)-xp(ipr+1))+sigman(HOSTCELL+DY3D)*0.5*(x(i+1)-x(i)));   
                  stute_Wz = Uten(HOSTCELL-DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr)-zp(kpr-1))+sigman(HOSTCELL-DX3D*DY3D)*0.5*(z(k+1)-z(k))); 
                  stute_P  = (stute_Ex +  stute_Wz);
               STUte(n) = stute_P;
               %E edge max z     
               elseif (i==DX3DC && k==DZ3DC)
                  HOSTCELL = HOSTNUM_C(j,i,k); ipr=iparent(j,i,k); jpr=jparent(j,i,k); kpr=kparent(j,i,k);
                  stute_Ex = Uten(HOSTCELL+DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DY3D)*(y(j+1)-y(j))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(xp(ipr+2)-xp(ipr+1))+sigman(HOSTCELL+DY3D)*0.5*(x(i+1)-x(i)));   
                  stute_Ez = Uten(HOSTCELL+DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr+2)-zp(kpr+1))+sigman(HOSTCELL+DX3D*DY3D)*0.5*(z(k+1)-z(k)));    
                  stute_P  = (stute_Ex +  stute_Ez);
               STUte(n) = stute_P;
               %N edge min z******from top view N egde  
               elseif (j==1 && k==1)
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k);
                  kpr=kparent(j,i,k);
                  stute_Wy = Uten(HOSTCELL-1)*sigma(j,i,k)*sigman(HOSTCELL-1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr)-yp(jpr-1))+sigman(HOSTCELL-1)*0.5*(y(j+1)-y(j)));       
                  stute_Wz = Uten(HOSTCELL-DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr)-zp(kpr-1))+sigman(HOSTCELL-DX3D*DY3D)*0.5*(z(k+1)-z(k))); 
                  stute_P  = (stute_Wy +  stute_Wz);
               STUte(n) = stute_P;                  
               %N edge max z
               elseif (j==1 && k==DZ3DC)
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Wy = Uten(HOSTCELL-1)*sigma(j,i,k)*sigman(HOSTCELL-1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr)-yp(jpr-1))+sigman(HOSTCELL-1)*0.5*(y(j+1)-y(j)));       
                  stute_Ez = Uten(HOSTCELL+DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr+2)-zp(kpr+1))+sigman(HOSTCELL+DX3D*DY3D)*0.5*(z(k+1)-z(k)));    
                  stute_P  = (stute_Wy +  stute_Ez);
               STUte(n) = stute_P;
               %S edge min z******from top view S egde
               elseif (j==DY3DC && k==1)
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k);
                  kpr=kparent(j,i,k);
                  stute_Ey = Uten(HOSTCELL+1)*sigma(j,i,k)*sigman(HOSTCELL+1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr+2)-yp(jpr+1))+sigman(HOSTCELL+1)*0.5*(y(j+1)-y(j)));     
                  stute_Wz = Uten(HOSTCELL-DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr)-zp(kpr-1))+sigman(HOSTCELL-DX3D*DY3D)*0.5*(z(k+1)-z(k))); 
                  stute_P  = (stute_Ey +  stute_Wz);
               STUte(n) = stute_P; 
               %S edge max z 
               elseif (j==DY3DC && k==DZ3DC)
                  HOSTCELL = HOSTNUM_C(j,i,k); 
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Ey = Uten(HOSTCELL+1)*sigma(j,i,k)*sigman(HOSTCELL+1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr+2)-yp(jpr+1))+sigman(HOSTCELL+1)*0.5*(y(j+1)-y(j)));     
                  stute_Ez = Uten(HOSTCELL+DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr+2)-zp(kpr+1))+sigman(HOSTCELL+DX3D*DY3D)*0.5*(z(k+1)-z(k)));    
                  stute_P  = (stute_Ey +  stute_Ez);
               STUte(n) = stute_P;
               %----------------define surface boundaries 
               %E face******from top view E face
               elseif i==DX3DC
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Ex = Uten(HOSTCELL+DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DY3D)*(y(j+1)-y(j))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(xp(ipr+2)-xp(ipr+1))+sigman(HOSTCELL+DY3D)*0.5*(x(i+1)-x(i)));   
                  stute_P  = (stute_Ex);
               STUte(n) = stute_P;
            
               %N face******from top view N face
               elseif j==1
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Wy = Uten(HOSTCELL-1)*sigma(j,i,k)*sigman(HOSTCELL-1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr)-yp(jpr-1))+sigman(HOSTCELL-1)*0.5*(y(j+1)-y(j)));       
                  stute_P  = (stute_Wy);
               STUte(n) = stute_P;
               %S face******from top view S face    
               elseif j==DY3DC
                  HOSTCELL = HOSTNUM_C(j,i,k);
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Ey = Uten(HOSTCELL+1)*sigma(j,i,k)*sigman(HOSTCELL+1)*(x(i+1)-x(i))*(z(k+1)-z(k))/(sigma(j,i,k)*0.5*(yp(jpr+2)-yp(jpr+1))+sigman(HOSTCELL+1)*0.5*(y(j+1)-y(j)));     
                  stute_P  = (stute_Ey);
               STUte(n) = stute_P;
               %near face******from top view top face
                elseif k==1
                  HOSTCELL = HOSTNUM_C(j,i,k); 
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Wz = Uten(HOSTCELL-DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL-DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr)-zp(kpr-1))+sigman(HOSTCELL-DX3D*DY3D)*0.5*(z(k+1)-z(k))); 
                  stute_P  = (stute_Wz);
               STUte(n) = stute_P;
               %far face******from top view bottom face                
                elseif k==DZ3DC
                  HOSTCELL = HOSTNUM_C(j,i,k); 
                  ipr=iparent(j,i,k); 
                  jpr=jparent(j,i,k); 
                  kpr=kparent(j,i,k);
                  stute_Ez = Uten(HOSTCELL+DX3D*DY3D)*sigma(j,i,k)*sigman(HOSTCELL+DX3D*DY3D)*(x(i+1)-x(i))*(y(j+1)-y(j))/(sigma(j,i,k)*0.5*(zp(kpr+2)-zp(kpr+1))+sigman(HOSTCELL+DX3D*DY3D)*0.5*(z(k+1)-z(k)));    
                  stute_P  = (stute_Ez);
               STUte(n) = stute_P;                 
               end
           end
       end
   end
   for i=floor(0.75*DX3DC)+1:DX3DC-1
       for j = 2:DY3DC-1
           for k = 2:DZ3DC-1
                n=(k-1)*(DY3DC*DX3DC)+(i-1)*DY3DC+j;
                %---------this deals with all the non-boundary elements
                  STUte(n) = 0;                                      
            end
        end
    end   
end

end
%Extract parts of sparse matrix from each core and recombine into a single
%matrix
STUte1 = STUte{:,1};
STUte2 = STUte{:,2};
STUte3 = STUte{:,3};
STUte4 = STUte{:,4};
STUte=STUte1+STUte2+STUte3+STUte4;