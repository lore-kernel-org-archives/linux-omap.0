From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Tue, 30 Oct 2012 12:17:11 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210301216330.12697@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com> <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com> <alpine.DEB.2.00.1210200611150.9865@utopia.booyaka.com> <CAORVsuUkU3iTTFcXfYJ=_FntjiTR33Gs4z9OsNEn2Cxq7Ef-qA@mail.gmail.com>
 <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com> <alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com> <CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com> <20121025101212.GD21217@arwen.pp.htv.fi>
 <20121026201539.GD29548@arwen.pp.htv.fi> <alpine.DEB.2.00.1210262201500.11258@utopia.booyaka.com> <20121029200032.GD30152@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-2101778199-1351599431=:12697"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48022 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933424Ab2J3MRM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 08:17:12 -0400
In-Reply-To: <20121029200032.GD30152@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-2101778199-1351599431=:12697
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 29 Oct 2012, Felipe Balbi wrote:

> that's too bad :-(
>=20
> Can you compile with:
>=20
> CONFIG_I2C_DEBUG_CORE=3Dy
> CONFIG_I2C_DEBUG_ALGO=3Dy
> CONFIG_I2C_DEBUG_BUS=3Dy
> CONFIG_DEFAULT_MESSAGE_LOGLEVEL=3D9
>=20
> so that I can see all transfers ?

Log is below.

- Paul


U-Boot 2011.06-dirty (Sep 04 2012 - 17:06:58)

OMAP3530-GP ES3.0, CPU-OPP2, L3-165MHz, Max CPU Clock 600 mHz
OMAP3 Beagle board + LPDDR/NAND
I2C:   ready
DRAM:  256 MiB
NAND:  256 MiB
MMC:   OMAP SD/MMC: 0
In:    serial
Out:   serial
Err:   serial
Beagle Rev C1/C2/C3
timed out in wait_for_pin: I2C_STAT=3D0
I2C read: I/O error
Unrecognized expansion board: 0
Die ID #5cf200030000000004013f7902012010
Hit any key to stop autoboot:  2 =08=08=08 0=20
OMAP3 beagleboard.org #=20
OMAP3 beagleboard.org #=20
OMAP3 beagleboard.org # setenv bootargs console=3DttyO2,230400n8 root=3D/de=
v/mmcblk0p2 rw rootfstype=3Dext3 rootwait
OMAP3 beagleboard.org # setenv bootargs console=3DttyO2,230400n8 root=3D/de=
v/mmcblk0p2 rw rootfstype=3Dext3 rootwait debug ignore_loglevel
OMAP3 beagleboard.org # loady
## Ready for binary (ymodem) download to 0x80200000 at 230400 bps...
CModem - CRC mode, 32426(SOH)/0(STX)/0(CAN) packets, 5 retries
## Total Size      =3D 0x003f53f0 =3D 4150256 Bytes
OMAP3 beagleboard.org # bootm
## Booting kernel from Legacy Image at 80200000 ...
   Image Name:   Linux-3.7.0-rc3
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    4150192 Bytes =3D 4 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.7.0-rc3 (paul@dusk) (gcc version 4.5.1 (Sour=
cery G++ Lite 2010.09-50) ) #703 SMP Tue Oct 30 05:56:54 MDT 2012
[    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=3D10c=
53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing in=
struction cache
[    0.000000] Machine: OMAP3 Beagle Board
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 65280
[    0.000000] free_area_init_node: node 0, pgdat c07de400, node_mem_map c0=
d3c000
[    0.000000]   Normal zone: 512 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 64768 pages, LIFO batch:15
[    0.000000] OMAP3430/3530 ES3.0 (l2cache iva sgx neon isp )
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
[    0.000000] PERCPU: Embedded 9 pages/cpu @c0f42000 s12928 r8192 d15744 u=
36864
[    0.000000] pcpu-alloc: s12928 r8192 d15744 u36864 alloc=3D9*4096
[    0.000000] pcpu-alloc: [0] 0=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 64768
[    0.000000] Kernel command line: console=3DttyO2,230400n8 root=3D/dev/mm=
cblk0p2 rw rootfstype=3Dext3 rootwait debug ignore_loglevel
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 byt=
es)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes=
)
[    0.000000] Memory: 255MB =3D 255MB total
[    0.000000] Memory: 245256k/245256k available, 16888k reserved, 0K highm=
em
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc07047fc   (7154 kB)
[    0.000000]       .init : 0xc0705000 - 0xc0755280   ( 321 kB)
[    0.000000]       .data : 0xc0756000 - 0xc07e15e0   ( 558 kB)
[    0.000000]        .bss : 0xc07e1604 - 0xc0d3bfac   (5483 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] =09RCU restricting CPUs from NR_CPUS=3D2 to nr_cpu_ids=3D1.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 inte=
rrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER12 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps eve=
ry 131071999ms
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.001220] Calibrating delay loop... 313.50 BogoMIPS (lpj=3D1222656)
[    0.103363] pid_max: default: 32768 minimum: 301
[    0.104187] Security Framework initialized
[    0.104431] Mount-cache hash table entries: 512
[    0.110626] CPU: Testing write buffer coherency: ok
[    0.111907] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.112030] Setting up static identity map for 0x8051f158 - 0x8051f1c8
[    0.115997] Brought up 1 CPUs
[    0.116027] SMP: Total of 1 processors activated (313.50 BogoMIPS).
[    0.132202] ttyO2 used as console in debug mode: uart2 clocks will not b=
e gated
[    0.139984] pinctrl core: initialized pinctrl subsystem
[    0.148834] regulator-dummy: no parameters
[    0.151702] NET: Registered protocol family 16
[    0.153503] DMA: preallocated 256 KiB pool for atomic coherent allocatio=
ns
[    0.156249] omap-gpmc omap-gpmc: GPMC revision 5.0
[    0.173187] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.173919] OMAP GPIO hardware version 2.5
[    0.177062] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.180633] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.183898] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.187469] gpiochip_add: registered GPIOs 128 to 159 on device: gpio
[    0.190551] gpiochip_add: registered GPIOs 160 to 191 on device: gpio
[    0.198242] i2c-core: driver [dummy] registered
[    0.200683] omap_mux_init: Add partition: #1: core, flags: 0
[    0.204437] OMAP3 Beagle Rev: C1/C2/C3
[    0.235412] Reprogramming SDRC clock to 332000000 Hz
[    0.236755] Found NAND on CS0
[    0.236785] Registering NAND on CS0
[    0.238677] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.260498]  omap-mcbsp.2: alias fck already exists
[    0.261749]  omap-mcbsp.3: alias fck already exists
[    0.267395] OMAP DMA hardware revision 4.0
[    0.273742]  arm-pmu: alias fck already exists
[    0.372436] bio: create slab <bio-0> at 0
[    0.507171] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    0.508972] i2c-core: driver [tps65023] registered
[    0.512786] i2c-core: driver [twl] registered
[    0.515808] SCSI subsystem initialized
[    0.520202] usbcore: registered new interface driver usbfs
[    0.521118] usbcore: registered new interface driver hub
[    0.522094] usbcore: registered new device driver usb
[    0.537139] i2c i2c-1: adapter [OMAP I2C adapter] registered
[    0.537994] i2c 1-0048: uevent
[    0.539367] twl 1-0048: probe
[    0.541015] i2c 1-0049: uevent
[    0.542419] dummy 1-0049: probe
[    0.542510] i2c i2c-1: client [dummy] registered with bus id 1-0049
[    0.542907] i2c 1-004a: uevent
[    0.543670] dummy 1-004a: probe
[    0.543731] i2c i2c-1: client [dummy] registered with bus id 1-004a
[    0.544158] i2c 1-004b: uevent
[    0.544830] dummy 1-004b: probe
[    0.544921] i2c i2c-1: client [dummy] registered with bus id 1-004b
[    0.545227] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    0.545623] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    0.546142] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.546203] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.546478] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    0.546539] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    0.546630] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.546752] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.546844] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    0.546905] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    0.546997] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.547119] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.547210] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    0.547271] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    0.547363] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.547454] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.547576] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D2
[    0.547607] omap_i2c omap_i2c.1: addr: 0x0049, len: 2, flags: 0x0, stop:=
 1
