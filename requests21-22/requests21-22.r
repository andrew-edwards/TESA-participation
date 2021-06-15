# requests21-22.r - import .csv file from Google Form (manually add a return at
#  the end), and tidy up. Usually then just manually edit the spreadsheet. 15/6/21.

# requests19-20.r - import .csv file from Google Form (manually add a return at the end)
#  and this code tidies it up. 11th June 2019.
#  At some point then usually just manually edit the spreadsheet.

# requests18-19.r - import .csv file from Google Form and tidy up. 26th June 2018.
#  Based on requests17-18.r from 4th May 2017.

# Downloaded from Google Fosm on 27th May 2018 with 24 responses. If more come in
#  then add them to the spreadsheet manually.

rm(list = ls())
require(dplyr)

# 34 responses
tab_raw <- read.csv("Pacific TESA participation requests 2021-22.csv")
tab <- tibble::as_tibble(tab_raw)

tab <- dplyr::rename(tab,
                     "Location" = "Work.location",
                     "Ghement.linear.ts" =
                       "X1..Linear.and.additive.models.for.time.series.data",
                     "Ghement.advanced.ts" =
                       "X2..Advanced.statistics.for.time.series.data",
                     "PR.Bayesian" =
                       "X3..Bayesian.data.analysis.and.introduction.to.STAN.modelling",
                     "PR.wrangling" =
                       "X4..Data.wrangling.and.visualization.in.R",
                     "ICES.MSE" =
                       "X5..ICES...Introduction.to.Management.Strategy.Evaluation",
                     "ICES.SA" = "X6..ICES...Introduction.to.stock.assessment",
                     "ICES.tagging" =
                       "X7..ICES...Large.scale.tag.recapture.campaigns",
                     "Workshop.ref.points" =
                       "X8..Workshop...reference.points.for.Fish.Stocks.Provisions.",
                     "Workshop.ageing" =
                       "X9..Workshop...ageing.data.best.practices.for.stock.assessments",
                     "PR.other.1" = "X10..PR.statistics...other.course",
                     "PR.other.2" =
                       "X11..PR.statistics...another.course..if.you.have.a.second.") %>%
  select(-Timestamp)

# Copy Lyanne's "Same answer as above":
tab[which(tab$First.name == "Lyanne"), "Ghement.advanced.ts"]  <-
  tab[which(tab$First.name == "Lyanne"), "Ghement.linear.ts"]

tab = mutate(tab,
             Region = "PAC",
             Priority = NA)
events = names(tab)[6:16]

# May need this based on 17-18 to shorten any long answers
#tab = tbl_df(lapply(tab, function(x) {
#                  gsub("TMB.II.Course",
#                       "TMB2", x) }) )


# I used descriptions for people to explain why they're interested in an event.
#  So want to get a tbl_df for each event.

# One table for each event, just keeping what's needed for spreadsheet, though want Division to help rank
#  sym() is from https://edwinth.github.io/blog/dplyr-recipes/ thanks
#  to Sean Anderson.
for(i in 1:length(events)){
    temp = filter(tab, !!sym(events[i]) != "")
    temp = select(temp,
                  Surname,
                  First.name,
                  Email,
                  Division,
                  Priority,
                  Location,
                  events[i])
    print(events[i])
    print(select(temp, -events[i]))
#    assign(paste0(events[i], "-tab"),
#           select(noquote(paste0(events[i], "-tab")),
    #    assign(paste0(events[i], ".tab"), temp)
    if(nrow(temp) > 0){
      write.csv(file=paste0(events[i],
                            ".csv"),
                temp,
                quote = FALSE,
                row.names = FALSE)   # Use this to decide priority
      write.csv(file=paste0(events[i],
                            "noComm.csv"),
                select(temp,
                       Priority,
                       Surname,
                       First.name,
                       Location),
                quote = FALSE,
                row.names = FALSE)         # Save this and then add
                                           # in priorities manually
    }

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
