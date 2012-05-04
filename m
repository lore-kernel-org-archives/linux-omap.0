From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: Problems with 3.4-rc5
Date: Fri, 04 May 2012 10:19:02 +0100
Message-ID: <WC20120504091902.970499@terrafix.co.uk>
References: <WC20120502115251.8503FF@terrafix.co.uk> <4FA12775.1090206@ti.com> <WC20120502124638.320406@terrafix.co.uk> <1336033721.14378.2.camel@deskari> <WC20120503084938.900446@terrafix.co.uk> <1336050442.14378.10.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.keele.netcentral.co.uk ([212.57.235.197]:55962 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753712Ab2EDJTb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 05:19:31 -0400
In-Reply-To: <1336050442.14378.10.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org

-----Original Message-----
 From: Tomi Valkeinen <tomi.valkeinen@ti.com>
 To: Joe Woodward <jw@terrafix.co.uk>
 Cc: Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org
 Date: Thu, 03 May 2012 16:07:22 +0300
 Subject: Re: Problems with 3.4-rc5
=20
> On Thu, 2012-05-03 at 09:49 +0100, Joe Woodward wrote:
 >=20
> > Both patches together results in slightly different behaviour, the
 > display is still broken-=20
> > it flickers on and off with occassional underflows before breaking
 > completely.
 >=20
> Beagle works fine for me with omap2plus based config, and I think ove=
ro
 > also although I can't test it now as I broke my micro mmc adapter.
 >=20
> Can you send your panel definition? Any other things that could affec=
t
 > display? Do you have PM enabled? Can you share your kernel config?
 >=20
>  Tomi
 >=20

I've gone back to a test setup others can replicate.
=20
I have a GUSMTIX Overo Earth (OMAP3503-based), running in a=20
Chestnut43 board with a connect 4.3" Samsung LCD panel (480x320).
=20
(my previous emails were using a GUMSTIX Overo AirSTORM (AM3703),=20
but the results seem to be the same with the Earth)
=20
I've built stock 3.4-rc5 using the omap2plus_defconfig (using the=20
CodeSorcery toolchain: arm-2010.09-50-arm-none-linux-gnueabi.bin).
=20
I've had to make the following changes to the defconfig for my RFS (I'v=
e=20
attached the defconfig for reference):
 CONFIG_OMAP2_DSS=3Dy
 CONFIG_OMAP2_VRAM_SIZE=3D4
 CONFIG_FB_OMAP2=3Dy
 CONFIG_PANEL_GENERIC_DPI=3Dy
 CONFIG_TUN=3Dy
 CONFIG_DEVTMPFS=3Dy
 CONFIG_DEVTMPFS_MOUNT=3Dy
 CONFIG_SQUASHFS=3Dy
=20
I've also set the LCD to the default display device in board-overo.c:
 static struct omap_dss_board_info overo_dss_data =3D {
    .num_devices   =3D ARRAY_SIZE
 (overo_dss_devices),
    .devices   =3D overo_dss_devices,
    .default_device   =3D &overo_lcd43_device, /* @@=20
Default to LCD*/
 };
=20
I'm booting using uBoot 2012.04.01, and run everything from RAM.
=20
When booting I can see the Linux boot logo for a short time.
=20
The log is pasted below, but you can see:
 [    6.621215] omapdss DISPC error: FIFO UNDERFLOW on gfx, disabling=20
the overlay
=20
Cheers,
 Joe
=20


Uncompressing Linux... done, booting the kernel.
 [    0.000000] Booting Linux on physical CPU 0
 [    0.000000] Linux version 3.4.0-rc5 (joe@joe-VirtualBox) (gcc versi=
on=20
4.5.1 (Sourcery G++ Lite 2010.09-50) ) #6 SMP Thu May 3 15:38:04 BST=20
2012
 [    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7),=20
