use ExtUtils::MakeMaker;

WriteMakefile(
              NAME              => "Acme::Ook",
              EXE_FILES         => ['ook'],
              VERSION_FROM      => 'lib/Acme/Ook.pm',
              'dist'            => {
                  COMPRESS      => 'gzip -9f',
                  SUFFIX        => 'gz',
                  DIST_DEFAULT => 'all tardist',
              },
              MAN1PODS  => {},
              );
