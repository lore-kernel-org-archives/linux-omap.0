From: Paul Walmsley <paul@pwsan.com>
Subject: RE: Current state of AM33xx patches
Date: Wed, 27 Jun 2012 15:44:48 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206271537480.27496@utopia.booyaka.com>
References: <4FD5BA4C.9070706@gmail.com> <4FD5FD9E.5040203@ti.com> <CADjby3UTVBKWRZUBRNTX9Bh4TqQJsoWQrrBxW6HuqSNZCUcvCw@mail.gmail.com> <79CD15C6BA57404B839C016229A409A83EA5B7DE@DBDE01.ent.ti.com> <alpine.DEB.2.00.1206271218540.27496@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EA5C1AB@DBDE01.ent.ti.com> <alpine.DEB.2.00.1206271306170.27496@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EA5C1F7@DBDE01.ent.ti.com> <alpine.DEB.2.00.1206271400100.27496@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EA5C2F4@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1103542235-1340833201=:27496"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41825 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756852Ab2F0Vot (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 17:44:49 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA5C2F4@DBDE01.ent.ti.com>
Content-ID: <alpine.DEB.2.00.1206271540320.27496@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Domenico Andreoli <cavokz@gmail.com>, Daniel Mack <zonque@gmail.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1103542235-1340833201=:27496
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1206271540321.27496@utopia.booyaka.com>


Good news; am able to get it booting with the images you sent and by=20
following the U-boot commands line by line from your earlier post. If I=20
use the uEnv.txt to set the optargs and uenvcmd to the same values, it=20
hangs as before.  So looks like I need to do a little further debugging=20
there to see why that's not working.

Thanks for your help.


- Paul

U-Boot 2011.09-00009-gcf6e04d (Mar 08 2012 - 17:15:43)

I2C:   ready
DRAM:  256 MiB
WARNING: Caches not enabled
No daughter card present
NAND:  HW ECC Hamming Code selected
nand_get_flash_type: second ID read did not match 10,10 against 00,10
No NAND device found!!!
0 MiB
MMC:   OMAP SD/MMC: 0
*** Warning - readenv() failed, using default environment

Net:   cpsw
Hit any key to stop autoboot:  0=20
U-Boot#=20
U-Boot# setenv bootargs console=3DttyO0,115200n8 mem=3D128M root=3D/dev/ram=
 rw=20
initrd=3D0x82000000,16MB ramdisk_size=3D65536 earlyprintk=3Dseril
U-Boot# mmc rescan 0
U-Boot# fatload mmc 0 81000000 uImage-dtb.am335x-evm
reading uImage-dtb.am335x-evm

** Unable to read "uImage-dtb.am335x-evm" from mmc 0:1 **
U-Boot# fatload mmc 0 81000000 uImage
reading uImage

3539030 bytes read
U-Boot# fatload mmc 0 82000000 ramdisk-pm.gz
reading ramdisk-pm.gz

