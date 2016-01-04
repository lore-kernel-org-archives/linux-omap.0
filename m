From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
Date: Mon, 4 Jan 2016 20:59:05 +0200
Message-ID: <568AC0F9.2010304@gmail.com>
References: <1432156863-19695-1-git-send-email-tony@atomide.com>
 <568662FC.9050206@gmail.com> <20160104170206.GC12777@atomide.com>
 <201601041834.56056@pali> <20160104174001.GD12777@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160104174001.GD12777@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, pavel@ucw.cz, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On  4.01.2016 19:40, Tony Lindgren wrote:
>> On Monday 04 January 2016 18:02:06 Tony Lindgren wrote:
>>> > >Care to boot with CONFIG_OMAP_GPMC_DEBUG=y and post the gpmc related
>>> > >dmesg output?

Here it is, including the pre-gpmc log, keep in mind this is with 
restored HWMOD_INIT_NO_RESET flag so rootfs is functional and I can get 
dmesg output from the syslog. Don't know if it is helpful :). Also, this 
device has Numonyx onenand (HW rev. 2204), unlike most of the others 
which have Samsung onenand (HW rev. 2101 etc), no idea if it is relevant.

Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] Booting Linux on 
physical CPU 0x0
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] Initializing cgroup 
subsys cpu
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] Linux version 
4.4.0-rc7+ (ivo@ivo-H81M-S2PV) (gcc version 4.7.2 20120701 (prerelease) 
(Linaro GCC 4.7-2012.07) ) #4 PREEMPT Mon Jan 4 20:30:31 EET 2016
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] CPU: ARMv7 Processor 
[411fc083] revision 3 (ARMv7), cr=10c5387d
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] CPU: PIPT / VIPT 
nonaliasing data cache, VIPT nonaliasing instruction cache
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] Machine model: Nokia N900
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] Memory policy: Data 
cache writeback
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] On node 0 totalpages: 
65280
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] free_area_init_node: 
node 0, pgdat c06776f8, node_mem_map cfcf9000
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000]   Normal zone: 512 
pages used for memmap
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000]   Normal zone: 0 pages 
reserved
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000]   Normal zone: 65280 
pages, LIFO batch:15
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] CPU: All CPU(s) 
started in SVC mode.
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] OMAP3430/3530 ES3.1 
(l2cache iva sgx neon isp )
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] pcpu-alloc: s0 r0 
d32768 u32768 alloc=1*32768
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] pcpu-alloc: [0] 0
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] Built 1 zonelists in 
Zone order, mobility grouping on.  Total pages: 64768
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] Kernel command line: 
init=/sbin/preinit ubi.mtd=rootfs root=ubi0:rootfs rootfstype=ubifs 
rootflags=bulk_read,no_chk_data_crc rw mtdoops.mtddev=log console=tty0 
console=ttyO2 omapfb_vram=7M omapfb.mode=lcd:848x480-16 nokia-modem.pm=0
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] PID hash table 
entries: 1024 (order: 0, 4096 bytes)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] Dentry cache hash 
table entries: 32768 (order: 5, 131072 bytes)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] Inode-cache hash table 
entries: 16384 (order: 4, 65536 bytes)
Jan  4 20:42:50 Nokia-N900 cellular: csd[1026]: com.nokia.phone.SIM: 
csd-libsimpb::configure: args=<(null)>
Jan  4 20:42:50 Nokia-N900 cellular: csd[1026]: Succesfully loaded 
plugin <simpb>
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] Memory: 
251588K/261120K available (4487K kernel code, 232K rwdata, 1624K rodata, 
244K init, 256K bss, 9532K reserved, 0K cma-reserved, 0K highmem)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] Virtual kernel memory 
layout:
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000]     vector  : 
0xffff0000 - 0xffff1000   (   4 kB)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000]     fixmap  : 
0xffc00000 - 0xfff00000   (3072 kB)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000]     vmalloc : 
0xd0800000 - 0xff800000   ( 752 MB)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000]     lowmem  : 
0xc0000000 - 0xd0000000   ( 256 MB)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000]     pkmap   : 
0xbfe00000 - 0xc0000000   (   2 MB)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000]     modules : 
0xbf000000 - 0xbfe00000   (  14 MB)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000]       .text : 
0xc0008000 - 0xc0600044   (6113 kB)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000]       .init : 
0xc0601000 - 0xc063e000   ( 244 kB)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000]       .data : 
0xc063e000 - 0xc0678240   ( 233 kB)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000]        .bss : 
0xc0678240 - 0xc06b8628   ( 257 kB)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] SLUB: HWalign=64, 
Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] Preemptible 
hierarchical RCU implementation.
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] ^IBuild-time 
adjustment of leaf fanout to 32.
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] NR_IRQS:16 nr_irqs:16 16
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] IRQ: Found an INTC at 
0xfa200000 (revision 4.0) with 96 interrupts
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] Clocking rate 
(Crystal/Core/MPU): 19.2/332/500 MHz
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] OMAP clockevent 
source: timer1 at 32768 Hz
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000000] clocksource: 
32k_counter: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 
58327039986419 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000030] sched_clock: 32 bits 
at 32kHz, resolution 30517ns, wraps every 65535999984741ns
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000030] OMAP clocksource: 
32k_counter at 32768 Hz
Jan  4 20:42:50 Nokia-N900 kernel: [    0.000579] Console: colour dummy 
device 80x30
Jan  4 20:42:50 Nokia-N900 kernel: [    0.001922] console [tty0] enabled
Jan  4 20:42:50 Nokia-N900 kernel: [    0.001983] Calibrating delay 
loop... 496.43 BogoMIPS (lpj=2482176)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.048522] pid_max: default: 
32768 minimum: 301
Jan  4 20:42:50 Nokia-N900 kernel: [    0.048675] Security Framework 
initialized
Jan  4 20:42:50 Nokia-N900 kernel: [    0.048797] Mount-cache hash table 
entries: 1024 (order: 0, 4096 bytes)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.048858] Mountpoint-cache hash 
table entries: 1024 (order: 0, 4096 bytes)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.049987] Initializing cgroup 
subsys io
Jan  4 20:42:50 Nokia-N900 kernel: [    0.050079] Initializing cgroup 
subsys freezer
Jan  4 20:42:50 Nokia-N900 kernel: [    0.050201] CPU: Testing write 
buffer coherency: ok
Jan  4 20:42:50 Nokia-N900 kernel: [    0.050842] Setting up static 
identity map for 0x80008200 - 0x80008258
Jan  4 20:42:50 Nokia-N900 kernel: [    0.055541] devtmpfs: initialized
Jan  4 20:42:50 Nokia-N900 kernel: [    0.102020] VFP support v0.3: 
implementor 41 architecture 3 part 30 variant c rev 1
Jan  4 20:42:50 Nokia-N900 kernel: [    0.122650] omap_hwmod: 
mcbsp2_sidetone using broken dt data from mcbsp
Jan  4 20:42:50 Nokia-N900 kernel: [    0.123352] omap_hwmod: 
mcbsp3_sidetone using broken dt data from mcbsp
Jan  4 20:42:50 Nokia-N900 kernel: [    0.163696] clocksource: jiffies: 
mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    0.164520] pinctrl core: 
initialized pinctrl subsystem
Jan  4 20:42:50 Nokia-N900 kernel: [    0.166320] NET: Registered 
protocol family 16
Jan  4 20:42:50 Nokia-N900 kernel: [    0.168090] DMA: preallocated 256 
KiB pool for atomic coherent allocations
Jan  4 20:42:50 Nokia-N900 kernel: [    0.198181] cpuidle: using 
governor ladder
Jan  4 20:42:50 Nokia-N900 kernel: [    0.228118] cpuidle: using 
governor menu
Jan  4 20:42:50 Nokia-N900 kernel: [    0.228942] Reprogramming SDRC 
clock to 332000000 Hz
Jan  4 20:42:50 Nokia-N900 kernel: [    0.236511] OMAP GPIO hardware 
version 2.5
Jan  4 20:42:50 Nokia-N900 kernel: [    0.244018] irq: no irq domain 
found for /ocp/l4@48000000/scm@2000/pinmux@30 !
Jan  4 20:42:50 Nokia-N900 kernel: [    0.244720] irq: no irq domain 
found for /ocp/l4@48000000/scm@2000/pinmux@30 !
Jan  4 20:42:50 Nokia-N900 kernel: [    0.259796] omap-gpmc 
6e000000.gpmc: could not find pctldev for node 
/ocp/l4@48000000/scm@2000/pinmux@30/pinmux_gpmc_pins, deferring probe
Jan  4 20:42:50 Nokia-N900 kernel: [    0.264739] RX-51: Add gpio switches
Jan  4 20:42:50 Nokia-N900 kernel: [    0.264831] RX-51: Enabling ARM 
errata 430973 workaround
Jan  4 20:42:50 Nokia-N900 kernel: [    0.266632] RX-51: Registring 
OMAP3 HWRNG device
Jan  4 20:42:50 Nokia-N900 kernel: [    0.270538] hw-breakpoint: debug 
architecture 0x4 unsupported.
Jan  4 20:42:50 Nokia-N900 kernel: [    0.271789] Reserving DMA channels 
0 and 1 for HS ROM code
Jan  4 20:42:50 Nokia-N900 kernel: [    0.271881] OMAP DMA hardware 
revision 4.0
Jan  4 20:42:50 Nokia-N900 kernel: [    0.293609] omap-dma-engine 
48056000.dma-controller: OMAP DMA engine driver
Jan  4 20:42:50 Nokia-N900 kernel: [    0.299499] omap-iommu 
480bd400.mmu: 480bd400.mmu registered
Jan  4 20:42:50 Nokia-N900 kernel: [    0.300292] usbcore: registered 
new interface driver usbfs
Jan  4 20:42:50 Nokia-N900 kernel: [    0.300476] usbcore: registered 
new interface driver hub
Jan  4 20:42:50 Nokia-N900 kernel: [    0.300689] usbcore: registered 
new device driver usb
Jan  4 20:42:50 Nokia-N900 kernel: [    0.301818] omap_i2c 48070000.i2c: 
could not find pctldev for node 
/ocp/l4@48000000/scm@2000/pinmux@30/pinmux_i2c1_pins, deferring probe
Jan  4 20:42:50 Nokia-N900 kernel: [    0.301940] omap_i2c 48072000.i2c: 
could not find pctldev for node 
/ocp/l4@48000000/scm@2000/pinmux@30/pinmux_i2c2_pins, deferring probe
Jan  4 20:42:50 Nokia-N900 kernel: [    0.302093] omap_i2c 48060000.i2c: 
could not find pctldev for node 
/ocp/l4@48000000/scm@2000/pinmux@30/pinmux_i2c3_pins, deferring probe
Jan  4 20:42:50 Nokia-N900 kernel: [    0.303466] omap-mailbox 
48094000.mailbox: omap mailbox rev 0x40
Jan  4 20:42:50 Nokia-N900 kernel: [    0.304077] Advanced Linux Sound 
Architecture Driver Initialized.
Jan  4 20:42:50 Nokia-N900 kernel: [    0.305694] clocksource: Switched 
to clocksource 32k_counter
Jan  4 20:42:50 Nokia-N900 kernel: [    0.325592] NET: Registered 
protocol family 2
Jan  4 20:42:50 Nokia-N900 kernel: [    0.326934] TCP established hash 
table entries: 2048 (order: 1, 8192 bytes)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.327056] TCP bind hash table 
entries: 2048 (order: 1, 8192 bytes)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.327148] TCP: Hash tables 
configured (established 2048 bind 2048)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.327331] UDP hash table 
entries: 256 (order: 0, 4096 bytes)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.327423] UDP-Lite hash table 
entries: 256 (order: 0, 4096 bytes)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.327697] NET: Registered 
protocol family 1
Jan  4 20:42:50 Nokia-N900 kernel: [    0.332336] futex hash table 
entries: 256 (order: -1, 3072 bytes)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.350402] VFS: Disk quotas 
dquot_6.6.0
Jan  4 20:42:50 Nokia-N900 kernel: [    0.350891] VFS: Dquot-cache hash 
table entries: 1024 (order 0, 4096 bytes)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.353790] squashfs: version 4.0 
(2009/01/31) Phillip Lougher
Jan  4 20:42:50 Nokia-N900 kernel: [    0.356262] io scheduler noop 
registered
Jan  4 20:42:50 Nokia-N900 kernel: [    0.356323] io scheduler deadline 
registered
Jan  4 20:42:50 Nokia-N900 kernel: [    0.356781] io scheduler cfq 
registered (default)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.358276] pinctrl-single 
48002030.pinmux: 284 pins at pa fa002030 size 568
Jan  4 20:42:50 Nokia-N900 kernel: [    0.358734] pinctrl-single 
48002a00.pinmux: 46 pins at pa fa002a00 size 92
Jan  4 20:42:50 Nokia-N900 kernel: [    0.359436] pinctrl-single 
480025d8.pinmux: 18 pins at pa fa0025d8 size 36
Jan  4 20:42:50 Nokia-N900 kernel: [    0.361846] 48050000.dss supply 
vdda_video not found, using dummy regulator
Jan  4 20:42:50 Nokia-N900 kernel: [    0.362213] OMAP DSS rev 2.0
Jan  4 20:42:50 Nokia-N900 kernel: [    0.362579] omapdss_dss 
48050000.dss: bound 48050400.dispc (ops dispc_component_ops)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.362884] omapdss_dss 
48050000.dss: bound 48050c00.encoder (ops venc_component_ops)
Jan  4 20:42:50 Nokia-N900 kernel: [    0.364379] omapfb omapfb: no displays
Jan  4 20:42:50 Nokia-N900 kernel: [    0.364562] omapfb omapfb: failed 
to setup omapfb
Jan  4 20:42:50 Nokia-N900 kernel: [    0.366119] 4806c000.serial: ttyO1 
at MMIO 0x4806c000 (irq = 89, base_baud = 3000000) is a OMAP UART1
Jan  4 20:42:50 Nokia-N900 kernel: [    0.367340] 49020000.serial: ttyO2 
at MMIO 0x49020000 (irq = 90, base_baud = 3000000) is a OMAP UART2
Jan  4 20:42:50 Nokia-N900 kernel: [    1.059082] console [ttyO2] enabled
Jan  4 20:42:50 Nokia-N900 kernel: [    1.064483] omap3_rom_rng: 
initializing
Jan  4 20:42:50 Nokia-N900 kernel: [    1.096862] brd: module loaded
Jan  4 20:42:50 Nokia-N900 kernel: [    1.115020] acx565akm spi1.2: 
omapfb: acx565akm rev ad LCD detected
Jan  4 20:42:50 Nokia-N900 kernel: [    1.126892] HS USB OTG: no 
transceiver configured
Jan  4 20:42:50 Nokia-N900 kernel: [    1.131958] musb-hdrc 
musb-hdrc.0.auto: musb_init_controller failed with status -517
Jan  4 20:42:50 Nokia-N900 kernel: [    1.141479] i2c /dev entries driver
Jan  4 20:42:50 Nokia-N900 kernel: [    1.209594] rx51-audio n900-audio: 
could not get speaker enable gpio
Jan  4 20:42:50 Nokia-N900 kernel: [    1.217315] Initializing XFRM 
netlink socket
Jan  4 20:42:50 Nokia-N900 kernel: [    1.221893] NET: Registered 
protocol family 17
Jan  4 20:42:50 Nokia-N900 kernel: [    1.226837] NET: Registered 
protocol family 15
Jan  4 20:42:50 Nokia-N900 kernel: [    1.231597] NET: Registered 
protocol family 35
Jan  4 20:42:50 Nokia-N900 kernel: [    1.236541] Key type dns_resolver 
registered
Jan  4 20:42:50 Nokia-N900 kernel: [    1.241485] 
omap2_set_init_voltage: unable to find boot up OPP for vdd_mpu_iva
Jan  4 20:42:50 Nokia-N900 kernel: [    1.249176] 
omap2_set_init_voltage: unable to set vdd_mpu_iva
Jan  4 20:42:50 Nokia-N900 kernel: [    1.255218] 
omap2_set_init_voltage: unable to find boot up OPP for vdd_core
Jan  4 20:42:50 Nokia-N900 kernel: [    1.262603] 
omap2_set_init_voltage: unable to set vdd_core
Jan  4 20:42:50 Nokia-N900 kernel: [    1.274322] ThumbEE CPU extension 
supported.
Jan  4 20:42:50 Nokia-N900 kernel: [    1.278991] SmartReflex Class3 
initialized
Jan  4 20:42:50 Nokia-N900 kernel: [    1.283721] Bootup reason: pwr_key
Jan  4 20:42:50 Nokia-N900 kernel: [    1.287414] OMAP GPIO switch 
handler initializing
Jan  4 20:42:50 Nokia-N900 kernel: [    1.293090] gpio-switch: 
gpio_reguest failed for cam_focus 68
Jan  4 20:42:50 Nokia-N900 kernel: [    1.299438] gpio-switch: 
gpio_reguest failed for cam_launch 69
Jan  4 20:42:50 Nokia-N900 kernel: [    1.305847] gpio-switch: 
gpio_reguest failed for cam_shutter 110
Jan  4 20:42:50 Nokia-N900 kernel: [    1.313842] gpio-switch: 
gpio_reguest failed for headphone 177
Jan  4 20:42:50 Nokia-N900 kernel: [    1.320281] gpio-switch: 
gpio_reguest failed for kb_lock 113
Jan  4 20:42:50 Nokia-N900 kernel: [    1.326507] gpio-switch: 
gpio_reguest failed for proximity 89
Jan  4 20:42:50 Nokia-N900 kernel: [    1.332794] gpio-switch: 
gpio_reguest failed for sleep_ind 162
Jan  4 20:42:50 Nokia-N900 kernel: [    1.339172] gpio-switch: 
gpio_reguest failed for slide 71
Jan  4 20:42:50 Nokia-N900 kernel: [    1.344970] slide (GPIO 71) is now 
open
Jan  4 20:42:50 Nokia-N900 kernel: [    1.349090] proximity (GPIO 89) is 
now open
Jan  4 20:42:50 Nokia-N900 kernel: [    1.353485] kb_lock (GPIO 113) is 
now closed
Jan  4 20:42:50 Nokia-N900 kernel: [    1.358032] headphone (GPIO 177) 
is now connected
Jan  4 20:42:50 Nokia-N900 kernel: [    1.363037] cam_shutter (GPIO 110) 
is now closed
Jan  4 20:42:50 Nokia-N900 kernel: [    1.367980] cam_launch (GPIO 69) 
is now active
Jan  4 20:42:50 Nokia-N900 kernel: [    1.372680] cam_focus (GPIO 68) is 
now active
Jan  4 20:42:50 Nokia-N900 kernel: [    1.378692] registered taskstats 
version 1
Jan  4 20:42:50 Nokia-N900 kernel: [    1.385314] omap-gpmc 
6e000000.gpmc: GPMC revision 5.0
Jan  4 20:42:50 Nokia-N900 kernel: [    1.391510] GPMC CS0: cs_on 
      :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.399536] GPMC CS0: cs_rd_off 
      :  14 ticks,  84 ns (was  16 ticks)  84 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.407531] GPMC CS0: cs_wr_off 
      :  12 ticks,  72 ns (was  16 ticks)  72 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.415435] GPMC CS0: adv_on 
      :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.423431] GPMC CS0: adv_rd_off 
      :   3 ticks,  18 ns (was   2 ticks)  18 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.431365] GPMC CS0: adv_wr_off 
      :   3 ticks,  18 ns (was   2 ticks)  18 ns
