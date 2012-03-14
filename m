From: Kevin Hilman <khilman@ti.com>
Subject: GPIO abort on 3630/Zoom3
Date: Wed, 14 Mar 2012 15:05:11 -0700
Message-ID: <87d38eet48.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:58868 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1031095Ab2CNWFA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Mar 2012 18:05:00 -0400
Received: by mail-pz0-f50.google.com with SMTP id n40so3080496dak.37
        for <linux-omap@vger.kernel.org>; Wed, 14 Mar 2012 15:04:59 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tarun.kanti@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Tarun,

Can you investigate an abort during boot on 3630/Zoom3?

Both Tony and I are seeing the abort below on 3630/Zoom3.  I'm using
arm-soc/for-next and Tony is using linux-next, but we see the same abor=
t.

Adding in your latest fixes series doesn't make the problem go away, bu=
t
backing out the GPIO runtime PM series does make the problem go away.

Kevin


Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.3.0-rc7-pm+debug+initramfs-01079-g405139=
c (khilman@paris) (gcc version 4.6.1 (Ubuntu/Linaro 4.6.1-9ubuntu3) ) #=
15 SMP Wed Mar 14 13:06:34 PDT 2012
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=3D=
10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing i=
nstruction cache
[    0.000000] Machine: OMAP Zoom3 board
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 32512
[    0.000000] free_area_init_node: node 0, pgdat c094f580, node_mem_ma=
p c0ea7000
[    0.000000]   Normal zone: 256 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 32256 pages, LIFO batch:7
[    0.000000] OMAP3630 ES1.0 (l2cache iva sgx neon isp 192mhz_clk )
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz
[    0.000000] PERCPU: Embedded 9 pages/cpu @c0fab000 s12864 r8192 d158=
08 u36864
[    0.000000] pcpu-alloc: s12864 r8192 d15808 u36864 alloc=3D9*4096
[    0.000000] pcpu-alloc: [0] 0=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  =
Total pages: 32256
[    0.000000] Kernel command line: mem=3D128M console=3DttyS0,115200n8=
 ip=3Ddhcp debug earlyprintk user_debug=3D0xffff
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 =
bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 by=
tes)
[    0.000000] Memory: 127MB =3D 127MB total
[    0.000000] Memory: 113868k/113868k available, 17204k reserved, 0K h=
ighmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0605560   (6134 kB)
[    0.000000]       .init : 0xc0606000 - 0xc08c2240   (2801 kB)
[    0.000000]       .data : 0xc08c4000 - 0xc0950ff0   ( 564 kB)
[    0.000000]        .bss : 0xc0951014 - 0xc0ea6c9c   (5464 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:474
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 =
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps=
 every 131071999ms
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
[    0.056732] Calibrating delay loop... 597.64 BogoMIPS (lpj=3D2334720=
)
[    0.098571] pid_max: default: 32768 minimum: 301
[    0.104125] Security Framework initialized
[    0.108673] Mount-cache hash table entries: 512
[    0.118377] CPU: Testing write buffer coherency: ok
[    0.124389] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.129852] Setting up static identity map for 0x8043ac18 - 0x8043ac=
88
[    0.138244] Brought up 1 CPUs
[    0.141387] SMP: Total of 1 processors activated (597.64 BogoMIPS).
[    0.170501] print_constraints: dummy:=20
[    0.176666] NET: Registered protocol family 16
[    0.182525] GPMC revision 5.0
[    0.196075] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.203277] OMAP GPIO hardware version 2.5
[    0.208831] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.217071] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.225128] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.233367] gpiochip_add: registered GPIOs 128 to 159 on device: gpi=
o
[    0.241546] gpiochip_add: registered GPIOs 160 to 191 on device: gpi=
o
[    0.254821] omap_mux_init: Add partition: #1: core, flags: 0
[    0.267486] error setting wl12xx data: -38
[    0.283905] Reprogramming SDRC clock to 400000000 Hz
[    0.294250] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.319091]  omap-mcbsp.2: alias fck already exists
[    0.325347]  omap-mcbsp.3: alias fck already exists
[    0.336669] OMAP DMA hardware revision 5.0
[    0.403747] bio: create slab <bio-0> at 0
[    0.412170] print_constraints: gpmc_smsc911x: 3300 mV normal standby
[    0.420104] print_constraints: vwl1271: 1800 mV=20
[    0.430725] SCSI subsystem initialized
[    0.445831] usbcore: registered new interface driver usbfs
[    0.452697] usbcore: registered new interface driver hub
[    0.459350] usbcore: registered new device driver usb
[    0.479003] omap_i2c omap_i2c.1: bus 1 rev1.4.0 at 2400 kHz
[    0.495117] twl4030: PIH (irq 7) chaining IRQs 368..401
[    0.501190] twl4030: power (irq 373) chaining IRQs 402..409
[    0.509429] twl4030: gpio (irq 368) chaining IRQs 410..427
[    0.515319] ------------[ cut here ]------------
[    0.520202] WARNING: at /work/kernel/omap/pm/drivers/gpio/gpio-twl40=
30.c:410 gpio_twl4030_probe+0x44/0x214()
[    0.530395] Modules linked in:
[    0.533691] [<c0014248>] (unwind_backtrace+0x0/0xf0) from [<c0039054=
>] (warn_slowpath_common+0x4c/0x64)
[    0.543640] [<c0039054>] (warn_slowpath_common+0x4c/0x64) from [<c00=
39088>] (warn_slowpath_null+0x1c/0x24)
[    0.553680] [<c0039088>] (warn_slowpath_null+0x1c/0x24) from [<c0419=
6f4>] (gpio_twl4030_probe+0x44/0x214)
[    0.563629] [<c04196f4>] (gpio_twl4030_probe+0x44/0x214) from [<c028=
832c>] (platform_drv_probe+0x18/0x1c)
[    0.573577] [<c028832c>] (platform_drv_probe+0x18/0x1c) from [<c0286=
fd4>] (really_probe+0x60/0x15c)
[    0.583007] [<c0286fd4>] (really_probe+0x60/0x15c) from [<c0287214>]=
 (driver_probe_device+0x48/0x60)
