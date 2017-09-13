#!/usr/bin/env bash

# This is to substitute into config file the env values
sed -i s#"POSTGRES_PORT_5432_TCP_ADDR"#"$POSTGRES_PORT_5432_TCP_ADDR"#g /usr/local/transitime/config/*
sed -i s#"POSTGRES_PORT_5432_TCP_PORT"#"$POSTGRES_PORT_5432_TCP_PORT"#g /usr/local/transitime/config/*
sed -i s#"PGPASSWORD"#"$PGPASSWORD"#g /usr/local/transitime/config/*
sed -i s#"AGENCYNAME"#"$AGENCYNAME"#g /usr/local/transitime/config/*
sed -i s#"GTFSRTVEHICLEPOSITIONS"#"$GTFSRTVEHICLEPOSITIONS"#g /usr/local/transitime/config/*

cp /usr/local/transitime/config/transitime.properties /usr/local/transitimeTomcatConfig/transitime.properties

java -Dtransitime.db.dbName=$AGENCYNAME -Dtransitime.hibernate.configFile=/usr/local/transitime/config/hibernate.cfg.xml -Dtransitime.db.dbHost=$POSTGRES_PORT_5432_TCP_ADDR:$POSTGRES_PORT_5432_TCP_PORT -Dtransitime.db.dbUserName=postgres -Dtransitime.db.dbPassword=$PGPASSWORD -Dtransitime.db.dbType=postgresql -cp transitime-core/transitime/target/CreateAPIKey.jar org.transitime.db.webstructs.WebAgency $AGENCYID 127.0.0.1 $AGENCYNAME postgresql $POSTGRES_PORT_5432_TCP_ADDR postgres $PGPASSWORD    