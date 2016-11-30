#!/bin/csh

setenv EOSDIROUT /store/group/phys_muon/hbrun/muonPOGtnpTrees/2015treesSkimed
setenv LOCALPATH /afs/cern.ch/work/h/hbrun/CMSSW_8_0_16_doubleMu/src/MuonAnalysis/TagAndProbe/test/zmumu/skim2015Trees 
setenv LOCALDIR `pwd`

cd $LOCALPATH
cmsenv
cd $LOCALDIR

cp $LOCALPATH/skimTree .

set fileName=`echo $1 | awk -F "TnPTree_" '{ print "TnPTree_" $2 } '`
set fileNameSkimed=`echo $fileName | awk -F ".root" '{ print $1 "_skimmed.root"}'`

eos cp $1 $fileName
./skimTree  $fileName $fileNameSkimed -r "all" -k "HighPt Medium2016 PF TMOST Tight2012 Track_HP abseta combRelIsoPF04dBeta dB dzPV eta mass pair_newTuneP_mass pair_newTuneP_probe_pt pair_probeMultiplicity pt relTkIso tag_IsoMu22 tag_combRelIsoPF04dBeta tag_nVertices tag_pt tkPixelLay tkTrackerLay weight" -c "((pt > 20 || pair_newTuneP_probe_pt >20) && mass > 69.5 && mass < 130.1  && tag_combRelIsoPF04dBeta < 0.2 && tag_combRelIsoPF04dBeta> -0.5 &&tag_pt > 26 && tag_IsoMu24==1 && abseta <2.401 && pair_probeMultiplicity == 1)" 
cmsStage $fileNameSkimed $EOSDIROUT
