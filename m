From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/11] ARM: OMAP2+: CM cleanup series
Date: Fri, 11 Oct 2013 17:09:42 -0700
Message-ID: <20131012000942.GH29913@atomide.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:39368 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540Ab3JLAJq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 20:09:46 -0400
Content-Disposition: inline
In-Reply-To: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@linaro.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [131011 09:24]:
>=20
> If someone could verify the omap2 changes, that would be nice.

Seems to boot on my n800 just fine, dmesg below.

Tony


[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.12.0-rc4-00050-gf44928c (tmlind@muffinss=
i) (gcc version 4.3.5 (Debian 4.3.5-4) ) #245 Fri Oct 11 17:03:03 PDT 2=
013
[    0.000000] CPU: ARMv6-compatible processor [4107b362] revision 2 (A=
RMv6TEJ), cr=3D00c5387d
[    0.000000] CPU: VIPT aliasing data cache, VIPT aliasing instruction=
 cache
[    0.000000] Machine: Nokia N800
[    0.000000] Ignoring unrecognised tag 0x414f4d50
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 32768
[    0.000000] free_area_init_node: node 0, pgdat c075891c, node_mem_ma=
p c0cb9000
[    0.000000]   Normal zone: 256 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 32768 pages, LIFO batch:7
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] OMAP2420
[    0.000000]=20
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
[    0.000000] pcpu-alloc: [0] 0=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  =
Total pages: 32512
[    0.000000] Kernel command line: root=3D/dev/mmcblk0p2 rootwait cons=
ole=3DttyO2,115200 earlyprintk ignore_loglevel
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 =
bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 by=
tes)
[    0.000000] Memory: 116864K/131072K available (5069K kernel code, 34=
4K rwdata, 1812K rodata, 271K init, 5489K bss, 14208K reserved, 0K high=
mem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc06c06d0   (6882 kB)
[    0.000000]       .init : 0xc06c1000 - 0xc0704ddc   ( 272 kB)
[    0.000000]       .data : 0xc0706000 - 0xc075c200   ( 345 kB)
[    0.000000]        .bss : 0xc075c200 - 0xc0cb8808   (5490 kB)
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa0fe000 (revision 2.0) with 96 =
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] Clocking rate (Crystal/DPLL/MPU): 19.2/658/329 MHz
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000000] omap2_sync32k_clocksource_init: failed to get counter_32=
k resource
[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns, w=
raps every 4294967286ms
[    0.000000] hw-breakpoint: CPUID feature registers not supported. As=
suming v6 debug is present.
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
[    0.070000] Calibrating delay loop... 217.49 BogoMIPS (lpj=3D1087488=
)
[    0.150000] pid_max: default: 32768 minimum: 301
[    0.150000] Security Framework initialized
[    0.160000] Mount-cache hash table entries: 512
[    0.170000] CPU: Testing write buffer coherency: ok
[    0.180000] Setting up static identity map for 0xc04d3518 - 0xc04d35=
88
[    0.210000] VFP support v0.3: implementor 41 architecture 1 part 20 =
variant b rev 2
[    0.260000] pinctrl core: initialized pinctrl subsystem
[    0.280000] regulator-dummy: no parameters
[    0.290000] NET: Registered protocol family 16
[    0.300000] DMA: preallocated 256 KiB pool for atomic coherent alloc=
ations
[    0.310000] omap-gpmc omap-gpmc: GPMC revision 2.0
[    0.340000] omap_gpio omap_gpio.0: Could not get gpio dbck
[    0.350000] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.360000] OMAP GPIO hardware version 1.8
[    0.360000] omap_gpio omap_gpio.1: Could not get gpio dbck
[    0.370000] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.380000] omap_gpio omap_gpio.2: Could not get gpio dbck
[    0.390000] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.400000] omap_gpio omap_gpio.3: Could not get gpio dbck
[    0.410000] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.440000] omap_mux_init: Add partition: #1: core, flags: b
[    0.510000]  mmci-omap.0: alias fck already exists
[    0.530000] TUSB 6010
[    0.530000] hw-breakpoint: found 6 breakpoint and 1 watchpoint regis=
ters.
[    0.540000] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.590000] OMAP DMA hardware revision 2.0
[    0.600000] Missing cpus node, bailing out
[    0.830000] bio: create slab <bio-0> at 0
[    1.100000] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    1.120000] SCSI subsystem initialized
[    1.130000] usbcore: registered new interface driver usbfs
[    1.140000] usbcore: registered new interface driver hub
[    1.150000] usbcore: registered new device driver usb
[    1.170000] omap_i2c omap_i2c.1: bus 1 rev3.3 at 400 kHz
[    1.180000] omap_i2c omap_i2c.2: bus 2 rev3.3 at 400 kHz
[    1.560000] NET: Registered protocol family 2
[    1.570000] TCP established hash table entries: 1024 (order: 1, 8192=
 bytes)
