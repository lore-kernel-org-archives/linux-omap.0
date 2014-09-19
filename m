From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/26] ARM: OMAP2+: PRCM cleanups for 3.18 merge window
Date: Fri, 19 Sep 2014 16:38:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1409191633180.22526@utopia.booyaka.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com> <20140918171650.GK14505@atomide.com> <20140918191615.GN14505@atomide.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1686613828-1411144684=:22526"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58736 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756107AbaISQiF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2014 12:38:05 -0400
In-Reply-To: <20140918191615.GN14505@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1686613828-1411144684=:22526
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 18 Sep 2014, Tony Lindgren wrote:

> * Tony Lindgren <tony@atomide.com> [140918 10:17]:
> > * Tero Kristo <t-kristo@ti.com> [140901 11:09]:
> > > Hi,
> > >=20
> > > This set contains PRCM related cleanups meant for 3.18 merge window.
> > > These are based on top of 3.17-rc1 + the PRM set from Nishanth Menon
> > > (http://article.gmane.org/gmane.linux.ports.arm.kernel/350305.) Nisha=
nth's
> > > set is used as basis to avoid merge issues.
> > >=20
> > > Purpose of this work is to eventually convert the PRCM code into a
> > > separate driver, but this is done in incremental parts as the amount
> > > of changes is substantial. Expected conclusion of this work is 3.19
> > > if everything goes fine.
> > >=20
> > > This part of the work mostly moves some of the SoC specific PRCM driv=
er
> > > calls under generic version of the same, and adds SoC-ops to support
> > > these on the driver level.
> > >=20
> > > Working branch posted here:
> > >=20
> > > tree: https://github.com/t-kristo/linux-pm.git
> > > branch: for-v3.18/prcm-cleanup
> >=20
> > Paul, any comments on this series?
>=20
> Just gave this branch a quick try, it seems to work with off-idle
> for me when merged with current linux-omap master branch. The following
> merge resolution is needed because of the recent pre es3.1 fix though.
>=20
> I've pushed out this merged with all the other pending patches into
> omap-for-v3.18/tmp-merge-2014-09-18.

Ran the tests here, they seemed to pass:

http://www.pwsan.com/omap/testlogs/tmp-merge-2014-09-18/20140918132302/

However, I saw the following crash at boot on 37xxevm during one of
the boot test.  Ran thirty more boot tests afterwards on that board
and it did not recur.  It seems unlikely that the problem is related
to this series, but looks like we may have some intermittent boot
failure or race on 37xx :-(


- Paul


Texas Instruments X-Loader 1.47 (Jan 14 2011 - 15:43:28)
Starting X-loader on MMC
Reading boot sector

212836 Bytes Read from MMC
Starting OS Bootloader from MMC...
Starting OS Bootloader...


U-Boot 2010.06 (Jan 14 2011 - 15:43:45)

OMAP34xx/35xx-GP ES2.1, CPU-OPP2 L3-165MHz
OMAP3 EVM board + LPDDR/NAND
I2C:   ready
DRAM:  256 MiB
NAND:  512 MiBhelp |230400 8N1 | NOR | script /home/p | VT102 |      Offlin=
e                                    =20
In:    serial
Out:   serial
Err:   serial
Read back SMSC id 0x92200000
Die ID #368000229ff80000016071640902c013
Net:   smc911x-0
Hit any key to stop autoboot:  0=20
OMAP3_EVM #=20
OMAP3_EVM #=20
OMAP3_EVM # dhcp
smc911x: detected LAN9220 controller
smc911x: phy initialized
smc911x: MAC 00:50:c2:7e:99:42
BOOTP broadcast 1
DHCP client bound to address 192.168.57.131
Using smc911x-0 device
TFTP from server 192.168.57.1; our IP address is 192.168.57.131
Filename 'uImage-dtb.omap3-evm-37xx'.
Load address: 0x82000000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #########################
done
Bytes transferred =3D 4452813 (43f1cd hex)
OMAP3_EVM # setenv bootargs console=3DttyO0,115200n8 ignore_loglevel earlyp=
rintk root=3D/dev/nfs nfsroot=3D192.168.57.1:/srv/nfs4/rootfs2 nfsrootdebug=
 ip=3Ddhcp init=3D/bin/sh
OMAP3_EVM #=20
OMAP3_EVM # bootm
## Booting kernel from Legacy Image at 82000000 ...
   Image Name:   Linux-
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    4452749 Bytes =3D 4.2 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.17.0-rc5-12866-g0164b2d (paul@nozomi) (gcc v=
ersion 4.7.2 (Debian 4.7.2-5) ) #1 SMP=20
Thu Sep 18 13:29:12 MDT 2014
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=3D10c=
5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instr=
uction cache
[    0.000000] Machine model: TI OMAP37XX EVM (TMDSEVM3730)
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] cma: Reserved 16 MiB at 8e800000
[    0.000000] Memory policy: Data cache writeback
[    0.000000] On node 0 totalpages: 65280
[    0.000000] free_area_init_node: node 0, pgdat c08c5480, node_mem_map cf=
cf1000
[    0.000000]   Normal zone: 512 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 65280 pages, LIFO batch:15
[    0.000000]   HighMem zone: 1048574 pages exceeds freesize 0
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
[    0.000000] PERCPU: Embedded 9 pages/cpu @cfc7d000 s14336 r8192 d14336 u=
36864
[    0.000000] pcpu-alloc: s14336 r8192 d14336 u36864 alloc=3D9*4096
[    0.000000] pcpu-alloc: [0] 0=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 64768
[    0.000000] Kernel command line: console=3DttyO0,115200n8 ignore_logleve=
l earlyprintk root=3D/dev/nfs nfsroot=3D192.168.57.1:/srv/nfs4/rootfs2 nfsr=
ootdebug ip=3Ddhcp init=3D/bin/sh
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 byt=
es)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes=
)
[    0.000000] Memory: 224708K/261120K available (5700K kernel code, 643K r=
wdata, 2212K rodata, 406K init, 8211K bss, 36412K reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc07c239c   (7913 kB)
[    0.000000]       .init : 0xc07c3000 - 0xc0828800   ( 406 kB)
[    0.000000]       .data : 0xc082a000 - 0xc08caf08   ( 644 kB)
[    0.000000]        .bss : 0xc08caf08 - 0xc10cfba0   (8212 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=3D2 to nr_cpu_ids=3D1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 inte=
rrupts
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000030] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps eve=
ry 65536000000000ns
[    0.000061] OMAP clocksource: 32k_counter at 32768 Hz
[    0.001068] Console: colour dummy device 80x30
[    0.001159] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar
[    0.001159] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.001190] ... MAX_LOCK_DEPTH:          48
[    0.001190] ... MAX_LOCKDEP_KEYS:        8191
[    0.001190] ... CLASSHASH_SIZE:          4096
[    0.001220] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.001220] ... MAX_LOCKDEP_CHAINS:      65536
[    0.001251] ... CHAINHASH_SIZE:          32768
[    0.001251]  memory used by lock dependency info: 5167 kB
[    0.001251]  per task-struct memory footprint: 1152 bytes
[    0.001312] Calibrating delay loop... 594.73 BogoMIPS (lpj=3D2973696)
[    0.107604] pid_max: default: 32768 minimum: 301
[    0.108154] Security Framework initialized
[    0.108337] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.108367] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 by=
tes)
[    0.111602] CPU: Testing write buffer coherency: ok
[    0.113189] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.113311] Setting up static identity map for 0x80566f40 - 0x80566fb0
[    0.118041] Brought up 1 CPUs
[    0.118072] SMP: Total of 1 processors activated.
[    0.118072] CPU: All CPU(s) started in SVC mode.
[    0.121765] devtmpfs: initialized
[    0.124145] VFP support v0.3: implementor 41 architecture 3 part 30 vari=
ant c rev 3
[    0.205780] omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
[    0.208160] omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
[    0.316955] pinctrl core: initialized pinctrl subsystem
[    0.320739] regulator-dummy: no parameters
[    0.415618] NET: Registered protocol family 16
[    0.424682] DMA: preallocated 256 KiB pool for atomic coherent allocatio=
ns
[    0.428741] cpuidle: using governor ladder
[    0.428771] cpuidle: using governor menu
[    0.428985] omap_l3_smx omap_l3_smx.0: couldn't request debug irq
[    0.429107] omap_l3_smx: probe of omap_l3_smx.0 failed with error -22
[    0.437469] Reprogramming SDRC clock to 400000000 Hz
[    0.451354] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.452606] OMAP GPIO hardware version 2.5
[    0.454620] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.457519] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.460266] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.462921] gpiochip_add: registered GPIOs 128 to 159 on device: gpio
[    0.465667] gpiochip_add: registered GPIOs 160 to 191 on device: gpio
[    0.467254] irq: no irq domain found for /ocp/pinmux@48002030 !
[    0.468170] irq: no irq domain found for /ocp/pinmux@48002030 !
[    0.469055] irq: no irq domain found for /ocp/pinmux@48002030 !
[    0.494537] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
[    0.496124] gpmc_probe_nand_child: ti,elm-id property not found
[    0.496337] gpmc_cs_program_settings: invalid width 0!
[    0.499053] platform 48058000.ssi-controller: Cannot lookup hwmod 'ssi'
[    0.507843] No ATAGs?
[    0.507904] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.511413] OMAP DMA hardware revision 5.0
[    0.554107] edma-dma-engine edma-dma-engine.0: Can't allocate PaRAM dumm=
y slot
[    0.554199] edma-dma-engine: probe of edma-dma-engine.0 failed with erro=
r -22
[    0.608306] omap-dma-engine 48056000.dma-controller: OMAP DMA engine dri=
ver
[    0.609619] of_get_named_gpiod_flags: can't parse 'gpio' property of nod=
e '/regulator-vddvario[0]'
[    0.610504] vddvario: no parameters
[    0.611114] of_get_named_gpiod_flags: can't parse 'gpio' property of nod=
e '/regulator-vdd33a[0]'
[    0.611663] vdd33a: no parameters
[    0.612304] reg-fixed-voltage wl12xx_vmmc: could not find pctldev for no=
de /ocp/pinmux@48002030/pinmux_wl12xx_gpio, deferring probe
[    0.612365] platform wl12xx_vmmc: Driver reg-fixed-voltage requests prob=
e deferral
[    0.612609] of_get_named_gpiod_flags: parsed 'gpio' property of node '/r=
egulator-lcd-3v3[0]' - status (0)
[    0.613494] lcd_3v3: 3300 mV=20
[    0.619995] SCSI subsystem initialized
[    0.621185] usbcore: registered new interface driver usbfs
[    0.621459] usbcore: registered new interface driver hub
[    0.622009] usbcore: registered new device driver usb
[    0.779907] omap_i2c 48070000.i2c: bus 0 rev4.4 at 2600 kHz
[    0.781829] omap_i2c 48072000.i2c: bus 1 rev4.4 at 400 kHz
[    0.785583] omap_i2c 48060000.i2c: bus 2 rev4.4 at 400 kHz
[    0.793243] Switched to clocksource 32k_counter
[    1.008422] NET: Registered protocol family 2
[    1.010833] TCP established hash table entries: 2048 (order: 1, 8192 byt=
es)
[    1.011077] TCP bind hash table entries: 2048 (order: 4, 73728 bytes)
[    1.012329] TCP: Hash tables configured (established 2048 bind 2048)
[    1.012542] TCP: reno registered
[    1.012573] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    1.012908] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    1.014556] NET: Registered protocol family 1
[    1.016998] RPC: Registered named UNIX socket transport module.
[    1.017028] RPC: Registered udp transport module.
[    1.017059] RPC: Registered tcp transport module.
[    1.017059] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.018890] hw perfevents: enabled with armv7_cortex_a8 PMU driver, 5 co=
unters available
[    1.027038] futex hash table entries: 256 (order: 2, 16384 bytes)
[    1.033843] VFS: Disk quotas dquot_6.5.2
[    1.034057] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.037384] NFS: Registering the id_resolver key type
[    1.037872] Key type id_resolver registered
[    1.037902] Key type id_legacy registered
[    1.038116] jffs2: version 2.2. (NAND) (SUMMARY)  ?=A9 2001-2006 Red Hat=
, Inc.
[    1.038757] msgmni has been set to 470
[    1.047607] io scheduler noop registered
[    1.047637] io scheduler deadline registered
[    1.047729] io scheduler cfq registered (default)
[    1.051757] pinctrl-single 48002030.pinmux: 284 pins at pa fa002030 size=
 568
