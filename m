From: Tony Lindgren <tony@atomide.com>
Subject: Re: n900 in next-20170901
Date: Thu, 19 Oct 2017 11:30:34 -0700
Message-ID: <20171019183033.GH4394@atomide.com>
References: <20170906133057.GH5024@atomide.com>
 <20170907073038.GA2111@js1304-P5Q-DELUXE>
 <20170907161650.GP5024@atomide.com>
 <20170913075516.GA25036@js1304-P5Q-DELUXE>
 <20170913163126.GS5024@atomide.com>
 <20170915065608.GA8567@js1304-P5Q-DELUXE>
 <20170921172811.GB4394@atomide.com>
 <20170925080806.GA9837@js1304-P5Q-DELUXE>
 <20170925145437.GG4394@atomide.com>
 <20171018082927.GB27595@js1304-P5Q-DELUXE>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171018082927.GB27595@js1304-P5Q-DELUXE>
Sender: linux-kernel-owner@vger.kernel.org
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

* Joonsoo Kim <iamjoonsoo.kim@lge.com> [171018 01:27]:
> On Mon, Sep 25, 2017 at 07:54:37AM -0700, Tony Lindgren wrote:
> > * Joonsoo Kim <iamjoonsoo.kim@lge.com> [170925 01:06]:
> > > On Thu, Sep 21, 2017 at 10:28:11AM -0700, Tony Lindgren wrote:
> > > > * Joonsoo Kim <iamjoonsoo.kim@lge.com> [170914 23:55]:
> > > > > On Wed, Sep 13, 2017 at 09:31:27AM -0700, Tony Lindgren wrote:
> > > > > > Yes I disabled CONFIG_HIGHMEM and n900 boots. To disable it,
> > > > > > you need to remove it from arch/arm/mach-omap2/Kconfig that
> > > > > > selects it if ARCH_OMAP2PLUS_TYPICAL is selected.
> > > > > 
> > > > > Okay. Problem would be related to address traslation. I'd like to
> > > > > check address traslation more. Could you apply following patch and
> > > > > test it? And, please send me the dmesg log and your kernel config.
> > > > > Please test this with CONFIG_DEBUG_VIRTUAL = n and CONFIG_CMA_DEBUG=y and
> > > > > CONFIG_HIGHMEM=y and with kernel bootparam 'ignore_loglevel'.
> > > > > 
> > > > > It would be really appreciate if you send me two logs for before/after
> > > > > commit 9caf25f996e8.
> > > > 
> > > > Sorry for the delays, I finally got around testing this for you.
> > > 
> > > No problem! I really appreciate your help!
> > > 
> > > > Compile with your patch failed for modules with __virt_to_phys_debug
> > > > being undefined so I added EXPORT_SYMBOL there. I also enabled DEBUG_LL
> > > > and EARLYPRINTK to get output.
> > > > 
> > > > Below is dmesg output for 9caf25f996e8 + your patch. I'll send you
> > > > the full logs separately.
> > > 
> > > Hmm...there is only one caller for the CMA memory, that is, atomic_pool_init().
> > > Could you test one more time with 9caf25f996e8 + following patch?  I'd like to
> > > know the actual user for the CMA memory.
> > 
> > Hmm not getting any stack with that patch after manually applying
> > it because of tabs to spaces mangling.
> 
> Sorry for long delay.
> 
> Seems like your system doesn't use any CMA memory by CMA API.
> 
> Could you test one more thing?
> This one is to disable CMA memory allocation from the page allocator.
> With this, we can be sure that CMA memory isn't used at all.
> 
> If there is no difference with this patch, that is, the system down,
> I think that some initialization step is broken. In this case, please
> test following patch.
> 
> I make a branch in github that all these patch is applied.
> Feel free to use it.
> 
> https://github.com/JoonsooKim/linux/tree/cma-debug4-next-20180901

Still not booting, dmesg output of your test branch below.

Regards,

Tony