[    0.547698] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.547760] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.547851] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D1
[    0.547882] i2c i2c-1: master_xfer[1] R, addr=3D0x49, len=3D4
[    0.547943] omap_i2c omap_i2c.1: addr: 0x0049, len: 1, flags: 0x0, stop:=
 0
[    0.548034] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.548095] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.548187] omap_i2c omap_i2c.1: addr: 0x0049, len: 4, flags: 0x1, stop:=
 1
[    0.548278] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    0.548309] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.548400] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D2
[    0.548461] omap_i2c omap_i2c.1: addr: 0x0049, len: 2, flags: 0x0, stop:=
 1
[    0.548553] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.548614] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.549774] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D4
[    0.549804] omap_i2c omap_i2c.1: addr: 0x0049, len: 4, flags: 0x0, stop:=
 1
[    0.549926] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.549987] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.550170] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D2
[    0.550201] omap_i2c omap_i2c.1: addr: 0x0049, len: 2, flags: 0x0, stop:=
 1
[    0.550323] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.550384] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.550476] i2c i2c-1: master_xfer[0] W, addr=3D0x4a, len=3D2
[    0.550537] omap_i2c omap_i2c.1: addr: 0x004a, len: 2, flags: 0x0, stop:=
 1
[    0.550628] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.550689] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.550781] i2c i2c-1: master_xfer[0] W, addr=3D0x4a, len=3D2
[    0.550811] omap_i2c omap_i2c.1: addr: 0x004a, len: 2, flags: 0x0, stop:=
 1
[    0.550903] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.550964] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.551086] i2c i2c-1: master_xfer[0] W, addr=3D0x4a, len=3D3
[    0.551116] omap_i2c omap_i2c.1: addr: 0x004a, len: 3, flags: 0x0, stop:=
 1
[    0.551208] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.551300] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.551391] i2c i2c-1: master_xfer[0] W, addr=3D0x4a, len=3D2
[    0.551422] omap_i2c omap_i2c.1: addr: 0x004a, len: 2, flags: 0x0, stop:=
 1
