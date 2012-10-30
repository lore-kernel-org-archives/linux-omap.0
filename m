From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: OMAP baseline test results for v3.7-rc3
Date: Tue, 30 Oct 2012 10:09:23 +0530
Message-ID: <508F59FB.7080400@ti.com>
References: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50328 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769Ab2J3Ejg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Oct 2012 00:39:36 -0400
In-Reply-To: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On 10/30/2012 8:06 AM, Paul Walmsley wrote:
>=20
> Here are some basic OMAP test results for Linux v3.7-rc3.
> Logs and other details at:
>=20
>     http://www.pwsan.com/omap/testlogs/test_v3.7-rc3/20121028162003/
>=20
>=20
> Passing tests
> -------------
>=20
> Boot to userspace: 2420n800, 3517evm, 3530es3beagle, 3730beaglexm, 37=
xxevm,
>                    4430es2panda, 5912osk, am335xbone
>=20
> PM ret/off, suspend + dynamic idle: (none)
>=20
>=20
> Failing tests: fixed by posted patches
> --------------------------------------
>=20
> Boot tests:
>=20
> * 2430sdp: vfp_reload_hw oops during MMC initialization
>   - Kernel attempts to save FP registers that don't exist; fix posted=
:
>     - http://www.spinics.net/lists/arm-kernel/msg200646.html
>     - added to rmk's patch system as 7566/1
>=20
> * AM335x Beaglebone: omap2plus_defconfig kernels don't boot
>   - Due to GPMC missing support for DT
>   - Temporary workaround at http://www.spinics.net/lists/arm-kernel/m=
sg200787.html
>   - May be fixed now, pending retest:
>     - http://marc.info/?l=3Dlinux-omap&m=3D135082257727502&w=3D2
>=20

This is surprising, I have tested v3.7-rc3 branch on AM335xBone platfor=
m
and its booting up for me without any issues.
Jon had submitted another patch which fixes boot issue on Bone.

https://patchwork.kernel.org/patch/1606471/


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DBoot =
Log=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D



U-Boot#
U-Boot#
U-Boot#
U-Boot#
U-Boot#
U-Boot# mmc rescan 0
U-Boot# fatload mmc 0 80000000 am335x-bone.dtb
reading am335x-bone.dtb

4391 bytes read
U-Boot# fatload mmc 0 81000000 uImage
reading uImage

3841320 bytes read
U-Boot# fatload mmc 0 82000000 ramdisk-pm.gz
reading ramdisk-pm.gz

