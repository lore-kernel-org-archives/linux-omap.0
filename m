From: "Sergey Vointsev" <vointsev@gmail.com>
Subject: "File not found" error while loading dspgateway demo
Date: Tue, 25 Apr 2006 15:18:41 +0400
Message-ID: <9713be7f0604250418t4cb184efke0bc07f88846b66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi everyone!
I'm trying to start working with dspgateway, but I've faced with some
troubles while running demos. Loading DSP part of console demo via
dspctl is OK (see below), but when I start ARM part it says that file
not found. File system is loaded from NFS, all other files made no
problems with reading, writing, executing.

/opt/dspgateway/demo/console # dspctl start demo_console.out
setting DSP idle
loading demo_console.out...
dspgw_task      : adr =3D 0x0013b0, size=3D   36
.vers           : adr =3D 0x000000, size=3D  120  ... ignored.
.sysstack       : adr =3D 0x000100, size=3D  512  ... initialized.
.clk            : adr =3D 0x000300, size=3D    8  ... initialized.
.prd            : adr =3D 0x000308, size=3D   48  ... initialized.
.swi            : adromapdsp: unbalanced memory request/release detected.
         intmem_usecount is not zero at where it should be! ... fixed
to be zero.
  =3D 0x000338, size=3D   80  ... inimbx: ***** old DSP binary *****
  Please update your DSP application.
tialized.
.idl            : adromapdsp: system ipbuf(D2A) is placed in DSP
internal memory.
         It will prevent DSP from idling.
  =3D 0x000388, size=3D    8  ... iniomapdsp: system ipbuf(A2D) is placed
in DSP internal memory.
         It will prevent DSP from idling.
tialized.
.hwi_disp_sec   : adromapdsp: IPBUF configuration
           1 words * 1 lines at 0xe0000ac4.
  =3D 0x000390, size=3D  386  ... iniomapdsp: mbseq is placed in DSP
internal memory.
         It will prevent DSP from idling.
tialized.
.bss            : adromapdsp: found 1 task(s)
  =3D 0x000514, size=3D 1570  ... iniomapdsp: task 0: name demo_console
tialized.
.far            : adromapdsp: taskdev demo_console enabled.
 =3D 0x000100, size=3D    0
.sysdata        : adr =3D 0x000b38, size=3D  304  ... initialized.
.sys            : adr =3D 0x000c68, size=3D   16  ... initialized.
.mem            : adr =3D 0x000512, size=3D    2  ... initialized.
.trace          : adr =3D 0x000c78, size=3D  512  ... initialized.
.gio            : adr =3D 0x000100, size=3D    0
.sysregs        : adr =3D 0x000100, size=3D    0
.sts            : adr =3D 0x000e78, size=3D   64  ... initialized.
.sem            : adr =3D 0x000eb8, size=3D   80  ... initialized.
.data           : adr =3D 0x000100, size=3D    0
.const          : adr =3D 0x000f08, size=3D  890  ... initialized.
.tsk            : adr =3D 0x001284, size=3D  264  ... initialized.
.cio            : adr =3D 0x000100, size=3D    0
.LOG_system$buf : adr =3D 0x001400, size=3D  128  ... initialized.
.printf         : adr =3D 0x000100, size=3D    0
.log            : adr =3D 0x00138c, size=3D   20  ... initialized.
.stack          : adr =3D 0x001480, size=3D 2048  ... initialized.
.args           : adr =3D 0x0013a0, size=3D   16  ... initialized.
.TSK_super$stk  : adr =3D 0x001c80, size=3D 2560  ... initialized.
.hst            : adr =3D 0x000100, size=3D    0
.dsm            : adr =3D 0x000100, size=3D    0
.TSK_sleep$stk  : adr =3D 0x002680, size=3D 2560  ... initialized.
.TSK_idle$stk   : adr =3D 0x003080, size=3D 2560  ... initialized.
.pip            : adr =3D 0x000100, size=3D    0
.DARAM$heap     : adr =3D 0x003a80, size=3D32512
.switch         : adr =3D 0x010000, size=3D    0
.hwi            : adr =3D 0x010000, size=3D    0
.pinit          : adr =3D 0x010000, size=3D    0
.bios           : adr =3D 0x010000, size=3D10997  ... initialized.
frt             : adr =3D 0x010000, size=3D    0
.text           : adr =3D 0x012af8, size=3D10121  ... initialized.
.gblinit        : adr =3D 0x015282, size=3D   74  ... initialized.
.sysinit        : adr =3D 0x0152cc, size=3D  336  ... initialized.
.trcdata        : adr =3D 0x01541c, size=3D    6  ... initialized.
.SARAM$heap     : adr =3D 0x015422, size=3D32512
.hwi_vec        : adr =3D 0xffff00, size=3D  256  ... initialized.
dbgbuf          : adr =3D 0x00b980, size=3D  512  ... initialized.
warning: found zero-sized cinit entry at 0x980
.cinit          : adr =3D 0x010000, size=3D 2434   ... .bss variables are
initialized.
setting DSP reset vector to 0x015395
releasing DSP reset
DSP configuration ... succeeded
/opt/dspgateway/demo/console # ./demo_console
open: No such file or directory
/opt/dspgateway/demo/console #


Thanks. Sergey.

--
Also available for instant messaging via Google Talk.
Need invite to Gmail? I have one for you! Just ask.