[    0.551513] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.551574] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.551696] i2c i2c-1: master_xfer[0] W, addr=3D0x4a, len=3D2
[    0.551727] omap_i2c omap_i2c.1: addr: 0x004a, len: 2, flags: 0x0, stop:=
 1
[    0.551818] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.551879] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.552001] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    0.552032] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    0.552124] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.552246] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.552337] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    0.552398] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    0.552459] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.552581] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.552673] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D1
[    0.552703] i2c i2c-1: master_xfer[1] R, addr=3D0x49, len=3D3
[    0.552764] omap_i2c omap_i2c.1: addr: 0x0049, len: 1, flags: 0x0, stop:=
 0
[    0.552856] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.552917] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.553009] omap_i2c omap_i2c.1: addr: 0x0049, len: 3, flags: 0x1, stop:=
 1
[    0.553100] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    0.553131] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.553222] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D1
[    0.553253] i2c i2c-1: master_xfer[1] R, addr=3D0x49, len=3D3
[    0.553314] omap_i2c omap_i2c.1: addr: 0x0049, len: 1, flags: 0x0, stop:=
 0
[    0.553405] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.553466] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.553527] omap_i2c omap_i2c.1: addr: 0x0049, len: 3, flags: 0x1, stop:=
 1
[    0.553649] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    0.553680] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.553771] i2c i2c-1: master_xfer[0] W, addr=3D0x4a, len=3D1
[    0.553802] i2c i2c-1: master_xfer[1] R, addr=3D0x4a, len=3D1
[    0.553833] omap_i2c omap_i2c.1: addr: 0x004a, len: 1, flags: 0x0, stop:=
 0
[    0.553924] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.553985] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.554077] omap_i2c omap_i2c.1: addr: 0x004a, len: 1, flags: 0x1, stop:=
 1
[    0.554168] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    0.554199] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.554290] i2c i2c-1: master_xfer[0] W, addr=3D0x4a, len=3D1
[    0.554321] i2c i2c-1: master_xfer[1] R, addr=3D0x4a, len=3D1
[    0.554382] omap_i2c omap_i2c.1: addr: 0x004a, len: 1, flags: 0x0, stop:=
 0
[    0.554473] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.554534] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.554595] omap_i2c omap_i2c.1: addr: 0x004a, len: 1, flags: 0x1, stop:=
 1
[    0.554687] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    0.554718] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.554840] i2c i2c-1: master_xfer[0] W, addr=3D0x4a, len=3D1
[    0.554840] i2c i2c-1: master_xfer[1] R, addr=3D0x4a, len=3D2
[    0.554901] omap_i2c omap_i2c.1: addr: 0x004a, len: 1, flags: 0x0, stop:=
 0
[    0.554992] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.555053] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.555145] omap_i2c omap_i2c.1: addr: 0x004a, len: 2, flags: 0x1, stop:=
 1
[    0.555236] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    0.555267] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.555358] i2c i2c-1: master_xfer[0] W, addr=3D0x4a, len=3D1
[    0.555389] i2c i2c-1: master_xfer[1] R, addr=3D0x4a, len=3D2
[    0.555419] omap_i2c omap_i2c.1: addr: 0x004a, len: 1, flags: 0x0, stop:=
 0
[    0.555511] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.555572] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.555664] omap_i2c omap_i2c.1: addr: 0x004a, len: 2, flags: 0x1, stop:=
 1
[    0.555786] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    0.555786] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.555908] i2c i2c-1: master_xfer[0] W, addr=3D0x4a, len=3D1
[    0.555938] i2c i2c-1: master_xfer[1] R, addr=3D0x4a, len=3D1
[    0.555969] omap_i2c omap_i2c.1: addr: 0x004a, len: 1, flags: 0x0, stop:=
 0
[    0.556060] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.556121] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.556213] omap_i2c omap_i2c.1: addr: 0x004a, len: 1, flags: 0x1, stop:=
 1
[    0.556732] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    0.556762] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.556945] i2c i2c-1: master_xfer[0] W, addr=3D0x4a, len=3D2
[    0.556976] omap_i2c omap_i2c.1: addr: 0x004a, len: 2, flags: 0x0, stop:=
 1
[    0.557098] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.557159] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.557250] i2c i2c-1: master_xfer[0] W, addr=3D0x4a, len=3D1
[    0.557281] i2c i2c-1: master_xfer[1] R, addr=3D0x4a, len=3D1
[    0.557312] omap_i2c omap_i2c.1: addr: 0x004a, len: 1, flags: 0x0, stop:=
 0
[    0.557403] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.557464] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.557556] omap_i2c omap_i2c.1: addr: 0x004a, len: 1, flags: 0x1, stop:=
 1
[    0.557647] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    0.557678] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.557769] i2c i2c-1: master_xfer[0] W, addr=3D0x4a, len=3D2
[    0.557830] omap_i2c omap_i2c.1: addr: 0x004a, len: 2, flags: 0x0, stop:=
 1
