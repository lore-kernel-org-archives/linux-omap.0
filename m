From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [Bug]: mtd: onenand: omap2plus: kernel panic with OneNAND on OMAP3 (DM3730) device GTA04A5
Date: Tue, 10 Apr 2018 18:25:17 +0200
Message-ID: <5D496D5C-4E3E-47B4-9981-E8F4C348DE00@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>, Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Roger Quadros <rogerq@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

Hi,
we just started testing the v4.16 kernel and found the
device no longer bootable (works with v4.15). It turned
out that there was a harmful modification somewhere between
v4.15.0 and v4.16-rc1.

A git bisect points to this patch:

commit bdaca9345d41fd9420995469d27603ea62054691
Author: Ladislav Michl <ladis@linux-mips.org>
Date:   Fri Jan 12 14:16:57 2018 +0100

   mtd: onenand: omap2: Decouple DMA enabling from INT pin availability

   INT pin (gpio_irq) is not really needed for DMA but only for =
notification
   when a command that needs wait has completed. DMA memcpy can be still =
used
   even without gpio_irq available, so enable it unconditionally.

   Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
   Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
   Tested-by: Tony Lindgren <tony@atomide.com>
   Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
   Acked-by: Roger Quadros <rogerq@ti.com>
   Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Kernel panic log is attached which indeed indicates a DMA problem.

Note that we have added compatible =3D "ti,omap2-onenand";

Any suggestions, fixes?

BR and thanks,
Nikolaus Schaller



