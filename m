From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP4: clockdomain: Follow recommended enable sequence
Date: Thu, 10 Mar 2011 07:39:38 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103100734490.15132@utopia.booyaka.com>
References: <1299245123-23444-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1103081937100.15132@utopia.booyaka.com> <4D775418.6050105@ti.com> <alpine.DEB.2.00.1103100514210.15132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60032 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab1CJOjj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 09:39:39 -0500
In-Reply-To: <alpine.DEB.2.00.1103100514210.15132@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

On Thu, 10 Mar 2011, Paul Walmsley wrote:

> On Wed, 9 Mar 2011, Rajendra Nayak wrote:
> 
> > On Wednesday 09 March 2011 09:20 AM, Paul Walmsley wrote:
> > > On Fri, 4 Mar 2011, Rajendra Nayak wrote:
> > > 
> > > > On OMAP4, the PRCM recommended sequence for enabling
> > > > a module after power-on-reset is
> > > > -1- Force clkdm to SW_WKUP
> > > > -2- Configure desired module mode to "enable" or "auto"
> > > > -3- Wait for the desired module idle status to be FUNC
> > > > -4- Program clkdm in HW_AUTO(if supported)
> > > > 
> > > > This sequence applies to all older OMAPs' as well,
> > > > however since they use autodeps, it makes sure that
> > > > no clkdm is in IDLE, and hence not requiring a force
> > > > SW_WKUP when a module is being enabled.
> 
> This patch is currently breaking boot on OMAP4430 ES2.0 Pandaboard,
> so I've dropped it from the integration branch until it can be
> debugged.  Could you check it, please?

It's also breaking boot on OMAP35xx BeagleBoard rev C2.  The kernel 
boot messages are below - omap2plus_defconfig + DEBUG_LL.  Reverting
the patch fixes it.  Could you please take a look?


- Paul

Uncompressing Linux... done, booting the kernel.
[    0.000000] Linux version 2.6.38-rc7-00245-gccc0402 (paul@twilight) (gcc version 4.5.1 (Sourcery G1
[    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
[    0.000000] Machine: OMAP3 Beagle Board
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3430/3530 ES3.0 (l2cache iva sgx neon isp )
[    0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x10000
[    0.000000] On node 0 totalpages: 65536
[    0.000000] free_area_init_node: node 0, pgdat c05faf20, node_mem_map c0b54000
[    0.000000]   Normal zone: 512 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 65024 pages, LIFO batch:15
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
[    0.000000] Reprogramming SDRC clock to 332000000 Hz
[    0.000000] PERCPU: Embedded 7 pages/cpu @c0d59000 s8032 r8192 d12448 u32768
[    0.000000] pcpu-alloc: s8032 r8192 d12448 u32768 alloc=8*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
[    0.000000] Kernel command line: console=ttyO2,115200n8 root=/dev/mmcblk0p2 rw rootfstype=ext3 memk
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 256MB = 256MB total
[    0.000000] Memory: 248248k/248248k available, 13896k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xd0800000 - 0xf8000000   ( 632 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc0051000   ( 292 kB)
[    0.000000]       .text : 0xc0051000 - 0xc05832fc   (5321 kB)
[    0.000000]       .data : 0xc0584000 - 0xc05fc300   ( 481 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU-based detection of stalled CPUs is disabled.
[    0.000000] NR_IRQS:409
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] omap_hwmod: gpt12_fck: missing clockdomain for gpt12_fck.
[    0.000000] OMAP clockevent source: GPTIMER12 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.057403] Calibrating delay loop... 476.81 BogoMIPS (lpj=1859584)
[    0.226165] pid_max: default: 32768 minimum: 301
[    0.231872] Security Framework initialized
[    0.236602] Mount-cache hash table entries: 512
[    0.246917] CPU: Testing write buffer coherency: ok
[    0.255737] Brought up 1 CPUs
[    0.258880] SMP: Total of 1 processors activated (476.81 BogoMIPS).
[    0.282135] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_core
[    0.289703] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_per
[    0.297088] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_wkup
[    0.321289] omap_hwmod: i2c1: softreset failed (waited 10000 usec)
[    0.341857] omap_hwmod: i2c2: softreset failed (waited 10000 usec)
[    0.362457] omap_hwmod: i2c3: softreset failed (waited 10000 usec)
[    0.376159] print_constraints: dummy: 
[    0.381896] NET: Registered protocol family 16
[    0.388214] GPMC revision 5.0
[    0.391510] Trying to install interrupt handler for IRQ402
[    0.397369] Trying to install interrupt handler for IRQ403
[    0.403167] Trying to install interrupt handler for IRQ404
[    0.408905] Trying to install interrupt handler for IRQ405
[    0.414703] Trying to install interrupt handler for IRQ406
[    0.420501] Trying to install interrupt handler for IRQ407
[    0.426330] Trying to install interrupt handler for IRQ408
[    0.432067] Trying to install type control for IRQ409
[    0.437408] Trying to set irq flags for IRQ409
[    0.451568] omap_device: omap_gpio.0: new worst case activate latency 0: 91552
[    0.460113] OMAP GPIO hardware version 2.5
[    0.465179] OMAP GPIO hardware version 2.5
[    0.470092] OMAP GPIO hardware version 2.5
[    0.474945] OMAP GPIO hardware version 2.5
[    0.479858] OMAP GPIO hardware version 2.5
[    0.484771] OMAP GPIO hardware version 2.5
