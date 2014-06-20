From: Casper Lyngesen Mogensen <clmogensen@grundfos.com>
Subject: OMAP 3630 random crashes
Date: Fri, 20 Jun 2014 08:50:43 +0000
Message-ID: <1403254242990.39117@grundfos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-db3lp0075.outbound.protection.outlook.com ([213.199.154.75]:5923
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754157AbaFTIus convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jun 2014 04:50:48 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi

I have  custom board with a Gumstix Overo, my board is similar to a
Tobi board. Right now i have it running with a 3.5.0 kernel. I'm
trying to upgrade the kernel, and have tried several versions (3.10 ->
3.15) and i seem to be hitting the same problem with all versions, i
get random crashes. Found a way to  trigger the crash within
minutes/seconds:

# dd if=3D/dev/urandom of=3D/tmp/test.file bs=3D1024 count=3D100000

A count > 10000 will at some point trigger the crash. The hang/crash
is repeatable everytime but the log is not, sometimes i do not get
any trace at all. I can provide more logs if necessary.  Config and
crash log are below..

Have tried disabling various peripherals, such as sound, usb,
ethernet, wifi, bluetooth, but with no luck. Also tried different Overo
boards.

Hope someone can help me/point me in the right direction

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.15.0 (clmo@N66266) (gcc version 4.8.1 (c=
rosstool-NG 1.19.0) ) #3 SMP Wed Jun 11 23:50:13 CEST 2014
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=3D=
10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing i=
nstruction cache
[    0.000000] Machine model: OMAP36xx/AM37xx/DM37xx Gumstix Overo on T=
obi
[    0.000000] cma: CMA: reserved 16 MiB at 8d800000
[    0.000000] Memory policy: Data cache writeback
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] OMAP3630 ES1.2 (l2cache neon isp 192mhz_clk )
[    0.000000] PERCPU: Embedded 9 pages/cpu @cecc6000 s14080 r8192 d145=
92 u36864
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  =
Total pages: 60704
[    0.000000] Kernel command line: console=3DttyO2,115200n8 root=3D/de=
v/nfs nfsroot=3D192.168.100.1:/export/bbroot,nolock rw ip=3D192.168.100=
=2E7::192.168.100.1:::eth0:off mem=3D240M
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072=
 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 b=
ytes)
[    0.000000] Memory: 211448K/244736K available (5624K kernel code, 65=
5K rwdata, 2148K rodata, 389K init, 5527K bss, 33288K reserved, 0K high=
mem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xcf800000 - 0xff000000   ( 760 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xcf000000   ( 240 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc079f520   (7774 kB)
[    0.000000]       .init : 0xc07a0000 - 0xc0801700   ( 390 kB)
[    0.000000]       .data : 0xc0802000 - 0xc08a5e40   ( 656 kB)
[    0.000000]        .bss : 0xc08a5e40 - 0xc0e0bdc8   (5528 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=3D2 to nr_cpu_ids=3D1=
=2E
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu=
_ids=3D1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 =
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000030] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps=
 every 65536000000000ns
[    0.000030] OMAP clocksource: 32k_counter at 32768 Hz
[    0.001159] Console: colour dummy device 80x30
[    0.001220] Lock dependency validator: Copyright (c) 2006 Red Hat, I=
nc., Ingo Molnar
[    0.001220] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.001251] ... MAX_LOCK_DEPTH:          48
[    0.001251] ... MAX_LOCKDEP_KEYS:        8191
[    0.001281] ... CLASSHASH_SIZE:          4096
[    0.001281] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.001312] ... MAX_LOCKDEP_CHAINS:      32768
[    0.001312] ... CHAINHASH_SIZE:          16384
[    0.001312]  memory used by lock dependency info: 3695 kB
[    0.001342]  per task-struct memory footprint: 1152 bytes
[    0.001403] Calibrating delay loop... 594.73 BogoMIPS (lpj=3D2973696=
)
[    0.097656] pid_max: default: 32768 minimum: 301
[    0.098266] Security Framework initialized
[    0.098449] Mount-cache hash table entries: 1024 (order: 0, 4096 byt=
es)
[    0.098480] Mountpoint-cache hash table entries: 1024 (order: 0, 409=
6 bytes)
[    0.102508] CPU: Testing write buffer coherency: ok
[    0.104125] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.104187] Setting up static identity map for 0x805568a8 - 0x805569=
18
[    0.108673] Brought up 1 CPUs
[    0.108703] SMP: Total of 1 processors activated.
[    0.108703] CPU: All CPU(s) started in SVC mode.
[    0.112609] devtmpfs: initialized
[    0.123229] VFP support v0.3: implementor 41 architecture 3 part 30 =
variant c rev 3
[    0.203124] omap_hwmod: mcbsp2_sidetone using broken dt data from mc=
bsp
[    0.205383] omap_hwmod: mcbsp3_sidetone using broken dt data from mc=
bsp
[    0.300659] pinctrl core: initialized pinctrl subsystem
[    0.304412] regulator-dummy: no parameters
[    0.398101] NET: Registered protocol family 16
[    0.406524] DMA: preallocated 256 KiB pool for atomic coherent alloc=
ations
[    0.421356] Reprogramming SDRC clock to 400000000 Hz
[    0.434478] OMAP GPIO hardware version 2.5
[    0.471252] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
[    0.481658] No ATAGs?
[    0.481689] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.485626] OMAP DMA hardware revision 5.0
[    0.524932] edma-dma-engine edma-dma-engine.0: Can't allocate PaRAM =
dummy slot
[    0.525024] edma-dma-engine: probe of edma-dma-engine.0 failed with =
error -5
[    0.577453] omap-dma-engine 48056000.dma-controller: OMAP DMA engine=
 driver