2022580 bytes read
U-Boot# bootm 81000000
## Booting kernel from Legacy Image at 81000000 ...
   Image Name:   Linux-3.5.0-rc1-11827-g67e68668
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3538966 Bytes =3D 3.4 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.5.0-rc1-11827-g67e68668 (a0393758@psplinux06=
4) (gcc version 4.5.3 20110311 (prerelease) (GCC) ) #2 SMP Thu Jun 28 00:20=
:09 IST 2012
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=3D10c=
53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instr=
uction cache
[    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: TI A=
M335x EVM
[    0.000000] cma: CMA: reserved 16 MiB at 86800000
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] AM335X ES1.0 (neon )
[    0.000000] PERCPU: Embedded 8 pages/cpu @c0d74000 s11520 r8192 d13056 u=
32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 32256
[    0.000000] Kernel command line: console=3DttyO0,115200n8 mem=3D128M roo=
t=3D/dev/ram rw initrd=3D0x82000000,16MB ramdisk_size=3D65536 earlyprintk=
=3Dserial
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 byte=
s)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 127MB =3D 127MB total
[    0.000000] Memory: 83336k/83336k available, 47736k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0626de4   (6268 kB)
[    0.000000]       .init : 0xc0627000 - 0xc0675d00   ( 316 kB)
[    0.000000]       .data : 0xc0676000 - 0xc0713570   ( 630 kB)
[    0.000000]        .bss : 0xc0713594 - 0xc0c6be08   (5475 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:474
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 5.0) with 128 int=
errupts
[    0.000000] Total of 128 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 24000000 Hz
[    0.000000] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every =
178956ms
[    0.000000] OMAP clocksource: GPTIMER2 at 24000000 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.084512] Calibrating delay loop... 497.82 BogoMIPS (lpj=3D1941504)
[    0.084575] pid_max: default: 32768 minimum: 301
[    0.085427] Security Framework initialized
[    0.085746] Mount-cache hash table entries: 512
[    0.095474] CPU: Testing write buffer coherency: ok
[    0.096368] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.096455] Setting up static identity map for 0x80462f40 - 0x80462fb0
[    0.098510] Brought up 1 CPUs
[    0.098538] SMP: Total of 1 processors activated (497.82 BogoMIPS).
[    0.117359] initlevel:0=3Dearly, 4 registered initcalls
[    0.117688] initlevel:1=3Dcore, 24 registered initcalls
[    0.130732] dummy:=20
[    0.135033] NET: Registered protocol family 16
[    0.135342] initlevel:2=3Dpostcore, 19 registered initcalls
[    0.142542] DMA: preallocated 256 KiB pool for atomic coherent allocatio=
ns
[    0.142697] GPMC revision 6.0
[    0.143031] gpmc: irq-20 could not claim: err -22
[    0.153324] initlevel:3=3Darch, 16 registered initcalls
[    0.172994] OMAP GPIO hardware version 0.1
[    0.195325] No ATAGs?
[    0.195327] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.205396] initlevel:4=3Dsubsys, 43 registered initcalls
[    0.288151] bio: create slab <bio-0> at 0
[    0.301232] SCSI subsystem initialized
[    0.304817] usbcore: registered new interface driver usbfs
[    0.305531] usbcore: registered new interface driver hub
[    0.306545] usbcore: registered new device driver usb
[    0.319884] omap_i2c i2c.13: bus -1 rev2.4.0 at 100 kHz
[    0.334856] omap_i2c i2c.14: bus -1 rev2.4.0 at 100 kHz
[    0.350437] omap_i2c i2c.15: bus -1 rev2.4.0 at 100 kHz
[    0.360796] initlevel:5=3Dfs, 20 registered initcalls
[    0.361110] Switching to clocksource gp_timer
[    0.504856] NET: Registered protocol family 2
[    0.505958] IP route cache hash table entries: 1024 (order: 0, 4096 byte=
s)
[    0.508505] TCP established hash table entries: 4096 (order: 3, 32768 by=
tes)
[    0.508889] TCP bind hash table entries: 4096 (order: 5, 147456 bytes)
[    0.512097] TCP: Hash tables configured (established 4096 bind 4096)
[    0.512236] TCP: reno registered
[    0.512278] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.512654] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.513831] NET: Registered protocol family 1
[    0.515748] RPC: Registered named UNIX socket transport module.
[    0.515776] RPC: Registered udp transport module.
[    0.515792] RPC: Registered tcp transport module.
[    0.515807] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.516947] Trying to unpack rootfs image as initramfs...
[    0.519935] rootfs image is not initramfs (no cpio magic); looks like an=
 initrd
[    0.662490] Freeing initrd memory: 16384K
[    0.662531] initlevel:6=3Ddevice, 185 registered initcalls
[    0.662721] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.871566] VFS: Disk quotas dquot_6.5.2
[    0.871964] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.874030] NFS: Registering the id_resolver key type
[    0.874693] Key type id_resolver registered
[    0.876405] jffs2: version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red Hat,=
 Inc.
