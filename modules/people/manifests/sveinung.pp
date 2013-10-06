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
  include sbt
  include caffeine

  class { 'intellij':
    edition => 'community',
    version => '12.1.5',
  }

  class { 'fish':
    chsh => false,
  }

  file { "${home}/.gitconfig":
    ensure => present,
    source => "${dotfiles}/gitconfig",
  }
}
