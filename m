From: Tony Lindgren <tony@atomide.com>
Subject: Re: n900 in next-20170901
Date: Fri, 20 Oct 2017 10:31:47 -0700
Message-ID: <20171020173146.GN4394@atomide.com>
References: <20170907161650.GP5024@atomide.com>
 <20170913075516.GA25036@js1304-P5Q-DELUXE>
 <20170913163126.GS5024@atomide.com>
 <20170915065608.GA8567@js1304-P5Q-DELUXE>
 <20170921172811.GB4394@atomide.com>
 <20170925080806.GA9837@js1304-P5Q-DELUXE>
 <20170925145437.GG4394@atomide.com>
 <20171018082927.GB27595@js1304-P5Q-DELUXE>
 <20171019183033.GH4394@atomide.com>
 <20171020015542.GA10438@js1304-P5Q-DELUXE>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171020015542.GA10438@js1304-P5Q-DELUXE>
Sender: linux-kernel-owner@vger.kernel.org
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

* Joonsoo Kim <iamjoonsoo.kim@lge.com> [171019 18:53]:
> Oops... I made a mistak. Could you test with reverting commit
> c977ee2803787363187d6aca9cebdabc793c6531 ("omap: forcibly call
> save_secure_ram_context() for test") in that branch?
> Without reverting it, it doesn't call 'smc' so it always cause a
> hang.

Oops I should have noticed that one. Here you go with commit
c977ee280378 reverted. Still not booting.

Regards,

Tony

8< ---------------------------
Booting Linux on physical CPU 0x0
Linux version 4.13.0-rc7-next-20170901-00011-geca3cddaf1a8 (tmlind@sampyla) (gcc version 6.3.1 20170109 (crosstool-NG crosstool-ng-1.23.0)) #541 SMP Fri Oct 20 10:15:45 PDT 2017
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
OF: fdt: Machine model: Nokia N900
Memory policy: Data cache writeback
cma: Reserved 16 MiB at 0x8e800000
CMA_ADDR: __phys_to_virt_debug: 0x8e800000 to 0xce800000
CPU: 0 PID: 0 Comm: swapper Not tainted 4.13.0-rc7-next-20170901-00011-geca3cddaf1a8 #541
Hardware name: Nokia RX-51 board
[<c0110b38>] (unwind_backtrace) from [<c010caec>] (show_stack+0x10/0x14)
[<c010caec>] (show_stack) from [<c082eae4>] (dump_stack+0xac/0xe0)
[<c082eae4>] (dump_stack) from [<c0c06f10>] (dma_contiguous_remap+0x64/0x168)
[<c0c06f10>] (dma_contiguous_remap) from [<c0c08114>] (paging_init+0x324/0x700)
[<c0c08114>] (paging_init) from [<c0c042ac>] (setup_arch+0x5b4/0xc94)
[<c0c042ac>] (setup_arch) from [<c0c00940>] (start_kernel+0x54/0x3fc)
[<c0c00940>] (start_kernel) from [<8000807c>] (0x8000807c)
CMA_ADDR: __phys_to_virt_debug: 0x8e800000 to 0xce800000
CPU: 0 PID: 0 Comm: swapper Not tainted 4.13.0-rc7-next-20170901-00011-geca3cddaf1a8 #541
Hardware name: Nokia RX-51 board
[<c0110b38>] (unwind_backtrace) from [<c010caec>] (show_stack+0x10/0x14)
[<c010caec>] (show_stack) from [<c082eae4>] (dump_stack+0xac/0xe0)
[<c082eae4>] (dump_stack) from [<c0c06f50>] (dma_contiguous_remap+0xa4/0x168)
[<c0c06f50>] (dma_contiguous_remap) from [<c0c08114>] (paging_init+0x324/0x700)
[<c0c08114>] (paging_init) from [<c0c042ac>] (setup_arch+0x5b4/0xc94)
[<c0c042ac>] (setup_arch) from [<c0c00940>] (start_kernel+0x54/0x3fc)
[<c0c00940>] (start_kernel) from [<8000807c>] (0x8000807c)
CMA_ADDR: __phys_to_virt_debug: 0x8e800000 to 0xce800000
CPU: 0 PID: 0 Comm: swapper Not tainted 4.13.0-rc7-next-20170901-00011-geca3cddaf1a8 #541
Hardware name: Nokia RX-51 board
[<c0110b38>] (unwind_backtrace) from [<c010caec>] (show_stack+0x10/0x14)
[<c010caec>] (show_stack) from [<c082eae4>] (dump_stack+0xac/0xe0)
[<c082eae4>] (dump_stack) from [<c0c06fcc>] (dma_contiguous_remap+0x120/0x168)
[<c0c06fcc>] (dma_contiguous_remap) from [<c0c08114>] (paging_init+0x324/0x700)
[<c0c08114>] (paging_init) from [<c0c042ac>] (setup_arch+0x5b4/0xc94)
[<c0c042ac>] (setup_arch) from [<c0c00940>] (start_kernel+0x54/0x3fc)
[<c0c00940>] (start_kernel) from [<8000807c>] (0x8000807c)
On node 0 totalpages: 65024
free_area_init_node: node 0, pgdat c0dc5040, node_mem_map cfa8b000
  Normal zone: 572 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 65024 pages, LIFO batch:15
CPU: All CPU(s) started in SVC mode.
OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp)
random: fast init done
percpu: Embedded 18 pages/cpu @cfd9c000 s41644 r8192 d23892 u73728
pcpu-alloc: s41644 r8192 d23892 u73728 alloc=18*4096
pcpu-alloc: [0] 0
Built 1 zonelists, mobility grouping on.  Total pages: 64452
Kernel command line: root=/dev/nfs ip=dhcp console=ttyO2,115200 memmap=2M$0x88000000 ramoops.mem_address=0x88000000 ramoops.mem_size=0x200000 ramoops.record_size=0x40000 debug earlyprintk init=/root/init
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 220052K/260096K available (8192K kernel code, 816K rwdata, 2420K rodata, 1024K init, 7557K bss, 23660K reserved, 16384K cma-reserved, 0K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xd0000000 - 0xff800000   ( 760 MB)
    lowmem  : 0xc0000000 - 0xcfe00000   ( 254 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
    modules : 0xbf000000 - 0xbfe00000   (  14 MB)
      .text : 0xc0008000 - 0xc0900000   (9184 kB)
      .init : 0xc0c00000 - 0xc0d00000   (1024 kB)
      .data : 0xc0d00000 - 0xc0dcc280   ( 817 kB)
       .bss : 0xc0dce000 - 0xc152f644   (7558 kB)
Running RCU self tests
Hierarchical RCU implementation.
	RCU event tracing is enabled.
	RCU lockdep checking is enabled.
	RCU restricting CPUs from NR_CPUS=2 to nr_cpu_ids=1.
RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
Clocking rate (Crystal/Core/MPU): 19.2/332/500 MHz
OMAP clockevent source: timer1 at 32768 Hz
clocksource: 32k_counter: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 58327039986419 ns
sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 65535999984741ns
OMAP clocksource: 32k_counter at 32768 Hz
Console: colour dummy device 80x30
WARNING: Your 'console=ttyO2' has been replaced by 'ttyS2'
This ensures that you still see kernel messages. Please
update your kernel commandline.
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8191
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     32768
... MAX_LOCKDEP_CHAINS:      65536
... CHAINHASH_SIZE:          32768
 memory used by lock dependency info: 4655 kB
 per task-struct memory footprint: 1536 bytes
Calibrating delay loop... 493.97 BogoMIPS (lpj=2469888)
pid_max: default: 32768 minimum: 301
Security Framework initialized
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
CPU: Testing write buffer coherency: ok
CPU0: thread -1, cpu 0, socket -1, mpidr 0
Setting up static identity map for 0x80100000 - 0x80100078
Hierarchical SRCU implementation.
smp: Bringing up secondary CPUs ...
smp: Brought up 1 node, 1 CPU
SMP: Total of 1 processors activated (493.97 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
Built 1 zonelists, mobility grouping on.  Total pages: 59109
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
futex hash table entries: 256 (order: 2, 16384 bytes)
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
__alloc_from_contiguous
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.13.0-rc7-next-20170901-00011-geca3cddaf1a8 #541
Hardware name: Nokia RX-51 board
[<c0110b38>] (unwind_backtrace) from [<c010caec>] (show_stack+0x10/0x14)
[<c010caec>] (show_stack) from [<c082eae4>] (dump_stack+0xac/0xe0)
[<c082eae4>] (dump_stack) from [<c011653c>] (__alloc_from_contiguous+0x30/0xf8)
[<c011653c>] (__alloc_from_contiguous) from [<c0c06d60>] (atomic_pool_init+0x7c/0x178)
[<c0c06d60>] (atomic_pool_init) from [<c0101df4>] (do_one_initcall+0x3c/0x170)
[<c0101df4>] (do_one_initcall) from [<c0c00ee4>] (kernel_init_freeable+0x1fc/0x2c4)
[<c0c00ee4>] (kernel_init_freeable) from [<c0842a2c>] (kernel_init+0x8/0x110)
[<c0842a2c>] (kernel_init) from [<c0107d78>] (ret_from_fork+0x14/0x3c)
DMA: preallocated 256 KiB pool for atomic coherent allocations
omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
cpuidle: using governor menu
SRAM_ADDR: omap_map_sram: P: 0x40208000 - 0x4020f000
SRAM_ADDR: omap_map_sram: V: 0xd0050000 - 0xd0057000
SRAM_ADDR: omap_sram_push_address: 0xd0056f00 - 0xd0056ffc
SRAM_ADDR: omap_sram_push_address: 0xd0056e90 - 0xd0056efc
Reprogramming SDRC clock to 332000000 Hz
gpio gpiochip0: (gpio): added GPIO chardev (254:0)
gpiochip_setup_dev: registered GPIOs 0 to 31 on device: gpiochip0 (gpio)
OMAP GPIO hardware version 2.5
gpio gpiochip1: (gpio): added GPIO chardev (254:1)
gpiochip_setup_dev: registered GPIOs 32 to 63 on device: gpiochip1 (gpio)
gpio gpiochip2: (gpio): added GPIO chardev (254:2)
gpiochip_setup_dev: registered GPIOs 64 to 95 on device: gpiochip2 (gpio)
gpio gpiochip3: (gpio): added GPIO chardev (254:3)
gpiochip_setup_dev: registered GPIOs 96 to 127 on device: gpiochip3 (gpio)
gpio gpiochip4: (gpio): added GPIO chardev (254:4)
gpiochip_setup_dev: registered GPIOs 128 to 159 on device: gpiochip4 (gpio)
gpio gpiochip5: (gpio): added GPIO chardev (254:5)
gpiochip_setup_dev: registered GPIOs 160 to 191 on device: gpiochip5 (gpio)
omap-gpmc 6e000000.gpmc: could not find pctldev for node /ocp@68000000/l4@48000000/scm@2000/pinmux@30/pinmux_gpmc_pins, deferring probe
hw-breakpoint: debug architecture 0x4 unsupported.
omap4_sram_init:Unable to allocate sram needed to handle errata I688
omap4_sram_init:Unable to get sram pool needed to handle errata I688
Reserving DMA channels 0 and 1 for HS ROM code
OMAP DMA hardware revision 4.0
omap-dma-engine 48056000.dma-controller: OMAP DMA engine driver
omap-iommu 480bd400.mmu: 480bd400.mmu registered
iommu: Adding device 480bc000.isp to group 0
SCSI subsystem initialized
libata version 3.00 loaded.
omap_i2c 48070000.i2c: could not find pctldev for node /ocp@68000000/l4@48000000/scm@2000/pinmux@30/pinmux_i2c1_pins, deferring probe
omap_i2c 48072000.i2c: could not find pctldev for node /ocp@68000000/l4@48000000/scm@2000/pinmux@30/pinmux_i2c2_pins, deferring probe
omap_i2c 48060000.i2c: could not find pctldev for node /ocp@68000000/l4@48000000/scm@2000/pinmux@30/pinmux_i2c3_pins, deferring probe
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
PTP clock support registered
clocksource: Switched to clocksource 32k_counter
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
NET: Registered protocol family 2
TCP established hash table entries: 2048 (order: 1, 8192 bytes)
TCP bind hash table entries: 2048 (order: 4, 81920 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
UDP hash table entries: 256 (order: 2, 24576 bytes)
UDP-Lite hash table entries: 256 (order: 2, 24576 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
hw perfevents: no interrupt-affinity property for /pmu@54000000, guessing.
hw perfevents: enabled with armv7_cortex_a8 PMU driver, 5 counters available
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(3.541:1): state=initialized audit_enabled=0 res=1
workingset: timestamp_bits=14 max_order=16 bucket_order=2
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
jffs2: version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
io scheduler mq-deadline registered
io scheduler kyber registered
pinctrl-single 48002030.pinmux: 284 pins at pa fa002030 size 568
pinctrl-single 48002a00.pinmux: 46 pins at pa fa002a00 size 92
pinctrl-single 480025d8.pinmux: 18 pins at pa fa0025d8 size 36
Serial: 8250/16550 driver, 6 ports, IRQ sharing enabled
4806c000.serial: ttyS1 at MMIO 0x4806c000 (irq = 89, base_baud = 3000000) is a 8250
49020000.serial: ttyS2 at MMIO 0x49020000 (irq = 90, base_baud = 3000000) is a 8250
console [ttyS2] enabled
brd: module loaded
loop: module loaded
mtdoops: mtd device (mtddev=name/number) must be supplied
mdio_bus fixed-0: GPIO lookup for consumer reset
mdio_bus fixed-0: using lookup tables for GPIO lookup
mdio_bus fixed-0: lookup for GPIO reset failed
libphy: Fixed MDIO Bus: probed
i2c /dev entries driver
omap_hsmmc 4809c000.mmc: GPIO lookup for consumer cd
omap_hsmmc 4809c000.mmc: using device tree for GPIO lookup
of_get_named_gpiod_flags: parsed 'cd-gpios' property of node '/ocp@68000000/mmc@4809c000[0]' - status (0)
omap_hsmmc 4809c000.mmc: Got CD GPIO
omap_hsmmc 4809c000.mmc: GPIO lookup for consumer wp
omap_hsmmc 4809c000.mmc: using device tree for GPIO lookup
of_get_named_gpiod_flags: can't parse 'wp-gpios' property of node '/ocp@68000000/mmc@4809c000[0]'
of_get_named_gpiod_flags: can't parse 'wp-gpio' property of node '/ocp@68000000/mmc@4809c000[0]'
omap_hsmmc 4809c000.mmc: using lookup tables for GPIO lookup
omap_hsmmc 4809c000.mmc: lookup for GPIO wp failed
omap_hsmmc 480b4000.mmc: GPIO lookup for consumer wp
omap_hsmmc 480b4000.mmc: using device tree for GPIO lookup
of_get_named_gpiod_flags: can't parse 'wp-gpios' property of node '/ocp@68000000/mmc@480b4000[0]'
of_get_named_gpiod_flags: can't parse 'wp-gpio' property of node '/ocp@68000000/mmc@480b4000[0]'
omap_hsmmc 480b4000.mmc: using lookup tables for GPIO lookup
omap_hsmmc 480b4000.mmc: lookup for GPIO wp failed
ledtrig-cpu: registered to indicate activity on CPUs
oprofile: using arm/armv7
Initializing XFRM netlink socket
NET: Registered protocol family 10
Segment Routing with IPv6
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
Key type dns_resolver registered
omap2_set_init_voltage: unable to find boot up OPP for vdd_mpu_iva
omap2_set_init_voltage: unable to set vdd_mpu_iva
omap2_set_init_voltage: unable to find boot up OPP for vdd_core
omap2_set_init_voltage: unable to set vdd_core
save_secure_sram() returns 0000ff02
save_secure_sram()'s param: 0: 0x4
save_secure_sram()'s param: 1: 0x8e700000
save_secure_sram()'s param: 2: 0x0
save_secure_sram()'s param: 3: 0x1
save_secure_sram()'s param: 4: 0x1
