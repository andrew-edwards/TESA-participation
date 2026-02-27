# requests25-26.r. 29 responses when downloading 10/3/25 9:26am. UPdated
# 12/3/25, added Lauren Gill and Noel Swain manually to
# all-requests-comments.csv for WHAM (easier than
# doing the input file, and don't expect to rerun all this again this year. Had
# to manually edit Jennifer and Katie's replies, as had extra " which
# complicated things. Then re-add Lauren and Noel. Do it in Excel as extra "
# still showing up in emacs. Must have added BI02 and Jaclyn manually, as when
# reran they disappeared off my list, so redoing. They are not in in the TESA
# participations 2025-2026.csv.

# 2025-2026, Jaclyn F not really keeping a master list (some regions just sent
#  numbers not names), so can update our
#  regional one to keep track, though I did rank people somehwere. I did start doing an updated list at the end
#  here, but seems that's not really needed. Just need it to send out info for
#  the WHAM list as that's all I've sent out so far (done).

# Use all-requests-comments.csv as master spreadsheet (edit in Excel as doesn't
#  show the quotes). Manually copying
#  over relevant priorities from the original version (see below) to the
#  updated (easier than doing it in code). Only really needed for the two
#  in-person workshops.


# requests22-23.r - import .csv file from Google Form (manually add a return at
#  the end), and tidy up if needed (wasn't in 2022). Run this code.
#  Open 'all-requests-comments.csv' in Excel and copy straight into Mary's (this
#  code does the formatting).
#
# Someone replying a second time is okay, Google highlights email address as (1)
#  but saves it normally. Shannon (for her un-named person) and Hilari both did
#  in 2022.

# requests19-20.r - import .csv file from Google Form (manually add a return at the end)
#  and this code tidies it up. 11th June 2019.
#  At some point then usually just manually edit the spreadsheet.

# requests18-19.r - import .csv file from Google Form and tidy up. 26th June 2018.
#  Based on requests17-18.r from 4th May 2017.

# Downloaded from Google Fosm on 27th May 2018 with 24 responses. If more come in
#  then add them to the spreadsheet manually.

require(dplyr)

stop("Do not re-run as am now manually working out the Priority for each course. Have resaved all-requests-comments.csv; just manually edit that as a spreadsheet.")
# 34 responses
tab_raw <- read.csv("TESA participation 2025-26.csv")
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
           Priority,                    # do names(tab_raw) to
                                        # figure out the column names to put
                                        # here as they get filled with ....
           "Location" = "Work.location..to.estimate.travel.costs.",
           "WHAM.nanaimo" =
             "Course...WHAM.in.Nanaimo.",
           "WHAM.quebec" =
             "Course..WHAM.in.Quebec",
           "R.package.adv" = "Course..Advanced.R.package.development..virtual.",
           "Eco.info.st.johns" = "Workshop..Incorporating.Ecosystem.Information.into.Assessment.Models..St..John.s..NL.",
           "Survey.design.nanaimo" = "Workshop..Survey.Design..Nanaimo.",
           "PR.stats.etc" = "Online.Course.of.Your.Choice..PR.Statistics..Highland.Statistics..Quebec.Center.for.Biodiversity.Science.etc...Please.include.the.name.of.the.course.and.the.cost.converted.to.CAD."
         ) %>%
  select(-c("Timestamp", "X", "X.1"))
 # sum(tab == "No", na.rm = TRUE)   = 7, Virginia Noble replied "No" instead of
 # blank (Lyanne for 2024-25), replace:
tab[tab == "No"] <- ""

# Copy Lyanne's "Same answer as above":
# tab[which(tab$First.name == "Lyanne"), "Ghement.advanced.ts"]  <-
#   tab[which(tab$First.name == "Lyanne"), "Ghement.linear.ts"]

events = names(tab)[8:13]   # change manually

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
    temp = filter(tab, !!sym(events[i]) != "") %>%
           select(Surname:Location,
                  events[i]) %>%
      rename("Comment" = events[i]) %>%
      mutate("Course.code" = events[i]) %>%
      relocate(Course.code)
    print(events[i])
    #print(select(temp, -events[i]))
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
     # temp <- rbind(rep(",", length(names(temp))),
     #               c(names(temp)[length(names(temp))],
     #                 rep(",", length(names(temp))-1)),
     #               temp)
     append <- ifelse(i == 1, FALSE, TRUE)   # appending if not first one
      if(!append){
        col.names <- names(temp)
       # col.names[length(col.names)] = "Comment"
      } else {
        col.names = FALSE
      }
      write.table(file = "all-requests-comments.csv",    # could add date here TODO
                  temp,
                  quote = TRUE,
                  sep = ",",
                  row.names = FALSE,
                  append = append,
                  col.names = col.names)
    }
}

stop("Stop here unless adding new people - this is for adding those after the deadline, though see notes at top of this file")

# Want to collate just the new people, by course.

# Had to manually edit .csv, due a long answer with quotes in it.
original <- read.csv("all-requests-comments-2025-03-14.csv") %>% as_tibble()
updated <- read.csv("all-requests-comments.csv") %>% as_tibble()

# Check for duplicate surnames (e.g. Carrie and Kendra!):
duplicate_surnames <- summarise(group_by(updated, Surname), number = n()) %>%
  filter(number > 1) %>%
  pull(Surname)
duplicate_surnames

# Just list them out, and can manually check first names are unique to each surname.
duplicated_people <- filter(updated,
                            Surname %in% duplicate_surnames) %>%
  select(Surname,
         First.name) %>%
  arrange(Surname)


duplicated_people %>% pacea::a()
# So just Carrie and Kendra.

new_folks <- updated$Surname[!(updated$Surname %in% original$Surname)]
new_folks
# But C and K are both in original, so new_folks is correct.

# Except Lauren Gill because I manually added her for WHAM, but she was already
# in for Advanced R.

filter(updated,
       Surname %in% new_folks) %>%
  select (-"Comment") %>%
  pacea::a()




# Open in Excel and copy into Mary's.


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
