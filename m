From: Ben Gamari <bgamari.foss@gmail.com>
Subject: [BUG] PandaBoard hangs before starting init while booting v3.12
Date: Mon, 18 Nov 2013 10:14:00 -0500
Message-ID: <87hab9agjr.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:64721 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab3KRPOH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Nov 2013 10:14:07 -0500
Received: by mail-qa0-f48.google.com with SMTP id w5so828527qac.14
        for <linux-omap@vger.kernel.org>; Mon, 18 Nov 2013 07:14:06 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I'm having difficulty getting a PandaBoard ES rev. B1 to boot v3.12 and
linux-next (30121118). I'm booting with a brand new u-boot
(c2e5e802ecb7ab668ce9911b210ed68c804b349f).

In both cases the device appears to hang shortly before one would expect
init to start as seen in the boot output below. I'm booting with the
omap4-panda-es devicetree. As far as I can tell, the machine is
completely dead and will not respond to even sysrq. I have a PandaBoard
A4 which apparently has no trouble with the same kernel image.

The only issues I can see in the output are,

  * pinctrl issues pertaining to wl12xx[1], these shouldn't cause the
    machine not to boot
  * Various missing vmmc regulators
  * hw-breakpoint issues:
      * Failed to enable monitor mode on CPU 0
      * CPU 0 failed to disable vector catch
    These sound serious and occur near the hang. Perhaps this is the culpri=
t?

Any help would be greatly appreciated.

Cheers,

=2D Ben


[1] http://www.spinics.net/lists/devicetree/msg07983.html


