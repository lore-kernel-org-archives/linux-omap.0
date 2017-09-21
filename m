From: Tony Lindgren <tony@atomide.com>
Subject: Re: n900 in next-20170901
Date: Thu, 21 Sep 2017 10:28:11 -0700
Message-ID: <20170921172811.GB4394@atomide.com>
References: <20170903203737.GA12475@amd>
 <20170905201314.GE5024@atomide.com>
 <20170905233241.GA19231@js1304-P5Q-DELUXE>
 <20170906133057.GH5024@atomide.com>
 <20170907073038.GA2111@js1304-P5Q-DELUXE>
 <20170907161650.GP5024@atomide.com>
 <20170913075516.GA25036@js1304-P5Q-DELUXE>
 <20170913163126.GS5024@atomide.com>
 <20170915065608.GA8567@js1304-P5Q-DELUXE>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170915065608.GA8567@js1304-P5Q-DELUXE>
Sender: linux-kernel-owner@vger.kernel.org
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

* Joonsoo Kim <iamjoonsoo.kim@lge.com> [170914 23:55]:
> On Wed, Sep 13, 2017 at 09:31:27AM -0700, Tony Lindgren wrote:
> > Yes I disabled CONFIG_HIGHMEM and n900 boots. To disable it,
> > you need to remove it from arch/arm/mach-omap2/Kconfig that
> > selects it if ARCH_OMAP2PLUS_TYPICAL is selected.
> 
> Okay. Problem would be related to address traslation. I'd like to
> check address traslation more. Could you apply following patch and
> test it? And, please send me the dmesg log and your kernel config.
> Please test this with CONFIG_DEBUG_VIRTUAL = n and CONFIG_CMA_DEBUG=y and
> CONFIG_HIGHMEM=y and with kernel bootparam 'ignore_loglevel'.
> 
> It would be really appreciate if you send me two logs for before/after
> commit 9caf25f996e8.

Sorry for the delays, I finally got around testing this for you.
Compile with your patch failed for modules with __virt_to_phys_debug
being undefined so I added EXPORT_SYMBOL there. I also enabled DEBUG_LL
and EARLYPRINTK to get output.

Below is dmesg output for 9caf25f996e8 + your patch. I'll send you
the full logs separately.

Regards,

Tony

