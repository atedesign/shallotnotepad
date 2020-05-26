#!/usr/local/bin/perl
use Tk;
# Main Window
my $mw = new MainWindow;

#Making a text area
my $txt = $mw -> Scrolled('Text',-width => 50,-scrollbars=>'e') -> pack ();

#Declare that there is a menu
my $mbar = $mw -> Menu();
$mw -> configure(-menu => $mbar);

#The Main Buttons
my $file = $mbar -> cascade(-label=>"File", -underline=>0, -tearoff => 0);
my $others = $mbar -> cascade(-label =>"Others", -underline=>0, -tearoff => 0);
my $help = $mbar -> cascade(-label =>"Help", -underline=>0, -tearoff => 0);

## File Menu ##
$file -> command(-label => "New", -underline=>0, 
		-command=>sub { $txt -> delete('1.0','end');} );
$file -> checkbutton(-label =>"Open", -underline => 0,
		-command => [\&openfunction, "Open"]);
$file -> command(-label =>"Save", -underline => 0,
		-command => [\&savefunction, "Save"]);
$file -> separator();
$file -> command(-label =>"Exit", -underline => 1,
		-command => sub { exit } );

## Others Menu ##
my $insert = $others -> cascade(-label =>"Insert", -underline => 0, -tearoff => 0);
$insert -> command(-label =>"Name", 
	-command => sub { $txt->insert('end',"Name : Thaddeus Roebuck Badgercock\n");});
$insert -> command(-label =>"Bullet Point", -command=>sub { 
	$txt->insert('end',"⚫\t");});
$insert -> command(-label =>"Email", 
	-command=> sub {$txt->insert('end',"E-Mail :\n");});
$others -> command(-label =>"Insert All", -underline => 7,
	-command => sub { $txt->insert('end',"Name : Thaddeus Roebuck Badgercock
Website : 
E-Mail :");
  	});

## Help ##
$help -> command(-label =>"About", -command => sub { 
	$txt->delete('1.0','end');
	$txt->insert('end',
	"About
----------
This is a simple text editor written in Perl Tk. This program is licensed under the GNU Public License and is Free Software.
"); });

MainLoop;

sub savefunction {
     my $fileDataToSave=$txt->get("1.0","end"); # or use contents of editor window
    # Trigger dialog
    $filename = $mw->getSaveFile( -title =>  "Selecting file to Save",
             -defaultextension => '.txt', -initialdir => '.' );
    # save the file (lots of ways here is one)
    open(my $fh, '>', $filename) or die $!;
   print $fh $fileDataToSave;
   close $fh;
}

sub openfunction {
	  # function to get file dialog box
     $filename = $mw->getOpenFile( -title => "Selecting file to Load",
     -defaultextension => '.txt', -initialdir => '.' );
     # function to load file into string e.g. if you have use File::Slurp
     open($fh, '<', $filename) or die $!;
     my $file_content = do { local $/; <$fh> };
     close $fh;
    $txt->Contents($file_content) # or put the file into textWindow here
}

sub menuClicked {
	my ($opt) = @_;
	$mw->messageBox(-message=>"You have clicked $opt.
This function is not implemented yet.");
}

#todo:
#fix open functionality
#figure out a way to highlight, underline notes
#figure out how to package as monolithic executables for various platforms
