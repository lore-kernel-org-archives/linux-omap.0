From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP baseline test results for v3.7-rc3
Date: Tue, 6 Nov 2012 10:24:09 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EB63E9C@DBDE01.ent.ti.com>
References: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com>
 <508F59FB.7080400@ti.com>
 <alpine.DEB.2.00.1211050239530.23228@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42956 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755Ab2KFKYV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 05:24:21 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Nov 06, 2012 at 11:39:18, Hiremath, Vaibhav wrote:
> On Mon, Nov 05, 2012 at 08:11:24, Paul Walmsley wrote:
> > Hi
> > 
> > On Tue, 30 Oct 2012, Vaibhav Hiremath wrote:
> > 
> > > This is surprising, I have tested v3.7-rc3 branch on AM335xBone platform
> > > and its booting up for me without any issues.
> > > Jon had submitted another patch which fixes boot issue on Bone.
> > > 
> > > https://patchwork.kernel.org/patch/1606471/
> > 
> > v3.7-rc4 failed for me with a detached .dtb in a quick test.  Probably it 
> > is due to the original u-boot that was shipped with the MMC card:
> > 
> 
> Pulling the tree, let me try now and update you shortly...
> 

Just tried -rc4, and it boots up fine for me. I tested it with Mainline u-
boot and mainline Kernel, I have pasted log below for reference -


> > U-Boot 2011.09-00009-gcf6e04d (Mar 08 2012 - 17:15:43)
> > arm-arago-linux-gnueabi-gcc (GCC) 4.5.3 20110311 (prerelease)
> > 

I do not suspect anything here, but still think we should use mainline 
u-boot version. Can you share the images with me, so that I can try them?


====================Log=======================


U-Boot SPL 2013.01-rc1-00071-g1cc619b (Nov 06 2012 - 15:33:43)
OMAP SD/MMC: 0
reading u-boot.img
reading u-boot.img


U-Boot 2013.01-rc1-00071-g1cc619b (Nov 06 2012 - 15:33:43)

I2C:   ready
DRAM:  256 MiB
WARNING: Caches not enabled
MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
Using default environment

Net:   cpsw
Hit any key to stop autoboot:  0
U-Boot#
U-Boot#
U-Boot# mmc rescan 0
U-Boot# fatload mmc 0 80000000 am335x-bone.dtb
reading am335x-bone.dtb
4391 bytes read
U-Boot# fatload mmc 0 81000000 uImage
reading uImage
3842256 bytes read
U-Boot# fatload mmc 0 82000000 ramdisk-pm.gz
reading ramdisk-pm.gz
2022580 bytes read
U-Boot# setenv bootargs console=ttyO0,115200n8 mem=256M root=/dev/ram rw initrd=0x82000000,16MB ramdisk_size=65536 earlyprintk=serial
U-Boot# bootm 81000000 - 80000000
## Booting kernel from Legacy Image at 81000000 ...
   Image Name:   Linux-3.7.0-rc4
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3842192 Bytes = 3.7 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 80000000
   Booting using the fdt blob at 0x80000000
   Loading Kernel Image ... OK
