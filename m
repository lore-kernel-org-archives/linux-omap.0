From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Current state of AM33xx patches
Date: Wed, 27 Jun 2012 19:01:34 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA5C1AB@DBDE01.ent.ti.com>
References: <4FD5BA4C.9070706@gmail.com> <4FD5FD9E.5040203@ti.com>
 <CADjby3UTVBKWRZUBRNTX9Bh4TqQJsoWQrrBxW6HuqSNZCUcvCw@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA5B7DE@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1206271218540.27496@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36768 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab2F0TBr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 15:01:47 -0400
In-Reply-To: <alpine.DEB.2.00.1206271218540.27496@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Domenico Andreoli <cavokz@gmail.com>, Daniel Mack <zonque@gmail.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Jun 28, 2012 at 00:01:06, Paul Walmsley wrote:
> Hi Vaibhav
> 
> On Wed, 27 Jun 2012, Hiremath, Vaibhav wrote:
> 
> > Build Steps:
> > ============
> >  - make ARCH=arm CROSS_COMPILE=<toolchain> distclean
> >  - make ARCH=arm CROSS_COMPILE=<toolchain> omap2plus_defconfig
> >  - Enable option CONFIG_ARM_APPENDED_DTB and CONFIG_ARM_ATAG_DTB_COMPAT
> >  - make ARCH=arm CROSS_COMPILE=<toolchain> uImage-dtb.am335x-evm
> >    (Since I am not using DT aware u-boot)
> > 
> > Use the ramdisk image to boot kernel, since we do not have support for any 
> > storage devices in the mainline.
> > 
> > U-Boot commands to boot:
> > ========================
> > setenv bootcmd 'mmc rescan 0; fatload mmc 0 81000000 uImage; fatload mmc 0 82000000 ramdisk-pm.gz; bootm 81000000'
> > setenv bootargs 'console=ttyO0,115200n8 mem=128M root=/dev/ram rw initrd=0x82000000,16MB ramdisk_size=65536 earlyprintk=serial'
> > boot
> > 
> > 
> > Hope this will help you to boot the kernel on BeagleBone.
> 
> Was anyone else able to get this to work?
> 
> I tried these steps here but with one difference: I put the U-boot 
> commands into the uEnv.txt file:
> 
> optargs=mem=128M root=/dev/ram rw initrd=0x82000000,16MB ramdisk_size=65536 earlyprintk=serial ignore_loglevel debug
> uenvcmd=mmc rescan 0; fatload mmc 0 81000000 uImage; fatload mmc 0 82000000 ramdisk-pm.gz; bootm 81000000
> 
> Unfortunately the kernel did not boot.  The log is at the bottom of this 
> file.  I did verify in U-boot that the commands were being executed 
> correctly by walking through them by hand.
> 
> The branch used was your am335x-upstream-staging branch, plus a minor 
> patch to allow the kernel to build on an am335x-only config (although for 
> the purposes of this test, omap2plus_defconfig was used).
> 
> This is on a BeagleBone A3, using gcc version 4.5.1 (Sourcery G++ Lite 
> 2010.09-50).
> 
> Enabling CONFIG_EARLY_PRINTK doesn't make any difference, which isn't too 
> surprising since there's no output from the kernel at all.  
> Unfortunately, I don't have the time to do in-depth troubleshooting here 
> with JTAG.
> 
> Any thoughts? 
> 
> 
> - Paul
> 
> 
> No daughter card present
> NAND:  HW ECC Hamming Code selected
> nand_get_flash_type: second ID read did not match 10,10 against 00,00
> No NAND device found!!!
> 0 MiB
> MMC:   OMAP SD/MMC: 0
> *** Warning - readenv() failed, using default environment
> 
> Net:   cpsw
> Hit any key to stop autoboot:  0 
> SD/MMC found on device 0
> reading uEnv.txt
> 
> 224 bytes read
> Loaded environment from uEnv.txt
> Importing environment from mmc ...
> Running uenvcmd ...
> reading uImage
> 
> 3819902 bytes read
> reading ramdisk-pm.gz
> 
> 2013059 bytes read
> ## Booting kernel from Legacy Image at 81000000 ...
>    Image Name:   Linux-3.5.0-rc1-11828-ge2b3dd1

Something seems to be wrong here???
The HEAD is,

