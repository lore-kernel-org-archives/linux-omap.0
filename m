From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: REGRESSION: omap3 fails to boot
Date: Sat, 10 Mar 2012 18:08:22 +0000
Message-ID: <20120310180822.GA22875@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58109 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667Ab2CJSIc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Mar 2012 13:08:32 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>
Cc: stable@vger.kernel.org, arm@kernel.org

I tried booting last nights omap3430-ldp test build... and it failed.
So I tried the tip of my tree... and it failed.  So I threw in the
standard ll debug printk hack and go the messages below.

Seems to be that the OMAP mailbox stuff is buggered:

c042ac1c t __initcall_omap2_mbox_init4
c042ac20 t __initcall_rx51_video_init4
c042ac24 t __initcall_omap_register_i2c_bus_cmdline4
c042ac28 t __initcall_omap_mbox_init4

so, omap2_mbox_init() gets called _before_ omap_mbox_init(), which means
the struct class has not been registered _before_ we start to register
devices against it.

Both these are subsys_initcall()s.

This bug is introduced by this "fix" in mainline which would appear to be
causing the regression - reverting it makes the platform boot again:

commit 435792d93410f008120c4dbab148019a3cc31dbc
Author: Ohad Ben-Cohen <ohad@wizery.com>
Date:   Sun Feb 26 12:14:14 2012 +0200

    ARM: OMAP: make iommu subsys_initcall to fix builtin omap3isp
    
    omap3isp depends on omap's iommu and will fail to probe if
    initialized before it (which always happen if they are builtin).
    
    Make omap's iommu subsys_initcall as an interim solution until
    the probe deferral mechanism is merged.
    
    Reported-by: James <angweiyang@gmail.com>
    Debugged-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
    Cc: stable <stable@vger.kernel.org>
    Cc: Tony Lindgren <tony@atomide.com>
    Cc: Hiroshi Doyu <hdoyu@nvidia.com>
    Cc: Joerg Roedel <Joerg.Roedel@amd.com>
    Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 609ea2d..a6db1e4 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -412,7 +412,8 @@ static void __exit omap2_mbox_exit(void)
        platform_driver_unregister(&omap2_mbox_driver);
 }
 
-module_init(omap2_mbox_init);
+/* must be ready before omap3isp is probed */
+subsys_initcall(omap2_mbox_init);
 module_exit(omap2_mbox_exit);
 
 MODULE_LICENSE("GPL v2");


