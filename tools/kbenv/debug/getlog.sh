#!/bin/bash
for i in ${logs[@]}; do docker logs $i 2>&1 | tee /tmp/$i.log; done