commit 67e686682dc286d90a0ed47b7dc68fb54944d3d9
Author: AnilKumar Ch <anilkumar@ti.com>
Date:   Thu Jun 21 12:33:58 2012 +0530

    arm/dts: Add support for AM335x BeagleBone





>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    3819838 Bytes = 3.6 MiB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK
> 
> Starting kernel ...
> 
> 

I just checked out  am335x-upstream-staging branch and tested it on my 
BeagleBone (A2: Available at my home :)) and below is exact log -



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
U-Boot# setenv bootargs console=ttyO0,115200n8 mem=128M root=/dev/ram rw initrd=0x82000000,16MB ramdisk_size=65536 earlyprintk=serial
U-Boot# mmc rescan 0
U-Boot# fatload mmc 0 81000000 uImage-dtb.am335x-evm
reading uImage-dtb.am335x-evm

3539030 bytes read
U-Boot# fatload mmc 0 82000000 ramdisk-pm.gz
reading ramdisk-pm.gz

2022580 bytes read
U-Boot# bootm 81000000
## Booting kernel from Legacy Image at 81000000 ...
   Image Name:   Linux-3.5.0-rc1-11827-g67e68668
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3538966 Bytes = 3.4 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.5.0-rc1-11827-g67e68668 (a0393758@psplinux064) (gcc version 4.5.3 20110311 (prerelease) (GCC) ) #2 SMP Thu Jun 28 00:20:09 IST 2012
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: TI AM335x EVM
[    0.000000] cma: CMA: reserved 16 MiB at 86800000
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] AM335X ES1.0 (neon )
[    0.000000] PERCPU: Embedded 8 pages/cpu @c0d74000 s11520 r8192 d13056 u32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32256
[    0.000000] Kernel command line: console=ttyO0,115200n8 mem=128M root=/dev/ram rw initrd=0x82000000,16MB ramdisk_size=65536 earlyprintk=serial
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 127MB = 127MB total
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
[    0.084516] Calibrating delay loop... 497.82 BogoMIPS (lpj=1941504)
[    0.084576] pid_max: default: 32768 minimum: 301
[    0.085432] Security Framework initialized
[    0.085748] Mount-cache hash table entries: 512
[    0.095464] CPU: Testing write buffer coherency: ok
[    0.096364] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.096449] Setting up static identity map for 0x80462f40 - 0x80462fb0
[    0.098490] Brought up 1 CPUs
[    0.098516] SMP: Total of 1 processors activated (497.82 BogoMIPS).
[    0.117332] initlevel:0=early, 4 registered initcalls
[    0.117665] initlevel:1=core, 24 registered initcalls
[    0.130683] dummy:
[    0.134998] NET: Registered protocol family 16
[    0.135304] initlevel:2=postcore, 19 registered initcalls
[    0.142535] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.142688] GPMC revision 6.0
[    0.143016] gpmc: irq-20 could not claim: err -22
[    0.153262] initlevel:3=arch, 16 registered initcalls
[    0.172916] OMAP GPIO hardware version 0.1
[    0.195147] No ATAGs?
[    0.195151] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.205297] initlevel:4=subsys, 43 registered initcalls
[    0.287496] bio: create slab <bio-0> at 0
[    0.300794] SCSI subsystem initialized
[    0.304330] usbcore: registered new interface driver usbfs
[    0.305038] usbcore: registered new interface driver hub
[    0.306050] usbcore: registered new device driver usb
[    0.319859] omap_i2c i2c.13: bus -1 rev2.4.0 at 100 kHz
[    0.334853] omap_i2c i2c.14: bus -1 rev2.4.0 at 100 kHz
[    0.350436] omap_i2c i2c.15: bus -1 rev2.4.0 at 100 kHz
[    0.360856] initlevel:5=fs, 20 registered initcalls
[    0.361166] Switching to clocksource gp_timer
[    0.504744] NET: Registered protocol family 2
[    0.505845] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.508384] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[    0.508770] TCP bind hash table entries: 4096 (order: 5, 147456 bytes)
[    0.511973] TCP: Hash tables configured (established 4096 bind 4096)
[    0.512104] TCP: reno registered
[    0.512147] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.512524] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.513677] NET: Registered protocol family 1
[    0.515562] RPC: Registered named UNIX socket transport module.
[    0.515591] RPC: Registered udp transport module.
[    0.515607] RPC: Registered tcp transport module.
[    0.515622] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.516772] Trying to unpack rootfs image as initramfs...
[    0.519750] rootfs image is not initramfs (no cpio magic); looks like an initrd
[    0.662323] Freeing initrd memory: 16384K
[    0.662364] initlevel:6=device, 185 registered initcalls
[    0.662555] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.871407] VFS: Disk quotas dquot_6.5.2
[    0.871803] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.873851] NFS: Registering the id_resolver key type
[    0.874506] Key type id_resolver registered
[    0.876183] jffs2: version 2.2. (NAND) (SUMMARY)  (c) 2001-2006 Red Hat, Inc.
[    0.877974] msgmni has been set to 226
[    0.882385] io scheduler noop registered
[    0.882412] io scheduler deadline registered
[    0.882717] io scheduler cfq registered (default)
[    0.886088] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.895186] serial.7: ttyO0 at MMIO 0x44e09000 (irq = 72) is a OMAP UART0
[    1.505204] console [ttyO0] enabled
[    1.511448] serial.8: ttyO1 at MMIO 0x48022000 (irq = 73) is a OMAP UART1
[    1.520916] serial.9: ttyO2 at MMIO 0x48024000 (irq = 74) is a OMAP UART2
[    1.530074] serial.10: ttyO3 at MMIO 0x481a6000 (irq = 44) is a OMAP UART3
[    1.539284] omap_uart serial.11: [UART-1]: failure [serial_omap_probe]: -22
[    1.546851] omap_uart: probe of serial.11 failed with error -22
[    1.553620] omap_uart serial.12: [UART-1]: failure [serial_omap_probe]: -22
[    1.561142] omap_uart: probe of serial.12 failed with error -22
[    1.608820] brd: module loaded
[    1.637652] loop: module loaded
[    1.648624] mtdoops: mtd device (mtddev=name/number) must be supplied
[    1.656752] OneNAND driver initializing
[    1.674491] usbcore: registered new interface driver asix
[    1.680906] usbcore: registered new interface driver cdc_ether
[    1.688183] usbcore: registered new interface driver smsc95xx
[    1.695038] usbcore: registered new interface driver net1080
[    1.701812] usbcore: registered new interface driver cdc_subset
[    1.708799] usbcore: registered new interface driver zaurus
[    1.715502] usbcore: registered new interface driver cdc_ncm
[    1.723580] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.732223] usbcore: registered new interface driver cdc_wdm
[    1.738381] Initializing USB Mass Storage driver...
[    1.744253] usbcore: registered new interface driver usb-storage
[    1.750756] USB Mass Storage support registered.
[    1.757147] usbcore: registered new interface driver libusual
[    1.764115] usbcore: registered new interface driver usbtest
[    1.772211] mousedev: PS/2 mouse device common for all mice
[    1.783856] i2c /dev entries driver
[    1.792566] Driver for 1-wire Dallas network protocol.
[    1.802176] omap_wdt: OMAP Watchdog Timer Rev 0x01: initial timeout 60 sec
[    1.814226] omap_hsmmc mmc.18: Failed to get debounce clk
[    1.862284] omap_hsmmc mmc.19: Failed to get debounce clk
[    1.876636] mmc0: host doesn't support card's voltages
[    1.882177] mmc0: error -22 whilst initialising SD card
[    1.917083] omap_hsmmc mmc.20: Failed to get debounce clk
[    1.977688] usbcore: registered new interface driver usbhid
[    1.983724] usbhid: USB HID core driver
[    1.988349] oprofile: hardware counters not available
[    1.993683] oprofile: using timer interrupt.
[    1.999300] TCP: cubic registered
[    2.003296] Initializing XFRM netlink socket
[    2.007966] NET: Registered protocol family 17
[    2.012873] NET: Registered protocol family 15
[    2.018181] Key type dns_resolver registered
[    2.022711] initlevel:7=late, 26 registered initcalls
[    2.028304] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
[    2.036550] ThumbEE CPU extension supported.
[    2.054622] clock: disabling unused clocks to save power
[    2.068584] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    2.079800] RAMDISK: gzip image found at block 0
[    2.599286] VFS: Mounted root (ext2 filesystem) on device 1:0.
[    2.606462] Freeing init memory: 312K
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


