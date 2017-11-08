From: Tony Lindgren <tony@atomide.com>
Subject: Re: n900 in next-20170901
Date: Wed, 8 Nov 2017 08:34:13 -0800
Message-ID: <20171108163413.GU28152@atomide.com>
References: <20171019183033.GH4394@atomide.com>
 <20171020015542.GA10438@js1304-P5Q-DELUXE>
 <20171020173146.GN4394@atomide.com>
 <20171023045342.GA23082@js1304-P5Q-DELUXE>
 <20171025173137.GQ4394@atomide.com>
 <20171026044829.GB11791@js1304-P5Q-DELUXE>
 <20171026141627.GD21504@atomide.com>
 <20171107053313.GA12447@js1304-P5Q-DELUXE>
 <20171107154842.GP28152@atomide.com>
 <20171108074645.GA18747@js1304-P5Q-DELUXE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171108074645.GA18747@js1304-P5Q-DELUXE>
Sender: linux-kernel-owner@vger.kernel.org
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

* Joonsoo Kim <iamjoonsoo.kim@lge.com> [171108 07:43]:
> On Tue, Nov 07, 2017 at 07:48:42AM -0800, Tony Lindgren wrote:
> > So it seems the issue is currently at the atomic_pool_init()
> > related code?
> 
> Yes, your test showed it although I can't find any clue in
> atomic_pool_init().
> 
> Could you test updated branch?
> 
> https://github.com/JoonsooKim/linux/tree/cma-debug4-next-20180901
> 
> There are two relevant commits.
> 
> arm/dma: stop dma allocation before __dma_alloc_remap()
> arm/dma: disable atomic pool after dma allocation
> 
> atomic pool initialization will be done partially to check
> exact point of failure. These are brain-dead commits however I have no
> idea what's going on here until now. :/

OK that booted, dmesg output below. Hopefully that provides
you with some more clues.

Regards,

Tony

8< ---------------------
Linux version 4.13.0-rc7-next-20170901-00024-gcf9a104b2f62 (tmlind@sampyla) (gcc version 6.3.1 20170109 (crosstool-NG crosstool-ng-1.23.0)) #568 SMP Wed Nov 8 08:25:47 PST 2017
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
OF: fdt: Machine model: Nokia N900
memblock_add: [0x80000000-0x8fffffff] early_init_dt_scan_memory+0xec/0x158
Memory policy: Data cache writeback
memblock_reserve: [0x80100000-0x8152f643] arm_memblock_init+0x30/0x1b0
memblock_reserve: [0x80004000-0x80007fff] arm_memblock_init+0x13c/0x1b0
memblock_reserve: [0x8ff00000-0x8fffffff] memblock_alloc_range_nid+0x38/0x50
   memblock_free: [0x8ff00000-0x8fffffff] arm_memblock_steal+0x30/0x48
memblock_reserve: [0x8fe00000-0x8fefffff] memblock_alloc_range_nid+0x38/0x50
   memblock_free: [0x8fe00000-0x8fefffff] arm_memblock_steal+0x30/0x48
memblock_reserve: [0x8fccb000-0x8fcddfff] arm_memblock_init+0x150/0x1b0
memblock_reserve: [0x8fccb000-0x8fcddfff] early_init_fdt_scan_reserved_mem+0x58/0x7c
memblock_reserve: [0x8e800000-0x8f7fffff] memblock_alloc_range_nid+0x38/0x50
cma: Reserved 16 MiB at 0x8e800000
MEMBLOCK configuration:
 memory size = 0x0fe00000 reserved size = 0x02446644
 memory.cnt  = 0x1
 memory[0x0]	[0x80000000-0x8fdfffff], 0x0fe00000 bytes flags: 0x0
 reserved.cnt  = 0x4
 reserved[0x0]	[0x80004000-0x80007fff], 0x00004000 bytes flags: 0x0
 reserved[0x1]	[0x80100000-0x8152f643], 0x0142f644 bytes flags: 0x0
 reserved[0x2]	[0x8e800000-0x8f7fffff], 0x01000000 bytes flags: 0x0
 reserved[0x3]	[0x8fccb000-0x8fcddfff], 0x00013000 bytes flags: 0x0