[    0.579772] hsusb2_vbus: 5000 mV
[    0.581207] regulator-w3cbw003c-npoweron: 3300 mV
[    0.581817] reg-fixed-voltage regulator-w3cbw003c-wifi-nreset.8: cou=
ld not find pctldev for node /ocp/pinmux@48002030/pinmux_w3cbw003c_pins=
, deferring probe
[    0.581848] platform regulator-w3cbw003c-wifi-nreset.8: Driver reg-f=
ixed-voltage requests probe deferral
[    0.582672] regulator-w3cbw003c-bt-nreset: 3300 mV
[    0.583679] lis33-3v3-reg: 3300 mV
[    0.584686] lis33-1v8-reg: 1800 mV
[    0.585723] vddvario: no parameters
[    0.586761] vdd33a: no parameters
[    0.592834] SCSI subsystem initialized
[    0.594055] usbcore: registered new interface driver usbfs
[    0.594299] usbcore: registered new interface driver hub
[    0.595367] usbcore: registered new device driver usb
[    0.598114] omap_i2c 48070000.i2c: could not find pctldev for node /=
ocp/pinmux@48002030/pinmux_i2c1_pins, deferring probe
[    0.598144] platform 48070000.i2c: Driver omap_i2c requests probe de=
ferral
[    0.598266] omap_i2c 48060000.i2c: could not find pctldev for node /=
ocp/pinmux@48002030/pinmux_i2c3_pins, deferring probe
[    0.598297] platform 48060000.i2c: Driver omap_i2c requests probe de=
ferral
[    0.605926] Switched to clocksource 32k_counter
[    0.848510] NET: Registered protocol family 2
[    0.850952] TCP established hash table entries: 2048 (order: 1, 8192=
 bytes)
