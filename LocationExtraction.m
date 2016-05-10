fprintf('Locations are being extracted from candidate images...\n\n')

function info = LocationExtraction(source, format)

narginchk(1, 2);

info = [];

validateattributes(source,{'char'},{'nonempty'},'','FILENAME');

[isUrl, filename] = getFileFromURL(source);

if(isUrl)
    c = onCleanup(@()deleteDownload(filename));
end

if (nargin < 2)
  
    
    fid = fopen(filename, 'r');
    
    if (fid == -1)
      
        error(message('MATLAB:imagesci:imfinfo:fileOpen', filename));
               
    end
      
    filename = fopen(fid); 
    fclose(fid);
  
    [format, fmt_s] = imftype(filename);
    
    if (isempty(format))
      
        error(message('MATLAB:imagesci:imfinfo:whatFormat'));
        
    end
    
else
  
    fmt_s = imformats(format);
    
    if (isempty(fmt_s))
      
        error(message('MATLAB:imagesci:imfinfo:unknownFormat', format));
        
    end

    fid = fopen(filename, 'r');

    if (fid == -1)

    
        found = 0;
        
        for p = 1:length(fmt_s.ext)
          
            fid = fopen([filename '.' fmt_s.ext{p}], 'r');
            
            if (fid ~= -1)
              
                found = 1;
                
                filename = fopen(fid);
                fclose(fid);
                
                break;
                
            end
            
        end
        
        if (~found)
            
            error(message('MATLAB:imagesci:imfinfo:fileOpenWithExtension', filename));
            
        end

        
    else
      
        filename = fopen(fid);
        fclose(fid);
        
    end
    
    tf = feval(fmt_s.isa, filename);
    if ~tf
        error(message('MATLAB:imagesci:imfinfo:badFormat', filename, upper(format)));
    end

end

if (~isempty(fmt_s.info))
  
    info = feval(fmt_s.info, filename);
    
else
  
     error(message('MATLAB:imagesci:imfinfo:noInfoFunction', format));
        
end


if (isUrl)
    info.Filename = source;
end
histo = zeros(1,cluster_size);
for k = 1:size(indices,1)
        nearest_cluster_center = uint16(indices(k,1));
        histo(1,nearest_cluster_center) = histo(1,nearest_cluster_center)+1;
        latitude = output.GPSInfo.GPSLatitude
        longitude = output.GPSInfo.GPSLongitude

end
    
for i=1:cluster_size
   images = dir( fullfile(data_path, 'train', categories{i}, '*.jpg'));
   gps_latitude = get_if_exist(gps_info, 'GPSLatitude')
   gps_latitude_ref = get_if_exist(gps_info, 'GPSLatitudeRef')
   gps_longitude = get_if_exist(gps_info, 'GPSLongitude')
   gps_longitude_ref = get_if_exist(gps_info, 'GPSLongitudeRef')

   train_image_geocoordinates = cell(num_categories * num_train_per_cat, 1);
   test_image_geocoordinates  = cell(num_categories * num_train_per_cat, 1);
   
end