CMA_ADDR: __phys_to_virt_debug: 0x8e800000 to 0xce800000
CPU: 0 PID: 0 Comm: swapper Not tainted 4.13.0-rc7-next-20170901-00024-gcf9a104b2f62 #568
Hardware name: Nokia RX-51 board
[<c0110b38>] (unwind_backtrace) from [<c010caec>] (show_stack+0x10/0x14)
[<c010caec>] (show_stack) from [<c082eb04>] (dump_stack+0xac/0xe0)
[<c082eb04>] (dump_stack) from [<c0c06e94>] (dma_contiguous_remap+0x70/0x144)
[<c0c06e94>] (dma_contiguous_remap) from [<c0c08068>] (paging_init+0x324/0x700)
[<c0c08068>] (paging_init) from [<c0c042ac>] (setup_arch+0x5b4/0xc94)
[<c0c042ac>] (setup_arch) from [<c0c00940>] (start_kernel+0x54/0x3fc)
[<c0c00940>] (start_kernel) from [<8000807c>] (0x8000807c)
CMA_ADDR: __phys_to_virt_debug: 0x8e800000 to 0xce800000
CPU: 0 PID: 0 Comm: swapper Not tainted 4.13.0-rc7-next-20170901-00024-gcf9a104b2f62 #568
Hardware name: Nokia RX-51 board
[<c0110b38>] (unwind_backtrace) from [<c010caec>] (show_stack+0x10/0x14)
[<c010caec>] (show_stack) from [<c082eb04>] (dump_stack+0xac/0xe0)
[<c082eb04>] (dump_stack) from [<c0c06eb8>] (dma_contiguous_remap+0x94/0x144)
[<c0c06eb8>] (dma_contiguous_remap) from [<c0c08068>] (paging_init+0x324/0x700)
[<c0c08068>] (paging_init) from [<c0c042ac>] (setup_arch+0x5b4/0xc94)
[<c0c042ac>] (setup_arch) from [<c0c00940>] (start_kernel+0x54/0x3fc)
[<c0c00940>] (start_kernel) from [<8000807c>] (0x8000807c)
CMA_ADDR: __phys_to_virt_debug: 0x8e800000 to 0xce800000
CPU: 0 PID: 0 Comm: swapper Not tainted 4.13.0-rc7-next-20170901-00024-gcf9a104b2f62 #568
Hardware name: Nokia RX-51 board
[<c0110b38>] (unwind_backtrace) from [<c010caec>] (show_stack+0x10/0x14)
[<c010caec>] (show_stack) from [<c082eb04>] (dump_stack+0xac/0xe0)
[<c082eb04>] (dump_stack) from [<c0c06f24>] (dma_contiguous_remap+0x100/0x144)
[<c0c06f24>] (dma_contiguous_remap) from [<c0c08068>] (paging_init+0x324/0x700)
[<c0c08068>] (paging_init) from [<c0c042ac>] (setup_arch+0x5b4/0xc94)
[<c0c042ac>] (setup_arch) from [<c0c00940>] (start_kernel+0x54/0x3fc)
[<c0c00940>] (start_kernel) from [<8000807c>] (0x8000807c)
memblock_reserve: [0x8fdfe000-0x8fdfffff] memblock_alloc_range_nid+0x38/0x50
memblock_reserve: [0x8fdfd000-0x8fdfdfff] memblock_alloc_range_nid+0x38/0x50
memblock_reserve: [0x8fdfcee8-0x8fdfcfff] memblock_alloc_range_nid+0x38/0x50
memblock_reserve: [0x8fdfcec0-0x8fdfcee7] memblock_alloc_range_nid+0x38/0x50
memblock_reserve: [0x8fdfce98-0x8fdfcebf] memblock_alloc_range_nid+0x38/0x50
memblock_reserve: [0x8fdfce70-0x8fdfce97] memblock_alloc_range_nid+0x38/0x50
memblock_reserve: [0x8fdfce48-0x8fdfce6f] memblock_alloc_range_nid+0x38/0x50
memblock_reserve: [0x8fdfce20-0x8fdfce47] memblock_alloc_range_nid+0x38/0x50
memblock_reserve: [0x8fdfb000-0x8fdfbfff] memblock_alloc_range_nid+0x38/0x50
memblock_reserve: [0x8fdfa000-0x8fdfafff] memblock_alloc_range_nid+0x38/0x50
memblock_reserve: [0x8fdf9000-0x8fdf9fff] memblock_alloc_range_nid+0x38/0x50
On node 0 totalpages: 65024
memblock_virt_alloc_try_nid_nopanic: 2359296 bytes align=0x0 nid=0 from=0x0 max_addr=0x0 alloc_node_mem_map.constprop.10+0x68/0xb4
memblock_reserve: [0x8fa8b000-0x8fccafff] memblock_virt_alloc_internal+0xfc/0x1c0
free_area_init_node: node 0, pgdat c0dc5040, node_mem_map cfa8b000
  Normal zone: 572 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 65024 pages, LIFO batch:15