[    1.052673] pinctrl-single 48002a00.pinmux: 46 pins at pa fa002a00 size =
92
[    1.053771] pinctrl-single 480025a0.pinmux: 46 pins at pa fa0025a0 size =
92
[    1.057189] pbias_mmc_omap2430: 1800 <--> 3000 mV at 3000 mV=20
[    1.059509] abb_mpu_iva: 1012 <--> 1375 mV=20
[    1.061737] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.071899] of_get_named_gpiod_flags: can't parse 'rts-gpio' property of=
 node '/ocp/serial@4806a000[0]'
[    1.072875] 4806a000.serial: ttyO0 at MMIO 0x4806a000 (irq =3D 224, base=
_baud =3D 3000000) is a OMAP UART0
[    1.977722] console [ttyO0] enabled
[    1.985351] of_get_named_gpiod_flags: can't parse 'rts-gpio' property of=
 node '/ocp/serial@4806c000[0]'
[    1.995727] 4806c000.serial: ttyO1 at MMIO 0x4806c000 (irq =3D 225, base=
_baud =3D 3000000) is a OMAP UART1
[    2.014007] of_get_named_gpiod_flags: can't parse 'rts-gpio' property of=
 node '/ocp/serial@49020000[0]'
[    2.024353] 49020000.serial: ttyO2 at MMIO 0x49020000 (irq =3D 226, base=
_baud =3D 3000000) is a OMAP UART2
[    2.036285] omap_uart 49042000.serial: no wakeirq for uart0
[    2.042297] of_get_named_gpiod_flags: can't parse 'rts-gpio' property of=
 node '/ocp/serial@49042000[0]'