[    0.851165] TCP bind hash table entries: 2048 (order: 4, 73728 bytes=
)
[    0.852294] TCP: Hash tables configured (established 2048 bind 2048)
[    0.852508] TCP: reno registered
[    0.852539] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.852844] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.854583] NET: Registered protocol family 1
[    0.857055] RPC: Registered named UNIX socket transport module.
[    0.857086] RPC: Registered udp transport module.
[    0.857116] RPC: Registered tcp transport module.
[    0.857116] RPC: Registered tcp NFSv4.1 backchannel transport module=
=2E
[    0.858764] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver, =
5 counters available
[    0.866516] futex hash table entries: 256 (order: 2, 16384 bytes)
[    1.081726] VFS: Disk quotas dquot_6.5.2
[    1.081939] Dquot-cache hash table entries: 1024 (order 0, 4096 byte=
s)
[    1.084777] NFS: Registering the id_resolver key type
[    1.085327] Key type id_resolver registered
[    1.085357] Key type id_legacy registered
[    1.085510] jffs2: version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red =
Hat, Inc.
[    1.086181] msgmni has been set to 444
[    1.094024] io scheduler noop registered
[    1.094055] io scheduler deadline registered
[    1.094299] io scheduler cfq registered (default)
[    1.098083] pinctrl-single 48002030.pinmux: 284 pins at pa fa002030 =
size 568
[    1.098846] pinctrl-single 48002a00.pinmux: 46 pins at pa fa002a00 s=
ize 92
[    1.100158] pinctrl-single 480025a0.pinmux: 46 pins at pa fa0025a0 s=
ize 92
[    1.103240] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.113128] omap_uart 4806a000.serial: no wakeirq for uart0
[    1.115661] 4806a000.serial: ttyO0 at MMIO 0x4806a000 (irq =3D 88, b=
ase_baud =3D 3000000) is a OMAP UART0
[    1.118194] omap_uart 4806c000.serial: no wakeirq for uart0
[    1.119415] 4806c000.serial: ttyO1 at MMIO 0x4806c000 (irq =3D 89, b=
ase_baud =3D 3000000) is a OMAP UART1
[    1.121215] omap_uart 49020000.serial: no wakeirq for uart0
[    1.122436] 49020000.serial: ttyO2 at MMIO 0x49020000 (irq =3D 90, b=
ase_baud =3D 3000000) is a OMAP UART2
[    1.917083] console [ttyO2] enabled
[    1.936828] omap_uart 49042000.serial: no wakeirq for uart0
[    1.943939] 49042000.serial: ttyO3 at MMIO 0x49042000 (irq =3D 96, b=
ase_baud =3D 3000000) is a OMAP UART3
[    1.999755] brd: module loaded
[    2.026184] loop: module loaded
[    2.033477] mtdoops: mtd device (mtddev=3Dname/number) must be suppl=
ied
[    2.208862] libphy: smsc911x-mdio: probed
[    2.284942] smsc911x 2c000000.ethernet eth0: attached PHY driver [SM=
SC LAN8700] (mii_bus:phy_addr=3D2c000000.etherne:01, irq=3D-1)
[    2.297485] smsc911x 2c000000.ethernet eth0: MAC Address: 3a:3b:e0:f=
c:3b:5e
[    2.306518] usbcore: registered new interface driver asix
[    2.312438] usbcore: registered new interface driver ax88179_178a
[    2.319122] usbcore: registered new interface driver cdc_ether
[    2.325592] usbcore: registered new interface driver smsc95xx
[    2.331817] usbcore: registered new interface driver net1080
[    2.338012] usbcore: registered new interface driver cdc_subset
[    2.344482] usbcore: registered new interface driver zaurus
[    2.350677] usbcore: registered new interface driver cdc_ncm
[    2.358398] usbcore: registered new interface driver cdc_wdm
[    2.364715] usbcore: registered new interface driver usb-storage
[    2.371307] usbcore: registered new interface driver usbtest
[    2.380249] mousedev: PS/2 mouse device common for all mice
[    2.389984] i2c /dev entries driver
[    2.393768] Driver for 1-wire Dallas network protocol.
[    2.403289] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout =
60 sec
[    2.414398] omap_hsmmc 4809c000.mmc: unable to get vmmc regulator -5=
17
[    2.421844] platform 4809c000.mmc: Driver omap_hsmmc requests probe =
deferral
[    2.465759] usbcore: registered new interface driver usbhid
[    2.471649] usbhid: USB HID core driver
[    2.477569] oprofile: using arm/armv7
[    2.482238] TCP: cubic registered
[    2.485870] Initializing XFRM netlink socket
[    2.490539] NET: Registered protocol family 17
[    2.495391] NET: Registered protocol family 15
[    2.500488] Key type dns_resolver registered
[    2.507141] ThumbEE CPU extension supported.
[    2.511688] Registering SWP/SWPB emulation handler
[    2.530731] lis33-1v8-reg: disabling
[    2.534729] lis33-3v3-reg: disabling
[    2.538513] regulator-w3cbw003c-bt-nreset: disabling
[    2.543762] hsusb2_vbus: disabling
[    2.551361] regulator-w3cbw003c-wifi-nreset: 3300 mV
[    2.582183] twl 0-0048: PIH (irq 23) chaining IRQs 338..346
[    2.588989] twl 0-0048: power (irq 343) chaining IRQs 346..353
[    2.601501] twl_rtc rtc.16: Enabling TWL-RTC
[    2.613494] twl_rtc rtc.16: rtc core: registered rtc.16 as rtc0
[    2.630218] mmc0: new SDIO card at address 0001
[    2.638488] VAUX1: at 3000 mV
[    2.646392] VAUX2_4030: at 1800 mV
[    2.653961] VAUX3: at 2800 mV
[    2.661163] VAUX4: at 2800 mV
[    2.668762] VDD1: 600 <--> 1450 mV at 1200 mV
[    2.677764] VDAC: 1800 mV
[    2.686553] VIO: at 1800 mV
[    2.694061] VINTANA1: 1500 mV
[    2.702056] VINTANA2: at 2750 mV
[    2.710357] VINTDIG: 1500 mV
[    2.716766] VMMC1: 1850 <--> 3150 mV at 3150 mV
[    2.725708] VMMC2: 1850 <--> 3150 mV at 2600 mV
[    2.733276] VUSB1V5: 1500 mV
[    2.739349] VUSB1V8: 1800 mV
[    2.744842] VUSB3V1: 3100 mV
[    2.752441] VPLL1: at 1800 mV
[    2.760406] VPLL2: 1800 mV
[    2.766998] VSIM: 1800 <--> 3000 mV at 1800 mV
[    2.775390] twl4030_gpio twl4030-gpio: gpio (irq 338) chaining IRQs =
354..371
[    2.792175] input: twl4030_pwrbutton as /devices/68000000.ocp/480700=
00.i2c/i2c-0/0-0048/pwrbutton.40/input/input0
[    2.807617] twl4030_keypad keypad.41: OF: linux,keymap property not =
defined in /ocp/i2c@48070000/twl@48/keypad
[    2.818420] twl4030_keypad keypad.41: Failed to build keymap
[    2.824615] twl4030_keypad: probe of keypad.41 failed with error -2
[    2.831420] omap_i2c 48070000.i2c: bus 0 rev4.4 at 2600 kHz
[    2.844818] omap_i2c 48060000.i2c: bus 2 rev4.4 at 100 kHz
[    2.903289] twl_rtc rtc.16: setting system clock to 2000-05-01 09:16=
:58 UTC (957172618)
[    3.088623] smsc911x 2c000000.ethernet eth0: SMSC911x/921x identifie=
d at 0xcf87c000, IRQ: 288
[    3.114654] IP-Config: Guessing netmask 255.255.255.0
[    3.120574] IP-Config: Complete:
[    3.123992]      device=3Deth0, hwaddr=3D3a:3b:e0:fc:3b:5e, ipaddr=3D=
192.168.100.7, mask=3D255.255.255.0, gw=3D192.168.100.1
[    3.135009]      host=3D192.168.100.7, domain=3D, nis-domain=3D(none=
)
[    3.141265]      bootserver=3D255.255.255.255, rootserver=3D192.168.=
100.1, rootpath=3D
[    3.207244] mmc1: host does not support reading read-only switch. as=
suming write-enable.
[    3.218902] mmc1: new high speed SDHC card at address 1234
[    3.227722] mmcblk0: mmc1:1234 SA04G 3.63 GiB
[    3.240112]  mmcblk0: p1 p2
[    8.184692] VFS: Mounted root (nfs filesystem) on device 0:13.
[    8.193328] devtmpfs: mounted
[    8.197631] Freeing unused kernel memory: 388K (c07a0000 - c0801000)
[    8.809020] systemd[1]: systemd 208 running in system mode. (-PAM +L=
IBWRAP -AUDIT -SELINUX +IMA +SYSVINIT -LIBCRYPTSETUP +GCRYPT +ACL -XZ)