reading uEnv-new.txt
1147 bytes read in 5 ms (223.6 KiB/s)
Importing environment from mmc0 ...
Running uenvcmd ...
reading zImage-new
3738608 bytes read in 172 ms (20.7 MiB/s)
reading uInitrd-new.img
3241151 bytes read in 157 ms (19.7 MiB/s)
reading /dtbs-new/omap4-panda-es.dtb
20188 bytes read in 10 ms (1.9 MiB/s)
Kernel image @ 0x80300000 [ 0x000000 - 0x390bf0 ]
## Loading init Ramdisk from Legacy Image at 81600000 ...
   Image Name:=20=20=20
   Image Type:   ARM Linux RAMDisk Image (gzip compressed)
   Data Size:    3241087 Bytes =3D 3.1 MiB
   Load Address: 81600000
   Entry Point:  81600000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 815f0000
   Booting using the fdt blob at 0x815f0000
   Loading Ramdisk to 8fce8000, end 8ffff47f ... OK
   Using Device Tree in place at 815f0000, end 815f7edb

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.12.0-next-20131118 (ben@ben-server) (gcc ver=
sion 4.7.3 (Ubuntu/Linaro 4.7.3-1ubuntu1) ) #11 SMP Mon Nov 18 02:24:43 EST=
 2013
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=3D10=
c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instr=
uction cache
[    0.000000] Machine model: TI OMAP4 PandaBoard
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] OMAP4460 ES1.1
[    0.000000] PERCPU: Embedded 9 pages/cpu @c13c8000 s13568 r8192 d15104 u=
36864
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 260368
[    0.000000] Kernel command line: console=3DttyO2,115200n8 earlyprintk in=
itcall_debug vram=3D16M omapfb.mode=3D: omapdss.def_disp=3D root=3D/dev/mmc=
blk0p5 ro rootfstype=3Dext4 fixrtc
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 by=
tes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 byte=
s)
[    0.000000] allocated 2097152 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=3Dmemory' option if you don't wan=
t memory cgroups
[    0.000000] Memory: 1021188K/1047552K available (7108K kernel code, 620K=
 rwdata, 2940K rodata, 457K init, 833K bss, 26364K reserved, 269312K highme=
m)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc09d845c   (10050 kB)
[    0.000000]       .init : 0xc09d9000 - 0xc0a4b500   ( 458 kB)
[    0.000000]       .data : 0xc0a4c000 - 0xc0ae7350   ( 621 kB)
[    0.000000]        .bss : 0xc0ae7350 - 0xc0bb79b8   ( 834 kB)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2, N=
odes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps eve=
ry 65536000000000ns
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000000] smp_twd: clock not found -2
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Calibrating local timer... 349.20MHz.
[    0.077056] Calibrating delay loop... 1391.00 BogoMIPS (lpj=3D6955008)
[    0.119934] pid_max: default: 32768 minimum: 301
[    0.124908] Security Framework initialized
[    0.129272] AppArmor: AppArmor initialized
[    0.133758] Mount-cache hash table entries: 512
[    0.143310] Initializing cgroup subsys memory
[    0.147979] Initializing cgroup subsys devices
[    0.152618] Initializing cgroup subsys freezer
[    0.157318] Initializing cgroup subsys blkio
[    0.161773] Initializing cgroup subsys perf_event
[    0.166809] CPU: Testing write buffer coherency: ok
[    0.172271] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.178375] Setting up static identity map for 0x806b5b60 - 0x806b5bb8
[    0.185333] L310 cache controller enabled
[    0.189575] l2x0: 16 ways, CACHE_ID 0x410000c7, AUX_CTRL 0x7e470000, Cac=
he size: 1024 kB
[    0.199951] CPU1: Booted secondary processor
[    0.236694] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.236816] Brought up 2 CPUs
[    0.250305] SMP: Total of 2 processors activated.
[    0.255218] CPU: All CPU(s) started in SVC mode.
[    0.260803] devtmpfs: initialized
[    0.268188] VFP support v0.3: implementor 41 architecture 3 part 30 vari=
ant 9 rev 4
[    0.338623] xor: measuring software checksum speed
[    0.436248]    arm4regs  :   982.800 MB/sec
[    0.536010]    8regs     :   762.400 MB/sec
[    0.635803]    32regs    :   802.800 MB/sec
[    0.640197] xor: using function: arm4regs (982.800 MB/sec)
[    0.645965] pinctrl core: initialized pinctrl subsystem
[    0.651733] regulator-dummy: no parameters
[    0.656555] NET: Registered protocol family 16
[    0.662567] DMA: preallocated 256 KiB pool for atomic coherent allocatio=
ns
[    0.670867] cpuidle: using governor ladder
[    0.675170] cpuidle: using governor menu
[    0.692718] OMAP GPIO hardware version 0.1
[    0.701019] omap-gpmc 50000000.gpmc: GPMC revision 6.0
[    0.712493] platform 4b501000.aes: Cannot lookup hwmod 'aes'
[    0.718566] platform 480a5000.des: Cannot lookup hwmod 'des'
[    0.726593] No ATAGs?
[    0.729064] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchp=
oint registers.
[    0.737365] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.743957] omap_init_mbox: hwmod doesn't have valid attrs
[    0.750549] OMAP DMA hardware revision 0.0
[    0.764617] bio: create slab <bio-0> at 0
[    0.935180] raid6: int32x1     69 MB/s
[    1.104766] raid6: int32x2    117 MB/s
[    1.274810] raid6: int32x4    116 MB/s
[    1.444244] raid6: int32x8    125 MB/s
[    1.448211] raid6: using algorithm int32x8 (125 MB/s)
[    1.453460] raid6: using intx1 recovery algorithm
[    1.459045] edma-dma-engine edma-dma-engine.0: Can't allocate PaRAM dumm=
y slot
[    1.466552] edma-dma-engine: probe of edma-dma-engine.0 failed with erro=
r -5
[    1.484497] omap-dma-engine 4a056000.dma-controller: OMAP DMA engine dri=
ver
[    1.492340] hsusb1_vbus: 3300 mV=20
[    1.495910] reg-fixed-voltage wl12xx_vmmc.10: could not find pctldev for=
 node /ocp/pinmux@4a31e040/pinmux_wl12xx_gpio, deferring probe
