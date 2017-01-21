#!/usr/bin/env bash

#******************************************************************************
# Copyright 2017 the original author or authors.                              *
#                                                                             *
# Licensed under the Apache License, Version 2.0 (the "License");             *
# you may not use this file except in compliance with the License.            *
# You may obtain a copy of the License at                                     *
#                                                                             *
# http://www.apache.org/licenses/LICENSE-2.0                                  *
#                                                                             *
# Unless required by applicable law or agreed to in writing, software         *
# distributed under the License is distributed on an "AS IS" BASIS,           *
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.    *
# See the License for the specific language governing permissions and         *
# limitations under the License.                                              *
#******************************************************************************/

#==============================================================================
# SCRIPT:   bashrc
# AUTOHR:   Markus Schneider
# DATE:     21/01/2017
# REV:      1.1.0
# PLATFORM: Noarch
# PURPOSE:  Set the environment for the OpenNMS Dockerfile project.
#==============================================================================

export ORIGIN="schneidermatic"
export ENTITY="opennms"
export TAG="opennms-18.0.3_centos-7.2"
export NAME="onms_1"
export IMAGE="$ORIGIN/$ENTITY:$TAG"

export WD=$(pwd)
PATH=$WD/bin:$PATH
