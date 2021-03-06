#!/bin/bash

##
# Copyright IBM Corporation 2016
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##

# This script uses curl for submitting a multipart request.
# It should use a test App ID token (this is just used for manual testing).

# If any commands fail, we want the shell script to exit immediately.
set -e

for i in "$@"
do
case $i in
    --token=*)
    token="${i#*=}"
    shift # past argument=value
    ;;
    *)
        # unknown option
    ;;
esac
done

imagesFolder=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`/images
jsonFolder=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`/json
#authHeader="Bearer <valid auth token>"
authHeader="Bearer $token"
# Upload image via Kitura-based server (localhost)
curl -v -F "imageJson=@$jsonFolder/bridge.json;type=application/json" -F "imageBinary=@$imagesFolder/bridge.png;type=image/png" -X POST http://localhost:8080/images -H "Content-Type:multipart/form-data" -H "Authorization: $authHeader"
