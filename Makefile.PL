use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Sympa::Message::Plugin::DistributionNotification',
    AUTHOR              => q{Stefan Hornburg (Racke) <racke@linuxia.de>},
    VERSION_FROM        => 'lib/Sympa/Message/Plugin/DistributionNotification.pm',
    ABSTRACT_FROM       => 'lib/Sympa/Message/Plugin/DistributionNotification.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    BUILD_REQUIRES => {
    },
    PREREQ_PM => {
    },
    EXE_FILES => [ ],
    META_MERGE        => {
        resources => {
            repository  => 'https://github.com/racke/sympa-plugin-distribution-notification.git',
            bugtracker  => 'https://github.com/racke/sympa-plugin-distribution-notification/issues',
        },
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Sympa-Message-Plugin-DistributionNotification-*' },
    test                => { TESTS => join( ' ', (glob( 't/*.t'), glob('t/*/*.t')))},
);