memblock_virt_alloc_try_nid_nopanic: 16 bytes align=0x0 nid=0 from=0x0 max_addr=0x0 setup_usemap.constprop.12+0x5c/0x6c
memblock_reserve: [0x8fdfce00-0x8fdfce0f] memblock_virt_alloc_internal+0xfc/0x1c0
memblock_virt_alloc_try_nid_nopanic: 16 bytes align=0x0 nid=0 from=0x0 max_addr=0x0 setup_usemap.constprop.12+0x5c/0x6c
memblock_reserve: [0x8fdfcdc0-0x8fdfcdcf] memblock_virt_alloc_internal+0xfc/0x1c0
memblock_virt_alloc_try_nid: 32 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 setup_arch+0x6e8/0xc94
memblock_reserve: [0x8fdfcd80-0x8fdfcd9f] memblock_virt_alloc_internal+0xfc/0x1c0
memblock_reserve: [0x8fdb0548-0x8fdf8fff] memblock_alloc_range_nid+0x38/0x50
memblock_reserve: [0x8fdfcde8-0x8fdfcdff] memblock_alloc_range_nid+0x38/0x50
memblock_reserve: [0x8fdfcdd0-0x8fdfcde7] memblock_alloc_range_nid+0x38/0x50
memblock_reserve: [0x8fdfcda4-0x8fdfcdbe] memblock_alloc_range_nid+0x38/0x50
memblock_reserve: [0x8fdfcd64-0x8fdfcd7e] memblock_alloc_range_nid+0x38/0x50
memblock_reserve: [0x8fdfcd48-0x8fdfcd62] memblock_alloc_range_nid+0x38/0x50
memblock_reserve: [0x8fdfcd30-0x8fdfcd47] memblock_alloc_range_nid+0x38/0x50
CPU: All CPU(s) started in SVC mode.
OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp)
memblock_virt_alloc_try_nid: 8 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 omap2_clk_legacy_provider_init+0x2c/0x44
memblock_reserve: [0x8fdfcd00-0x8fdfcd07] memblock_virt_alloc_internal+0xfc/0x1c0
memblock_virt_alloc_try_nid: 8 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 omap2_clk_legacy_provider_init+0x2c/0x44
memblock_reserve: [0x8fdfccc0-0x8fdfccc7] memblock_virt_alloc_internal+0xfc/0x1c0
random: fast init done
memblock_virt_alloc_try_nid: 183 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 start_kernel+0x9c/0x3fc
memblock_reserve: [0x8fdfcc00-0x8fdfccb6] memblock_virt_alloc_internal+0xfc/0x1c0
memblock_virt_alloc_try_nid: 183 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 start_kernel+0xc0/0x3fc
memblock_reserve: [0x8fdfcb40-0x8fdfcbf6] memblock_virt_alloc_internal+0xfc/0x1c0
memblock_virt_alloc_try_nid: 183 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 start_kernel+0xe4/0x3fc
memblock_reserve: [0x8fdfca80-0x8fdfcb36] memblock_virt_alloc_internal+0xfc/0x1c0
memblock_virt_alloc_try_nid_nopanic: 4096 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_alloc_info+0x4c/0x88
memblock_reserve: [0x8fdaf540-0x8fdb053f] memblock_virt_alloc_internal+0xfc/0x1c0
memblock_virt_alloc_try_nid_nopanic: 4096 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_embed_first_chunk+0x464/0x714
memblock_reserve: [0x8fdae540-0x8fdaf53f] memblock_virt_alloc_internal+0xfc/0x1c0
memblock_virt_alloc_try_nid_nopanic: 73728 bytes align=0x1000 nid=-1 from=0xbfffffff max_addr=0x0 pcpu_dfl_fc_alloc+0x3c/0x44
memblock_reserve: [0x8fd9c000-0x8fdadfff] memblock_virt_alloc_internal+0xfc/0x1c0
__memblock_free_early: [0x0000008fdae000-0x0000008fdadfff] pcpu_embed_first_chunk+0x5d8/0x714
percpu: Embedded 18 pages/cpu @cfd9c000 s41644 r8192 d23892 u73728
memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0xf0/0x678
memblock_reserve: [0x8fdfca40-0x8fdfca43] memblock_virt_alloc_internal+0xfc/0x1c0
memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x110/0x678
memblock_reserve: [0x8fdfca00-0x8fdfca03] memblock_virt_alloc_internal+0xfc/0x1c0
memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x130/0x678
memblock_reserve: [0x8fdfc9c0-0x8fdfc9c3] memblock_virt_alloc_internal+0xfc/0x1c0
memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x150/0x678
memblock_reserve: [0x8fdfc980-0x8fdfc983] memblock_virt_alloc_internal+0xfc/0x1c0
pcpu-alloc: s41644 r8192 d23892 u73728 alloc=18*4096
pcpu-alloc: [0] 0
memblock_virt_alloc_try_nid: 128 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x41c/0x678
memblock_reserve: [0x8fdfc900-0x8fdfc97f] memblock_virt_alloc_internal+0xfc/0x1c0
memblock_virt_alloc_try_nid: 69 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_first_chunk+0x64/0x2b4
memblock_reserve: [0x8fdfc880-0x8fdfc8c4] memblock_virt_alloc_internal+0xfc/0x1c0
memblock_virt_alloc_try_nid: 384 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_first_chunk+0xa8/0x2b4
memblock_reserve: [0x8fdfc700-0x8fdfc87f] memblock_virt_alloc_internal+0xfc/0x1c0
memblock_virt_alloc_try_nid: 388 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_first_chunk+0xc8/0x2b4
memblock_reserve: [0x8fdfc540-0x8fdfc6c3] memblock_virt_alloc_internal+0xfc/0x1c0
memblock_virt_alloc_try_nid: 60 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_first_chunk+0xf4/0x2b4
memblock_reserve: [0x8fdfc500-0x8fdfc53b] memblock_virt_alloc_internal+0xfc/0x1c0
memblock_virt_alloc_try_nid: 69 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_first_chunk+0x64/0x2b4
memblock_reserve: [0x8fdfc480-0x8fdfc4c4] memblock_virt_alloc_internal+0xfc/0x1c0
memblock_virt_alloc_try_nid: 768 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_first_chunk+0xa8/0x2b4
memblock_reserve: [0x8fdfc180-0x8fdfc47f] memblock_virt_alloc_internal+0xfc/0x1c0
memblock_virt_alloc_try_nid: 772 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_first_chunk+0xc8/0x2b4
memblock_reserve: [0x8fdae200-0x8fdae503] memblock_virt_alloc_internal+0xfc/0x1c0
memblock_virt_alloc_try_nid: 120 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_first_chunk+0xf4/0x2b4
memblock_reserve: [0x8fdfc100-0x8fdfc177] memblock_virt_alloc_internal+0xfc/0x1c0
__memblock_free_early: [0x0000008fdaf540-0x0000008fdb053f] pcpu_embed_first_chunk+0x664/0x714
__memblock_free_early: [0x0000008fdae540-0x0000008fdaf53f] pcpu_embed_first_chunk+0x6c4/0x714
Built 1 zonelists, mobility grouping on.  Total pages: 64452
Kernel command line: root=/dev/nfs ip=dhcp console=ttyO2,115200 memmap=2M$0x88000000 ramoops.mem_address=0x88000000 ramoops.mem_size=0x200000 ramoops.record_size=0x40000 debug earlyprintk init=/root/init
memblock_virt_alloc_try_nid_nopanic: 4096 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 alloc_large_system_hash+0x180/0x268
memblock_reserve: [0x8fdaf540-0x8fdb053f] memblock_virt_alloc_internal+0xfc/0x1c0
PID hash table entries: 1024 (order: 0, 4096 bytes)
memblock_virt_alloc_try_nid_nopanic: 131072 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 alloc_large_system_hash+0x180/0x268
memblock_reserve: [0x8fd7c000-0x8fd9bfff] memblock_virt_alloc_internal+0xfc/0x1c0
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
memblock_virt_alloc_try_nid_nopanic: 65536 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 alloc_large_system_hash+0x180/0x268
memblock_reserve: [0x8fd6c000-0x8fd7bfff] memblock_virt_alloc_internal+0xfc/0x1c0
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
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.13.0-rc7-next-20170901-00024-gcf9a104b2f62 #568
Hardware name: Nokia RX-51 board
[<c0110b38>] (unwind_backtrace) from [<c010caec>] (show_stack+0x10/0x14)
[<c010caec>] (show_stack) from [<c082eb04>] (dump_stack+0xac/0xe0)
[<c082eb04>] (dump_stack) from [<c0118b94>] (__alloc_from_contiguous.constprop.7+0x28/0x68)
[<c0118b94>] (__alloc_from_contiguous.constprop.7) from [<c0c06d3c>] (atomic_pool_init+0x58/0xf0)
[<c0c06d3c>] (atomic_pool_init) from [<c0101df4>] (do_one_initcall+0x3c/0x170)
[<c0101df4>] (do_one_initcall) from [<c0c00ee4>] (kernel_init_freeable+0x1fc/0x2c4)
[<c0c00ee4>] (kernel_init_freeable) from [<c0842a4c>] (kernel_init+0x8/0x110)
[<c0842a4c>] (kernel_init) from [<c0107d78>] (ret_from_fork+0x14/0x3c)
atomic_pool_init: DMA: disable atomic_pool
omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
cpuidle: using governor menu
SRAM_ADDR: omap_map_sram: P: 0x40208000 - 0x4020f000
SRAM_ADDR: omap_map_sram: V: 0xd0008000 - 0xd000f000
SRAM_ADDR: omap_sram_push_address: 0xd000ef00 - 0xd000effc
SRAM_ADDR: omap_sram_push_address: 0xd000ee90 - 0xd000eefc
Reprogramming SDRC clock to 332000000 Hz
...