[    1.508422] platform wl12xx_vmmc.10: Driver reg-fixed-voltage requests p=
robe deferral
[    1.519165] SCSI subsystem initialized
[    1.523620] usbcore: registered new interface driver usbfs
[    1.529418] usbcore: registered new interface driver hub
[    1.535064] usbcore: registered new device driver usb
[    1.541076] omap_i2c 48070000.i2c: could not find pctldev for node /ocp/=
pinmux@4a100040/pinmux_i2c1_pins, deferring probe
[    1.552429] platform 48070000.i2c: Driver omap_i2c requests probe deferr=
al
[    1.559600] omap_i2c 48072000.i2c: could not find pctldev for node /ocp/=
pinmux@4a100040/pinmux_i2c2_pins, deferring probe
[    1.570953] platform 48072000.i2c: Driver omap_i2c requests probe deferr=
al
[    1.578124] omap_i2c 48060000.i2c: could not find pctldev for node /ocp/=
pinmux@4a100040/pinmux_i2c3_pins, deferring probe
[    1.589508] platform 48060000.i2c: Driver omap_i2c requests probe deferr=
al
[    1.596649] omap_i2c 48350000.i2c: could not find pctldev for node /ocp/=
pinmux@4a100040/pinmux_i2c4_pins, deferring probe
[    1.608001] platform 48350000.i2c: Driver omap_i2c requests probe deferr=
al
[    1.615295] media: Linux media interface: v0.10
[    1.620147] Linux video capture interface: v2.00
[    1.626159] Advanced Linux Sound Architecture Driver Initialized.
[    1.633270] NetLabel: Initializing
[    1.636871] NetLabel:  domain hash size =3D 128
[    1.641418] NetLabel:  protocols =3D UNLABELED CIPSOv4
[    1.646636] NetLabel:  unlabeled traffic allowed by default
[    1.652862] Switched to clocksource 32k_counter
[    1.675933] AppArmor: AppArmor Filesystem Enabled
[    1.691864] NET: Registered protocol family 2
[    1.697143] TCP established hash table entries: 8192 (order: 3, 32768 by=
tes)
[    1.704559] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    1.711425] TCP: Hash tables configured (established 8192 bind 8192)
[    1.718109] TCP: reno registered
[    1.721527] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    1.727752] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    1.734802] NET: Registered protocol family 1
[    1.739746] RPC: Registered named UNIX socket transport module.
[    1.745941] RPC: Registered udp transport module.
[    1.750854] RPC: Registered tcp transport module.
[    1.755798] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.763793] Trying to unpack rootfs image as initramfs...
[    2.031555] Freeing initrd memory: 3164K (cfce8000 - cffff000)
[    2.038391] hw perfevents: enabled with ARMv7 Cortex-A9 PMU driver, 7 co=
unters available
[    2.050140] audit: initializing netlink socket (disabled)
[    2.055816] type=3D2000 audit(2.050:1): initialized
[    2.279815] bounce pool size: 64 pages
[    2.289947] VFS: Disk quotas dquot_6.5.2
[    2.294403] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    2.304626] NFS: Registering the id_resolver key type
[    2.309936] Key type id_resolver registered
[    2.314361] Key type id_legacy registered
[    2.318603] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    2.325744] fuse init (API version 7.22)
[    2.330932] bio: create slab <bio-1> at 1
[    2.336303] Btrfs loaded
[    2.339019] msgmni has been set to 1474
[    2.345367] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 250)
[    2.353118] io scheduler noop registered
[    2.357269] io scheduler deadline registered
[    2.362060] io scheduler cfq registered (default)
[    2.371337] pinctrl-single 4a100040.pinmux: 203 pins at pa fc100040 size=
 406
[    2.379180] pinctrl-single 4a31e040.pinmux: 28 pins at pa fc31e040 size =
56
[    2.388000] OMAP DSS rev 4.0
[    2.392578] omapfb omapfb: no displays
[    2.396636] omapfb omapfb: failed to setup omapfb
[    2.401550] platform omapfb: Driver omapfb requests probe deferral
[    2.408966] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.416992] 4806a000.serial: ttyO0 at MMIO 0x4806a000 (irq =3D 104, base=
_baud =3D 3000000) is a OMAP UART0
[    2.427246] 4806c000.serial: ttyO1 at MMIO 0x4806c000 (irq =3D 105, base=
_baud =3D 3000000) is a OMAP UART1
[    2.437316] 48020000.serial: ttyO2 at MMIO 0x48020000 (irq =3D 106, base=
_baud =3D 3000000) is a OMAP UART2
[    2.447021] console [ttyO2] enabled
[    2.447021] console [ttyO2] enabled
[    2.454376] bootconsole [earlycon0] disabled
[    2.454376] bootconsole [earlycon0] disabled
[    2.463806] 4806e000.serial: ttyO3 at MMIO 0x4806e000 (irq =3D 102, base=
_baud =3D 3000000) is a OMAP UART3
[    2.480438] brd: module loaded
[    2.486755] loop: module loaded
[    2.494689] usbcore: registered new interface driver ax88179_178a
[    2.501159] usbcore: registered new interface driver cdc_ether
[    2.507415] usbcore: registered new interface driver r815x
[    2.513244] usbcore: registered new interface driver rndis_host
[    2.519592] usbcore: registered new interface driver cdc_ncm
[    2.526092] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.532989] ehci-omap: OMAP-EHCI Host Controller driver
[    2.558654] ehci-omap 4a064c00.ehci: EHCI Host Controller
[    2.564544] ehci-omap 4a064c00.ehci: new USB bus registered, assigned bu=
s number 1
[    2.572601] ehci-omap 4a064c00.ehci: irq 109, io mem 0x4a064c00
[    2.592864] ehci-omap 4a064c00.ehci: USB 2.0 started, EHCI 1.00
[    2.599304] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    2.606475] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.614074] usb usb1: Product: EHCI Host Controller
[    2.619171] usb usb1: Manufacturer: Linux 3.12.0-next-20131118 ehci_hcd
[    2.626129] usb usb1: SerialNumber: 4a064c00.ehci
[    2.631652] hub 1-0:1.0: USB hub found
[    2.635650] hub 1-0:1.0: 3 ports detected
[    2.640441] usbcore: registered new interface driver usb-storage
[    2.647338] mousedev: PS/2 mouse device common for all mice
[    2.654205] i2c /dev entries driver
[    2.658081] lirc_dev: IR Remote Control driver registered, major 246=20
[    2.665069] smssdio: Siano SMS1xxx SDIO driver
[    2.669738] smssdio: Copyright Pierre Ossman
[    2.674285] Driver for 1-wire Dallas network protocol.
[    2.680847] omap_wdt: OMAP Watchdog Timer Rev 0x01: initial timeout 60 s=
ec
[    2.688842] device-mapper: ioctl: 4.27.0-ioctl (2013-10-30) initialised:=
 dm-devel@redhat.com
