require 'version'
require 'json'
require 'open-uri'

module SnapCI
  class ArtefactGrabber
    def initialize owner, repo, branch, pipeline
      @owner = owner
      @repo = repo
      @branch = branch
      @pipeline = pipeline

      get_latest_pipeline
    end

    def get_artefact_url_for_stage stage, filename
      url = "#{base_url}/branch/#{@branch}/artifacts/#{@pipeline}/#{@pipeline_counter}/#{stage}/1/#{filename}"

      get_from_snap url
    end

    private
    def base_url
      "https://api.snap-ci.com/project/#{@owner}/#{@repo}"
    end

    def get_latest_pipeline
      url = "#{base_url}/branch/#{@branch}/pipelines"

      pipelines = JSON.parse(get_from_snap(url))
      @pipeline_counter = pipelines['_embedded']['pipelines'][0]['counter']
    end

    def credentials_set?
      !(
        ENV['SNAP_USER'].nil? or ENV['SNAP_APIKEY'].nil? or
        ENV['SNAP_USER'] == "" or ENV['SNAP_APIKEY'] == ""
      )
    end

    def get_from_snap url
      unless credentials_set?
        raise "SNAP_USER or SNAP_APIKEY is not set as ENV vars"
      end

      open(url, { http_basic_authentication: [ENV['SNAP_USER'], ENV['SNAP_APIKEY']] }).read
    end
  end
end