# DodgySoft software
# Eric Thompson
# A fake tech support that gives canned responses when it finds keywords,
# otherwise it prints out a vague message

open( dodgySoft, "DodgysoftTextFile.txt" )
  or die("Couldn't open DodgySoft text file");    # Opens file to edit
my @textArray = <dodgySoft>;                      # Puts the input into an array
my %errorMessages;                                # Declares a hash

# Splits and joins the array
my $inputText = join "", @textArray;              # Make it one string
my @inputSections = split( '//', $inputText );

# Grabs the first block of text
my @intro = $inputSections[0];

# Maps words to their corresponding error messages
# If two words map to a message, both of them are mapped separately
my @cannedResponses = split( '\n', $inputSections[1] );
for ( my $k = 0 ; $k < @cannedResponses ; $k++ )
{
	my @differentErrors = split( '\t', $cannedResponses[$k] );
	my @synonyms        = split( '\,', $differentErrors[0] );
	if ( @synonyms > 1 )
	{
		foreach my $value (@synonyms)
		{
			$errorMessages{$value} = $differentErrors[1];
		}
	} else
	{
		$errorMessages{ $differentErrors[0] } = $differentErrors[1];
	}
}

# Grabs the 3rd and 4th blocks of text
my @randomResponses = split( '\n', $inputSections[2] );
my @closing         = split( ',',  $inputSections[3] );
$closing[0] =~ s/^\s+//
  ; # Removes leading newline character http://www.daniweb.com/software-development/perl/code/216783

#----------------------------------------------------------------------------------------
print @intro;
print "Please type '$closing[0]' to exit our system.\n";
my $input = '';
while ( $input ne $closing[0] )
{
	print "> ";
	chomp( $input = <STDIN> );
	if ( $input eq $closing[0] ) { last; }
	else
	{
		my $found         = 0;
		my $alreadyChosen = "";
		foreach my $keys ( keys %errorMessages )
		{

			# Searches the hash for the keyword
			if ( $input =~ /$keys/
				 && !( $alreadyChosen =~ /$errorMessages{$keys}/ ) )
			{
				$alreadyChosen .= $errorMessages{$keys};
				print $errorMessages{$keys}, "\n";
				$found = 1;
			}
		}

		# Prints a random message if no keyword was found
		if ( $found == 0 )
		{
			my $random = int( rand($#randomResponses) );
			print $randomResponses[ $random + 1 ], "\n";
		}
	}
}

#----------------------------------------------------------------------------------------

print "Nice talking to you, bye...";    # End message