Uncompressing Linux... done, booting the kernel.
<6>Booting Linux on physical CPU 0
<5>Linux version 3.3.0-rc6+ (rmk@rmk-PC.arm.linux.org.uk) (gcc version 4.3.5 (GCC) ) #237 PREEMPT Sat Mar 10 17:54:37 GMT 201
2
CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP LDP board
<4>vmalloc area is too big, limiting to 976MB
<6>Reserving 2097152 bytes SDRAM for VRAM
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 32000
<7>free_area_init_node: node 0, pgdat c0470a5c, node_mem_map c0871000
<7>  Normal zone: 64 pages used for memmap
<7>  Normal zone: 0 pages reserved
<7>  Normal zone: 7360 pages, LIFO batch:0
<7>  HighMem zone: 192 pages used for memmap
<7>  HighMem zone: 24384 pages, LIFO batch:3
<6>OMAP3430/3530 ES2.1 (l2cache iva sgx neon isp )
<6>Clocking rate (Crystal/Core/MPU): 26.0/266/500 MHz
<7>pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
<7>pcpu-alloc: [0] 0 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 31744
<5>Kernel command line: console=ttyO2,115200n8 noinitrd vmalloc=1G mem=128M root=/dev/mmcblk0p2 rw ip=none rootdelay=2 video=
omap24xxfb:rotation=270
<6>PID hash table entries: 128 (order: -3, 512 bytes)
<6>Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
<6>Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
<6>Memory: 29MB 96MB = 125MB total
<5>Memory: 118256k/118256k available, 12816k reserved, 98304K highmem
<5>Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xc2800000 - 0xff000000   ( 968 MB)
    lowmem  : 0xc0000000 - 0xc2000000   (  32 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
    modules : 0xbf000000 - 0xbfe00000   (  14 MB)
      .text : 0xc0008000 - 0xc03fe000   (4056 kB)
      .init : 0xc03fe000 - 0xc042c000   ( 184 kB)
      .data : 0xc042c000 - 0xc0471500   ( 278 kB)
       .bss : 0xc0471524 - 0xc0870434   (4092 kB)
<6>NR_IRQS:410
<6>IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
<6>Total of 96 interrupts on 1 active controller
<6>OMAP clockevent source: GPTIMER1 at 32768 Hz
<6>sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
<6>Console: colour dummy device 80x30
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8191
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     16384
... MAX_LOCKDEP_CHAINS:      32768
... CHAINHASH_SIZE:          16384
 memory used by lock dependency info: 3679 kB
 per task-struct memory footprint: 1152 bytes
<6>Calibrating delay loop... <c>493.67 BogoMIPS (lpj=1929216)
<6>pid_max: default: 32768 minimum: 301
<6>Mount-cache hash table entries: 512
<6>CPU: Testing write buffer coherency: ok
<6>Setting up static identity map for 0x80306128 - 0x80306180
<4>omap_hwmod: usbtll_fck: missing clockdomain for usbtll_fck.
<6>print_constraints: dummy: 
<6>NET: Registered protocol family 16
<6>GPMC revision 5.0
<6>gpiochip_add: registered GPIOs 0 to 31 on device: gpio
<6>OMAP GPIO hardware version 2.5
<6>gpiochip_add: registered GPIOs 32 to 63 on device: gpio
<6>gpiochip_add: registered GPIOs 64 to 95 on device: gpio
<6>gpiochip_add: registered GPIOs 96 to 127 on device: gpio
<6>gpiochip_add: registered GPIOs 128 to 159 on device: gpio
<6>gpiochip_add: registered GPIOs 160 to 191 on device: gpio
<6>omap_mux_init: Add partition: #1: core, flags: 0
<6>Reprogramming SDRC clock to 266000000 Hz
<3>dpll3_m2_clk rate change failed: -22
<4> omap-mcbsp.2: alias fck already exists
<4> omap-mcbsp.3: alias fck already exists
<6>OMAP DMA hardware revision 4.0
<1>Unable to handle kernel NULL pointer dereference at virtual address 0000016c
<1>pgd = c0004000
<1>[0000016c] *pgd=00000000
<0>Internal error: Oops: 5 [#1] PREEMPT ARM
<d>Modules linked in:
CPU: 0    Not tainted  (3.3.0-rc6+ #237)
PC is at __lock_acquire+0x94/0x7f0
LR is at lock_acquire+0x64/0x78
pc : [<c006a678>]    lr : [<c006ae38>]    psr: 80000093
sp : c181fcd0  ip : c181b7c0  fp : c181fd1c
r10: c03b1e5c  r9 : 00000000  r8 : c1883008
r7 : 00000000  r6 : c181e000  r5 : 60000013  r4 : 00000001
r3 : 00000168  r2 : 00000000  r1 : 00000000  r0 : 00000168
Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 80004019  DAC: 00000015
<0>Process swapper (pid: 1, stack limit = 0xc181e2e8)
<0>Stack: (0xc181fcd0 to 0xc1820000)
<0>fcc0:                                     60000013 00000001 00000000 00000000
<0>fce0: 00000168 c181b7c0 c181fd14 c181fcf8 c0017438 00000000 60000013 c181e000
<0>fd00: 00000000 c1883008 c047251c c03b1e5c c181fd54 c181fd20 c006ae38 c006a5f0
<0>fd20: 00000001 00000000 00000000 c01e0d94 00000000 c181fd40 c01e0d94 00000158
<0>fd40: 00000000 c1883010 c181fd7c c181fd58 c03057ec c006ade0 00000001 00000000
<0>fd60: c01e0d94 c1883008 c189d000 c189d000 c181fd9c c181fd80 c01e0d94 c03057b0
<0>fd80: c189d000 c189d000 00000000 c189d008 c181fdd4 c181fda0 c01e2124 c01e0cd0
<0>fda0: c01eabb8 c01ebaf4 c189d000 00000000 c181fdd4 c189d000 00000000 00000000
<0>fdc0: c1883008 c043f6c4 c181fdec c181fdd8 c01e24c0 c01e2060 00000000 c189d000
<0>fde0: c181fe14 c181fdf0 c01e2544 c01e24ac c181fe34 c043f6c4 00000000 c047229c
<0>fe00: c1883008 00000000 c181fe2c c181fe18 c01e2598 c01e24d0 c03b1e5c c181fe34
<0>fe20: c181fe64 c181fe30 c0033128 c01e2580 c03b1e5c c03a5188 c02fd748 c043f6c4
<0>fe40: c1883000 c047229c c043f724 c04654d8 00000000 00000000 c181fe84 c181fe68
<0>fe60: c02fd764 c00330e8 c1883008 c1883008 c043f740 c043f740 c181fe94 c181fe88
<0>fe80: c01e57c4 c02fd708 c181feb4 c181fe98 c01e4274 c01e57b0 c1883008 c043f740
<0>fea0: c043f740 c181fef0 c181fecc c181feb8 c01e439c c01e41e0 c1883008 c188303c
<0>fec0: c181feec c181fed0 c01e4428 c01e4358 c01e43b4 00000000 c01e43b4 c043f740
<0>fee0: c181ff14 c181fef0 c01e2c30 c01e43c0 c18330a8 c187d390 c042ac20 c043f740
<0>ff00: c043f740 c188e0c0 c181ff24 c181ff18 c01e40c0 c01e2be4 c181ff54 c181ff28
<0>ff20: c01e34b0 c01e40ac c03a6c2b c181ff38 c042ac20 c042af5c c043f740 00000013
<0>ff40: 00000000 c04095c8 c181ff7c c181ff58 c01e4ae4 c01e3414 00000201 c042ac20
<0>ff60: c042af5c c003a2f0 00000013 00000000 c181ff8c c181ff80 c01e5b24 c01e4a28
<0>ff80: c181ff9c c181ff90 c04095dc c01e5ae4 c181ffdc c181ffa0 c0008798 c04095d4
<0>ffa0: c181ffc4 c181ffb0 c00563c4 c01878d0 c003a2f0 c042ac20 c042af5c c003a2f0
<0>ffc0: 00000013 00000000 00000000 00000000 c181fff4 c181ffe0 c03fe284 c0008708
<0>ffe0: 00000000 c03fe208 00000000 c181fff8 c003a2f0 c03fe214 1077ce40 01f7ee08
Backtrace: 
[<c006a5e4>] (__lock_acquire+0x0/0x7f0) from [<c006ae38>] (lock_acquire+0x64/0x78)
[<c006add4>] (lock_acquire+0x0/0x78) from [<c03057ec>] (_raw_spin_lock+0x48/0x58)
 r7:c1883010 r6:00000000 r5:00000158 r4:c01e0d94
[<c03057a4>] (_raw_spin_lock+0x0/0x58) from [<c01e0d94>] (get_device_parent+0xd0/0x204)
 r5:c189d000 r4:c189d000
[<c01e0cc4>] (get_device_parent+0x0/0x204) from [<c01e2124>] (device_add+0xd0/0x44c)
 r7:c189d008 r6:00000000 r5:c189d000 r4:c189d000
[<c01e2054>] (device_add+0x0/0x44c) from [<c01e24c0>] (device_register+0x20/0x24)
 r8:c043f6c4 r7:c1883008 r6:00000000 r5:00000000 r4:c189d000
[<c01e24a0>] (device_register+0x0/0x24) from [<c01e2544>] (device_create_vargs+0x80/0xb0)
 r4:c189d000
[<c01e24c4>] (device_create_vargs+0x0/0xb0) from [<c01e2598>] (device_create+0x24/0x2c)
 r8:00000000 r7:c1883008 r6:c047229c r5:00000000 r4:c043f6c4
[<c01e2574>] (device_create+0x0/0x2c) from [<c0033128>] (omap_mbox_register+0x4c/0xe8)
[<c00330dc>] (omap_mbox_register+0x0/0xe8) from [<c02fd764>] (omap2_mbox_probe+0x68/0x88)
[<c02fd6fc>] (omap2_mbox_probe+0x0/0x88) from [<c01e57c4>] (platform_drv_probe+0x20/0x24)
 r7:c043f740 r6:c043f740 r5:c1883008 r4:c1883008
[<c01e57a4>] (platform_drv_probe+0x0/0x24) from [<c01e4274>] (really_probe+0xa0/0x178)
[<c01e41d4>] (really_probe+0x0/0x178) from [<c01e439c>] (driver_probe_device+0x50/0x68)
 r7:c181fef0 r6:c043f740 r5:c043f740 r4:c1883008
[<c01e434c>] (driver_probe_device+0x0/0x68) from [<c01e4428>] (__driver_attach+0x74/0x98)
 r5:c188303c r4:c1883008
[<c01e43b4>] (__driver_attach+0x0/0x98) from [<c01e2c30>] (bus_for_each_dev+0x58/0x98)
 r6:c043f740 r5:c01e43b4 r4:00000000
[<c01e2bd8>] (bus_for_each_dev+0x0/0x98) from [<c01e40c0>] (driver_attach+0x20/0x28)
 r7:c188e0c0 r6:c043f740 r5:c043f740 r4:c042ac20
[<c01e40a0>] (driver_attach+0x0/0x28) from [<c01e34b0>] (bus_add_driver+0xa8/0x22c)
[<c01e3408>] (bus_add_driver+0x0/0x22c) from [<c01e4ae4>] (driver_register+0xc8/0x154)
[<c01e4a1c>] (driver_register+0x0/0x154) from [<c01e5b24>] (platform_driver_register+0x4c/0x60)
 r8:00000000 r7:00000013 r6:c003a2f0 r5:c042af5c r4:c042ac20
[<c01e5ad8>] (platform_driver_register+0x0/0x60) from [<c04095dc>] (omap2_mbox_init+0x14/0x1c)
[<c04095c8>] (omap2_mbox_init+0x0/0x1c) from [<c0008798>] (do_one_initcall+0x9c/0x164)
[<c00086fc>] (do_one_initcall+0x0/0x164) from [<c03fe284>] (kernel_init+0x7c/0x120)
[<c03fe208>] (kernel_init+0x0/0x120) from [<c003a2f0>] (do_exit+0x0/0x2d8)
 r5:c03fe208 r4:00000000
<0>Code: e3590001 8a000005 e51b003c e0803109 (e5934004) 
<4>---[ end trace 1b75b31a2719ed1c ]---
<6>note: swapper[1] exited with preempt_count 1
<0>Kernel panic - not syncing: Attempted to kill init!

