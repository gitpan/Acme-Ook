use ExtUtils::MakeMaker;
use File::Spec;

WriteMakefile(
              NAME              => "Acme::Ook",
              EXE_FILES         => [File::Spec->catfile("bin", "ook")],
              VERSION_FROM      => 'lib/Acme/Ook.pm',
              'dist'            => {
                  COMPRESS      => 'gzip -9f',
                  SUFFIX        => 'gz',
                  DIST_DEFAULT => 'all tardist',
              },
              MAN1PODS  => {},
              );
