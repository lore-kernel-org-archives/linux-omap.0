From: Roger Quadros <rogerq@ti.com>
Subject: Re: pandaboard usb ethernet failed to connect to network
Date: Mon, 22 Jul 2013 11:35:04 +0300
Message-ID: <51ECEEB8.5040507@ti.com>
References: <SNT131-W35E1FF7C785E6D1ADA69BE86E0@phx.gbl> <51ECEB58.8070406@ti.com> <1bd09d65.1921d.140057dc1c1.Coremail.xufei_wh@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60060 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756769Ab3GVIfH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jul 2013 04:35:07 -0400
In-Reply-To: <1bd09d65.1921d.140057dc1c1.Coremail.xufei_wh@hotmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: xufei_wh@hotmail.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Please don't drop mailing list from cc.

On 07/22/2013 11:27 AM, xufei_wh@hotmail.com wrote:
> Hi roger:
>  Do you mean it works from 3.11-rc2.  But I've tested with 3.11-rc2, =
 there is the same problem. =20
>  Should I have to use 3.11-rc1 with your patch.

OK. In your earlier mail you mentioned 3.10.

Looks like that patch didn't go in 3.11-rc2. So can you please try
with the patch on top of 3.11-rc2?

cheers,
-roger

>=20
> ---------------------------------------------------------------------=
---------------------------------------------------------
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 3.11.0-rc2 (root@localhost.localdomain) =
(gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) ) #2 SMP Mon Jul 22 1=
4:34:58 CST 2013
> [    0.000000] CPU: ARMv7 Processor [411fc093] revision 3 (ARMv7), cr=
=3D10c53c7d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing=
 instruction cache
> [    0.000000] Machine: Generic OMAP4 (Flattened Device Tree), model:=
 TI OMAP4 PandaBoard
> [    0.000000] cma: CMA: reserved 16 MiB at ae800000
> [    0.000000] Memory policy: ECC disabled, Data cache writealloc
> [    0.000000] OMAP4430 ES2.3
> [    0.000000] PERCPU: Embedded 9 pages/cpu @c160f000 s14144 r8192 d1=
4528 u36864
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.=
  Total pages: 246032