[    0.557922] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.557983] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.558074] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    0.558105] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    0.558166] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    0.558258] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.558288] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.558380] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    0.558471] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    0.558502] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.558593] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    0.558624] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    0.558685] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    0.558776] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.558837] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.558898] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    0.558990] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    0.559020] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.559295] twl 1-0048: PIH (irq 23) chaining IRQs 338..346
[    0.560180] twl 1-0048: power (irq 343) chaining IRQs 346..353
[    0.560699] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D1
[    0.560729] i2c i2c-1: master_xfer[1] R, addr=3D0x49, len=3D1
[    0.560760] omap_i2c omap_i2c.1: addr: 0x0049, len: 1, flags: 0x0, stop:=
 0
[    0.560882] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.560943] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.561035] omap_i2c omap_i2c.1: addr: 0x0049, len: 1, flags: 0x1, stop:=
 1
[    0.561126] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    0.561157] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.561279] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D2
[    0.561309] omap_i2c omap_i2c.1: addr: 0x0049, len: 2, flags: 0x0, stop:=
 1
[    0.561401] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.561462] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.565185] twl4030_gpio twl4030_gpio: gpio (irq 338) chaining IRQs 354.=
=2E371
[    0.565246] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D6
[    0.565338] omap_i2c omap_i2c.1: addr: 0x0049, len: 6, flags: 0x0, stop:=
 1
[    0.565490] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.565521] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x4000)
[    0.565612] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.565795] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D4
[    0.565856] omap_i2c omap_i2c.1: addr: 0x0049, len: 4, flags: 0x0, stop:=
 1
[    0.565948] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.566040] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.566162] gpiochip_find_base: found new base at 492
[    0.567779] gpiochip_add: registered GPIOs 492 to 511 on device: twl4030
[    0.569366] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D2
[    0.569488] omap_i2c omap_i2c.1: addr: 0x0049, len: 2, flags: 0x0, stop:=
 1
[    0.569641] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.569702] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.569854] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D1
[    0.569885] i2c i2c-1: master_xfer[1] R, addr=3D0x49, len=3D1
[    0.569946] omap_i2c omap_i2c.1: addr: 0x0049, len: 1, flags: 0x0, stop:=
 0
[    0.570037] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.570098] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.570190] omap_i2c omap_i2c.1: addr: 0x0049, len: 1, flags: 0x1, stop:=
 1
[    0.570281] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    0.570312] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.570404] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D2
[    0.570465] omap_i2c omap_i2c.1: addr: 0x0049, len: 2, flags: 0x0, stop:=
 1
[    0.570556] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.570648] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.570770] i2c i2c-1: master_xfer[0] W, addr=3D0x4a, len=3D2
[    0.570800] omap_i2c omap_i2c.1: addr: 0x004a, len: 2, flags: 0x0, stop:=
 1
[    0.570892] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.570983] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.571075] i2c i2c-1: master_xfer[0] W, addr=3D0x4a, len=3D2
[    0.571289] omap_i2c omap_i2c.1: addr: 0x004a, len: 2, flags: 0x0, stop:=
 1
[    0.571380] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.571472] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.571655] i2c i2c-1: master_xfer[0] W, addr=3D0x4a, len=3D1
[    0.571685] i2c i2c-1: master_xfer[1] R, addr=3D0x4a, len=3D1
[    0.571716] omap_i2c omap_i2c.1: addr: 0x004a, len: 1, flags: 0x0, stop:=
 0
[    0.571838] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.571899] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.571960] omap_i2c omap_i2c.1: addr: 0x004a, len: 1, flags: 0x1, stop:=
 1
[    0.572052] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    0.572082] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.572204] i2c i2c-1: master_xfer[0] W, addr=3D0x4a, len=3D2
[    0.572235] omap_i2c omap_i2c.1: addr: 0x004a, len: 2, flags: 0x0, stop:=
 1
[    0.572326] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.572418] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.572540] i2c i2c-1: master_xfer[0] W, addr=3D0x4a, len=3D2
[    0.572601] omap_i2c omap_i2c.1: addr: 0x004a, len: 2, flags: 0x0, stop:=
 1