[    0.592498] [<c0287214>] (driver_probe_device+0x48/0x60) from [<c028=
5af8>] (bus_for_each_drv+0x5c/0x88)
[    0.602264] [<c0285af8>] (bus_for_each_drv+0x5c/0x88) from [<c028718=
c>] (device_attach+0x98/0xbc)
[    0.611480] [<c028718c>] (device_attach+0x98/0xbc) from [<c0286844>]=
 (bus_probe_device+0x88/0xac)
[    0.620727] [<c0286844>] (bus_probe_device+0x88/0xac) from [<c028516=
0>] (device_add+0x278/0x358)
[    0.629882] [<c0285160>] (device_add+0x278/0x358) from [<c02887a8>] =
(platform_device_add+0xf8/0x1a4)
[    0.639373] [<c02887a8>] (platform_device_add+0xf8/0x1a4) from [<c04=
2e4a0>] (add_numbered_child.constprop.0+0xb8/0xfc)
[    0.650451] [<c042e4a0>] (add_numbered_child.constprop.0+0xb8/0xfc) =
from [<c042e5a4>] (add_children+0x44/0x6d0)
[    0.660949] [<c042e5a4>] (add_children+0x44/0x6d0) from [<c041a8b8>]=
 (twl_probe+0x354/0x3bc)
[    0.669738] [<c041a8b8>] (twl_probe+0x354/0x3bc) from [<c0326cb0>] (=
i2c_device_probe+0xc0/0x100)
[    0.678863] [<c0326cb0>] (i2c_device_probe+0xc0/0x100) from [<c0286f=
d4>] (really_probe+0x60/0x15c)
[    0.688171] [<c0286fd4>] (really_probe+0x60/0x15c) from [<c0287214>]=
 (driver_probe_device+0x48/0x60)
[    0.697692] [<c0287214>] (driver_probe_device+0x48/0x60) from [<c028=
5af8>] (bus_for_each_drv+0x5c/0x88)
[    0.707458] [<c0285af8>] (bus_for_each_drv+0x5c/0x88) from [<c028718=
c>] (device_attach+0x98/0xbc)
[    0.716674] [<c028718c>] (device_attach+0x98/0xbc) from [<c0286844>]=
 (bus_probe_device+0x88/0xac)
