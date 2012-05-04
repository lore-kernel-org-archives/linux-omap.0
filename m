From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: ttyO2 broken on IGEPv2 on 3.3, 3.4-rc5 or arm-soc/for-next, working
 on 3.2
Date: Fri, 4 May 2012 15:52:55 +0200
Message-ID: <20120504155255.140b4e3f@skate>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/_i/pUlqCpr6pR3kVb68xou9"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:53539 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757206Ab2EDNxM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 09:53:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

--MP_/_i/pUlqCpr6pR3kVb68xou9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I have an IGEPv2 revision 6 board, which uses the DM3730 OMAP3. With
3.2 omap2plus_defconfig, the system boots fine and have a working shell
on ttyO2. On either 3.3, 3.4-rc5 or arm-soc/for-next from Arnd, the
system boots all the way up to showing the shell prompt, but I can't
type any character, as if UART RX was broken.

All the kernel versions have been tested with identical bootloaders and
identical setup, so there is apparently no misconfiguration of my serial
terminal program regarding flow control or things like that.

I have seen that there has been multiple changes to the OMAP UART code
between 3.2 and 3.3, but a git bisect attempt has failed miserably due
to numerous build issues in the OMAP code at various points of the
bisection.

I am attaching the boot logs for 3.2 (working), 3.3 (not working) and
3.4-rc5 (not working) in case this is of any help.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

--MP_/_i/pUlqCpr6pR3kVb68xou9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=bootlog-3.2.txt

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.2.0-00002-g7892880 (thomas@skate) (gcc versi=
on 4.5.2 (Sourcery G++ Lite 2011.03-41) ) #4 SMP Fri May 4 14:24:20 CEST 20=
12
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=3D10c=
53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instr=
uction cache
[    0.000000] Machine: IGEP v2 board
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/200/600 MHz
[    0.000000] PERCPU: Embedded 8 pages/cpu @c103d000 s10112 r8192 d14464 u=
32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 130048
[    0.000000] Kernel command line: init=3D/bin/sh mtdparts=3Domap2-nand.0:=
6m(boot),6m(rootfs) rootfstype=3Djffs2 root=3D/dev/mtdblock1 console=3DttyO=
2,115200
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 byt=
es)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 byte=
s)
[    0.000000] Memory: 512MB =3D 512MB total
[    0.000000] Memory: 507236k/507236k available, 17052k reserved, 0K highm=
em
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xf8000000   ( 376 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc060b388   (6157 kB)
[    0.000000]       .init : 0xc060c000 - 0xc0658780   ( 306 kB)
[    0.000000]       .data : 0xc065a000 - 0xc06e0970   ( 539 kB)
[    0.000000]        .bss : 0xc06e0994 - 0xc0c34f20   (5458 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:410
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 inte=
rrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps eve=
ry 131071999ms
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
[    0.001068] Calibrating delay loop... 597.64 BogoMIPS (lpj=3D2334720)
[    0.085876] pid_max: default: 32768 minimum: 301
[    0.086822] Security Framework initialized
[    0.087188] Mount-cache hash table entries: 512
[    0.092681] CPU: Testing write buffer coherency: ok
[    0.093994] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.096527] Brought up 1 CPUs
[    0.096527] SMP: Total of 1 processors activated (597.64 BogoMIPS).
[    0.101379] devtmpfs: initialized
[    0.125549] print_constraints: dummy:=20
[    0.128540] NET: Registered protocol family 16
[    0.130126] GPMC revision 5.0
[    0.148162] OMAP GPIO hardware version 2.5
[    0.171112] omap_mux_init: Add partition: #1: core, flags: 0
[    0.174163] IGEP2: Hardware Revision C (B-NON compatible)
[    0.188110] Reprogramming SDRC clock to 200000000 Hz
[    0.188140] dpll3_m2_clk rate change failed: -22
[    0.189605] IGEP: initializing NAND memory device
[    0.208648] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.243743]  omap-mcbsp.2: alias fck already exists
[    0.245239]  omap-mcbsp.3: alias fck already exists
[    0.255187] OMAP DMA hardware revision 5.0
[    0.378997] bio: create slab <bio-0> at 0
[    0.385559] print_constraints: vwlan: 3300 mV normal=20
[    0.396392] SCSI subsystem initialized
[    0.410797] usbcore: registered new interface driver usbfs
[    0.412902] usbcore: registered new interface driver hub
[    0.414855] usbcore: registered new device driver usb
[    0.430450] omap_i2c omap_i2c.3: bus 3 rev1.4.0 at 100 kHz
[    0.445648] omap_i2c omap_i2c.1: bus 1 rev1.4.0 at 2600 kHz
[    0.458923] twl4030: PIH (irq 7) chaining IRQs 368..375
[    0.459777] twl4030: power (irq 373) chaining IRQs 376..383
[    0.463439] twl4030: gpio (irq 368) chaining IRQs 384..401
[    0.465698] _omap_mux_init_gpio: Could not set gpio192
[    0.487487] print_constraints: VIO: 1800 mV normal standby
[    0.491027] print_constraints: VMMC1: 1850 <--> 3150 mV at 3000 mV norma=
l standby
[    0.495086] print_constraints: VDVI: 1800 mV normal standby
[    0.509552] Switching to clocksource 32k_counter
[    0.708190] NET: Registered protocol family 2
[    0.709472] IP route cache hash table entries: 4096 (order: 2, 16384 byt=
es)
[    0.712280] TCP established hash table entries: 16384 (order: 5, 131072 =
bytes)
[    0.713043] TCP bind hash table entries: 16384 (order: 7, 589824 bytes)
[    0.722534] TCP: Hash tables configured (established 16384 bind 16384)
[    0.722717] TCP reno registered
[    0.722778] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.723114] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.724304] NET: Registered protocol family 1
[    0.726348] RPC: Registered named UNIX socket transport module.
[    0.726379] RPC: Registered udp transport module.
[    0.726409] RPC: Registered tcp transport module.
[    0.726409] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.727539] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.906768] VFS: Disk quotas dquot_6.5.2
[    0.907165] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.911590] JFFS2 version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 Red Ha=
t, Inc.
[    0.913177] msgmni has been set to 990
[    0.920104] io scheduler noop registered
[    0.920135] io scheduler deadline registered
[    0.920440] io scheduler cfq registered (default)
[    0.927368] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.940551] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is a OMAP=
 UART0
