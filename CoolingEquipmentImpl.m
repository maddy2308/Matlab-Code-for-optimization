classdef CoolingEquipmentImpl < DataCenterItemImpl
    
    
    properties
        type='';
        ratingPower = 0;
    end    
    
    methods
        
        function coolingEquipment = CoolingEquipmentImpl(name, width, height, depth, positionX, positionZ, orientation)
            coolingEquipment@DataCenterItemImpl(name, width, height, depth, positionX, positionZ, orientation);            
        end
		
        % set the rating power of Cooling equipment(Chiller & CRAH)
		function setRatingPowerOfCoolingEquipment(coolingEquipment, ratingPower)
			coolingEquipment.ratingPower = ratingPower;
        end
        
        % set the type of Cooling equipment(Chiller & CRAH)
		function setTypeOfCoolingEquipment(coolingEquipment, type)
			coolingEquipment.type = type;
        end
        
    end
    
end

