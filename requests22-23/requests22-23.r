# requests22-23.r - import .csv file from Google Form (manually add a return at
#  the end), and tidy up. Usually then just manually edit the spreadsheet. 24/6/22.

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
tab <- tibble::as_tibble(tab_raw)

tab <- dplyr::rename(tab,
                     "Location" = "Work.location..to.estimate.travel.costs.",
                     "HMM" =  "Hidden.Markov.Models",
                     "sdmTMB" = "Spatial.and.spatiotemporal.models.with.sdmTMB",
                     "Reproducible" =
                       "Reproducible.science..best.practices.and.ICES.Transparent.Assessment.Framework",
                     "PR" = "PR.Statistics..also.give.course.name.",
                     "Highland" =
                       "Highland.Statistics..also.give.course.name.",
                     "Quebec" =
                       "X.The.Quebec.Centre.for.Biodiversity.Science..also.give.course.name.",
                     "Anadromous" = "Anadromous.Fishes.Stock.Assessment",
                     "Ages" =
                       "Best.practices.in.age.determination",
                     "Liberating" =
                       "Diving.Deeper.into.Workshop.and.Meeting.Facilitation.using.Liberating.Structures",
#                     "sdmTMBYouTube" = "Spatiotemporal.modelling.with.sdmTMB...time.just.let.us.know.here.",   # May need tweaking
                     "Notation" =
                       "Some.guidance.on.using.mathematical.notation.in.biology",
                     "Coding" = "Good.coding.practices",
                     "RefPoints" = "Reference.points.101",
                     "Indigenous" = "Indigenous.knowledge.and.stock.assessment.webinar.series"
                     ) %>%
  select(-Timestamp)

# Copy Lyanne's "Same answer as above":
# tab[which(tab$First.name == "Lyanne"), "Ghement.advanced.ts"]  <-
#   tab[which(tab$First.name == "Lyanne"), "Ghement.linear.ts"]

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
      # Individual files for each event (though in 2021 lots of events, so doing
      # one big one
      if(FALSE){
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
                  row.names = FALSE)         # Save this and then add in priorities manually
      }

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
