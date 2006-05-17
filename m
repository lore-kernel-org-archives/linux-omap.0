From: Komal Shah <komal_shah802003@yahoo.com>
Subject: RE: [PATCH] Add PRCM scheme I on omap2420
Date: Tue, 16 May 2006 23:56:29 -0700 (PDT)
Message-ID: <20060517065629.68535.qmail@web37908.mail.mud.yahoo.com>
References: <EA12F909C0431D458B9D18A176BEE4A50595FF66@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A50595FF66@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>, kyungmin.park@samsung.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- "Woodruff, Richard" <r-woodruff2@ti.com> wrote:

> 
> The open-source git kernel has no chance of booting, 2430 is not
> fully
> merged here.  The processors are similar but there are enough address
> space changes to ensure it won't work even for a minimal kernel.  We
> have also not yet attempted to sync up the external u-boot tree.

Here is first kernel boot (crash!!, but that's ok) of omap-git tree on
2430. I just started to add minimal support. Need to look at cpu id,
clocks, and gpios now. I will post the patch. We need to come at some
conclusion to avoid lots #ifders I have used in my code for 243x :) 
 
<5>Linux version 2.6.17-rc4-omap1-gabfedf52-dirty (komal@everest) (gcc
version
3.4.0 20040409 (CodeSourcery ARM Q1A 2004)) #266 Wed May 17 12:10:48
IST 2006
CPU: Some Random V6 Processor [4107b362] revision 2 (ARMv6TEJ)
Machine: Generic OMAP24xx
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 32768
<7>  DMA zone: 32768 pages, LIFO batch:7
<7>OMAP_TAP_IDCODE 0x00000204 REV 0 HAWKEYE 0x0000 MANF 102
<7>OMAP_TAP_DIE_ID_0: 0x00000218
<7>OMAP_TAP_DIE_ID_1: 0x0000021c DEV_REV: 0
<7>OMAP_TAP_DIE_ID_2: 0x00000220
<7>OMAP_TAP_DIE_ID_3: 0x00000224
<7>OMAP_TAP_PROD_ID_0: 0x00000208 DEV_TYPE: 0
<3>Unknown OMAP CPU id
<6>SRAM: Mapped pa 0x4020f000 to va 0xd0000000 size: 0x1000
CPU0: D VIPT write-back cache
CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
Built 1 zonelists
<5>Kernel command line: console=ttyS0,115200n8 noinitrd root=/dev/nfs r
w nfsroot=10.203.96.33:/pub/fs/oss,wsize=1024
ip=10.203.96.34:10.203.96.33:
255.255.254.0:omap2:eth0:
<6>Clocking rate (Crystal/DPLL/MPU): 13.0/0/0 MHz
<3>clock.c: Enable for dpll_ck without enable code
<6>IRQ: Found an INTC at 0x480fe000 (revision 3.0) with 96 interrupts
<6>Total of 96 interrupts on 1 active controller
PID hash table entries: 1024 (order: 10, 4096 bytes)
<3>Could not get sys_ck
<6>OMAP2 GP timer (HW version 1.6)
Console: colour dummy device 80x30
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
<6>Memory: 128MB = 128MB total
<5>Memory: 128128KB available (1260K code, 325K data, 84K init)
<7>Calibrating delay loop... 303.92 BogoMIPS (lpj=1519616)
Mount-cache hash table entries: 512
<6>CPU: Testing write buffer coherency: ok
<1>Unhandled fault: external abort on linefetch (0x806) at 0x00000000
Internal error: : 806 [#1]
Modules linked in:
CPU: 0
PC is at kernel_thread_helper+0x0/0xc
LR is at kernel_thread_helper+0x0/0xc
pc : [<c001f478>]    lr : [<c001f478>]    Not tainted
sp : c02e9ff8  ip : 00000000  fp : 00000000
r10: 00000000  r9 : 00000000  r8 : 00000000
r7 : 00000000  r6 : 00000000  r5 : 00000000  r4 : 00000000
r3 : c0039c9c  r2 : c001d058  r1 : 00000000  r0 : 00000000
Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  Segment kernel
Control: C5387F  Table: 80004000  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc02e8190)
Stack: (0xc02e9ff8 to 0xc02ea000)
9fe0:                                                       0000000a
00000001
Backtrace: no frame pointer
Code: db043fac e89da800 c0195e60 c015da44 (e1a00001)

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
