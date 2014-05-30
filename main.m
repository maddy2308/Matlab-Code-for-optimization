function main()
    dataCenterObjectsIncludingRoom = ImportEcostreamXml('MyRoom.xml');
    load2DModel(dataCenterObjectsIncludingRoom);
end