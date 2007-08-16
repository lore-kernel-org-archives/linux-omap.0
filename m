From: "Kyungmin Park" <kyungmin.park@samsung.com>
Subject: The clock problem in OMAP2 McSPI
Date: Fri, 17 Aug 2007 08:57:08 +0900
Message-ID: <002801c7e061$2da499c0$e1ac580a@swcenter.sec.samsung.co.kr>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
To: 'David Brownell' <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi David,

I saw your patch related with TSC2101 in H4. I also try to enable the
Apollon tsc2101. Actually it's almost same as H4.

I encounter the some problem with OMAP2 McSPIs code.
The last patch[1] from you doesn't work well.
After booting, it oops with following messages[2].

So I reverted only clock parts as before. Then it's work well.
I think it has some clock problem.

Do you have any idea?
I also attached a parts of the kernel configurations [3].

Thank you,
Kyungmin Park

1.
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commitdiff;h=
7fc39f1f2f1f9998dd6d237e1de911020ba819fc

2. 
Trying disable clock mcspi_fck with 0 usecount
WARNING: at arch/arm/plat-omap/clock.c:141 clk_disable()
[<c0027fe4>] (dump_stack+0x0/0x14) from [<c00409f8>] (clk_disable+0x5c/0x98)
[<c004099c>] (clk_disable+0x0/0x98) from [<c019b8f0>]
(omap2_mcspi_work+0x87c/0)
 r4:c074a958
[<c019b074>] (omap2_mcspi_work+0x0/0x8d0) from [<c005c0f4>]
(run_workqueue+0xa4)
[<c005c050>] (run_workqueue+0x0/0x128) from [<c005c280>]
(worker_thread+0x108/0)
 r5:c0712c28 r4:c0784000
[<c005c178>] (worker_thread+0x0/0x11c) from [<c005fc58>] (kthread+0x54/0x80)
 r8:00000000 r7:00000000 r6:00000000 r5:c005c178 r4:fffffffc
[<c005fc04>] (kthread+0x0/0x80) from [<c004e180>] (do_exit+0x0/0x768)
 r5:00000000 r4:00000000
Trying disable clock mcspi_ick with 0 usecount
WARNING: at arch/arm/plat-omap/clock.c:141 clk_disable()
[<c0027fe4>] (dump_stack+0x0/0x14) from [<c00409f8>] (clk_disable+0x5c/0x98)
[<c004099c>] (clk_disable+0x0/0x98) from [<c019b8fc>]
(omap2_mcspi_work+0x888/0)
 r4:c074a958
[<c019b074>] (omap2_mcspi_work+0x0/0x8d0) from [<c005c0f4>]
(run_workqueue+0xa4)
[<c005c050>] (run_workqueue+0x0/0x128) from [<c005c280>]
(worker_thread+0x108/0)
 r5:c0712c28 r4:c0784000
[<c005c178>] (worker_thread+0x0/0x11c) from [<c005fc58>] (kthread+0x54/0x80)
 r8:00000000 r7:00000000 r6:00000000 r5:c005c178 r4:fffffffc
[<c005fc04>] (kthread+0x0/0x80) from [<c004e180>] (do_exit+0x0/0x768)
 r5:00000000 r4:00000000

Unhandled fault: external abort on linefetch (0x806) at 0x00000000
Internal error: : 806 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.23-rc2-omap1 #122)
PC is at omap2_mcspi_force_cs+0x54/0x80
LR is at 0xc02c0200
pc : [<c019aa80>]    lr : [<c02c0200>]    psr: 20000013
sp : c0785ed0  ip : c02c0200  fp : c0785eec
r10: 00000000  r9 : 00000000  r8 : c07d74b4
r7 : c074c800  r6 : c074c800  r5 : 00000001  r4 : c0712b20
r3 : d8098000  r2 : 000000a7  r1 : c023ea90  r0 : c029929c
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387f  Table: 87e90000  DAC: 00000017
Process omap2_mcspi (pid: 51, stack limit = 0xc0784258)
Stack: (0xc0785ed0 to 0xc0786000)
5ec0:                                     c0785f6c c7cb2528 c019b074
c0785fa0
5ee0: c0785f6c c0785ef0 c019b1e0 c019aa38 c0058b78 c003b28c c0785f2c
c06f801c
5f00: c074a958 00000017 c06ef0e0 c0712c20 c0785f34 c0785f20 c0058c34
c0058b38
5f20: 00000000 c0785f30 00000000 00000000 c0712b20 00000000 c7cb2508
c074a948
5f40: c0785f84 c0712c20 c019b074 c0785fa0 c0776be0 c0712c20 00000000
00000000
5f60: c0785f84 c0785f70 c005c0f4 c019b080 c0784000 c0712c28 c0785fdc
c0785f88
5f80: c005c280 c005c05c 00000000 c0776be0 c0060148 c0785fac c0785fac
c0785fa8
5fa0: 00000000 c0776be0 c0060148 c0785fac c0785fac c0712c20 c005c178
fffffffc
5fc0: c005c178 00000000 00000000 00000000 c0785ff4 c0785fe0 c005fc58
c005c184
5fe0: 00000000 00000000 00000000 c0785ff8 c004e180 c005fc10 00000000
00000000
Backtrace:
[<c019aa2c>] (omap2_mcspi_force_cs+0x0/0x80) from [<c019b1e0>]
(omap2_mcspi_wor)
 r6:c0785fa0 r5:c019b074 r4:c7cb2528
[<c019b074>] (omap2_mcspi_work+0x0/0x8d0) from [<c005c0f4>]
(run_workqueue+0xa4)
[<c005c050>] (run_workqueue+0x0/0x128) from [<c005c280>]
(worker_thread+0x108/0)
 r5:c0712c28 r4:c0784000
[<c005c178>] (worker_thread+0x0/0x11c) from [<c005fc58>] (kthread+0x54/0x80)
 r8:00000000 r7:00000000 r6:00000000 r5:c005c178 r4:fffffffc
[<c005fc04>] (kthread+0x0/0x80) from [<c004e180>] (do_exit+0x0/0x768)
 r5:00000000 r4:00000000
Code: e593502c e59f0020 e59f1028 e3a020a7 (13855601)

3.
#
# Kernel Features
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_PREEMPT=y
CONFIG_HZ=128
CONFIG_AEABI=y
CONFIG_OABI_COMPAT=y
# CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_RESOURCES_64BIT is not set
CONFIG_ZONE_DMA_FLAG=1
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_LEDS is not set
CONFIG_ALIGNMENT_TRAP=y

And also I enable almost the kernel debug options
