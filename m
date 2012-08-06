From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP3 Overo: Crash on boot with Linus' master
Date: Mon, 06 Aug 2012 13:38:24 +0300
Message-ID: <1344249504.12136.3.camel@deskari>
References: <1343903452.2686.15.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-armmcGv9ct5MUcBuU6Js"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:42963 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755826Ab2HFKie (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Aug 2012 06:38:34 -0400
Received: by lago2 with SMTP id o2so3074895lag.1
        for <linux-omap@vger.kernel.org>; Mon, 06 Aug 2012 03:38:31 -0700 (PDT)
In-Reply-To: <1343903452.2686.15.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: tarun.kanti@ti.com, Kevin Hilman <khilman@ti.com>, Arnd Bergmann <arnd@arndb.de>


--=-armmcGv9ct5MUcBuU6Js
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This problem exists on v3.6-rc1 also. I bisected the crash below to:

f1d2c07d331f717da79a42952be7dc1c0d35f846=20

It's a merge commit, Merge tag 'boards' of
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc

I'm not sure why bisect did came up with a merge commit, instead of the
actual code commit, though.

I don't see any changes in overo's board file that could cause this, so
could it be an omap3 wide problem? Although I would think somebody else
had noticed it also, then.

 Tomi

On Thu, 2012-08-02 at 13:30 +0300, Tomi Valkeinen wrote:
> Hi,
>=20
> I'm unable to boot with Linus' master branch from today on OMAP3 Overo
> board. Below is the full boot log. Something related to GPIOs and IRQs,
> perhaps. I've also attached my kernel conf. OMAP4 Blaze works ok, and
> kernel v3.5 works ok.
>=20
> The crash looks very similar to what is mentioned in a post from March
> "GPIO abort on 3630/Zoom3".
>=20
>  Tomi
>=20
>=20
> =04=01=EF=BF=BD=06t=EF=BF=BDb=01PH=EF=BF=BDUI=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=17=EF=BF=BD**S=EF=BF=BD=EF=BF=BD012.04.01-00958-g7d2d58b (Jun 26 2012 - 10=
:37:53)
> OMAP SD/MMC: 0
> reading u-boot.img
> reading u-boot.img
>=20
>=20
> U-Boot 2012.04.01-00958-g7d2d58b (Jun 26 2012 - 10:37:53)
>=20
> OMAP3503-GP ES2.1, CPU-OPP2, L3-165MHz, Max CPU Clock 600 mHz
> Gumstix Overo board + LPDDR/NAND
> I2C:   ready
> DRAM:  256 MiB
> NAND:  256 MiB
> MMC:   OMAP SD/MMC: 0
> In:    serial
> Out:   serial
> Err:   serial
> Board revision: 0
> Direct connection on mmc2
> No EEPROM on expansion board
> Die ID #496800020000000004013ef00a01100a
> Net:   No ethernet found.
> Hit any key to stop autoboot:  3 =08=08=08 2 =08=08=08 1 =08=08=08 0=20
> reading uImage
>=20
> 4107144 bytes read
> ## Booting kernel from Legacy Image at 82000000 ...
>    Image Name:   Linux-3.5.0-09139-g1a9b499
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    4107080 Bytes =3D 3.9 MiB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK
>=20
> Starting kernel ...
>=20
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Booting Linux on physical CPU 0
> [    0.000000] Linux version 3.5.0-09139-g1a9b499 (tomba@deskari) (gcc ve=
rsion 4.5.1 (Sourcery G++ Lite 2010.09-50) ) #12 SMP Thu Aug 2 13:20:08 EES=
T 2012
> [    0.000000] CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=3D1=
0c53c7d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing =
instruction cache
> [    0.000000] Machine: Gumstix Overo
> [    0.000000] Reserving 10485760 bytes SDRAM for VRAM
> [    0.000000] Memory policy: ECC disabled, Data cache writeback
> [    0.000000] On node 0 totalpages: 62720
> [    0.000000] free_area_init_node: node 0, pgdat c07dc800, node_mem_map =
c0d38000
> [    0.000000]   Normal zone: 512 pages used for memmap
> [    0.000000]   Normal zone: 0 pages reserved
> [    0.000000]   Normal zone: 62208 pages, LIFO batch:15
> [    0.000000] OMAP3503 ES2.1 (l2cache neon isp )
> [    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/600 MHz
> [    0.000000] PERCPU: Embedded 9 pages/cpu @c0f3e000 s12736 r8192 d15936=
 u36864
> [    0.000000] pcpu-alloc: s12736 r8192 d15936 u36864 alloc=3D9*4096
> [    0.000000] pcpu-alloc: [0] 0=20
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  To=
tal pages: 62208
> [    0.000000] Kernel command line: g_ether.host_addr=3D86:6a:a8:ad:e0:78=
 g_ether.dev_addr=3D02:51:c6:e2:c3:d3 console=3DttyO2,115200 root=3D/dev/nf=
s nfsroot=3D/tftpboot/rootfs,tcp,nolock,rsize=3D1024,wsize=3D1024 ip=3D192.=
168.2.15:192.168.2.14::::usb0: vram=3D10M loglevel=3D9 no_console_suspend
> [    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 b=
ytes)
> [    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 byt=
es)
> [    0.000000] Memory: 245MB =3D 245MB total
> [    0.000000] Memory: 235032k/235032k available, 27112k reserved, 0K hig=
hmem
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
> [    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
> [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
> [    0.000000]       .text : 0xc0008000 - 0xc06f1304   (7077 kB)
> [    0.000000]       .init : 0xc06f2000 - 0xc07401c0   ( 313 kB)
> [    0.000000]       .data : 0xc0742000 - 0xc07df1c0   ( 629 kB)
> [    0.000000]        .bss : 0xc07df1e4 - 0xc0d37c0c   (5475 kB)
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000] 	RCU restricting CPUs from NR_CPUS=3D2 to nr_cpu_ids=3D1.
> [    0.000000] NR_IRQS:474
> [    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 in=
terrupts
> [    0.000000] Total of 96 interrupts on 1 active controller
> [    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
> [    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps e=
very 131071999ms
> [    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
> [    0.000000] Console: colour dummy device 80x30
> [    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc=
., Ingo Molnar
> [    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    0.000000] ... MAX_LOCK_DEPTH:          48
> [    0.000000] ... MAX_LOCKDEP_KEYS:        8191
> [    0.000000] ... CLASSHASH_SIZE:          4096
> [    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
> [    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
> [    0.000000] ... CHAINHASH_SIZE:          16384
> [    0.000000]  memory used by lock dependency info: 3695 kB
> [    0.000000]  per task-struct memory footprint: 1152 bytes
> [    0.000976] Calibrating delay loop... 397.57 BogoMIPS (lpj=3D1554432)
> [    0.109344] pid_max: default: 32768 minimum: 301
> [    0.109924] Security Framework initialized
> [    0.110107] Mount-cache hash table entries: 512
> [    0.115509] CPU: Testing write buffer coherency: ok
> [    0.116516] CPU0: thread -1, cpu 0, socket -1, mpidr 0
> [    0.116638] Setting up static identity map for 0x8050da20 - 0x8050da90
> [    0.119415] Brought up 1 CPUs
> [    0.119445] SMP: Total of 1 processors activated (397.57 BogoMIPS).
> [    0.123138] devtmpfs: initialized
> [    0.145507] dummy:=20
> [    0.147949] NET: Registered protocol family 16
> [    0.149719] DMA: preallocated 256 KiB pool for atomic coherent allocat=
ions
> [    0.150756] GPMC revision 5.0
> [    0.151031] gpmc: irq-20 could not claim: err -22
> [    0.161865] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
> [    0.162445] OMAP GPIO hardware version 2.5
> [    0.164367] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
> [    0.166564] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
> [    0.168365] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
> [    0.170043] gpiochip_add: registered GPIOs 128 to 159 on device: gpio
> [    0.171722] gpiochip_add: registered GPIOs 160 to 191 on device: gpio
> [    0.181427] omap_mux_init: Add partition: #1: core, flags: 0
> [    0.209991] Reprogramming SDRC clock to 332000000 Hz
> [    0.210113] Found NAND on CS0
> [    0.210113] Registering NAND on CS0
> [    0.213317]  usbhs_omap: alias fck already exists
> [    0.229705] hw-breakpoint: debug architecture 0x4 unsupported.
> [    0.247924]  omap-mcbsp.2: alias fck already exists
> [    0.248931]  omap-mcbsp.3: alias fck already exists
> [    0.254699] OMAP DMA hardware revision 4.0
> [    0.341369] bio: create slab <bio-0> at 0
> [    0.449920] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
> [    0.451080] fixed-dummy:=20
> [    0.452423] vads7846: 3300 mV=20
> [    0.459320] SCSI subsystem initialized
> [    0.462860] usbcore: registered new interface driver usbfs
> [    0.463531] usbcore: registered new interface driver hub
> [    0.464538] usbcore: registered new device driver usb
> [    0.472167] omap_i2c omap_i2c.1: bus 1 rev1.3.12 at 2600 kHz
> [    0.482482] twl 1-0048: PIH (irq 7) chaining IRQs 320..328
> [    0.483245] twl 1-0048: power (irq 325) chaining IRQs 328..335
> [    0.486480] twl4030_gpio twl4030_gpio: gpio (irq 320) chaining IRQs 33=
6..353
> [    0.488037] gpiochip_add: registered GPIOs 192 to 211 on device: twl40=
30
> [    0.491241] VUSB1V5: 1500 mV normal standby
> [    0.494079] VUSB1V8: 1800 mV normal standby
> [    0.496337] VUSB3V1: 3100 mV normal standby
> [    0.501953] twl4030_usb twl4030_usb: HW_CONDITIONS 0xd0/208; link 3
> [    0.506072] musb-omap2430 musb-omap2430: musb core is not yet ready
> [    0.506225] twl4030_usb twl4030_usb: Initialized TWL4030 USB module
> [    0.511413] vdd_mpu_iva: 600 <--> 1450 mV normal=20
> [    0.513763] vdd_core: 600 <--> 1450 mV normal=20
> [    0.516601] VMMC1: 1850 <--> 3150 mV at 3150 mV normal standby
> [    0.519226] VDAC: 1800 mV normal standby
> [    0.521667] VDVI: 1800 mV normal standby
> [    0.522979] omap_i2c omap_i2c.3: bus 3 rev1.3.12 at 400 kHz
> [    0.533843] Switching to clocksource 32k_counter
> [    0.705017] usbhs_omap usbhs_omap: xclk60mhsp2_ck set parentfailed err=
or:-22
> [    0.709075] NET: Registered protocol family 2
> [    0.711517] TCP established hash table entries: 8192 (order: 4, 65536 =
bytes)
> [    0.711975] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
> [    0.716888] TCP: Hash tables configured (established 8192 bind 8192)
> [    0.717163] TCP: reno registered
> [    0.717193] UDP hash table entries: 256 (order: 2, 20480 bytes)
> [    0.717529] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
> [    0.718536] NET: Registered protocol family 1
> [    0.720092] RPC: Registered named UNIX socket transport module.
> [    0.720123] RPC: Registered udp transport module.
> [    0.720153] RPC: Registered tcp transport module.
> [    0.720153] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    0.721588] NetWinder Floating Point Emulator V0.97 (double precision)
> [    0.905181] VFS: Disk quotas dquot_6.5.2
> [    0.905487] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> [    0.908721] NFS: Registering the id_resolver key type
> [    0.909332] Key type id_resolver registered
> [    0.909606] Key type id_legacy registered
> [    0.909851] jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 Red=
 Hat, Inc.
> [    0.910552] msgmni has been set to 459
> [    0.914886] io scheduler noop registered
> [    0.914916] io scheduler deadline registered
> [    0.915008] io scheduler cfq registered (default)
> [    0.917419] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    0.926910] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is a OM=
AP UART0
> [    0.929290] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73) is a OM=
AP UART1
> [    0.930999] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74) is a OM=
AP UART2
> [    1.731506] console [ttyO2] enabled
> [    1.778930] brd: module loaded
> [    1.807098] loop: module loaded
> [    1.819458] mtdoops: mtd device (mtddev=3Dname/number) must be supplie=
d
> [    1.827484] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron =
NAND 256MiB 1,8V 16-bit), page size: 2048, OOB size: 64
> [    1.839538] Creating 5 MTD partitions on "omap2-nand.0":
> [    1.845153] 0x000000000000-0x000000080000 : "xloader"
> [    1.859710] 0x000000080000-0x000000240000 : "uboot"
> [    1.872589] 0x000000240000-0x000000280000 : "uboot environment"
> [    1.885009] 0x000000280000-0x000000680000 : "linux"
> [    1.899200] 0x000000680000-0x000010000000 : "rootfs"
> [    2.128631] OneNAND driver initializing
> [    2.138000] omap-dma-engine omap-dma-engine: allocating channel for 36
> [    2.145294] omap-dma-engine omap-dma-engine: allocating channel for 35
> [    2.153991] omap-dma-engine omap-dma-engine: allocating channel for 38
> [    2.161132] omap-dma-engine omap-dma-engine: allocating channel for 37
> [    2.178894] smsc911x: Driver version 2008-10-21
> [    2.186065] smsc911x: Driver version 2008-10-21
> [    2.193664] usbcore: registered new interface driver asix
> [    2.200286] usbcore: registered new interface driver cdc_ether
> [    2.207336] usbcore: registered new interface driver smsc95xx
> [    2.213989] usbcore: registered new interface driver net1080
> [    2.220672] usbcore: registered new interface driver cdc_subset
> [    2.227661] usbcore: registered new interface driver zaurus
> [    2.234313] usbcore: registered new interface driver cdc_ncm
> [    2.242401] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    2.249450] ehci_hcd: block sizes: qh 60 qtd 96 itd 160 sitd 96
> [    2.256195] ehci-omap ehci-omap.0: failed to get ehci port1 regulator
> [    2.263214] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
> [    2.272521] ehci-omap ehci-omap.0: new USB bus registered, assigned bu=
s number 1
> [    3.284393] ehci-omap ehci-omap.0: phy reset operation timed out
> [    3.290710] ehci-omap ehci-omap.0: reset hcs_params 0x1313 dbg=3D0 cc=
=3D1 pcc=3D3 ordered ports=3D3
> [    3.299560] ehci-omap ehci-omap.0: reset hcc_params 0016 thresh 1 ufra=
mes 256/512/1024 park
> [    3.308807] ehci-omap ehci-omap.0: park 0
> [    3.313171] ehci-omap ehci-omap.0: reset command 0080b02  park=3D3 ith=
resh=3D8 period=3D1024 Reset HALT
> [    3.322601] ehci-omap ehci-omap.0: ...powerup ports...
> [    3.354888] ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
> [    3.360870] ehci-omap ehci-omap.0: init command 0010005 (park)=3D0 ith=
resh=3D1 period=3D512 RUN
> [    3.378295] ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
> [    3.385467] usb usb1: default language 0x0409
> [    3.390289] usb usb1: udev 1, busnum 1, minor =3D 0
> [    3.395294] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
> [    3.402496] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
> [    3.410125] usb usb1: Product: OMAP-EHCI Host Controller
> [    3.415710] usb usb1: Manufacturer: Linux 3.5.0-09139-g1a9b499 ehci_hc=
d
> [    3.422729] usb usb1: SerialNumber: ehci-omap.0
> [    3.430877] usb usb1: usb_probe_device
> [    3.434936] usb usb1: configuration #1 chosen from 1 choice
> [    3.441528] usb usb1: adding 1-0:1.0 (config #1, interface 0)
> [    3.449157] hub 1-0:1.0: usb_probe_interface
> [    3.453674] hub 1-0:1.0: usb_probe_interface - got id
> [    3.459167] hub 1-0:1.0: USB hub found
> [    3.463317] hub 1-0:1.0: 3 ports detected
> [    3.467620] hub 1-0:1.0: standalone hub
> [    3.471649] hub 1-0:1.0: individual port power switching
> [    3.477294] hub 1-0:1.0: individual port over-current protection
> [    3.483673] hub 1-0:1.0: power on to power good time: 20ms
> [    3.489929] hub 1-0:1.0: local power source is good
> [    3.495086] hub 1-0:1.0: enabling power on all ports
> [    3.503326] usbcore: registered new interface driver cdc_wdm
> [    3.509307] Initializing USB Mass Storage driver...
> [    3.515319] usbcore: registered new interface driver usb-storage
> [    3.521728] USB Mass Storage support registered.
> [    3.528076] usbcore: registered new interface driver libusual
> [    3.535034] usbcore: registered new interface driver usbtest
> [    3.540985] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
> [    3.547729] musb-hdrc: ConfigData=3D0xde (UTMI-8, dyn FIFOs, bulk comb=
ine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
> [    3.559051] musb-hdrc: MHDRC RTL version 1.400=20
> [    3.563812] musb-hdrc: setup fifo_mode 4
> [    3.567993] musb-hdrc: 28/31 max ep, 16384/16384 memory
> [    3.576324] musb-hdrc musb-hdrc: USB OTG mode controller at fa0ab000 u=
sing PIO, IRQ 92
> [    3.587341] twl4030_usb twl4030_usb: twl4030_phy_suspend
> [    3.593597] udc musb-hdrc: registering UDC driver [g_ether]
> [    3.602050] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
> [    3.610626] usb0: MAC 02:51:c6:e2:c3:d3
> [    3.614776] usb0: HOST MAC 86:6a:a8:ad:e0:78
> [    3.619628]  gadget: adding config #2 'RNDIS'/c07d208c
> [    3.625274]  gadget: adding 'rndis'/ce823840 to config 'RNDIS'/c07d208=
c
> [    3.632324] rndis_register: configNr =3D 0
> [    3.636505] rndis_set_param_medium: 0 0
> [    3.640533]  gadget: RNDIS: dual speed IN/ep1in OUT/ep1out NOTIFY/ep2i=
n
> [    3.647552]  gadget: cfg 2/c07d208c speeds: high full
> [    3.652923]  gadget:   interface 0 =3D rndis/ce823840
> [    3.658050]  gadget:   interface 1 =3D rndis/ce823840
> [    3.663238]  gadget: adding config #1 'CDC Ethernet (ECM)'/c07d1ff0
> [    3.669891]  gadget: adding 'cdc_ethernet'/ce823780 to config 'CDC Eth=
ernet (ECM)'/c07d1ff0
> [    3.678771]  gadget: CDC Ethernet: dual speed IN/ep1in OUT/ep1out NOTI=
FY/ep2in
> [    3.686401]  gadget: cfg 1/c07d1ff0 speeds: high full
> [    3.691772]  gadget:   interface 0 =3D cdc_ethernet/ce823780
> [    3.697540]  gadget:   interface 1 =3D cdc_ethernet/ce823780
> [    3.703338]  gadget: Ethernet Gadget, version: Memorial Day 2008
> [    3.709777]  gadget: g_ether ready
> [    3.718597] twl4030_usb twl4030_usb: twl4030_phy_resume
> [    3.724273] musb-hdrc musb-hdrc: MUSB HDRC host driver
> [    3.731903] musb-hdrc musb-hdrc: new USB bus registered, assigned bus =
number 2
> [    3.739715] musb-hdrc musb-hdrc: supports USB remote wakeup
> [    3.745941] usb usb2: default language 0x0409
> [    3.750610] usb usb2: udev 1, busnum 2, minor =3D 128
> [    3.755828] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
> [    3.763031] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
> [    3.770690] usb usb2: Product: MUSB HDRC host driver
> [    3.775909] usb usb2: Manufacturer: Linux 3.5.0-09139-g1a9b499 musb-hc=
d
> [    3.782897] usb usb2: SerialNumber: musb-hdrc
> [    3.790008] usb usb2: usb_probe_device
> [    3.794128] usb usb2: configuration #1 chosen from 1 choice
> [    3.800292] usb usb2: adding 2-0:1.0 (config #1, interface 0)
> [    3.807586] hub 2-0:1.0: usb_probe_interface
> [    3.812255] hub 2-0:1.0: usb_probe_interface - got id
> [    3.817718] hub 2-0:1.0: USB hub found
> [    3.821838] hub 2-0:1.0: 1 port detected
> [    3.826019] hub 2-0:1.0: standalone hub
> [    3.830078] hub 2-0:1.0: individual port power switching
> [    3.835723] hub 2-0:1.0: no over-current protection
> [    3.840911] hub 2-0:1.0: Single TT
> [    3.844512] hub 2-0:1.0: TT requires at most 8 FS bit times (666 ns)
> [    3.851226] hub 2-0:1.0: power on to power good time: 10ms
> [    3.857086] hub 2-0:1.0: 100mA bus power budget for each child
> [    3.863403] hub 2-0:1.0: local power source is good
> [    3.868560] hub 2-0:1.0: enabling power on all ports
> [    3.878540] mousedev: PS/2 mouse device common for all mice
> [    3.888916] Unhandled fault: external abort on non-linefetch (0x1028) =
at 0xfb054040
> [    3.897003] Internal error: : 1028 [#1] SMP ARM
> [    3.901763] Modules linked in:
> [    3.904998] CPU: 0    Not tainted  (3.5.0-09139-g1a9b499 #12)
> [    3.911041] PC is at _set_gpio_triggering+0x2c/0x264
> [    3.916259] LR is at gpio_irq_type+0xb8/0x160
> [    3.920837] pc : [<c02df8fc>]    lr : [<c02dff1c>]    psr: 20000093
> [    3.920837] sp : cf02ddf8  ip : cf09bec0  fp : ce81339c
> [    3.932891] r10: 00000072  r9 : c074df70  r8 : cf0a1e10
> [    3.938385] r7 : 20000093  r6 : 00000001  r5 : 00000020  r4 : fb054000
> [    3.945220] r3 : cf0a1e10  r2 : 00000002  r1 : 00000012  r0 : 00000040
> [    3.952087] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segm=
ent kernel
> [    3.959838] Control: 10c5387d  Table: 80004019  DAC: 00000017
> [    3.965881] Process swapper/0 (pid: 1, stack limit =3D 0xcf02c2f8)
> [    3.972198] Stack: (0xcf02ddf8 to 0xcf02e000)
> [    3.976776] dde0:                                                     =
  00000002 c074df40
> [    3.985351] de00: cf0a1e6c 20000093 c074dfe4 c074df40 c02dfe64 0000000=
0 c07be320 000000d2
> [    3.993957] de20: 00000002 c00a4cbc c074dfe4 00000000 c074df40 cf3dc70=
0 000000d2 c074df90
> [    4.002532] de40: 40000013 c00a50f0 000000d2 c0685104 cf1be060 cf1be06=
4 ce813000 c03f8034
> [    4.011138] de60: c03f8058 000000d2 c074df40 ce813370 cf3dc700 c00a521=
0 ce82d800 00002002
> [    4.019714] de80: ce818400 ce818400 00000000 c07a8644 ce813000 ce82d80=
0 00002002 c04fe660
> [    4.028320] dea0: c0685104 ce813000 00000000 00000001 cf3dc780 cf3dc78=
c c0d2f83c ce818400
> [    4.036895] dec0: c0d2f83c c0d2f84c 00000000 c07d3274 c073beec c06f21c=
4 00000000 c038656c
> [    4.045501] dee0: c0386554 c03230d8 22222222 ce818400 c07d3274 ce81843=
4 00000000 00000000
> [    4.054077] df00: c06f21c4 c032330c c07d3274 c0323278 00000000 c032188=
0 cf0a10a8 cf382490
> [    4.062652] df20: c07d3274 c07cc9e0 ce8391c0 c03227a4 c0685104 c02c04f=
8 c07d3274 c07df200
> [    4.071258] df40: cf02c000 00000000 00000000 c073beec c06f21c4 c032384=
0 00000000 c0723f3c
> [    4.079833] df60: c07df200 cf02c000 00000000 0000009f c06f21c4 c000872=
4 c06c8550 c06c8f40
> [    4.088439] df80: c0f3b35e c071a3ac 00000001 00000000 c068110c 0000000=
0 00000006 00000006
> [    4.097015] dfa0: 60000013 c0723f3c 00000006 c0723f1c c07df200 0000009=
f c073beec c06f21c4
> [    4.105621] dfc0: 00000000 c06f28fc 00000006 00000006 c06f21c4 0000000=
0 00000000 c06f2800
> [    4.114196] dfe0: c0014ef4 00000013 00000000 00000000 00000000 c0014ef=
4 00fbcf11 01f7de18
> [    4.122802] [<c02df8fc>] (_set_gpio_triggering+0x2c/0x264) from [<c074=
dfe4>] (irq_desc+0x9e24/0x16380)
> [    4.132598] Code: e1dc52b2 e3550000 0a00004c e3a06001 (e794c000)=20
> [    4.139068] ---[ end trace bbbce2218b6cbd16 ]---
> [    4.143951] In-band Error seen by MPU  at address 0
> [    4.149047] ------------[ cut here ]------------
> [    4.153930] WARNING: at arch/arm/mach-omap2/omap_l3_smx.c:162 omap3_l3=
_app_irq+0x104/0x12c()
> [    4.162780] Modules linked in:
> [    4.166046] [<c001b74c>] (unwind_backtrace+0x0/0xf0) from [<c00418fc>]=
 (warn_slowpath_common+0x4c/0x64)
> [    4.175903] [<c00418fc>] (warn_slowpath_common+0x4c/0x64) from [<c0041=
930>] (warn_slowpath_null+0x1c/0x24)
> [    4.186065] [<c0041930>] (warn_slowpath_null+0x1c/0x24) from [<c0035d3=
c>] (omap3_l3_app_irq+0x104/0x12c)
> [    4.196044] [<c0035d3c>] (omap3_l3_app_irq+0x104/0x12c) from [<c00a39a=
0>] (handle_irq_event_percpu+0x5c/0x240)
> [    4.206542] [<c00a39a0>] (handle_irq_event_percpu+0x5c/0x240) from [<c=
00a3bc0>] (handle_irq_event+0x3c/0x5c)
> [    4.216888] [<c00a3bc0>] (handle_irq_event+0x3c/0x5c) from [<c00a61c4>=
] (handle_level_irq+0xac/0x148)
> [    4.226562] [<c00a61c4>] (handle_level_irq+0xac/0x148) from [<c00a31b4=
>] (generic_handle_irq+0x30/0x48)
> [    4.236450] [<c00a31b4>] (generic_handle_irq+0x30/0x48) from [<c0014c5=
8>] (handle_IRQ+0x4c/0xac)
> [    4.245697] [<c0014c58>] (handle_IRQ+0x4c/0xac) from [<c0008580>] (oma=
p3_intc_handle_irq+0x60/0x74)
> [    4.255187] [<c0008580>] (omap3_intc_handle_irq+0x60/0x74) from [<c050=
85e4>] (__irq_svc+0x44/0x5c)
> [    4.264587] Exception stack(0xcf02dc08 to 0xcf02dc50)
> [    4.269897] dc00:                   c07bdca0 00000000 00030003 0000000=
0 c0765a7c 0000000b
> [    4.278503] dc20: cf02fc00 00000014 00000017 00000001 00000000 0000000=
0 00000000 cf02dc50
> [    4.287078] dc40: c0508368 c050836c 60000113 ffffffff
> [    4.292388] [<c05085e4>] (__irq_svc+0x44/0x5c) from [<c050836c>] (_raw=
_spin_unlock_irq+0x28/0x2c)
> [    4.301727] [<c050836c>] (_raw_spin_unlock_irq+0x28/0x2c) from [<c0047=
ea8>] (do_exit+0x5b4/0x80c)
> [    4.311035] [<c0047ea8>] (do_exit+0x5b4/0x80c) from [<c00181d8>] (die+=
0x358/0x404)
> [    4.319000] [<c00181d8>] (die+0x358/0x404) from [<c00083a4>] (do_DataA=
bort+0x8c/0x9c)
> [    4.327239] [<c00083a4>] (do_DataAbort+0x8c/0x9c) from [<c0508564>] (_=
_dabt_svc+0x44/0x80)
> [    4.335906] Exception stack(0xcf02ddb0 to 0xcf02ddf8)
> [    4.341217] dda0:                                     00000040 0000001=
2 00000002 cf0a1e10
> [    4.349792] ddc0: fb054000 00000020 00000001 20000093 cf0a1e10 c074df7=
0 00000072 ce81339c
> [    4.358398] dde0: cf09bec0 cf02ddf8 c02dff1c c02df8fc 20000093 fffffff=
f
> [    4.365356] [<c0508564>] (__dabt_svc+0x44/0x80) from [<c02df8fc>] (_se=
t_gpio_triggering+0x2c/0x264)
> [    4.374847] [<c02df8fc>] (_set_gpio_triggering+0x2c/0x264) from [<c074=
dfe4>] (irq_desc+0x9e24/0x16380)
> [    4.384643] ---[ end trace bbbce2218b6cbd17 ]---
> [    4.389801] Kernel panic - not syncing: Attempted to kill init! exitco=
de=3D0x0000000b
> [    4.389801]=20
> [    4.482757]  gadget: high-speed config #1: CDC Ethernet (ECM)
> [    4.488800]  gadget: init ecm
> [    4.491943]  gadget: notify connect false
> [    4.496948]  gadget: activate ecm
> [    4.500488] usb0: qlen 10
> [    4.503234]  gadget: ecm_close
> [    4.547912]  gadget: notify connect false
> [    4.579895]  gadget: notify speed 425984000
>=20


--=-armmcGv9ct5MUcBuU6Js
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQH56gAAoJEPo9qoy8lh71AfYP/2bU7ZdAWy4KdPkAlI66zH4V
GlgozHqzPJTJCjGF7AFWJg7TW8f6ttYLqpmq76Vg6Nb5lReBdK8acnV+krpBI8bN
6DAaia7ENTV4qMUeLuZvbU/PJdLsO0TdcrcajSl739ECz4G8ieFxYD1GAWlQLs4Z
Y7X2mkAvTbB0dkyTcAiVbmTYStxfzFTzo4VrRN2sG7AmbIn6tTqPUEsGW08pWbPe
Dqveh4PTA1A8vlHcUtJ/sqWSLnQ9le8HUDn4LJP2fMZYzJawvdwRNDi81lyhObfM
QB61KuRuBPb0LQDGrNit063BMpF/Ge5xhGhOquToRKunMp0NhX92Ogh4yKk8MIxF
KtIqVGxPz+lBEksULAyCEu6vRer+RJmYlsTfrY14oAiNDL6BZfGOj/s3OxxLag99
/T/bDTS2YLsZjIhLpkQ4or2EFGnX99NyYqil3GFQExaUQ+AsFDr+sDaWQsewY6gm
sknii7lqLdQDpoZG8SdLJqlArhcny67CayzZt345r9kmPJ8Duj7auvGBlfFjqbVa
4BGEX5RNzevrzSFO6ScVEPAQ0AfxBnhJn5s7C9yI1ARmvPLiV2fNt7HMcVnZBEZ1
34U3e4YbHrG53Dtu6F6ZCybDImtLFG7baMEfy6NR8e+zTU9yhOpHSp5f7rgw99rX
JokepvQhjkYPcw4u1Chw
=sWt/
-----END PGP SIGNATURE-----

--=-armmcGv9ct5MUcBuU6Js--

