library("rjson")
library("pdc")
library("arules")
library("Matrix")
library("TraMineR")
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



dimnames(dataM) <- list(rownames(dataM, do.NULL = FALSE, prefix = "T"),colnames(dataM, do.NULL = FALSE, prefix = "Device"))
dataTrans <- as(dataM, "transactions")

#Converting to a logical dataset
#dataLog <- as.logical(dataM) 

png(filename = "itemFreqPlot.png", width=700, height=700)
itemFrequencyPlot(dataTrans)
dev.off()

dataClust <-  pdclust(dataM, m = NULL, t=NULL,divergence= symmetricAlphaDivergence,clustering.method = "complete" )

png(filename = "hClust.png", width=700, height=700)
plot(dataClust, labels = NULL, type = "triangle", cols="blue", timeseries.as.labels = FALSE, p.values = F)
dev.off()

#Sequence part
seq <- read.csv("Data/SequenceData.txt", header = FALSE)
seq <- seqdecomp(seq)
seq <- seqdef(seq, informat = "DSS")

#Output plots
#Visualisation of the states in each state successions Assumed to be same length
png(filename = "seqPlot.png", width=700, height=700)
seqiplot(seq, title = "State successions, visualised", withlegend= FALSE)
dev.off()

#Display of general state distributions patterns 
png(filename = "stateDistPlot.png", width=700, height=700)
seqdplot(seq, title = "State distribution plot", withlegend = FALSE, border = NA)
dev.off()

#Most frequent sequences, in order
png(filename = "seqFreqPlot.png", width=700, height=700)
seqfplot(seq, title = "Sequence frequency plot", withlegend = FALSE)
dev.off()


#Entropy with regards to state transitions
png(filename = "activityEntropy.png", width=700, height=700)
seqHtplot(seq, title = "State Traversal Entropy through the day", withlegend = FALSE)  #sequence entropy
dev.off()

#Legend
png(filename = "legend.png")
seqlegend(seq, title = "Legend")
dev.off()

#compute transition probabilities
seqTrans <- seqtrate(seq)

# Frequent sequences
fseq <- seqefsub(seqecreate(seq), pMinSupport = 0.7)


png(filename = "freqSubSeq.png", width=700, height=700)
plot(fseq, col="cyan", main = "Most Frequent State Transitions")
dev.off()