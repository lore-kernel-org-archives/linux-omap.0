From: Peter Barada <peterb@logicpd.com>
Subject: Problems bringing up new PM 2.6.29 tree on Logic 35x LV SOM
Date: Thu, 26 Mar 2009 16:35:52 -0400
Message-ID: <1238099752.8002.84.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:28278 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752304AbZCZUfz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Mar 2009 16:35:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

I pulled out Kevin's linux-omap PM tree this morning by:

git init
git clone
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
cd linux-omp-pm
git checkout -b pm origin/pm

1) Cloned arch/arm/mach-omap2/board-omap3beagle.c to
arch/arm/mach-omap2/board-omap3lv_som.c, and ifdef'd out all calls to
omap_cfg_reg and gpio calls (since the GPIO on my board is different
than beagle).

2) Added the following to arch/arm/mach-omap2/Makefile:

obj-$(CONFIG_MACH_OMAP3530_LV_SOM)	+=3D board-omap3lv_som.o \
					   mmc-twl4030.o \
					   twl4030-generic-scripts.o

3) Added the following to arch/arm/mach-omap2/Kconfig

config MACH_OMAP3530_LV_SOM
	bool "OMAP3 Logic 35x LV SOM board"
	depends on ARCH_OMAP3 && ARCH_OMAP34XX


4) Copied Kevin's beagle.pm.config to .config

5) Ran menuconfig, deselected "OMAP3 BEAGLE board" and selected "OMAP3
   Logic 35x LV SOM board", selected "Kernel low-level debugging
   function (DEBUG_LL)", changed "Low-level debug console UART" to
   UART1, turned on OMAP_MUX, OMAP_MUX_DEBUG, disabled USB and the
   OMAP host/otg USB controllers, and saved the results, built uImage.


When I first ran the kernel I got:

<5>Linux version 2.6.29-omap1 (peter@blackhole) (gcc version 4.1.2) #17
PREEMPT
Thu Mar 26 15:37:52 EDT 2009
CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=3D10c5387f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP OMAP3530LV_SOM board
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 32768
<7>free_area_init_node: node 0, pgdat c0396e74, node_mem_map c03c1000
<7>  Normal zone: 256 pages used for memmap
<7>  Normal zone: 0 pages reserved
<7>  Normal zone: 32512 pages, LIFO batch:7
<6>OMAP3430 ES2.1
<6>SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
32512
<5>Kernel command line: display=3D3 console=3DttyS0,115200 root=3D/dev/=
nfs rw
nfsroot=3D192.168.3.5:/opt/nfs-exports/ltib-omap,wsize=3D1500,rsize=3D1=
500
ip=3Ddhcp ignore_loglevel no_console_suspend initcall_debug
<6>debug: ignoring loglevel setting.
<6>Clocking rate (Crystal/DPLL/ARM core): 26.0/166/500 MHz
<6>Reprogramming SDRC
<6>GPMC revision 5.0
gpmc_mem_init: cs 0 base 0x30000000 size 0x8000000
<2>kernel BUG at arch/arm/mach-omap2/gpmc.c:438!
<1>Unable to handle kernel NULL pointer dereference at virtual address
00000000
<1>pgd =3D c0004000
<1>[00000000] *pgd=3D00000000
Internal error: Oops: 805 [#1] PREEMPT
Modules linked in:
CPU: 0    Not tainted  (2.6.29-rc8-omap1 =C3=A2)
PC is at cache_init+0x608dca41/0x60b3392d
LR is at cache_init+0x6090515d/0x60b3392d
pc : [<c002e9a0>]    lr : [<c00570bc>]    psr: 400001d3
sp : c036df40  ip : c036de98  fp : c036df4c
r10: 00000000  r9 : 411fc082  r8 : c0398700
r7 : 00000000  r6 : c036c000  r5 : 30000000  r4 : fffffff0
r3 : 00000000  r2 : c036c000  r1 : 800001d3  r0 : 00000031
<1>Unable to handle kernel NULL pointer dereference at virtual address
00000013
<1>Unhandled fault: alignment exception (0x001) at 0xe1a040c2
Internal error: : 1 [#2] PREEMPT
Modules linked in:
CPU: 0    Not tainted  (2.6.29-rc8-omap1 =C3=A2)
PC is at cache_init+0x608df1b5/0x60b3392d
LR is at 0xe3e07002
pc : [<c0031114>]    lr : [<e3e07002>]    psr: 000001d3
sp : c0067ed0  ip : c0067f10  fp : c0067f0c
r10: 00000000  r9 : 400001d3  r8 : 159f00dc
r7 : c0067fd8  r6 : e1a04006  r5 : 00000560  r4 : ffffffff
r3 : c0066000  r2 : c0067fd8  r1 : 00000005  r0 : 159f00dc
<1>Unhandled fault: alignment exception (0x001) at 0xe1a040c2
Internal error: : 1 [#3] PREEMPT
Modules linked in:
CPU: 0    Not tainted  (2.6.29-rc8-omap1 =C3=A2)
PC is at cache_init+0x608df1b5/0x60b3392d
LR is at 0xe3e07005
pc : [<c0031114>]    lr : [<e3e07005>]    psr: 000001d3
sp : c00679e0  ip : c0067a20  fp : c0067a1c
r10: c039e5d0  r9 : 400001d3  r8 : 00000013
r7 : c0067ae8  r6 : e1a04006  r5 : 00000000  r4 : ffffffff
r3 : c0066000  r2 : c0067ae8  r1 : 00000005  r0 : 00000013
<1>Unhandled fault: alignment exception (0x001) at 0xea000177
<1>Unhandled fault: alignment exception (0x001) at 0xea000177
<1>Unhandled fault: alignment exception (0x001) at 0xea000177

I changed the call to omap_init_common_hw to pass in four NULLs (as I
think the sdrc params for mt46h32m32lf6 (somehow?) don't match the
mt29c2g24maklajg-75 used on our board.  This lets the kernel go
farther, (though I do get "<3>dpll3_m2_clk rate change failed: -22"
before the "GPMC revision 5.0" message) but it hangs in rtc_hctosys,
and further printk debugging shows the hang is in twl4030_i2c_write_u8,
apparently no response comes back from the I2C controller.  Sometimes
it hangs in omap3_sr_init, again trying to write to the twl4030 to
turn on Smartreflex.  I checked the schematics, and both the beagle
board and Logic's LV SOM use the same pins for i2c1 to talk to the
twl4030.


1) Are the git commands I used the proper way to pull out Kevin's PM
   tree?
2) Does my approch of using Beagle as a starting point for a port
   to Logic's 35x LV SOM look sane (I already have 2.6.28-rc8 running
   on the LV som, started from LDP)?
3) Any suggestions on how to figure out why I2C communication with the
   TWL4030 fails?

Any help is appreciated!

--=20
Peter Barada <peterb@logicpd.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
