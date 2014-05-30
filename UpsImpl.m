classdef UpsImpl < PowerEquipmentImpl
    
    properties
        airflowPerKw = 0;
    end
    
    methods
        function ups = UpsImpl(name, width, height, depth, positionX, positionZ, orientation, airflowPerKw, power)
            ups@PowerEquipmentImpl(name, width, height, depth, positionX, positionZ, orientation, power);
            airflowPerKw = str2double(airflowPerKw);
            power = str2double(power);
            if (power > 0)
                ups.airflowPerKw = airflowPerKw/power;
            else
                ups.airflowPerKw = 0.0;
            end
        end
        
        % function to set the Airflow per Kw for a UPS.
        function setAirflowOfDataCenterEquipment(ups, airflowPerKw)
             if (isnumeric(airflowPerKw) && (airflowPerKw >= 0) && (ups.power > 0))  
                 airflowPerKw = str2double(airflowPerKw);
                 ups.airflowPerKw = airflowPerKw/ups.power;
             else
                 ups.airflowPerKw = 0.0;
             end
        end
    end
    
end

