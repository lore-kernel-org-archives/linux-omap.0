From: Belisko Marek <marek.belisko@gmail.com>
Subject: booting gta04 (kernel 3.6) with devicetree lead to can't open
 /dev/ttyO2: No such file or directory
Date: Sat, 13 Oct 2012 23:02:39 +0200
Message-ID: <CAAfyv34XAapDd1_cWfd+P4LfzwxSK12_egFSfj9Fs+6NzkeUiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:37223 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833Ab2JMVCk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Oct 2012 17:02:40 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so2799302iag.19
        for <linux-omap@vger.kernel.org>; Sat, 13 Oct 2012 14:02:39 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I'm working on adding gta04 board (omap 3630) to be able boot with devi=
ce tree.
Booting kernel 3.6 seems working fine but I'm facing a problem when
userspace start it complain it cannot open /dev/ttyO2 console. Booting
without dtb
it's working fine. Any ideas? Am I missing something?

[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.6.0-00002-g269a275-dirty
(open-nandra@nandra-host) (gcc version 4.6.3 20120201 (prerelease)
(crosstool-NG linaro-1.13.1-2012.02-20120222
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=3D=
10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine: Generic OMAP3 (Flattened Device Tree), model:
OMAP3 GTA04 (OMAP3730)
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/600 MHz
[    0.000000] PERCPU: Embedded 9 pages/cpu @c10d3000 s12736 r8192 d159=
36 u36864
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 129792
[    0.000000] Kernel command line: root=3D/dev/mmcblk0p2 rootwait
console=3DttyO2,115200
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144=
 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 =
bytes)
[    0.000000] Memory: 511MB =3D 511MB total
[    0.000000] Memory: 505600k/505600k available, 18688k reserved, 0K h=
ighmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc067ff6c   (6624 kB)
[    0.000000]       .init : 0xc0680000 - 0xc06cf1c0   ( 317 kB)
[    0.000000]       .data : 0xc06d0000 - 0xc076cf00   ( 628 kB)
[    0.000000]        .bss : 0xc076cf24 - 0xc0cc6f8c   (5481 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=3D2 to nr_cpu_ids=3D1=
=2E
[    0.000000] NR_IRQS:474
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns,
wraps every 131071999ms
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
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
[    0.000854] Calibrating delay loop... 397.57 BogoMIPS (lpj=3D1554432=
)
[    0.109344] pid_max: default: 32768 minimum: 301
[    0.109863] Security Framework initialized
[    0.110046] Mount-cache hash table entries: 512
[    0.119232] CPU: Testing write buffer coherency: ok
[    0.120147] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.120208] Setting up static identity map for 0x804a7c08 - 0x804a7c=
78
[    0.122406] Brought up 1 CPUs
[    0.122436] SMP: Total of 1 processors activated (397.57 BogoMIPS).
[    0.143829] dummy:
[    0.145965] NET: Registered protocol family 16
[    0.146728] DMA: preallocated 256 KiB pool for atomic coherent alloc=
ations
[    0.147705] GPMC revision 5.0
[    0.147918] gpmc: irq-20 could not claim: err -22
[    0.163360] Reprogramming SDRC clock to 332000000 Hz
[    0.163391] dpll3_m2_clk rate change failed: -22
[    0.171417] OMAP GPIO hardware version 2.5
[    0.197387] No ATAGs?
[    0.197418] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.209869]  omap-mcbsp.2: alias fck already exists
[    0.210693]  omap-mcbsp.3: alias fck already exists
[    0.216308] OMAP DMA hardware revision 5.0
[    0.281707] bio: create slab <bio-0> at 0
[    0.377075] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    0.385131] SCSI subsystem initialized
[    0.387786] usbcore: registered new interface driver usbfs
[    0.388366] usbcore: registered new interface driver hub
[    0.389221] usbcore: registered new device driver usb
[    0.406707] omap_i2c i2c.14: bus -1 rev1.4.0 at 2600 kHz
[    0.416412] twl 0-0048: PIH (irq 7) chaining IRQs 320..328
[    0.416992] twl 0-0048: power (irq 325) chaining IRQs 328..335
[    0.421539] VDAC: 1800 mV
[    0.424896] VPLL2: 1800 mV
[    0.427368] VMMC1: 1850 <--> 3150 mV at 3000 mV
[    0.429534] twl4030_gpio gpio.30: gpio (irq 320) chaining IRQs 336..=
353
[    0.445495] omap_i2c i2c.15: bus -1 rev1.4.0 at 400 kHz
[    0.449188] omap_i2c i2c.16: bus -1 rev1.4.0 at 100 kHz
[    0.458312] Switching to clocksource 32k_counter
[    0.592712] NET: Registered protocol family 2
[    0.594848] TCP established hash table entries: 16384 (order: 5,
131072 bytes)
[    0.595550] TCP bind hash table entries: 16384 (order: 7, 589824 byt=
es)
[    0.605010] TCP: Hash tables configured (established 16384 bind 1638=
4)
[    0.605224] TCP: reno registered
[    0.605255] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.605590] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.606567] NET: Registered protocol family 1
[    0.608093] RPC: Registered named UNIX socket transport module.
[    0.608123] RPC: Registered udp transport module.
[    0.608123] RPC: Registered tcp transport module.
[    0.608154] RPC: Registered tcp NFSv4.1 backchannel transport module=
=2E
[    0.609191] NetWinder Floating Point Emulator V0.97 (double precisio=
n)
[    0.785827] VFS: Disk quotas dquot_6.5.2
[    0.786163] Dquot-cache hash table entries: 1024 (order 0, 4096 byte=
s)
[    0.789398] NFS: Registering the id_resolver key type
[    0.789916] Key type id_resolver registered
[    0.789947] Key type id_legacy registered
[    0.790100] jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 R=
ed Hat, Inc.
[    0.790679] msgmni has been set to 987
[    0.794189] io scheduler noop registered
[    0.794219] io scheduler deadline registered
[    0.794311] io scheduler cfq registered (default)
[    0.797149] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.804382] serial.10: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is a OM=
AP UART0
[    0.806304] serial.11: ttyO1 at MMIO 0x4806c000 (irq =3D 73) is a OM=
AP UART1
[    0.807800] serial.12: ttyO2 at MMIO 0x49020000 (irq =3D 74) is a OM=
AP UART2
[    1.446411] console [ttyO2] enabled
[    1.452087] serial.13: ttyO3 at MMIO 0x49042000 (irq =3D 80) is a OM=
AP UART3
[    1.494506] brd: module loaded
[    1.518707] loop: module loaded
[    1.528167] mtdoops: mtd device (mtddev=3Dname/number) must be suppl=
ied
[    1.536315] OneNAND driver initializing
[    1.554779] usbcore: registered new interface driver asix
[    1.561431] usbcore: registered new interface driver cdc_ether
[    1.568359] usbcore: registered new interface driver smsc95xx
[    1.574920] usbcore: registered new interface driver net1080
[    1.581604] usbcore: registered new interface driver cdc_subset
[    1.588470] usbcore: registered new interface driver zaurus
[    1.595031] usbcore: registered new interface driver cdc_ncm
[    1.603332] usbcore: registered new interface driver cdc_wdm
[    1.609466] Initializing USB Mass Storage driver...
[    1.615386] usbcore: registered new interface driver usb-storage
[    1.621704] USB Mass Storage support registered.
[    1.627777] usbcore: registered new interface driver libusual
[    1.634582] usbcore: registered new interface driver usbtest
[    1.642303] mousedev: PS/2 mouse device common for all mice
[    1.653778] twl_rtc rtc.26: Enabling TWL-RTC
[    1.662689] twl_rtc rtc.26: rtc core: registered rtc.26 as rtc0
[    1.670806] i2c /dev entries driver
[    1.678436] Driver for 1-wire Dallas network protocol.
[    1.687377] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout =
60 sec
[    1.698944] omap_hsmmc mmc.21: Failed to get debounce clk
[    1.704925] omap-dma-engine omap-dma-engine: allocating channel for =
62
[    1.711944] omap-dma-engine omap-dma-engine: allocating channel for =
61
[    1.764221] omap_hsmmc mmc.22: Failed to get debounce clk
[    1.769958] omap-dma-engine omap-dma-engine: allocating channel for =
48
[    1.776947] omap-dma-engine omap-dma-engine: allocating channel for =
47
[    1.834381] omap_hsmmc mmc.23: Failed to get debounce clk
[    1.840118] omap-dma-engine omap-dma-engine: allocating channel for =
78
[    1.847137] omap-dma-engine omap-dma-engine: allocating channel for =
77
[    1.865386] mmc0: host does not support reading read-only switch.
assuming write-enable.
[    1.876281] mmc0: new high speed SDHC card at address 84bb
[    1.884857] mmcblk0: mmc0:84bb SU04G 3.69 GiB
[    1.895904]  mmcblk0: p1 p2 p3
[    1.908355] usbcore: registered new interface driver usbhid
[    1.914428] usbhid: USB HID core driver
[    1.918457] oprofile: hardware counters not available
[    1.923828] oprofile: using timer interrupt.
[    1.929168] TCP: cubic registered
[    1.932678] Initializing XFRM netlink socket
[    1.937408] NET: Registered protocol family 17
[    1.942199] NET: Registered protocol family 15
[    1.947357] Key type dns_resolver registered
[    1.951995] VFP support v0.3: implementor 41 architecture 3 part 30
variant c rev 3
[    1.960235] ThumbEE CPU extension supported.
[    1.997375] clock: disabling unused clocks to save power
[    2.012481] VPLL2: disabling
[    2.016296] VDAC: disabling
[    2.022857] input: gpio-keys.25 as /devices/gpio-keys.25/input/input=
0
[    2.038879] twl_rtc rtc.26: setting system clock to 2000-01-01
00:00:41 UTC (946684841)
[    2.058502] EXT3-fs (mmcblk0p2): recovery required on readonly files=
ystem
[    2.065826] EXT3-fs (mmcblk0p2): write access will be enabled during=
 recovery
[    2.384826] kjournald starting.  Commit interval 5 seconds
[    2.407135] EXT3-fs (mmcblk0p2): recovery complete
[    2.412292] EXT3-fs (mmcblk0p2): mounted filesystem with ordered dat=
a mode
[    2.420013] VFS: Mounted root (ext3 filesystem) readonly on device 1=
79:2.
[    2.427886] Freeing init memory: 316K
[    2.601013] EXT3-fs (mmcblk0p2): warning: maximal mount count
reached, running e2fsck is recommended
[    2.621948] EXT3-fs (mmcblk0p2): using internal journal
Starting logging :OK
Initializing random number generator... done.
Starting network...
can't open /dev/ttyO2: No such file or directory
can't open /dev/ttyO2: No such file or directory
can't open /dev/ttyO2: No such file or directory
can't open /dev/ttyO2: No such file or directory
can't open /dev/ttyO2: No such file or directory
can't open /dev/ttyO2: No such file or directory
can't open /dev/ttyO2: No such file or directory

I was trying latest Linus tree but sadly kernel doesn't start at all
(EARLY_PRINTK + CONFIG_LL report nothing)

Thanks,

marek
--=20
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
=46reelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
