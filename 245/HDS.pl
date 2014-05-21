use strict;

open( TESTDATA, "testdata" )
  or die("System Malfunction. Self destructing in 3 seconds.");

my @overall = <TESTDATA>;
my %errors;
my %exits;

my $overall = join "", @overall;

my @threeDifferentGroups = split( '//+\n', $overall );
my $otherscaler = @threeDifferentGroups;

my @introduction   = @threeDifferentGroups[0];
my @errorResponse  = split( "\n", @threeDifferentGroups[1] );
my @randomResponse = split( "\n", @threeDifferentGroups[2] );
my @exitResponse   = split( "\n", @threeDifferentGroups[3] );
my $scalar         = @errorResponse;

for ( my $x = 0 ; $x < @errorResponse ; $x++ )
{
	my @eachErrorLine              = split( '\t', @errorResponse[$x] );
	my @differentWordsSameResponse = split( '\,', @eachErrorLine[0] );
	if ( @differentWordsSameResponse > 1 )
	{
		foreach my $value (@differentWordsSameResponse)
		{
			$errors{$value} = @eachErrorLine[1];
		}
	}
	$errors{ @eachErrorLine[0] } = @eachErrorLine[1];
}

for ( my $x = 0 ; $x < @exitResponse ; $x++ )
{
	my @eachErrorLine              = split( '\t', @exitResponse[$x] );
	my @differentWordsSameResponse = split( '\,', @eachErrorLine[0] );
	if ( @differentWordsSameResponse > 1 )
	{
		foreach my $value (@differentWordsSameResponse)
		{
			$exits{$value} = @eachErrorLine[1];
		}
	}
	$exits{ @eachErrorLine[0] } = @eachErrorLine[1];
}

print @introduction, "\n";
my $input = "";

while ( !( $input eq "bye" ) )
{

	chomp( $input = <STDIN> );
	my $temphold        = "";
	my $poorMansBoolean = 0;
	foreach my $keys ( keys %errors )
	{
		if ( $input =~ /$keys/ && !( $temphold =~ /$errors{$keys}/ ) )
		{
			$temphold .= $errors{$keys};
			print $errors{$keys}, "\n";
			$poorMansBoolean = 1;
		}
	}
	if ( $poorMansBoolean == 0 && !( $input eq "bye" ) )
	{
		my $random = int rand @randomResponse;
		print $randomResponse[$random], "\n";
	}
}