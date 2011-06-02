
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'composable units of assertion',
  'AUTHOR' => 'Ricardo Signes <rjbs@cpan.org>',
  'BUILD_REQUIRES' => {
    'MooseX::Method::Signatures' => '0',
    'Test::Builder::Tester' => '0',
    'Test::Fatal' => '0',
    'Test::Moose' => '0',
    'Test::More' => '0.96'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.30'
  },
  'DISTNAME' => 'Test-Routine',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'Test::Routine',
  'PREREQ_PM' => {
    'Carp' => '0',
    'Class::MOP' => '0',
    'Moose' => '0',
    'Moose::Exporter' => '0',
    'Moose::Meta::Class' => '0',
    'Moose::Meta::Method' => '0',
    'Moose::Role' => '0',
    'Moose::Util' => '0',
    'Moose::Util::TypeConstraints' => '0',
    'Params::Util' => '0',
    'Scalar::Util' => '0',
    'Sub::Exporter' => '0',
    'Sub::Exporter::Util' => '0',
    'Test::More' => '0.96',
    'namespace::autoclean' => '0',
    'namespace::clean' => '0'
  },
  'VERSION' => '0.012',
  'test' => {
    'TESTS' => 't/*.t t/demo/*.t t/todo/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



