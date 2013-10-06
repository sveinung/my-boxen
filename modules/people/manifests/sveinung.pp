class people::sveinung {
  include spotify
  include macvim
  include iterm2::stable

  class { 'intellij':
    edition => 'community',
    version => '12.1.5',
  }
}
