#!/bin/bash

#   raw character constant in ASCII table
#   using Google coding style, i.e. with prefix 'k'

#   name=value  hex  typing     meaning

kNUL=" "   #   00   ^@  \0     Null character
kSOH=""   #   01   ^A         Start of Header
kSTX=""   #   02   ^B         Start of Text
kETX=""   #   03   ^C         End of Text
kEOT=""   #   04   ^D         End of Transmission
kENQ=""   #   05   ^E         Enquiry
kACK=""   #   06   ^F         Acknowledgment
kBEL=""   #   07   ^G  \a     Bell
kBS=""    #   08   ^H  \b     Backspace
kHT="	"   #   09   ^I  \t     Horizontal Tab
kLF="\n"    #   0A   ^J  \n     Line feed
kVT=""    #   0B   ^K  \v     Vertical Tab
kFF=""    #   0C   ^L  \f     Form feed
kCR=""    #   0D   ^M  \r     Carriage return
kSO=""    #   0E   ^N         Shift Out
kSI=""    #   0F   ^O         Shift In
kCAN=""   #   18   ^X         Cancel
kEM=""    #   19   ^Y         End of Medium
kSUB=""   #   1A   ^Z         Substitute
kESC=""   #   1B   ^[  \e     Escape
kFS=""    #   1C   ^\         File Separator

#   alias
kEndl="${kLF}"      #   END of Line
kCRLF="${kCR}${kLF}"
kTab="${kHT}"       #   horizontal TAB
kTabChar="${kHT}"
kNumberChar="#"     #   number sign