## Booting kernel from Legacy Image at 82000000 ...
   Image Name:   Linux-4.16.0-letux+
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    4456744 Bytes =3D 4.3 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 81c00000
   Booting using the fdt blob at 0x81c00000
   Loading Kernel Image ... OK
   Using Device Tree in place at 81c00000, end 81c14a1e

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.16.0-letux+ (hns@iMac.local) (gcc version =
4.9.2 (GCC)) #2187 SMP PREEMPT Tue Apr 10 16:23:45 CEST 2018
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), =
cr=3D10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing =
instruction cache
[    0.000000] OF: fdt: Machine model: Goldelico GTA04A5/Letux 2804
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] Memory policy: Data cache writeback
[    0.000000] cma: Reserved 16 MiB at 0xbe800000
[    0.000000] On node 0 totalpages: 261632
[    0.000000]   Normal zone: 1536 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 196608 pages, LIFO batch:31
[    0.000000]   HighMem zone: 65024 pages, LIFO batch:15
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] OMAP3630/DM3730 ES1.2 (l2cache iva sgx neon isp =
192mhz_clk)
[    0.000000] random: fast init done
[    0.000000] percpu: Embedded 17 pages/cpu @(ptrval) s39744 r8192 =
d21696 u69632
[    0.000000] pcpu-alloc: s39744 r8192 d21696 u69632 alloc=3D17*4096
[    0.000000] pcpu-alloc: [0] 0=20
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: =
260096
[    0.000000] Kernel command line: console=3DttyO2,115200n8 =
mtdoops.mtddev=3Domap2.nand ubi.mtd=3D4 root=3D/dev/mmcblk0p1 rw =
rootfstype=3Dext4,ext3 rootwait console=3DttyO2,115200n8 vram=3D12M =
omapfb.vram=3D0:8M,1:4M omapfb.rotate_type=3D0 omapdss.def_disp=3Dlcd =
rootwait twl4030_charger.allow_usb=3D1 log_buf_len=3D8M ignore_loglevel =
earlyprintk
[    0.000000] log_buf_len: 8388608 bytes
[    0.000000] early log buf free: 63924(97%)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 =
bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 =
bytes)
[    0.000000] Memory: 1002524K/1046528K available (6169K kernel code, =
626K rwdata, 1660K rodata, 1024K init, 218K bss, 27620K reserved, 16384K =
cma-reserved, 243712K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0x(ptrval) - 0x(ptrval)   (7162 kB)
[    0.000000]       .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
[    0.000000]       .data : 0x(ptrval) - 0x(ptrval)   ( 627 kB)
[    0.000000]        .bss : 0x(ptrval) - 0x(ptrval)   ( 219 kB)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=3D2 to nr_cpu_ids=3D1.
[    0.000000]  Tasks RCU enabled.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, =
nr_cpu_ids=3D1
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] IRQ: Found an INTC at 0x(ptrval) (revision 4.0) with 96 =
interrupts
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000000] clocksource: 32k_counter: mask: 0xffffffff max_cycles: =
0xffffffff, max_idle_ns: 58327039986419 ns
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps =
every 65535999984741ns
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.001159] Console: colour dummy device 80x30
[    0.001220] Calibrating delay loop... 597.60 BogoMIPS (lpj=3D2988032)
[    0.117279] pid_max: default: 32768 minimum: 301
[    0.117462] Security Framework initialized
[    0.117553] Mount-cache hash table entries: 2048 (order: 1, 8192 =
bytes)
[    0.117584] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 =
bytes)
[    0.118499] CPU: Testing write buffer coherency: ok
[    0.118988] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.157257] Setting up static identity map for 0x80100000 - =
0x80100060
[    0.177124] Hierarchical SRCU implementation.
[    0.217041] smp: Bringing up secondary CPUs ...
[    0.217071] smp: Brought up 1 node, 1 CPU
[    0.217102] SMP: Total of 1 processors activated (597.60 BogoMIPS).
[    0.217102] CPU: All CPU(s) started in SVC mode.
[    0.219177] devtmpfs: initialized
[    0.247558] VFP support v0.3: implementor 41 architecture 3 part 30 =
variant c rev 3
[    0.248321] clocksource: jiffies: mask: 0xffffffff max_cycles: =
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.248352] futex hash table entries: 256 (order: 2, 16384 bytes)
[    0.249816] pinctrl core: initialized pinctrl subsystem
[    0.251129] NET: Registered protocol family 16
[    0.254211] DMA: preallocated 256 KiB pool for atomic coherent =
allocations
[    0.285614] omap_hwmod: mcbsp2_sidetone using broken dt data from =
mcbsp
[    0.286437] omap_hwmod: mcbsp3_sidetone using broken dt data from =
mcbsp
[    0.367187] audit: initializing netlink subsys (disabled)
[    0.369598] audit: type=3D2000 audit(0.370:1): state=3Dinitialized =
audit_enabled=3D0 res=3D1
[    0.376861] cpuidle: using governor menu
[    0.377777] Reprogramming SDRC clock to 400000000 Hz
[    0.388366] OMAP GPIO hardware version 2.5
[    0.397277] GPIO line 143 (irda_en) hogged as output/high
[    0.430053] omap-gpmc 6e000000.gpmc: could not find pctldev for node =
/ocp@68000000/l4@48000000/scm@2000/pinmux@30/pinmux_gpmc_pins, deferring =
probe
[    0.453155] No ATAGs?
[    0.453155] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.454315] omap4_sram_init:Unable to allocate sram needed to handle =
errata I688
[    0.454345] omap4_sram_init:Unable to get sram pool needed to handle =
errata I688
[    0.454711] OMAP DMA hardware revision 5.0
[    0.553466] omap-dma-engine 48056000.dma-controller: OMAP DMA engine =
driver (LinkedList1/2/3 supported)
[    0.558044] reg-fixed-voltage wlan_en_regulator: could not find =
pctldev for node =
/ocp@68000000/l4@48000000/scm@2000/pinmux@30/pinmux_wlan_pins, deferring =
probe
[    0.558135] reg-fixed-voltage bt_en_regulator: could not find pctldev =
for node /ocp@68000000/l4@48000000/scm@2000/pinmux@30/pinmux_bt_pins, =
deferring probe
[    0.567810] omap-iommu 480bd400.mmu: 480bd400.mmu registered
[    0.569183] iommu: Adding device 480bc000.isp to group 0
[    0.573181] SCSI subsystem initialized
[    0.573822] libata version 3.00 loaded.
[    0.574768] usbcore: registered new interface driver usbfs
[    0.574951] usbcore: registered new interface driver hub
[    0.575195] usbcore: registered new device driver usb
[    0.575897] usb_phy_generic hsusb2_phy: hsusb2_phy supply vcc not =
found, using dummy regulator
[    0.581481] omap_i2c 48070000.i2c: bus 0 rev4.4 at 2600 kHz
[    0.585662] omap_i2c 48072000.i2c: bus 1 rev4.4 at 400 kHz
[    0.588562] omap_i2c 48060000.i2c: bus 2 rev4.4 at 100 kHz
[    0.590576] Advanced Linux Sound Architecture Driver Initialized.
[    0.595062] clocksource: Switched to clocksource 32k_counter
[    0.680328] VFS: Disk quotas dquot_6.6.0
[    0.680480] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 =
bytes)
[    0.713348] NET: Registered protocol family 2
[    0.714935] tcp_listen_portaddr_hash hash table entries: 512 (order: =
0, 6144 bytes)
[    0.714965] TCP established hash table entries: 8192 (order: 3, 32768 =
bytes)
[    0.715087] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.716766] TCP: Hash tables configured (established 8192 bind 8192)
[    0.716979] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.717041] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.717285] NET: Registered protocol family 1
[    0.721435] hw perfevents: no interrupt-affinity property for =
/pmu@54000000, guessing.
[    0.722167] hw perfevents: enabled with armv7_cortex_a8 PMU driver, 5 =
counters available
[    0.733459] Initialise system trusted keyrings
[    0.734985] workingset: timestamp_bits=3D30 max_order=3D18 =
bucket_order=3D0
[    0.735992] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.740325] Key type asymmetric registered
[    0.740356] Asymmetric key parser 'x509' registered
[    0.740447] bounce: pool size: 64 pages
[    0.740600] Block layer SCSI generic (bsg) driver version 0.4 loaded =
(major 251)
[    0.740600] io scheduler noop registered
[    0.740631] io scheduler deadline registered
[    0.740692] io scheduler cfq registered (default)
[    0.740722] io scheduler mq-deadline registered
[    0.740722] io scheduler kyber registered
[    0.748992] pinctrl-single 48002030.pinmux: 284 pins, size 568
[    0.750823] pinctrl-single 48002a00.pinmux: 46 pins, size 92
[    0.751983] pinctrl-single 480025a0.pinmux: 46 pins, size 92
[    0.752716] pinctrl-single 480022d8.pinmux: please update dts to use =
#pinctrl-cells =3D <2>
[    0.752838] pinctrl-single 480022d8.pinmux: initialized with no =
interrupts
[    0.752868] pinctrl-single 480022d8.pinmux: 4 pins, size 4
[    0.753448] pinctrl-single 48002274.pinmux: please update dts to use =
#pinctrl-cells =3D <2>
[    0.753570] pinctrl-single 48002274.pinmux: initialized with no =
interrupts
[    0.753601] pinctrl-single 48002274.pinmux: 4 pins, size 4
[    0.765106] omap_uart 4806a000.serial: no wakeirq for uart0
[    0.765808] 4806a000.serial: ttyO0 at MMIO 0x4806a000 (irq =3D 88, =
base_baud =3D 3000000) is a OMAP UART0
[    0.766876] serial serial0: tty port ttyO0 registered
[    0.767456] omap_uart 4806c000.serial: no wakeirq for uart1
[    0.767669] 4806c000.serial: ttyO1 at MMIO 0x4806c000 (irq =3D 89, =
base_baud =3D 3000000) is a OMAP UART1
[    0.768402] serial serial1: tty port ttyO1 registered
[    0.769042] omap_uart 49020000.serial: no wakeirq for uart2
[    0.769378] 49020000.serial: ttyO2 at MMIO 0x49020000 (irq =3D 90, =
base_baud =3D 3000000) is a OMAP UART2
[    1.675048] console [ttyO2] enabled
[    1.680389] omap_uart 49042000.serial: no wakeirq for uart3
[    1.687011] 49042000.serial: ttyO3 at MMIO 0x49042000 (irq =3D 96, =
base_baud =3D 3000000) is a OMAP UART3
[    1.720733] brd: module loaded
[    1.737548] loop: module loaded
[    1.768859] twl 0-0048: PIH (irq 23) chaining IRQs 145..153
[    1.774841] twl 0-0048: power (irq 150) chaining IRQs 153..160
[    1.790344] VAUX3: Bringing 2800000uV into 2500000-2500000uV
[    1.814697] VMMC2: Bringing 2600000uV into 1800000-1800000uV
[    1.822174] VMMC2: failed to apply 1800000-1800000uV constraint(-22)
[    1.829162] twl4030_reg 48070000.i2c:twl@48:regulator-vmmc2: can't =
register VMMC2, -22
[    1.837707] twl4030_reg: probe of 48070000.i2c:twl@48:regulator-vmmc2 =
failed with error -22
[    1.856262] VSIM: Bringing 1800000uV into 2800000-2800000uV
[    1.899414] libphy: Fixed MDIO Bus: probed
[    1.912872] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) =
Driver
[    1.920806] usbcore: registered new interface driver usb-storage
[    1.928375] mousedev: PS/2 mouse device common for all mice
[    1.937164] twl_rtc 48070000.i2c:twl@48:rtc: Power up reset detected.
[    1.944396] twl_rtc 48070000.i2c:twl@48:rtc: Enabling TWL-RTC
[    1.953063] twl_rtc 48070000.i2c:twl@48:rtc: rtc core: registered =
48070000.i2c:twl@48:rtc as rtc0
[    1.963684] i2c /dev entries driver
[    1.968963] IR NEC protocol handler initialized
[    1.973693] IR RC5(x/sz) protocol handler initialized
[    1.979553] IR RC6 protocol handler initialized
[    1.984313] IR JVC protocol handler initialized
[    1.989166] IR Sony protocol handler initialized
[    1.994018] IR SANYO protocol handler initialized
[    1.999114] IR Sharp protocol handler initialized
[    2.004058] IR MCE Keyboard/mouse protocol handler initialized
[    2.010223] IR XMP protocol handler initialized
[    2.014984] Driver for 1-wire Dallas network protocol.
[    2.022155] ti-soc-thermal 48002524.bandgap: This OMAP thermal sensor =
is unreliable. You've been warned
[    2.032592] ti-soc-thermal 48002524.bandgap: Non-trimmed BGAP, Temp =
not accurate
[    2.043121] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout =
60 sec
[    2.103393] ledtrig-cpu: registered to indicate activity on CPUs
[    2.111541] usbcore: registered new interface driver usbhid
[    2.119415] usbhid: USB HID core driver
[    2.123901] ashmem: initialized
[    2.131225] oprofile: using arm/armv7
[    2.135131] mmc0: host does not support reading read-only switch, =
assuming write-enable
[    2.144989] Initializing XFRM netlink socket
[    2.149841] mmc0: new high speed SDHC card at address b368
[    2.155792] NET: Registered protocol family 17
[    2.160491] NET: Registered protocol family 15
[    2.166320] mmcblk0: mmc0:b368 USD   7.47 GiB=20
[    2.172180] Key type dns_resolver registered
[    2.178070] omap2_set_init_voltage: unable to find boot up OPP for =
vdd_core
[    2.185546] omap2_set_init_voltage: unable to set vdd_core
[    2.192779]  mmcblk0: p1
[    2.196899] ThumbEE CPU extension supported.
[    2.201385] Registering SWP/SWPB emulation handler
[    2.207519] SmartReflex Class3 initialized
[    2.212921] Loading compiled-in X.509 certificates
[    2.234527] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
[    2.240295] gpmc_mem_init: disabling cs 0 mapped at 0x0-0x1000000
[    2.248382] omap2-onenand 4000000.onenand: initializing on CS0 =
(0x04000000), va 5c982521, DMA mode
[    2.258270] OneNAND Manufacturer: Samsung (0xec)
[    2.263092] Muxed OneNAND 512MB 1.8V 16-bit (0x50)
[    2.268188] OneNAND version =3D 0x0232
[    2.271942] Chip support all block unlock
[    2.276153] Chip has 4KiB pagesize
[    2.279724] Chip has cache program feature
[    2.285552] Scanning device for bad blocks
[    2.393066] onenand_bbt_wait: ecc 0xaaaa ctrl 0x0400 intr 0x8080 =
addr1 0x34b addr8 0x0
[    2.401367] OneNAND eraseblock 843 is an initial bad block
[    2.554351] omap2-onenand 4000000.onenand: optimized timings for 83 =
MHz
[    2.561340] 5 ofpart partitions found on MTD device 4000000.onenand
[    2.567932] Creating 5 MTD partitions on "4000000.onenand":
[    2.573730] 0x000000000000-0x000000080000 : "X-Loader"
[    2.580718] 0x000000080000-0x000000240000 : "U-Boot"
[    2.587799] 0x000000240000-0x000000280000 : "U-Boot Env"
[    2.595153] 0x000000280000-0x000000880000 : "Kernel"
[    2.602325] 0x000000880000-0x000020000000 : "File System"
[    2.732788] ubi0: default fastmap pool size: 100
[    2.739837] ubi0: default fastmap WL pool size: 50
[    2.744903] ubi0: attaching mtd4
[    2.751831] omap_hsmmc 480b4000.mmc: card claims to support voltages =
below defined range
[    2.788055] mmc1: new high speed SDIO card at address 0001
[    2.910888] ubi0: scanning is finished
[    2.915283] Unable to handle kernel NULL pointer dereference at =
virtual address 00000000
[    2.923767] pgd =3D 3b4ffe8c
[    2.926635] [00000000] *pgd=3D00000000
[    2.930389] Internal error: Oops: 805 [#1] PREEMPT SMP ARM
[    2.936126] Modules linked in:
[    2.939300] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.16.0-letux+ =
#2187
[    2.946411] Hardware name: Generic OMAP36xx (Flattened Device Tree)
[    2.952972] PC is at v7_dma_inv_range+0x30/0x48
[    2.957733] LR is at dma_cache_maint_page+0xd0/0xe0
[    2.962799] pc : [<c0118abc>]    lr : [<c0113330>]    psr: 60000113
[    2.969360] sp : ee0afca8  ip : c0118b3c  fp : c0a03d54
[    2.974822] r10: 00000002  r9 : 00001000  r8 : c0abcb00
[    2.980255] r7 : c0a06b84  r6 : 000c0000  r5 : 00001000  r4 : =
00000000
[    2.987091] r3 : 0000003f  r2 : 00000040  r1 : 00001000  r0 : =
00000000
[    2.993896] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  =
Segment none
[    3.001342] Control: 10c5387d  Table: 80004019  DAC: 00000051
[    3.007354] Process swapper/0 (pid: 1, stack limit =3D 0xb7652d0f)
[    3.013641] Stack: (0xee0afca8 to 0xee0b0000)
[    3.018188] fca0:                   efff9000 00000000 00001000 =
00000000 00001000 efff9000
[    3.026733] fcc0: 00000002 00000000 ee6f7aa8 02c41000 04000000 =
c0113360 c0118b3c 00000000
[    3.035278] fce0: 00001000 efff9000 00000000 ee6f4810 00001000 =
c0113444 00000400 00000000
[    3.043792] fd00: ee6f7820 c0515110 00000002 00000000 f0957000 =
c0514fc0 ee6f7820 ee0afdc8
[    3.052368] fd20: 00000000 00001000 ee6f7aa8 02c41000 00000000 =
c0511f94 00001000 ee731580
[    3.060913] fd40: 00006000 f0957000 00001000 00000000 00000000 =
00000000 00000000 00000080
[    3.069458] fd60: 00000000 00000000 00000000 00000fff 00007000 =
ee724400 00000000 00000000
[    3.078002] fd80: ee0afe24 00880000 00000000 ee0afdc8 00000000 =
c04f86b0 ee0afdc8 00000000
[    3.086547] fda0: 023c1000 00000000 00006000 ee724400 c04f867c =
c04f6588 ee0afdc8 c0acad34
[    3.095092] fdc0: c022f98c ee71f440 00000000 00006000 00000000 =
00000000 00000000 00000000
[    3.103637] fde0: f0957000 00000000 ee71f440 ee387000 00006000 =
0000008f 00001000 023c1000
[    3.112182] fe00: 00000000 f0957000 00000004 c051ebb8 00006000 =
ee0afe24 f0957000 c022fad0
[    3.120727] fe20: 014080c0 00000000 00000000 ee387000 ee7366f0 =
ee72fa80 ee0afe68 ee736710
[    3.129272] fe40: 00000014 c0acad34 00000000 c051643c 00006000 =
c0acad34 00000000 c023ad90
[    3.137817] fe60: f0957000 00000000 ee387000 00000000 ee387000 =
00000000 ee724400 ee387040
[    3.146362] fe80: 00000014 c0acad34 00000000 c0524e60 ee387000 =
ee72fa80 00000000 ee387000
[    3.154907] fea0: 00000000 ee387040 00000014 c051996c c0acad34 =
00000000 c0acad34 c095483c
[    3.163482] fec0: ee724400 00000004 000000bc 00000000 c0acad38 =
ee724400 c0acad34 00000000
[    3.171997] fee0: c0a9c900 c095483c 00000000 c093b4f0 00000000 =
00000000 c0a06ca0 c0acad39
[    3.180541] ff00: 00000007 c093b3b8 000000bc c09705f4 00000000 =
c0102818 000000bb c08a5ca0
[    3.189086] ff20: 00000000 c014973c 00000000 c08a4e04 00000007 =
00000007 c08a5cb4 efffcad4
[    3.197662] ff40: 000000bb c08a5cb4 efffcad4 00000000 c095483c =
00000007 c0954834 000000bc
[    3.206207] ff60: 00000007 c0954838 000000bc c09705f4 c0a9c900 =
c0900d78 00000007 00000007
[    3.214752] ff80: 00000000 c090058c 00000000 c06ff350 00000000 =
00000000 00000000 00000000
[    3.223297] ffa0: 00000000 c06ff358 00000000 c01010e8 00000000 =
00000000 00000000 00000000
[    3.231842] ffc0: 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000 00000000
[    3.240386] ffe0: 00000000 00000000 00000000 00000000 00000013 =
00000000 ffdfffff fffffd7f
[    3.248962] [<c0118abc>] (v7_dma_inv_range) from [<c0113330>] =
(dma_cache_maint_page+0xd0/0xe0)
[    3.257965] [<c0113330>] (dma_cache_maint_page) from [<c0113360>] =
(__dma_page_cpu_to_dev+0x20/0x90)
[    3.267456] [<c0113360>] (__dma_page_cpu_to_dev) from [<c0113444>] =
(arm_dma_map_page+0x30/0x64)
[    3.276550] [<c0113444>] (arm_dma_map_page) from [<c0515110>] =
(omap2_onenand_read_bufferram+0x150/0x348)
[    3.286468] [<c0515110>] (omap2_onenand_read_bufferram) from =
[<c0511f94>] (onenand_read_oob+0x164/0x668)
[    3.296386] [<c0511f94>] (onenand_read_oob) from [<c04f86b0>] =
(part_read_oob+0x34/0x6c)
[    3.304748] [<c04f86b0>] (part_read_oob) from [<c04f6588>] =
(mtd_read+0xc8/0x108)
[    3.312499] [<c04f6588>] (mtd_read) from [<c051ebb8>] =
(ubi_io_read+0x158/0x250)
[    3.320129] [<c051ebb8>] (ubi_io_read) from [<c051643c>] =
(ubi_read_volume_table+0x1ac/0x8f8)
[    3.328948] [<c051643c>] (ubi_read_volume_table) from [<c0524e60>] =
(ubi_attach+0x134/0x214)
[    3.337677] [<c0524e60>] (ubi_attach) from [<c051996c>] =
(ubi_attach_mtd_dev+0x358/0x794)
[    3.346160] [<c051996c>] (ubi_attach_mtd_dev) from [<c093b4f0>] =
(ubi_init+0x138/0x1d8)
[    3.354431] [<c093b4f0>] (ubi_init) from [<c0102818>] =
(do_one_initcall+0xa8/0x14c)
[    3.362335] [<c0102818>] (do_one_initcall) from [<c0900d78>] =
(kernel_init_freeable+0x110/0x1d4)
[    3.371429] [<c0900d78>] (kernel_init_freeable) from [<c06ff358>] =
(kernel_init+0x8/0x10c)
[    3.380004] [<c06ff358>] (kernel_init) from [<c01010e8>] =
(ret_from_fork+0x14/0x2c)
[    3.387908] Exception stack(0xee0affb0 to 0xee0afff8)
[    3.393188] ffa0:                                     00000000 =
00000000 00000000 00000000
[    3.401733] ffc0: 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000 00000000
[    3.410278] ffe0: 00000000 00000000 00000000 00000000 00000013 =
00000000
[    3.417205] Code: 1e070f3e e1110003 e1c11003 1e071f3e (ee070f36)=20
[    3.423736] ---[ end trace 3d1a74d3a673ac09 ]---
[    3.428649] Kernel panic - not syncing: Attempted to kill init! =
exitcode=3D0x0000000b
[    3.428649]=20
[    3.438201] ---[ end Kernel panic - not syncing: Attempted to kill =
init! exitcode=3D0x0000000b
[    3.438201]=20
