CWD=$(shell pwd)

# https://github.com/whosonfirst/go-whosonfirst-exportify#wof-as-featurecollection
AS_FEATURECOLLECTION=$(shell which wof-as-featurecollection)

# https://github.com/whosonfirst/go-whosonfirst-exportify#wof-merge-featurecollection
MERGE_FEATURECOLLECTION=$(shell which wof-merge-featurecollection)

level0:
	@make current-level LEVEL=0

level1:
	@make current-level LEVEL=1

level2:
	@make current-level LEVEL=2

level3:
	@make current-level LEVEL=3

level4:
	@make current-level LEVEL=4

current-level:
	$(AS_FEATURECOLLECTION) -iterator-uri 'repo://?include=properties.mz:is_current=1&include=properties.sfo:level=$(LEVEL)' $(CWD) > work/waypoints-level$(LEVEL).geojson

current:
	$(AS_FEATURECOLLECTION) -iterator-uri 'repo://?include=properties.mz:is_current=1' $(CWD) > work/waypoints.geojson

update-geoms:
	$(MERGE_FEATURECOLLECTION) -reader-uri repo://$(CWD) -writer-uri repo://$(CWD) -path geometry work/waypoints.geojson


