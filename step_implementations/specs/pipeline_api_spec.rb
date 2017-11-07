##########################################################################
# Copyright 2016 ThoughtWorks, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##########################################################################

include Helpers::GoUrlHelper

step "Verify pipeline <pipeline> is locked and not schedulable - Using api" do |pipeline|
  begin
    response = RestClient.get http_url("/api/pipelines/#{scenario_state.get_pipeline(pipeline)}/status"), basic_configuration.header
    assert_true JSON.parse(response.body)['locked'] == true
    assert_true JSON.parse(response.body)['schedulable'] == false
  rescue RestClient::ExceptionWithResponse => err
    p "Pipeline Status call failed with response code #{err.response.code} and the response body - #{err.response.body}"
  end
end

step "Verify pipeline <pipeline> is not locked and is schedulable - Using api" do |pipeline|
  begin
    response = RestClient.get http_url("/api/pipelines/#{scenario_state.get_pipeline(pipeline)}/status"), basic_configuration.header
    assert_true JSON.parse(response.body)['locked'] == false
    assert_true JSON.parse(response.body)['schedulable'] == true
  rescue RestClient::ExceptionWithResponse => err
    p "Pipeline Status call failed with response code #{err.response.code} and the response body - #{err.response.body}"
  end
end
