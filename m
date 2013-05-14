From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: am3517: failed to boot 3.10-rc1
Date: Tue, 14 May 2013 11:24:44 +0200
Message-ID: <519202DC.10100@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.vscom.de ([62.145.30.242]:59237 "EHLO mail.visionsystems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756288Ab3ENJvZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 May 2013 05:51:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Mark A. Greer" <mgreer@animalcreek.com>, Maxim Podbereznyy <lisarden@gmail.com>

Trying to boot 3.10-rc1 on an am3515 based board. With the same .config=
 as 3.7 the system comes to RTC stops there. I've also tried make omap2=
plus_defconfig with no visible difference. I'm booting from MMC card an=
d it will be detected by the system. Kernel is from http://git.kernel.o=
rg/cgit/linux/kernel/git/torvalds/linux.git, latest commit f722406faae2=
d073cc1d01063d1123c35425939e. Are there any pending patches needed to b=
oot on am3517?

Here bootlog:

Booting from mmc ...
## Booting kernel from Legacy Image at 82000000 ...
   Image Name:   Linux-3.10.0-rc1-dirty
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3750728 Bytes =3D 3.6 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.10.0-rc1-dirty (YegorYefremov@developmen=
t1) (gcc version 4.5.3 (Buildroot 2012.05-rc2-00022-g339098e) ) #27 SMP=
 Tue May 14 11:10:08 CEST 2013
[    0.000000] CPU: ARMv7 Processor [411fc087] revision 7 (ARMv7), cr=3D=
10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasin=
g instruction cache
[    0.000000] Machine: OMAP3517/AM3517 EVM
[    0.000000] Ignoring tag cmdline (using the default kernel command l=
ine)
[    0.000000] cma: CMA: reserved 16 MiB at 8e800000
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] AM3517 ES1.1 (l2cache sgx neon )
[    0.000000] PERCPU: Embedded 9 pages/cpu @c0ecd000 s13632 r8192 d150=
40 u36864
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  =
Total pages: 64768
[    0.000000] Kernel command line: root=3D/dev/mmcblk0p2 rootwait cons=
ole=3DttyO2,115200 nohlt
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072=
 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 b=
ytes)
[    0.000000] Memory: 255MB =3D 255MB total
[    0.000000] Memory: 229308k/229308k available, 32836k reserved, 0K h=
ighmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0689084   (6661 kB)
[    0.000000]       .init : 0xc068a000 - 0xc06e2540   ( 354 kB)
[    0.000000]       .data : 0xc06e4000 - 0xc0764f68   ( 516 kB)
[    0.000000]        .bss : 0xc0764f68 - 0xc0cc6b58   (5511 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=3D2 to nr_cpu_ids=3D1=
=2E
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 =
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps=
 every 131071999ms
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, I=
nc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.001464] Calibrating delay loop... 329.31 BogoMIPS (lpj=3D1646592=
)
[    0.119567] pid_max: default: 32768 minimum: 301
[    0.120330] Security Framework initialized
[    0.120544] Mount-cache hash table entries: 512
[    0.125946] CPU: Testing write buffer coherency: ok
[    0.128051] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.128204] Setting up static identity map for 0xc04a99c8 - 0xc04a9a=
20
[    0.133209] Brought up 1 CPUs
[    0.133270] SMP: Total of 1 processors activated (329.31 BogoMIPS).
[    0.133270] CPU: All CPU(s) started in SVC mode.
[    0.137817] devtmpfs: initialized
[    0.205139] pinctrl core: initialized pinctrl subsystem
[    0.212188] regulator-dummy: no parameters
[    0.217559] NET: Registered protocol family 16
[    0.230255] DMA: preallocated 256 KiB pool for atomic coherent alloc=
ations
[    0.233306] omap-gpmc omap-gpmc: GPMC revision 5.0
[    0.249542] OMAP GPIO hardware version 2.5
[    0.276336] omap_mux_init: Add partition: #1: core, flags: 4
[    0.296539] omap_mux_get_by_name: Could not find signal uart4_rx.uar=
t4_rx
[    0.305114] Reprogramming SDRC clock to 332000000 Hz
[    0.314483] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.336059] OMAP DMA hardware revision 4.0
[    0.341400]  arm-pmu: alias fck already exists
[    0.428009] bio: create slab <bio-0> at 0
[    0.555541] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    0.557830] hsusb1_reset: 3300 mV
[    0.570617] SCSI subsystem initialized
[    0.580078] omap_i2c omap_i2c.1: bus 1 rev3.3 at 400 kHz
[    0.584442] omap_i2c omap_i2c.2: bus 2 rev3.3 at 400 kHz
[    0.588378] omap_i2c omap_i2c.3: bus 3 rev3.3 at 400 kHz
[    0.600799] Switching to clocksource 32k_counter
[    0.820800] NET: Registered protocol family 2
[    0.824340] TCP established hash table entries: 2048 (order: 2, 1638=
4 bytes)
[    0.824645] TCP bind hash table entries: 2048 (order: 4, 73728 bytes=
)
[    0.826019] TCP: Hash tables configured (established 2048 bind 2048)
[    0.826416] TCP: reno registered
[    0.826477] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.826873] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.829101] NET: Registered protocol family 1
[    0.832214] RPC: Registered named UNIX socket transport module.
[    0.832275] RPC: Registered udp transport module.
[    0.832275] RPC: Registered tcp transport module.
[    0.832305] RPC: Registered tcp NFSv4.1 backchannel transport module=
=2E
[    0.833953] NetWinder Floating Point Emulator V0.97 (double precisio=
n)
[    0.834472] CPU PMU: probing PMU on CPU 0
[    0.834533] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver, =
5 counters available
[    1.104064] VFS: Disk quotas dquot_6.5.2
[    1.104431] Dquot-cache hash table entries: 1024 (order 0, 4096 byte=
s)
[    1.108551] NFS: Registering the id_resolver key type
[    1.109283] Key type id_resolver registered
[    1.109313] Key type id_legacy registered
[    1.109558] jffs2: version 2.2. (NAND) (SUMMARY)  =E2=94=AC=E2=8C=90=
 2001-2006 Red Hat, Inc.