[    0.943267] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73) is a OMAP=
 UART1
[    0.945373] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74) is a OMAP=
 UART2
[    1.555114] console [ttyO2] enabled
[    1.561309] omap_uart.3: ttyO3 at MMIO 0x49042000 (irq =3D 80) is a OMAP=
 UART3
[    1.633819] brd: module loaded
[    1.673492] loop: module loaded
[    1.691589] mtdoops: mtd device (mtddev=3Dname/number) must be supplied
[    1.698669] omap2-nand driver initializing
[    1.703674] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xbc (Micron NA=
ND 512MiB 1,8V 16-bit)
[    1.713012] 2 cmdlinepart partitions found on MTD device omap2-nand.0
[    1.719909] Creating 2 MTD partitions on "omap2-nand.0":
[    1.725585] 0x000000000000-0x000000600000 : "boot"
[    1.745971] 0x000000600000-0x000000c00000 : "rootfs"
[    1.763824] OneNAND driver initializing
[    1.780822] smsc911x: Driver version 2008-10-21
[    1.797454] smsc911x-mdio: probed
[    1.801513] smsc911x smsc911x.0: eth0: attached PHY driver [SMSC LAN8700=
] (mii_bus:phy_addr=3D0:01, irq=3D-1)
[    1.812164] smsc911x smsc911x.0: eth0: MAC Address: 96:f8:f1:e1:86:64
[    1.821289] usbcore: registered new interface driver asix
[    1.828369] usbcore: registered new interface driver cdc_ether
[    1.835876] usbcore: registered new interface driver net1080
[    1.843139] usbcore: registered new interface driver cdc_subset
[    1.850677] usbcore: registered new interface driver zaurus
[    1.856811] cdc_ncm: 04-Aug-2011
[    1.861297] usbcore: registered new interface driver cdc_ncm
[    1.871917] usbcore: registered new interface driver cdc_wdm
[    1.878082] Initializing USB Mass Storage driver...
[    1.884399] usbcore: registered new interface driver usb-storage
[    1.890960] USB Mass Storage support registered.
[    1.897888] usbcore: registered new interface driver libusual
[    1.905334] usbcore: registered new interface driver usbtest
[    1.915191] mousedev: PS/2 mouse device common for all mice
[    1.925628] input: TWL4030 Keypad as /devices/platform/omap/omap_i2c.1/i=
2c-1/1-004a/twl4030_keypad/input/input0
[    1.950042] input: twl4030_pwrbutton as /devices/platform/omap/omap_i2c.=
1/i2c-1/1-0049/twl4030_pwrbutton/input/input1
[    1.965148] twl_rtc twl_rtc: Power up reset detected.
[    1.971038] twl_rtc twl_rtc: Enabling TWL-RTC.
[    1.981567] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    1.990814] i2c /dev entries driver
[    2.000640] Driver for 1-wire Dallas network protocol.
[    2.013977] OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
[    2.022247] twl4030_wdt twl4030_wdt: Failed to register misc device
[    2.029388] twl4030_wdt: probe of twl4030_wdt failed with error -16
[    2.276824] usbcore: registered new interface driver usbhid
[    2.282684] usbhid: USB HID core driver
[    2.286987] oprofile: hardware counters not available
[    2.292449] oprofile: using timer interrupt.
[    2.297790] TCP cubic registered
[    2.301330] Initializing XFRM netlink socket
[    2.306091] NET: Registered protocol family 17
[    2.311004] NET: Registered protocol family 15
[    2.316314] Registering the dns_resolver key type
[    2.322357] VFP support v0.3: implementor 41 architecture 3 part 30 vari=
ant c rev 3
[    2.330810] ThumbEE CPU extension supported.
[    2.388092] clock: disabling unused clocks to save power
[    2.401214] regulator_init_complete: VDVI: incomplete constraints, leavi=
ng on
[    2.412658] twl_rtc twl_rtc: setting system clock to 2000-01-01 00:00:00=
 UTC (946684800)
