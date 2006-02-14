From: Komal Shah <komal_shah802003@yahoo.com>
Subject: clk_get kernel dump
Date: Tue, 14 Feb 2006 09:01:26 -0800 (PST)
Message-ID: <20060214170126.65047.qmail@web32913.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Anybody sees the following kernel dump for H4 EVM ? or am I missing
some patch ?


Uncompressing
Linux.............................................................
.................. done, booting the kernel.
<5>Linux version 2.6.16-rc2-omap1-g67374e9f-dirty (komal@Ubuntu) (gcc
version
 3.4.0 20040409 (CodeSourcery ARM Q1A 2004)) #11 Tue Feb 14 18:42:46
EET 2006
CPU: Some Random V6 Processor [4107b362] revision 2 (ARMv6TEJ)
Machine: OMAP2420 H4 board
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 32768
<7>  DMA zone: 32768 pages, LIFO batch:7
<7>  DMA32 zone: 0 pages, LIFO batch:0
<7>  Normal zone: 0 pages, LIFO batch:0
<7>  HighMem zone: 0 pages, LIFO batch:0
<6>OMAP2420
<6>SRAM: Mapped pa 0x4020f000 to va 0xd0000000 size: 0x1000
CPU0: D VIPT write-back cache
CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
Built 1 zonelists
<5>Kernel command line: console=ttyS0,115200n8 root=/dev/nfs rw
nfsroot=172.45.4
0.102:/omap2420/omap2420root,rsize=1024,wsize=1024 ip=dhcp
<6>Clocking rate (Crystal/DPLL/MPU): 12.0/600/300 MHz
<3>clock.c: Enable for dpll_ck without enable code
<6>IRQ: Found an INTC at 0x480fe000 (revision 1.0) with 96 interrupts
<6>Total of 96 interrupts on 1 active controller
<6>OMAP24xx GPIO hardware version 1.5
Muxing M15_24XX_GPIO92 (0x4800010a): 0x03 -> 0x03
PID hash table entries: 1024 (order: 10, 16384 bytes)
<6>OMAP2 GP timer (HW version 1.2)
Console: colour dummy device 80x30
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
<6>Memory: 128MB 0MB = 128MB total
<5>Memory: 127104KB available (2000K code, 445K data, 104K init)
<7>Calibrating delay loop... 299.00 BogoMIPS (lpj=1495040)
Mount-cache hash table entries: 512
<6>CPU: Testing write buffer coherency: ok
<6>NET: Registered protocol family 16
<1>Unhandled fault: alignment exception (0x001) at 0x00000012
Internal error: : 1 [#1]
Modules linked in:
CPU: 0
PC is at clk_get+0x58/0x148
LR is at debug_mutex_free_waiter+0x78/0x94
pc : [<c003467c>]    lr : [<c0052ffc>]    Not tainted
sp : c03e3f74  ip : 22222222  fp : c03e3f94
r10: 00000000  r9 : 00000000  r8 : c01eb1d4
r7 : ffffffff  r6 : fffffffe  r5 : c021fd88  r4 : 00000012
r3 : c03e2000  r2 : c03e2000  r1 : 22222222  r0 : c03e3f38
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment kernel
Control: C5387F  Table: 80004000  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc03e2194)
Stack: (0xc03e3f74 to 0xc03e4000)
3f60:                                              c021f4f0 00000000
c001f1e0
3f80: c001e358 00000000 c03e3fb0 c03e3f98 c0010ebc c0034630 c001e1c0
c03e2000
3fa0: 00000000 c03e3fc0 c03e3fb4 c00112cc c0010e54 c03e3fd0 c03e3fc4
c000eb98
3fc0: c0011288 c03e3ff4 c03e3fd4 c00220f4 c000eb84 00000001 00000000
00000000
3fe0: 00000000 00000000 00000000 c03e3ff8 c003e5d0 c0022064 46804b45
b84cc023
Backtrace:
[<c0034624>] (clk_get+0x0/0x148) from [<c0010ebc>]
(omap_serial_init+0x74/0x220)
 r8 = 00000000  r7 = C001E358  r6 = C001F1E0  r5 = 00000000
 r4 = C021F4F0
[<c0010e48>] (omap_serial_init+0x0/0x220) from [<c00112cc>]
(omap_h4_init+0x50/0
x68)
 r6 = 00000000  r5 = C03E2000  r4 = C001E1C0
[<c001127c>] (omap_h4_init+0x0/0x68) from [<c000eb98>]
(customize_machine+0x20/0
x2c)
[<c000eb78>] (customize_machine+0x0/0x2c) from [<c00220f4>]
(init+0x9c/0x218)
[<c0022058>] (init+0x0/0x218) from [<c003e5d0>] (do_exit+0x0/0x754)
 r7 = 00000000  r6 = 00000000  r5 = 00000000  r4 = 00000000
Code: e59f50f0 e59f00f0 eb06a9e4 e5954000 (e5943000)
 <0>Kernel panic - not syncing: Attempted to kill init!

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
