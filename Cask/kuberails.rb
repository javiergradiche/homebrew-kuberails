cask 'kuberails' do
  version '0.0.1'
  sha256 'dc1eca6ae99a9d3c7acd225284a778fd56c95c4ed93395708a1ef19403903083'

  url "https://github.com/javiergradiche/homebrew-kuberails/archive/#{version}.zip"

  name 'Kuberails CLI'
  homepage 'https://www.coworkear.com'

  depends_on macos: '>= :mojave'
  depends_on formula: "csshx"

  #TODO: Complete cask instalation using builded versions for l64 & osx.
end