[    2.475097] Empty flash at 0x002a1574 ends at 0x002a1800
[    2.508087] JFFS2 notice: (1) jffs2_build_xattr_subsystem: complete buil=
ding xattr subsystem, 0 of xdatum (0 unchecked, 0 orphan) and 0 of xref (0 =
dead, 0 orphan) found.
[    2.530731] VFS: Mounted root (jffs2 filesystem) on device 31:1.
[    2.550292] mmc1: new SDIO card at address 0001
[    2.578765] devtmpfs: mounted
[    2.582641] Freeing init memory: 304K
/bin/sh: can't access tty; job control turned off
/ #=20
/ # ls
bin      etc      lib      media    opt      root     sbin     tmp      var
dev      home     linuxrc  mnt      proc     run      sys      usr
/ # pwd
/

--MP_/_i/pUlqCpr6pR3kVb68xou9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=bootlog-3.3.txt

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.3.3-00002-gb127925 (thomas@skate) (gcc versi=
on 4.5.2 (Sourcery G++ Lite 2011.03-41) ) #3 SMP Fri May 4 13:57:24 CEST 20=
12
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=3D10c=
53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instr=
uction cache
[    0.000000] Machine: IGEP v2 board
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/200/600 MHz
[    0.000000] PERCPU: Embedded 8 pages/cpu @c105e000 s10880 r8192 d13696 u=
32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 129792
[    0.000000] Kernel command line: init=3D/bin/sh mtdparts=3Domap2-nand.0:=
6m(boot),6m(rootfs) rootfstype=3Djffs2 root=3D/dev/mtdblock1 console=3DttyO=
2,115200
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 byt=
es)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 byte=
s)
[    0.000000] Memory: 511MB =3D 511MB total
[    0.000000] Memory: 506076k/506076k available, 18212k reserved, 0K highm=
em
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc06259bc   (6263 kB)
[    0.000000]       .init : 0xc0626000 - 0xc0672a80   ( 307 kB)
[    0.000000]       .data : 0xc0674000 - 0xc06ffb50   ( 559 kB)
[    0.000000]        .bss : 0xc06ffb74 - 0xc0c5581c   (5464 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:474
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 inte=
rrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps eve=
ry 131071999ms
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
[    0.001037] Calibrating delay loop... 597.64 BogoMIPS (lpj=3D2334720)
[    0.085876] pid_max: default: 32768 minimum: 301
[    0.086822] Security Framework initialized
[    0.087158] Mount-cache hash table entries: 512
[    0.092987] CPU: Testing write buffer coherency: ok
[    0.094421] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.094482] Setting up static identity map for 0x80478af8 - 0x80478b68
[    0.097106] Brought up 1 CPUs
[    0.097137] SMP: Total of 1 processors activated (597.64 BogoMIPS).
[    0.102111] devtmpfs: initialized
[    0.115844] omap_hwmod: usbtll_fck: missing clockdomain for usbtll_fck.
[    0.127197] print_constraints: dummy:=20
[    0.130187] NET: Registered protocol family 16
[    0.131744] GPMC revision 5.0
[    0.148193] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.149291] OMAP GPIO hardware version 2.5
[    0.150848] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.152648] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.154449] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.156646] gpiochip_add: registered GPIOs 128 to 159 on device: gpio
[    0.158508] gpiochip_add: registered GPIOs 160 to 191 on device: gpio
[    0.169952] omap_mux_init: Add partition: #1: core, flags: 0
[    0.173248] IGEP2: Hardware Revision C (B-NON compatible)
[    0.183990] _omap_mux_get_by_name: Could not find signal gpmc_wait2.uart=
4_tx
[    0.184020] omap_hwmod_mux_init: Could not allocate device mux entry
[    0.184387] Reprogramming SDRC clock to 200000000 Hz
[    0.184417] dpll3_m2_clk rate change failed: -22
[    0.185729] IGEP: initializing NAND memory device
[    0.205200] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.237854]  omap-mcbsp.2: alias fck already exists
[    0.239288]  omap-mcbsp.3: alias fck already exists
[    0.248840] OMAP DMA hardware revision 5.0
[    0.366607] bio: create slab <bio-0> at 0
[    0.373138] print_constraints: vwlan: 3300 mV normal=20
[    0.374847] print_constraints: gpmc_smsc911x: 3300 mV normal standby
[    0.385467] SCSI subsystem initialized
[    0.400817] usbcore: registered new interface driver usbfs
[    0.402770] usbcore: registered new interface driver hub
[    0.404266] usbcore: registered new device driver usb
[    0.408874] omap_i2c omap_i2c.3: bus 3 rev1.4.0 at 100 kHz
[    0.413146] omap_i2c omap_i2c.1: bus 1 rev1.4.0 at 2600 kHz
[    0.426422] twl4030: PIH (irq 7) chaining IRQs 368..375
[    0.427246] twl4030: power (irq 373) chaining IRQs 376..383
[    0.431030] twl4030: gpio (irq 368) chaining IRQs 384..401
[    0.433074] gpiochip_add: registered GPIOs 192 to 211 on device: twl4030
[    0.454315] print_constraints: VIO: 1800 mV normal standby
[    0.458129] print_constraints: VMMC1: 1850 <--> 3150 mV at 3000 mV norma=
l standby
[    0.462036] print_constraints: VDVI: 1800 mV normal standby
[    0.475585] Switching to clocksource 32k_counter
[    0.668914] NET: Registered protocol family 2
[    0.670166] IP route cache hash table entries: 4096 (order: 2, 16384 byt=
es)
[    0.673645] TCP established hash table entries: 16384 (order: 5, 131072 =
bytes)
[    0.674377] TCP bind hash table entries: 16384 (order: 7, 589824 bytes)
[    0.683471] TCP: Hash tables configured (established 16384 bind 16384)
[    0.683685] TCP reno registered
[    0.683746] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.684082] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.685272] NET: Registered protocol family 1
[    0.687683] RPC: Registered named UNIX socket transport module.
[    0.687744] RPC: Registered udp transport module.
[    0.687744] RPC: Registered tcp transport module.
[    0.687774] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.688873] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.859588] VFS: Disk quotas dquot_6.5.2
[    0.860015] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.864318] JFFS2 version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 Red Ha=
t, Inc.
[    0.866027] msgmni has been set to 988
[    0.872161] io scheduler noop registered
[    0.872192] io scheduler deadline registered
[    0.872558] io scheduler cfq registered (default)
[    0.876983] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.888885] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is a OMAP=
 UART0