2022580 bytes read
U-Boot# setenv bootargs console=3DttyO0,115200n8 mem=3D256M root=3D/dev=
/ram rw
initrd=3D0x82000000,16MB ramdisk_size=3D65536 earlyprintk=3Dserial
U-Boot# bootm 81000000 - 80000000
## Booting kernel from Legacy Image at 81000000 ...
   Image Name:   Linux-3.7.0-rc3
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3841256 Bytes =3D 3.7 MiB
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
[    0.000000] Linux version 3.7.0-rc3 (a0393758@psplinux064) (gcc
version 4.5.3 20110311 (prerelease) (GCC) ) #1 SMP Tue Oct 30 09:46:04
IST 2012
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7),
cr=3D10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model:
TI AM335x BeagleBone
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] AM335X ES1.0 (neon )
[    0.000000] PERCPU: Embedded 9 pages/cpu @c0f03000 s12928 r8192
d15744 u36864
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 64768
[    0.000000] Kernel command line: console=3DttyO0,115200n8 mem=3D256M
root=3D/dev/ram rw initrd=3D0x82000000,16MB ramdisk_size=3D65536
earlyprintk=3Dserial
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072
bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 b=
ytes)
[    0.000000] Memory: 255MB =3D 255MB total
[    0.000000] Memory: 229112k/229112k available, 33032k reserved, 0K
highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc06c4b68   (6899 kB)
[    0.000000]       .init : 0xc06c5000 - 0xc0715280   ( 321 kB)
[    0.000000]       .data : 0xc0716000 - 0xc07a13a0   ( 557 kB)
[    0.000000]        .bss : 0xc07a13c4 - 0xc0cfbd6c   (5483 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=3D2 to nr_cpu_ids=3D1=
=2E
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 5.0) with 128
interrupts
[    0.000000] Total of 128 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 24000000 Hz
[    0.000000] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps
every 178956ms
[    0.000000] OMAP clocksource: GPTIMER2 at 24000000 Hz
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
[    0.001132] Calibrating delay loop... 364.48 BogoMIPS (lpj=3D1425408=
)
[    0.107570] pid_max: default: 32768 minimum: 301
[    0.108239] Security Framework initialized
[    0.108448] Mount-cache hash table entries: 512
[    0.118568] CPU: Testing write buffer coherency: ok
[    0.119689] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.119779] Setting up static identity map for 0x804d5ee0 - 0x804d5f=
50
[    0.122980] Brought up 1 CPUs
[    0.123011] SMP: Total of 1 processors activated (364.48 BogoMIPS).
[    0.147810] pinctrl core: initialized pinctrl subsystem
[    0.156141] regulator-dummy: no parameters
[    0.158749] NET: Registered protocol family 16
[    0.159728] DMA: preallocated 256 KiB pool for atomic coherent
allocations
[    0.161208] omap-gpmc omap-gpmc: GPMC revision 6.0
[    0.161436] omap-gpmc omap-gpmc: failed to reserve memory
[    0.161536] omap-gpmc: probe of omap-gpmc failed with error -16
[    0.190579] OMAP GPIO hardware version 0.1
[    0.206252] No ATAGs?
[    0.206283] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.293742] bio: create slab <bio-0> at 0
[    0.400896] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    0.408799] SCSI subsystem initialized
[    0.411752] usbcore: registered new interface driver usbfs
[    0.413025] usbcore: registered new interface driver hub
[    0.414113] usbcore: registered new device driver usb
[    0.431103] omap_i2c 44e0b000.i2c: bus 0 rev2.4.0 at 400 kHz
[    0.442630] Switching to clocksource gp_timer
[    0.597669] NET: Registered protocol family 2
[    0.600545] TCP established hash table entries: 8192 (order: 4, 6553=
6
bytes)
[    0.601064] TCP bind hash table entries: 8192 (order: 6, 294912 byte=
s)
[    0.605997] TCP: Hash tables configured (established 8192 bind 8192)
[    0.606290] TCP: reno registered
[    0.606333] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.606678] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.607821] NET: Registered protocol family 1
[    0.609499] RPC: Registered named UNIX socket transport module.
[    0.609529] RPC: Registered udp transport module.
[    0.609545] RPC: Registered tcp transport module.
[    0.609561] RPC: Registered tcp NFSv4.1 backchannel transport module=
=2E
[    0.610891] Trying to unpack rootfs image as initramfs...
[    0.613489] rootfs image is not initramfs (no cpio magic); looks lik=
e
an initrd
[    0.755899] Freeing initrd memory: 16384K
[    0.756108] NetWinder Floating Point Emulator V0.97 (double precisio=
n)
[    0.756747] CPU PMU: probing PMU on CPU 0
[    0.756984] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver, =
5
counters available
[    0.963611] VFS: Disk quotas dquot_6.5.2
[    0.963913] Dquot-cache hash table entries: 1024 (order 0, 4096 byte=
s)
[    0.967591] NFS: Registering the id_resolver key type
[    0.968222] Key type id_resolver registered
[    0.968255] Key type id_legacy registered
[    0.968449] jffs2: version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red
Hat, Inc.
[    0.969172] msgmni has been set to 479
[    0.973697] io scheduler noop registered
[    0.973729] io scheduler deadline registered
[    0.973866] io scheduler cfq registered (default)
[    0.977713] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.985692] omap_uart 44e09000.serial: did not get pins for uart0
error: -19
[    0.986374] 44e09000.serial: ttyO0 at MMIO 0x44e09000 (irq =3D 88) i=
s a
OMAP UART0
[    1.590551] console [ttyO0] enabled
[    1.634342] brd: module loaded
[    1.663009] loop: module loaded
[    1.673903] mtdoops: mtd device (mtddev=3Dname/number) must be suppl=
ied
[    1.682057] OneNAND driver initializing
[    1.693805] usbcore: registered new interface driver asix
[    1.700157] usbcore: registered new interface driver cdc_ether
[    1.707228] usbcore: registered new interface driver smsc95xx
[    1.714312] usbcore: registered new interface driver net1080
[    1.721103] usbcore: registered new interface driver cdc_subset
[    1.728096] usbcore: registered new interface driver zaurus
[    1.734875] usbcore: registered new interface driver cdc_ncm
[    1.743641] usbcore: registered new interface driver cdc_wdm
[    1.749802] Initializing USB Mass Storage driver...
[    1.755830] usbcore: registered new interface driver usb-storage
[    1.762172] USB Mass Storage support registered.
[    1.767796] usbcore: registered new interface driver usbtest
[    1.776135] mousedev: PS/2 mouse device common for all mice
[    1.787377] i2c /dev entries driver
[    1.793669] Driver for 1-wire Dallas network protocol.
[    1.803608] omap_wdt: OMAP Watchdog Timer Rev 0x01: initial timeout
60 sec
[    1.816899] usbcore: registered new interface driver usbhid
[    1.823040] usbhid: USB HID core driver
[    1.828816] oprofile: using arm/armv7
[    1.833658] TCP: cubic registered
[    1.837422] Initializing XFRM netlink socket
[    1.842165] NET: Registered protocol family 17
[    1.846984] NET: Registered protocol family 15
[    1.852261] Key type dns_resolver registered
[    1.856941] VFP support v0.3: implementor 41 architecture 3 part 30
variant c rev 3
[    1.865272] ThumbEE CPU extension supported.
[    1.882344] clock: disabling unused clocks to save power
[    1.895621] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    1.907005] RAMDISK: gzip image found at block 0
[    2.380009] VFS: Mounted root (ext2 filesystem) on device 1:0.
[    2.387220] Freeing init memory: 320K
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


Thanks,
Vaibhav
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
