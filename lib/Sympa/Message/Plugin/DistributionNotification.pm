# Sympa - SYsteme de Multi-Postage Automatique
#
# Copyright 2019 The Sympa Community.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

package Sympa::Message::Plugin::DistributionNotification;

use strict;
use warnings;

use Sympa;
use Sympa::Log;

our $VERSION = '0.100';

my $log = Sympa::Log->instance;

sub post_archive {
    my $module  = shift;    # module name: "My::Hook"
    my $name    = shift;    # handler name: "post_archive"
    my $message = shift;    # message object
    my %options = @_;
    my $list = $message->{'context'};

    $log->syslog('debug2', 'Invoking hook with message to list %s from %s', $list->{name}, $message->{sender});

    # Only act on moderated messages
    unless ($message->get_header('X-Validation-by')) {
        $log->syslog('debug2', 'Skip distribution notification for unmoderated message.');
        return 0;
    }

    # Send distribution notification
    if ($message->{sender}) {
        $log->syslog('info', 'Distribution notification to %s', $message->{sender});

        # Set recipient variable to list address
        my $recipient = $list->{name} . '@' . $list->{'domain'};

        # Ensure 1 second elapsed since last message.
        Sympa::send_file(
            $list,
            'distribution_notification',
            $message->{sender},
            {
                type           => 'success',             # Compat<=6.2.12.
                entry          => 'message_distributed',
                auto_submitted => 'auto-replied',
                action => 'delivered',
                recipient => $recipient,
                msg =>  $message->as_string(original => 1),
            },
            date => time + 1,
        );
    }

    # Return suitable result.
    # If unrecoverable error occurred, you may return undef or simply die.
    return 1;
}

=head1 NAME

Sympa::Plugin::Message::DistributionNotification - Distribution notification for moderated messages

=head1 VERSION

Version 0.100

=cut

1;