[    1.580000] TCP bind hash table entries: 1024 (order: 3, 36864 bytes=
)
[    1.590000] TCP: Hash tables configured (established 1024 bind 1024)
[    1.600000] TCP: reno registered
[    1.600000] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    1.610000] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    1.620000] NET: Registered protocol family 1
[    1.630000] RPC: Registered named UNIX socket transport module.
[    1.630000] RPC: Registered udp transport module.
[    1.640000] RPC: Registered tcp transport module.
[    1.640000] RPC: Registered tcp NFSv4.1 backchannel transport module=
=2E
[    1.660000] NetWinder Floating Point Emulator V0.97 (double precisio=
n)
[    1.660000] CPU PMU: probing PMU on CPU 0
[    1.670000] hw perfevents: enabled with v6 PMU driver, 3 counters av=
ailable
[    2.230000] VFS: Disk quotas dquot_6.5.2
[    2.230000] Dquot-cache hash table entries: 1024 (order 0, 4096 byte=
s)
[    2.250000] NFS: Registering the id_resolver key type
[    2.250000] Key type id_resolver registered
[    2.260000] Key type id_legacy registered
[    2.260000] jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 R=
ed Hat, Inc.
[    2.270000] msgmni has been set to 228
[    2.290000] io scheduler noop registered
[    2.290000] io scheduler deadline registered
[    2.300000] io scheduler cfq registered (default)
[    2.310000] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.340000] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 88, base_=
baud =3D 3000000) is a OMAP UART0
[    2.360000] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 89, base_=
baud =3D 3000000) is a OMAP UART1
[    2.370000] omap_uart.2: ttyO2 at MMIO 0x4806e000 (irq =3D 90, base_=
baud =3D 3000000) is a OMAP UART2
[    2.380000] console [ttyO2] enabled, bootconsole disabled
[    2.380000] console [ttyO2] enabled, bootconsole disabled
[    2.400000] omap_rng omap_rng: OMAP Random Number Generator ver. 40
[    2.500000] brd: module loaded
[    2.550000] loop: module loaded
[    2.560000] Menelaus rev 2.2
[    2.600000] mtdoops: mtd device (mtddev=3Dname/number) must be suppl=
ied
[    2.610000] omap2-onenand omap2-onenand: initializing on CS0, phys b=
ase 0x04000000, virtual base c88c0000, freq 54 MHz
[    2.620000] OneNAND Manufacturer: Samsung (0xec)
[    2.620000] Muxed OneNAND(DDP) 256MB 1.8V 16-bit (0x48)
[    2.630000] OneNAND version =3D 0x0011
[    2.630000] Chip support all block unlock
[    2.640000] onenand_wait: controller error! state 15 ctrl 0x0400 int=
r 0x8000
[    2.650000] Scanning device for bad blocks
[    2.910000] Creating 5 MTD partitions on "omap2-onenand":
[    2.920000] 0x000000000000-0x000000020000 : "bootloader"
[    2.940000] 0x000000020000-0x000000080000 : "config"
[    2.960000] 0x000000080000-0x000000280000 : "kernel"
[    2.970000] 0x000000280000-0x000000680000 : "initfs"
[    2.990000] 0x000000680000-0x000010000000 : "rootfs"
[    3.040000] omap-dma-engine omap-dma-engine: allocating channel for =
44
[    3.050000] omap-dma-engine omap-dma-engine: allocating channel for =
43
[    3.080000] usbcore: registered new interface driver asix
[    3.090000] usbcore: registered new interface driver ax88179_178a
[    3.100000] usbcore: registered new interface driver cdc_ether
[    3.100000] usbcore: registered new interface driver r815x
[    3.110000] usbcore: registered new interface driver smsc95xx
[    3.120000] usbcore: registered new interface driver net1080
[    3.130000] usbcore: registered new interface driver cdc_subset
[    3.140000] usbcore: registered new interface driver zaurus
[    3.140000] usbcore: registered new interface driver cdc_ncm
[    3.150000] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driv=
er
[    3.160000] ehci_hcd: block sizes: qh 64 qtd 96 itd 160 sitd 96
[    3.170000] ehci-omap: OMAP-EHCI Host Controller driver
[    3.180000] usbcore: registered new interface driver cdc_wdm
[    3.180000] usbcore: registered new interface driver usb-storage
[    3.190000] usbcore: registered new interface driver usbtest
[    3.230000] tusb: prcm2.0 int2.0 gpio3.0 dma3.0 dieid2 rev3.1
[    3.230000] drivers/usb/musb/tusb6010.c tusb_musb_disable: dma still=
 active