[    0.892242] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73) is a OMAP=
 UART1
[    0.894775] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74) is a OMAP=
 UART2
[    1.580657] console [ttyO2] enabled
[    1.587402] omap_uart.3: ttyO3 at MMIO 0x49042000 (irq =3D 80) is a OMAP=
 UART3
[    1.655151] brd: module loaded
[    1.692718] loop: module loaded
[    1.709960] mtdoops: mtd device (mtddev=3Dname/number) must be supplied
[    1.717926] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xbc (Micron NA=
ND 512MiB 1,8V 16-bit)
[    1.727264] 2 cmdlinepart partitions found on MTD device omap2-nand.0
[    1.734161] Creating 2 MTD partitions on "omap2-nand.0":
[    1.739807] 0x000000000000-0x000000600000 : "boot"
[    1.759124] 0x000000600000-0x000000c00000 : "rootfs"
[    1.776519] OneNAND driver initializing
[    1.792480] smsc911x: Driver version 2008-10-21
[    1.811126] smsc911x-mdio: probed
[    1.815277] smsc911x smsc911x.0: eth0: attached PHY driver [SMSC LAN8700=
] (mii_bus:phy_addr=3Dsmsc911x-0:01, irq=3D-1)
[    1.826721] smsc911x smsc911x.0: eth0: MAC Address: f2:f5:da:a8:56:a3
[    1.835998] usbcore: registered new interface driver asix
[    1.842651] usbcore: registered new interface driver cdc_ether
[    1.850067] usbcore: registered new interface driver net1080
[    1.857269] usbcore: registered new interface driver cdc_subset
[    1.864746] usbcore: registered new interface driver zaurus
[    1.871887] usbcore: registered new interface driver cdc_ncm
[    1.881988] usbcore: registered new interface driver cdc_wdm
[    1.888183] Initializing USB Mass Storage driver...
[    1.894470] usbcore: registered new interface driver usb-storage
[    1.901062] USB Mass Storage support registered.
[    1.908020] usbcore: registered new interface driver libusual
[    1.915405] usbcore: registered new interface driver usbtest
[    1.925140] mousedev: PS/2 mouse device common for all mice
[    1.935058] input: TWL4030 Keypad as /devices/platform/omap/omap_i2c.1/i=
2c-1/1-004a/twl4030_keypad/input/input0
[    1.957763] input: twl4030_pwrbutton as /devices/platform/omap/omap_i2c.=
1/i2c-1/1-0049/twl4030_pwrbutton/input/input1
[    1.972351] twl_rtc twl_rtc: Power up reset detected.
[    1.978454] twl_rtc twl_rtc: Enabling TWL-RTC.
[    1.988403] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    1.997009] i2c /dev entries driver
[    2.006317] Driver for 1-wire Dallas network protocol.
[    2.019317] OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
[    2.027496] twl4030_wdt twl4030_wdt: Failed to register misc device
[    2.034667] twl4030_wdt: probe of twl4030_wdt failed with error -16
[    2.281738] usbcore: registered new interface driver usbhid
[    2.287597] usbhid: USB HID core driver
[    2.291931] oprofile: hardware counters not available
[    2.297363] oprofile: using timer interrupt.
[    2.302917] TCP cubic registered
[    2.306457] Initializing XFRM netlink socket
[    2.311248] NET: Registered protocol family 17
[    2.316162] NET: Registered protocol family 15
[    2.321502] Registering the dns_resolver key type
[    2.327667] VFP support v0.3: implementor 41 architecture 3 part 30 vari=
ant c rev 3
[    2.336151] ThumbEE CPU extension supported.
[    2.394775] clock: disabling unused clocks to save power
[    2.407501] regulator_init_complete: VDVI: incomplete constraints, leavi=
ng on
[    2.419067] twl_rtc twl_rtc: setting system clock to 2000-01-01 00:00:00=
 UTC (946684800)