[    2.052581] 49042000.serial: ttyO3 at MMIO 0x49042000 (irq =3D 260, base=
_baud =3D 3000000) is a OMAP UART3
[    2.109252] brd: module loaded
[    2.136108] loop: module loaded
[    2.160552] twl 0-0048: PIH (irq 294) chaining IRQs 298..306
[    2.167144] twl 0-0048: power (irq 303) chaining IRQs 306..313
[    2.184173] VAUX1: at 3000 mV=20
[    2.192749] VAUX2_4030: at 1800 mV=20
[    2.200714] VAUX3: at 2800 mV=20
[    2.212615] VAUX4: at 2800 mV=20
[    2.220214] VDD1: 600 <--> 1450 mV at 1200 mV=20
[    2.229949] VDAC: 1800 mV=20
[    2.239624] VIO: at 1800 mV=20
[    2.247985] VINTANA1: 1500 mV=20
[    2.256774] VINTANA2: at 2750 mV=20
[    2.265624] VINTDIG: 1500 mV=20
[    2.272277] VMMC1: 1850 <--> 3150 mV at 3000 mV=20
[    2.281951] VMMC2: 1850 <--> 3150 mV at 2600 mV=20
[    2.291107] VUSB1V5: 1500 mV=20
[    2.296752] VUSB1V8: 1800 mV=20
[    2.301879] VUSB3V1: 3100 mV=20
[    2.310089] VPLL1: at 1800 mV=20
[    2.319671] VPLL2: 1800 mV=20
[    2.326751] VSIM: 1800 <--> 3000 mV at 1800 mV=20
[    2.335571] twl4030_gpio twl4030-gpio: gpio (irq 298) chaining IRQs 314.=
=2E331
[    2.344512] gpiochip_find_base: found new base at 492
[    2.350799] gpiochip_add: registered GPIOs 492 to 511 on device: twl4030
[    2.433349] mtdoops: mtd device (mtddev=3Dname/number) must be supplied
[    2.471710] libphy: smsc911x-mdio: probed
[    2.476654] smsc911x 2c000000.ethernet eth0: attached PHY driver [SMSC L=
AN8700] (mii_bus:phy_addr=3D2c000000.ethe
rne:01, irq=3D-1)
[    2.489044] smsc911x 2c000000.ethernet eth0: MAC Address: 00:50:c2:7e:99=
:42
[    2.498687] usbcore: registered new interface driver asix
[    2.504730] usbcore: registered new interface driver ax88179_178a
[    2.511352] usbcore: registered new interface driver cdc_ether
[    2.517852] usbcore: registered new interface driver smsc95xx
[    2.524200] usbcore: registered new interface driver net1080
[    2.530364] usbcore: registered new interface driver cdc_subset
[    2.536895] usbcore: registered new interface driver zaurus
[    2.543151] usbcore: registered new interface driver cdc_ncm
[    2.551086] usbcore: registered new interface driver cdc_wdm
[    2.557525] usbcore: registered new interface driver usb-storage
[    2.564208] usbcore: registered new interface driver usbtest
[    2.574462] mousedev: PS/2 mouse device common for all mice
[    2.581848] twl4030_keypad 48070000.i2c:twl@48:keypad: OF: linux,keymap =
property not defined in /ocp/i2c@48070000/twl@48/keypad
[    2.594085] twl4030_keypad 48070000.i2c:twl@48:keypad: Failed to build k=
eymap
[    2.601684] twl4030_keypad: probe of 48070000.i2c:twl@48:keypad failed w=
ith error -2
[    2.611633] of_get_named_gpiod_flags: parsed 'pendown-gpio' property of =
node '/ocp/spi@48098000/tsc2046@0[0]' - status (0)
[    2.703765] ads7846 spi1.0: touchscreen, irq 207
[    2.711456] input: ADS7846 Touchscreen as /devices/68000000.ocp/48098000=
=2Espi/spi_master/spi1/spi1.0/input/input1
[    2.729522] input: twl4030_pwrbutton as /devices/68000000.ocp/48070000.i=
2c/i2c-0/0-0048/48070000.i2c:twl@48:pwrbutton/input/input2
[    2.746917] twl_rtc 48070000.i2c:twl@48:rtc: Power up reset detected.
[    2.754852] twl_rtc 48070000.i2c:twl@48:rtc: Enabling TWL-RTC
[    2.766296] twl_rtc 48070000.i2c:twl@48:rtc: rtc core: registered 480700=
00.i2c:twl@48 as rtc0
[    2.777374] i2c /dev entries driver
[    2.785491] Driver for 1-wire Dallas network protocol.
[    2.795928] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60 s=
ec
[    2.809204] of_get_named_gpiod_flags: can't parse 'cd-gpios' property of=
 node '/ocp/mmc@4809c000[0]'