[    1.110443] msgmni has been set to 479
[    1.116119] io scheduler noop registered
[    1.116149] io scheduler deadline registered
[    1.116271] io scheduler cfq registered (default)
[    1.118896] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.131408] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 88) is a =
OMAP UART0
[    1.135284] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 89) is a =
OMAP UART1
[    1.138183] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 90) is a =
OMAP UART2
[    1.769134] console [ttyO2] enabled
[    1.775909] omap_uart.3: ttyO3 at MMIO 0x4809e000 (irq =3D 100) is a=
 OMAP UART3
[    1.834869] brd: module loaded
[    1.868225] loop: module loaded
[    1.879669] mtdoops: mtd device (mtddev=3Dname/number) must be suppl=
ied
[    1.911224] mousedev: PS/2 mouse device common for all mice
[    1.940277] rtc-s35390a 1-0030: rtc core: registered rtc-s35390a as =
rtc0
[    1.948974] i2c /dev entries driver
[    1.959381] Driver for 1-wire Dallas network protocol.
[    1.972198] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout =
60 sec
[    1.985198] omap-dma-engine omap-dma-engine: allocating channel for =
62
[    1.992523] omap-dma-engine omap-dma-engine: allocating channel for =
61
[    2.043548] omap-dma-engine omap-dma-engine: allocating channel for =
48
[    2.050506] omap-dma-engine omap-dma-engine: allocating channel for =
47
[    2.091613] mmc0: host does not support reading read-only switch. as=
suming write-enable.
[    2.103668] mmc0: new high speed SD card at address 0007
[    2.115600] mmcblk0: mmc0:0007 SD02G 1.84 GiB
[    2.129333] oprofile: using arm/armv7
[    2.135131] TCP: cubic registered
[    2.138641] Initializing XFRM netlink socket
[    2.143707] NET: Registered protocol family 17
[    2.148559] NET: Registered protocol family 15
[    2.153991] Key type dns_resolver registered
[    2.158630] VFP support v0.3: implementor 41 architecture 3 part 30 =
variant c rev 1
[    2.177581] voltdm_scale: No voltage scale API registered for vdd_mp=
u_iva
[    2.184906] voltdm_scale: No voltage scale API registered for vdd_co=
re
[    2.193328]  mmcblk0: p1 p2
[    2.200012] PM: no software I/O chain control; some wakeups may be l=
ost
[    2.207855] ThumbEE CPU extension supported.
[    2.212615] Registering SWP/SWPB emulation handler
[    2.236633] rtc-s35390a 1-0030: setting system clock to 2000-01-01 0=
1:20:01 UTC (946689601)

Yegor
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