[    2.481048] Empty flash at 0x002a1574 ends at 0x002a1800
[    2.514190] JFFS2 notice: (1) jffs2_build_xattr_subsystem: complete buil=
ding xattr subsystem, 0 of xdatum (0 unchecked, 0 orphan) and 0 of xref (0 =
dead, 0 orphan) found.
[    2.536926] VFS: Mounted root (jffs2 filesystem) on device 31:1.
[    2.553131] mmc1: new SDIO card at address 0001
[    2.583312] devtmpfs: mounted
[    2.587188] Freeing init memory: 304K
/bin/sh: can't access tty; job control turned off
/ #=20

--MP_/_i/pUlqCpr6pR3kVb68xou9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=bootlog-3.4-rc5.txt

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.4.0-rc5-00002-ga018052 (thomas@skate) (gcc v=
ersion 4.5.2 (Sourcery G++ Lite 2011.03-41) ) #5 SMP Fri May 4 14:35:33 CES=
T 2012
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=3D10c=
53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instr=
uction cache
[    0.000000] Machine: IGEP v2 board
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/200/600 MHz
[    0.000000] PERCPU: Embedded 8 pages/cpu @c105a000 s11520 r8192 d13056 u=
32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 129792
[    0.000000] Kernel command line: init=3D/bin/sh mtdparts=3Domap2-nand.0:=
6m(boot),6m(rootfs) rootfstype=3Djffs2 root=3D/dev/mtdblock1 console=3DttyO=
2,115200
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 byt=
es)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 byte=
s)
[    0.000000] Memory: 511MB =3D 511MB total
[    0.000000] Memory: 506092k/506092k available, 18196k reserved, 0K highm=
em
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc061dfd4   (6232 kB)
[    0.000000]       .init : 0xc061e000 - 0xc066bd00   ( 312 kB)
[    0.000000]       .data : 0xc066c000 - 0xc06fd7d8   ( 582 kB)
[    0.000000]        .bss : 0xc06fd7fc - 0xc0c51ca0   (5458 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:474
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 inte=
rrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps eve=
ry 131071999ms
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
[    0.001098] Calibrating delay loop... 594.49 BogoMIPS (lpj=3D2322432)
[    0.085876] pid_max: default: 32768 minimum: 301
[    0.086853] Security Framework initialized
[    0.087219] Mount-cache hash table entries: 512
[    0.093627] CPU: Testing write buffer coherency: ok
[    0.095031] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.095092] Setting up static identity map for 0x80473ba0 - 0x80473c10
[    0.097747] Brought up 1 CPUs
[    0.097778] SMP: Total of 1 processors activated (594.49 BogoMIPS).
[    0.102874] devtmpfs: initialized
[    0.127532] dummy:=20
[    0.130676] NET: Registered protocol family 16
[    0.132446] GPMC revision 5.0
[    0.150115] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.150726] OMAP GPIO hardware version 2.5
[    0.152435] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.154602] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.157104] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.159149] gpiochip_add: registered GPIOs 128 to 159 on device: gpio
[    0.161224] gpiochip_add: registered GPIOs 160 to 191 on device: gpio
[    0.174530] omap_mux_init: Add partition: #1: core, flags: 0
[    0.177307] IGEP2: Hardware Revision C (B-NON compatible)
[    0.185668] ------------[ cut here ]------------
[    0.185729] WARNING: at /home/thomas/projets/linux-2.6/fs/sysfs/dir.c:50=
8 sysfs_add_one+0x8c/0xb0()
[    0.185760] sysfs: cannot create duplicate filename '/devices/platform/r=
eg-fixed-voltage.0'
[    0.185760] Modules linked in:
[    0.185821] [<c001b4b8>] (unwind_backtrace+0x0/0xf0) from [<c003f764>] (=
warn_slowpath_common+0x4c/0x64)
[    0.185852] [<c003f764>] (warn_slowpath_common+0x4c/0x64) from [<c003f81=
0>] (warn_slowpath_fmt+0x30/0x40)
[    0.185913] [<c003f810>] (warn_slowpath_fmt+0x30/0x40) from [<c0167df4>]=
 (sysfs_add_one+0x8c/0xb0)