[    0.725921] [<c0286844>] (bus_probe_device+0x88/0xac) from [<c028516=
0>] (device_add+0x278/0x358)
[    0.735076] [<c0285160>] (device_add+0x278/0x358) from [<c0327410>] =
(i2c_new_device+0xec/0x160)
[    0.744354] [<c0327410>] (i2c_new_device+0xec/0x160) from [<c032781c=
>] (i2c_register_adapter+0x168/0x220)
[    0.754302] [<c032781c>] (i2c_register_adapter+0x168/0x220) from [<c=
0327a40>] (i2c_add_numbered_adapter+0xd4/0xf0)
[    0.765045] [<c0327a40>] (i2c_add_numbered_adapter+0xd4/0xf0) from [=
<c041f4c8>] (omap_i2c_probe+0x334/0x424)
[    0.775268] [<c041f4c8>] (omap_i2c_probe+0x334/0x424) from [<c028832=
c>] (platform_drv_probe+0x18/0x1c)
[    0.784942] [<c028832c>] (platform_drv_probe+0x18/0x1c) from [<c0286=
fd4>] (really_probe+0x60/0x15c)
[    0.794342] [<c0286fd4>] (really_probe+0x60/0x15c) from [<c0287214>]=
 (driver_probe_device+0x48/0x60)