Welcome to Linux!

[    8.880523] systemd[1]: Failed to insert module 'autofs4'
[    8.887298] systemd[1]: Failed to insert module 'ipv6'
[    8.897216] systemd[1]: Set hostname to <grundfos-beaglebone>.
[    8.973663] random: systemd urandom read with 28 bits of entropy ava=
ilable
[    9.583892] systemd[1]: Starting Forward Password Requests to Wall D=
irectory Watch.
[    9.595245] systemd[1]: Started Forward Password Requests to Wall Di=
rectory Watch.
[    9.603393] systemd[1]: Expecting device dev-ttyO2.device...
         Expecting device dev-ttyO2.device...
[    9.624999] systemd[1]: Starting Remote File Systems.
[  OK  ] Reached target Remote File Systems.
[    9.644958] systemd[1]: Reached target Remote File Systems.
[    9.651000] systemd[1]: Starting Delayed Shutdown Socket.
[  OK  ] Listening on Delayed Shutdown Socket.
[    9.674926] systemd[1]: Listening on Delayed Shutdown Socket.
[    9.681152] systemd[1]: Starting /dev/initctl Compatibility Named Pi=
pe.
[  OK  ] Listening on /dev/initctl Compatibility Named Pipe.
[    9.704956] systemd[1]: Listening on /dev/initctl Compatibility Name=
d Pipe.
[    9.712463] systemd[1]: Starting Root Slice.
[  OK  ] Created slice Root Slice.
[    9.734954] systemd[1]: Created slice Root Slice.
[    9.740051] systemd[1]: Starting User and Session Slice.
[  OK  ] Created slice User and Session Slice.
[    9.764953] systemd[1]: Created slice User and Session Slice.
[    9.771179] systemd[1]: Starting System Slice.
[  OK  ] Created slice System Slice.
[    9.794952] systemd[1]: Created slice System Slice.
[    9.800231] systemd[1]: Starting system-getty.slice.
[  OK  ] Created slice system-getty.slice.
[    9.824951] systemd[1]: Created slice system-getty.slice.
[    9.830780] systemd[1]: Starting system-serial\x2dgetty.slice.
[  OK  ] Created slice system-serial\x2dgetty.slice.
[    9.854980] systemd[1]: Created slice system-serial\x2dgetty.slice.
[    9.861724] systemd[1]: Starting Slices.
[  OK  ] Reached target Slices.
[    9.884948] systemd[1]: Reached target Slices.
[    9.890380] systemd[1]: Starting Arbitrary Executable File Formats F=
ile System Automount Point.
[    9.900451] systemd[1]: Failed to open /dev/autofs: No such file or =
directory
[    9.908233] systemd[1]: Failed to initialize automounter: No such fi=
le or directory
[FAILED] Failed to set up automount Arbitrary Executable File...utomoun=
t Point.
See 'systemctl status proc-sys-fs-binfmt_misc.automount' for details.
[    9.954925] systemd[1]: Failed to set up automount Arbitrary Executa=
ble File Formats File System Automount Point.
[    9.966003] systemd[1]: Unit proc-sys-fs-binfmt_misc.automount enter=
ed failed state.
[    9.974609] systemd[1]: Starting Dispatch Password Requests to Conso=
le Directory Watch.
[    9.984344] systemd[1]: Started Dispatch Password Requests to Consol=
e Directory Watch.
[    9.992828] systemd[1]: Starting Paths.
[  OK  ] Reached target Paths.
[   10.014923] systemd[1]: Reached target Paths.
[   10.019805] systemd[1]: Starting udev Kernel Socket.
[  OK  ] Listening on udev Kernel Socket.
[   10.045227] systemd[1]: Listening on udev Kernel Socket.
[   10.051116] systemd[1]: Starting udev Control Socket.
[  OK  ] Listening on udev Control Socket.
[   10.074981] systemd[1]: Listening on udev Control Socket.
[   10.080841] systemd[1]: Starting Journal Socket.
[  OK  ] Listening on Journal Socket.
[   10.104980] systemd[1]: Listening on Journal Socket.
[   10.117675] systemd[1]: Starting Apply Kernel Variables...
         Starting Apply Kernel Variables...
[   10.168121] systemd[1]: Started Load Kernel Modules.
[   10.173767] systemd[1]: Mounted FUSE Control File System.
[   10.191741] systemd[1]: Starting udev Coldplug all Devices...
         Starting udev Coldplug all Devices...
         Starting Journal Service...
[  OK  ] Started Journal Service.
         Mounting Debug File System...
         Starting Setup Virtual Console...
         Mounting POSIX Message Queue File System...
         Starting Create list of required static device nodes...rrent k=
ernel...
[  OK  ] Reached target Swap.
         Mounting Temporary Directory...
         Starting Load/Save Random Seed...