[    0.185943] [<c0167df4>] (sysfs_add_one+0x8c/0xb0) from [<c0168094>] (cr=
eate_dir+0x60/0xc4)
[    0.185974] [<c0168094>] (create_dir+0x60/0xc4) from [<c0168418>] (sysfs=
_create_dir+0x90/0xe8)
[    0.186004] [<c0168418>] (sysfs_create_dir+0x90/0xe8) from [<c024ae04>] =
(kobject_add_internal+0xa0/0x21c)
[    0.186035] [<c024ae04>] (kobject_add_internal+0xa0/0x21c) from [<c024b2=
e8>] (kobject_add+0x50/0x98)
[    0.186065] [<c024b2e8>] (kobject_add+0x50/0x98) from [<c02b3c0c>] (devi=
ce_add+0x90/0x648)
[    0.186126] [<c02b3c0c>] (device_add+0x90/0x648) from [<c02b7d20>] (plat=
form_device_add+0xf8/0x230)
[    0.186157] [<c02b7d20>] (platform_device_add+0xf8/0x230) from [<c02b7f6=
4>] (platform_add_devices+0x24/0x104)
[    0.186187] [<c02b7f64>] (platform_add_devices+0x24/0x104) from [<c062ee=
14>] (igep_init+0x184/0x42c)
[    0.186218] [<c062ee14>] (igep_init+0x184/0x42c) from [<c062165c>] (cust=
omize_machine+0x1c/0x28)
[    0.186248] [<c062165c>] (customize_machine+0x1c/0x28) from [<c0008718>]=
 (do_one_initcall+0x34/0x180)
[    0.186309] [<c0008718>] (do_one_initcall+0x34/0x180) from [<c061e8fc>] =
(kernel_init+0xf0/0x1b8)
[    0.186340] [<c061e8fc>] (kernel_init+0xf0/0x1b8) from [<c0014d84>] (ker=
nel_thread_exit+0x0/0x8)
[    0.186828] ---[ end trace 1b75b31a2719ed1c ]---
[    0.186889] ------------[ cut here ]------------
[    0.186920] WARNING: at /home/thomas/projets/linux-2.6/lib/kobject.c:198=
 kobject_add_internal+0x200/0x21c()
[    0.186950] kobject_add_internal failed for reg-fixed-voltage.0 with -EE=
XIST, don't try to register things with the same name in the same directory.
[    0.186981] Modules linked in:
[    0.187011] [<c001b4b8>] (unwind_backtrace+0x0/0xf0) from [<c003f764>] (=
warn_slowpath_common+0x4c/0x64)
[    0.187072] [<c003f764>] (warn_slowpath_common+0x4c/0x64) from [<c003f81=
0>] (warn_slowpath_fmt+0x30/0x40)
[    0.187103] [<c003f810>] (warn_slowpath_fmt+0x30/0x40) from [<c024af64>]=
 (kobject_add_internal+0x200/0x21c)