cr=3D10c53c7d
 [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasi=
ng=20
instruction cache
 [    0.000000] Machine: Gumstix Overo
 [    0.000000] Reserving 4194304 bytes SDRAM for VRAM
 [    0.000000] Memory policy: ECC disabled, Data cache writeback
 [    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
 [    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/600 MHz
 [    0.000000] PERCPU: Embedded 8 pages/cpu @c7408000 s11520 r8192=20
d13056 u32768
 [    0.000000] Built 1 zonelists in Zone order, mobility grouping on. =
 Total=20
pages: 128768
 [    0.000000] Kernel command line: console=3DttyO2,115200=20
omapfb.rotate=3D0 root=3D/dev/ram0 rw ramdisk_size=3D98304=20
initrd=3D0x81000000,96M rootfstype=3Dsquashfs
 [    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
 [    0.000000] Dentry cache hash table entries: 65536 (order: 6, 26214=
4=20
bytes)
 [    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072=
=20
bytes)
 [    0.000000] Memory: 507MB =3D 507MB total
 [    0.000000] Memory: 403416k/403416k available, 120872k reserved, 0K=
=20
highmem
 [    0.000000] Virtual kernel memory layout:
 [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
 [    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
 [    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
 [    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
 [    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
 [    0.000000]       .text : 0xc0008000 - 0xc065e058   (6489 kB)
 [    0.000000]       .init : 0xc065f000 - 0xc06acd00   ( 312 kB)
 [    0.000000]       .data : 0xc06ae000 - 0xc0740d18   ( 588 kB)
 [    0.000000]        .bss : 0xc0740d3c - 0xc0c96b20   (5464 kB)
 [    0.000000] Hierarchical RCU implementation.
 [    0.000000] NR_IRQS:474
 [    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96=
=20
interrupts
 [    0.000000] Total of 96 interrupts on 1 active controller
 [    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
 [    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wrap=
s=20
every 131071999ms
 [    0.000000] Console: colour dummy device 80x30
 [    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat,=20
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
 [    0.000946] Calibrating delay loop... 594.49 BogoMIPS (lpj=3D232243=
2)
 [    0.085937] pid_max: default: 32768 minimum: 301
 [    0.086761] Security Framework initialized
 [    0.087066] Mount-cache hash table entries: 512
 [    0.092529] CPU: Testing write buffer coherency: ok
 [    0.093566] CPU0: thread -1, cpu 0, socket -1, mpidr 0
 [    0.093658] Setting up static identity map for 0x804a5888 - 0x804a5=
8f8
 [    0.095794] Brought up 1 CPUs
 [    0.095825] SMP: Total of 1 processors activated (594.49 BogoMIPS).
 [    0.099487] devtmpfs: initialized
 [    0.121551] dummy:
 [    0.123931] NET: Registered protocol family 16
 [    0.125549] GPMC revision 5.0
 [    0.136993] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
 [    0.137573] OMAP GPIO hardware version 2.5
 [    0.138824] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
 [    0.140502] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
 [    0.142517] gpiochip_add: registered GPIOs 96 to 127 on device: gpi=
o
 [    0.144104] gpiochip_add: registered GPIOs 128 to 159 on device: gp=
io
 [    0.145660] gpiochip_add: registered GPIOs 160 to 191 on device: gp=
io
 [    0.154357] omap_mux_init: Add partition: #1: core, flags: 0
 [    0.170623] Reprogramming SDRC clock to 332000000 Hz
 [    0.170715] NAND: Unable to find configuration in GPMC
 [    0.170715]
 [    0.186828] hw-breakpoint: debug architecture 0x4 unsupported.
 [    0.204162]  omap-mcbsp.2: alias fck already exists
 [    0.205047]  omap-mcbsp.3: alias fck already exists
 [    0.209991] OMAP DMA hardware revision 4.0
 [    0.289672] bio: create slab <bio-0> at 0
 [    0.293884] fixed-dummy:
 [    0.295196] vads7846: 3300 mV
 [    0.302124] SCSI subsystem initialized
 [    0.304412] omap2_mcspi omap2_mcspi.1: master is unqueued, this is=20
deprecated
 [    0.308013] omap2_mcspi omap2_mcspi.2: master is unqueued, this is=20
deprecated
 [    0.309326] omap2_mcspi omap2_mcspi.3: master is unqueued, this is=20
deprecated
 [    0.310607] omap2_mcspi omap2_mcspi.4: master is unqueued, this is=20
deprecated
 [    0.314727] usbcore: registered new interface driver usbfs
 [    0.315948] usbcore: registered new interface driver hub
 [    0.316680] usbcore: registered new device driver usb
 [    0.328979] omap_i2c omap_i2c.1: bus 1 rev1.3.12 at 2600 kHz
 [    0.339752] twl 1-0048: PIH (irq 7) chaining IRQs 320..328
 [    0.340454] twl 1-0048: power (irq 325) chaining IRQs 328..335
 [    0.343139] twl4030_gpio twl4030_gpio: gpio (irq 320) chaining IRQs=
=20
336..353
 [    0.345214] gpiochip_add: registered GPIOs 192 to 211 on device:=20
twl4030
 [    0.351074] VMMC1: 1850 <--> 3150 mV at 3150 mV normal standby
 [    0.353881] VDAC: 1800 mV normal standby
 [    0.356292] VDVI: 1800 mV normal standby
 [    0.357604] omap_i2c omap_i2c.3: bus 3 rev1.3.12 at 400 kHz
 [    0.367736] Switching to clocksource 32k_counter
 [    0.511047] NET: Registered protocol family 2
 [    0.512115] IP route cache hash table entries: 4096 (order: 2, 1638=
4=20
bytes)
 [    0.514526] TCP established hash table entries: 16384 (order: 5,=20
131072=20
bytes)
 [    0.515228] TCP bind hash table entries: 16384 (order: 7, 589824 by=
tes)
 [    0.524719] TCP: Hash tables configured (established 16384 bind 163=
84)
 [    0.524841] TCP: reno registered
 [    0.524871] UDP hash table entries: 256 (order: 2, 20480 bytes)
 [    0.525207] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes=
)
 [    0.526275] NET: Registered protocol family 1
 [    0.527984] RPC: Registered named UNIX socket transport module.
 [    0.528015] RPC: Registered udp transport module.
 [    0.528045] RPC: Registered tcp transport module.
 [    0.528076] RPC: Registered tcp NFSv4.1 backchannel transport modul=
e.
 [    0.528961] Trying to unpack rootfs image as initramfs...
 [    0.530273] rootfs image is not initramfs (junk in compressed archi=
ve);=20
looks like an initrd
 [    1.404937] Freeing initrd memory: 98304K
 [    1.405120] NetWinder Floating Point Emulator V0.97 (double precisi=
on)
 [    1.576263] VFS: Disk quotas dquot_6.5.2
 [    1.576660] Dquot-cache hash table entries: 1024 (order 0, 4096 byt=
es)
 [    1.578369] squashfs: version 4.0 (2009/01/31) Phillip Lougher
 [    1.578582] NFS: Registering the id_resolver key type
 [    1.580841] jffs2: version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red=
=20
Hat, Inc.
 [    1.582214] msgmni has been set to 979
 [    1.586212] io scheduler noop registered
 [    1.586212] io scheduler deadline registered
 [    1.586486] io scheduler cfq registered (default)
 [    1.593688] OMAP DSS rev 2.0
 [    1.627441] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
 [    1.636077] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is a=
=20
OMAP UART0
 [    1.638336] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73) is a=
=20
OMAP UART1
 [    1.640136] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74) is a=
=20
OMAP UART2
 [    2.357696] console [ttyO2] enabled
 [    2.403747] brd: module loaded
 [    2.431823] loop: module loaded
 [    2.444305] mtdoops: mtd device (mtddev=3Dname/number) must be=20
supplied
 [    2.452392] OneNAND driver initializing
 [    2.462188] tun: Universal TUN/TAP device driver, 1.6
 [    2.467559] tun: (C) 1999-2004 Max Krasnyansky=20
<maxk@qualcomm.com>
 [    2.477905] smsc911x: Driver version 2008-10-21
 [    2.485748] smsc911x: Driver version 2008-10-21
 [    2.493560] usbcore: registered new interface driver asix
 [    2.499877] usbcore: registered new interface driver cdc_ether
 [    2.506866] usbcore: registered new interface driver net1080
 [    2.513549] usbcore: registered new interface driver cdc_subset
 [    2.520507] usbcore: registered new interface driver zaurus
 [    2.527130] usbcore: registered new interface driver cdc_ncm
 [    2.535827] usbcore: registered new interface driver cdc_wdm
 [    2.541961] Initializing USB Mass Storage driver...
 [    2.547821] usbcore: registered new interface driver usb-storage
 [    2.554321] USB Mass Storage support registered.
 [    2.560546] usbcore: registered new interface driver libusual
 [    2.567443] usbcore: registered new interface driver usbtest
 [    2.576019] mousedev: PS/2 mouse device common for all mice
 [    2.588287] ads7846 spi1.0: touchscreen, irq 210
 [    2.596252] input: ADS7846 Touchscreen=20
as /devices/platform/omap2_mcspi.1/spi_master/spi1/spi1.0/input/input0
 [    2.613708] input: twl4030_pwrbutton=20
as /devices/platform/omap_i2c.1/i2c-1/1-
 0049/twl4030_pwrbutton/input/input1
 [    2.627075] twl_rtc twl_rtc: Power up reset detected.
 [    2.632598] twl_rtc twl_rtc: Enabling TWL-RTC
 [    2.642150] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
 [    2.650329] i2c /dev entries driver
 [    2.657989] Driver for 1-wire Dallas network protocol.
 [    2.667633] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial=20
timeout=20
60 sec
 [    2.676361] twl4030_wdt twl4030_wdt: Failed to register misc device
 [    2.683197] twl4030_wdt: probe of twl4030_wdt failed with error -16
 [    2.925811] usbcore: registered new interface driver usbhid
 [    2.931884] usbhid: USB HID core driver
 [    2.935943] oprofile: hardware counters not available
 [    2.941345] oprofile: using timer interrupt.
 [    2.946990] TCP: cubic registered
 [    2.950500] Initializing XFRM netlink socket
 [    2.955261] NET: Registered protocol family 17
 [    2.960052] NET: Registered protocol family 15
 [    2.965209] Registering the dns_resolver key type
 [    2.970520] VFP support v0.3: implementor 41 architecture 3 part 30=
=20
variant c rev 1
 [    2.978790] ThumbEE CPU extension supported.
 [    3.033538] clock: disabling unused clocks to save power
 [    3.044952] omapfb omapfb: no driver for display: dvi
 [    3.064605] Console: switching to colour frame buffer device 60x34
 [    3.077270] omapdss DPI: Could not find exact pixel clock. Requeste=
d=20
9200 kHz, got 9094 kHz
 [    3.090240] VDAC: incomplete constraints, leaving on
 [    3.102539] input: gpio-keys as /devices/platform/gpio-keys/input/i=
nput2
 [    3.115509] twl_rtc twl_rtc: setting system clock to 2000-01-01=20
00:00:08 UTC (946684808)
 [    3.130462] RAMDISK: squashfs filesystem found at block 0
 [    3.136413] RAMDISK: Loading 50389KiB [1 disk] into ram disk... /
 [    3.493408] mmc0: host does not support reading read-only switch.=20
assuming write-enable.
 [    3.502807] |
 [    3.509490] mmc0: new high speed SDHC card at address 0002
 [    3.517395] -
 [    3.532745] mmcblk0: mmc0:0002 SD32G 29.9 GiB
 [    3.539916] -
 [    3.553771]  mmcblk0: p1
 [    3.558837] \
 [    3.652862] mmc1: new SDIO card at address 0001
 [    3.658905] done.
 [    6.427917] VFS: Mounted root (squashfs filesystem) readonly on dev=
ice=20
1:0.
 [    6.438079] devtmpfs: mounted
 [    6.442260] Freeing init memory: 308K
 [    6.621215] omapdss DISPC error: FIFO UNDERFLOW on gfx, disabling=20
the overlay
=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