[    0.572692] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.572784] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.580383] vdd_mpu_iva: 600 <--> 1450 mV normal=20
[    0.581024] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    0.581085] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    0.581207] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.581298] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.583740] vdd_core: 600 <--> 1450 mV normal=20
[    0.584197] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    0.584259] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    0.584411] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.584503] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.587371] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    0.587402] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    0.587493] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    0.587646] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.587738] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.587829] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    0.587951] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    0.587951] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.588073] VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
[    0.588104] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    0.588134] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    0.588195] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    0.588287] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.588348] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.588439] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    0.588531] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    0.588562] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.589202] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    0.589233] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    0.589355] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.589477] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.591949] VDAC: 1800 mV normal standby
[    0.592010] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    0.592041] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    0.592071] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    0.592193] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.592285] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.592376] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    0.592468] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    0.592498] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.593139] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    0.593200] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    0.593292] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.593688] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.596221] VDVI: 1800 mV normal standby
[    0.596252] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    0.596282] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    0.596343] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    0.596466] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.596527] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.596649] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    0.596740] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    0.596771] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.597320] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    0.597351] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    0.597473] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.597564] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.599975] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    0.600006] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    0.600067] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    0.600189] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.600250] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.600341] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    0.600433] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    0.600463] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.600585] VSIM: 1800 <--> 3000 mV at 1800 mV normal standby
[    0.600616] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    0.600646] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    0.600708] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    0.600799] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.601165] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.601348] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    0.601440] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    0.601470] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.602142] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    0.602203] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    0.602294] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    0.602416] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    0.602691] i2c i2c-1: client [twl4030] registered with bus id 1-0048
[    0.602813] omap_i2c omap_i2c.1: bus 1 rev1.3.12 at 2600 kHz
[    0.617614] i2c i2c-3: adapter [OMAP I2C adapter] registered
[    0.618041] i2c 3-0050: uevent
[    0.618743] i2c i2c-3: client [eeprom] registered with bus id 3-0050
[    0.618804] omap_i2c omap_i2c.3: bus 3 rev1.3.12 at 100 kHz
[    0.629852] Switching to clocksource 32k_counter
[    0.819976] NET: Registered protocol family 2
[    0.822814] TCP established hash table entries: 8192 (order: 4, 65536 by=
tes)
[    0.823394] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    0.829284] TCP: Hash tables configured (established 8192 bind 8192)
[    0.829681] TCP: reno registered
[    0.829711] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.830108] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.831573] NET: Registered protocol family 1
[    0.834106] RPC: Registered named UNIX socket transport module.
[    0.834167] RPC: Registered udp transport module.
[    0.834167] RPC: Registered tcp transport module.
[    0.834197] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.835723] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.836212] CPU PMU: probing PMU on CPU 0
[    0.836425] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver, 5 co=
unters available
[    1.058898] VFS: Disk quotas dquot_6.5.2
[    1.059265] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.063476] NFS: Registering the id_resolver key type
[    1.064178] Key type id_resolver registered
[    1.064208] Key type id_legacy registered
[    1.064453] jffs2: version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red Hat,=
 Inc.
[    1.065338] msgmni has been set to 479
[    1.070770] io scheduler noop registered
[    1.070800] io scheduler deadline registered
[    1.070922] io scheduler cfq registered (default)
[    1.075500] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.085754] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 88) is a OMAP=
 UART0
[    1.088653] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 89) is a OMAP=
 UART1
[    1.090850] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 90) is a OMAP=
 UART2
[    2.409454] console [ttyO2] enabled
[    2.461151] brd: module loaded
[    2.493194] loop: module loaded
[    2.495727] i2c-core: driver [menelaus] registered
[    2.499206] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    2.502166] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    2.505554] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    2.509490] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    2.512207] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    2.515106] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    2.518920] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    2.521575] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    2.524749] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D2
[    2.527709] omap_i2c omap_i2c.1: addr: 0x0049, len: 2, flags: 0x0, stop:=
 1
[    2.532348] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    2.535064] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    2.546630] mtdoops: mtd device (mtddev=3Dname/number) must be supplied
[    2.550842] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron NA=
ND 256MiB 1,8V 16-bit), page size: 2048, OOB size: 64
[    2.557312] Creating 5 MTD partitions on "omap2-nand.0":
[    2.560302] 0x000000000000-0x000000080000 : "X-Loader"
[    2.573455] 0x000000080000-0x000000260000 : "U-Boot"
[    2.584594] 0x000000260000-0x000000280000 : "U-Boot Env"
[    2.593811] 0x000000280000-0x000000680000 : "Kernel"
[    2.606109] 0x000000680000-0x000010000000 : "File System"
[    2.828338] OneNAND driver initializing
[    2.847808] usbcore: registered new interface driver asix
[    2.851654] usbcore: registered new interface driver cdc_ether
[    2.855651] usbcore: registered new interface driver smsc95xx
[    2.859619] usbcore: registered new interface driver net1080
[    2.863464] usbcore: registered new interface driver cdc_subset
[    2.867492] usbcore: registered new interface driver zaurus
[    2.871337] usbcore: registered new interface driver cdc_ncm
[    2.877563] usbcore: registered new interface driver cdc_wdm
[    2.880798] Initializing USB Mass Storage driver...
[    2.884307] usbcore: registered new interface driver usb-storage
[    2.887573] USB Mass Storage support registered.
[    2.891021] usbcore: registered new interface driver usbtest
[    2.896881] mousedev: PS/2 mouse device common for all mice
[    2.904998] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    2.908050] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    2.912017] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    2.914733] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    2.917541] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    2.920562] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D2
[    2.923522] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    2.927398] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    2.930114] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    2.932830] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x1, stop:=
 1
[    2.936737] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    2.939392] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    2.942138] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D3
[    2.945190] omap_i2c omap_i2c.1: addr: 0x004b, len: 3, flags: 0x0, stop:=
 1
