#!/usr/bin/env bash
psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_POST_5432_TCP_PORT" -U postgres -d $AGENCYNAME 