[    0.187133] [<c024af64>] (kobject_add_internal+0x200/0x21c) from [<c024b=
2e8>] (kobject_add+0x50/0x98)
[    0.187164] [<c024b2e8>] (kobject_add+0x50/0x98) from [<c02b3c0c>] (devi=
ce_add+0x90/0x648)
[    0.187194] [<c02b3c0c>] (device_add+0x90/0x648) from [<c02b7d20>] (plat=
form_device_add+0xf8/0x230)
[    0.187225] [<c02b7d20>] (platform_device_add+0xf8/0x230) from [<c02b7f6=
4>] (platform_add_devices+0x24/0x104)
[    0.187286] [<c02b7f64>] (platform_add_devices+0x24/0x104) from [<c062ee=
14>] (igep_init+0x184/0x42c)
[    0.187316] [<c062ee14>] (igep_init+0x184/0x42c) from [<c062165c>] (cust=
omize_machine+0x1c/0x28)
[    0.187347] [<c062165c>] (customize_machine+0x1c/0x28) from [<c0008718>]=
 (do_one_initcall+0x34/0x180)
[    0.187377] [<c0008718>] (do_one_initcall+0x34/0x180) from [<c061e8fc>] =
(kernel_init+0xf0/0x1b8)
[    0.187744] [<c061e8fc>] (kernel_init+0xf0/0x1b8) from [<c0014d84>] (ker=
nel_thread_exit+0x0/0x8)
[    0.187774] ---[ end trace 1b75b31a2719ed1d ]---
[    0.192993] Reprogramming SDRC clock to 200000000 Hz
[    0.193023] dpll3_m2_clk rate change failed: -22
[    0.194335] IGEP: initializing NAND memory device
[    0.213165] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.240417]  omap-mcbsp.2: alias fck already exists
[    0.241821]  omap-mcbsp.3: alias fck already exists
[    0.249053] OMAP DMA hardware revision 5.0
[    0.372802] bio: create slab <bio-0> at 0
[    0.379180] fixed-dummy:=20
[    0.389526] SCSI subsystem initialized
[    0.392974] omap2_mcspi omap2_mcspi.1: master is unqueued, this is depre=
cated
[    0.395111] omap2_mcspi omap2_mcspi.2: master is unqueued, this is depre=
cated
[    0.397125] omap2_mcspi omap2_mcspi.3: master is unqueued, this is depre=
cated
[    0.399444] omap2_mcspi omap2_mcspi.4: master is unqueued, this is depre=
cated
[    0.405242] usbcore: registered new interface driver usbfs
[    0.407623] usbcore: registered new interface driver hub
[    0.409118] usbcore: registered new device driver usb
[    0.413299] omap_i2c omap_i2c.3: bus 3 rev1.4.0 at 100 kHz
[    0.417968] omap_i2c omap_i2c.1: bus 1 rev1.4.0 at 2600 kHz
[    0.431915] twl 1-0048: PIH (irq 7) chaining IRQs 320..328
[    0.432739] twl 1-0048: power (irq 325) chaining IRQs 328..335
[    0.436065] twl4030_gpio twl4030_gpio: gpio (irq 320) chaining IRQs 336.=
.353
[    0.438598] gpiochip_add: registered GPIOs 192 to 211 on device: twl4030
[    0.455535] VIO: 1800 mV normal standby
[    0.459259] VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
[    0.463317] VDVI: 1800 mV normal standby
[    0.477416] Switching to clocksource 32k_counter
[    0.669799] NET: Registered protocol family 2
[    0.670959] IP route cache hash table entries: 4096 (order: 2, 16384 byt=
es)
[    0.674499] TCP established hash table entries: 16384 (order: 5, 131072 =
bytes)
[    0.675201] TCP bind hash table entries: 16384 (order: 7, 589824 bytes)
[    0.684356] TCP: Hash tables configured (established 16384 bind 16384)
[    0.684570] TCP: reno registered
[    0.684631] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.684936] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.686218] NET: Registered protocol family 1
[    0.688537] RPC: Registered named UNIX socket transport module.
[    0.688568] RPC: Registered udp transport module.
[    0.688598] RPC: Registered tcp transport module.
[    0.688629] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.690399] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.862396] VFS: Disk quotas dquot_6.5.2
[    0.862854] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.865142] NFS: Registering the id_resolver key type
[    0.867980] jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 Red H=
at, Inc.
[    0.869964] msgmni has been set to 988
[    0.875823] io scheduler noop registered
[    0.875854] io scheduler deadline registered
[    0.876251] io scheduler cfq registered (default)
[    0.880737] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.893066] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is a OMAP=
 UART0
