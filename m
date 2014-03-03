From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/12] ARM: OMAP2 DT clock conversion
Date: Mon, 3 Mar 2014 10:46:42 -0800
Message-ID: <20140303184642.GB25804@atomide.com>
References: <1393579384-23440-1-git-send-email-t-kristo@ti.com>
 <5310B271.5040708@ti.com>
 <20140228180112.GC15399@atomide.com>
 <5310D2FE.5090209@ti.com>
 <20140228183313.GD15399@atomide.com>
 <53143A7A.9020703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54062 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753761AbaCCSqt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Mar 2014 13:46:49 -0500
Content-Disposition: inline
In-Reply-To: <53143A7A.9020703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [140303 00:20]:
> On 02/28/2014 08:33 PM, Tony Lindgren wrote:
> >* Tero Kristo <t-kristo@ti.com> [140228 10:21]:
> >>
> >>Hmm, some clock node is broken, might be missing a name or parent
> >>name for some reason. Can you try to boot with DEBUG enabled so you
> >>get pr_debug:s out and see which clock is being initialized during
> >>the crash?
> >
> >...
> >[    0.000000] ti_dt_clk_init_provider: ti_dt_clk_init_provider: ini=
tializing: core_d18_ck
> >[    0.000000] ti_dt_clk_init_provider: ti_dt_clk_init_provider: ini=
tializing: vlynq_mux_fck
> >[    0.000000] ti_dt_clk_init_provider: ti_dt_clk_init_provider: ini=
tializing: vlynq_fck
> >[    0.000000] Unable to handle kernel NULL pointer dereference at v=
irtual address 00000000
> >...
> >
> >We really should be registering the clocks lazily as needed BTW. Tha=
t
> >leaves out the dependency to DEBUG_LL for seeing any kind of decent
> >error messages during the booting.
> >
> >Regards,
> >
> >Tony
> >
>=20
> Hey Tony,
>=20
> Can you retry with the branch? I just pushed one patch there, seems
> the parents for the vlynq_mux_fck were somewhat broken (there are
> holes in the valid mux values list, which hasn't happened with any
> other mux-clock so far.)
>=20
> If this works, I will rework the series a bit and send v2 out.
> Alternatively I need to add extra debug info.

Still getting this without omap3:

