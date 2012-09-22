From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP: hwmod/PMU/PRCM patches for 3.7
Date: Sat, 22 Sep 2012 05:40:52 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209220442010.16893@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209210103140.6888@utopia.booyaka.com> <20120921205322.GK28835@atomide.com> <20120921231039.GN28835@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:35557 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140Ab2IVFkx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 Sep 2012 01:40:53 -0400
In-Reply-To: <20120921231039.GN28835@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


On Fri, 21 Sep 2012, Tony Lindgren wrote:

> * Tony Lindgren <tony@atomide.com> [120921 13:55]:
> 
> Care to base this on something more mergeable? Maybe a merge
> of cleanup-fixes-for-v3.7 + omap-devel-am33xx-for-v3.7?

While working on this, noticed that the 4430ES2 Panda test boot failed on 
the merge base of cleanup-fixes-for-v3.7 and omap-devel-am33xx-for-v3.7.  
Enabling DEBUG_LL and adding some debug revealed that the static variable 
'arch_clkdm' in mach-omap2/clockdomain.c was getting overwritten between 
omap44xx_clockdomains_init() and the end of IRQ setup.  This was bisected 
down to this commit:

commit ec2c0825ca3183a646a24717966cc7752e8b0393
Author: Tony Lindgren <tony@atomide.com>
Date:   Mon Aug 27 17:43:01 2012 -0700

    ARM: OMAP2+: Remove hardcoded IRQs and enable SPARSE_IRQ
    
    Remove hardcoded IRQs in irqs.h and related files as these
    are no longer needed.
    
...

Looks to me like something is wrong with the IRQ allocation and it's 
corrupting memory.


- Paul



[ In the following dump, the lines beginning with 'a:' are logged at the 
beginning of _clkdm_clk_hwmod_enable().  The number on the right 
represents whether arch_clkdm is nonzero (1) or zero (0) ]

...

[    0.000000] free_area_init_node: node 0, pgdat c07af500, node_mem_map c0d0d000
[    0.000000]   Normal zone: 1024 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 125696 pages, LIFO batch:31
[    0.000000] OMAP4430 ES2.0
[    0.000000] a: l3_instr_clkdm 1
[    0.000000] a: l3_instr_clkdm 1
[    0.000000] a: l3_instr_clkdm 1
[    0.000000] a: l3_2_clkdm 1
[    0.000000] a: l3_emif_clkdm 1
[    0.000000] a: l3_emif_clkdm 1
[    0.000000] a: l3_emif_clkdm 1
[    0.000000] PERCPU: Embedded 9 pages/cpu @c1115000 s12736 r8192 d15936 u36864
[    0.000000] pcpu-alloc: s12736 r8192 d15936 u36864 alloc=9*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 125696
[    0.000000] Kernel command line: console=ttyO2,230400n8 vram=16M root=/dev/mmcblk0p2 rw rootfstype=ext3\
 rootwait earlyprintk debug ignore_loglevel
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Memory: 495MB = 495MB total
[    0.000000] Memory: 488916k/488916k available, 35372k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc06d6b18   (6971 kB)
[    0.000000]       .init : 0xc06d7000 - 0xc07261c0   ( 317 kB)
[    0.000000]       .data : 0xc0728000 - 0xc07b1d00   ( 552 kB)
[    0.000000]        .bss : 0xc07b1d24 - 0xc0d0c34c   (5482 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] omap_hwmod: dpll_mpu_m2_ck: missing clockdomain for dpll_mpu_m2_ck.
[    0.000000] a: mpuss_clkdm 0
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1941 _enable+0x1bc/0x204()
[    0.000000] omap_hwmod: mpu: could not enable clockdomain mpuss_clkdm: -22
[    0.000000] Modules linked in:
[    0.000000] [<c001b94c>] (unwind_backtrace+0x0/0xf0) from [<c004239c>] (warn_slowpath_common+0x4c/0x64)
[    0.000000] [<c004239c>] (warn_slowpath_common+0x4c/0x64) from [<c0042448>] (warn_slowpath_fmt+0x30/0x4\
0)
[    0.000000] [<c0042448>] (warn_slowpath_fmt+0x30/0x40) from [<c00292e8>] (_enable+0x1bc/0x204)
[    0.000000] [<c00292e8>] (_enable+0x1bc/0x204) from [<c06e2bf8>] (_setup+0x78/0x150)
[    0.000000] [<c06e2bf8>] (_setup+0x78/0x150) from [<c06e3204>] (omap_hwmod_setup_one+0x4c/0x60)
[    0.000000] [<c06e3204>] (omap_hwmod_setup_one+0x4c/0x60) from [<c06e31ec>] (omap_hwmod_setup_one+0x34/\
0x60)
[    0.000000] [<c06e31ec>] (omap_hwmod_setup_one+0x34/0x60) from [<c06e1340>] (omap_dm_timer_init_one+0x2\
c/0x234)
[    0.000000] [<c06e1340>] (omap_dm_timer_init_one+0x2c/0x234) from [<c06e1564>] (omap2_gp_clockevent_ini\
t+0x1c/0x114)
[    0.000000] [<c06e1564>] (omap2_gp_clockevent_init+0x1c/0x114) from [<c06e1808>] (omap4_timer_init+0x10\
/0x58)
[    0.000000] [<c06e1808>] (omap4_timer_init+0x10/0x58) from [<c06db3a0>] (time_init+0x20/0x30)
[    0.000000] [<c06db3a0>] (time_init+0x20/0x30) from [<c06d76b0>] (start_kernel+0x1b4/0x304)
[    0.000000] [<c06d76b0>] (start_kernel+0x1b4/0x304) from [<80008044>] (0x80008044)
[    0.000000] ---[ end trace 1b75b31a2719ed1c ]---
[    0.000000] omap_hwmod: mpu: cannot be enabled for reset (3)