[    0.896606] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73) is a OMAP=
 UART1
[    0.899169] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74) is a OMAP=
 UART2
[    1.914642] console [ttyO2] enabled
[    1.921264] omap_uart.3: ttyO3 at MMIO 0x49042000 (irq =3D 80) is a OMAP=
 UART3
[    1.990692] brd: module loaded
[    2.030090] loop: module loaded
[    2.046020] mtdoops: mtd device (mtddev=3Dname/number) must be supplied
[    2.054107] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xbc (Micron NA=
ND 512MiB 1,8V 16-bit)
[    2.063507] 2 cmdlinepart partitions found on MTD device omap2-nand.0
[    2.070404] Creating 2 MTD partitions on "omap2-nand.0":
[    2.076141] 0x000000000000-0x000000600000 : "boot"
[    2.097930] 0x000000600000-0x000000c00000 : "rootfs"
[    2.117767] OneNAND driver initializing
[    2.133911] smsc911x: Driver version 2008-10-21
[    2.153472] smsc911x-mdio: probed
[    2.157287] smsc911x smsc911x.0: eth0: attached PHY driver [SMSC LAN8700=
] (mii_bus:phy_addr=3Dsmsc911x-0:01, irq=3D-1)
[    2.169097] smsc911x smsc911x.0: eth0: MAC Address: ba:15:a4:bd:ac:2e
[    2.178100] usbcore: registered new interface driver asix
[    2.185119] usbcore: registered new interface driver cdc_ether
[    2.192596] usbcore: registered new interface driver net1080
[    2.199829] usbcore: registered new interface driver cdc_subset
[    2.207305] usbcore: registered new interface driver zaurus
[    2.214477] usbcore: registered new interface driver cdc_ncm
[    2.224609] usbcore: registered new interface driver cdc_wdm
[    2.230834] Initializing USB Mass Storage driver...
[    2.237182] usbcore: registered new interface driver usb-storage
[    2.243560] USB Mass Storage support registered.
[    2.250579] usbcore: registered new interface driver libusual
[    2.257965] usbcore: registered new interface driver usbtest
[    2.268005] mousedev: PS/2 mouse device common for all mice
[    2.277923] input: TWL4030 Keypad as /devices/platform/omap_i2c.1/i2c-1/=
1-004a/twl4030_keypad/input/input0
[    2.300720] input: twl4030_pwrbutton as /devices/platform/omap_i2c.1/i2c=
-1/1-0049/twl4030_pwrbutton/input/input1
[    2.315155] twl_rtc twl_rtc: Power up reset detected.
[    2.320739] twl_rtc twl_rtc: Enabling TWL-RTC
[    2.331878] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    2.340545] i2c /dev entries driver
[    2.350006] Driver for 1-wire Dallas network protocol.
[    2.361663] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60 s=
ec
[    2.370849] twl4030_wdt twl4030_wdt: Failed to register misc device
[    2.377777] twl4030_wdt: probe of twl4030_wdt failed with error -16
[    2.620422] usbcore: registered new interface driver usbhid
[    2.626312] usbhid: USB HID core driver
[    2.630645] oprofile: hardware counters not available
[    2.636077] oprofile: using timer interrupt.
[    2.641815] TCP: cubic registered
[    2.645477] Initializing XFRM netlink socket
[    2.650360] NET: Registered protocol family 17
[    2.655212] NET: Registered protocol family 15
[    2.660583] Registering the dns_resolver key type
[    2.665924] VFP support v0.3: implementor 41 architecture 3 part 30 vari=
ant c rev 3
[    2.674346] ThumbEE CPU extension supported.
[    2.728729] clock: disabling unused clocks to save power
[    2.741241] VDVI: incomplete constraints, leaving on
[    2.750915] twl_rtc twl_rtc: setting system clock to 2000-01-01 00:00:00=
 UTC (946684800)
[    2.806823] jffs2: Empty flash at 0x002a1574 ends at 0x002a1800
[    2.840362] jffs2: notice: (1) jffs2_build_xattr_subsystem: complete bui=
lding xattr subsystem, 0 of xdatum (0 unchecked, 0 orphan) and 0 of xref (0=
 dead, 0 orphan) found.
[    2.862274] VFS: Mounted root (jffs2 filesystem) on device 31:1.
[    2.895263] devtmpfs: mounted
[    2.899017] Freeing init memory: 308K
/bin/sh: can't access tty; job control turned off
/ #

--MP_/_i/pUlqCpr6pR3kVb68xou9--
