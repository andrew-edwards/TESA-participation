# requests19-20.r - import .csv file from Google Form (manually add a return at the end)
#  and this code tidies it up. 11th June 2019.
#  At some point then usually just manually edit the spreadsheet.

# requests18-19.r - import .csv file from Google Form and tidy up. 26th June 2018.
#  Based on requests17-18.r from 4th May 2017.

# Downloaded from Google Fosm on 27th May 2018 with 24 responses. If more come in
#  then add them to the spreadsheet manually.

rm(list = ls())
require(dplyr)

tab = read.csv("Pacific TESA participation 2019-20.csv")
tab = tbl_df(tab)

names(tab)[names(tab) == "Work.location..to.estimate.travel.costs."] = "Location"
names(tab)[names(tab) == "Five.day.Introduction.to.Stock.Assessment.Course"] =
                            "IntroSA"
names(tab)[names(tab) == "Spatial.Analysis.with.Geostatistics.and.R.INLA.Course"] = "Spatial"
names(tab)[names(tab) ==
       "Data.Poor.Stock.Assessment.Methods.Course"] = "DataPoor"
names(tab)[names(tab) ==
       "Uncertainty.and.Risk.in.Fisheries.Science.Advice.Workshop."] = "UncertWorkshop"


tab = select(tab, -Timestamp)
tab = mutate(tab, Name = paste(First.name, Surname),
             Region = "PAC",
             Priority = NA)
events = names(tab)[6:9]

# May need this based on 17-18 to shorten any long answers
#tab = tbl_df(lapply(tab, function(x) {
#                  gsub("TMB.II.Course",
#                       "TMB2", x) }) )


# 2017-18 had to do all this manual stuff, but hopefully avoid this year
#  (just fill the form for any late/new people? - or add manually to the main .csv)
# Need to add Kathryn back in manually for DLMtool as I deleted her thinking
#  I could add it to her response on the Form, but I can't. In future will
#  be easier to stick with one answer per row for the form.
# write.csv(file="temp.csv", tab)
# Just do manually on a .csv file - not ideal but only a one off and save as
#  temp2.csv to then reload in.
# Doing the following - add Kathryn for DLMtool, split up those with ; into
#  two rows, Remove (Murrell) from Erin's, bput Vanessa's division as ESD.
# Adding Carrie in also, as she didn't do the form.
# And updated since Sue Grant and Mike Hawkshaw now filled out form, plus
#  Dawn and new BI-03 as per Arlene's email.
# Adding Diana McHugh and Brittany Jenewein who filled out form (23/5/17).
# Reordering manually. Remove Carrie and new BI-03 from Salmon.
# Reordering for Salmon as per Carrie's email of 23/5/17
# Reordering for ESD as per Eddy's email of 26/5/17
# Adding Rob Kronlund for DLMtool. 7/6/17.

#tab2 = read.csv("temp2.csv")
#tab2 = tbl_df(tab2)
#tab2 = select(tab2, -1)

#tab2 = arrange(tab2, desc(Event))
#print(as.data.frame(tab2))

# I used descriptions for people to explain why they're interested in an event.
#  So want to get a tbl_df for each event.



# One table for each event, just keeping what's needed for spreadsheet, though want Division to help rank
#  sym() is from https://edwinth.github.io/blog/dplyr-recipes/ thanks
#  to Sean Anderson.
for(i in 1:length(events)){
    temp = filter(tab, !!sym(events[i]) != "")
    temp = select(temp,
                  Region,
                  Division,
                  Priority,
                  Name,
                  Location,
                  events[i])
#    assign(paste0(events[i], "-tab"),
#           select(noquote(paste0(events[i], "-tab")),
    assign(paste0(events[i], ".tab"), temp)
    write.csv(file=paste0(events[i], ".csv"),
              temp, quote = FALSE, row.names = FALSE)
    write.csv(file=paste0(events[i], "noComm.csv"),
              select(temp, Region, Priority, Name, Location),
              quote = FALSE, row.names = FALSE)

}

# print(as.data.frame(select(tab2, First.name, Surname, Work.location)))

# write.csv(file="temp3.csv", tab2)

# tabJustQAM = filter(tab2, Division == "ARRAD")
# Have to manually filter further
# tabJustQAM = filter(tabJustQAM, First.name %in% c("Kendra", "Brooke",
#    "Carrie", "Katherine", "Robyn", "Andrew", "Wayne"))
# Don't need DLMtool for costs:
# tabJustQAM = filter(tabJustQAM, Event %in% c("Salmon", "GLMM"))

# tabJustQAM = select(tabJustQAM, Surname, First.name, Event)

# tabJustESD = filter(tab2, Division == "ESD", Event == "GLMM")


print(as.data.frame(IntroSA.tab))
print(Spatial.tab)
print(DataPoor.tab)
print(UncertWorkshop.tab)
