#!/bin/csh

set list=`cat listFiles`

foreach i ($list)
	echo $i
	bsub -q 8nh runOnBatch.csh $i	
end
 
