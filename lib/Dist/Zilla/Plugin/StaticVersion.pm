use strict;
use warnings;
use utf8;

package Dist::Zilla::Plugin::StaticVersion;
# ABSTRACT: Specify version number manually, using a plugin

use Moose;
use MooseX::Has::Sugar;
use MooseX::Types::Moose qw( Str );
with qw/ Dist::Zilla::Role::VersionProvider /;

has version => (
    ro, lazy, required,
    isa => Str,
    default => sub { '' },
);

=method provide_version

This method simply offers the specified version. If the specified
version is false (e.g. empty string), it will not be offered.

=cut

sub provide_version {
    return $_[0]->version if $_[0]->version;
}

1; # Magic true value required at end of module
__END__

=head1 SYNOPSIS

In a plugin bundle:

    package Dist::Zilla::PluginBundle::SomePlugins;
    use Moose;
    with 'Dist::Zilla::Role::PluginBundle::Easy';
    sub configure {
        ...
        $self->add_plugins(
            ['StaticVersion' => { version => "1.14.3" } ],
        );
        ...
    }

In dist.ini:

    [StaticVersion]
    version = 1.14.3

which is equivalent to:

    version = 1.14.3

=head1 DESCRIPTION

This purpose of this plugin is to allow plugin bundles or other such
things to specify a specific version number. This allows one to write
a pluginbundle that decides based on its configuration whether to
offer a specific version number. You could not otherwise do this,
because a static version number is specified before any plugins in
F<dist.ini>.

You shouldn't need to use this plugin directly in your F<dist.ini>.

=head1 BUGS AND LIMITATIONS

This module is under ten lines of code. It is likely provably correct.
Regardless, please report any bugs or feature requests to
C<rct+perlbug@thompsonclan.org>.

=head1 SEE ALSO

=for :list
* L<Dist::Zilla>