> [    0.000000] Kernel command line: console=3DttyO2,115200n8 mem=3D45=
6M@0x80000000 mem=3D512M@0xA0000000 root=3D/dev/nfs nfsroot=3D10.38.58.=
209:/srv/rootfs-panda rw ip=3D10.38.58.246:::::eth0 rootdelay=3D2
> [    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524=
288 bytes)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 26214=
4 bytes)
> [    0.000000] Memory: 950788K/990208K available (5759K kernel code, =
614K rwdata, 1944K rodata, 381K init, 5522K bss, 39420K reserved, 26931=
2K highmem)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
> [    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
> [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
> [    0.000000]       .text : 0xc0008000 - 0xc078e124   (7705 kB)
> [    0.000000]       .init : 0xc078f000 - 0xc07ee740   ( 382 kB)
> [    0.000000]       .data : 0xc07f0000 - 0xc0889a80   ( 615 kB)
> [    0.000000]        .bss : 0xc0889a80 - 0xc0dee5b0   (5523 kB)
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000] NR_IRQS:16 nr_irqs:16 16
> [    0.000000] OMAP clockevent source: timer1 at 32768 Hz
> [    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wra=
ps every 131071999ms
> [    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
> [    0.000000] smp_twd: clock not found -2
> [    0.000000] Console: colour dummy device 80x30
> [    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat,=
 Inc., Ingo Molnar
> [    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    0.000000] ... MAX_LOCK_DEPTH:          48
> [    0.000000] ... MAX_LOCKDEP_KEYS:        8191
> [    0.000000] ... CLASSHASH_SIZE:          4096
> [    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
> [    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
> [    0.000000] ... CHAINHASH_SIZE:          16384
> [    0.000000]  memory used by lock dependency info: 3695 kB
> [    0.000000]  per task-struct memory footprint: 1152 bytes
> [    0.001922] Calibrating delay loop... 1191.11 BogoMIPS (lpj=3D5955=
584)
> [    0.079620] pid_max: default: 32768 minimum: 301
> [    0.080352] Security Framework initialized
> [    0.080596] Mount-cache hash table entries: 512
> [    0.096557] CPU: Testing write buffer coherency: ok
> [    0.098632] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.098663] Calibrating local timer... 298.93MHz.
> [    0.149749] Setting up static identity map for 0xc057adc0 - 0xc057=
ae30
> [    0.149871] L310 cache controller enabled
> [    0.149902] l2x0: 16 ways, CACHE_ID 0x410000c4, AUX_CTRL 0x7e47000=
0, Cache size: 1048576 B
> [    0.155456] CPU1: Booted secondary processor
> [    0.189544] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> [    0.190155] Brought up 2 CPUs
> [    0.190185] SMP: Total of 2 processors activated (2382.23 BogoMIPS=
).
> [    0.190185] CPU: All CPU(s) started in SVC mode.
> [    0.193023] devtmpfs: initialized
> [    0.274963] pinctrl core: initialized pinctrl subsystem
> [    0.278717] regulator-dummy: no parameters
> [    0.282470] NET: Registered protocol family 16
> [    0.291381] DMA: preallocated 256 KiB pool for atomic coherent all=
ocations
> [    0.380187] OMAP GPIO hardware version 0.1
> [    0.394531] omap-gpmc 50000000.gpmc: error: clk_get
> [    0.394592] omap-gpmc: probe of 50000000.gpmc failed with error -2
> [    0.427581] No ATAGs?
> [    0.427642] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 =
watchpoint registers.
> [    0.427642] hw-breakpoint: maximum watchpoint size is 4 bytes.
> [    0.432128] OMAP DMA hardware revision 0.0
> [    0.435302] ARM PMU: not yet supported on OMAP4430 due to missing =
CTI driver
> [    0.484527] bio: create slab <bio-0> at 0
> [    0.487884] edma-dma-engine edma-dma-engine.0: Can't allocate PaRA=
M dummy slot
> [    0.487945] edma-dma-engine: probe of edma-dma-engine.0 failed wit=
h error -5
> [    0.551391] omap-dma-engine 4a056000.dma-controller: OMAP DMA engi=
ne driver
> [    0.553649] hsusb1_reset: 3300 mV=20
> [    0.554687] hsusb1_vbus: 3300 mV=20
> [    0.561767] SCSI subsystem initialized
> [    0.563568] usbcore: registered new interface driver usbfs
> [    0.563934] usbcore: registered new interface driver hub
> [    0.564453] usbcore: registered new device driver usb
> [    0.567565] omap_i2c 48070000.i2c: could not find pctldev for node=
 /ocp/pinmux@4a100040/pinmux_i2c1_pins, deferring probe
> [    0.567596] platform 48070000.i2c: Driver omap_i2c requests probe =
deferral
> [    0.567687] omap_i2c 48072000.i2c: could not find pctldev for node=
 /ocp/pinmux@4a100040/pinmux_i2c2_pins, deferring probe
> [    0.567718] platform 48072000.i2c: Driver omap_i2c requests probe =
deferral
> [    0.567779] omap_i2c 48060000.i2c: could not find pctldev for node=
 /ocp/pinmux@4a100040/pinmux_i2c3_pins, deferring probe
> [    0.567810] platform 48060000.i2c: Driver omap_i2c requests probe =
deferral
> [    0.567871] omap_i2c 48350000.i2c: could not find pctldev for node=
 /ocp/pinmux@4a100040/pinmux_i2c4_pins, deferring probe
> [    0.567901] platform 48350000.i2c: Driver omap_i2c requests probe =
deferral
> [    0.574890] Switched to clocksource 32k_counter
> [    0.695770] NET: Registered protocol family 2
> [    0.697845] TCP established hash table entries: 8192 (order: 4, 65=
536 bytes)
> [    0.698242] TCP bind hash table entries: 8192 (order: 6, 294912 by=
tes)
> [    0.701354] TCP: Hash tables configured (established 8192 bind 819=
2)
> [    0.701660] TCP: reno registered
> [    0.701721] UDP hash table entries: 512 (order: 3, 40960 bytes)
> [    0.702148] UDP-Lite hash table entries: 512 (order: 3, 40960 byte=
s)
> [    0.703765] NET: Registered protocol family 1
> [    0.705413] RPC: Registered named UNIX socket transport module.
> [    0.705413] RPC: Registered udp transport module.
> [    0.705444] RPC: Registered tcp transport module.
> [    0.705444] RPC: Registered tcp NFSv4.1 backchannel transport modu=
le.
> [    0.709838] NetWinder Floating Point Emulator V0.97 (double precis=
ion)
> [    0.905731] bounce pool size: 64 pages
> [    0.906494] VFS: Disk quotas dquot_6.5.2
> [    0.906768] Dquot-cache hash table entries: 1024 (order 0, 4096 by=
tes)
> [    0.909515] NFS: Registering the id_resolver key type
> [    0.909973] Key type id_resolver registered
> [    0.909973] Key type id_legacy registered
> [    0.910125] jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006=
 Red Hat, Inc.
> [    0.910766] msgmni has been set to 1363
> [    0.914276] io scheduler noop registered
> [    0.914306] io scheduler deadline registered
> [    0.914398] io scheduler cfq registered (default)
> [    0.916503] pinctrl-single 4a100040.pinmux: 203 pins at pa fc10004=
0 size 406
> [    0.917144] pinctrl-single 4a31e040.pinmux: 28 pins at pa fc31e040=
 size 56
> [    0.920989] Serial: 8250/16550 driver, 4 ports, IRQ sharing enable=
d
> [    0.926879] omap_uart 4806a000.serial: did not get pins for uart0 =
error: -19
> [    0.928100] 4806a000.serial: ttyO0 at MMIO 0x4806a000 (irq =3D 104=
) is a OMAP UART0
> [    0.930053] omap_uart 4806c000.serial: did not get pins for uart1 =
error: -19
> [    0.930480] 4806c000.serial: ttyO1 at MMIO 0x4806c000 (irq =3D 105=
) is a OMAP UART1
> [    0.931640] omap_uart 48020000.serial: did not get pins for uart2 =
error: -19
> [    0.932067] 48020000.serial: ttyO2 at MMIO 0x48020000 (irq =3D 106=
) is a OMAP UART2
> [    1.703094] console [ttyO2] enabled
> [    1.708129] omap_uart 4806e000.serial: did not get pins for uart3 =
error: -19
> [    1.716033] 4806e000.serial: ttyO3 at MMIO 0x4806e000 (irq =3D 102=
) is a OMAP UART3
> [    1.751525] brd: module loaded
> [    1.770568] loop: module loaded
> [    1.779632] mtdoops: mtd device (mtddev=3Dname/number) must be sup=
plied
> [    1.798187] usbcore: registered new interface driver asix
> [    1.804290] usbcore: registered new interface driver ax88179_178a
> [    1.811157] usbcore: registered new interface driver cdc_ether
> [    1.817779] usbcore: registered new interface driver r815x
> [    1.823974] usbcore: registered new interface driver smsc95xx
> [    1.830474] usbcore: registered new interface driver net1080
> [    1.836914] usbcore: registered new interface driver cdc_subset
> [    1.843536] usbcore: registered new interface driver zaurus
> [    1.849945] usbcore: registered new interface driver cdc_ncm
> [    1.857238] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Dr=
iver
> [    1.864227] ehci-omap: OMAP-EHCI Host Controller driver
> [    1.940185] ehci-omap 4a064c00.ehci: EHCI Host Controller
> [    1.948303] ehci-omap 4a064c00.ehci: new USB bus registered, assig=
ned bus number 1
> [    1.958343] ehci-omap 4a064c00.ehci: irq 109, io mem 0x4a064c00
> [    1.984863] ehci-omap 4a064c00.ehci: USB 2.0 started, EHCI 1.00
> [    1.992004] usb usb1: New USB device found, idVendor=3D1d6b, idPro=
duct=3D0002
> [    1.999267] usb usb1: New USB device strings: Mfr=3D3, Product=3D2=
, SerialNumber=3D1
> [    2.006958] usb usb1: Product: EHCI Host Controller
> [    2.012145] usb usb1: Manufacturer: Linux 3.11.0-rc2 ehci_hcd
> [    2.018280] usb usb1: SerialNumber: 4a064c00.ehci
> [    2.027557] hub 1-0:1.0: USB hub found
> [    2.031646] hub 1-0:1.0: 3 ports detected
> [    2.039459] usbcore: registered new interface driver cdc_wdm
> [    2.046325] usbcore: registered new interface driver usb-storage
> [    2.053100] usbcore: registered new interface driver usbtest
> [    2.060821] mousedev: PS/2 mouse device common for all mice
> [    2.071472] i2c /dev entries driver
> [    2.075561] Driver for 1-wire Dallas network protocol.
> [    2.086029] omap_wdt: OMAP Watchdog Timer Rev 0x00: initial timeou=
t 60 sec
> [    2.096466] omap-dma-engine 4a056000.dma-controller: allocating ch=
annel for 62
> [    2.104187] omap-dma-engine 4a056000.dma-controller: allocating ch=
annel for 61
> [    2.111999] omap_hsmmc 4809c000.mmc: vmmc regulator missing
> [    2.118255] omap-dma-engine 4a056000.dma-controller: freeing chann=
el for 61
> [    2.125671] omap-dma-engine 4a056000.dma-controller: freeing chann=
el for 62
> [    2.133148] platform 4809c000.mmc: Driver omap_hsmmc requests prob=
e deferral
> [    2.141387] omap-dma-engine 4a056000.dma-controller: allocating ch=
annel for 60
> [    2.149108] omap-dma-engine 4a056000.dma-controller: allocating ch=
annel for 59
> [    2.156890] omap_hsmmc 480d5000.mmc: vmmc regulator missing
> [    2.162841] omap-dma-engine 4a056000.dma-controller: freeing chann=
el for 59
> [    2.170288] omap-dma-engine 4a056000.dma-controller: freeing chann=
el for 60
> [    2.182464] ledtrig-cpu: registered to indicate activity on CPUs
> [    2.190063] usbcore: registered new interface driver usbhid
> [    2.196014] usbhid: USB HID core driver
> [    2.201171] oprofile: no performance counters
> [    2.207733] oprofile: using timer interrupt.
> [    2.212982] TCP: cubic registered
> [    2.216552] Initializing XFRM netlink socket
> [    2.221221] NET: Registered protocol family 17
> [    2.226043] NET: Registered protocol family 15
> [    2.231140] Key type dns_resolver registered
> [    2.235839] VFP support v0.3: implementor 41 architecture 3 part 3=
0 variant 9 rev 4
> [    2.245574] Power Management for TI OMAP4+ devices.
> [    2.250823] Power Management for TI OMAP4.
> [    2.255218] OMAP4 PM: u-boot >=3D v2012.07 is required for full PM=
 support
> [    2.262542] ThumbEE CPU extension supported.
> [    2.274932] omap_i2c 48070000.i2c: bus 0 rev0.10 at 400 kHz
> [    2.286071] Skipping twl internal clock init and using bootloader =
value (unknown osc rate)
> [    2.298095] twl 0-0048: PIH (irq 39) chaining IRQs 416..436
> [    2.306488] twl_rtc rtc.10: Power up reset detected.
> [    2.312835] twl_rtc rtc.10: Enabling TWL-RTC
> [    2.322723] twl_rtc rtc.10: rtc core: registered rtc.10 as rtc0
> [    2.332244] VAUX1_6030: 1000 <--> 3000 mV at 1800 mV=20
> [    2.340423] VAUX2_6030: 1200 <--> 2800 mV at 1800 mV=20
> [    2.348266] VAUX3_6030: 1000 <--> 3000 mV at 1200 mV=20
> [    2.356079] VMMC: 1200 <--> 3000 mV at 3000 mV=20
> [    2.363220] VPP: 1800 <--> 2500 mV at 1900 mV=20
> [    2.370300] VUSIM: 1200 <--> 2900 mV at 1800 mV=20
> [    2.377258] VDAC: 1800 mV=20
> [    2.381835] VANA: 2100 mV=20
> [    2.386871] VCXIO: 1800 mV=20
> [    2.391601] VUSB: 3300 mV=20
> [    2.396759] V1V8: 1800 mV=20
> [    2.401763] V2V1: 2100 mV=20
> [    2.407684] usb 1-1: new high-speed USB device number 2 using ehci=
-omap
> [    2.428192] omap_i2c 48072000.i2c: bus 1 rev0.10 at 400 kHz
> [    2.436584] omap_i2c 48060000.i2c: bus 2 rev0.10 at 100 kHz
> [    2.446136] omap_i2c 48350000.i2c: bus 3 rev0.10 at 400 kHz
> [    2.452941] omap-dma-engine 4a056000.dma-controller: allocating ch=
annel for 62
> [    2.460693] omap-dma-engine 4a056000.dma-controller: allocating ch=
annel for 61
> [    2.472412] omap_hsmmc 4809c000.mmc: pins are not configured from =
the driver
> [    2.529968] twl_rtc rtc.10: setting system clock to 2000-01-01 00:=
00:00 UTC (946684800)
> [    2.585601] usb 1-1: New USB device found, idVendor=3D0424, idProd=
uct=3D9514
> [    2.592773] usb 1-1: New USB device strings: Mfr=3D0, Product=3D0,=
 SerialNumber=3D0
> [    2.602966] hub 1-1:1.0: USB hub found
> [    2.607299] hub 1-1:1.0: 5 ports detected
> [    2.720733] mmc0: host does not support reading read-only switch. =
assuming write-enable.
> [    2.732025] mmc0: new high speed SDHC card at address 1234
> [    2.740447] mmcblk0: mmc0:1234 SA04G 3.67 GiB=20
> [    2.751312]  mmcblk0: p1 p2
> [    2.904937] usb 1-1.1: new high-speed USB device number 3 using eh=
ci-omap
> [    3.040222] usb 1-1.1: New USB device found, idVendor=3D0424, idPr=
oduct=3Dec00
> [    3.047576] usb 1-1.1: New USB device strings: Mfr=3D0, Product=3D=
0, SerialNumber=3D0
> [    3.059692] smsc95xx v1.0.4
> [    3.719573] smsc95xx 1-1.1:1.0 eth0: register 'smsc95xx' at usb-4a=
064c00.ehci-1.1, smsc95xx USB 2.0 Ethernet, ea:6e:f5:1a:32:8b
> [    6.476684] smsc95xx 1-1.1:1.0 eth0: hardware isn't capable of rem=
ote wakeup
> [    9.224060] smsc95xx 1-1.1:1.0 eth0: link up, 100Mbps, full-duplex=
, lpa 0x45E1
> [    9.258178] IP-Config: Guessing netmask 255.0.0.0
> [    9.258178] IP-Config: Complete:
> [    9.267089]      device=3Deth0, hwaddr=3Dea:6e:f5:1a:32:8b, ipaddr=
=3D10.38.58.246, mask=3D255.0.0.0, gw=3D255.255.255.255
> [    9.277923]      host=3D10.38.58.246, domain=3D, nis-domain=3D(non=
e)
> [    9.284149]      bootserver=3D255.255.255.255, rootserver=3D10.38.=
58.209, rootpath=3D
> [    9.294799] Waiting 2 sec before mounting root device...
> [    9.304931] smsc95xx 1-1.1:1.0 eth0: Failed to write reg index 0x0=
0000114: -71
> [    9.312744] smsc95xx 1-1.1:1.0 eth0: Error writing MII_ADDR
> [    9.322875] smsc95xx 1-1.1:1.0 eth0: Failed to read reg index 0x00=
000114: -71
> [    9.330505] smsc95xx 1-1.1:1.0 eth0: Error reading MII_ACCESS
> [    9.336730] smsc95xx 1-1.1:1.0 eth0: MII is busy in smsc95xx_mdio_=
read
> [    9.347839] smsc95xx 1-1.1:1.0 eth0: Failed to read reg index 0x00=
000114: -71
> [    9.355529] smsc95xx 1-1.1:1.0 eth0: Error reading MII_ACCESS
> [    9.361724] smsc95xx 1-1.1:1.0 eth0: MII is busy in smsc95xx_mdio_=
read
> [    9.372772] smsc95xx 1-1.1:1.0 eth0: Failed to read reg index 0x00=
000114: -71
> [    9.380432] smsc95xx 1-1.1:1.0 eth0: Error reading MII_ACCESS
> [    9.386596] smsc95xx 1-1.1:1.0 eth0: MII is busy in smsc95xx_mdio_=
read
> [    9.397735] smsc95xx 1-1.1:1.0 eth0: Failed to read reg index 0x00=
000114: -71
> [    9.405395] smsc95xx 1-1.1:1.0 eth0: Error reading MII_ACCESS
> [    9.411529] smsc95xx 1-1.1:1.0 eth0: MII is busy in smsc95xx_mdio_=
read
> [    9.422729] smsc95xx 1-1.1:1.0 eth0: Failed to write reg index 0x0=
0000100: -71
> [    9.430480] smsc95xx 1-1.1:1.0 eth0: link reset failed (-71) usbne=
t usb-4a064c00.ehci-1.1, smsc95xx USB 2.0 Ethernet
> [  254.893829] usb 1-1.1: USB disconnect, device number 3
> [  254.905975] smsc95xx 1-1.1:1.0 eth0: unregister 'smsc95xx' usb-4a0=
64c00.ehci-1.1, smsc95xx USB 2.0 Ethernet
> [  254.905975] smsc95xx 1-1.1:1.0 eth0: hardware isn't capable of rem=
ote wakeup
> [  255.212585] usb 1-1: reset high-speed USB device number 2 using eh=
ci-omap
> [  255.520080] usb 1-1: device descriptor read/64, error -71
> [  256.664794] usb 1-1: device descriptor read/64, error -71
> [  256.945129] usb 1-1: reset high-speed USB device number 2 using eh=
ci-omap
> [  257.464782] usb 1-1: device descriptor read/64, error -71
> [  258.544799] usb 1-1: device descriptor read/64, error -71
> [  258.774780] usb 1-1: reset high-speed USB device number 2 using eh=
ci-omap
> [  259.374816] usb 1-1: device not accepting address 2, error -71
> [  259.600677] usb 1-1: reset high-speed USB device number 2 using eh=
ci-omap
> [  260.350799] usb 1-1: device not accepting address 2, error -71
> [  260.464782] hub 1-1:1.0: activate --> -19
> [  260.469238] usb 1-1: USB disconnect, device number 2
> [  260.605133] usb 1-1: new high-speed USB device number 4 using ehci=
-omap
> [  260.883819] usb 1-1: device descriptor read/64, error -71
> [  262.784790] usb 1-1: device descriptor read/64, error -71
> [  263.084320] usb 1-1: new high-speed USB device number 5 using ehci=
-omap
> [  264.763946] usb 1-1: device descriptor read/64, error -71
> [  265.655029] usb 1-1: device descriptor read/64, error -71
> [  265.914978] usb 1-1: new high-speed USB device number 6 using ehci=
-omap
> [  266.633605] usb 1-1: device not accepting address 6, error -71
> [  266.804779] usb 1-1: new high-speed USB device number 7 using ehci=
-omap
> [  267.304779] usb 1-1: device not accepting address 7, error -71
> [  267.311065] hub 1-0:1.0: unable to enumerate USB device on port 1
> [  282.028167] VFS: Unable to mount root fs via NFS, trying floppy.
> [  282.035308] VFS: Cannot open root device "nfs" or unknown-block(2,=
0): error -6
> [  282.043395] Please append a correct "root=3D" boot option; here ar=
e the available partitions:
> [  282.052307] b300         3858432 mmcblk0  driver: mmcblk
> [  282.056610]   b301           40131 mmcblk0p1 00000000-01
> [  282.056610]   b302         3815437 mmcblk0p2 00000000-02
> [  282.069335] Kernel panic - not syncing: VFS: Unable to mount root =
fs on unknown-block(2,0)
> [  282.078643] CPU1: stopping
> [  282.081665] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.11.0-rc2 #=
2
> [  282.088378] [<c001cd00>] (unwind_backtrace+0x0/0xf4) from [<c0018b=
9c>] (show_stack+0x10/0x14)
> [  282.088378] [<c0018b9c>] (show_stack+0x10/0x14) from [<c0570350>] =
(dump_stack+0x70/0x90)
> [  282.088378] [<c0570350>] (dump_stack+0x70/0x90) from [<c001a1bc>] =
(handle_IPI+0x10c/0x134)
> [  282.114898] [<c001a1bc>] (handle_IPI+0x10c/0x134) from [<c0008698>=
] (gic_handle_irq+0x58/0x60)
> [  282.124084] [<c0008698>] (gic_handle_irq+0x58/0x60) from [<c05757a=
4>] (__irq_svc+0x44/0x5c)
> [  282.124084] Exception stack(0xed8a7f78 to 0xed8a7fc0)
> [  282.124084] 7f60:                                                 =
      00056c26 00000001
> [  282.124084] 7f80: 00000000 ed8a5480 ed8a6000 00000000 c0888270 000=
00003 c0581740 c088827c
> [  282.155761] 7fa0: c07f89a8 c0887cee 00000001 ed8a7fc0 00056c27 c00=
162e0 20000113 ffffffff
> [  282.155761] [<c05757a4>] (__irq_svc+0x44/0x5c) from [<c00162e0>] (=
arch_cpu_idle+0x20/0x44)
> [  282.173278] [<c00162e0>] (arch_cpu_idle+0x20/0x44) from [<c008ea4c=
>] (cpu_startup_entry+0xa8/0x1ec)
> [  282.173278] [<c008ea4c>] (cpu_startup_entry+0xa8/0x1ec) from [<800=
081bc>] (0x800081bc)
>=20
>=20
>=20
>=20
>=20
>=20
> =E5=9C=A8 2013-07-22 16:20:40=EF=BC=8C"Roger Quadros" <rogerq@ti.com>=
 =E5=86=99=E9=81=93=EF=BC=9A
>>Hi,
>>
>>On 07/22/2013 11:17 AM, =E8=8F=B2 =E5=BE=90 wrote:
>>> Hi all:
>>>=20
>>> I met a problem about USB Ethernet on panda board with kernel 3.10 =
=2E  USB Ethernet can be detected  when device tree enabled but failed =
to connect to network.
>>
>>We don't yet support USB Host on panda with DT boot on 3.10.  It shou=
ld work with non-DT boot.
>>
>>It will work on 3.11-rc1 with this patch on top https://lkml.org/lkml=
/2013/6/18/492
>>
>>Hopefully it should work out of the box from 3.11-rc2 onwards.
>>
>>cheers,
>>-roger
>>
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
