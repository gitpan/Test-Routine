package Test::Routine::Runner;
BEGIN {
  $Test::Routine::Runner::VERSION = '0.004';
}
use Moose;
# ABSTRACT: tools for running Test::Routine tests


use Carp qw(confess);
use Scalar::Util qw(reftype);
use Test::More ();

use Moose::Util::TypeConstraints;

use namespace::clean;

# XXX: THIS CODE BELOW WILL BE REMOVED VERY SOON -- rjbs, 2010-10-18
use Sub::Exporter -setup => {
  exports => [
    run_tests => \'_curry_tester',
    run_me    => \'_curry_tester',
  ],
  groups  => [ default   => [ qw(run_me run_tests) ] ],
};

sub _curry_tester {
  my ($class, $name) = @_;
  use Test::Routine::Util;
  my $sub = Test::Routine::Util->_curry_tester($name);

  return sub {
    warn "you got $name from Test::Routine::Runner; use Test::Routine::Util instead; Test::Routine::Runner's exports will be removed soon\n";
    goto &$sub;
  }
}
# XXX: THIS CODE ABOVE WILL BE REMOVED VERY SOON -- rjbs, 2010-10-18

subtype 'Test::Routine::_InstanceBuilder', as 'CodeRef';
subtype 'Test::Routine::_Instance',
  as 'Object',
  where { $_->does('Test::Routine::Common') };

coerce 'Test::Routine::_InstanceBuilder',
  from 'Test::Routine::_Instance',
  via  { my $instance = $_; sub { $instance } };

has test_instance => (
  is   => 'ro',
  does => 'Test::Routine::Common',
  init_arg   => undef,
  lazy_build => 1,
);

has _instance_builder => (
  is  => 'ro',
  isa => 'Test::Routine::_InstanceBuilder',
  coerce   => 1,
  traits   => [ 'Code' ],
  init_arg => 'instance_from',
  required => 1,
  handles  => {
    '_build_test_instance' => 'execute_method',
  },
);

has description => (
  is  => 'ro',
  isa => 'Str',
  required => 1,
);

has fresh_instance => (
  is  => 'ro',
  isa => 'Bool',
  default => 0,
);

sub run {
  my ($self) = @_;

  my $thing = $self->test_instance;

  my @tests = grep { $_->isa('Test::Routine::Test') }
              $thing->meta->get_all_methods;

  # As a side note, I wonder whether there is any way to format the code below
  # to not look stupid. -- rjbs, 2010-09-28
  my @ordered_tests = sort {
         $a->_origin->{file} cmp $b->_origin->{file}
      || $a->_origin->{nth}  <=> $b->_origin->{nth}
  } @tests;

  Test::More::subtest($self->description, sub {
    for my $test (@ordered_tests) {
      $self->test_instance->run_test( $test );
      $self->clear_test_instance if $self->fresh_instance;
    }
  });
}

1;

__END__
=pod

=head1 NAME

Test::Routine::Runner - tools for running Test::Routine tests

=head1 VERSION

version 0.004

=head1 OVERVIEW

A Test::Routine::Runner takes a callback for building test instances, then uses
it to build instances and run the tests on it.  The Test::Routine::Runner
interface is still undergoing work, but the Test::Routine::Util exports for
running tests, descibed in L<Test::Routine|Test::Routine/Running Tests>, are
more stable.  Please use those instead, unless you are willing to deal with
interface breakage.

=head1 AUTHOR

Ricardo Signes <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo Signes.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

