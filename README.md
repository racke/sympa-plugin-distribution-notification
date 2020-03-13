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

## Patch ##

If you use Sympa 6.2.48 or older it is recommended to apply the following
patch:

https://github.com/sympa-community/sympa/pull/807.diff