[  OK  ] Started Apply Kernel Variables.
[  OK  ] Mounted Debug File System.
[  OK  ] Mounted POSIX Message Queue File System.
[  OK  ] Mounted Temporary Directory.
[  OK  ] Started Load/Save Random Seed.
[  OK  ] Started Create list of required static device nodes ...current=
 kernel.
         Starting Create static device nodes in /dev...
[  OK  ] Started Setup Virtual Console.
[  OK  ] Started Create static device nodes in /dev.
         Starting udev Kernel Device Manager...
[  OK  ] Reached target Local File Systems (Pre).
[  OK  ] Reached target Local File Systems.
         Starting Trigger Flushing of Journal to Persistent Storage...
         Starting Recreate Volatile Files and Directories...
[  OK  ] Started udev Kernel Device Manager.
[  OK  ] Started Trigger Flushing of Journal to Persistent Storage.
[  OK  ] Started Recreate Volatile Files and Directories.
         Starting Update UTMP about System Reboot/Shutdown...
[  OK  ] Started Update UTMP about System Reboot/Shutdown.
[  OK  ] Started udev Coldplug all Devices.
[  OK  ] Reached target System Initialization.
[  OK  ] Listening on D-Bus System Message Bus Socket.
[  OK  ] Listening on OpenSSH Socket.
[  OK  ] Reached target Sockets.
[  OK  ] Reached target Timers.
[  OK  ] Reached target Basic System.
         Starting Setup network on beaglebone...
         Starting Login Service...
         Starting D-Bus System Message Bus...
[  OK  ] Started D-Bus System Message Bus.
         Starting Permit User Sessions...
[  OK  ] Started Permit User Sessions.
         Starting Getty on tty1...
[  OK  ] Started Getty on tty1.
[  OK  ] Found device /dev/ttyO2.
         Starting Serial Getty on ttyO2...
[  OK  ] Started Serial Getty on ttyO2.
[  OK  ] Reached target Login Prompts.
[   18.839508] omap-twl4030 sound.4: ASoC: CPU DAI (null) not registere=
d
[   18.846954] omap-twl4030 sound.4: devm_snd_soc_register_card() faile=
d: -517
[   18.868682] omap-twl4030 sound.4: ASoC: CPU DAI (null) not registere=
d
[   18.876068] omap-twl4030 sound.4: devm_snd_soc_register_card() faile=
d: -517
[   18.993011] omap-twl4030 sound.4: ASoC: CPU DAI (null) not registere=
d
[   19.000183] omap-twl4030 sound.4: devm_snd_soc_register_card() faile=
d: -517
[   19.936645] omap-twl4030 sound.4: ASoC: CPU DAI (null) not registere=
d
[   19.943572] omap-twl4030 sound.4: devm_snd_soc_register_card() faile=
d: -517


=2E...................


[   56.368255] Unable to handle kernel NULL pointer dereference at virt=
ual address 00000000
[   56.376831] BUG: spinlock bad magic on CPU#0, dd/1570
[   56.382171]  lock: jiffies_lock+0x14/0x40, .magic: 00000000, .owner:=
 <none>/-1, .owner_cpu: 0
[   56.391174] CPU: 0 PID: 1570 Comm: dd Tainted: G        W     3.15.0=
 #3
[   56.398193] [<c00153a0>] (unwind_backtrace) from [<c0011fa0>] (show_=
stack+0x10/0x14)
[   56.406372] [<c0011fa0>] (show_stack) from [<c054b010>] (dump_stack+=
0x84/0x9c)
[   56.414001] [<c054b010>] (dump_stack) from [<c008927c>] (do_raw_spin=
_lock+0x158/0x198)
[   56.422363] [<c008927c>] (do_raw_spin_lock) from [<c00a540c>] (tick_=
do_update_jiffies64+0x4c/0x1a8)
[   56.431915] [<c00a540c>] (tick_do_update_jiffies64) from [<c00a5d84>=
] (tick_sched_timer+0x44/0x90)
[   56.441375] [<c00a5d84>] (tick_sched_timer) from [<c0062908>] (__run=
_hrtimer+0x7c/0x1e0)
[   56.449920] [<c0062908>] (__run_hrtimer) from [<c0063530>] (hrtimer_=
interrupt+0x128/0x2b8)
[   56.458648] [<c0063530>] (hrtimer_interrupt) from [<c0025ea8>] (omap=
2_gp_timer_interrupt+0x24/0x34)
[   56.468200] [<c0025ea8>] (omap2_gp_timer_interrupt) from [<c008fd44>=
] (handle_irq_event_percpu+0x40/0x1c4)
[   56.478393] [<c008fd44>] (handle_irq_event_percpu) from [<c008ff04>]=
 (handle_irq_event+0x3c/0x5c)
