#!/usr/bin/env perl
# Thu Jan 28 17:39:51 PST 2016 by epixoip

die "Usage: $0 .plist\n" if ($#ARGV < 0);

foreach my $file (@ARGV)
{
    my %data = ();

    next unless (-e $file);

    die $! unless open (my $fh, '<', $file);

    while (<$fh>)
    {
        if (/^.*<key>RestrictionsPassword(.*)<\/key>.*/)
        {
            my $type = lc $1;

            while (<$fh>)
            {
                s/[^a-zA-Z0-9\/=<>]//g;
                next if not length;

                if (/<data>(.*)<\/data>/)
                {
                    $data{$type} = $1;
                    goto end;
                }
                elsif (/<data>$/)
                {
                    while (<$fh>)
                    {
                        s/[^a-zA-Z0-9\/=<>]//g;
                        next if not length;

                        if (/^([0-9a-zA-Z\/.=]+)$/)
                        {
                             $data{$type} = $1;
                             goto end;
                        }
                    }
                }
            }
        }

        end:
    }

    close ($fh);

    print 'sha1:1000:'.$data{'salt'}.':'.$data{'key'}."\n";
}