[    3.240000] musb-hdrc: ConfigData=3D0x06 (UTMI-8, dyn FIFOs, SoftCon=
n)
[    3.250000] musb-hdrc: MHDRC RTL version 1.400=20
[    3.250000] musb-hdrc: setup fifo_mode 4
[    3.260000] musb-hdrc: 28/31 max ep, 16384/16384 memory
[    3.260000] musb-hdrc musb-hdrc.0.auto: MUSB HDRC host driver
[    3.280000] musb-hdrc musb-hdrc.0.auto: new USB bus registered, assi=
gned bus number 1
[    3.280000] musb-hdrc musb-hdrc.0.auto: supports USB remote wakeup
[    3.300000] usb usb1: default language 0x0409
[    3.300000] usb usb1: udev 1, busnum 1, minor =3D 0
[    3.310000] usb usb1: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002
[    3.310000] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    3.320000] usb usb1: Product: MUSB HDRC host driver
[    3.330000] usb usb1: Manufacturer: Linux 3.12.0-rc4-00050-gf44928c =
musb-hcd
[    3.330000] usb usb1: SerialNumber: musb-hdrc.0.auto
[    3.350000] usb usb1: usb_probe_device
[    3.350000] usb usb1: configuration #1 chosen from 1 choice
[    3.360000] usb usb1: adding 1-0:1.0 (config #1, interface 0)
[    3.370000] hub 1-0:1.0: usb_probe_interface
[    3.370000] hub 1-0:1.0: usb_probe_interface - got id
[    3.380000] hub 1-0:1.0: USB hub found
[    3.380000] hub 1-0:1.0: 1 port detected
[    3.390000] hub 1-0:1.0: standalone hub
[    3.390000] hub 1-0:1.0: individual port power switching
[    3.400000] hub 1-0:1.0: no over-current protection
[    3.400000] hub 1-0:1.0: Single TT
[    3.410000] hub 1-0:1.0: TT requires at most 8 FS bit times (666 ns)
[    3.410000] hub 1-0:1.0: power on to power good time: 10ms
[    3.420000] hub 1-0:1.0: 200mA bus power budget for each child
[    3.430000] hub 1-0:1.0: local power source is good
[    3.440000] hub 1-0:1.0: enabling power on all ports
[    3.440000] drivers/usb/musb/tusb6010.c tusb_musb_enable: dma not re=
activated
[    3.470000] udc musb-hdrc.0.auto: registering UDC driver [g_ether]
[    3.480000] using random self ethernet address
[    3.480000] using random host ethernet address
[    3.490000] usb0: HOST MAC b2:a6:82:3d:61:d2
[    3.500000] usb0: MAC ba:a4:f3:92:f4:6a
[    3.500000] using random self ethernet address
[    3.510000] using random host ethernet address
[    3.510000] g_ether gadget: adding config #2 'RNDIS'/c074c92c
[    3.520000] rndis_register: configNr =3D 0
[    3.520000] g_ether gadget: adding 'rndis'/c7b379c0 to config 'RNDIS=
'/c074c92c
[    3.530000] rndis_set_param_medium: 0 0
[    3.540000] g_ether gadget: RNDIS: dual speed IN/ep1in OUT/ep1out NO=
TIFY/ep2in
[    3.540000] g_ether gadget: cfg 2/c074c92c speeds: high full
[    3.550000] g_ether gadget:   interface 0 =3D rndis/c7b379c0
[    3.560000] g_ether gadget:   interface 1 =3D rndis/c7b379c0
[    3.560000] g_ether gadget: adding config #1 'CDC Ethernet (EEM)'/c0=
74c8b8
[    3.570000] g_ether gadget: adding 'cdc_eem'/c7b37900 to config 'CDC=
 Ethernet (EEM)'/c074c8b8
[    3.580000] g_ether gadget: CDC Ethernet (EEM): dual speed IN/ep1in =
OUT/ep1out
[    3.590000] g_ether gadget: cfg 1/c074c8b8 speeds: high full
[    3.590000] g_ether gadget:   interface 0 =3D cdc_eem/c7b37900
[    3.600000] g_ether gadget: Ethernet Gadget, version: Memorial Day 2=
008
[    3.610000] g_ether gadget: g_ether ready
[    3.620000] mousedev: PS/2 mouse device common for all mice
[    3.640000] i2c /dev entries driver
[    3.670000] retu-mfd 3-0001: Retu & Vilma v1.5 found
[    3.690000] input: retu-pwrbutton as /devices/platform/i2c-cbus-gpio=
=2E3/i2c-3/3-0001/retu-pwrbutton/input/input0
[    3.710000] Driver for 1-wire Dallas network protocol.
[    3.720000] omap_wdt: OMAP Watchdog Timer Rev 0x11: initial timeout =
60 sec
[    3.740000] omap-dma-engine omap-dma-engine: allocating channel for =
61
[    3.750000] omap-dma-engine omap-dma-engine: allocating channel for =
62
[    3.760000] hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0000
[    3.770000] hub 1-0:1.0: hub_suspend
[    3.770000] usb usb1: bus auto-suspend, wakeup 1
[    3.890000] mmci-omap mmci-omap.0: command timeout (CMD52)
[    3.900000] mmci-omap mmci-omap.0: command timeout (CMD52)
[    3.930000] mmci-omap mmci-omap.0: command timeout (CMD5)
[    3.930000] mmci-omap mmci-omap.0: command timeout (CMD5)
[    3.940000] mmci-omap mmci-omap.0: command timeout (CMD5)
[    3.950000] mmci-omap mmci-omap.0: command timeout (CMD5)
[    3.970000] usbcore: registered new interface driver usbhid
[    3.980000] usbhid: USB HID core driver
[    3.990000] oprofile: using arm/armv6
[    3.990000] TCP: cubic registered
[    4.000000] Initializing XFRM netlink socket
[    4.000000] NET: Registered protocol family 17
[    4.010000] NET: Registered protocol family 15
[    4.010000] Key type dns_resolver registered
[    4.030000] mux: Failed to setup hwmod io irq -22
[    4.040000] Power Management for OMAP2 initializing
[    4.050000] PRCM revision 1.0
[    4.070000] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    4.090000] Waiting for root device /dev/mmcblk0p2...
[    4.110000] mmc0: host does not support reading read-only switch. as=
suming write-enable.
[    4.120000] mmc0: new SDHC card at address ea4d
[    4.130000] mmcblk0: mmc0:ea4d SU04G 3.79 GiB=20
[    4.150000]  mmcblk0: p1 p2
[    4.160000] mmci-omap mmci-omap.0: command timeout (CMD52)
[    4.170000] mmci-omap mmci-omap.0: command timeout (CMD52)
[    4.180000] mmci-omap mmci-omap.0: command timeout (CMD8)
[    4.190000] mmci-omap mmci-omap.0: command timeout (CMD5)
[    4.190000] mmci-omap mmci-omap.0: command timeout (CMD5)
[    4.210000] mmci-omap mmci-omap.0: command timeout (CMD5)
[    4.220000] mmci-omap mmci-omap.0: command timeout (CMD5)
[    4.230000] mmci-omap mmci-omap.0: command timeout (CMD8)
[    4.320000] mmc1: SD Status: Invalid Allocation Unit size.
[    4.330000] mmc1: host does not support reading read-only switch. as=
suming write-enable.
[    4.340000] mmc1: new SD card at address e624
[    4.370000] mmcblk1: mmc1:e624 SD128 120 MiB=20
[    4.390000]  mmcblk1: p1
[    5.790000] kjournald starting.  Commit interval 5 seconds
[    5.800000] EXT3-fs (mmcblk0p2): warning: maximal mount count reache=
d, running e2fsck is recommended
[    5.960000] EXT3-fs (mmcblk0p2): using internal journal
[    5.970000] EXT3-fs (mmcblk0p2): recovery complete
[    5.980000] EXT3-fs (mmcblk0p2): mounted filesystem with ordered dat=
a mode
[    5.990000] VFS: Mounted root (ext3 filesystem) on device 179:2.
[    6.000000] Freeing unused kernel memory: 268K (c06c1000 - c0704000)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