[   56.487762] [<c008ff04>] (handle_irq_event) from [<c00928e4>] (handl=
e_level_irq+0xac/0x154)
[   56.496551] [<c00928e4>] (handle_level_irq) from [<c008f424>] (gener=
ic_handle_irq+0x28/0x3c)
[   56.505462] [<c008f424>] (generic_handle_irq) from [<c000ee48>] (han=
dle_IRQ+0x4c/0xb4)
[   56.513824] [<c000ee48>] (handle_IRQ) from [<c00085fc>] (omap3_intc_=
handle_irq+0x80/0x9c)
[   56.522460] [<c00085fc>] (omap3_intc_handle_irq) from [<c0551264>] (=
__irq_svc+0x44/0x5c)
[   56.531005] Exception stack(0xcd1cbba0 to 0xcd1cbbe8)
[   56.536346] bba0: 00000001 cd7b8d58 00000000 cd7b8800 0000004c 00000=
001 c085d118 c0d96170
[   56.544982] bbc0: 00000000 00000000 00000000 60000113 00000001 cd1cb=
be8 c008412c c008dd24
[   56.553588] bbe0: 60000113 ffffffff
[   56.557281] [<c0551264>] (__irq_svc) from [<c008dd24>] (vprintk_emit=
+0x1ac/0x544)
[   56.565185] [<c008dd24>] (vprintk_emit) from [<c0548ecc>] (printk+0x=
30/0x40)
[   56.572631] [<c0548ecc>] (printk) from [<c05477ec>] (__do_kernel_fau=
lt.part.11+0x38/0x74)
[   56.581268] [<c05477ec>] (__do_kernel_fault.part.11) from [<c0552c94=
>] (do_page_fault.part.12+0x19c/0x3c4)
[   56.591461] [<c0552c94>] (do_page_fault.part.12) from [<c0552f34>] (=
do_page_fault+0x78/0x88)
[   56.600372] [<c0552f34>] (do_page_fault) from [<c000847c>] (do_Prefe=
tchAbort+0x34/0x98)
[   56.608825] [<c000847c>] (do_PrefetchAbort) from [<c0551364>] (__pab=
t_svc+0x44/0xa0)
[   56.617004] Exception stack(0xcd1cbdb0 to 0xcd1cbdf8)
[   56.622314] bda0:                                     c080408c 00001=
06f 0e4c8000 00000000
[   56.630950] bdc0: 00000003 c080408c 00000008 cd1ca000 00000004 c08a3=
790 00000100 00000000
[   56.639587] bde0: c07fe628 cd1cbdf8 c004558c 00000000 60000113 fffff=
fff
[   56.646575] [<c0551364>] (__pabt_svc) from [<c004558c>] (__do_softir=
q+0x138/0x33c)
[   56.654571] [<c004558c>] (__do_softirq) from [<c0045a7c>] (irq_exit+=
0xb0/0x104)
[   56.662292] [<c0045a7c>] (irq_exit) from [<c000ee50>] (handle_IRQ+0x=
54/0xb4)
[   56.669738] [<c000ee50>] (handle_IRQ) from [<c00085fc>] (omap3_intc_=
handle_irq+0x80/0x9c)
[   56.678344] [<c00085fc>] (omap3_intc_handle_irq) from [<c0551264>] (=
__irq_svc+0x44/0x5c)
[   56.686889] Exception stack(0xcd1cbe88 to 0xcd1cbed0)
[   56.692230] be80:                   cb8b70e8 00020001 013e9c00 00000=
000 013ea000 00000000
[   56.700866] bea0: 00000400 00000000 cd541ac0 cd1cbf10 cd1cbf08 00000=
000 70000000 cd1cbed0
[   56.709472] bec0: c008412c c00e2888 40000013 ffffffff
[   56.714813] [<c0551264>] (__irq_svc) from [<c00e2888>] (generic_file=
_aio_write+0xd0/0xec)
[   56.723480] [<c00e2888>] (generic_file_aio_write) from [<c011f3d8>] =
(do_sync_write+0x7c/0xa4)
[   56.732482] [<c011f3d8>] (do_sync_write) from [<c011fbd4>] (vfs_writ=
e+0xac/0x188)
[   56.740386] [<c011fbd4>] (vfs_write) from [<c01201b0>] (SyS_write+0x=
40/0x94)
[   56.747833] [<c01201b0>] (SyS_write) from [<c000e520>] (ret_fast_sys=
call+0x0/0x48)
[   56.755828] INFO: rcu_sched self-detected stall on CPU { 0}  (t=3D24=
365 jiffies g=3D1189 c=3D1188 q=3D2)
[   56.765136] CPU: 0 PID: 1570 Comm: dd Tainted: G        W     3.15.0=
 #3
[   56.772155] [<c00153a0>] (unwind_backtrace) from [<c0011fa0>] (show_=
stack+0x10/0x14)
[   56.780303] [<c0011fa0>] (show_stack) from [<c054b010>] (dump_stack+=
0x84/0x9c)
[   56.787963] [<c054b010>] (dump_stack) from [<c0099ce8>] (rcu_check_c=
allbacks+0x3f4/0x8b4)
[   56.796600] [<c0099ce8>] (rcu_check_callbacks) from [<c004d64c>] (up=
date_process_times+0x40/0x60)
[   56.805969] [<c004d64c>] (update_process_times) from [<c00a5d34>] (t=
ick_sched_handle.isra.18+0x44/0x50)
[   56.815856] [<c00a5d34>] (tick_sched_handle.isra.18) from [<c00a5d9c=
>] (tick_sched_timer+0x5c/0x90)
[   56.825408] [<c00a5d9c>] (tick_sched_timer) from [<c0062908>] (__run=
_hrtimer+0x7c/0x1e0)
[   56.833953] [<c0062908>] (__run_hrtimer) from [<c0063530>] (hrtimer_=
interrupt+0x128/0x2b8)
[   56.842681] [<c0063530>] (hrtimer_interrupt) from [<c0025ea8>] (omap=
2_gp_timer_interrupt+0x24/0x34)
[   56.852233] [<c0025ea8>] (omap2_gp_timer_interrupt) from [<c008fd44>=
] (handle_irq_event_percpu+0x40/0x1c4)
[   56.862426] [<c008fd44>] (handle_irq_event_percpu) from [<c008ff04>]=
 (handle_irq_event+0x3c/0x5c)