Jan  4 20:42:50 Nokia-N900 DSME: process '/usr/bin/Xorg -logfile 
/tmp/Xorg.0.log -logverbose 1 -nolisten tcp -noreset -s 0 -core' started 
with pid 1095
Jan  4 20:42:50 Nokia-N900 kernel: [    1.439361] GPMC CS0: oe_on 
      :   5 ticks,  30 ns (was   2 ticks)  30 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.447357] GPMC CS0: oe_off 
      :  14 ticks,  84 ns (was  16 ticks)  84 ns
Jan  4 20:42:50 Nokia-N900 cellular: csd[1026]: Succesfully loaded 
plugin <sms>
Jan  4 20:42:50 Nokia-N900 kernel: [    1.455322] GPMC CS0: we_on 
      :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.463226] GPMC CS0: we_off 
      :   7 ticks,  42 ns (was  16 ticks)  42 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.471160] GPMC CS0: rd_cycle 
      :  18 ticks, 108 ns (was  19 ticks) 108 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.479156] GPMC CS0: wr_cycle 
      :  16 ticks,  96 ns (was  19 ticks)  96 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.487152] GPMC CS0: access 
      :  13 ticks,  78 ns (was  15 ticks)  78 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.495117] GPMC CS0: 
page_burst_access:   0 ticks,   0 ns (was   2 ticks)   0 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.503112] GPMC CS0: 
bus_turnaround   :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.511047] GPMC CS0: 
cycle2cycle_delay:   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.518981] GPMC CS0: 
wr_data_mux_bus  :   5 ticks,  30 ns (was   5 ticks)  30 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.526916] GPMC CS0: wr_access 
      :   0 ticks,   0 ns (was  15 ticks)   0 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.534851] GPMC CS0: 
