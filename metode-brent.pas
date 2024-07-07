program metode_brent;
uses crt, math;

var
    i, j, n: integer;
    e, a, fa, b, fb, c, fc, s, fs, d, L0, L1, L2: real;
    mflag: boolean;

procedure border;
begin
    for j := 1 to 68 do
    begin
        write('-');
    end;
    writeln('-');
end;

procedure id;
begin
    writeln('Nama: Ketut Ary Sujaya');
    writeln('NIM: E1R020058');
    writeln;
end;

procedure title;
begin
    writeln('PROGRAM PENCARIAN AKAR');
    writeln;
end;

procedure fm;
begin
    writeln('Fungsi: f(x) = (-1400(1.2)^x)/(1.2^x - 1) - (150x)/(1.2^x - 1) + 3750');
    writeln('Metode pencarian akar: Brent');
    writeln;
end;

procedure swap(var m, n: real);
var
    temp: real;
begin
    temp := m;
    m := n;
    n := temp;
end;

procedure comp;
begin
    writeln('i = ',i,' // ','s = ',s:0:n,' // ','a = ',a:0:n,' // ','b = ',b:0:n,' // ');
    writeln('f(a) = ',fa:0:n,' // ','f(b) = ',fb:0:n,' // ','|b - a| = ',abs(b - a):0:n);
    border;
end;
   
function f(x: real): real;
begin
    f := (-1400 * (1.2**x))/(1.2**x - 1) - (150 * x)/(1.2**x - 1) + 3750;
end;

begin
    clrscr;
        
    id;
    title;
    fm;
        
    write('Masukkan batas bawah interval: '); readln(a);
    write('Masukkan batas atas interval: '); readln(b);
    write('Masukkan nilai toleransi: '); readln(e);
    write('Masukkan banyaknya digit di belakang koma: '); readln(n);
    writeln;
        
    fa := f(a);
    fb := f(b);
    
    if (fa = 0) then
    begin
        writeln('Akarnya adalah ',a:0:n);
        writeln('Tidak ada iterasi yang terjadi');
        readln;
        exit;
    end
    else if (fb = 0) or (abs(b - a) <= e) then
    begin
        writeln('Akarnya adalah ',b:0:n);
        writeln('Tidak ada iterasi yang terjadi');
        readln;
        exit;
    end;
        
    if (fa * fb > 0) then
    begin
        writeln('Akar tidak berada di dalam interval [',a:0:n,', ',b:0:n,']');
        readln;
        exit;
    end;
        
    if (abs(fa) < abs(fb)) then
    begin
        swap(a, b);
        swap(fa, fb);
    end;
        
    c  := a;
    fc := fa;
        
    s  := 0;
    fs := 0;
    d  := 0;
    i  := 0;
    mflag := true;
        
    while (fb <> 0) and (abs(b - a) > e) do
    begin
        if (fa <> fc) and (fb <> fc) then
        begin
            L0 := (a * fb * fc) / ((fa - fb) * (fa - fc));
            L1 := (b * fa * fc) / ((fb - fa) * (fb - fc));
            L2 := (c * fa * fb) / ((fc - fa) * (fc - fb));
            s  := L0 + L1 + L2;
        end
        else
            s  := b - (fb * ((b - a) / (fb - fa)));
            
        if ( ( s - (3 * a + b) / 4 )  * (s - b) >= 0 ) or
           ( ( mflag = true  ) and ( abs(s - b) >= abs(b - c) / 2 ) ) or
           ( ( mflag = false ) and ( abs(s - b) >= abs(c - d) / 2 ) ) or
           ( ( mflag = true  ) and ( abs(b - c) <  abs(e)         ) ) or
           ( ( mflag = false ) and ( abs(c - d) <  abs(e)         ) ) then
        begin
            s := (a + b) / 2;
            mflag := true;
        end
        else
            mflag := false;
            
        d  := c;
        c  := b;
        fc := fb;
            
        fs := f(s);
            
        if (fa * fs < 0) then
        begin
            b  := s;
            fb := fs;
        end
        else
        begin
            a  := s;
            fa := fs;
        end;
            
        if (abs(fa) < abs(fb)) then
        begin
            swap(a, b);
            swap(fa, fb);
        end;
            
        i := i + 1;
            
        comp;
    end;
        
    writeln('Akarnya adalah ',b:0:n);
    writeln('Jumlah iterasinya adalah ',i);
    readln;
end.
