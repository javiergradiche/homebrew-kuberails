cask 'kuberails' do
  version '0.0.1'
  sha256 ''

  url "https://github.com/javiergradiche/kuberails/releases/download/v#{version}/kuberails.zip"

  name 'Kuberails CLI'
  homepage 'https://www.coworkear.com'

  depends_on macos: '>= :mojave'
  depends_on formula: "csshx"

  artifact 'kuberails.rb', target: "#{ENV['HOME']}/bin/kuberails.rb"
  binary 'kuberails'

  installer script: {
    executable: "#{staged_path}/bundle",
    args:       ['install'],
    sudo:       false,
  }

  zap delete: [
    '~/bin/kuberails.rb',
    '~/bin/kuberails'
  ]
end