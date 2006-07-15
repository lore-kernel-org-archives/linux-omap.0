From: karthik karthik <skarthikeyan_17@yahoo.com>
Subject: Problem runnning demo_console.
Date: Sat, 15 Jul 2006 14:29:37 -0700 (PDT)
Message-ID: <20060715212937.31597.qmail@web51402.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1675190743-1152998977=:31070"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--0-1675190743-1152998977=:31070
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by reloaded.ext.ti.com id k6FLTjgv014233

hi
  =20
  linux version: linux-2.6.12
  gateway : 3.3
  =20
  I built the root file system, set it up  and thought i could test the g=
ateway by running the demo_console program.
  =20
  I am not able to run the demo_console program. The DSP is getting confi=
gured properly, but when i hit './demo_console' , the system hangs (no ou=
tput).
  I am attaching the output message i got when i did 'dspctl start demo_c=
onsole.out' and mblog output just after the configuration.=20
  =20
  I am sending two cases=20
  1)icrmask set=20
  2) icrmask disabled.(does not configure at all)
  =20
  case 1) icrmask set=20
  I tried to comment some lines in the arm side code (i am yet not comfor=
table with the compilation of DSP code). The problem occurs when the read=
 and write commands are run. (No problems with device open and close)
  =20
  case 2)  icrmask disabled --> does not configure at all
  =20
  =20
  Can someone can tell me about the public linux dsp tools and where i ca=
n get them from, i would write some more codes and try to debug. (i googl=
ed but no use )
  =20
  thx & regs
  Karthikeyan.S
  =20
  =20

 	=09
---------------------------------
Yahoo! Messenger with Voice. Make PC-to-Phone Calls to the US (and 30+ co=
untries) for 2=A2/min or less.
--0-1675190743-1152998977=:31070
Content-Type: text/plain; name="error_hang_july15s.txt"
Content-Description: 1754314232-error_hang_july15s.txt
Content-Disposition: inline; filename="error_hang_july15s.txt"

ICRMASK ENABLED
----------------
# dspctl start demo_console.out
loading demo_console.out...
dspgw_task      : adr = 0x00c4d4, size=   36
dspgw_version   : adr = 0x000000, size=    8  ... ignored.
SARAM_seq       : adr = 0x010000, size=    8  ... initialized.
DARAM_seq       : adr = 0x000100, size=    8  ... initialized.
SDRAM_seq       : adr = 0xfffd00, size=    8  ... initialized.
SDRAM_system_data : adr = 0xfffd08, size=  136  ... initialized.
sleep_code      : adr = 0x000108, size=  242  ... initialized.
.vers           : adr = 0x000000, size=  120  ... ignored.
.sysstack       : adr = 0x0001fc, size=  512  ... initialized.
.clk            : adr = 0x0003fc, size=    8  ... initialized.
.prd            : adr = 0x000404, size=   48  ... initialized.
.swi            : adr = 0x000434, size=   80  ... initialized.
.tsk            : adr = 0x000484, size=  264  ... initialized.
.idl            : adr = 0x00058c, size=    8  ... initialized.
.hwi_disp_sec   : adr = 0x000594, size=  384  ... initialized.
.bss            : adr = 0x000714, size= 2792  ... initialized.
.far            : adr = 0x000100, size=    0
.sysdata        : adr = 0x0011fc, size=  316  ... initialized.
.mem            : adr = 0x0001fa, size=    2  ... initialized.
.cio            : adr = 0x000100, size=    0
.sysregs        : adr = 0x000100, size=    0
.sem            : adr = 0x001338, size=  132  ... initialized.
.dsm            : adr = 0x000100, size=    0
.data           : adr = 0x0013bc, size=    4  ... initialized.
.gio            : adr = 0x000100, size=    0
.sys            : adr = 0x0013c0, size=   16  ... initialized.
.TSK_idle$stk   : adr = 0x0013d0, size= 2560  ... initialized.
.TSK_sleep$stk  : adr = 0x001dd0, size= 2560  ... initialized.
.TSK_super$stk  : adr = 0x0027d0, size= 2560  ... initialized.
.const          : adr = 0x0031d0, size= 1814  ... initialized.
.printf         : adr = 0x0038e6, size=  236  ... ignored.
.args           : adr = 0x0038e8, size=   16  ... initialized.
.LOG_system$buf : adr = 0x003900, size=  128  ... initialized.
.trace          : adr = 0x003980, size= 1024  ... initialized.
.stack          : adr = 0x003d80, size= 2048  ... initialized.
.hst            : adr = 0x000100, size=    0
.log        omapdsp: IPBUF configuration
           1 words * 1 lines at 0xe000c4f8.
    : adr = 0x004580, size=   20omapdsp: found 1 task(s)
  ... initialized.
.pip        omapdsp: task 0: name demo_console
    : adr = 0x000100, size=    0omapdsp: taskdev demo_console enabled.

.sts            : adr = 0x004594, size=   64  ... initialized.
.DARAM$heap     : adr = 0x0045d4, size=32512
frt             : adr = 0x010000, size=    0
.bios           : adr = 0x010008, size=10215  ... initialized.
.text           : adr = 0x0127f0, size=20642  ... initialized.
.switch         : adr = 0x010000, size=    0
.sysinit        : adr = 0x017892, size=  437  ... initialized.
.trcdata        : adr = 0x017a48, size=    6  ... initialized.
.pinit          : adr = 0x010000, size=    0
.gblinit        : adr = 0x017a4e, size=   74  ... initialized.
.hwi            : adr = 0x010000, size=    0
.SARAM$heap     : adr = 0x017a98, size=   16
.hwi_vec        : adr = 0xffff00, size=  256  ... initialized.
ipbuf           : adr = 0x00c4f8, size=   14  ... initialized.
dbgbuf          : adr = 0x00c506, size= 4096  ... initialized.
warning: found zero-sized cinit entry at 0x9f2
.cinit          : adr = 0x010000, size= 2548   ... .bss variables are initialize
d.
setting DSP reset vector to 0x017968
releasing DSP reset
DSP configuration ... succeeded
symlink: File exists
# cat /sys/devices/platform/dsp/mblog
log count:10 / ARM->DSP:5, DSP->ARM:5
          ARM -> DSP   ARM <- DSP
