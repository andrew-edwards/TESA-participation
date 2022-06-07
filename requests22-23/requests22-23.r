# requests22-23.r - import .csv file from Google Form (manually add a return at
#  the end), and tidy up. Usually then just manually edit the spreadsheet. 24/5/22.

# requests19-20.r - import .csv file from Google Form (manually add a return at the end)
#  and this code tidies it up. 11th June 2019.
#  At some point then usually just manually edit the spreadsheet.

# requests18-19.r - import .csv file from Google Form and tidy up. 26th June 2018.
#  Based on requests17-18.r from 4th May 2017.

# Downloaded from Google Fosm on 27th May 2018 with 24 responses. If more come in
#  then add them to the spreadsheet manually.

rm(list = ls())
require(dplyr)

# stop("Do not re-run as am now manually working out the Priority for each course. Have resaved all-requests-comments.csv as PAC-TESA-requets-21.csv. Manually add to that now")
# 34 responses
tab_raw <- read.csv("TESA participation 2022-23.csv")
tab <- tibble::as_tibble(tab_raw) %>%
  mutate(Supervisor = NA,
         # Region = "PAC",
         Priority = NA) %>%
  dplyr::relocate(
           Surname,
           First.name,
           "Email" = "Username",
           Division,
           Supervisor,
           Priority,
           "Location" = "Work.location..to.estimate.travel.costs.",
           "HMM" =  "Hidden.Markov.Models",
           "sdmTMB" = "Spatial.and.spatiotemporal.models.with.sdmTMB",
           "ICES.TAFReproducible" =
             "Reproducible.science..best.practices.and.ICES.Transparent.Assessment.Framework",
           "PRStats" = "PR.Statistics..also.give.course.name.",
           "Highland" =
             "Highland.Statistics..also.give.course.name.",
           "PSBQ" =
             "X.The.Quebec.Centre.for.Biodiversity.Science..also.give.course.name.",
           "WS.anadromous" = "Anadromous.Fishes.Stock.Assessment",
           "WS.ageing" =
             "Best.practices.in.age.determination",
           "WS.LibStr" =
             "Diving.Deeper.into.Workshop.and.Meeting.Facilitation.using.Liberating.Structures",
           "Webinar.sdmTMB" = "Spatiotemporal.modelling.with.sdmTMB..on.demand.YouTube.recordings...do.in.your.own.time.just.let.us.know.here.",
           "Webinar.math" =
             "Some.guidance.on.using.mathematical.notation.in.biology",
           "Webinar.coding" = "Good.coding.practices",
           "Webinar.RP101" = "Reference.points.101",
           "Webinar.IKseries" = "Indigenous.knowledge.and.stock.assessment.webinar.series"
         ) %>%
  select(-Timestamp)

# Copy Lyanne's "Same answer as above":
# tab[which(tab$First.name == "Lyanne"), "Ghement.advanced.ts"]  <-
#   tab[which(tab$First.name == "Lyanne"), "Ghement.linear.ts"]

events = names(tab)[8:21]   # change manually

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
      ## # Individual files for each event (though in 2021 lots of events, so doing
      ## # one big one
      ## if(FALSE){
      ##   write.csv(file=paste0(events[i],
      ##                         ".csv"),
      ##             temp,
      ##             quote = FALSE,
      ##             row.names = FALSE)   # Use this to decide priority
      ##   write.csv(file=paste0(events[i],
      ##                         "noComm.csv"),
      ##             select(temp,
      ##                    Priority,
      ##                    Surname,
      ##                    First.name,
      ##                    Location),
      ##             quote = FALSE,
      ##             row.names = FALSE)         # Save this and then add in priorities manually
      ## }

      # Try just doing to one file:
      temp <- rbind(rep(",", length(names(temp))),
                    c(names(temp)[length(names(temp))],
                      rep(",", length(names(temp))-1)),
                    temp)
      append <- ifelse(i == 1, FALSE, TRUE)   # appending if not first one
      if(!append){
        col.names <- names(temp)
        col.names[length(col.names)] = "Comment"
      } else {
        col.names = FALSE
      }
      write.table(file = "all-requests-comments.csv",
                  temp,
                  quote = TRUE,
                  sep = ",",
                  row.names = FALSE,
                  append = append,
                  col.names = col.names)

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