drivers/built-in.o: In function `of_ti_dpll_setup':
/home/tmlind/src/linux-2.6/drivers/clk/ti/dpll.c:235: undefined referen=
ce to `clkhwops_omap3_dpll'
drivers/built-in.o:(.rodata+0x1d7a0): undefined reference to `omap3_non=
core_dpll_enable'
drivers/built-in.o:(.rodata+0x1d7a4): undefined reference to `omap3_non=
core_dpll_disable'
drivers/built-in.o:(.rodata+0x1d7b0): undefined reference to `omap3_dpl=
l_recalc'
drivers/built-in.o:(.rodata+0x1d7c4): undefined reference to `omap3_non=
core_dpll_set_rate'
drivers/built-in.o:(.rodata+0x1d808): undefined reference to `omap3_dpl=
l_recalc'
drivers/built-in.o:(.rodata+0x1d84c): undefined reference to `omap3_dpl=
l_recalc'
drivers/built-in.o:(.rodata+0x1d860): undefined reference to `omap3_non=
core_dpll_set_rate'

and after enabling omap3 getting this without 2430:

drivers/built-in.o: In function `of_ti_omap2430_interface_clk_setup':
/home/tmlind/src/linux-2.6/drivers/clk/ti/interface.c:129: undefined re=
ference to `clkhwops_omap2430_i2chs_wait'

But after enabling those, it now boots on n8x0. The dmesg is below.

Care to post a patch to try dropping the legacy clock data as it should
now work with the DT clocks only for omap2?

Regards,

Tony


[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.14.0-rc5-00014-g2297f72-dirty (tmlind@mu=
ffinssi) (gcc version 4.3.5 (Debian 4.3.5-4) ) #388 Mon Mar 3 10:38:58 =
PST 2014
[    0.000000] CPU: ARMv6-compatible processor [4107b362] revision 2 (A=
RMv6TEJ), cr=3D00c5387d
[    0.000000] CPU: VIPT aliasing data cache, VIPT aliasing instruction=
 cache
[    0.000000] Machine model: Nokia N800
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] Memory policy: Data cache writeback
[    0.000000] On node 0 totalpages: 32512
[    0.000000] free_area_init_node: node 0, pgdat c07969a8, node_mem_ma=
p c7df9000
[    0.000000]   Normal zone: 256 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 32512 pages, LIFO batch:7
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] OMAP2420
[    0.000000]=20
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
[    0.000000] pcpu-alloc: [0] 0=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  =
Total pages: 32256
[    0.000000] Kernel command line: root=3D/dev/mmcblk0p2 rootwait cons=
ole=3DttyO2,115200 earlyprintk ignore_loglevel
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 =
bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 by=
tes)
[    0.000000] Memory: 115492K/130048K available (5098K kernel code, 45=
7K rwdata, 1884K rodata, 304K init, 5485K bss, 14556K reserved, 0K high=
mem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc06d9e10   (6984 kB)
[    0.000000]       .init : 0xc06da000 - 0xc072601c   ( 305 kB)
[    0.000000]       .data : 0xc0728000 - 0xc079a690   ( 458 kB)
[    0.000000]        .bss : 0xc079a690 - 0xc0cf5b10   (5486 kB)
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa0fe000 (revision 2.0) with 96 =
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] Clocking rate (Crystal/DPLL/MPU): 19.2/658/329 MHz
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000030] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps=
 every 65536000000000ns
[    0.008758] OMAP clocksource: 32k_counter at 32768 Hz
[    0.014465] hw-breakpoint: CPUID feature registers not supported. As=
suming v6 debug is present.
[    0.026245] Console: colour dummy device 80x30
[    0.031005] Lock dependency validator: Copyright (c) 2006 Red Hat, I=
nc., Ingo Molnar
[    0.039215] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.043609] ... MAX_LOCK_DEPTH:          48
[    0.048034] ... MAX_LOCKDEP_KEYS:        8191
[    0.052673] ... CLASSHASH_SIZE:          4096
[    0.057250] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.061981] ... MAX_LOCKDEP_CHAINS:      32768
[    0.066680] ... CHAINHASH_SIZE:          16384
[    0.071411]  memory used by lock dependency info: 3695 kB
[    0.077056]  per task-struct memory footprint: 1152 bytes
[    0.082916] Calibrating delay loop... 324.40 BogoMIPS (lpj=3D1622016=
)
[    0.143737] pid_max: default: 32768 minimum: 301
[    0.149230] Security Framework initialized
[    0.153930] Mount-cache hash table entries: 512
[    0.247467] CPU: Testing write buffer coherency: ok
[    0.256866] Setting up static identity map for 0x804db430 - 0x804db4=
a0
[    0.286865] VFP support v0.3: implementor 41 architecture 1 part 20 =
variant b rev 2
[    0.404479] pinctrl core: initialized pinctrl subsystem
[    0.424957] regulator-dummy: no parameters
[    0.437042] NET: Registered protocol family 16
[    0.443664] DMA: preallocated 256 KiB pool for atomic coherent alloc=
ations
[    0.615081] omap_gpio 48018000.gpio: Could not get gpio dbck
[    0.626770] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.636871] OMAP GPIO hardware version 1.8
[    0.647003] omap_gpio 4801a000.gpio: Could not get gpio dbck
[    0.655456] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.668640] omap_gpio 4801c000.gpio: Could not get gpio dbck
[    0.677062] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.690704] omap_gpio 4801e000.gpio: Could not get gpio dbck
[    0.698974] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.712554] omap-gpmc 6800a000.gpmc: GPMC revision 2.0
[    0.730529] platform mmci-omap.0: alias fck already exists
[    0.743072] No ATAGs?
[    0.745300] hw-breakpoint: found 6 breakpoint and 1 watchpoint regis=
ters.
[    0.752807] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.771942] OMAP DMA hardware revision 2.0
[    1.001983] bio: create slab <bio-0> at 0
[    1.308654] omap-dma-engine 48056000.dma-controller: OMAP DMA engine=
 driver
[    1.336578] SCSI subsystem initialized
[    1.351013] usbcore: registered new interface driver usbfs
[    1.358825] usbcore: registered new interface driver hub
[    1.366912] usbcore: registered new device driver usb
[    1.391571] omap_i2c 48070000.i2c: bus 0 rev3.3 at 400 kHz
[    1.401855] omap_i2c 48072000.i2c: bus 1 rev3.3 at 400 kHz
[    1.433074] Switched to clocksource 32k_counter
[    1.892578] NET: Registered protocol family 2
[    1.902313] TCP established hash table entries: 1024 (order: 0, 4096=
 bytes)
[    1.910247] TCP bind hash table entries: 1024 (order: 3, 36864 bytes=
)
[    1.918212] TCP: Hash tables configured (established 1024 bind 1024)
[    1.925659] TCP: reno registered
[    1.929168] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    1.936157] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    1.946411] NET: Registered protocol family 1
[    1.955749] RPC: Registered named UNIX socket transport module.
[    1.962005] RPC: Registered udp transport module.
[    1.967132] RPC: Registered tcp transport module.
[    1.972106] RPC: Registered tcp NFSv4.1 backchannel transport module=
=2E
[    1.983520] hw perfevents: enabled with v6 PMU driver, 3 counters av=
ailable
[    2.018554] futex hash table entries: 256 (order: 1, 10240 bytes)
[    2.587036] VFS: Disk quotas dquot_6.5.2
[    2.591400] Dquot-cache hash table entries: 1024 (order 0, 4096 byte=
s)
[    2.603668] NFS: Registering the id_resolver key type
[    2.610473] Key type id_resolver registered
[    2.615142] Key type id_legacy registered
[    2.619812] jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 R=
ed Hat, Inc.
[    2.629089] msgmni has been set to 225
[    2.645568] io scheduler noop registered
[    2.649749] io scheduler deadline registered
[    2.654632] io scheduler cfq registered (default)
[    2.671997] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.702178] omap_uart 4806a000.serial: no wakeirq for uart0
[    2.708282] of_get_named_gpiod_flags: can't parse gpios property of =
node '/ocp/serial@4806a000[0]'
[    2.720428] 4806a000.serial: ttyO0 at MMIO 0x4806a000 (irq =3D 88, b=
ase_baud =3D 3000000) is a OMAP UART0
[    2.736633] omap_uart 4806c000.serial: no wakeirq for uart0
[    2.742553] of_get_named_gpiod_flags: can't parse gpios property of =
node '/ocp/serial@4806c000[0]'
[    2.753723] 4806c000.serial: ttyO1 at MMIO 0x4806c000 (irq =3D 89, b=
ase_baud =3D 3000000) is a OMAP UART1
[    2.768005] omap_uart 4806e000.serial: no wakeirq for uart0
[    2.774078] of_get_named_gpiod_flags: can't parse gpios property of =
node '/ocp/serial@4806e000[0]'
[    2.784912] 4806e000.serial: ttyO2 at MMIO 0x4806e000 (irq =3D 90, b=
ase_baud =3D 3000000) is a OMAP UART2
[    2.795776] console [ttyO2] enabled
[    2.795776] console [ttyO2] enabled
[    2.803344] bootconsole [earlycon0] disabled
[    2.803344] bootconsole [earlycon0] disabled
[    2.825744] omap_rng 480a0000.rng: OMAP Random Number Generator ver.=
 40
[    2.935699] brd: module loaded
[    2.997741] loop: module loaded
[    3.006866] Menelaus rev 2.2
[    3.047821] mtdoops: mtd device (mtddev=3Dname/number) must be suppl=
ied
[    3.059997] omap2-onenand omap2-onenand: initializing on CS0, phys b=
ase 0x04000000, virtual base c88c0000, freq 54 MHz
[    3.071533] OneNAND Manufacturer: Samsung (0xec)
[    3.076538] Muxed OneNAND(DDP) 256MB 1.8V 16-bit (0x48)
[    3.082092] OneNAND version =3D 0x0011
[    3.085968] Chip support all block unlock
[    3.090332] onenand_wait: controller error =3D 0x0400
[    3.097259] Scanning device for bad blocks
[    3.254333] 6 ofpart partitions found on MTD device omap2-onenand
[    3.260803] Creating 6 MTD partitions on "omap2-onenand":
[    3.266662] 0x000000000000-0x000000020000 : "bootloader"
[    3.292877] 0x000000020000-0x000000080000 : "config"
[    3.312042] 0x000000080000-0x000000280000 : "kernel"
[    3.331085] 0x000000280000-0x000000680000 : "initfs"
[    3.350555] 0x000000680000-0x000010000000 : "rootfs"
[    3.393737] 0x000000000000-0x000010000000 : "omap2-onenand"
[    3.474853] usbcore: registered new interface driver asix
[    3.482421] usbcore: registered new interface driver ax88179_178a
[    3.490844] usbcore: registered new interface driver cdc_ether
[    3.498992] usbcore: registered new interface driver r815x
[    3.506896] usbcore: registered new interface driver smsc95xx
[    3.514953] usbcore: registered new interface driver net1080
[    3.522705] usbcore: registered new interface driver cdc_subset
[    3.530944] usbcore: registered new interface driver zaurus
[    3.539093] usbcore: registered new interface driver cdc_ncm
[    3.551727] usbcore: registered new interface driver cdc_wdm
[    3.559906] usbcore: registered new interface driver usb-storage
[    3.568420] usbcore: registered new interface driver usbtest
[    3.583953] mousedev: PS/2 mouse device common for all mice
[    3.606262] i2c /dev entries driver
[    3.620574] of_get_named_gpiod_flags exited with status 0
[    3.626647] of_get_named_gpiod_flags exited with status 0
[    3.632476] of_get_named_gpiod_flags exited with status 0
[    3.656005] retu-mfd 2-0001: Retu & Vilma v1.5 found
[    3.677124] input: retu-pwrbutton as /devices/ocp.3/i2c.4/i2c-2/2-00=
01/retu-pwrbutton/input/input0
[    3.695190] Driver for 1-wire Dallas network protocol.
[    3.724243] mmci-omap mmci-omap.0: no slots
[    3.728820] platform mmci-omap.0: Driver mmci-omap requests probe de=
ferral
[    3.745727] usbcore: registered new interface driver usbhid
[    3.751678] usbhid: USB HID core driver
[    3.760375] oprofile: using arm/armv6
[    3.766571] TCP: cubic registered
[    3.770111] Initializing XFRM netlink socket
[    3.775299] NET: Registered protocol family 17
[    3.780242] NET: Registered protocol family 15
[    3.786315] Key type dns_resolver registered
[    3.804290] omap_mux_get_by_name: Could not find signal sys_ndmareq0
[    3.811065] omap_mux_get_by_name: Could not find signal sys_ndmareq1
[    3.817932] omap_mux_get_by_name: Could not find signal sys_ndmareq2
[    3.824768] omap_mux_get_by_name: Could not find signal sys_ndmareq3
[    3.831512] omap_mux_get_by_name: Could not find signal sys_ndmareq4
[    3.838317] omap_mux_get_by_name: Could not find signal sys_ndmareq5
[    3.854064] usb_phy_gen_xceiv supply vcc not found, using dummy regu=
lator
[    3.883972] tusb: prcm2.0 int2.0 gpio3.0 dma3.0 dieid2 rev3.1
[    3.890167] musb-hdrc: ConfigData=3D0x06 (UTMI-8, dyn FIFOs, SoftCon=
n)
[    3.897064] musb-hdrc: MHDRC RTL version 1.400=20
[    3.901885] musb-hdrc: setup fifo_mode 4
[    3.906188] musb-hdrc: 28/31 max ep, 16384/16384 memory
[    3.912506] musb-hdrc musb-hdrc.0.auto: MUSB HDRC host driver
[    3.928985] musb-hdrc musb-hdrc.0.auto: new USB bus registered, assi=
gned bus number 1
[    3.942871] usb usb1: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002
[    3.950256] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    3.958068] usb usb1: Product: MUSB HDRC host driver
[    3.963439] usb usb1: Manufacturer: Linux 3.14.0-rc5-00014-g2297f72-=
dirty musb-hcd
[    3.971466] usb usb1: SerialNumber: musb-hdrc.0.auto
[    3.992279] hub 1-0:1.0: USB hub found
[    3.997680] hub 1-0:1.0: 1 port detected
[    4.022338] TUSB 6010
[    4.157165] mmci-omap mmci-omap.0: command timeout (CMD52)
[    4.165161] mmci-omap mmci-omap.0: command timeout (CMD52)
[    4.196777] mmci-omap mmci-omap.0: command timeout (CMD5)
[    4.203491] mmci-omap mmci-omap.0: command timeout (CMD5)
[    4.210144] mmci-omap mmci-omap.0: command timeout (CMD5)
[    4.219604] mmci-omap mmci-omap.0: command timeout (CMD5)
[    4.241088] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    4.353851] Waiting for root device /dev/mmcblk0p2...
[    4.385711] mmc0: host does not support reading read-only switch. as=
suming write-enable.
[    4.395019] mmc0: new SDHC card at address ea4d
[    4.407897] mmcblk0: mmc0:ea4d SU04G 3.79 GiB=20
[    4.428863]  mmcblk0: p1 p2
[    4.447296] mmci-omap mmci-omap.0: command timeout (CMD52)
[    4.454101] mmci-omap mmci-omap.0: command timeout (CMD52)
[    4.464874] mmci-omap mmci-omap.0: command timeout (CMD8)
[    4.477966] mmci-omap mmci-omap.0: command timeout (CMD5)
[    4.488250] mmci-omap mmci-omap.0: command timeout (CMD5)
[    4.498260] mmci-omap mmci-omap.0: command timeout (CMD5)
[    4.506286] EXT3-fs (mmcblk0p2): recovery required on readonly files=
ystem
[    4.513671] EXT3-fs (mmcblk0p2): write access will be enabled during=
 recovery
[    4.523468] mmci-omap mmci-omap.0: command timeout (CMD5)
[    4.540527] mmci-omap mmci-omap.0: command timeout (CMD8)
[    4.547363] kjournald starting.  Commit interval 5 seconds
[    4.562103] EXT3-fs (mmcblk0p2): recovery complete
[    4.567413] EXT3-fs (mmcblk0p2): mounted filesystem with ordered dat=
a mode
[    4.577270] VFS: Mounted root (ext3 filesystem) readonly on device 1=
79:2.
[    4.587280] Freeing unused kernel memory: 304K (c06da000 - c0726000)
[    4.662048] mmc1: host does not support reading read-only switch. as=
suming write-enable.
[    4.671020] mmc1: new SD card at address e624
[    4.683898] mmcblk1: mmc1:e624 SD128 120 MiB=20
[    4.706298]  mmcblk1: p1
INIT: version 2.86 booting
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