[    2.698333] sdhci: Secure Digital Host Controller Interface driver
[    2.704833] sdhci: Copyright(c) Pierre Ossman
[    2.709838] omap-dma-engine 4a056000.dma-controller: allocating channel =
for 62
[    2.717468] omap-dma-engine 4a056000.dma-controller: allocating channel =
for 61
[    2.725097] omap_hsmmc 4809c000.mmc: vmmc regulator missing
[    2.730957] omap-dma-engine 4a056000.dma-controller: freeing channel for=
 61
[    2.738311] omap-dma-engine 4a056000.dma-controller: freeing channel for=
 62
[    2.745666] platform 4809c000.mmc: Driver omap_hsmmc requests probe defe=
rral
[    2.753082] pinctrl-single 4a31e040.pinmux: mux offset out of range: 0x3=
8 (0x38)
[    2.760864] pinctrl-single 4a31e040.pinmux: could not add functions for =
pinmux_wl12xx_pins 56x
[    2.770111] omap-dma-engine 4a056000.dma-controller: allocating channel =
for 60
[    2.777740] omap-dma-engine 4a056000.dma-controller: allocating channel =
for 59
[    2.785369] omap_hsmmc 480d5000.mmc: vmmc regulator missing
[    2.791229] omap-dma-engine 4a056000.dma-controller: freeing channel for=
 59
[    2.798553] omap-dma-engine 4a056000.dma-controller: freeing channel for=
 60