8< -------------------------
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.13.0-rc7-next-20170901-00010-gf93e559a038d (tmlind@sampyla) (gcc version 6.3.1 20170109 (crosstool-NG crosstool-ng-1.23.0)) #475 SMP Thu Oct 19 11:09:34 PDT 2017
[    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
[    0.000000] OF: fdt: Machine model: Nokia N900
[    0.000000] Memory policy: Data cache writeback
[    0.000000] cma: Reserved 16 MiB at 0x8e800000
[    0.000000] CMA_ADDR: __phys_to_virt_debug: 0x8e800000 to 0xce800000
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.13.0-rc7-next-20170901-00010-gf93e559a038d #475
[    0.000000] Hardware name: Nokia RX-51 board
[    0.000000] [<c0110b38>] (unwind_backtrace) from [<c010caec>] (show_stack+0x10/0x14)
[    0.000000] [<c010caec>] (show_stack) from [<c082eac4>] (dump_stack+0xac/0xe0)
[    0.000000] [<c082eac4>] (dump_stack) from [<c0c06f10>] (dma_contiguous_remap+0x64/0x168)
[    0.000000] [<c0c06f10>] (dma_contiguous_remap) from [<c0c08114>] (paging_init+0x324/0x700)
[    0.000000] [<c0c08114>] (paging_init) from [<c0c042ac>] (setup_arch+0x5b4/0xc94)
[    0.000000] [<c0c042ac>] (setup_arch) from [<c0c00940>] (start_kernel+0x54/0x3fc)
[    0.000000] [<c0c00940>] (start_kernel) from [<8000807c>] (0x8000807c)
[    0.000000] CMA_ADDR: __phys_to_virt_debug: 0x8e800000 to 0xce800000
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.13.0-rc7-next-20170901-00010-gf93e559a038d #475
[    0.000000] Hardware name: Nokia RX-51 board
[    0.000000] [<c0110b38>] (unwind_backtrace) from [<c010caec>] (show_stack+0x10/0x14)
[    0.000000] [<c010caec>] (show_stack) from [<c082eac4>] (dump_stack+0xac/0xe0)
[    0.000000] [<c082eac4>] (dump_stack) from [<c0c06f50>] (dma_contiguous_remap+0xa4/0x168)
[    0.000000] [<c0c06f50>] (dma_contiguous_remap) from [<c0c08114>] (paging_init+0x324/0x700)
[    0.000000] [<c0c08114>] (paging_init) from [<c0c042ac>] (setup_arch+0x5b4/0xc94)
[    0.000000] [<c0c042ac>] (setup_arch) from [<c0c00940>] (start_kernel+0x54/0x3fc)
[    0.000000] [<c0c00940>] (start_kernel) from [<8000807c>] (0x8000807c)
[    0.000000] CMA_ADDR: __phys_to_virt_debug: 0x8e800000 to 0xce800000
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.13.0-rc7-next-20170901-00010-gf93e559a038d #475
[    0.000000] Hardware name: Nokia RX-51 board
[    0.000000] [<c0110b38>] (unwind_backtrace) from [<c010caec>] (show_stack+0x10/0x14)
[    0.000000] [<c010caec>] (show_stack) from [<c082eac4>] (dump_stack+0xac/0xe0)
[    0.000000] [<c082eac4>] (dump_stack) from [<c0c06fcc>] (dma_contiguous_remap+0x120/0x168)
[    0.000000] [<c0c06fcc>] (dma_contiguous_remap) from [<c0c08114>] (paging_init+0x324/0x700)
[    0.000000] [<c0c08114>] (paging_init) from [<c0c042ac>] (setup_arch+0x5b4/0xc94)
[    0.000000] [<c0c042ac>] (setup_arch) from [<c0c00940>] (start_kernel+0x54/0x3fc)
[    0.000000] [<c0c00940>] (start_kernel) from [<8000807c>] (0x8000807c)
[    0.000000] On node 0 totalpages: 65024
[    0.000000] free_area_init_node: node 0, pgdat c0dc5040, node_mem_map cfa8b000
[    0.000000]   Normal zone: 572 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 65024 pages, LIFO batch:15
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp)
[    0.000000] random: fast init done
[    0.000000] percpu: Embedded 18 pages/cpu @cfd9c000 s41644 r8192 d23892 u73728
[    0.000000] pcpu-alloc: s41644 r8192 d23892 u73728 alloc=18*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 64452
[    0.000000] Kernel command line: root=/dev/nfs ip=dhcp console=ttyO2,115200 memmap=2M$0x88000000 ramoops.mem_address=0x88000000 ramoops.mem_size=0x200000 ramoops.record_size=0x40000 debug earlyprintk init=/root/init
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 220052K/260096K available (8192K kernel code, 816K rwdata, 2420K rodata, 1024K init, 7557K bss, 23660K reserved, 16384K cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xd0000000 - 0xff800000   ( 760 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xcfe00000   ( 254 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0900000   (9184 kB)
[    0.000000]       .init : 0xc0c00000 - 0xc0d00000   (1024 kB)
[    0.000000]       .data : 0xc0d00000 - 0xc0dcc280   ( 817 kB)
[    0.000000]        .bss : 0xc0dce000 - 0xc152f644   (7558 kB)
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
[    0.000030] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 65535999984741ns
[    0.000061] OMAP clocksource: 32k_counter at 32768 Hz
[    0.002716] Console: colour dummy device 80x30
[    0.002807] WARNING: Your 'console=ttyO2' has been replaced by 'ttyS2'
[    0.002838] This ensures that you still see kernel messages. Please
[    0.002868] update your kernel commandline.
[    0.002899] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.002929] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.002960] ... MAX_LOCK_DEPTH:          48
[    0.002990] ... MAX_LOCKDEP_KEYS:        8191
[    0.003021] ... CLASSHASH_SIZE:          4096
[    0.003051] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.003082] ... MAX_LOCKDEP_CHAINS:      65536
[    0.003112] ... CHAINHASH_SIZE:          32768
[    0.003143]  memory used by lock dependency info: 4655 kB
[    0.003173]  per task-struct memory footprint: 1536 bytes
[    0.003234] Calibrating delay loop... 493.97 BogoMIPS (lpj=2469888)
[    0.104431] pid_max: default: 32768 minimum: 301
[    0.105895] Security Framework initialized
[    0.106658] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.106781] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.116973] CPU: Testing write buffer coherency: ok
[    0.121459] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.128570] Setting up static identity map for 0x80100000 - 0x80100078
[    0.130950] Hierarchical SRCU implementation.
[    0.140258] smp: Bringing up secondary CPUs ...
[    0.140380] smp: Brought up 1 node, 1 CPU
[    0.140502] SMP: Total of 1 processors activated (493.97 BogoMIPS).
[    0.140594] CPU: All CPU(s) started in SVC mode.
[    0.152923] devtmpfs: initialized
[    0.661376] Built 1 zonelists, mobility grouping on.  Total pages: 59109
[    0.665405] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
[    0.669372] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.669586] futex hash table entries: 256 (order: 2, 16384 bytes)
[    0.671386] pinctrl core: initialized pinctrl subsystem
[    0.690399] NET: Registered protocol family 16
[    0.691802] __alloc_from_contiguous
[    0.691925] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.13.0-rc7-next-20170901-00010-gf93e559a038d #475
[    0.692016] Hardware name: Nokia RX-51 board
[    0.692138] [<c0110b38>] (unwind_backtrace) from [<c010caec>] (show_stack+0x10/0x14)
[    0.692260] [<c010caec>] (show_stack) from [<c082eac4>] (dump_stack+0xac/0xe0)
[    0.692382] [<c082eac4>] (dump_stack) from [<c011653c>] (__alloc_from_contiguous+0x30/0xf8)
[    0.692504] [<c011653c>] (__alloc_from_contiguous) from [<c0c06d60>] (atomic_pool_init+0x7c/0x178)
[    0.692626] [<c0c06d60>] (atomic_pool_init) from [<c0101df4>] (do_one_initcall+0x3c/0x170)
[    0.692718] [<c0101df4>] (do_one_initcall) from [<c0c00ee4>] (kernel_init_freeable+0x1fc/0x2c4)
[    0.692840] [<c0c00ee4>] (kernel_init_freeable) from [<c0842a0c>] (kernel_init+0x8/0x110)
[    0.692962] [<c0842a0c>] (kernel_init) from [<c0107d78>] (ret_from_fork+0x14/0x3c)
[    0.726104] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    1.273651] omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
[    1.289337] omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
[    1.796203] cpuidle: using governor menu
[    1.798645] SRAM_ADDR: omap_map_sram: P: 0x40208000 - 0x4020f000
[    1.798736] SRAM_ADDR: omap_map_sram: V: 0xd0050000 - 0xd0057000
[    1.798889] SRAM_ADDR: omap_sram_push_address: 0xd0056f00 - 0xd0056ffc
[    1.798980] SRAM_ADDR: omap_sram_push_address: 0xd0056e98 - 0xd0056f00
[    1.799163] Reprogramming SDRC clock to 332000000 Hz
[    1.865997] gpio gpiochip0: (gpio): added GPIO chardev (254:0)
[    1.868011] gpiochip_setup_dev: registered GPIOs 0 to 31 on device: gpiochip0 (gpio)
[    1.868835] OMAP GPIO hardware version 2.5
[    1.880462] gpio gpiochip1: (gpio): added GPIO chardev (254:1)
[    1.882446] gpiochip_setup_dev: registered GPIOs 32 to 63 on device: gpiochip1 (gpio)
[    1.894042] gpio gpiochip2: (gpio): added GPIO chardev (254:2)
[    1.895568] gpiochip_setup_dev: registered GPIOs 64 to 95 on device: gpiochip2 (gpio)
[    1.907318] gpio gpiochip3: (gpio): added GPIO chardev (254:3)
[    1.908843] gpiochip_setup_dev: registered GPIOs 96 to 127 on device: gpiochip3 (gpio)
[    1.920501] gpio gpiochip4: (gpio): added GPIO chardev (254:4)
[    1.922424] gpiochip_setup_dev: registered GPIOs 128 to 159 on device: gpiochip4 (gpio)
[    1.933990] gpio gpiochip5: (gpio): added GPIO chardev (254:5)
[    1.935485] gpiochip_setup_dev: registered GPIOs 160 to 191 on device: gpiochip5 (gpio)
[    2.065551] omap-gpmc 6e000000.gpmc: could not find pctldev for node /ocp@68000000/l4@48000000/scm@2000/pinmux@30/pinmux_gpmc_pins, deferring probe
[    2.119781] hw-breakpoint: debug architecture 0x4 unsupported.
[    2.123596] omap4_sram_init:Unable to allocate sram needed to handle errata I688
[    2.123748] omap4_sram_init:Unable to get sram pool needed to handle errata I688
[    2.131469] Reserving DMA channels 0 and 1 for HS ROM code
[    2.131591] OMAP DMA hardware revision 4.0
[    2.426635] omap-dma-engine 48056000.dma-controller: OMAP DMA engine driver
[    2.460449] omap-iommu 480bd400.mmu: 480bd400.mmu registered
[    2.465270] iommu: Adding device 480bc000.isp to group 0
[    2.477874] SCSI subsystem initialized
[    2.481719] libata version 3.00 loaded.
[    2.485290] omap_i2c 48070000.i2c: could not find pctldev for node /ocp@68000000/l4@48000000/scm@2000/pinmux@30/pinmux_i2c1_pins, deferring probe
[    2.485931] omap_i2c 48072000.i2c: could not find pctldev for node /ocp@68000000/l4@48000000/scm@2000/pinmux@30/pinmux_i2c2_pins, deferring probe
[    2.486511] omap_i2c 48060000.i2c: could not find pctldev for node /ocp@68000000/l4@48000000/scm@2000/pinmux@30/pinmux_i2c3_pins, deferring probe
[    2.488647] pps_core: LinuxPPS API ver. 1 registered
[    2.488739] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    2.489166] PTP clock support registered
[    2.505584] clocksource: Switched to clocksource 32k_counter
[    3.327270] VFS: Disk quotas dquot_6.6.0
[    3.328155] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    3.490722] NET: Registered protocol family 2
[    3.497497] TCP established hash table entries: 2048 (order: 1, 8192 bytes)
[    3.497741] TCP bind hash table entries: 2048 (order: 4, 81920 bytes)
[    3.498992] TCP: Hash tables configured (established 2048 bind 2048)
[    3.500183] UDP hash table entries: 256 (order: 2, 24576 bytes)
[    3.500701] UDP-Lite hash table entries: 256 (order: 2, 24576 bytes)
[    3.503479] NET: Registered protocol family 1
[    3.511474] RPC: Registered named UNIX socket transport module.
[    3.511627] RPC: Registered udp transport module.
[    3.511749] RPC: Registered tcp transport module.
[    3.511871] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    3.538238] hw perfevents: no interrupt-affinity property for /pmu@54000000, guessing.
[    3.540618] hw perfevents: enabled with armv7_cortex_a8 PMU driver, 5 counters available
[    3.572448] audit: initializing netlink subsys (disabled)
[    3.587646] audit: type=2000 audit(3.571:1): state=initialized audit_enabled=0 res=1
[    3.590087] workingset: timestamp_bits=14 max_order=16 bucket_order=2
[    3.602478] NFS: Registering the id_resolver key type
[    3.603515] Key type id_resolver registered
[    3.603668] Key type id_legacy registered
[    3.604309] jffs2: version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
[    3.637115] io scheduler noop registered
[    3.637237] io scheduler deadline registered
[    3.637512] io scheduler cfq registered (default)
[    3.637634] io scheduler mq-deadline registered
[    3.637756] io scheduler kyber registered
[    3.658416] pinctrl-single 48002030.pinmux: 284 pins at pa fa002030 size 568
[    3.663146] pinctrl-single 48002a00.pinmux: 46 pins at pa fa002a00 size 92
[    3.668548] pinctrl-single 480025d8.pinmux: 18 pins at pa fa0025d8 size 36
[    3.711212] Serial: 8250/16550 driver, 6 ports, IRQ sharing enabled
[    3.759765] 4806c000.serial: ttyS1 at MMIO 0x4806c000 (irq = 89, base_baud = 3000000) is a 8250
[    3.774414] 49020000.serial: ttyS2 at MMIO 0x49020000 (irq = 90, base_baud = 3000000) is a 8250
[    5.113739] console [ttyS2] enabled
[    5.301635] brd: module loaded
[    5.439788] loop: module loaded
[    5.459564] mtdoops: mtd device (mtddev=name/number) must be supplied
[    5.530944] mdio_bus fixed-0: GPIO lookup for consumer reset
[    5.537200] mdio_bus fixed-0: using lookup tables for GPIO lookup
[    5.543701] mdio_bus fixed-0: lookup for GPIO reset failed
[    5.550903] libphy: Fixed MDIO Bus: probed
[    5.582519] i2c /dev entries driver
[    5.603973] omap_hsmmc 4809c000.mmc: GPIO lookup for consumer cd
[    5.610595] omap_hsmmc 4809c000.mmc: using device tree for GPIO lookup
[    5.617767] of_get_named_gpiod_flags: parsed 'cd-gpios' property of node '/ocp@68000000/mmc@4809c000[0]' - status (0)
[    5.629211] omap_hsmmc 4809c000.mmc: Got CD GPIO
[    5.634033] omap_hsmmc 4809c000.mmc: GPIO lookup for consumer wp
[    5.640502] omap_hsmmc 4809c000.mmc: using device tree for GPIO lookup
[    5.647491] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of node '/ocp@68000000/mmc@4809c000[0]'
[    5.657928] of_get_named_gpiod_flags: can't parse 'wp-gpio' property of node '/ocp@68000000/mmc@4809c000[0]'
[    5.668212] omap_hsmmc 4809c000.mmc: using lookup tables for GPIO lookup
[    5.675109] omap_hsmmc 4809c000.mmc: lookup for GPIO wp failed
[    5.693267] omap_hsmmc 480b4000.mmc: GPIO lookup for consumer wp
[    5.699981] omap_hsmmc 480b4000.mmc: using device tree for GPIO lookup
[    5.707031] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of node '/ocp@68000000/mmc@480b4000[0]'
[    5.717437] of_get_named_gpiod_flags: can't parse 'wp-gpio' property of node '/ocp@68000000/mmc@480b4000[0]'
[    5.727752] omap_hsmmc 480b4000.mmc: using lookup tables for GPIO lookup
[    5.734619] omap_hsmmc 480b4000.mmc: lookup for GPIO wp failed
[    5.749328] ledtrig-cpu: registered to indicate activity on CPUs
[    5.761383] oprofile: using arm/armv7
[    5.767517] Initializing XFRM netlink socket
[    5.773590] NET: Registered protocol family 10
[    5.789123] Segment Routing with IPv6
[    5.793579] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    5.808959] NET: Registered protocol family 17
[    5.813842] NET: Registered protocol family 15
[    5.819976] Key type dns_resolver registered
[    5.825561] omap2_set_init_voltage: unable to find boot up OPP for vdd_mpu_iva
[    5.832977] omap2_set_init_voltage: unable to set vdd_mpu_iva
[    5.839263] omap2_set_init_voltage: unable to find boot up OPP for vdd_core
[    5.846710] omap2_set_init_voltage: unable to set vdd_core
[    5.864746] save_secure_sram() returns 00000019
[    5.869445] save_secure_sram()'s param: 0: 0x4
[    5.874023] save_secure_sram()'s param: 1: 0x8e700000
[    5.879211] save_secure_sram()'s param: 2: 0x0
[    5.883789] save_secure_sram()'s param: 3: 0x1
[    5.888366] save_secure_sram()'s param: 4: 0x1
