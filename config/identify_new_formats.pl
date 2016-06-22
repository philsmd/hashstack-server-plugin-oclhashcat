use File::Slurp;
use JSON;

my %have = ();

$json = read_file ('hashcat.json') or die $!;
$server = decode_json $json;

foreach my $format (@$server)
{
    $have{$$format{'algorithm'}}++;
}

$json = read_file ($ARGV[0]) or die $!;
$agent = decode_json $json;

foreach my $format (@{$$agent{'algorithms'}})
{
    $have{$$format{'algorithm'}}++;
}

foreach my $format (keys %have)
{
    print "$format\n" if ($have{$format} == 1);
}
