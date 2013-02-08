From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP baseline test results for v3.8-rc6
Date: Fri, 8 Feb 2013 15:10:22 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC06F9A@DBDE01.ent.ti.com>
References: <alpine.DEB.2.00.1302062333270.12769@utopia.booyaka.com>
 <20130207083217.GA15462@arwen.pp.htv.fi>
 <79CD15C6BA57404B839C016229A409A83EC06CEA@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1302081306230.11464@utopia.booyaka.com>
 <alpine.DEB.2.00.1302081332200.11464@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48345 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946062Ab3BHPKa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Feb 2013 10:10:30 -0500
In-Reply-To: <alpine.DEB.2.00.1302081332200.11464@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Feb 08, 2013 at 19:04:04, Paul Walmsley wrote:
> On Fri, 8 Feb 2013, Paul Walmsley wrote:
> 
> > The point is to try to minimize bootloader dependencies.
> 
> Also if there are weird bootloader dependendencies that no one can track 
> down, we should document them somewhere, maybe underneath 
> Documentation/arm/OMAP.
> 


Paul,

Unfortunately I do not have same observations here at my end,
I just tried booting up appended dtb uImage with your shared u-boot and it 
is working got me. Below is the log -



U-Boot SPL 2011.09-00009-gcf6e04d (Mar 08 2012 - 17:15:43)
Texas Instruments Revision detection unimplemented
No AC power, disabling frequency switch
OMAP SD/MMC: 0
reading u-boot.img
reading u-boot.img


U-Boot 2011.09-00009-gcf6e04d (Mar 08 2012 - 17:15:43)

I2C:   ready
DRAM:  256 MiB
WARNING: Caches not enabled
No daughter card present
NAND:  HW ECC Hamming Code selected
nand_get_flash_type: unknown NAND device: Manufacturer ID: 0x10, Chip ID: 0x10
No NAND device found!!!
0 MiB
MMC:   OMAP SD/MMC: 0
*** Warning - readenv() failed, using default environment

Net:   cpsw
Hit any key to stop autoboot:  0
U-Boot#
U-Boot#
U-Boot#
U-Boot#
U-Boot#
U-Boot#
U-Boot# mmc rescan 0
U-Boot# fatload mmc 0 82000000 ramdisk-pm.gz
reading ramdisk-pm.gz

2022580 bytes read
U-Boot# fatload mmc 0 81000000 uImage-append
reading uImage-append

