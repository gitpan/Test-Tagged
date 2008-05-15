#!/usr/bin/env perl
package App::Prove::Plugin::Tagged;
use strict;
use warnings;

our $VERSION = '0.01_01';

sub import {
    my $class = shift;
    my @tags = @_;

    $ENV{TEST_TAGGED_TAGS} = join ' ', @tags;
}

1;

__END__

=head1 NAME

App::Prove::Plugin::Tagged - run specifically-tagged tests

=head1 SYNOPSIS

    # run tests tagged "web"
    prove -PTagged=web

    # run tests tagged "regression"
    prove -PTagged=regression

    # run IM and email tests
    prove -PTagged=im,email

    # run tests with any and all tags
    prove

=head1 DESCRIPTION

C<App::Prove::Plugin::Tagged> just sets an environment variable,
C<TEST_TAGGED_TAGS> which L<Test::Tagged> examines.

=head1 SEE ALSO

L<Test::Tagged>, L<App::Prove>

=head1 AUTHOR

Shawn M Moore, C<< <sartak@bestpractical.com> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-test-tagged at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Test-Tagged>.

=head1 LICENSE

Copyright 2008 Best Practical Solutions, LLC.
Test::Tagged is distributed under the same terms as Perl itself.

=cut

