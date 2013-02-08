From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP baseline test results for v3.8-rc6
Date: Fri, 8 Feb 2013 10:24:31 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC06CEA@DBDE01.ent.ti.com>
References: <alpine.DEB.2.00.1302062333270.12769@utopia.booyaka.com>
 <20130207083217.GA15462@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56143 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946187Ab3BHKYi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Feb 2013 05:24:38 -0500
In-Reply-To: <20130207083217.GA15462@arwen.pp.htv.fi>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Feb 07, 2013 at 14:02:17, Balbi, Felipe wrote:
> Hi,
> 
> On Wed, Feb 06, 2013 at 11:34:32PM +0000, Paul Walmsley wrote:
> > Boot tests:
> > 
> > * am335xbone: hangs after "Starting kernel"
> >   - Cause unknown
> >   - http://www.mail-archive.com/linux-omap@vger.kernel.org/msg82297.html
> >   - http://marc.info/?l=linux-omap&m=135903184512238&w=2
> >   - http://www.mail-archive.com/linux-omap@vger.kernel.org/msg83942.html
> 
> After testing quite a lot and having help from other folks, the problem
> (for me at least) was missing fdt_high in u-boot environment.
> 
> setenv fdt_high 0xffffffff
> 
> fixed everything.
> 

Sorry for not following up on this for long, I have tested v3.8-rc6 
(with latest u-boot)on both BeageBone platoforms and I have pasted the logs 
below as well for reference.


Paul,
I have used your MLO & u-boot.img images and tried at my end, and as 
expected it didn't boot for me. I debugged it further and found that your 
u-boot doesn't enable support for FDT and that's is the reason it fails to 
boot.



Below are my observations,

BeagleBone:
===========

U-Boot SPL 2013.01-00167-gd62ef56 (Feb 08 2013 - 12:41:55)
OMAP SD/MMC: 0
reading u-boot.img
reading u-boot.img


U-Boot 2013.01-00167-gd62ef56 (Feb 08 2013 - 12:41:55)

I2C:   ready
DRAM:  256 MiB
WARNING: Caches not enabled
NAND:  No NAND device found!!!
0 MiB
MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
*** Warning - readenv() failed, using default environment

musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
musb-hdrc: MHDRC RTL version 2.0
musb-hdrc: setup fifo_mode 4
musb-hdrc: 28/31 max ep, 16384/16384 memory
USB Peripheral mode controller at 47401000 using PIO, IRQ 0
musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
musb-hdrc: MHDRC RTL version 2.0
musb-hdrc: setup fifo_mode 4
musb-hdrc: 28/31 max ep, 16384/16384 memory
USB Host mode controller at 47401800 using PIO, IRQ 0
Net:   cpsw, usb_ether
Hit any key to stop autoboot:  0
U-Boot#
U-Boot#
U-Boot# mmc rescan 0
U-Boot# fatload mmc 0 80000000 am335x-bone.dtb
reading am335x-bone.dtb
7967 bytes read in 6 ms (1.3 MiB/s)
U-Boot# fatload mmc 0 81000000 uImage
reading uImage
3927712 bytes read in 455 ms (8.2 MiB/s)
U-Boot# fatload mmc 0 82000000 ramdisk-pm.gz
reading ramdisk-pm.gz
2022580 bytes read in 238 ms (8.1 MiB/s)
U-Boot# setenv bootargs console=ttyO0,115200n8 mem=256M root=/dev/ram rw initrd=0x82000000,32MB ramdisk_size=65536 earlyprintk=serial
U-Boot# bootm 81000000 - 80000000
## Booting kernel from Legacy Image at 81000000 ...
   Image Name:   Linux-3.8.0-rc6
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3927648 Bytes = 3.7 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 80000000
   Booting using the fdt blob at 0x80000000
   Loading Kernel Image ... OK