3943783 bytes read
U-Boot# setenv bootargs console=ttyO0,115200n8 mem=128M root=/dev/ram rw initrd=0x82000000,16MB ramdisk_size=65536 earlyprintk=serial
U-Boot# bootm 81000000
## Booting kernel from Legacy Image at 81000000 ...
   Image Name:   Linux
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3943719 Bytes = 3.8 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.8.0-rc6-dirty (a0393758@psplinux064) (gcc version 4.5.3 20110311 (prerelease) (GCC) ) #3 SMP Fri Feb 8 20:25:33 IST 2013
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: TI AM335x BeagleBone
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] AM335X ES1.0 (neon )
[    0.000000] PERCPU: Embedded 9 pages/cpu @c0e3c000 s12992 r8192 d15680 u36864
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32256
[    0.000000] Kernel command line: console=ttyO0,115200n8 mem=128M root=/dev/ram rw initrd=0x82000000,16MB ramdisk_size=65536 earlyprintk=serial
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] Memory: 127MB = 127MB total
[    0.000000] Memory: 98948k/98948k available, 32124k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
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
[    0.001262] Calibrating delay loop... 330.83 BogoMIPS (lpj=1290240)
[    0.108960] pid_max: default: 32768 minimum: 301
[    0.109689] Security Framework initialized
[    0.109917] Mount-cache hash table entries: 512
[    0.123799] CPU: Testing write buffer coherency: ok
[    0.125975] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.126076] Setting up static identity map for 0x804ee8e0 - 0x804ee950
[    0.129588] Brought up 1 CPUs
[    0.129622] SMP: Total of 1 processors activated (330.83 BogoMIPS).
[    0.134409] devtmpfs: initialized
[    0.215281] pinctrl core: initialized pinctrl subsystem
[    0.223989] regulator-dummy: no parameters
[    0.226903] NET: Registered protocol family 16
[    0.227923] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.229592] omap-gpmc omap-gpmc: GPMC revision 6.0
[    0.262353] OMAP GPIO hardware version 0.1
[    0.291767] No ATAGs?
[    0.291803] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.380278] bio: create slab <bio-0> at 0
[    0.497426] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    0.509170] SCSI subsystem initialized
[    0.512433] usbcore: registered new interface driver usbfs
[    0.513128] usbcore: registered new interface driver hub
[    0.514206] usbcore: registered new device driver usb
[    0.517970] omap_i2c 44e0b000.i2c: did not get pins for i2c error: -19
[    0.520719] omap_i2c 44e0b000.i2c: bus 0 rev0.11 at 400 kHz
[    0.529332] DCDC1: at 1800 mV
[    0.533027] vdd_mpu: 925 <--> 1325 mV at 1275 mV
[    0.535961] vdd_core: 925 <--> 1150 mV at 1100 mV
[    0.539360] LDO1: at 1800 mV
[    0.542376] LDO2: at 3300 mV
[    0.545217] LDO3: at 3300 mV
[    0.548214] LDO4: at 3300 mV
[    0.550702] tps65217 0-0024: TPS65217 ID 0x7 version 1.0
[    0.561587] Switching to clocksource gp_timer
[    0.753451] NET: Registered protocol family 2
[    0.756280] TCP established hash table entries: 1024 (order: 1, 8192 bytes)
[    0.756547] TCP bind hash table entries: 1024 (order: 3, 36864 bytes)
[    0.757245] TCP: Hash tables configured (established 1024 bind 1024)
[    0.758030] TCP: reno registered
[    0.758089] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.758472] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.759698] NET: Registered protocol family 1
[    0.761584] RPC: Registered named UNIX socket transport module.
[    0.761618] RPC: Registered udp transport module.
[    0.761637] RPC: Registered tcp transport module.
[    0.761656] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.762980] Trying to unpack rootfs image as initramfs...
[    0.766383] rootfs image is not initramfs (no cpio magic); looks like an initrd
[    0.914558] Freeing initrd memory: 16384K
[    0.914773] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.915707] CPU PMU: probing PMU on CPU 0
[    0.915758] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver, 5 counters available
[    1.152101] VFS: Disk quotas dquot_6.5.2
[    1.152431] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.156489] NFS: Registering the id_resolver key type
[    1.157216] Key type id_resolver registered
[    1.157248] Key type id_legacy registered
[    1.157458] jffs2: version 2.2. (NAND) (SUMMARY)  (c) 2001-2006 Red Hat, Inc.
[    1.158319] msgmni has been set to 225
[    1.163373] io scheduler noop registered
[    1.163409] io scheduler deadline registered
[    1.163552] io scheduler cfq registered (default)
[    1.165601] pinctrl-single 44e10800.pinmux: 142 pins at pa f9e10800 size 568
[    1.171111] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.181588] omap_uart 44e09000.serial: did not get pins for uart0 error: -19
[    1.182333] 44e09000.serial: ttyO0 at MMIO 0x44e09000 (irq = 88) is a OMAP UART0
[    1.825961] console [ttyO0] enabled
[    1.877684] brd: module loaded
[    1.908939] loop: module loaded
[    1.922268] mtdoops: mtd device (mtddev=name/number) must be supplied
[    1.930231] OneNAND driver initializing
[    1.943422] usbcore: registered new interface driver asix
[    1.950353] usbcore: registered new interface driver cdc_ether
[    1.957546] usbcore: registered new interface driver smsc95xx
[    1.964664] usbcore: registered new interface driver net1080
[    1.971452] usbcore: registered new interface driver cdc_subset
[    1.978495] usbcore: registered new interface driver zaurus
[    1.985251] usbcore: registered new interface driver cdc_ncm
[    1.994512] usbcore: registered new interface driver cdc_wdm
[    2.000648] Initializing USB Mass Storage driver...
[    2.006600] usbcore: registered new interface driver usb-storage
[    2.013649] USB Mass Storage support registered.
[    2.019467] usbcore: registered new interface driver usbtest
[    2.028987] mousedev: PS/2 mouse device common for all mice
[    2.040757] i2c /dev entries driver
[    2.048079] Driver for 1-wire Dallas network protocol.
[    2.060277] omap_wdt: OMAP Watchdog Timer Rev 0x01: initial timeout 60 sec
[    2.074797] usbcore: registered new interface driver usbhid
[    2.080927] usbhid: USB HID core driver
[    2.087089] oprofile: using arm/armv7
[    2.092002] TCP: cubic registered
[    2.095883] Initializing XFRM netlink socket
[    2.100572] NET: Registered protocol family 17
[    2.105455] NET: Registered protocol family 15
[    2.110742] Key type dns_resolver registered
[    2.115403] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
[    2.123659] ThumbEE CPU extension supported.
[    2.195138] davinci_mdio 4a101000.mdio: davinci mdio revision 1.6
[    2.201566] davinci_mdio 4a101000.mdio: detected phy mask fffffffe
[    2.212353] libphy: 4a101000.mdio: probed
[    2.216603] davinci_mdio 4a101000.mdio: phy[0]: device 4a101000.mdio:00, driver SMSC LAN8710/LAN8720
[    2.226837] Random MACID = e6:d7:d4:a0:c6:14
[    2.238078] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    2.250348] RAMDISK: gzip image found at block 0
[    2.753968] VFS: Mounted root (ext2 filesystem) on device 1:0.
[    2.761822] devtmpfs: mounted
[    2.765982] Freeing init memory: 324K
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

Please press Enter to activate this console.
  ::
  :: Setting shell environment ...
  ::
   : Path
   : Aliases
   : Touch Screen
  ::
  :: Done
  ::
[root@arago /]#
[root@arago /]# cat /proc/version
Linux version 3.8.0-rc6-dirty (a0393758@psplinux064) (gcc version 4.5.3 20110311 (prerelease) (GCC) ) #3 SMP Fri Feb 8 20:25:33 IST 2013
[root@arago /]#
