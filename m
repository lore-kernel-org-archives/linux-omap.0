From: Daniel Mack <zonque@gmail.com>
Subject: Trouble with newer kernels on Gumstix Overo boards
Date: Fri, 17 Jun 2011 16:00:06 +0200
Message-ID: <BANLkTimJTBpj30EKf_EucvOf2yCHHbRrkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39841 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757622Ab1FQOAH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jun 2011 10:00:07 -0400
Received: by pvg12 with SMTP id 12so1839925pvg.19
        for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 07:00:06 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony et al,

I'm having problems booting newer kernels on a Gumstix Overo board.

I enabled CONFIG_EARLY_PRINTK to see any messages at all, and see a
number of warnings first and then lots of garbled binary junk once the
UART is set up.

This is Linus' current master branch plus your latest fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.g=
it fixes


Uncompressing Linux... done, booting the kernel.
[    0.000000] Linux version 3.0.0-rc3-00209-g64db347-dirty
(daniel@jup) (gcc version 4.4.5 (Buildroot 2010.11-git) ) #24 SMP Fri
Jun 17 15:42:59 CEST 2011
[    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=3D=
10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing
instruction cache
[    0.000000] Machine: Gumstix Overo
[    0.000000] Ignoring tag cmdline (using the default kernel command l=
ine)
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3503 ES3.1 (l2cache neon isp )
[    0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x1000=
0
[    0.000000] On node 0 totalpages: 65536
[    0.000000] free_area_init_node: node 0, pgdat c065e9e0,
node_mem_map c0bb5000
[    0.000000]   Normal zone: 512 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 65024 pages, LIFO batch:15
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/331/500 MHz
[    0.000000] Reprogramming SDRC clock to 331882352 Hz
[    0.000000] PERCPU: Embedded 7 pages/cpu @c0dba000 s5952 r8192 d1452=
8 u32768
[    0.000000] pcpu-alloc: s5952 r8192 d14528 u32768 alloc=3D8*4096
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 65024
[    0.000000] Kernel command line: debug earlyprintk
console=3DttyS2,115200 root=3D/dev/mmcblk0p2 rw rootfstype=3Dext3 rootw=
ait
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072=
 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 b=
ytes)
[    0.000000] Memory: 256MB =3D 256MB total
[    0.000000] Memory: 247860k/247860k available, 14284k reserved, 0K h=
ighmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xd0800000 - 0xf8000000   ( 632 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc0051000   ( 292 kB)
[    0.000000]       .text : 0xc0051000 - 0xc05dd334   (5681 kB)
[    0.000000]       .data : 0xc05de000 - 0xc065fe00   ( 520 kB)
[    0.000000]        .bss : 0xc065fe24 - 0xc0bb4e68   (5461 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:410
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns,
wraps every 131071999ms
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat,
Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.057312] Calibrating delay loop... 497.82 BogoMIPS (lpj=3D1941504=
)
[    0.096282] pid_max: default: 32768 minimum: 301
[    0.102081] Security Framework initialized
[    0.106842] Mount-cache hash table entries: 512
[    0.117034] CPU: Testing write buffer coherency: ok
[    0.126556] Brought up 1 CPUs
[    0.129730] SMP: Total of 1 processors activated (497.82 BogoMIPS).
[    0.154479] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va fo=
r l4_core
[    0.162017] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va fo=
r l4_per
[    0.169433] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va fo=
r l4_wkup
[    0.177429] omap_hwmod: gpt12_fck: missing clockdomain for gpt12_fck=
=2E
[    0.200500] omap_hwmod: i2c1: softreset failed (waited 10000 usec)
[    0.221557] omap_hwmod: i2c2: softreset failed (waited 10000 usec)
[    0.242614] omap_hwmod: i2c3: softreset failed (waited 10000 usec)
[    0.249938] omap_hwmod: am35x_otg_hs: cannot be enabled (3)
[    0.261901] print_constraints: dummy:
[    0.267517] NET: Registered protocol family 16
[    0.273895] GPMC revision 5.0
[    0.287017] omap_device: omap_gpio.0: new worst case activate
latency 0: 91552
[    0.298126] OMAP GPIO hardware version 2.5
[    0.304260] OMAP GPIO hardware version 2.5
[    0.310638] OMAP GPIO hardware version 2.5
[    0.316986] OMAP GPIO hardware version 2.5
[    0.323150] OMAP GPIO hardware version 2.5
[    0.329376] OMAP GPIO hardware version 2.5
[    0.344146] omap_mux_init: Add partition: #1: core, flags: 0
[    0.362213] omap_device: omap_uart.0: new worst case activate
latency 0: 30517
[    0.362579] omap_device: omap_uart.0: new worst case deactivate
latency 0: 30517
[    0.381591] Found NAND on CS0
[    0.384857] Registering NAND on CS0
[    0.391021] kobject (c06231f0): tried to init an initialized
object, something is seriously wrong.
[    0.400482] [<c0063f7c>] (unwind_backtrace+0x0/0xf4) from
[<c0266f28>] (kobject_init+0x7c/0x90)
[    0.409637] [<c0266f28>] (kobject_init+0x7c/0x90) from [<c02c1130>]
(device_initialize+0x24/0x94)
[    0.418945] [<c02c1130>] (device_initialize+0x24/0x94) from
[<c02c4f60>] (platform_device_register+0x10/0x1c)
[    0.429321] [<c02c4f60>] (platform_device_register+0x10/0x1c) from
[<c0016478>] (overo_init+0x84/0x238)
[    0.439178] [<c0016478>] (overo_init+0x84/0x238) from [<c000b5cc>]
(customize_machine+0x1c/0x28)
[    0.448394] [<c000b5cc>] (customize_machine+0x1c/0x28) from
[<c0051518>] (do_one_initcall+0x34/0x17c)
[    0.458068] [<c0051518>] (do_one_initcall+0x34/0x17c) from
[<c0008570>] (kernel_init+0x88/0x130)
[    0.467285] [<c0008570>] (kernel_init+0x88/0x130) from [<c005dd9c>]
(kernel_thread_exit+0x0/0x8)
[    0.476562] ------------[ cut here ]------------
[    0.481445] WARNING: at fs/sysfs/dir.c:455 sysfs_add_one+0x88/0xb0()
[    0.488128] sysfs: cannot create duplicate filename
'/devices/platform/reg-fixed-voltage.1'
[    0.496887] Modules linked in:
[    0.500213] [<c0063f7c>] (unwind_backtrace+0x0/0xf4) from
[<c009879c>] (warn_slowpath_common+0x4c/0x64)
[    0.510040] [<c009879c>] (warn_slowpath_common+0x4c/0x64) from
[<c0098848>] (warn_slowpath_fmt+0x30/0x40)
[    0.520080] [<c0098848>] (warn_slowpath_fmt+0x30/0x40) from
[<c0194c84>] (sysfs_add_one+0x88/0xb0)
[    0.529479] [<c0194c84>] (sysfs_add_one+0x88/0xb0) from
[<c019588c>] (create_dir+0x60/0xc8)
[    0.538238] [<c019588c>] (create_dir+0x60/0xc8) from [<c0195978>]
(sysfs_create_dir+0x84/0xcc)
[    0.547271] [<c0195978>] (sysfs_create_dir+0x84/0xcc) from
[<c0267294>] (kobject_add_internal+0x9c/0x1b8)
[    0.557281] [<c0267294>] (kobject_add_internal+0x9c/0x1b8) from
[<c0267520>] (kobject_add+0x34/0x64)
[    0.566864] [<c0267520>] (kobject_add+0x34/0x64) from [<c02c153c>]
(device_add+0x88/0x5a4)
[    0.575561] [<c02c153c>] (device_add+0x88/0x5a4) from [<c02c4eb4>]
(platform_device_add+0xf8/0x194)
[    0.585021] [<c02c4eb4>] (platform_device_add+0xf8/0x194) from
[<c0016478>] (overo_init+0x84/0x238)
[    0.594512] [<c0016478>] (overo_init+0x84/0x238) from [<c000b5cc>]
(customize_machine+0x1c/0x28)
[    0.603729] [<c000b5cc>] (customize_machine+0x1c/0x28) from
[<c0051518>] (do_one_initcall+0x34/0x17c)
[    0.613403] [<c0051518>] (do_one_initcall+0x34/0x17c) from
[<c0008570>] (kernel_init+0x88/0x130)
[    0.622619] [<c0008570>] (kernel_init+0x88/0x130) from [<c005dd9c>]
(kernel_thread_exit+0x0/0x8)
[    0.632202] ---[ end trace 1b75b31a2719ed1c ]---
[    0.637145] kobject_add_internal failed for reg-fixed-voltage.1
with -EEXIST, don't try to register things with the same name in the
same directory.
[    0.651031] [<c0063f7c>] (unwind_backtrace+0x0/0xf4) from
[<c0267398>] (kobject_add_internal+0x1a0/0x1b8)
[    0.661041] [<c0267398>] (kobject_add_internal+0x1a0/0x1b8) from
[<c0267520>] (kobject_add+0x34/0x64)
[    0.670715] [<c0267520>] (kobject_add+0x34/0x64) from [<c02c153c>]
(device_add+0x88/0x5a4)
[    0.679382] [<c02c153c>] (device_add+0x88/0x5a4) from [<c02c4eb4>]
(platform_device_add+0xf8/0x194)
[    0.688873] [<c02c4eb4>] (platform_device_add+0xf8/0x194) from
[<c0016478>] (overo_init+0x84/0x238)
[    0.698364] [<c0016478>] (overo_init+0x84/0x238) from [<c000b5cc>]
(customize_machine+0x1c/0x28)
[    0.707550] [<c000b5cc>] (customize_machine+0x1c/0x28) from
[<c0051518>] (do_one_initcall+0x34/0x17c)
[    0.717224] [<c0051518>] (do_one_initcall+0x34/0x17c) from
[<c0008570>] (kernel_init+0x88/0x130)
[    0.726440] [<c0008570>] (kernel_init+0x88/0x130) from [<c005dd9c>]
(kernel_thread_exit+0x0/0x8)
[    0.752105] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.778869] OMAP DMA hardware revision 4.0
[    0.866241] bio: create slab <bio-0> at 0
[    0.883331] SCSI subsystem initialized
[    0.888000] omap_device: omap2_mcspi.1: new worst case activate
latency 0: 30517
[    0.900268] omap2_mcspi omap2_mcspi.1: chipselect 0 already in use
[    0.906921] omap2_mcspi omap2_mcspi.1: can't create new device for a=
ds7846
[    0.914215] omap_device: omap2_mcspi.1: new worst case deactivate
latency 0: 30517
[    0.930358] usbcore: registered new interface driver usbfs
[    0.938018] usbcore: registered new interface driver hub
[    0.944519] usbcore: registered new device driver usb
[    0.952636] omap_device: omap_i2c.1: new worst case activate latency=
 0: 30517
[    0.968933] omap_i2c omap_i2c.1: bus 1 rev3.12 at 2600 kHz
[    0.987884] twl4030: PIH (irq 7) chaining IRQs 368..375
[    0.993652] twl4030: power (irq 373) chaining IRQs 376..383
[    1.002136] twl4030: gpio (irq 368) chaining IRQs 384..401
[    1.021820] print_constraints: VMMC1: 1850 <--> 3150 mV at 3000 mV
normal standby
[    1.033050] print_constraints: VDAC: 1800 mV normal standby
[    1.041870] print_constraints: VDVI: 1800 mV normal standby
[    1.048675] omap_device: omap_i2c.1: new worst case deactivate
latency 0: 30517
[    1.056854] omap_i2c omap_i2c.3: bus 3 rev3.12 at 400 kHz
[    1.074707] Switching to clocksource 32k_counter
[    1.085968] Switched to NOHz mode on CPU #0
[    1.217803] NET: Registered protocol family 2
[    1.223388] IP route cache hash table entries: 2048 (order: 1, 8192 =
bytes)
[    1.233093] TCP established hash table entries: 8192 (order: 4, 6553=
6 bytes)
[    1.241058] TCP bind hash table entries: 8192 (order: 6, 294912 byte=
s)
[    1.253143] TCP: Hash tables configured (established 8192 bind 8192)
[    1.259887] TCP reno registered
[    1.263305] UDP hash table entries: 128 (order: 1, 10240 bytes)
[    1.269927] UDP-Lite hash table entries: 128 (order: 1, 10240 bytes)
[    1.277832] NET: Registered protocol family 1
[    1.284698] RPC: Registered named UNIX socket transport module.Is
that a known issue?

[    1.290924] RPC: Registered udp transport module.
[    1.295959] RPC: Registered tcp transport module.
[    1.300964] RPC: Registered tcp NFSv4.1 backchannel transport module=
=2E
[    1.308837] NetWinder Floating Point Emulator V0.97 (double precisio=
n)
[    1.318511] omap_init_opp_table: no hwmod or odev for iva, [8]
cannot add OPPs.
[    1.518035] VFS: Disk quotas dquot_6.5.2
[    1.522644] Dquot-cache hash table entries: 1024 (order 0, 4096 byte=
s)
[    1.533508] JFFS2 version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red H=
at, Inc.
[    1.542449] msgmni has been set to 484
[    1.552124] io scheduler noop registered
[    1.556274] io scheduler deadline registered
[    1.561187] io scheduler cfq registered (default)
[    1.571533] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.588043] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is a =
OMAP UART0
[    1.597991] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73) is a =
OMAP UART1
[    1.607421] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74) is a =
OMAP UART2

=2E.. and lots of binary junk after this line. Seems like the UART is
configured to some other baud rate at this point, but I can't see the
reason yet. Most probably, the kernel runs into an Ooops later on
which I can't see as my serial console is toast.

Older kernels (ie, 2.6.36) work just fine. Do I miss anything obvious?


Thanks,
Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
