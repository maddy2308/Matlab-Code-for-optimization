classdef RackImpl < DataCenterEquipmentImpl
    %UNTITLED6 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(SetAccess='private')
        isDucted = false;
        airflowPerKw = 0;
    end
    
    methods
        
        function rack = RackImpl(name, width, height, depth, positionX, positionZ, orientation, airflowPerKw, power, isDucted)
            rack@DataCenterEquipmentImpl(name, width, height, depth, positionX, positionZ, orientation, power);
            
            if (strcmpi(isDucted, 'NO')) 
                rack.isDucted = false;
            else
                rack.isDucted = true;
            end
            if (str2double(power) > 0)
                airflowPerKw = str2double(airflowPerKw);
                power = str2double(power);
                rack.airflowPerKw = airflowPerKw/power;
            else
                rack.airflowPerKw = 0;
            end
        end
        
        % function to set the ducted propert of Rack
        % input boolean values only
        function setDuctPropertyOfDataCenterEquipment(rack, isDucted)  
            if(isDucted == ture || isDucted == false)
                rack.isDucted = isDucted;
            else
                disp('value passed for ducted property is not boolean or not in lower case i.e. true/false')
            end
        end 
        
        % function to set the Airflow per Kw for a rack.
        function setAirflowOfDataCenterEquipment(rack, airflowPerKw)
             if (isnumeric(airflowPerKw) && (airflowPerKw >= 0) && (rack.power > 0))                 
                 rack.airflowPerKw = airflowPerKw/(rack.power);
             else
                 rack.airflowPerKw = 0;
             end
        end
    end
    
end