[    2.949005] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    2.951751] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    2.956054] input: twl4030_pwrbutton as /devices/platform/omap_i2c.1/i2c=
-1/1-0049/twl4030_pwrbutton/input/input0
[    2.965484] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    2.968749] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    2.971740] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    2.975677] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    2.978393] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    2.981201] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    2.986236] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    2.988891] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    2.991973] twl_rtc twl_rtc: Power up reset detected.
[    2.994750] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    2.997955] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    3.001770] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.004547] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.007415] twl_rtc twl_rtc: Enabling TWL-RTC
[    3.009796] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    3.012756] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    3.016693] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.019439] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.022308] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    3.025268] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    3.029571] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.032318] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.035125] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    3.038208] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    3.041168] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    3.045043] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.047760] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.050537] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    3.054443] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    3.057098] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.060821] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    3.063781] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    3.066772] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    3.070739] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.073425] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.076293] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    3.080108] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    3.082794] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.085632] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    3.088592] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    3.092468] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.095214] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.098388] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    3.101440] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D6
[    3.104400] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    3.108276] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.110992] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.113708] omap_i2c omap_i2c.1: addr: 0x004b, len: 6, flags: 0x1, stop:=
 1
[    3.117736] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    3.120422] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x2000)
[    3.123199] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.125946] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    3.128906] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D6
[    3.131927] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    3.135742] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.138519] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.141235] omap_i2c omap_i2c.1: addr: 0x004b, len: 6, flags: 0x1, stop:=
 1
[    3.145172] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    3.147827] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x2000)
[    3.150604] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.153350] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    3.156372] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    3.159362] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    3.163208] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.165924] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.168640] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    3.172546] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    3.175201] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.178009] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    3.180969] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    3.184814] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.187561] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.190307] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    3.193328] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D6
[    3.196319] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    3.200103] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.202880] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.205596] omap_i2c omap_i2c.1: addr: 0x004b, len: 6, flags: 0x1, stop:=
 1
[    3.209594] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    3.212249] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x2000)
[    3.214965] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.219451] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    3.223144] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    3.226287] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    3.230133] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.232910] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.235717] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    3.238677] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D2
[    3.241760] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    3.245574] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.248352] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.251129] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x1, stop:=
 1
[    3.254943] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    3.257629] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.260498] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D3
[    3.263580] omap_i2c omap_i2c.1: addr: 0x004b, len: 3, flags: 0x0, stop:=
 1
[    3.267425] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.270141] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.273895] i2c /dev entries driver
[    3.278717] i2c-dev: adapter [OMAP I2C adapter] registered as minor 1
[    3.283691] i2c-dev: adapter [OMAP I2C adapter] registered as minor 3
[    3.287353] Driver for 1-wire Dallas network protocol.
[    3.295043] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60 s=
ec
[    3.300048] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    3.303222] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    3.307067] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.309814] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.312713] twl4030_wdt twl4030_wdt: Failed to register misc device
[    3.316192] twl4030_wdt: probe of twl4030_wdt failed with error -16
[    3.323455] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D1
[    3.326690] i2c i2c-1: master_xfer[1] R, addr=3D0x49, len=3D1
[    3.329711] omap_i2c omap_i2c.1: addr: 0x0049, len: 1, flags: 0x0, stop:=
 0
[    3.333679] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.336364] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.339202] omap_i2c omap_i2c.1: addr: 0x0049, len: 1, flags: 0x1, stop:=
 1
[    3.343139] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    3.345794] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.348602] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D2
[    3.351867] omap_i2c omap_i2c.1: addr: 0x0049, len: 2, flags: 0x0, stop:=
 1
[    3.355682] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.358459] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.362335] omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
[    3.365844] omap-dma-engine omap-dma-engine: allocating channel for 62
[    3.369506] omap-dma-engine omap-dma-engine: allocating channel for 61
[    3.374359] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    3.377319] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    3.380371] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    3.384368] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.387054] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.389953] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    3.393768] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    3.396423] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.399353] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    3.402313] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    3.405426] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    3.409240] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.412017] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.414794] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    3.418609] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    3.421264] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.424163] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    3.427124] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    3.430175] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    3.433990] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.436767] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.439514] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    3.443420] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    3.446075] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.448822] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    3.451873] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    3.455688] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.458404] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.461212] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    3.464172] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    3.467193] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    3.471008] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.473693] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.476501] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    3.480285] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    3.482971] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.485778] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    3.488708] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    3.491760] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    3.495574] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.498321] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.501068] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    3.504852] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    3.507537] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.510345] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    3.513366] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    3.516326] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    3.520141] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.522888] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.525634] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    3.529510] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    3.532165] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.534912] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    3.537933] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    3.540893] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    3.544769] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.547454] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.550170] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    3.554046] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    3.556732] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.559478] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    3.562499] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    3.566314] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.569061] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.677520] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    3.680450] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    3.683410] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    3.687316] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.690002] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.692749] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    3.696624] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    3.699279] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.702117] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    3.705078] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    3.708953] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.711700] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.714447] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    3.717468] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    3.720428] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    3.724304] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.727020] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.729736] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    3.733612] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    3.736267] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.739013] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    3.742034] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    3.745849] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.748626] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.857482] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D4
[    3.860443] omap_i2c omap_i2c.1: addr: 0x0049, len: 4, flags: 0x0, stop:=
 1
[    3.864288] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.867065] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.869812] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D1
[    3.872833] i2c i2c-1: master_xfer[1] R, addr=3D0x49, len=3D5
[    3.875793] omap_i2c omap_i2c.1: addr: 0x0049, len: 1, flags: 0x0, stop:=
 0
[    3.879608] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.882385] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.885101] omap_i2c omap_i2c.1: addr: 0x0049, len: 5, flags: 0x1, stop:=
 1
