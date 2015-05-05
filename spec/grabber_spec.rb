require 'fakeweb'
require 'open-uri'
require './lib/snap-ci-artefact-grabber'

describe 'SnapCIArtefactGrabber' do
  let(:artefact_grabber) {SnapCI::ArtefactGrabber.new("owner", "repo", "branch", "pipeline")}

  fake_pipeline_response = {
    _embedded: {
      pipelines: [{
        counter: 88
      }
      ]
    }
  }

  describe 'when no SnapCI credentials are supplied' do
    it { expect{artefact_grabber}.to raise_error(RuntimeError) }
  end

  describe 'when SnapCI credentials are blank' do
    before :each do
      stub_env('SNAP_USER', '')
      stub_env('SNAP_APIKEY', '')
    end

    it { expect{artefact_grabber}.to raise_error(RuntimeError) }
  end

  describe 'with valid credentials' do
    before :each do
      stub_env('SNAP_USER', 'distributedlife')
      stub_env('SNAP_APIKEY', 'password')

      FakeWeb.register_uri(:any, 'https://distributedlife:password@api.snap-ci.com/project/owner/repo/branch/branch/pipelines', :body => fake_pipeline_response.to_json)
    end

    it 'should get the latest pipeline information' do
      expect{artefact_grabber}.to_not raise_error
    end

    describe :get_artefact_url_for_stage do
      before :each do
        FakeWeb.register_uri(:any, 'https://distributedlife:password@api.snap-ci.com/project/owner/repo/branch/branch/artifacts/pipeline/88/stage/1/filename', :body => "file contents")
      end

      it 'should construct the url' do
        expect(artefact_grabber).to receive(:get_from_snap).with('https://api.snap-ci.com/project/owner/repo/branch/branch/artifacts/pipeline/88/stage/1/filename')

        artefact_grabber.get_artefact_url_for_stage "stage", "filename"
      end

      it 'should return the file content' do
        response = artefact_grabber.get_artefact_url_for_stage "stage", "filename"
        expect(response).to eq "file contents"
      end
    end
  end
end