8< -----------------------
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.13.0-rc7-00246-g9caf25f996e8-dirty (tmlind@sampyla) (gcc version 6.2.0 (crosstool-NG crosstool-ng-1.22.0-248-gdf5a341)) #416 SMP Thu Sep 21 10:04:29 PDT 2017
[    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
[    0.000000] OF: fdt: Machine model: Nokia N900
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: Data cache writeback
[    0.000000] cma: dma_contiguous_reserve(limit ffffffff)
[    0.000000] cma: dma_contiguous_reserve: reserving 16 MiB for global area
[    0.000000] cma: cma_declare_contiguous(size 0x01000000, base 0x00000000, limit 0xffffffff alignment 0x00000000)
[    0.000000] cma: Reserved 16 MiB at 0x8e800000
[    0.000000] CMA_ADDR: __phys_to_virt_debug: 0x8e800000 to 0xce800000
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.13.0-rc7-00246-g9caf25f996e8-dirty #416
[    0.000000] Hardware name: Nokia RX-51 board
[    0.000000] [<c0110570>] (unwind_backtrace) from [<c010c510>] (show_stack+0x10/0x14)
[    0.000000] [<c010c510>] (show_stack) from [<c081efe8>] (dump_stack+0xac/0xe0)
[    0.000000] [<c081efe8>] (dump_stack) from [<c0c06f14>] (dma_contiguous_remap+0x68/0x138)
[    0.000000] [<c0c06f14>] (dma_contiguous_remap) from [<c0c08158>] (paging_init+0x324/0x708)
[    0.000000] [<c0c08158>] (paging_init) from [<c0c042a4>] (setup_arch+0x5b4/0xca8)
[    0.000000] [<c0c042a4>] (setup_arch) from [<c0c0093c>] (start_kernel+0x58/0x3ec)
[    0.000000] [<c0c0093c>] (start_kernel) from [<8000807c>] (0x8000807c)
[    0.000000] CMA_ADDR: __phys_to_virt_debug: 0x8e800000 to 0xce800000
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.13.0-rc7-00246-g9caf25f996e8-dirty #416
[    0.000000] Hardware name: Nokia RX-51 board
[    0.000000] [<c0110570>] (unwind_backtrace) from [<c010c510>] (show_stack+0x10/0x14)
[    0.000000] [<c010c510>] (show_stack) from [<c081efe8>] (dump_stack+0xac/0xe0)
[    0.000000] [<c081efe8>] (dump_stack) from [<c0c06f3c>] (dma_contiguous_remap+0x90/0x138)
[    0.000000] [<c0c06f3c>] (dma_contiguous_remap) from [<c0c08158>] (paging_init+0x324/0x708)
[    0.000000] [<c0c08158>] (paging_init) from [<c0c042a4>] (setup_arch+0x5b4/0xca8)
[    0.000000] [<c0c042a4>] (setup_arch) from [<c0c0093c>] (start_kernel+0x58/0x3ec)
[    0.000000] [<c0c0093c>] (start_kernel) from [<8000807c>] (0x8000807c)
[    0.000000] CMA_ADDR: __phys_to_virt_debug: 0x8e800000 to 0xce800000
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.13.0-rc7-00246-g9caf25f996e8-dirty #416
[    0.000000] Hardware name: Nokia RX-51 board
[    0.000000] [<c0110570>] (unwind_backtrace) from [<c010c510>] (show_stack+0x10/0x14)
[    0.000000] [<c010c510>] (show_stack) from [<c081efe8>] (dump_stack+0xac/0xe0)
[    0.000000] [<c081efe8>] (dump_stack) from [<c0c06f9c>] (dma_contiguous_remap+0xf0/0x138)
[    0.000000] [<c0c06f9c>] (dma_contiguous_remap) from [<c0c08158>] (paging_init+0x324/0x708)
[    0.000000] [<c0c08158>] (paging_init) from [<c0c042a4>] (setup_arch+0x5b4/0xca8)
[    0.000000] [<c0c042a4>] (setup_arch) from [<c0c0093c>] (start_kernel+0x58/0x3ec)
[    0.000000] [<c0c0093c>] (start_kernel) from [<8000807c>] (0x8000807c)
[    0.000000] On node 0 totalpages: 65024
[    0.000000] free_area_init_node: node 0, pgdat c0dc22c0, node_mem_map cfa8b000
[    0.000000]   Normal zone: 572 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 65024 pages, LIFO batch:15
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp)
[    0.000000] percpu: Embedded 18 pages/cpu @cfd94000 s41000 r8192 d24536 u73728
[    0.000000] pcpu-alloc: s41000 r8192 d24536 u73728 alloc=18*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 64452
[    0.000000] Kernel command line: root=/dev/nfs ip=dhcp console=ttyO2,115200 memmap=2M$0x88000000 ramoops.mem_address=0x88000000 ramoops.mem_size=0x200000 ramoops.record_size=0x40000 debug earlyprintk init=/root/init
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 219536K/260096K available (8192K kernel code, 805K rwdata, 2388K rodata, 1024K init, 8058K bss, 24176K reserved, 16384K cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xd0000000 - 0xff800000   ( 760 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xcfe00000   ( 254 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0900000   (9184 kB)
[    0.000000]       .init : 0xc0c00000 - 0xc0d00000   (1024 kB)
[    0.000000]       .data : 0xc0d00000 - 0xc0dc9430   ( 806 kB)
[    0.000000]        .bss : 0xc0dcb000 - 0xc15a9a4c   (8059 kB)
[    0.000000] Running RCU self tests
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU event tracing is enabled.
[    0.000000] 	RCU lockdep checking is enabled.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=2 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
[    0.000000] Clocking rate (Crystal/Core/MPU): 19.2/332/500 MHz
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000000] clocksource: 32k_counter: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 58327039986419 ns
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 65535999984741ns
[    0.008697] OMAP clocksource: 32k_counter at 32768 Hz
[    0.017150] Console: colour dummy device 80x30
[    0.021972] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.030120] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.034454] ... MAX_LOCK_DEPTH:          48
[    0.038848] ... MAX_LOCKDEP_KEYS:        8191
[    0.043518] ... CLASSHASH_SIZE:          4096
[    0.048095] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.052825] ... MAX_LOCKDEP_CHAINS:      65536
[    0.057525] ... CHAINHASH_SIZE:          32768
[    0.062255]  memory used by lock dependency info: 5167 kB
[    0.067932]  per task-struct memory footprint: 1536 bytes
[    0.073669] Calibrating delay loop... 493.97 BogoMIPS (lpj=2469888)
[    0.135528] pid_max: default: 32768 minimum: 301
[    0.141265] Security Framework initialized
[    0.145843] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.152893] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.166473] CPU: Testing write buffer coherency: ok
[    0.174652] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.183135] Setting up static identity map for 0x80100000 - 0x80100078
[    0.191253] Hierarchical SRCU implementation.
[    0.199310] smp: Bringing up secondary CPUs ...
[    0.204101] smp: Brought up 1 node, 1 CPU
[    0.208343] SMP: Total of 1 processors activated (493.97 BogoMIPS).
[    0.214996] CPU: All CPU(s) started in SVC mode.
[    0.227752] devtmpfs: initialized
[    0.344909] Built 1 zonelists, mobility grouping on.  Total pages: 58980
[    0.353942] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
[    0.363677] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.374145] futex hash table entries: 256 (order: 2, 16384 bytes)
[    0.381561] pinctrl core: initialized pinctrl subsystem
[    0.394714] random: get_random_u32 called from bucket_table_alloc+0xdc/0x264 with crng_init=0
[    0.405181] NET: Registered protocol family 16
[    0.410919] __alloc_from_contiguous
[    0.414642] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.13.0-rc7-00246-g9caf25f996e8-dirty #416
[    0.423706] Hardware name: Nokia RX-51 board
[    0.428222] [<c0110570>] (unwind_backtrace) from [<c010c510>] (show_stack+0x10/0x14)
[    0.436309] [<c010c510>] (show_stack) from [<c081efe8>] (dump_stack+0xac/0xe0)
[    0.443878] [<c081efe8>] (dump_stack) from [<c01161c4>] (__alloc_from_contiguous+0x30/0xf8)
[    0.452606] [<c01161c4>] (__alloc_from_contiguous) from [<c0c06d60>] (atomic_pool_init+0x7c/0x178)
[    0.461944] [<c0c06d60>] (atomic_pool_init) from [<c0101918>] (do_one_initcall+0x3c/0x170)
[    0.470550] [<c0101918>] (do_one_initcall) from [<c0c00ecc>] (kernel_init_freeable+0x1fc/0x2c4)
[    0.479644] [<c0c00ecc>] (kernel_init_freeable) from [<c08328e4>] (kernel_init+0x8/0x110)
[    0.488159] [<c08328e4>] (kernel_init) from [<c0107850>] (ret_from_fork+0x14/0x24)
[    0.496185] cma: cma_alloc(cma c15774bc, count 64, align 6)
[    0.511199] cma: cma_alloc(): returned cfc95000
[    0.517578] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.651306] omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
[    0.662017] omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
[    0.802093] cpuidle: using governor menu
[    0.807403] SRAM_ADDR: omap_map_sram: P: 0x40208000 - 0x4020f000
[    0.813873] SRAM_ADDR: omap_map_sram: V: 0xd0050000 - 0xd0057000
[    0.820312] SRAM_ADDR: omap_sram_push_address: 0xd0056f00 - 0xd0056ffc
[    0.827148] SRAM_ADDR: omap_sram_push_address: 0xd0056e90 - 0xd0056efc
[    0.834106] Reprogramming SDRC clock to 332000000 Hz
[    0.857757] gpio gpiochip0: (gpio): added GPIO chardev (254:0)
[    0.864685] gpiochip_setup_dev: registered GPIOs 0 to 31 on device: gpiochip0 (gpio)
[    0.879302] OMAP GPIO hardware version 2.5
[    0.888824] gpio gpiochip1: (gpio): added GPIO chardev (254:1)
[    0.895416] gpiochip_setup_dev: registered GPIOs 32 to 63 on device: gpiochip1 (gpio)
[    0.913238] gpio gpiochip2: (gpio): added GPIO chardev (254:2)
[    0.919952] gpiochip_setup_dev: registered GPIOs 64 to 95 on device: gpiochip2 (gpio)
[    0.937927] gpio gpiochip3: (gpio): added GPIO chardev (254:3)
[    0.944519] gpiochip_setup_dev: registered GPIOs 96 to 127 on device: gpiochip3 (gpio)
[    0.962524] gpio gpiochip4: (gpio): added GPIO chardev (254:4)
[    0.969207] gpiochip_setup_dev: registered GPIOs 128 to 159 on device: gpiochip4 (gpio)
[    0.986816] gpio gpiochip5: (gpio): added GPIO chardev (254:5)
[    0.993530] gpiochip_setup_dev: registered GPIOs 160 to 191 on device: gpiochip5 (gpio)
[    1.045806] omap-gpmc 6e000000.gpmc: could not find pctldev for node /ocp@68000000/l4@48000000/scm@2000/pinmux@30/pinmux_gpmc_pins, deferring probe
[    1.075134] hw-breakpoint: debug architecture 0x4 unsupported.
[    1.083435] omap4_sram_init:Unable to allocate sram needed to handle errata I688
[    1.091369] omap4_sram_init:Unable to get sram pool needed to handle errata I688
[    1.101593] Reserving DMA channels 0 and 1 for HS ROM code
[    1.107543] OMAP DMA hardware revision 4.0
[    1.201812] omap-dma-engine 48056000.dma-controller: OMAP DMA engine driver
[    1.221221] omap-iommu 480bd400.mmu: 480bd400.mmu registered
[    1.228912] iommu: Adding device 480bc000.isp to group 0
[    1.236175] SCSI subsystem initialized
[    1.241912] libata version 3.00 loaded.
[    1.247253] omap_i2c 48070000.i2c: could not find pctldev for node /ocp@68000000/l4@48000000/scm@2000/pinmux@30/pinmux_i2c1_pins, deferring probe
[    1.261108] omap_i2c 48072000.i2c: could not find pctldev for node /ocp@68000000/l4@48000000/scm@2000/pinmux@30/pinmux_i2c2_pins, deferring probe
[    1.274871] omap_i2c 48060000.i2c: could not find pctldev for node /ocp@68000000/l4@48000000/scm@2000/pinmux@30/pinmux_i2c3_pins, deferring probe
[    1.289215] pps_core: LinuxPPS API ver. 1 registered
[    1.294433] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.304138] PTP clock support registered
[    1.315582] clocksource: Switched to clocksource 32k_counter
[    1.595153] VFS: Disk quotas dquot_6.6.0
[    1.599853] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.660949] NET: Registered protocol family 2
[    1.669342] TCP established hash table entries: 2048 (order: 1, 8192 bytes)
[    1.676910] TCP bind hash table entries: 2048 (order: 4, 73728 bytes)
[    1.684814] TCP: Hash tables configured (established 2048 bind 2048)
[    1.692321] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    1.699005] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    1.707244] NET: Registered protocol family 1
[    1.715698] RPC: Registered named UNIX socket transport module.
[    1.721954] RPC: Registered udp transport module.
[    1.727050] RPC: Registered tcp transport module.
[    1.732025] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.748840] hw perfevents: no interrupt-affinity property for /pmu@54000000, guessing.
[    1.759094] hw perfevents: enabled with armv7_cortex_a8 PMU driver, 5 counters available
[    1.777587] audit: initializing netlink subsys (disabled)
[    1.788665] audit: type=2000 audit(1.689:1): state=initialized audit_enabled=0 res=1
[    1.798400] workingset: timestamp_bits=14 max_order=16 bucket_order=2
[    1.810302] NFS: Registering the id_resolver key type
[    1.816619] Key type id_resolver registered
[    1.821075] Key type id_legacy registered
[    1.825775] jffs2: version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
[    1.838653] random: fast init done
[    1.851684] io scheduler noop registered
[    1.856201] io scheduler deadline registered
[    1.860870] io scheduler cfq registered (default)
[    1.865997] io scheduler mq-deadline registered
[    1.870758] io scheduler kyber registered
[    1.880615] pinctrl-single 48002030.pinmux: 284 pins at pa fa002030 size 568
[    1.889617] pinctrl-single 48002a00.pinmux: 46 pins at pa fa002a00 size 92
[    1.898406] pinctrl-single 480025d8.pinmux: 18 pins at pa fa0025d8 size 36
[    1.916870] Serial: 8250/16550 driver, 6 ports, IRQ sharing enabled
[    1.936401] omap_uart 4806c000.serial: no wakeirq for uart1
[    1.942291] of_get_named_gpiod_flags: can't parse 'rts-gpio' property of node '/ocp@68000000/serial@4806c000[0]'
[    1.953826] 4806c000.serial: ttyO1 at MMIO 0x4806c000 (irq = 89, base_baud = 3000000) is a OMAP UART1
[    1.967803] of_get_named_gpiod_flags: can't parse 'rts-gpio' property of node '/ocp@68000000/serial@49020000[0]'
[    1.978912] 49020000.serial: ttyO2 at MMIO 0x49020000 (irq = 90, base_baud = 3000000) is a OMAP UART2
[    1.989379] console [ttyO2] enabled
[    1.989379] console [ttyO2] enabled
[    1.997009] bootconsole [earlycon0] disabled
[    1.997009] bootconsole [earlycon0] disabled
[    2.064758] brd: module loaded
[    2.114959] loop: module loaded
[    2.123657] mtdoops: mtd device (mtddev=name/number) must be supplied
[    2.151977] mdio_bus fixed-0: GPIO lookup for consumer reset
[    2.158264] mdio_bus fixed-0: using lookup tables for GPIO lookup
[    2.164916] mdio_bus fixed-0: lookup for GPIO reset failed
[    2.171386] libphy: Fixed MDIO Bus: probed
[    2.183044] i2c /dev entries driver
[    2.191650] omap_hsmmc 4809c000.mmc: GPIO lookup for consumer cd
[    2.198303] omap_hsmmc 4809c000.mmc: using device tree for GPIO lookup
[    2.205322] of_get_named_gpiod_flags: parsed 'cd-gpios' property of node '/ocp@68000000/mmc@4809c000[0]' - status (0)
[    2.216827] omap_hsmmc 4809c000.mmc: Got CD GPIO
[    2.221771] omap_hsmmc 4809c000.mmc: GPIO lookup for consumer wp
[    2.228271] omap_hsmmc 4809c000.mmc: using device tree for GPIO lookup
[    2.235198] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of node '/ocp@68000000/mmc@4809c000[0]'
[    2.245788] of_get_named_gpiod_flags: can't parse 'wp-gpio' property of node '/ocp@68000000/mmc@4809c000[0]'
[    2.256317] omap_hsmmc 4809c000.mmc: using lookup tables for GPIO lookup
[    2.263397] omap_hsmmc 4809c000.mmc: lookup for GPIO wp failed
[    2.277252] omap_hsmmc 480b4000.mmc: GPIO lookup for consumer wp
[    2.283660] omap_hsmmc 480b4000.mmc: using device tree for GPIO lookup
[    2.290771] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of node '/ocp@68000000/mmc@480b4000[0]'
[    2.301422] of_get_named_gpiod_flags: can't parse 'wp-gpio' property of node '/ocp@68000000/mmc@480b4000[0]'
[    2.311920] omap_hsmmc 480b4000.mmc: using lookup tables for GPIO lookup
[    2.319152] omap_hsmmc 480b4000.mmc: lookup for GPIO wp failed
[    2.328521] ledtrig-cpu: registered to indicate activity on CPUs
[    2.336822] oprofile: using arm/armv7
[    2.342010] Initializing XFRM netlink socket
[    2.347503] NET: Registered protocol family 10
[    2.357482] Segment Routing with IPv6
[    2.361602] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    2.371490] NET: Registered protocol family 17
[    2.376525] NET: Registered protocol family 15
[    2.381835] Key type dns_resolver registered
[    2.387268] omap2_set_init_voltage: unable to find boot up OPP for vdd_mpu_iva
[    2.394927] omap2_set_init_voltage: unable to set vdd_mpu_iva
[    2.401214] omap2_set_init_voltage: unable to find boot up OPP for vdd_core
[    2.408721] omap2_set_init_voltage: unable to set vdd_core
[    2.419464] save_secure_sram() returns 0000ff02
[    2.424285] save_secure_sram()'s param: 0: 0x4
[    2.428985] save_secure_sram()'s param: 1: 0x8e700000
[    2.434356] save_secure_sram()'s param: 2: 0x0
[    2.439056] save_secure_sram()'s param: 3: 0x1
[    2.443756] save_secure_sram()'s param: 4: 0x1