[    0.878207] msgmni has been set to 226
[    0.882644] io scheduler noop registered
[    0.882671] io scheduler deadline registered
[    0.882977] io scheduler cfq registered (default)
[    0.886331] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.895435] serial.7: ttyO0 at MMIO 0x44e09000 (irq =3D 72) is a OMAP UA=
RT0
[    1.505306] console [ttyO0] enabled
[    1.511548] serial.8: ttyO1 at MMIO 0x48022000 (irq =3D 73) is a OMAP UA=
RT1
[    1.521021] serial.9: ttyO2 at MMIO 0x48024000 (irq =3D 74) is a OMAP UA=
RT2
[    1.530178] serial.10: ttyO3 at MMIO 0x481a6000 (irq =3D 44) is a OMAP U=
ART3
[    1.539399] omap_uart serial.11: [UART-1]: failure [serial_omap_probe]: =
-22
[    1.546983] omap_uart: probe of serial.11 failed with error -22
[    1.553752] omap_uart serial.12: [UART-1]: failure [serial_omap_probe]: =
-22
[    1.561280] omap_uart: probe of serial.12 failed with error -22
[    1.608812] brd: module loaded
[    1.637737] loop: module loaded
[    1.648775] mtdoops: mtd device (mtddev=3Dname/number) must be supplied
[    1.656905] OneNAND driver initializing
[    1.674797] usbcore: registered new interface driver asix
[    1.681200] usbcore: registered new interface driver cdc_ether
[    1.688454] usbcore: registered new interface driver smsc95xx
[    1.695334] usbcore: registered new interface driver net1080
[    1.702097] usbcore: registered new interface driver cdc_subset
[    1.709078] usbcore: registered new interface driver zaurus
[    1.715775] usbcore: registered new interface driver cdc_ncm
[    1.723841] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.732439] usbcore: registered new interface driver cdc_wdm
[    1.738595] Initializing USB Mass Storage driver...
[    1.744634] usbcore: registered new interface driver usb-storage
[    1.750971] USB Mass Storage support registered.
[    1.757383] usbcore: registered new interface driver libusual
[    1.764317] usbcore: registered new interface driver usbtest
[    1.772412] mousedev: PS/2 mouse device common for all mice
[    1.784078] i2c /dev entries driver
[    1.792814] Driver for 1-wire Dallas network protocol.
[    1.802435] omap_wdt: OMAP Watchdog Timer Rev 0x01: initial timeout 60 s=
ec
[    1.814452] omap_hsmmc mmc.18: Failed to get debounce clk
[    1.862238] omap_hsmmc mmc.19: Failed to get debounce clk
[    1.876561] mmc0: host doesn't support card's voltages
[    1.882111] mmc0: error -22 whilst initialising SD card
[    1.917023] omap_hsmmc mmc.20: Failed to get debounce clk
[    1.977620] usbcore: registered new interface driver usbhid
[    1.983656] usbhid: USB HID core driver
[    1.988273] oprofile: hardware counters not available
[    1.993605] oprofile: using timer interrupt.
[    1.999234] TCP: cubic registered
[    2.003055] Initializing XFRM netlink socket
[    2.007730] NET: Registered protocol family 17
[    2.012848] NET: Registered protocol family 15
[    2.018313] Key type dns_resolver registered
[    2.022832] initlevel:7=3Dlate, 26 registered initcalls
[    2.028421] VFP support v0.3: implementor 41 architecture 3 part 30 vari=
ant c rev 3
[    2.036674] ThumbEE CPU extension supported.
[    2.054739] clock: disabling unused clocks to save power
[    2.068694] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    2.079880] RAMDISK: gzip image found at block 0
[    2.599184] VFS: Mounted root (ext2 filesystem) on device 1:0.
[    2.606361] Freeing init memory: 312K
mount: mounting none on /var/shm failed: No such file or directory
  ::
  :: Enabling hot-plug  : [SUCCESS]
  ::
  ::
   : Populating /dev    : [SUCCESS]
[SUCCESS]
  ::
  ::
  :: Setting PATH
  ::
   : syslogd            : [SUCCESS]
   : telnetd            : [SUCCESS]

Please press Enter to activate this console.=20
--155748971-1103542235-1340833201=:27496--