wait_monitoring  :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.542785] GPMC CS0: 
clk_activation   :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.550720] GPMC CS0 CLK period is 
6 ns (div 1)
Jan  4 20:42:50 Nokia-N900 kernel: [    1.555511] gpmc cs0 after 
gpmc_cs_set_timings:
Jan  4 20:42:50 Nokia-N900 kernel: [    1.560333] cs0 GPMC_CS_CONFIG1: 
0xd1001200
Jan  4 20:42:50 Nokia-N900 kernel: [    1.564758] cs0 GPMC_CS_CONFIG2: 
0x000c0e00
Jan  4 20:42:50 Nokia-N900 kernel: [    1.571014] cs0 GPMC_CS_CONFIG3: 
0x00030300
Jan  4 20:42:50 Nokia-N900 kernel: [    1.575500] cs0 GPMC_CS_CONFIG4: 
0x07000e05
Jan  4 20:42:50 Nokia-N900 kernel: [    1.580047] cs0 GPMC_CS_CONFIG5: 
0x000d1012
Jan  4 20:42:50 Nokia-N900 kernel: [    1.584503] cs0 GPMC_CS_CONFIG6: 
0x80050000
Jan  4 20:42:50 Nokia-N900 kernel: [    1.588958] gpmc cs0 access 
configuration:
Jan  4 20:42:50 Nokia-N900 kernel: [    1.593292] gpmc,mux-add-data = <2>
Jan  4 20:42:50 Nokia-N900 kernel: [    1.597015] gpmc,device-width = <1>
Jan  4 20:42:50 Nokia-N900 kernel: [    1.600738] gpmc,wait-pin = <0>
Jan  4 20:42:50 Nokia-N900 kernel: [    1.604064] gpmc,burst-length = <16>
Jan  4 20:42:50 Nokia-N900 kernel: [    1.607910] gpmc,burst-write = <1>
Jan  4 20:42:50 Nokia-N900 kernel: [    1.611511] gpmc,burst-read = <1>
Jan  4 20:42:50 Nokia-N900 kernel: [    1.615020] gpmc,burst-wrap = <1>
Jan  4 20:42:50 Nokia-N900 kernel: [    1.618591] gpmc cs0 timings 
configuration:
Jan  4 20:42:50 Nokia-N900 kernel: [    1.623016] gpmc,cs-on-ns = <0> /* 
0 ns - 0 ns; 0 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    1.628875] gpmc,cs-rd-off-ns = 
<84> /* 79 ns - 84 ns; 14 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    1.635375] gpmc,cs-wr-off-ns = 
<72> /* 67 ns - 72 ns; 12 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    1.641967] gpmc,adv-on-ns = <0> 
/* 0 ns - 0 ns; 0 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    1.647857] gpmc,adv-rd-off-ns = 
<18> /* 13 ns - 18 ns; 3 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    1.654388] gpmc,adv-wr-off-ns = 
<18> /* 13 ns - 18 ns; 3 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    1.660919] gpmc,oe-on-ns = <30> 
/* 25 ns - 30 ns; 5 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    1.667053] gpmc,oe-off-ns = <84> 
/* 79 ns - 84 ns; 14 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    1.673309] gpmc,we-on-ns = <0> /* 
0 ns - 0 ns; 0 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    1.679107] gpmc,we-off-ns = <42> 
/* 37 ns - 42 ns; 7 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    1.685272] gpmc,rd-cycle-ns = 
<108> /* 103 ns - 108 ns; 18 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    1.691986] gpmc,wr-cycle-ns = 
<96> /* 91 ns - 96 ns; 16 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    1.698455] gpmc,access-ns = <78> 
/* 73 ns - 78 ns; 13 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    1.704681] 
gpmc,page-burst-access-ns = <0> /* 0 ns - 0 ns; 0 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    1.711608] gpmc,bus-turnaround-ns 
= <0> /* 0 ns - 0 ns; 0 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    1.718231] 
gpmc,cycle2cycle-delay-ns = <0> /* 0 ns - 0 ns; 0 ticks */
Jan  4 20:42:50 Nokia-N900 cellular: csd[1026]: Succesfully loaded 
plugin <ss>
Jan  4 20:42:50 Nokia-N900 kernel: [    1.725128] 
gpmc,wait-monitoring-ns = <0> /* 0 ns - 0 ns; 0 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    1.731903] gpmc,clk-activation-ns 
= <0> /* 0 ns - 0 ns; 0 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    1.738525] 
gpmc,wr-data-mux-bus-ns = <30> /* 25 ns - 30 ns; 5 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    1.745544] gpmc,wr-access-ns = 
<0> /* 0 ns - 0 ns; 0 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    1.751831] GPMC CS0: cs_on 
      :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.759765] GPMC CS0: cs_rd_off 
      :  16 ticks,  96 ns (was  14 ticks)  96 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.767761] GPMC CS0: cs_wr_off 
      :  16 ticks,  96 ns (was  12 ticks)  96 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.775665] GPMC CS0: adv_on 
      :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.783569] GPMC CS0: adv_rd_off 
      :   2 ticks,  12 ns (was   3 ticks)  12 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.791534] GPMC CS0: adv_wr_off 
      :   2 ticks,  12 ns (was   3 ticks)  12 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.799468] GPMC CS0: oe_on 
      :   3 ticks,  18 ns (was   5 ticks)  18 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.807403] GPMC CS0: oe_off 
      :  16 ticks,  96 ns (was  14 ticks)  96 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.815307] GPMC CS0: we_on 
      :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.823242] GPMC CS0: we_off 
      :  16 ticks,  96 ns (was   7 ticks)  96 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.831176] GPMC CS0: rd_cycle 
      :  19 ticks, 114 ns (was  18 ticks) 114 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.839111] GPMC CS0: wr_cycle 
      :  19 ticks, 114 ns (was  16 ticks) 114 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.847106] GPMC CS0: access 
      :  15 ticks,  90 ns (was  13 ticks)  90 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.854980] GPMC CS0: 
page_burst_access:   2 ticks,  12 ns (was   0 ticks)  12 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.862976] GPMC CS0: 
bus_turnaround   :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.870971] GPMC CS0: 
cycle2cycle_delay:   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.878906] GPMC CS0: 
wr_data_mux_bus  :   5 ticks,  30 ns (was   5 ticks)  30 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.886840] GPMC CS0: wr_access 
      :  15 ticks,  90 ns (was   0 ticks)  90 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.894744] GPMC CS0: 
wait_monitoring  :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.902740] GPMC CS0: 
clk_activation   :   1 ticks,   6 ns (was   0 ticks)   6 ns
Jan  4 20:42:50 Nokia-N900 kernel: [    1.910675] GPMC CS0 CLK period is 
12 ns (div 2)
Jan  4 20:42:50 Nokia-N900 kernel: [    1.915557] gpmc cs0 after 
gpmc_cs_set_timings:
Jan  4 20:42:50 Nokia-N900 kernel: [    1.920410] cs0 GPMC_CS_CONFIG1: 
0xfb001201
Jan  4 20:42:50 Nokia-N900 kernel: [    1.924835] cs0 GPMC_CS_CONFIG2: 
0x00101000
Jan  4 20:42:50 Nokia-N900 kernel: [    1.929321] cs0 GPMC_CS_CONFIG3: 
0x00020200
Jan  4 20:42:50 Nokia-N900 kernel: [    1.933776] cs0 GPMC_CS_CONFIG4: 
0x10001003
Jan  4 20:42:50 Nokia-N900 kernel: [    1.938262] cs0 GPMC_CS_CONFIG5: 
0x020f1313
Jan  4 20:42:50 Nokia-N900 kernel: [    1.942687] cs0 GPMC_CS_CONFIG6: 
0x8f050000
Jan  4 20:42:50 Nokia-N900 kernel: [    1.947143] gpmc cs0 access 
configuration:
Jan  4 20:42:50 Nokia-N900 kernel: [    1.951477] gpmc,mux-add-data = <2>
Jan  4 20:42:50 Nokia-N900 kernel: [    1.955169] gpmc,device-width = <1>
Jan  4 20:42:50 Nokia-N900 kernel: [    1.958892] gpmc,wait-pin = <0>
Jan  4 20:42:50 Nokia-N900 kernel: [    1.962249] gpmc,burst-length = <16>
Jan  4 20:42:50 Nokia-N900 kernel: [    1.966094] gpmc,sync-write = <1>
Jan  4 20:42:50 Nokia-N900 kernel: [    1.969604] gpmc,burst-write = <1>
Jan  4 20:42:50 Nokia-N900 kernel: [    1.973236] gpmc,gpmc,sync-read = <1>
Jan  4 20:42:50 Nokia-N900 kernel: [    1.977142] gpmc,burst-read = <1>
Jan  4 20:42:50 Nokia-N900 kernel: [    1.980651] gpmc,burst-wrap = <1>
Jan  4 20:42:50 Nokia-N900 kernel: [    1.984161] gpmc cs0 timings 
configuration:
Jan  4 20:42:50 Nokia-N900 kernel: [    1.988616] gpmc,cs-on-ns = <0> /* 
0 ns - 0 ns; 0 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    1.994415] gpmc,cs-rd-off-ns = 
<96> /* 91 ns - 96 ns; 16 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    2.000976] gpmc,cs-wr-off-ns = 
<96> /* 91 ns - 96 ns; 16 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    2.007537] gpmc,adv-on-ns = <0> 
/* 0 ns - 0 ns; 0 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    2.013397] gpmc,adv-rd-off-ns = 
<12> /* 7 ns - 12 ns; 2 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    2.019836] gpmc,adv-wr-off-ns = 
<12> /* 7 ns - 12 ns; 2 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    2.026306] gpmc,oe-on-ns = <18> 
/* 13 ns - 18 ns; 3 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    2.032348] gpmc,oe-off-ns = <96> 
/* 91 ns - 96 ns; 16 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    2.038635] gpmc,we-on-ns = <0> /* 
0 ns - 0 ns; 0 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    2.044464] gpmc,we-off-ns = <96> 
/* 91 ns - 96 ns; 16 ticks */
Jan  4 20:42:50 Nokia-N900 kernel: [    2.050781] gpmc,rd-cycle-ns = 
<114> /* 109 ns - 114 ns; 19 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.057525] gpmc,wr-cycle-ns = 
<114> /* 109 ns - 114 ns; 19 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.064208] gpmc,access-ns = <90> 
/* 85 ns - 90 ns; 15 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.070526] 
gpmc,page-burst-access-ns = <12> /* 7 ns - 12 ns; 2 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.077636] gpmc,bus-turnaround-ns 
= <0> /* 0 ns - 0 ns; 0 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.084289] 
gpmc,cycle2cycle-delay-ns = <0> /* 0 ns - 0 ns; 0 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.091186] 
gpmc,wait-monitoring-ns = <0> /* 0 ns - 0 ns; 0 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.097930] gpmc,clk-activation-ns 
= <6> /* 1 ns - 6 ns; 1 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.104583] 
gpmc,wr-data-mux-bus-ns = <30> /* 25 ns - 30 ns; 5 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.111633] gpmc,wr-access-ns = 
<90> /* 85 ns - 90 ns; 15 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.118194] omap2-onenand 
omap2-onenand: initializing on CS0, phys base 0x01000000, virtual base 
d0940000, freq 83 MHz
Jan  4 20:42:51 Nokia-N900 kernel: [    2.129486] OneNAND Manufacturer: 
Numonyx (0x20)
Jan  4 20:42:51 Nokia-N900 kernel: [    2.129516] Muxed OneNAND 256MB 
1.8V 16-bit (0x40)
Jan  4 20:42:51 Nokia-N900 kernel: [    2.134582] OneNAND version = 0x0031
Jan  4 20:42:51 Nokia-N900 kernel: [    2.138366] Chip support all block 
unlock
Jan  4 20:42:51 Nokia-N900 kernel: [    2.138366] Chip has 2 plane
Jan  4 20:42:51 Nokia-N900 kernel: [    2.139953] Scanning device for 
bad blocks
Jan  4 20:42:51 Nokia-N900 kernel: [    2.238616] 6 ofpart partitions 
found on MTD device (null)
Jan  4 20:42:51 Nokia-N900 kernel: [    2.244415] Creating 6 MTD 
partitions on "(null)":
Jan  4 20:42:51 Nokia-N900 kernel: [    2.249633] 
0x000000000000-0x000000020000 : "bootloader"
Jan  4 20:42:51 Nokia-N900 kernel: [    2.256164] 
0x000000020000-0x000000080000 : "config"
Jan  4 20:42:51 Nokia-N900 kernel: [    2.262084] 
0x000000080000-0x0000000c0000 : "log"
Jan  4 20:42:51 Nokia-N900 kernel: [    2.270233] mtdoops: ready 33, 
959521135 (no erase)
Jan  4 20:42:51 Nokia-N900 gconfd (root-1094): starting (version 
2.16.0), pid 1094 user 'root'
Jan  4 20:42:51 Nokia-N900 kernel: [    2.270233] mtdoops: Attached to 
MTD device 2
Jan  4 20:42:51 Nokia-N900 kernel: [    2.274871] 
0x0000000c0000-0x0000002c0000 : "kernel"
Jan  4 20:42:51 Nokia-N900 kernel: [    2.280914] 
0x0000002c0000-0x0000004c0000 : "initfs"
Jan  4 20:42:51 Nokia-N900 kernel: [    2.286895] 
0x0000004c0000-0x000010000000 : "rootfs"
Jan  4 20:42:51 Nokia-N900 kernel: [    2.294494] gpmc cs1 before 
gpmc_cs_program_settings:
Jan  4 20:42:51 Nokia-N900 kernel: [    2.299865] cs1 GPMC_CS_CONFIG1: 
0x00001000
Jan  4 20:42:51 Nokia-N900 kernel: [    2.304290] cs1 GPMC_CS_CONFIG2: 
0x00101001
Jan  4 20:42:51 Nokia-N900 kernel: [    2.308776] cs1 GPMC_CS_CONFIG3: 
0x00020201
Jan  4 20:42:51 Nokia-N900 kernel: [    2.313232] cs1 GPMC_CS_CONFIG4: 
0x10031003
Jan  4 20:42:51 Nokia-N900 kernel: [    2.317718] cs1 GPMC_CS_CONFIG5: 
0x010f1111
Jan  4 20:42:51 Nokia-N900 kernel: [    2.322143] cs1 GPMC_CS_CONFIG6: 
0x8f030000
Jan  4 20:42:51 Nokia-N900 kernel: [    2.326599] gpmc cs1 access 
configuration:
Jan  4 20:42:51 Nokia-N900 kernel: [    2.330902] gpmc,mux-add-data = <0>
Jan  4 20:42:51 Nokia-N900 kernel: [    2.334625] gpmc,device-width = <1>
Jan  4 20:42:51 Nokia-N900 kernel: [    2.338348] gpmc,wait-pin = <0>
Jan  4 20:42:51 Nokia-N900 kernel: [    2.341674] gpmc,burst-length = <4>
Jan  4 20:42:51 Nokia-N900 kernel: [    2.345367] gpmc cs1 timings 
configuration:
Jan  4 20:42:51 Nokia-N900 kernel: [    2.349822] gpmc,cs-on-ns = <6> /* 
1 ns - 6 ns; 1 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.355651] gpmc,cs-rd-off-ns = 
<96> /* 91 ns - 96 ns; 16 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.362243] gpmc,cs-wr-off-ns = 
<96> /* 91 ns - 96 ns; 16 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.368804] gpmc,adv-on-ns = <6> 
/* 1 ns - 6 ns; 1 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.374664] gpmc,adv-rd-off-ns = 
<12> /* 7 ns - 12 ns; 2 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.381195] gpmc,adv-wr-off-ns = 
<12> /* 7 ns - 12 ns; 2 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.387695] gpmc,oe-on-ns = <18> 
/* 13 ns - 18 ns; 3 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.393798] gpmc,oe-off-ns = <96> 
/* 91 ns - 96 ns; 16 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.400054] gpmc,we-on-ns = <18> 
/* 13 ns - 18 ns; 3 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.406188] gpmc,we-off-ns = <96> 
/* 91 ns - 96 ns; 16 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.412414] gpmc,rd-cycle-ns = 
<102> /* 97 ns - 102 ns; 17 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.419067] gpmc,wr-cycle-ns = 
<102> /* 97 ns - 102 ns; 17 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.425720] gpmc,access-ns = <90> 
/* 85 ns - 90 ns; 15 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.432006] 
gpmc,page-burst-access-ns = <6> /* 1 ns - 6 ns; 1 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.438964] gpmc,bus-turnaround-ns 
= <0> /* 0 ns - 0 ns; 0 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.445556] 
gpmc,cycle2cycle-delay-ns = <0> /* 0 ns - 0 ns; 0 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.452484] 
gpmc,wait-monitoring-ns = <0> /* 0 ns - 0 ns; 0 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.459197] gpmc,clk-activation-ns 
= <0> /* 0 ns - 0 ns; 0 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.465850] 
gpmc,wr-data-mux-bus-ns = <18> /* 13 ns - 18 ns; 3 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.472869] gpmc,wr-access-ns = 
<90> /* 85 ns - 90 ns; 15 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.479461] GPMC CS1: cs_on 
      :   0 ticks,   0 ns (was   1 ticks)   0 ns
Jan  4 20:42:51 Nokia-N900 kernel: [    2.487396] GPMC CS1: cs_rd_off 
      :   8 ticks,  48 ns (was  16 ticks)  48 ns
Jan  4 20:42:51 Nokia-N900 kernel: [    2.495361] GPMC CS1: cs_wr_off 
      :   4 ticks,  24 ns (was  16 ticks)  24 ns
Jan  4 20:42:51 Nokia-N900 kernel: [    2.503295] GPMC CS1: adv_on 
      :   0 ticks,   0 ns (was   1 ticks)   0 ns
Jan  4 20:42:51 Nokia-N900 kernel: [    2.511230] GPMC CS1: adv_rd_off 
      :   0 ticks,   0 ns (was   2 ticks)   0 ns
Jan  4 20:42:51 Nokia-N900 waitx[1097]: trying to get X display
Jan  4 20:42:51 Nokia-N900 kernel: [    2.519165] GPMC CS1: adv_wr_off 
      :   0 ticks,   0 ns (was   2 ticks)   0 ns
Jan  4 20:42:51 Nokia-N900 kernel: [    2.527099] GPMC CS1: oe_on 
      :   2 ticks,  12 ns (was   3 ticks)  12 ns
Jan  4 20:42:51 Nokia-N900 kernel: [    2.535003] GPMC CS1: oe_off 
      :   8 ticks,  48 ns (was  16 ticks)  48 ns
Jan  4 20:42:51 Nokia-N900 kernel: [    2.542999] GPMC CS1: we_on 
      :   2 ticks,  12 ns (was   3 ticks)  12 ns
Jan  4 20:42:51 Nokia-N900 kernel: [    2.550933] GPMC CS1: we_off 
      :   3 ticks,  18 ns (was  16 ticks)  18 ns
Jan  4 20:42:51 Nokia-N900 kernel: [    2.558929] GPMC CS1: rd_cycle 
      :  30 ticks, 180 ns (was  17 ticks) 180 ns
Jan  4 20:42:51 Nokia-N900 kernel: [    2.566864] GPMC CS1: wr_cycle 
      :  30 ticks, 180 ns (was  17 ticks) 180 ns
Jan  4 20:42:51 Nokia-N900 kernel: [    2.574768] GPMC CS1: access 
      :   7 ticks,  42 ns (was  15 ticks)  42 ns
Jan  4 20:42:51 Nokia-N900 kernel: [    2.582733] GPMC CS1: 
page_burst_access:   0 ticks,   0 ns (was   1 ticks)   0 ns
Jan  4 20:42:51 Nokia-N900 kernel: [    2.590728] GPMC CS1: 
bus_turnaround   :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  4 20:42:51 Nokia-N900 kernel: [    2.598663] GPMC CS1: 
cycle2cycle_delay:   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  4 20:42:51 Nokia-N900 kernel: [    2.606658] GPMC CS1: 
wr_data_mux_bus  :   2 ticks,  12 ns (was   3 ticks)  12 ns
Jan  4 20:42:51 Nokia-N900 kernel: [    2.614624] GPMC CS1: wr_access 
      :   0 ticks,   0 ns (was  15 ticks)   0 ns
Jan  4 20:42:51 Nokia-N900 kernel: [    2.622528] GPMC CS1: 
wait_monitoring  :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  4 20:42:51 Nokia-N900 kernel: [    2.630523] GPMC CS1: 
clk_activation   :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  4 20:42:51 Nokia-N900 kernel: [    2.638458] GPMC CS1 CLK period is 
6 ns (div 1)
Jan  4 20:42:51 Nokia-N900 kernel: [    2.643249] gpmc cs1 after 
gpmc_cs_set_timings:
Jan  4 20:42:51 Nokia-N900 kernel: [    2.648040] cs1 GPMC_CS_CONFIG1: 
0x00001000
Jan  4 20:42:51 Nokia-N900 kernel: [    2.652465] cs1 GPMC_CS_CONFIG2: 
0x00040800
Jan  4 20:42:51 Nokia-N900 kernel: [    2.656951] cs1 GPMC_CS_CONFIG3: 
0x00000000
Jan  4 20:42:51 Nokia-N900 kernel: [    2.661376] cs1 GPMC_CS_CONFIG4: 
0x03020802
Jan  4 20:42:51 Nokia-N900 kernel: [    2.665863] cs1 GPMC_CS_CONFIG5: 
0x00071e1e
Jan  4 20:42:51 Nokia-N900 kernel: [    2.670318] cs1 GPMC_CS_CONFIG6: 
0x80020000
Jan  4 20:42:51 Nokia-N900 kernel: [    2.674713] gpmc cs1 access 
configuration:
Jan  4 20:42:51 Nokia-N900 kernel: [    2.679107] gpmc,mux-add-data = <0>
Jan  4 20:42:51 Nokia-N900 kernel: [    2.682769] gpmc,device-width = <1>
Jan  4 20:42:51 Nokia-N900 kernel: [    2.686523] gpmc,wait-pin = <0>
Jan  4 20:42:51 Nokia-N900 kernel: [    2.689880] gpmc,burst-length = <4>
Jan  4 20:42:51 Nokia-N900 kernel: [    2.693572] gpmc cs1 timings 
configuration:
Jan  4 20:42:51 Nokia-N900 kernel: [    2.698059] gpmc,cs-on-ns = <0> /* 
0 ns - 0 ns; 0 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.703857] gpmc,cs-rd-off-ns = 
<48> /* 43 ns - 48 ns; 8 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.710296] gpmc,cs-wr-off-ns = 
<24> /* 19 ns - 24 ns; 4 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.716735] gpmc,adv-on-ns = <0> 
/* 0 ns - 0 ns; 0 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.722656] gpmc,adv-rd-off-ns = 
<0> /* 0 ns - 0 ns; 0 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.728942] gpmc,adv-wr-off-ns = 
<0> /* 0 ns - 0 ns; 0 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.735168] gpmc,oe-on-ns = <12> 
/* 7 ns - 12 ns; 2 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.741180] gpmc,oe-off-ns = <48> 
/* 43 ns - 48 ns; 8 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.747344] gpmc,we-on-ns = <12> 
/* 7 ns - 12 ns; 2 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.753356] gpmc,we-off-ns = <18> 
/* 13 ns - 18 ns; 3 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.759552] gpmc,rd-cycle-ns = 
<180> /* 175 ns - 180 ns; 30 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.766296] gpmc,wr-cycle-ns = 
<180> /* 175 ns - 180 ns; 30 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.772979] gpmc,access-ns = <42> 
/* 37 ns - 42 ns; 7 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.779144] 
gpmc,page-burst-access-ns = <0> /* 0 ns - 0 ns; 0 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.786102] gpmc,bus-turnaround-ns 
= <0> /* 0 ns - 0 ns; 0 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.792785] 
gpmc,cycle2cycle-delay-ns = <0> /* 0 ns - 0 ns; 0 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.799743] 
gpmc,wait-monitoring-ns = <0> /* 0 ns - 0 ns; 0 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.806518] gpmc,clk-activation-ns 
= <0> /* 0 ns - 0 ns; 0 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.813110] 
gpmc,wr-data-mux-bus-ns = <12> /* 7 ns - 12 ns; 2 ticks */
Jan  4 20:42:51 Nokia-N900 kernel: [    2.820037] gpmc,wr-access-ns = 
<0> /* 0 ns - 0 ns; 0 ticks */