[    2.819000] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of=
 node '/ocp/mmc@4809c000[0]'
[    2.882751] of_get_named_gpiod_flags: can't parse 'cd-gpios' property of=
 node '/ocp/mmc@480b4000[0]'
[    2.892486] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of=
 node '/ocp/mmc@480b4000[0]'
[    2.902984] omap_hsmmc 480b4000.mmc: unable to get vmmc regulator -517
[    2.910522] platform 480b4000.mmc: Driver omap_hsmmc requests probe defe=
rral
[    2.919433] of_get_named_gpiod_flags: parsed 'gpios' property of node '/=
leds/ledb[0]' - status (0)
[    2.929016] of_get_named_gpiod_flags: parsed 'gpios' property of node '/=
leds/ledb[0]' - status (0)
[    2.944396] ledtrig-cpu: registered to indicate activity on CPUs
[    2.952117] usbcore: registered new interface driver usbhid
[    2.958007] usbhid: USB HID core driver
[    2.964782] oprofile: using arm/armv7
[    2.969543] TCP: cubic registered
[    2.973144] Initializing XFRM netlink socket
[    2.977813] NET: Registered protocol family 17
[    2.982666] NET: Registered protocol family 15
[    2.987823] Key type dns_resolver registered
[    2.992767] omap2_set_init_voltage: unable to find boot up OPP for vdd_m=
pu_iva
[    3.000396] omap2_set_init_voltage: unable to set vdd_mpu_iva
[    3.006530] omap2_set_init_voltage: unable to find boot up OPP for vdd_c=
ore
[    3.013916] omap2_set_init_voltage: unable to set vdd_core
[    3.024597] ThumbEE CPU extension supported.
[    3.029174] Registering SWP/SWPB emulation handler
[    3.034301] SmartReflex Class3 initialized
[    3.054931] of_get_named_gpiod_flags: parsed 'gpio' property of node '/w=
l12xx_vmmc[0]' - status (0)
[    3.065643] vwl1271: 1800 mV=20
[    3.069000] vwl1271: supplied by VMMC2
[    3.074829] of_get_named_gpiod_flags: can't parse 'cd-gpios' property of=
 node '/ocp/mmc@480b4000[0]'
