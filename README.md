# TESA-participation
Code to summarise TESA participation from Google Forms results, and to keep track of subsidies for participants.

[25/3/19 - writing these notes for Brooke but haven't used the code for a year, so the notes may not be perfect. Depending when the TESA events get finalised, I may or may not be back to help advertise the events.]

## To get interest from participants

1. Create a Google Form based on the events being offerred. I've copied the 2018-19 one to a new 2019-20 one (https://docs.google.com/forms/d/1Zl7X5j03p11pSeBArDWNikW2wRacM_LGdzsOZsC2vh8/edit - that may be accessible), and will invite Brooke as a collaborator. Haven't changed the questions yet (as don't know what the events will be).

2. Send out email to potential interested people. I think that should be StAR and ESD, plus Diana Dobson (ask her to forward on), and check that Joel Harding gets it (through whatever channel, I think Diana).

3. Save the results from Google Form as a .csv file. For 2018-2019 I hadn't changed the title of the Google Form from 2017 to 2018 so it still saves as `Pacific TESA participation 2017-18.csv`. Just renamed it to `TESA18-19.csv` when unzipping.

4. Update the code `requests18-19.r` for 2019-20. It takes in the output from the .csv file and I think just spits out a list of interested participants for each event, which then get copied into the spreadsheet that Susan (or someone) in Ottawa will send out. One thing - the list to Ottawa should be prioritised (there's usually excess demand for spaces), so I think I just do that in the spreadsheet, partly based on participants' responses. In the past I think I have verified rankings with John and Eddy (and once with Carmel), but they just agree with what I've done.

5. Then the regions' requests will get merged by Susan - there's a bit of haggling to get extra people on courses, though there's always people that later drop out of things (so a few extras on each event are okay).

## Keeping track of participants and their subsidies

6. Susan will send out a spreadsheet with participants' names and expected subsidy for each event (wasn't until July in 2018 though). Looks like I summarised that in `TESA-budget-18/TESAfunds18.csv`, to then process and create a .pdf in `TESA-budget-18/TESAfunds18.Snw`. Then when things change (people change etc.), I update the .csv and re-run it. So best to create a new `TESA-budget-19/` folder and use what I've done as a template. 

This may seem a bit cumbersome, but we are the largest region, and for some regions this whole process is much simpler (the TESA reps will know most of the interested people anyway). 