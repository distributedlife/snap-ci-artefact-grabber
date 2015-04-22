require "snap/ci/artefact/grabber/version"
require 'open-uri'

module Snap
  module Ci
    module Artefact
      module Grabber
        class SnapCI
          def initialize owner, repo, branch, pipeline
            @owner = owner
            @repo = repo
            @branch = branch
            @pipeline = pipeline

            get_latest_pipeline
          end

          def get_artefact_url_for_stage stage, filename
            url = 'https://api.snap-ci.com/project/#{@owner}/#{@repo}/branch/#{@branch}/artifacts/#{@pipeline}/#{@pipeline_counter}/#{stage}/1/#{filename}'

            get_from_snap url
          end

          private
          def get_latest_pipeline
            url = 'https://api.snap-ci.com/project/#{@owner}/#{@repo}/branch/#{@branch}/pipelines'

            pipelines = JSON.parse(get_from_snap(url))
            @pipeline_counter = pipelines['_embedded']['pipelines'][0]['counter']
          end

          def get_from_snap url
            open(url, { http_basic_authentication: [ENV['SNAP_USER'], ENV['SNAP_APIKEY']] }).read
          end
        end
      end
    end
  end
end