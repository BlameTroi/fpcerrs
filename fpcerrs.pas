{ fpcerrs.pas --  -- Troy Brumley BlameTroi@gmail.com }

program fpcerrs;

{ expects to be compiled with the following two mode flags and command
line/fpc.cfg options of -Ciort -Sgix -Sh- for full checks, allowing
exceptions, goto, inlining, and prefer classic strings. }
{$LONGSTRINGS OFF}            { to be sure, use AnsiString or pchar explicitly }
{$BOOLEVAL ON}                { standard pascal expects this }

type
   integer = int64;            { by default ints are 64 bits this decade}

{ fpcerrs is a little program to print out descriptions for runtime errors
  from fpc. i don't remember them all and a quick command line 'what's that'
  is quicker than looking in the documentation. a little bit of sed and awk
  and the case is made. }

function maperr(n : integer) : string;

var
   s : string;

begin
   s := 'i''m sorry dave, i don''t understand that';
   case n of
     0:   s := 'no error here';
     1:   s := 'Invalid function number';
     2:   s := 'File not found';
     3:   s := 'Path not found';
     4:   s := 'Too many open files';
     5:   s := 'File access denied';
     6:   s := 'Invalid file handle';
     12:  s := 'Invalid file access code';
     15:  s := 'Invalid drive number';
     16:  s := 'Cannot remove current directory';
     17:  s := 'Cannot rename across drives';
     100: s := 'Disk read error';
     101: s := 'Disk write error';
     102: s := 'File not assigned';
     103: s := 'File not open';
     104: s := 'File not open for input';
     105: s := 'File not open for output';
     106: s := 'Invalid numeric format';
     107: s := 'Invalid enumeration';
     150: s := 'Disk is write-protected';
     151: s := 'Bad drive request struct length';
     152: s := 'Drive not ready';
     154: s := 'CRC error in data';
     156: s := 'Disk seek error';
     157: s := 'Unknown media type';
     158: s := 'Sector Not Found';
     159: s := 'Printer out of paper';
     160: s := 'Device write fault';
     161: s := 'Device read fault';
     162: s := 'Hardware failure';
     200: s := 'Division by zero';
     201: s := 'Range check error';
     202: s := 'Stack overflow error';
     203: s := 'Heap overflow error';
     204: s := 'Invalid pointer operation';
     205: s := 'Floating point overflow';
     206: s := 'Floating point underflow';
     207: s := 'Invalid floating point operation';
     210: s := 'Object not initialized';
     211: s := 'Call to abstract method';
     212: s := 'Stream registration error';
     213: s := 'Collection index out of range';
     214: s := 'Collection overflow error';
     215: s := 'Arithmetic overflow error';
     216: s := 'General Protection fault';
     217: s := 'Unhandled exception occurred';
     218: s := 'Invalid value specified';
     219: s := 'Invalid typecast';
     222: s := 'Variant dispatch error';
     223: s := 'Variant array create';
     224: s := 'Variant is not an array';
     225: s := 'Var Array Bounds check error';
     227: s := 'Assertion failed error';
     229: s := 'Safecall error check';
     231: s := 'Exception stack corrupted';
     232: s := 'Threads not supported';
   end;
   maperr := s;
end;


function str2int(s : string) : integer;

var
   n : boolean;
   i : integer;

begin
   str2int := 0;
   if length(s) < 1 then
      exit;
   n := false;
   i := 1;
   if s[i] in ['+', '-'] then begin
      n := s[i] = '-';
      i := i + 1;
   end;
   while i <= length(s) do begin
      if not (s[i] in ['0'..'9']) then
         break;
      str2int := str2int * 10 + (ord(s[i]) - ord('0'));
      i := i + 1;
   end;
   if n then
      str2int := 0 - str2int;
end;


begin
   if paramcount < 1 then
      writeln(maperr(-1))
   else
      writeln(maperr(str2int(paramstr(1))));
end.

{ end fpcerrs.pas }
