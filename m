From: "Premi, Sanjeev" <premi@ti.com>
Subject: omap3evm: observing bug in lockdep
Date: Thu, 23 Jun 2011 21:56:47 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D6C29DB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55932 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758347Ab1FWQ0w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Jun 2011 12:26:52 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5NGQm7f021916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 11:26:51 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5NGQmAT026940
	for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 21:56:48 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

I am currently on the pm branch. And my HEAD is at:

commit 40d10207b5389184333bacb786d27036cbcee500
Merge: 6b10874 b830f73
Author: Kevin Hilman <khilman@ti.com>
Date:   Thu Jun 16 16:31:51 2011 -0700

    rebuild PM from branches

Every now and then EVM doesn't boot at all. OR shows this
error (at end of this mail). Otherwise, there is no problem
at all!

The uImage was build with omap2plus_defconfig with only
OMAP3EVM and OMAP3BEAGLE selected.

Haven't yet tried to update my repo - but wanted to share
the issue.

Best regards,
Sanjeev


Uncompressing Linux... done, booting the kernel.
[    0.000000] Linux version 3.0.0-rc3-13998-g40d1020-dirty (premi@mylinux) (gcc version 4.3.3 (Sourcery G++ Lite 2009q1-203) ) #3 Thu Jun 23 21:12:56 IST 2011
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: OMAP3 EVM
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3630 ES1.1 (l2cache iva sgx neon isp 192mhz_clk )
[    0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x10000
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz
[    0.000000] Reprogramming SDRC clock to 40000000
[    0.000000] dpll3_m2_clk rate change failed: -22
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: console=ttyO0,115200n8 mem=128M root=/dev/ram0 rw initrd=0x81600000,24M ip=dhcp earlyprintk=serial,ttyO0,115200
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 128MB = 128MB total
[    0.000000] Memory: 95576k/95576k available, 35496k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xc8800000 - 0xf8000000   ( 760 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc0034000   ( 176 kB)
[    0.000000]       .text : 0xc0034000 - 0xc03f806c   (3857 kB)
[    0.000000]       .data : 0xc03fa000 - 0xc043e090   ( 273 kB)
[    0.000000] NR_IRQS:410
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.000732] Calibrating delay loop... 597.64 BogoMIPS (lpj=2334720)
[    0.093780] pid_max: default: 32768 minimum: 301
[    0.094177] Security Framework initialized
[    0.094360] Mount-cache hash table entries: 512
[    0.097381] CPU: Testing write buffer coherency: ok
[    0.105743] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_core
[    0.105743] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_per
[    0.105773] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_wkup
[    0.106079] omap_hwmod: gpt12_fck: missing clockdomain for gpt12_fck.
[    0.121002] omap_hwmod: i2c1: softreset failed (waited 10000 usec)
[    0.134460] omap_hwmod: i2c2: softreset failed (waited 10000 usec)
[    0.147918] omap_hwmod: i2c3: softreset failed (waited 10000 usec)
[    0.152343] print_constraints: dummy:
[    0.153259] GPMC revision 5.0
[    0.160003] omap_device: omap_gpio.0: new worst case activate latency 0: 61035
[    0.161834] OMAP GPIO hardware version 2.5
[    0.173095] omap_mux_init: Add partition: #1: core, flags: 0
[    0.181579] omap_device: omap_uart.0: new worst case activate latency 0: 30517
[    0.184814] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.193725] OMAP DMA hardware revision 5.0
[    0.220489] bio: create slab <bio-0> at 0
[    0.227294] SCSI subsystem initialized
[    0.227844] omap_device: omap2_mcspi.1: new worst case activate latency 0: 30517
[    0.230194] omap_device: omap2_mcspi.1: new worst case deactivate latency 0: 30517
[    0.234130] omap_device: omap_i2c.1: new worst case activate latency 0: 30517
[    0.234283] omap_i2c omap_i2c.1: bus 1 rev1.4.0 at 2600 kHz
[    0.243225] twl4030: PIH (irq 7) chaining IRQs 368..375
[    0.243377] twl4030: power (irq 373) chaining IRQs 376..383
[    0.244995] twl4030: gpio (irq 368) chaining IRQs 384..401
[    0.255798] print_constraints: VIO: 1800 mV normal standby
[    0.257812] print_constraints: VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
[    0.259887] print_constraints: VDAC: 1800 mV normal standby
[    0.261901] print_constraints: VPLL2: 1800 mV normal standby
[    0.263763] print_constraints: VSIM: 1800 <--> 3000 mV at 1800 mV normal standby
[    0.264251] omap_device: omap_i2c.1: new worst case deactivate latency 0: 30517
[    0.273651] omap_i2c omap_i2c.2: bus 2 rev1.4.0 at 400 kHz
[    0.289245] omap_i2c omap_i2c.3: bus 3 rev1.4.0 at 400 kHz
[    0.292388] Switching to clocksource 32k_counter
[    0.297271] Switched to NOHz mode on CPU #0
[    0.372436] Trying to unpack rootfs image as initramfs...
[    0.374481] rootfs image is not initramfs (no cpio magic); looks like an initrd
[    0.516082] Freeing initrd memory: 24576K
[    0.516113] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.583679] VFS: Disk quotas dquot_6.5.2
[    0.583740] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.584411] JFFS2 version 2.2. (NAND) (SUMMARY)  (c) 2001-2006 Red Hat, Inc.
[    0.584777] msgmni has been set to 234
[    0.586791] io scheduler noop registered
[    0.586822] io scheduler deadline registered
[    0.586883] io scheduler cfq registered (default)
[    0.589080] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.593261] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq = 72) is a OMAP UART0
[    1.174285] console [ttyO0] enabled
[    1.179046] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq = 73) is a OMAP UART1
[    1.187347] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq = 74) is a OMAP UART2
[    1.195587] omap_uart.3: ttyO3 at MMIO 0x49042000 (irq = 80) is a OMAP UART3
[    1.205932] BUG: looking up invalid subclass: 3347450624
[    1.211608] turning off the locking correctness validator.
[    1.217468] [<c00456e0>] (unwind_backtrace+0x0/0xf8) from [<c00a0708>] (__lock_acquire+0x18d8/0x1ce4)
[    1.227294] [<c00a0708>] (__lock_acquire+0x18d8/0x1ce4) from [<c00a10dc>] (lock_acquire+0xd4/0xf8)
[    1.236846] [<c00a10dc>] (lock_acquire+0xd4/0xf8) from [<c02e4b20>] (__atomic_notifier_call_chain+0x4c/0x90)
[    1.247314] [<c02e4b20>] (__atomic_notifier_call_chain+0x4c/0x90) from [<c02e4b7c>] (atomic_notifier_call_chain+0x18/0x20)
[    1.259094] [<c02e4b7c>] (atomic_notifier_call_chain+0x18/0x20) from [<c006ea84>] (do_exit+0x178/0x6f8)
[    1.269104] [<c006ea84>] (do_exit+0x178/0x6f8) from [<c00813b4>] (____call_usermodehelper+0x154/0x158)
[    1.279022] [<c00813b4>] (____call_usermodehelper+0x154/0x158) from [<c00405e0>] (kernel_thread_exit+0x0/0x8)
[    1.289581] Internal error: Oops - undefined instruction: 0 [#1]
[    1.295989] Modules linked in:
[    1.299224] CPU: 0    Not tainted  (3.0.0-rc3-13998-g40d1020-dirty #3)
[    1.306182] PC is at runqueues+0x4/0x498
[    1.310363] LR is at debug_locks+0x0/0x4
[    1.314544] pc : [<c04107d4>]    lr : [<c042c204>]    psr: 60000093
[    1.314544] sp : c5df3e64  ip : 20000093  fp : c042c204
[    1.326782] r10: 00000000  r9 : c009f24c  r8 : c0888460
[    1.332336] r7 : c042c204  r6 : 00000000  r5 : c043f468  r4 : c0413fc0
[    1.339294] r3 : 00000001  r2 : c0413fc0  r1 : c0450e88  r0 : 00000000
[    1.346221] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
[    1.353912] Control: 10c5387d  Table: 80004019  DAC: 00000015
[    1.360046] Process kworker/u:0 (pid: 310, stack limit = 0xc5df22f0)
[    1.366821] Stack: (0xc5df3e64 to 0xc5df4000)
[    1.371459] 3e60:          c7860b00 c045d510 0000000b c7860b00 00000001 00000002 00000000
[    1.380157] 3e80: c7860b00 00000001 00000000 00000000 20000093 00000000 c7860b00 c7860f40
[    1.388854] 3ea0: 0000002c 00000000 c782ee0c c7860f40 0000000b 00000000 c782ee0c c7860f58
[    1.397583] 3ec0: 0008605c 00000000 00000043 00000000 00000001 00000000 00000000 00000000
[    1.406280] 3ee0: 00000000 00000000 00000000 00000000 00000002 c0413300 00000001 60000013
[    1.415008] 3f00: 00000000 c00a10dc 00000001 00000000 00000000 c02e4ad4 00000000 c7839500
[    1.423706] 3f20: c0412cb0 c0413300 c5df2000 00000001 ffffffff c03ff87c c5dd07c0 00000001
[    1.432434] 3f40: 00000001 c02e4b20 00000001 00000000 c02e4ad4 c0101024 c78abce8 00000000
[    1.441131] 3f60: c0412cb8 c7860b00 c0412cb0 c78abce8 c78abcc0 c02e4b7c 00000000 c78abcc0
[    1.449829] 3f80: 00000001 c006ea84 00000000 00000000 00000000 00000000 00000000 00000000
[    1.458557] 3fa0: 00000000 c5df3fc8 c0412cb8 ffffffff c0412cb0 c78abce8 c5dd07c0 c78abcc0
[    1.467254] 3fc0: 00000000 c00813b4 00000000 00000000 ffffffff ffffffff c5dd07c0 c0081260
[    1.475982] 3fe0: c00405e0 00000013 00000000 00000000 00000000 c00405e0 00000000 00000000
[    1.484680] Code: c00be634 c00be634 00000000 00000001 (dead4ead)
[    1.491241] ---[ end trace c92f2ccff97b1f33 ]---
[    1.496185] Fixing recursive fault but reboot is needed!
[    1.511383] brd: module loaded
[    1.520507] loop: module loaded
[    1.525299] mtdoops: mtd device (mtddev=name/number) must be supplied
[    1.532226] omap2-nand driver initializing
[    1.537017] OneNAND driver initializing
[    1.542327] mousedev: PS/2 mouse device common for all mice
[    1.549377] input: TWL4030 Keypad as /devices/platform/omap/omap_i2c.1/i2c-1/1-004a/twl4030_keypad/input/input0
[    1.562652] ads7846 spi1.0: touchscreen, irq 335
[    1.568450] input: ADS7846 Touchscreen as /devices/platform/omap/omap2_mcspi.1/spi1.0/input/input1
[    1.579681] input: twl4030_pwrbutton as /devices/platform/omap/omap_i2c.1/i2c-1/1-0049/twl4030_pwrbutton/input/input2
[    1.592895] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    1.599609] twl_rtc twl_rtc: Power up reset detected.
[    1.605316] twl_rtc twl_rtc: Enabling TWL-RTC.
[    1.610565] i2c /dev entries driver
[    1.615539] Driver for 1-wire Dallas network protocol.
[    1.621734] omap_device: omap_wdt.-1: new worst case activate latency 0: 30517
[    1.630035] OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
[    1.636871] twl4030_wdt twl4030_wdt: Failed to register misc device
[    1.643554] twl4030_wdt: probe of twl4030_wdt failed with error -16
[    1.654083] oprofile: hardware counters not available
[    1.659454] oprofile: using timer interrupt.
[    1.664062] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
[    1.672271] ThumbEE CPU extension supported.
[    1.689636] clock: disabling unused clocks to save power
[    1.697967] twl_rtc twl_rtc: setting system clock to 2000-01-01 00:00:00 UTC (946684800)
[    1.707122] RAMDISK: gzip image found at block 0
[    1.941314] VFS: Mounted root (ext2 filesystem) on device 1:0.
[    1.947631] Freeing init memory: 176K



premi # grep -R "looking up invalid subclass" .
Binary file ./arch/arm/boot/Image matches
./kernel/lockdep.c:                     "BUG: looking up invalid subclass: %u\n", subclass);
Binary file ./kernel/lockdep.o matches
Binary file ./kernel/built-in.o matches
premi #
premi # 