[   56.871795] [<c008ff04>] (handle_irq_event) from [<c00928e4>] (handl=
e_level_irq+0xac/0x154)
[   56.880615] [<c00928e4>] (handle_level_irq) from [<c008f424>] (gener=
ic_handle_irq+0x28/0x3c)
[   56.889526] [<c008f424>] (generic_handle_irq) from [<c000ee48>] (han=
dle_IRQ+0x4c/0xb4)
[   56.897888] [<c000ee48>] (handle_IRQ) from [<c00085fc>] (omap3_intc_=
handle_irq+0x80/0x9c)
[   56.906524] [<c00085fc>] (omap3_intc_handle_irq) from [<c0551264>] (=
__irq_svc+0x44/0x5c)
[   56.915039] Exception stack(0xcd1cbba0 to 0xcd1cbbe8)
[   56.920379] bba0: 00000001 cd7b8d58 00000000 cd7b8800 0000004c 00000=
001 c085d118 c0d96170
[   56.929016] bbc0: 00000000 00000000 00000000 60000113 00000001 cd1cb=
be8 c008412c c008dd24
[   56.937622] bbe0: 60000113 ffffffff
[   56.941314] [<c0551264>] (__irq_svc) from [<c008dd24>] (vprintk_emit=
+0x1ac/0x544)
[   56.949218] [<c008dd24>] (vprintk_emit) from [<c0548ecc>] (printk+0x=
30/0x40)
[   56.956665] [<c0548ecc>] (printk) from [<c05477ec>] (__do_kernel_fau=
lt.part.11+0x38/0x74)
[   56.965301] [<c05477ec>] (__do_kernel_fault.part.11) from [<c0552c94=
>] (do_page_fault.part.12+0x19c/0x3c4)
[   56.975494] [<c0552c94>] (do_page_fault.part.12) from [<c0552f34>] (=
do_page_fault+0x78/0x88)
[   56.984405] [<c0552f34>] (do_page_fault) from [<c000847c>] (do_Prefe=
tchAbort+0x34/0x98)
[   56.992858] [<c000847c>] (do_PrefetchAbort) from [<c0551364>] (__pab=
t_svc+0x44/0xa0)
[   57.001007] Exception stack(0xcd1cbdb0 to 0xcd1cbdf8)
[   57.006347] bda0:                                     c080408c 00001=
06f 0e4c8000 00000000
[   57.014984] bdc0: 00000003 c080408c 00000008 cd1ca000 00000004 c08a3=
790 00000100 00000000
[   57.023590] bde0: c07fe628 cd1cbdf8 c004558c 00000000 60000113 fffff=
fff
[   57.030578] [<c0551364>] (__pabt_svc) from [<c004558c>] (__do_softir=
q+0x138/0x33c)
[   57.038574] [<c004558c>] (__do_softirq) from [<c0045a7c>] (irq_exit+=
0xb0/0x104)
[   57.046295] [<c0045a7c>] (irq_exit) from [<c000ee50>] (handle_IRQ+0x=
54/0xb4)
[   57.053741] [<c000ee50>] (handle_IRQ) from [<c00085fc>] (omap3_intc_=
handle_irq+0x80/0x9c)
[   57.062377] [<c00085fc>] (omap3_intc_handle_irq) from [<c0551264>] (=
__irq_svc+0x44/0x5c)
[   57.070892] Exception stack(0xcd1cbe88 to 0xcd1cbed0)
[   57.076232] be80:                   cb8b70e8 00020001 013e9c00 00000=
000 013ea000 00000000
[   57.084869] bea0: 00000400 00000000 cd541ac0 cd1cbf10 cd1cbf08 00000=
000 70000000 cd1cbed0
[   57.093505] bec0: c008412c c00e2888 40000013 ffffffff
[   57.098846] [<c0551264>] (__irq_svc) from [<c00e2888>] (generic_file=
_aio_write+0xd0/0xec)
[   57.107452] [<c00e2888>] (generic_file_aio_write) from [<c011f3d8>] =
(do_sync_write+0x7c/0xa4)
[   57.116455] [<c011f3d8>] (do_sync_write) from [<c011fbd4>] (vfs_writ=
e+0xac/0x188)
[   57.124359] [<c011fbd4>] (vfs_write) from [<c01201b0>] (SyS_write+0x=
40/0x94)
[   57.131805] [<c01201b0>] (SyS_write) from [<c000e520>] (ret_fast_sys=
call+0x0/0x48)
[   57.139923] pgd =3D cd460000
[   57.142791] [00000000] *pgd=3D8d50e831, *pte=3D00000000, *ppte=3D000=
00000
[   57.149505] Internal error: Oops: 80000007 [#1] SMP ARM
[   57.154998] Modules linked in: libertas_sdio libertas lib80211 cfg80=
211 snd_soc_omap snd_soc_twl4030 snd_soc_omap_twl4030 snd_pcm_dmaengine=
 snd_soc_core snd_compress snd_pcm snd_time
r snd soundcore
[   57.173675] CPU: 0 PID: 1570 Comm: dd Tainted: G        W     3.15.0=
 #3
[   57.180664] task: cd7b8800 ti: cd1ca000 task.ti: cd1ca000
[   57.186340] PC is at 0x0
[   57.189025] LR is at __do_softirq+0x138/0x33c
[   57.193634] pc : [<00000000>]    lr : [<c004558c>]    psr: 60000113
[   57.193634] sp : cd1cbdf8  ip : c07fe628  fp : 00000000
[   57.205749] r10: 00000100  r9 : c08a3790  r8 : 00000004
[   57.211242] r7 : cd1ca000  r6 : 00000008  r5 : c080408c  r4 : 000000=
03
[   57.218139] r3 : 00000000  r2 : 0e4c8000  r1 : 0000106f  r0 : c08040=
8c
[   57.225036] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Seg=
ment user
[   57.232543] Control: 10c5387d  Table: 8d460019  DAC: 00000015
[   57.238616] Process dd (pid: 1570, stack limit =3D 0xcd1ca248)
[   57.244567] Stack: (0xcd1cbdf8 to 0xcd1cc000)
[   57.249176] bde0:                                                   =
    cd00a100 cd161e10
[   57.257812] be00: 00000001 0000000c 00000000 cd1ca038 0000000a 00000=
001 00400000 00000001
[   57.266448] be20: cee22020 cd1ca008 c0800220 cd1ca000 00000032 00000=
000 cd1cbf10 cd1cbf08
[   57.275054] be40: 00000000 c0045a7c cd7b8800 c080b7e4 c0800220 c000e=
e50 fa200000 cd1cbe88
[   57.283691] be60: c08a6a10 00000032 cd541ac0 c00085fc cd7b8800 c00e2=
888 40000013 ffffffff
[   57.292327] be80: cd1cbebc c0551264 cb8b70e8 00020001 013e9c00 00000=
000 013ea000 00000000
[   57.300964] bea0: 00000400 00000000 cd541ac0 cd1cbf10 cd1cbf08 00000=
000 70000000 cd1cbed0
[   57.309570] bec0: c008412c c00e2888 40000013 ffffffff cd1ca038 60000=
013 00000000 00000000
[   57.318206] bee0: 013e9c00 00000000 cd1cbf80 00000400 00000400 0001e=
000 00000000 c011f3d8
[   57.326843] bf00: 013e9c00 00000000 0001e000 00000400 cd541ac0 00000=
000 00000000 00000000
[   57.335479] bf20: cd7b8800 00000000 00000000 00000000 013ea000 00000=
000 00000400 00000000
[   57.344116] bf40: 00000000 00000000 cd541ac0 0001e000 cd1cbf80 c011f=
bd4 00000000 00000000
[   57.352722] bf60: cd1ca038 013e9c00 00000000 cd541ac0 cd541ac0 00000=
400 0001e000 c01201b0
[   57.361358] bf80: 013e9c00 00000000 00000400 00000000 0001c730 00000=
400 00000004 c000e6e4
[   57.369995] bfa0: cd1ca000 c000e520 00000000 0001c730 00000001 0001e=
000 00000400 00000000
[   57.378631] bfc0: 00000000 0001c730 00000400 00000004 00000000 0001e=
400 00000001 00000000
[   57.387268] bfe0: 00000000 bef97ad4 0000c470 b6f2a2fc 40000010 00000=
001 00000000 00000000
[   57.395904] [<c004558c>] (__do_softirq) from [<c0045a7c>] (irq_exit+=
0xb0/0x104)
[   57.403625] [<c0045a7c>] (irq_exit) from [<c000ee50>] (handle_IRQ+0x=
54/0xb4)
[   57.411071] [<c000ee50>] (handle_IRQ) from [<c00085fc>] (omap3_intc_=
handle_irq+0x80/0x9c)
[   57.419677] [<c00085fc>] (omap3_intc_handle_irq) from [<c0551264>] (=
__irq_svc+0x44/0x5c)
[   57.428222] Exception stack(0xcd1cbe88 to 0xcd1cbed0)
[   57.433563] be80:                   cb8b70e8 00020001 013e9c00 00000=
000 013ea000 00000000
[   57.442199] bea0: 00000400 00000000 cd541ac0 cd1cbf10 cd1cbf08 00000=
000 70000000 cd1cbed0
[   57.450805] bec0: c008412c c00e2888 40000013 ffffffff
[   57.456146] [<c0551264>] (__irq_svc) from [<c00e2888>] (generic_file=
_aio_write+0xd0/0xec)
[   57.464782] [<c00e2888>] (generic_file_aio_write) from [<c011f3d8>] =
(do_sync_write+0x7c/0xa4)
[   57.473785] [<c011f3d8>] (do_sync_write) from [<c011fbd4>] (vfs_writ=
e+0xac/0x188)
[   57.481689] [<c011fbd4>] (vfs_write) from [<c01201b0>] (SyS_write+0x=
40/0x94)
[   57.489135] [<c01201b0>] (SyS_write) from [<c000e520>] (ret_fast_sys=
call+0x0/0x48)
[   57.497131] Code: bad PC value
[   57.500427] ---[ end trace e11a0ea3c923ac53 ]---
[   57.505310] Kernel panic - not syncing: Fatal exception in interrupt
[   57.512054] ---[ end Kernel panic - not syncing: Fatal exception in =
interrupt






=20
=20
Med venlig hilsen/Best regards=20

 =20
Casper Mogensen    --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
