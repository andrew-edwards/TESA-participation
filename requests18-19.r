# requests18-19.r - import .csv file from Google Form and tidy up. 26th June 2018.
#  Based on requests17-18.r from 4th May 2017.

require(dplyr)

tab = read.csv("TESA18-19.csv")
tab = tbl_df(tab)

names(tab)[names(tab) == "Work.location..to.estimate.travel.costs."] = "Location"
names(tab)[names(tab) == "TMB.II.Course"] = "TMB2"
names(tab)[names(tab) == "Five.day.Introduction.to.Stock.Assessment.Course"] =
                            "IntroSA"
names(tab)[names(tab) == "Zero.inflated.Models.Course"] = "ZeroInf"
names(tab)[names(tab) ==
       "Transparent..Traceable.and.Transferable.Assessments.Workshop"] = "TTT"


** tab = select(tab, Surname, First.name, Division, Work.location, Event)

# I should have put shorter descriptions in the form to avoid this:
tab = tbl_df(lapply(tab, function(x) {
                  gsub("TMB.II.Course",
                       "TMB2", x) }) )
tab = tbl_df(lapply(tab, function(x) {
                  gsub("Introduction to mixed modelling and GLMM, Halifax",
                       "GLMM", x) }) )
tab = tbl_df(lapply(tab, function(x) {
                  gsub("Salmonid/anadromous assessment workshop, Moncton",
                       "Salmon", x) }) )
# Need to add Kathryn back in manually for DLMtool as I deleted her thinking
#  I could add it to her response on the Form, but I can't. In future will
#  be easier to stick with one answer per row for the form.
write.csv(file="temp.csv", tab)
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

tab2 = read.csv("temp2.csv")
tab2 = tbl_df(tab2)
tab2 = select(tab2, -1)

tab2 = arrange(tab2, desc(Event))
print(as.data.frame(tab2))

print(as.data.frame(select(tab2, First.name, Surname, Work.location)))

write.csv(file="temp3.csv", tab2)

# tabJustQAM = filter(tab2, Division == "ARRAD")
# Have to manually filter further
# tabJustQAM = filter(tabJustQAM, First.name %in% c("Kendra", "Brooke",
#    "Carrie", "Katherine", "Robyn", "Andrew", "Wayne"))
# Don't need DLMtool for costs:
# tabJustQAM = filter(tabJustQAM, Event %in% c("Salmon", "GLMM"))

# tabJustQAM = select(tabJustQAM, Surname, First.name, Event)

tabJustESD = filter(tab2, Division == "ESD", Event == "GLMM")
