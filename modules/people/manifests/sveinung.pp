class people::sveinung {
  $home     = "/Users/${::boxen_user}"
  $my       = "${home}/my"
  $dotfiles = "${my}/dotfiles"

  file { $my:
    ensure  => directory
  }

  repository { $dotfiles:
    source  => 'sveinung/dotfiles',
    require => File[$my]
  }

  include spotify
  include macvim
  include iterm2::stable

  class { 'intellij':
    edition => 'community',
    version => '12.1.5',
  }

  file { "${home}/.gitconfig":
    ensure => present,
    source => "${dotfiles}/gitconfig",
  }
}