[    2.805938] platform 480d5000.mmc: Driver omap_hsmmc requests probe defe=
rral
[    2.814300] ledtrig-cpu: registered to indicate activity on CPUs
[    2.820739] hidraw: raw HID events driver (C) Jiri Kosina
[    2.826812] usbcore: registered new interface driver usbhid
[    2.832641] usbhid: USB HID core driver
[    2.837249] ashmem: initialized
d
[    2.883728] omap-hdmi-audio omap-hdmi-audio: snd_soc_register_card faile=
d (-517)
[    2.891510] platform omap-hdmi-audio: Driver omap-hdmi-audio requests pr=
obe deferral
[    2.899932] oprofile: using arm/armv7-ca9
[    2.904724] TCP: cubic registered
[    2.908874] NET: Registered protocol family 10
[    2.914245] NET: Registered protocol family 17
[    2.919281] Key type dns_resolver registered
[    2.924224] cpu cpu0: dummy supplies not allowed
[    2.929077] cpufreq_cpu0: failed to get cpu0 regulator: -19
[    2.934967] cpufreq_cpu0: failed to get cpu0 clock: -2
[    2.940368] cpufreq-cpu0: probe of cpufreq-cpu0.0 failed with error -2
[    2.947326] Power Management for TI OMAP4+ devices.
[    2.952484] Power Management for TI OMAP4.
[    2.956787] OMAP4 PM: u-boot >=3D v2012.07 is required for full PM suppo=
rt
[    2.964233] ThumbEE CPU extension supported.
[    2.968749] Registering SWP/SWPB emulation handler
[    2.973815] SmartReflex Class3 initialized
[    2.978912] registered taskstats version 1
[    2.983459] AppArmor: AppArmor sha1 policy hashing enabled
[    2.989776] vwl1271: 1800 mV=20
[    3.000091] Skipping twl internal clock init and using bootloader value =
(unknown osc rate)
[    3.009490] twl 0-0048: PIH (irq 39) nested IRQs
[    3.015655] twl_rtc rtc.11: Enabling TWL-RTC
[    3.022827] twl_rtc rtc.11: rtc core: registered rtc.11 as rtc0
[    3.029571] VAUX1_6030: 1000 <--> 3000 mV at 2800 mV=20
[    3.035583] VAUX2_6030: 1200 <--> 2800 mV at 1800 mV=20
[    3.041534] VAUX3_6030: 1000 <--> 3000 mV at 1200 mV=20
[    3.047515] VMMC: 1200 <--> 3000 mV at 3000 mV=20
[    3.052978] VPP: 1800 <--> 2500 mV at 1900 mV=20
[    3.053070] usb 1-1: new high-speed USB device number 2 using ehci-omap
[    3.065307] VUSIM: 1200 <--> 2900 mV at 1800 mV=20
[    3.070312] VDAC: 1800 mV=20
[    3.073852] VANA: 2100 mV=20
[    3.077301] VCXIO: 1800 mV=20
[    3.077301] VUSB: 3300 mV=20
[    3.084075] V1V8: 1800 mV=20
[    3.087554] V2V1: 2100 mV=20
[    3.098846] omap_i2c 48070000.i2c: bus 0 rev0.11 at 400 kHz
[    3.105468] omap_i2c 48072000.i2c: bus 1 rev0.11 at 400 kHz
[    3.116485] omap_i2c 48060000.i2c: bus 2 rev0.11 at 100 kHz
[    3.122955] omap_i2c 48350000.i2c: bus 3 rev0.11 at 400 kHz
[    3.129394] omapfb omapfb: no displays
[    3.133453] omapfb omapfb: failed to setup omapfb
[    3.133483] platform omapfb: Driver omapfb requests probe deferral
[    3.145141] omap-dma-engine 4a056000.dma-controller: allocating channel =
for 62
[    3.152893] omap-dma-engine 4a056000.dma-controller: allocating channel =
for 61
[    3.160583] 4809c000.mmc supply vmmc_aux not found, using dummy regulator
[    3.168365] hw-breakpoint: Failed to enable monitor mode on CPU 0.
[    3.175292] hw-breakpoint: CPU 0 failed to disable vector catch
[    3.183135] omap_hsmmc 4809c000.mmc: pins are not configured from the dr=
iver
[    3.216278] usb 1-1: New USB device found, idVendor=3D0424, idProduct=3D=
9514
[    3.223419] usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    3.231506] hub 1-1:1.0: USB hub found
[    3.235626] hub 1-1:1.0: 5 ports detected
[    3.240020] pinctrl-single 4a31e040.pinmux: mux offset out of range: 0x3=
8 (0x38)
[    3.247894] pinctrl-single 4a31e040.pinmux: could not add functions for =
pinmux_wl12xx_pins 56x
[    3.257324] omap-dma-engine 4a056000.dma-controller: allocating channel =
for 60
[    3.264953] omap-dma-engine 4a056000.dma-controller: allocating channel =
for 59
[    3.272705] 480d5000.mmc supply vmmc_aux not found, using dummy regulator

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQEcBAEBAgAGBQJSii64AAoJEErkyLZmeNiDe18H/1rS0FwESddi+jeBOluLSc6T
AOuzospnK8NIZ9H1zdv21AkruxVldAn1xcuEmkZwKoamFDxbC5KBBXOY9AkJ47Ce
YTdsMJ69qhwNoGktJnktA3r2L/NQrAIHpTMXuuhE00+7deI8UgSjGzpEZnvHotaL
72YouFd0czBcizA7lXCYcQVKAXnoJ39GCQTul0tqzKDaSmd1Edceqnm1dd+EsqmY
zN1lmRcc9p3nHx2LBw4XA3UeKYVivliQnUbUm7KyEKKTSFxy8FiZb8C4nJP/RtYx
bl3DR4SFmsWlb0qeZfY5J94hS68yVvdtbtQOtjIR0VYp2zekiG70wURqwCl+A4A=
=Z5hJ
-----END PGP SIGNATURE-----
--=-=-=--
