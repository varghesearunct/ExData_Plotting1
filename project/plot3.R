#opening file "household_power_consumption.txt"

f<-file("household_power_consumption.txt")

#reading only the lines starting with 1/2/2007 or 2/2/2007

val<-read.csv(text = grep("^[1,2]/2/2007", readLines(f), value = T), sep = ";",stringsAsFactors=F,header=F)

#naming the column variables

names(val)<-c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

#converting the date and time class to POSIXct class
val$tim<-paste(val$Date,val$Time,sep='_')
val$tim<-as.POSIXct(strptime(val$tim,"%d/%m/%Y_%H:%M:%S"))

#opening the file device
png(file="plot3.png")

#plotting the graph

with(val,plot(Sub_metering_1~tim,ylab="Energy sub metering",type='l',xlab=""))
lines(val$Sub_metering_2~val$tim,col='red')
lines(val$Sub_metering_3~val$tim,col='blue')
legend("topright",legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black","red","blue"),lty=1,lwd=2)
dev.off()