[    0.803863] [<c0287214>] (driver_probe_device+0x48/0x60) from [<c028=
72c0>] (__driver_attach+0x94/0x98)
[    0.813537] [<c02872c0>] (__driver_attach+0x94/0x98) from [<c0285b74=
>] (bus_for_each_dev+0x50/0x7c)
[    0.822937] [<c0285b74>] (bus_for_each_dev+0x50/0x7c) from [<c0286ad=
4>] (bus_add_driver+0x184/0x248)
[    0.832427] [<c0286ad4>] (bus_add_driver+0x184/0x248) from [<c028779=
8>] (driver_register+0x78/0x12c)
[    0.841949] [<c0287798>] (driver_register+0x78/0x12c) from [<c000880=
0>] (do_one_initcall+0x34/0x178)
[    0.851440] [<c0008800>] (do_one_initcall+0x34/0x178) from [<c06068a=
c>] (kernel_init+0x8c/0x130)
[    0.860565] [<c06068ac>] (kernel_init+0x8c/0x130) from [<c000e850>] =
(kernel_thread_exit+0x0/0x8)
[    0.870117] ---[ end trace 1b75b31a2719ed1c ]---
[    0.876403] gpiochip_add: registered GPIOs 192 to 209 on device: twl=
4030
[    0.891571] print_constraints: vdd_mpu_iva: 600 <--> 1450 mV normal=20
[    0.900726] print_constraints: vdd_core: 600 <--> 1450 mV normal=20
[    0.909454] print_constraints: VMMC1: 1850 <--> 3150 mV at 3000 mV n=
ormal standby
[    0.919616] print_constraints: VDAC: 1800 mV normal standby
[    0.927642] print_constraints: VPLL2: 1800 mV normal standby
[    0.936065] print_constraints: VMMC2: 1850 mV normal standby
[    0.944305] print_constraints: VSIM: 1800 <--> 3000 mV at 1800 mV no=
rmal standby
[    0.963043] omap_i2c omap_i2c.2: bus 2 rev1.4.0 at 400 kHz
[    0.978668] omap_i2c omap_i2c.3: bus 3 rev1.4.0 at 400 kHz
[    0.992675] Switching to clocksource 32k_counter
[    1.111755] NET: Registered protocol family 2
[    1.117462] IP route cache hash table entries: 1024 (order: 0, 4096 =
bytes)
[    1.126464] TCP established hash table entries: 4096 (order: 3, 3276=
8 bytes)
[    1.134155] TCP bind hash table entries: 4096 (order: 5, 147456 byte=
s)
[    1.143310] TCP: Hash tables configured (established 4096 bind 4096)
[    1.150024] TCP reno registered
[    1.153350] UDP hash table entries: 64 (order: 0, 5120 bytes)
[    1.159698] UDP-Lite hash table entries: 64 (order: 0, 5120 bytes)
[    1.167083] NET: Registered protocol family 1
[    1.173034] RPC: Registered named UNIX socket transport module.
[    1.179504] RPC: Registered udp transport module.
[    1.184417] RPC: Registered tcp transport module.
[    1.189392] RPC: Registered tcp NFSv4.1 backchannel transport module=
=2E
[    1.438323] VFS: Disk quotas dquot_6.5.2
[    1.442779] Dquot-cache hash table entries: 1024 (order 0, 4096 byte=
s)
[    1.452575] JFFS2 version 2.2. (NAND) (SUMMARY)  =C3=82=C2=A9 2001-2=
006 Red Hat, Inc.
[    1.461120] msgmni has been set to 222
[    1.468536] io scheduler noop registered
[    1.472656] io scheduler deadline registered
[    1.477447] io scheduler cfq registered (default)
[    1.485046] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.522857] serial8250.0: ttyS0 at MMIO 0x10000000 (irq =3D 262) is =
a ST16654
[    1.530426] console [ttyS0] enabled, bootconsole disabled
[    1.530426] console [ttyS0] enabled, bootconsole disabled
[    1.544494] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is a =
OMAP UART0
[    1.553680] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73) is a =
OMAP UART1
[    1.562164] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74) is a =
OMAP UART2
[    1.570648] omap_uart.3: ttyO3 at MMIO 0x49042000 (irq =3D 80) is a =
OMAP UART3
[    1.612884] brd: module loaded
[    1.636749] loop: module loaded
[    1.648681] mtdoops: mtd device (mtddev=3Dname/number) must be suppl=
ied
[    1.656097] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xbc (Micro=
n NAND 512MiB 1,8V 16-bit)
[    1.670745] Creating 7 MTD partitions on "omap2-nand.0":
[    1.676086] 0x000000000000-0x000000080000 : "X-Loader-NAND"
[    1.689300] 0x000000080000-0x0000001c0000 : "U-Boot-NAND"
[    1.699920] 0x0000001c0000-0x000000200000 : "Boot Env-NAND"
[    1.710144] 0x000000200000-0x000002000000 : "Kernel-NAND"
[    1.733581] 0x000002000000-0x00001c000000 : "system"
[    1.931427] 0x00001c000000-0x00001e000000 : "userdata"
[    1.955413] 0x00001e000000-0x000020000000 : "cache"
[    1.979888] OneNAND driver initializing
[    1.990173] smsc911x: Driver version 2008-10-21
[    2.006958] smsc911x-mdio: probed
[    2.010528] smsc911x smsc911x.0: eth0: attached PHY driver [SMSC LAN=
8700] (mii_bus:phy_addr=3Dsmsc911x-0:01, irq=3D-1)
[    2.021606] smsc911x smsc911x.0: eth0: MAC Address: 00:08:ee:03:7e:0=
7
[    2.029602] usbcore: registered new interface driver asix
[    2.035552] usbcore: registered new interface driver cdc_ether
[    2.042053] usbcore: registered new interface driver net1080
[    2.048309] usbcore: registered new interface driver cdc_subset
[    2.054809] usbcore: registered new interface driver zaurus
[    2.061035] usbcore: registered new interface driver cdc_ncm
[    2.068969] usbcore: registered new interface driver cdc_wdm
[    2.074645] Initializing USB Mass Storage driver...
[    2.080230] usbcore: registered new interface driver usb-storage
[    2.086334] USB Mass Storage support registered.
[    2.092285] usbcore: registered new interface driver libusual
[    2.098602] usbcore: registered new interface driver usbtest
[    2.106018] mousedev: PS/2 mouse device common for all mice
[    2.114196] input: TWL4030 Keypad as /devices/platform/omap_i2c.1/i2=
c-1/1-004a/twl4030_keypad/input/input0
[    2.130432] input: twl4030_pwrbutton as /devices/platform/omap_i2c.1=
/i2c-1/1-0049/twl4030_pwrbutton/input/input1
[    2.146270] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    2.153411] i2c /dev entries driver
[    2.160797] Driver for 1-wire Dallas network protocol.
[    2.169342] OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
[    2.176635] twl4030_wdt twl4030_wdt: Failed to register misc device
[    2.183166] twl4030_wdt: probe of twl4030_wdt failed with error -16
[    2.192077] cpuidle: using governor ladder
[    2.196380] cpuidle: using governor menu
[    2.397155] mmc0: new high speed MMC card at address 0001
[    2.405548] mmcblk0: mmc0:0001 STM16G 14.8 GiB=20
[    2.418579]  mmcblk0: unknown partition table
[    2.501220] usbcore: registered new interface driver usbhid
[    2.506927] usbhid: USB HID core driver
[    2.510772] oprofile: hardware counters not available
[    2.515899] oprofile: using timer interrupt.
[    2.520904] TCP cubic registered
[    2.524444] Initializing XFRM netlink socket
[    2.528900] NET: Registered protocol family 17
[    2.533508] NET: Registered protocol family 15
[    2.538299] Registering the dns_resolver key type
[    2.543579] VFP support v0.3: implementor 41 architecture 3 part 30 =
variant c rev 3
[    2.551452] ThumbEE CPU extension supported.
[    2.570129] omap3_idle_init: core off state C7 disabled due to i583
[    2.577514] sr_init: No PMIC hook to init smartreflex
[    2.582977] smartreflex smartreflex.0: omap_sr_probe: SmartReflex dr=
iver initialized
[    2.591522] smartreflex smartreflex.1: omap_sr_probe: SmartReflex dr=
iver initialized
[    2.600341] SmartReflex Class3 initialized
[    2.638000] clock: disabling unused clocks to save power
[    2.650909] mmc1: card claims to support voltages below the defined =
range. These will be ignored.
[    2.663513] twl_rtc twl_rtc: setting system clock to 2000-01-28 00:5=
8:30 UTC (949021110)
[    2.674804] smsc911x smsc911x.0: eth0: SMSC911x/921x identified at 0=
xc8888000, IRQ: 254
[    2.697235] mmc1: queuing unknown CIS tuple 0x91 (3 bytes)
[    2.702880] Sending DHCP requests .
[    2.709014] mmc1: new SDIO card at address 0001
[    3.270294] mmc2: host does not support reading read-only switch. as=
suming write-enable.
[    3.280944] mmc2: new high speed SD card at address 1234
[    3.288391] mmcblk1: mmc2:1234 SA02G 1.83 GiB=20
[    3.297149]  mmcblk1: p1 p2
[    5.021850] ., OK
[    5.061401] IP-Config: Got DHCP answer from 192.168.1.5, my address =
is 192.168.1.151
[    5.069763] IP-Config: Complete:
[    5.072998]      device=3Deth0, addr=3D192.168.1.151, mask=3D255.255=
=2E255.0, gw=3D192.168.1.254,
[    5.080841]      host=3Dzoom3, domain=3Dlan, nis-domain=3D(none),
[    5.086456]      bootserver=3D192.168.1.5, rootserver=3D192.168.1.23=
6, rootpath=3D/opt/kjh/rootfs/debian/armel,rsize=3D4096,wsize=3D4096,nf=
svers=3D3
[    5.101623] Unhandled fault: external abort on non-linefetch (0x1028=
) at 0xfb058040
[    5.109283] Internal error: : 1028 [#1] SMP
[    5.113494] Modules linked in:
[    5.116546] CPU: 0    Tainted: G        W     (3.3.0-rc7-pm+debug+in=
itramfs-01079-g405139c #15)
[    5.125274] PC is at _set_gpio_triggering+0x34/0x260
[    5.130249] LR is at gpio_irq_type+0x110/0x150
[    5.134704] pc : [<c0244224>]    lr : [<c0244890>]    psr: 60000093
[    5.134704] sp : c7825cc0  ip : 00000001  fp : 00000106
[    5.146209] r10: 000000a6  r9 : 00000106  r8 : c7874c10
[    5.151428] r7 : 20000093  r6 : c7874c6c  r5 : 00000020  r4 : fb0580=
00
[    5.157958] r3 : c7874c10  r2 : 00000001  r1 : 00000040  r0 : 000000=
40
[    5.164489] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Se=
gment kernel
[    5.171905] Control: 10c5387d  Table: 872fc019  DAC: 00000017
[    5.177642] Process swapper/0 (pid: 1, stack limit =3D 0xc78242f8)
[    5.183654] Stack: (0xc7825cc0 to 0xc7826000)
[    5.188049] 5cc0: 00000001 c08d2640 c7874c6c 20000093 c08d26e8 c08d2=
640 c0244780 00000000
[    5.196228] 5ce0: c0932770 00000106 00000001 c00946e4 c08d26e8 c08d2=
640 c72f9a00 c08d2694
[    5.204406] 5d00: 60000013 c08d2674 00000000 c0094b2c 000080d0 c00ee=
ea0 60000093 c78233c0
[    5.212615] 5d20: c0950244 c72f9a00 c08d2640 c72f99c0 00000081 c027a=
db0 00000106 00000000
[    5.220794] 5d40: 00000000 c0094c98 c0e9a904 c72f99c0 00000000 00000=
006 c72f99cc 00000080
[    5.228973] 5d60: c0e9cd30 c027afa0 c05679b4 c72f99c0 c0e9a904 00000=
002 20000013 00000002
[    5.237182] 5d80: 00000000 c73a4800 00000002 c027c2d8 c0e9a904 c7980=
000 00000000 c73a4800
[    5.245361] 5da0: 00000000 c02777d8 c73a4800 c73a4920 c7980000 00000=
000 c71ba2c0 c02787d8
[    5.253570] 5dc0: 00000000 c7980000 c73a4800 c79800b0 c78d8cc0 c0279=
08c c78d8cc0 00500001
[    5.261749] 5de0: c0464158 c7824000 c71ba2c0 c0261288 c00f5e38 c7536=
0f8 00000001 00000000
[    5.269927] 5e00: c0e997a0 00000000 c0e997a0 00000000 c75360f8 00000=
000 00000000 c78d8cc0
[    5.278137] 5e20: 00000000 c00f5ee8 c753620c 00000000 00000000 c78d8=
cc0 c75378e0 c75360f8
[    5.286315] 5e40: c753620c 00000000 00000000 c7814b10 00000000 c00ef=
fd4 c00f5df8 c753792c
[    5.294525] 5e60: 00000000 c781c840 00000000 c78d8cc0 c7825f38 00000=
000 00000000 00000000
[    5.302703] 5e80: 00000000 c00f102c c781c840 00000002 00000000 c7825=
f38 00000002 00000000
[    5.310882] 5ea0: 00000026 c00ff8b0 c7537a20 c00fe1c4 00000001 c7536=
0f8 c00fe1a0 c7825f38
[    5.319091] 5ec0: c7825fb8 00000000 c7825ef4 c7824000 00000000 00000=
000 00000000 c00ffb94
[    5.327270] 5ee0: c7825f04 00000000 00000000 00000000 00000000 c7814=
b10 c75378e0 00000000
[    5.335449] 5f00: c781eed0 00000000 00000000 c7825fb8 00000001 c7a35=
000 ffffff9c ffffff9c
[    5.343658] 5f20: 00000000 00000000 00000000 c00fff80 00000041 c7823=
3c0 c7814b10 c75378e0
[    5.351837] 5f40: 05b6719b 00000007 c7a35005 00000000 c7401940 c7536=
0f8 00000101 00000004
[    5.360015] 5f60: 00000000 00000000 c781ee88 00000000 c781eec0 00000=
002 00000000 00000000
[    5.368225] 5f80: 00000000 c781ee80 c781ee88 00000002 00000000 00000=
000 c000e850 c7a35000
[    5.376403] 5fa0: 00000002 00000000 00000001 c00f1110 00000000 00000=
000 00000002 c0080000
[    5.384613] 5fc0: 00000026 00000100 c0651bb4 c0651bb4 c0651bb4 c000e=
850 00000013 00000000
[    5.392791] 5fe0: 00000000 c06068c4 00000000 00000000 c0606820 c000e=
850 df2b77da f7efed7e
[    5.401000] [<c0244224>] (_set_gpio_triggering+0x34/0x260) from [<c0=
8d26e8>] (irq_desc+0xc528/0x16380)
[    5.410308] Code: 0a00004c e3a0c001 e3120008 e1a0111c (e794c000)=20
[    5.416442] ------------[ cut here ]------------
[    5.421081] WARNING: at /work/kernel/omap/pm/arch/arm/mach-omap2/oma=
p_l3_smx.c:161 omap3_l3_app_irq+0xd0/0x128()
[    5.431243] In-band Error seen by MPU  at address 0
[    5.436126] Modules linked in:
[    5.439208] [<c0014248>] (unwind_backtrace+0x0/0xf0) from [<c0039054=
>] (warn_slowpath_common+0x4c/0x64)
[    5.448638] [<c0039054>] (warn_slowpath_common+0x4c/0x64) from [<c00=
39100>] (warn_slowpath_fmt+0x30/0x40)
[    5.458221] [<c0039100>] (warn_slowpath_fmt+0x30/0x40) from [<c002c0=
c0>] (omap3_l3_app_irq+0xd0/0x128)
[    5.467559] [<c002c0c0>] (omap3_l3_app_irq+0xd0/0x128) from [<c00934=
60>] (handle_irq_event_percpu+0x58/0x244)
[    5.477478] [<c0093460>] (handle_irq_event_percpu+0x58/0x244) from [=
<c0093688>] (handle_irq_event+0x3c/0x5c)
[    5.487335] [<c0093688>] (handle_irq_event+0x3c/0x5c) from [<c0095c6=
c>] (handle_level_irq+0xac/0xfc)
[    5.496490] [<c0095c6c>] (handle_level_irq+0xac/0xfc) from [<c0092cb=
8>] (generic_handle_irq+0x30/0x48)
[    5.505828] [<c0092cb8>] (generic_handle_irq+0x30/0x48) from [<c000e=
5f8>] (handle_IRQ+0x4c/0xac)
[    5.514617] [<c000e5f8>] (handle_IRQ+0x4c/0xac) from [<c0008744>] (o=
map3_intc_handle_irq+0x54/0x68)
[    5.523681] [<c0008744>] (omap3_intc_handle_irq+0x54/0x68) from [<c0=
435964>] (__irq_svc+0x44/0x60)
[    5.532653] Exception stack(0xc7825b70 to 0xc7825bb8)
[    5.537719] 5b60:                                     c0435688 00000=
001 00000000 00000080
[    5.545898] 5b80: c08e1c6c c7824000 00000001 00001028 c7874c10 00000=
106 000000a6 00000106
[    5.554107] 5ba0: 00000000 c7825bb8 c0435688 c043568c 60000113 fffff=
fff
[    5.560729] [<c0435964>] (__irq_svc+0x44/0x60) from [<c043568c>] (_r=
aw_spin_unlock_irq+0x28/0x2c)
[    5.569610] [<c043568c>] (_raw_spin_unlock_irq+0x28/0x2c) from [<c00=
11760>] (die+0x98/0x128)
[    5.578063] [<c0011760>] (die+0x98/0x128) from [<c0008584>] (do_Data=
Abort+0x8c/0x9c)
[    5.585845] [<c0008584>] (do_DataAbort+0x8c/0x9c) from [<c04358e4>] =
(__dabt_svc+0x44/0x80)
[    5.594116] Exception stack(0xc7825c78 to 0xc7825cc0)
[    5.599151] 5c60:                                                   =
    00000040 00000040
[    5.607360] 5c80: 00000001 c7874c10 fb058000 00000020 c7874c6c 20000=
093 c7874c10 00000106
[    5.615539] 5ca0: 000000a6 00000106 00000001 c7825cc0 c0244890 c0244=
224 60000093 ffffffff
[    5.623748] [<c04358e4>] (__dabt_svc+0x44/0x80) from [<c0244224>] (_=
set_gpio_triggering+0x34/0x260)
[    5.632812] [<c0244224>] (_set_gpio_triggering+0x34/0x260) from [<c0=
8d26e8>] (irq_desc+0xc528/0x16380)
[    5.642120] ---[ end trace 1b75b31a2719ed1e ]---
[    5.646820] ---[ end trace 1b75b31a2719ed1f ]---
[    5.651489] Kernel panic - not syncing: Attempted to kill init!

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