OK
   Loading Device Tree to 8fe3e000, end 8fe42f1e ... OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.8.0-rc6 (a0393758@psplinux064) (gcc version 4.5.3 20110311 (prerelease) (GCC) ) #1 SMP Fri Feb 8 12:47:14 IST 2013
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: TI AM335x BeagleBone
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] AM335X ES1.0 (neon )
[    0.000000] PERCPU: Embedded 9 pages/cpu @c0f3a000 s12992 r8192 d15680 u36864
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64768
[    0.000000] Kernel command line: console=ttyO0,115200n8 mem=256M root=/dev/ram rw initrd=0x82000000,32MB ramdisk_size=65536 earlyprintk=serial
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] Memory: 255MB = 255MB total
[    0.000000] Memory: 212500k/212500k available, 49644k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc06f0600   (7074 kB)
[    0.000000]       .init : 0xc06f1000 - 0xc07422c0   ( 325 kB)
[    0.000000]       .data : 0xc0744000 - 0xc07d59b8   ( 583 kB)
[    0.000000]        .bss : 0xc07d59b8 - 0xc0d306b0   (5484 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=2 to nr_cpu_ids=1.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 5.0) with 128 interrupts
[    0.000000] Total of 128 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 24000000 Hz
[    0.000000] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
[    0.000000] OMAP clocksource: GPTIMER2 at 24000000 Hz
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
[    0.001165] Calibrating delay loop... 364.48 BogoMIPS (lpj=1425408)
[    0.109064] pid_max: default: 32768 minimum: 301
[    0.109704] Security Framework initialized
[    0.109916] Mount-cache hash table entries: 512
[    0.122564] CPU: Testing write buffer coherency: ok
[    0.124461] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.124555] Setting up static identity map for 0x804ee8e0 - 0x804ee950
[    0.127896] Brought up 1 CPUs
[    0.127925] SMP: Total of 1 processors activated (364.48 BogoMIPS).
[    0.131934] devtmpfs: initialized
[    0.210430] pinctrl core: initialized pinctrl subsystem
[    0.218538] regulator-dummy: no parameters
[    0.221241] NET: Registered protocol family 16
[    0.222190] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.223796] omap-gpmc omap-gpmc: GPMC revision 6.0
[    0.254534] OMAP GPIO hardware version 0.1
[    0.280095] No ATAGs?
[    0.280126] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.361898] bio: create slab <bio-0> at 0
[    0.468320] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    0.478996] SCSI subsystem initialized
[    0.481933] usbcore: registered new interface driver usbfs
[    0.482570] usbcore: registered new interface driver hub
[    0.483569] usbcore: registered new device driver usb
[    0.487020] omap_i2c 44e0b000.i2c: did not get pins for i2c error: -19
[    0.489555] omap_i2c 44e0b000.i2c: bus 0 rev0.11 at 400 kHz
[    0.497420] DCDC1: at 1800 mV
[    0.500881] vdd_mpu: 925 <--> 1325 mV at 1100 mV
[    0.503626] vdd_core: 925 <--> 1150 mV at 1100 mV
[    0.506243] LDO1: at 1800 mV
[    0.509244] LDO2: at 3300 mV
[    0.512059] LDO3: at 3250 mV
[    0.514585] LDO4: at 3300 mV
[    0.517248] tps65217 0-0024: TPS65217 ID 0x7 version 1.0
[    0.527350] Switching to clocksource gp_timer
[    0.700240] NET: Registered protocol family 2
[    0.702832] TCP established hash table entries: 2048 (order: 2, 16384 bytes)
[    0.703113] TCP bind hash table entries: 2048 (order: 4, 73728 bytes)
[    0.704364] TCP: Hash tables configured (established 2048 bind 2048)
[    0.704651] TCP: reno registered
[    0.704693] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.705042] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.706128] NET: Registered protocol family 1
[    0.708356] RPC: Registered named UNIX socket transport module.
[    0.708390] RPC: Registered udp transport module.
[    0.708406] RPC: Registered tcp transport module.
[    0.708423] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.709651] Trying to unpack rootfs image as initramfs...
[    0.712288] rootfs image is not initramfs (no cpio magic); looks like an initrd
[    0.986566] Freeing initrd memory: 32768K
[    0.986772] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.987674] CPU PMU: probing PMU on CPU 0
[    0.987722] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver, 5 counters available
[    1.203370] VFS: Disk quotas dquot_6.5.2
[    1.203672] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.207268] NFS: Registering the id_resolver key type
[    1.208084] Key type id_resolver registered
[    1.208116] Key type id_legacy registered
[    1.208315] jffs2: version 2.2. (NAND) (SUMMARY)  (c) 2001-2006 Red Hat, Inc.
[    1.209103] msgmni has been set to 479
[    1.213684] io scheduler noop registered
[    1.213719] io scheduler deadline registered
[    1.213846] io scheduler cfq registered (default)
[    1.215746] pinctrl-single 44e10800.pinmux: 142 pins at pa f9e10800 size 568
[    1.220860] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.230360] omap_uart 44e09000.serial: did not get pins for uart0 error: -19
[    1.231161] 44e09000.serial: ttyO0 at MMIO 0x44e09000 (irq = 88) is a OMAP UART0
[    1.876322] console [ttyO0] enabled
[    1.923926] brd: module loaded
[    1.955161] loop: module loaded
[    1.965841] mtdoops: mtd device (mtddev=name/number) must be supplied
[    1.973722] OneNAND driver initializing
[    1.986311] usbcore: registered new interface driver asix
[    1.993080] usbcore: registered new interface driver cdc_ether
[    2.000214] usbcore: registered new interface driver smsc95xx
[    2.008513] usbcore: registered new interface driver net1080
[    2.015426] usbcore: registered new interface driver cdc_subset
[    2.022474] usbcore: registered new interface driver zaurus
[    2.029217] usbcore: registered new interface driver cdc_ncm
[    2.038245] usbcore: registered new interface driver cdc_wdm
[    2.044383] Initializing USB Mass Storage driver...
[    2.050291] usbcore: registered new interface driver usb-storage
[    2.056762] USB Mass Storage support registered.
[    2.062390] usbcore: registered new interface driver usbtest
[    2.071698] mousedev: PS/2 mouse device common for all mice
[    2.083653] i2c /dev entries driver
[    2.090664] Driver for 1-wire Dallas network protocol.
[    2.102492] omap_wdt: OMAP Watchdog Timer Rev 0x01: initial timeout 60 sec
[    2.116487] usbcore: registered new interface driver usbhid
[    2.122564] usbhid: USB HID core driver
[    2.128283] oprofile: using arm/armv7
[    2.133402] TCP: cubic registered
[    2.136911] Initializing XFRM netlink socket
[    2.141672] NET: Registered protocol family 17
[    2.146557] NET: Registered protocol family 15
[    2.151748] Key type dns_resolver registered
[    2.156486] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
[    2.164736] ThumbEE CPU extension supported.
[    2.238943] davinci_mdio 4a101000.mdio: davinci mdio revision 1.6
[    2.245392] davinci_mdio 4a101000.mdio: detected phy mask fffffffe
[    2.255782] libphy: 4a101000.mdio: probed
[    2.260041] davinci_mdio 4a101000.mdio: phy[0]: device 4a101000.mdio:00, driver SMSC LAN8710/LAN8720
[    2.270327] Random MACID = 82:b3:08:b9:1d:3d
[    2.281116] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    2.292887] RAMDISK: gzip image found at block 0
[    2.788982] VFS: Mounted root (ext2 filesystem) on device 1:0.
[    2.796713] devtmpfs: mounted
[    2.800690] Freeing init memory: 324K
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

Please press Enter to activate this console.   ::
  :: Setting shell environment ...
  ::
   : Path
   : Aliases
   : Touch Screen
  ::
  :: Done
  ::
[root@arago /]#
[root@arago /]#
[root@arago /]#
[root@arago /]#
[root@arago /]#
[root@arago /]# cat /proc/version
Linux version 3.8.0-rc6 (a0393758@psplinux064) (gcc version 4.5.3 20110311 (prerelease) (GCC) ) #1 SMP Fri Feb 8 12:47:14 IST 2013
[root@arago /]#





BeagleBone-Black:
===================

> -- 
> balbi
> 