[    3.084533] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of=
 node '/ocp/mmc@480b4000[0]'
[    3.204681] mmc0: host does not support reading read-only switch. assumi=
ng write-enable.
[    3.213531] mmc0: new SDHC card at address e624
[    3.221923] mmcblk0: mmc0:e624 SD08G 7.40 GiB=20
[    3.233978] twl_rtc 48070000.i2c:twl@48:rtc: setting system clock to 200=
0-01-01 00:00:00 UTC (946684800)
[    3.244171] sr_init: No PMIC hook to init smartreflex
[    3.250122] smartreflex smartreflex.0: omap_sr_probe: SmartReflex driver=
 initialized
[    3.259307] smartreflex smartreflex.1: omap_sr_probe: SmartReflex driver=
 initialized
[    3.342926] smsc911x 2c000000.ethernet eth0: SMSC911x/921x identified at=
 0xd087c000, IRQ: 208
[    3.369903]  mmcblk0: p1 p2 p3
[    4.892211] Unhandled fault: external abort on non-linefetch (0x1028) at=
 0xfa318034
[    4.900299] Internal error: : 1028 [#1] SMP ARM
[    4.905090] Modules linked in:
[    4.908325] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.17.0-rc5-12866-g=
0164b2d #1
[    4.916320] task: c0835db0 ti: c082a000 task.ti: c082a000
[    4.922027] PC is at omap2_gp_timer_set_next_event+0x24/0x78
[    4.928009] LR is at clockevents_program_event+0xc0/0x148
[    4.933715] pc : [<c002622c>]    lr : [<c00a2800>]    psr: 00000193
[    4.933715] sp : c082bed8  ip : 00000000  fp : 00000000
[    4.945800] r10: 00000000  r9 : 24101100  r8 : c0839080
[    4.951324] r7 : 00000001  r6 : 237bc339  r5 : 0000009f  r4 : 3d9759e7
[    4.958190] r3 : fa318034  r2 : c08cb920  r1 : 00000003  r0 : fffffec1
[    4.965087] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segmen=
t kernel
[    4.972900] Control: 10c5387d  Table: 80004019  DAC: 00000015     =20
[    4.978942] Process swapper/0 (pid: 0, stack limit =3D 0xc082a248)  =20
[    4.985290] Stack: (0xc082bed8 to 0xc082c000)
[    4.989868] bec0:                                                       =
237bc339 00000001
[    4.998504] bee0: 00000001 24101100 00000001 cfc7d6c8 00000001 cfc7da50 =
cfc7d720 c00a4780
[    5.007141] bf00: 00000000 c00962b0 cfc7d720 c0096180 00000001 00000000 =
00000001 c08256c8
[    5.015777] bf20: c082a000 c08256c8 00000000 c00962b0 237b4c04 00000001 =
00000002 a0000193
[    5.024414] bf40: 00989680 00000000 00000000 24101100 00000001 cfc7da50 =
00000000 c108cc78
[    5.033020] bf60: 00000000 c00962b0 00000000 00000002 00000001 00000000 =
c108cc78 c00a56f0
[    5.041656] bf80: 00000000 00000002 237b4c04 00000001 c08c8ce8 c082a000 =
00000000 c08c8ce8
[    5.050292] bfa0: c08329dc c0832978 cfc7f0f8 c0072808 c0559928 c08270f0 =
c08caf40 c080fdc0
[    5.058929] bfc0: 00000000 c07c3b74 ffffffff ffffffff c07c35f0 00000000 =
00000000 c080fdc0
[    5.067535] bfe0: c08cb154 c0832968 c080fdbc c083763c 80004059 80008074 =
00000000 00000000
[    5.076171] [<c002622c>] (omap2_gp_timer_set_next_event) from [<c00a2800=
>] (clockevents_program_event+0xc0/0x148)
[    5.087005] [<c00a2800>] (clockevents_program_event) from [<c00a4780>] (=
tick_program_event+0x44/0x54)
[    5.096771] [<c00a4780>] (tick_program_event) from [<c0096180>] (__hrtim=
er_start_range_ns+0x3c0/0x4a0)
[    5.106597] [<c0096180>] (__hrtimer_start_range_ns) from [<c00962b0>] (h=
rtimer_start_range_ns+0x24/0x2c)
[    5.116577] [<c00962b0>] (hrtimer_start_range_ns) from [<c00a56f0>] (tic=
k_nohz_idle_exit+0x140/0x1ec)
[    5.126342] [<c00a56f0>] (tick_nohz_idle_exit) from [<c0072808>] (cpu_st=
artup_entry+0xf4/0x2d0)
[    5.135528] [<c0072808>] (cpu_startup_entry) from [<c07c3b74>] (start_ke=
rnel+0x340/0x3a8)
[    5.144165] [<c07c3b74>] (start_kernel) from [<80008074>] (0x80008074)
[    5.151031] Code: 13a0c000 0a000004 ee07cfba e592301c (e5931000)=20
[    5.157470] ---[ end trace f92de024d996d904 ]---
[    5.162353] Kernel panic - not syncing: Attempted to kill the idle task!
[    5.169433] ---[ end Kernel panic - not syncing: Attempted to kill the i=
dle task!

--843723315-1686613828-1411144684=:22526--
