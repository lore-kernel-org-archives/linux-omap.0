From: "naga rajan" <nagubk82@gmail.com>
Subject: DSPGateway problem with kernel2.6.14
Date: Fri, 30 Jun 2006 10:19:24 +0530
Message-ID: <7e6cc7550606292149y585c24aah60c559bc0b37ebe0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com, dspgateway-devel-request@lists.sourceforge.net
List-Id: linux-omap@vger.kernel.org

Hi all,

       I tried to execute the DSPGateway program after patching the OMAP
patch for kernel 2.6.14, i am getting the following error....

# dspctl start ex_task.out
Warning: none of /sys/devices/platform/dsp.0/ifver,
/sys/devices/platform/dsp0/i

fver or /sys/devices/platform/dsp/ifver is
found.
(DSP Gateway driver is too old or not
loaded)
loading ex_task.out...
.vers           : adr = 0x000000, size=  120  ...
ignored.
.sysstack       : adr = 0x000100, size=  512  ...
initialized.
.clk            : adr = 0x000300, size=    8  ...
initialized.
.prd            : adr = 0x000308, size=   48  ...
initialized.
.swi            : adr = 0x000338, size=   80  ...
initialized.
.tsk            : adr = 0x000388, size=  264  ...
initialized.
.idl            : adr = 0x000490, size=    8  ...
initialized.
.hwi_disp_sec   : adr = 0x000498, size=  384  ...
initialized.
.bss            : adr = 0x000618, size= 2808  ...
initialized.
.far            : adr = 0x000100, size=
0
.sysdata        : adr = 0x001110, size=  316  ...
initialized.
.mem            : adr = 0x00124c, size=    2  ...
initialized.
.cio            : adr = 0x000100, size=
0
.sysreomapdsp: IPBUF configuration
           128 words * 4 lines at
0xe0020000.
gs        : adr = 0x000100, sizeomapdsp: found 1
task(s)
=    0
.switch         : adr =omapdsp: task 0: name
hellotimer
 0x000100, size=    0
.trcdataomapdsp: taskdev hellotimer
enabled.
        : adr = 0x00124e, size=
.sem            : adr = 0x001254, size=  132  ...
initialized.
.dsm            : adr = 0x000100, size=
0
.data           : adr = 0x0012d8, size=    4  ...
initialized.
.gio            : adr = 0x000100, size=
0
.sys            : adr = 0x0012dc, size=   16  ...
initialized.
.pinit          : adr = 0x000100, size=
0
.gblinit        : adr = 0x0012ec, size=   74  ...
initialized.
.TSK_idle$stk   : adr = 0x001338, size= 2560  ...
initialized.
.TSK_sleep$stk  : adr = 0x001d38, size= 2560  ...
initialized.
.TSK_super$stk  : adr = 0x002738, size= 2560  ...
initialized.
.const          : adr = 0x003138, size= 1726  ...
initialized.
.printf         : adr = 0x0037f6, size=  236  ...
ignored.
.args           : adr = 0x0037f8, size=   16  ...
initialized.
.LOG_system$buf : adr = 0x003880, size=  128  ...
initialized.
.trace          : adr = 0x003900, size= 1024  ...
initialized.
.stack          : adr = 0x003d00, size= 2048  ...
initialized.
.hst            : adr = 0x000100, size=
0
.log            : adr = 0x003808,
.pip            : adr = 0x000100, size=
0
.sts            : adr = 0x00381c, size=   64  ...
initialized.
.DARAM$heap     : adr = 0x004500,
size=32512
frt             : adr = 0x012000, size=    0
.bios           : adr = 0x012000, size=10215  ... initialized.
.text           : adr = 0x0147e8, size=21056  ... initialized.
.sysinit        : adr = 0x019a28, size=  437  ... initialized.
.hwi            : adr = 0x012000, size=    0
.SARAM$heap     : adr = 0x019bdd, size=   16
.hwi_vec        : adr = 0xffff00, size=  256  ... initialized.
dspgw_task      : adr = 0x00c510, size=   36
dspgw_version   : adr = 0x000000, size=    8  ... ignored.
SARAM_seq       : adr = 0x019bee, size=    8  ... initialized.
DARAM_seq       : adr = 0x00385c, size=    8  ... initialized.
SDRAM_seq       : adr = 0xfffd00, size=    8  ... initialized.
SDRAM_system_data : adr = 0xfffd08, size=  136  ... initialized.
sleep_code      : adr = 0x00c400, size=  271  ... initialized.
ipbuf           : adr = 0x020000, size= 1072  ... initialized.
dbgbuf          : adr = 0x019bf8, size= 4096  ... initialized.
warning: found zero-sized cinit entry at 0x9f2
.cinit          : adr = 0x000100, size= 2548   ... .bss variables are
initialize
d.
setting DSP reset vector to 0x019afe
releasing DSP reset
DSP configuration ... succeeded
open taskdev: No such file or directory
#
Please provide solution for this problem.

Thanks in advance,
B.Nagarajan,
SANDS.
