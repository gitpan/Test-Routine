package Test::Routine::Test;
BEGIN {
  $Test::Routine::Test::VERSION = '0.007';
}
use Moose;
extends 'Moose::Meta::Method';
# ABSTRACT: a test method in a Test::Routine role


has description => (
  is   => 'ro',
  isa  => 'Str',
  lazy => 1,
  default => sub { $_[0]->name },
);

has _origin => (
  is  => 'ro',
  isa => 'HashRef',
  required => 1,
);

1;

__END__
=pod

=head1 NAME

Test::Routine::Test - a test method in a Test::Routine role

=head1 VERSION

version 0.007

=head1 OVERVIEW

Test::Routine::Test is a very simple subclass of L<Moose::Meta::Method>, used
primarily to identify which methods in a class are tests.  It also has
attributes used for labeling and ordering test runs.

=head1 AUTHOR

Ricardo Signes <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo Signes.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

