# TESA-participation
Code to summarise TESA participation from Google Forms results, and to keep track of subsidies for participants.

[25/3/19 - writing these notes for Brooke but haven't used the code for a year, so the notes may not be perfect. Depending when the TESA events get finalised, I may or may not be back to help advertise the events.]

## To get interest from participants

1. Create a Google Form based on the events being offerred. I've copied the 2018-19 one to a new 2019-20 one (https://docs.google.com/forms/d/1Zl7X5j03p11pSeBArDWNikW2wRacM_LGdzsOZsC2vh8/edit - that may be accessible), and will invite Brooke as a collaborator. Haven't changed the questions yet (as don't know what the events will be). 2022 is https://docs.google.com/forms/d/1qTZFMa9jhiFcl75hTy1esAFy1AfgUN-vB-snaD3CiOg/edit 

2. Send out email to potential interested people. Originally though should be StAR and ESD, plus Diana Dobson (ask her to forward on), and check that Joel Harding gets it (through whatever channel, I think Diana). June 2019 - chatted with Brooke, we'll just send to XPAC SC-ALL-STAFF. Also can mention that the R webinars may be of more general use (and will be advertised later). 2022: XPAC SC-ALL-STAFF seems to be replaced by DFO.R PAC Science - I expanded that list and then deleted BMD and CHS. And emailed Dawn Lewis to tell the Area Chiefs.

3. Save the results from Google Form as a .csv file. 

4. Update the code, currently `requests21-22.r`. It takes in the output from the .csv file and I think just spits out a list of interested participants for each event, which then get copied into the spreadsheet that Susan (or someone) in Ottawa will send out. One thing - the list to Ottawa should be prioritised (there's usually excess demand for spaces), so I think I just do that in the spreadsheet, partly based on participants' responses. In the past I think I have verified rankings with John and Eddy (and once with Carmel), but they just agree with what I've done.

5. Then the regions' requests will get merged nationally - there's a bit of haggling to get extra people on courses, though there's always people that later drop out of things (so a few extras on each event are okay).

## Dealing with funds once arrive in PAC

Just had a discussion with Brianna Glennie (StAR Branch Co-ordinator), 25/5/22. So, plan is:

a) Get the money from Ottawa into usual local TESA collator (hopefully stays the same)

b) Keep money for StAR folks in the local TESA collator. Send money for other divisions in lump sums to each division (Brianna needs approval from someone to send them money, so wants to keep it at the Division level, and it's easier to send money earlier rather than later in the year). If people cancel etc then either get Division to sort it out or may have to redirect some.

c) For StAR people can get their subsidy by claiming part of the expenses from the TESA collator. 
  i) They can code an exact part of their GAC cost (e.g. $400) directly to the TESA collator (Brianna will set up a single fund commitment to claim against), and the rest to their usual collator.
  ii) For travel they can code specific expenses to TESA collator directly, but can't specify an exact amount. So may have to do, say, hotels or certain meals to get the number close enough to the specified subsidy.
  Since under StAR, approvals are all under John and he's fine with that. There are no JV's any more. 

Next steps: 
 - update Brianna when know rough amounts of the money coming from Ottawa (late June maybe),
 - then let her know what to transfer at the Division level and what to leave in the TESA collator. 
 - then tell the participants.

From earlier years:

## Keeping track of participants and their subsidies

National master spreadsheet is on TESA Teams: Regional TESA Participants - 2022-2023_AllRegions_300622

Update that when people change (combined list and PAC list, so I can just copy emails).

For subsidies, also keep track locally. **When participants change** - just change `requests22-23/TESAfunds22-23.csv`, re-build `TESA-budget22-23/TESAbudget22-23.pdf`.

The `TESAfunds22-23.csv` is initially taken from the PAC tab of the master spreadsheet (as everyone essentially got accepted; which was essentially `all-requests-comments.csv` but includes a few latecomers got manually added), then whittled down to just the courses/workshops that have a subsidy aspect. Manually standardised some Division names (SSI to AMD, StAD and SCA Stock Assessment and Science Stock Assessment to SCA, Environmental Watch to ESD.

This may seem a bit cumbersome, but we are the largest region, and for some regions this whole process is much simpler (the TESA reps will know most of the interested people anyway). 