jiffies  q cmd  data q cmd  data
fffff319 0 7000 0000             DSPCFG:REQ
fffff319             0 7070 0019 DSPCFG:PROTREV
fffff319             1 f028 007f DSPCFG:SYSADRH
fffff319             0 70a9 fe88 DSPCFG:SYSADRL
fffff319             1 a300 0000 BKYLD
fffff31a 0 6000 0000             TCFG:task 0
fffff31a             0 6000 0000 TCFG:task 0
fffff31b 1 b000 0000             TCTL:task 0
fffff31b 0 7500 ffff             SETVAR:ICRMASK
fffff37f 1 d200 0002             PM:DISABLE
# ./demo_console



It hangs here.

--0-1675190743-1152998977=:31070
Content-Type: text/plain; name="error_hang_july15u.txt"
Content-Description: 3782028785-error_hang_july15u.txt
Content-Disposition: inline; filename="error_hang_july15u.txt"


ICRMASK DISABLED

--------------

# echo 0 > /sys/devices/platform/dsp/icrmask
# cat /sys/devices/platform/dsp/icrmask
0x0000
# dspctl start demo_console.out
loading demo_console.out...
dspgw_task      : adr = 0x00c4d4, size=   36
dspgw_version   : adr = 0x000000, size=    8  ... ignored.
SARAM_seq       : adr = 0x010000, size=    8  ... initialized.
DARAM_seq       : adr = 0x000100, size=    8  ... initialized.
SDRAM_seq       : adr = 0xfffd00, size=    8  ... initialized.
SDRAM_system_data : adr = 0xfffd08, size=  136  ... initialized.
sleep_code      : adr = 0x000108, size=  242  ... initialized.
.vers           : adr = 0x000000, size=  120  ... ignored.
.sysstack       : adr = 0x0001fc, size=  512  ... initialized.
.clk            : adr = 0x0003fc, size=    8  ... initialized.
.prd            : adr = 0x000404, size=   48  ... initialized.
.swi            : adr = 0x000434, size=   80  ... initialized.
.tsk            : adr = 0x000484, size=  264  ... initialized.
.idl            : adr = 0x00058c, size=    8  ... initialized.
.hwi_disp_sec   : adr = 0x000594, size=  384  ... initialized.
.bss            : adr = 0x000714, size= 2792  ... initialized.
.far            : adr = 0x000100, size=    0
.sysdata        : adr = 0x0011fc, size=  316  ... initialized.
.mem            : adr = 0x0001fa, size=    2  ... initialized.
.cio            : adr = 0x000100, size=    0
.sysregs        : adr = 0x000100, size=    0
.sem            : adr = 0x001338, size=  132  ... initialized.
.dsm            : adr = 0x000100, size=    0
.data           : adr = 0x0013bc, size=    4  ... initialized.
.gio            : adr = 0x000100, size=    0
.sys            : adr = 0x0013c0, size=   16  ... initialized.
.TSK_idle$stk   : adr = 0x0013d0, size= 2560  ... initialized.
.TSK_sleep$stk  : adr = 0x001dd0, size= 2560  ... initialized.
.TSK_super$stk  : adr = 0x0027d0, size= 2560  ... initialized.
.const          : adr = 0x0031d0, size= 1814  ... initialized.
.printf         : adr = 0x0038e6, size=  236  ... ignored.
.args           : adr = 0x0038e8, size=   16  ... initialized.
.LOG_system$buf : adr = 0x003900, size=  128  ... initialized.
.trace          : adr = 0x003980, size= 1024  ... initialized.
.stack          : adr = 0x003d80, size= 2048  ... initialized.
.hst            : adr = 0x000100, size=    0
.log            : adr = 0x004580, size=   20  ... initialized.
.pip            : adr = 0x000100, size=    0
.sts            : adr = 0x004594, size=   64  ... initialized.
.DARAM$heap     : adr = 0x0045d4, size=32512
frt             : adr = 0x010000, size=    0
.bios           : adr = 0x010008, size=10215  ... initialized.
.text           : adr = 0x0127f0, size=20642  ... initialized.
.switch         : adr = 0x010000, size=    0
.sysinit        : adr = 0x017892, size=  437  ... initialized.
.trcdata        : adr = 0x017a48, size=    6  ... initialized.
.pinit          : adr = 0x010000, size=    0
.gblinit        : adr = 0x017a4e, size=   74  ... initialized.
.hwi            : adr = 0x010000, size=    0
.SARAM$heap     : adr = 0x017a98, size=   16
.hwi_vec        : adr = 0xffff00, size=  256  ... initialized.
ipbuf           : adr = 0x00c4f8, size=   14  ... initialized.
dbgbuf          : adr = 0x00c506, size= 4096  ... initialized.
warning: found zero-sized cinit entry at 0x9f2
.cinit          : adr = 0x010000, size= 2548   ... .bss variables are initialize
d.
setting DSP reset vector to 0x017968
releasing DSP resetDSP MMU interrupt!
  TLB miss
fault address = PROGRAM: 0x000000
Resetting DSP...

scheduling while atomic: dspctl/0x00010003/29


Hangs here
--0-1675190743-1152998977=:31070
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--0-1675190743-1152998977=:31070--