[    3.889007] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    3.891662] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x2000)
[    3.894378] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.897186] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D6
[    3.900146] omap_i2c omap_i2c.1: addr: 0x0049, len: 6, flags: 0x0, stop:=
 1
[    3.904022] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.906677] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x4000)
[    3.909393] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.914062] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    3.916992] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    3.920135] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    3.923980] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.926666] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.929534] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    3.933349] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    3.936035] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.938934] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    3.941894] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    3.944946] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    3.948760] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.951538] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.954284] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    3.958099] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    3.960754] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.963653] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    3.966705] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    3.970520] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.973236] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.976623] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    3.979583] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    3.982666] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    3.986480] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    3.989196] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    3.992034] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    3.995849] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    3.998504] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.001403] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    4.004333] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    4.007415] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    4.011230] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    4.014007] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.016784] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    4.020599] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    4.023254] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.026123] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    4.029174] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    4.032165] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    4.035949] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    4.038726] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.041473] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    4.045379] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    4.048034] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.050781] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    4.053802] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    4.057617] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    4.060394] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.063232] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    4.066192] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    4.069213] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    4.073028] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    4.075805] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.078521] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    4.082336] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    4.084991] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.087799] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    4.090759] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    4.093780] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    4.097595] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    4.100341] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.103057] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    4.106933] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    4.109588] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.112396] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    4.115447] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    4.119232] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    4.121978] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.279876] i2c i2c-1: master_xfer[0] W, addr=3D0x49, len=3D1
[    4.282836] i2c i2c-1: master_xfer[1] R, addr=3D0x49, len=3D1
[    4.285858] omap_i2c omap_i2c.1: addr: 0x0049, len: 1, flags: 0x0, stop:=
 0
[    4.289855] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    4.292541] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.297668] omap_i2c omap_i2c.1: addr: 0x0049, len: 1, flags: 0x1, stop:=
 1
[    4.301544] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    4.304199] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.308349] usbcore: registered new interface driver usbhid
[    4.311523] usbhid: USB HID core driver
[    4.317321] oprofile: using arm/armv7
[    4.320526] TCP: cubic registered
[    4.322326] Initializing XFRM netlink socket
[    4.324859] NET: Registered protocol family 17
[    4.327514] NET: Registered protocol family 15
[    4.330535] Key type dns_resolver registered
[    4.333038] VFP support v0.3: implementor 41 architecture 3 part 30 vari=
ant c rev 1
[    4.348693] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    4.351776] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    4.354827] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    4.358795] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    4.361511] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.365783] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    4.369659] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    4.372314] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.377227] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    4.380279] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    4.384185] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    4.386932] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.391601] PM: no software I/O chain control; some wakeups may be lost
[    4.395812] ThumbEE CPU extension supported.
[    4.443084] clock: disabling unused clocks to save power
[    4.452331] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    4.455291] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    4.458374] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    4.462371] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    4.465087] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.467987] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    4.471801] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    4.474487] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.477386] VDVI: incomplete constraints, leaving on
[    4.480102] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    4.483306] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    4.486267] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    4.490173] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    4.492858] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.495666] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    4.499572] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    4.502227] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.505035] VDAC: incomplete constraints, leaving on
[    4.512847] input: gpio-keys as /devices/platform/gpio-keys/input/input1
[    4.519531] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    4.522644] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[    4.525665] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    4.529632] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    4.532348] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.535156] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[    4.539123] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    4.541778] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.544830] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[    4.547821] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[    4.551635] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    4.554443] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.557281] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[    4.560363] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D6
[    4.563323] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[    4.567138] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[    4.569915] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.572692] omap_i2c omap_i2c.1: addr: 0x004b, len: 6, flags: 0x1, stop:=
 1
[    4.576843] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[    4.579498] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x2000)
[    4.582244] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[    4.585235] twl_rtc twl_rtc: setting system clock to 2000-01-01 00:00:01=
 UTC (946684801)
[    4.595428] Waiting for root device /dev/mmcblk0p2...
[    4.702789] mmc0: SD Status: Invalid Allocation Unit size.
[    4.708129] mmc0: new SD card at address 8001
[    4.714416] mmcblk0: mmc0:8001 SD02G 1.89 GiB=20
[    4.724670]  mmcblk0: p1 p2
[    6.088897] kjournald starting.  Commit interval 5 seconds
[    6.092681] EXT3-fs (mmcblk0p2): warning: maximal mount count reached, r=
unning e2fsck is recommended
[    6.279846] EXT3-fs (mmcblk0p2): using internal journal
[    6.287200] EXT3-fs (mmcblk0p2): recovery complete
[    6.289825] EXT3-fs (mmcblk0p2): mounted filesystem with ordered data mo=
de
[    6.294158] VFS: Mounted root (ext3 filesystem) on device 179:2.
[    6.298675] Freeing init memory: 320K
INIT: version 2.86 booting
Starting the hotplug events dispatcher udevd
Synthesizing the initial hotplug events
[    9.449676] twl 1-0048: uevent
[    9.467559] dummy 1-0049: uevent
[    9.472778] dummy 1-004a: uevent
[    9.519195] dummy 1-004b: uevent
[    9.536560] i2c 3-0050: uevent
Remounting root file system...
mount: according to mtab, /proc is already mounted on /proc

