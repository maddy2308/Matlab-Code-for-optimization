classdef DataCenterEquipmentImpl < DataCenterItemImpl & handle
    
    % DataCenterEquipment is a subclass of the DataCenterItem and is valid 
    % all those items that have power and airflow 
    
    properties(SetAccess='private')
        power = 0;                
    end
    
    methods
        %constructor to initialize the data center equipment class;
        function dce = DataCenterEquipmentImpl(name, width, height, depth, positionX, positionZ, orientation, power)     
            dce@DataCenterItemImpl(name, width, height, depth, positionX, positionZ, orientation);
            dce.power = str2double(power);
        end
        
        function setPowerOfDataCenterEquipment(dce, power)
             if (isnumeric(power) && (power >= 0))  
                 dce.power = str2double(power);
             end
        end
        
    end
    
    
end

