library("rjson")
library("pdc")
library("arules")
library("Matrix")
BedPressure <- fromJSON(file = ("Data/A_66101100_Vector.json"))
BedPressure <- BedPressure$TimeVector
BasinPIR <- fromJSON(file = ("Data/A_6697115_Vector.json"))
BasinPIR <- BasinPIR$TimeVector
MicrowaveElectric <- fromJSON(file = ("Data/A_7710599_Vector.json"))
MicrowaveElectric <- MicrowaveElectric$TimeVector
MaindoorMagnetic <- fromJSON(file = ("Data/A_7797105_Vector.json"))
MaindoorMagnetic <- MaindoorMagnetic$TimeVector
SeatPressure <- fromJSON(file = ("Data/A_8310197_Vector.json"))
SeatPressure <- SeatPressure$TimeVector
ToasterElectric <- fromJSON(file = ("Data/A_8411197_Vector.json"))
ToasterElectric <- ToasterElectric$TimeVector
CabinetMagnetic <- fromJSON(file = ("Data/A_679798_Vector.json"))
CabinetMagnetic <- CabinetMagnetic$TimeVector
CooktopPIR <- fromJSON(file = ("Data/A_67111111_Vector.json"))
CooktopPIR <- CooktopPIR$TimeVector
FridgeMagnetic <- fromJSON(file = ("Data/A_70114105_Vector.json"))
FridgeMagnetic <- FridgeMagnetic$TimeVector
ShowerPIR <- fromJSON(file = ("Data/A_83104111_Vector.json"))
ShowerPIR <- ShowerPIR$TimeVector
ToiletFlush <- fromJSON(file = ("Data/A_84111105_Vector.json"))
ToiletFlush <- ToiletFlush$TimeVector
CupboardMagnetic <- fromJSON(file = ("Data/A_67117112_Vector.json"))
CupboardMagnetic <- CupboardMagnetic$TimeVector

dataM <- cbind(BedPressure,BasinPIR,MicrowaveElectric,MaindoorMagnetic,SeatPressure,ToasterElectric,CabinetMagnetic,CooktopPIR,FridgeMagnetic,ShowerPIR,ToiletFlush,CupboardMagnetic)

#dimnames(dataM) <- list( r("66101100","6697115","67111111","67117112","679798","70114105","7710599","7797105","8310197","83104111","84111105","8411197"))

dimnames(dataM) <- list(rownames(dataM, do.NULL = FALSE, prefix = "T"),colnames(dataM, do.NULL = FALSE, prefix = "Device"))
#dimnames(dataM) <- list( rownames(dataM, do.NULL = FALSE, prefix="T"), colnames("BedPressure","BasinPIR","MicrowaveElectric","MaindoorMagnetic","SeatPressure","ToasterElectric","CabinetMagnetic","CooktopPIR","FridgeMagnetic","ShowerPIR","ToiletFlush","CupboardMagnetic"))
#dimnames(dataM) <- list(colnames("BedPressure","BasinPIR","MicrowaveElectric","MaindoorMagnetic","SeatPressure","ToasterElectric","CabinetMagnetic","CooktopPIR","FridgeMagnetic","ShowerPIR","ToiletFlush","CupboardMagnetic"))
dataTrans <- as(dataM, "transactions")

dataClust <-  pdclust(dataM, m = NULL, t=NULL,divergence= symmetricAlphaDivergence,clustering.method = "complete" )
plot(dataClust, labels = NULL, type = "triangle", cols="blue", timeseries.as.labels = FALSE, p.values = F)