WARNING: Couldn't open directory /lib/modules/3.7.0-rc3: No such file or di=
rectory
FATAL: Could not open /lib/modules/3.7.0-rc3/modules.dep.temp for writing: =
No such file or directory
root: mount: mount point /proc/bus/usb does not exist
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces... modprobe: FATAL: Could not load /lib/modu=
les/3.7.0-rc3/modules.dep: No such file or directory

modprobe: FATAL: Could not load /lib/modules/3.7.0-rc3/modules.dep: No such=
 file or directory

ifconfig: SIOCGIFFLAGS: No such device
modprobe: FATAL: Could not load /lib/modules/3.7.0-rc3/modules.dep: No such=
 file or directory

modprobe: FATAL: Could not load /lib/modules/3.7.0-rc3/modules.dep: No such=
 file or directory

modprobe: FATAL: Could not load /lib/modules/3.7.0-rc3/modules.dep: No such=
 file or directory

modprobe: FATAL: Could not load /lib/modules/3.7.0-rc3/modules.dep: No such=
 file or directory

eth0      No such device

modprobe: FATAL: Could not load /lib/modules/3.7.0-rc3/modules.dep: No such=
 file or directory

modprobe: FATAL: Could not load /lib/modules/3.7.0-rc3/modules.dep: No such=
 file or directory

udhcpc: SIOCGIFINDEX: No such device
done.
Starting portmap daemon: portmap.
[   24.558410] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[   24.561553] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[   24.564758] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[   24.568695] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[   24.571411] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[   24.574218] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[   24.578186] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[   24.580871] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[   24.583801] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[   24.586761] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[   24.590576] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[   24.593383] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[   24.596191] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[   24.599243] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D6
[   24.602203] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[   24.606018] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[   24.608764] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[   24.611541] omap_i2c omap_i2c.1: addr: 0x004b, len: 6, flags: 0x1, stop:=
 1
[   24.615631] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[   24.618286] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x2000)
[   24.621002] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
Tue Jul 22 00:18:00 UTC 2008
[   24.757415] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[   24.760406] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[   24.763549] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[   24.767395] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[   24.770111] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[   24.773162] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[   24.777038] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[   24.779693] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[   24.782623] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[   24.785614] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[   24.789520] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[   24.792297] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[   24.795166] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D7
[   24.798126] omap_i2c omap_i2c.1: addr: 0x004b, len: 7, flags: 0x0, stop:=
 1
[   24.801940] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[   24.804626] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x4000)
[   24.807434] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[   24.810272] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[   24.813232] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[   24.817047] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[   24.819824] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[   24.823242] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[   24.826324] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D1
[   24.829345] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[   24.833282] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[   24.836059] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[   24.838958] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x1, stop:=
 1
[   24.842864] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[   24.845550] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[   24.848297] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D2
[   24.851348] omap_i2c omap_i2c.1: addr: 0x004b, len: 2, flags: 0x0, stop:=
 1
[   24.855163] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[   24.857940] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[   24.860687] i2c i2c-1: master_xfer[0] W, addr=3D0x4b, len=3D1
[   24.863647] i2c i2c-1: master_xfer[1] R, addr=3D0x4b, len=3D6
[   24.866668] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, stop:=
 0
[   24.870483] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0010)
[   24.873260] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
[   24.875976] omap_i2c omap_i2c.1: addr: 0x004b, len: 6, flags: 0x1, stop:=
 1
[   24.880065] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0008)
[   24.882720] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x2000)
[   24.885528] omap_i2c omap_i2c.1: IRQ (ISR =3D 0x0004)
INIT: Entering runlevel: 5
ALSA: Restoring mixer settings...
/usr/sbin/alsactl: load_state:1327: No soundcards found...
Starting Dropbear SSH server: modprobe: FATAL: Could not load /lib/modules/=
3.7.0-rc3/modules.dep: No such file or directory

modprobe: FATAL: Could not load /lib/modules/3.7.0-rc3/modules.dep: No such=
 file or directory

dropbear.
Starting advanced power management daemon: No APM support in kernel
(failed.)
Starting system message bus: dbus.
Starting syslogd/klogd: start-stop-daemon: lseek: Invalid argument
 * Starting Avahi mDNS/DNS-SD Daemon: avahi-daemon
[ ok ]
Starting Bluetooth subsystem: hcidmodprobe: FATAL: Could not load /lib/modu=
les/3.7.0-rc3/modules.dep: No such file or directory

 hid2hci.

=2E-------.                                          =20
|       |                  .-.                     =20
|   |   |-----.-----.-----.| |   .----..-----.-----.
|       |     | __  |  ---'| '--.|  .-'|     |     |
|   |   |  |  |     |---  ||  --'|  |  |  '  | | | |
'---'---'--'--'--.  |-----''----''--'  '-----'-'-'-'
                -'  |
                '---'

The Angstrom Distribution beagleboard ttyO2

Angstrom 2008.1-test-20080712 beagleboard ttyO2

beagleboard login:=20

--843723315-2101778199-1351599431=:12697--
