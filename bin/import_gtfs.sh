#!/usr/bin/env bash

# This is to substitute into config file the env values. 
sed -i s#"POSTGRES_PORT_5432_TCP_ADDR"#"$POSTGRES_PORT_5432_TCP_ADDR"#g /usr/local/transitime/config/*
sed -i s#"POSTGRES_PORT_5432_TCP_PORT"#"$POSTGRES_PORT_5432_TCP_PORT"#g /usr/local/transitime/config/*
sed -i s#"PGPASSWORD"#"$PGPASSWORD"#g /usr/local/transitime/config/*
sed -i s#"AGENCYNAME"#"$AGENCYNAME"#g /usr/local/transitime/config/*
sed -i s#"GTFSRTVEHICLEPOSITIONS"#"$GTFSRTVEHICLEPOSITIONS"#g /usr/local/transitime/config/*

cp /usr/local/transitime/config/transitime.properties /usr/local/transitimeTomcatConfig/transitime.properties

java -Xmx1000M -Dtransitime.core.agencyId=$AGENCYID -Dtransitime.configFiles=/usr/local/transitime/config/transiTimeConfig.xml -Dtransitime.logging.dir=/usr/local/transitime/logs/ -Dlogback.configurationFile=$TRANSITIMECORE/transitime/src/main/resouces/logbackGtfs.xml -jar $TRANSITIMECORE/transitime/target/GtfsFileProcessor.jar -gtfsUrl $GTFS_URL -maxTravelTimeSegmentLength 400

psql \
	-h "$POSTGRES_PORT_5432_TCP_ADDR" \
	-p "$POSTGRES_PORT_5432_TCP_PORT" \
	-U postgres \
	-d $AGENCYNAME \
	-c "update activerevisions set configrev=0 where configrev = -1; update activerevisions set traveltimesrev=0 where traveltimesrev = -1;"

