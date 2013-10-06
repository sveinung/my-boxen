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
  include iterm2::stable
  include sbt
  include caffeine

  class { 'intellij':
    edition => 'community',
    version => '12.1.5',
  }

  include fish

  file { "${home}/.gitconfig":
    ensure => present,
    source => "${dotfiles}/gitconfig",
    require => Repository[$dotfiles],
  }

  class { 'nodejs::global': version => 'v0.10.5' }
  nodejs::module { 'bower': node_version => 'v0.10' }

  include macvim

  file { "${home}/.vimrc":
    ensure => present,
    source => "${dotfiles}/vimrc",
    require => Repository[$dotfiles],
  }

  file { [ "${home}/.vim",
           "${home}/.vim/autoload",
           "${home}/.vim/colors" ]:
    ensure => directory,
    require => Repository[$dotfiles],
  }

  file { "${home}/.vim/autoload/pathogen.vim":
    ensure => present,
    source => "${dotfiles}/vim/autoload/pathogen.vim",
  }

  file { "${home}/.vim/colors/solarized.vim":
    ensure => present,
    source => "${dotfiles}/vim/colors/solarized.vim",
  }
}