OK
   Loading Device Tree to 8fe65000, end 8fe69126 ... OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.7.0-rc4 (a0393758@psplinux064) (gcc version 4.5.3 20110311 (prerelease) (GCC) ) #1 SMP Tue Nov 6 15:28:21 IST 2012
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: TI AM335x BeagleBone
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] AM335X ES1.0 (neon )
[    0.000000] PERCPU: Embedded 9 pages/cpu @c0f03000 s12928 r8192 d15744 u36864
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64768
[    0.000000] Kernel command line: console=ttyO0,115200n8 mem=256M root=/dev/ram rw initrd=0x82000000,16MB ramdisk_size=65536 earlyprintk=serial
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 255MB = 255MB total
[    0.000000] Memory: 229112k/229112k available, 33032k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc06c4b94   (6899 kB)
[    0.000000]       .init : 0xc06c5000 - 0xc0715280   ( 321 kB)
[    0.000000]       .data : 0xc0716000 - 0xc07a13a0   ( 557 kB)
[    0.000000]        .bss : 0xc07a13c4 - 0xc0cfbd6c   (5483 kB)
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
[    0.001135] Calibrating delay loop... 364.48 BogoMIPS (lpj=1425408)
[    0.107571] pid_max: default: 32768 minimum: 301
[    0.108255] Security Framework initialized
[    0.108464] Mount-cache hash table entries: 512
[    0.118582] CPU: Testing write buffer coherency: ok
[    0.119703] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.119790] Setting up static identity map for 0x804d61e0 - 0x804d6250
[    0.122980] Brought up 1 CPUs
[    0.123012] SMP: Total of 1 processors activated (364.48 BogoMIPS).
[    0.147821] pinctrl core: initialized pinctrl subsystem
[    0.156108] regulator-dummy: no parameters
[    0.158717] NET: Registered protocol family 16
[    0.159696] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.161182] omap-gpmc omap-gpmc: GPMC revision 6.0
[    0.161403] omap-gpmc omap-gpmc: failed to reserve memory
[    0.161501] omap-gpmc: probe of omap-gpmc failed with error -16
[    0.190475] OMAP GPIO hardware version 0.1
[    0.206060] No ATAGs?
[    0.206089] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.293133] bio: create slab <bio-0> at 0
[    0.400112] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    0.407996] SCSI subsystem initialized
[    0.410955] usbcore: registered new interface driver usbfs
[    0.411594] usbcore: registered new interface driver hub
[    0.413229] usbcore: registered new device driver usb
[    0.418391] omap_i2c 44e0b000.i2c: bus 0 rev2.4.0 at 400 kHz
[    0.430593] Switching to clocksource gp_timer
[    0.586714] NET: Registered protocol family 2
[    0.589620] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
[    0.590148] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    0.595587] TCP: Hash tables configured (established 8192 bind 8192)
[    0.595897] TCP: reno registered
[    0.595941] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.596311] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.597375] NET: Registered protocol family 1
[    0.599070] RPC: Registered named UNIX socket transport module.
[    0.599101] RPC: Registered udp transport module.
[    0.599117] RPC: Registered tcp transport module.
[    0.599133] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.600475] Trying to unpack rootfs image as initramfs...
[    0.603605] rootfs image is not initramfs (no cpio magic); looks like an initrd
[    0.746420] Freeing initrd memory: 16384K
[    0.746624] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.747263] CPU PMU: probing PMU on CPU 0
[    0.747496] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver, 5 counters available
[    0.953802] VFS: Disk quotas dquot_6.5.2
[    0.954099] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.957740] NFS: Registering the id_resolver key type
[    0.958396] Key type id_resolver registered
[    0.958425] Key type id_legacy registered
[    0.958612] jffs2: version 2.2. (NAND) (SUMMARY)  (c) 2001-2006 Red Hat, Inc.
[    0.959333] msgmni has been set to 479
[    0.964156] io scheduler noop registered
[    0.964191] io scheduler deadline registered
[    0.964331] io scheduler cfq registered (default)
[    0.967982] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.975911] omap_uart 44e09000.serial: did not get pins for uart0 error: -19
[    0.976583] 44e09000.serial: ttyO0 at MMIO 0x44e09000 (irq = 88) is a OMAP UART0
[    1.579209] console [ttyO0] enabled
[    1.622741] brd: module loaded
[    1.651866] loop: module loaded
[    1.661935] mtdoops: mtd device (mtddev=name/number) must be supplied
[    1.670613] OneNAND driver initializing
[    1.682234] usbcore: registered new interface driver asix
[    1.688544] usbcore: registered new interface driver cdc_ether
[    1.695670] usbcore: registered new interface driver smsc95xx
[    1.702759] usbcore: registered new interface driver net1080
[    1.709533] usbcore: registered new interface driver cdc_subset
[    1.716526] usbcore: registered new interface driver zaurus
[    1.723296] usbcore: registered new interface driver cdc_ncm
[    1.732034] usbcore: registered new interface driver cdc_wdm
[    1.738182] Initializing USB Mass Storage driver...
[    1.744230] usbcore: registered new interface driver usb-storage
[    1.750559] USB Mass Storage support registered.
[    1.756198] usbcore: registered new interface driver usbtest
[    1.764520] mousedev: PS/2 mouse device common for all mice
[    1.775792] i2c /dev entries driver
[    1.782078] Driver for 1-wire Dallas network protocol.
[    1.792090] omap_wdt: OMAP Watchdog Timer Rev 0x01: initial timeout 60 sec
[    1.805350] usbcore: registered new interface driver usbhid
[    1.811484] usbhid: USB HID core driver
[    1.817257] oprofile: using arm/armv7
[    1.822333] TCP: cubic registered
[    1.825843] Initializing XFRM netlink socket
[    1.830589] NET: Registered protocol family 17
[    1.835398] NET: Registered protocol family 15
[    1.840638] Key type dns_resolver registered
[    1.845380] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
[    1.853623] ThumbEE CPU extension supported.
[    1.870806] clock: disabling unused clocks to save power
[    1.884043] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    1.895403] RAMDISK: gzip image found at block 0
[    2.375558] VFS: Mounted root (ext2 filesystem) on device 1:0.
[    2.382761] Freeing init memory: 320K
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

