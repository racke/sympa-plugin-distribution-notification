[![License](https://img.shields.io/github/license/racke/sympa-plugin-distribution-notification.svg)](COPYING)

# Distribution Notification Plugin for Sympa #

This Sympa message plugin has the following use case:

  * User sends post to mailing list
  * User receives notification of pending moderation
  * Message waits for moderation (can take a considerable amount of time)
  * Editor releases post
  * User receives distribution notifaction including the original post

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

The subject of the distribution notification email is (for list *test@lists.example.com*):

    Your message has been distributed to list test
    
The body looks like this:

    This is an automatic response sent by Sympa Mailing Lists Manager.
    Message was successfully delivered to following address:

        test@lists.example.com

Both can be adjusted in the template.

## Patch ##

If you use Sympa 6.2.48 or older it is recommended to apply the following
patch:

https://github.com/sympa-community/sympa/pull/807.diff

## Troubleshooting ##

Please check the Sympa log file if the user doesn't receive the distribution
notification:

    Mar 14 10:56:18 local-sympa sympa_msg[1176]: err main::#243 > Sympa::Spindle::spin#95 > Sympa::Spindle::DoCommand::_twist#120 > Sympa::Spindle::spin#95 > Sympa::Request::Handler::distribute::_twist#60 > Sympa::Spindle::spin#95 > Sympa::Spindle::TransformOutgoing::_twist#48 > Sympa::Message::Plugin::execute#79 > (eval)#80 > Sympa::Message::Plugin::DistributionNotification::post_archive#58 > Sympa::send_file#385 > Sympa::Spindle::new#42 > Sympa::Message::Template::new#199 > Sympa::Message::Template::_new_from_template#293 Can't parse template distribution_notification.tt2: file error - distribution_notification.tt2: not found

Possible problems are:

  * Sympa can not find this module
  * Sympa can not find the template
