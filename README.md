# Distribution Notification Plugin for Sympa #

## Installation ##

Install module with:

    perl Makefile.PL
    make
    make install

Copy the template `distribution_notification.tt2` from the `mail_tt2`
directory.

## Configuration ##

Add to your list config file:

    message_hook
    post_archive DistributionNotification
    
## Template ##
