From: Will Deacon <will.deacon@arm.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Tue, 3 Apr 2012 13:34:45 +0100
Message-ID: <20120403123444.GL17741@mudshark.cambridge.arm.com>
References: <CAMsRxfJe_MEA=anzRu6jehGcZyg49uAx44_nDQ3_FRY=WrFLoA@mail.gmail.com>
 <CACVXFVNXJ2vZM-dAxQPQ5LSOuvv5yvOrnytOB9PxURtkaSCP8w@mail.gmail.com>
 <CACVXFVMH9WZDqs-mVjxL=1FY12uHyQAJMTCQuU5ru1wQT+YnZg@mail.gmail.com>
 <CAMQu2gzW706YbOzHa4Am0=X17T0G3zBhOmWUd8eC6GY9F6OBog@mail.gmail.com>
 <CACVXFVPb-McJj1oi284RW37Pe08cAXSw-jteFwfNVPpCJx5EaQ@mail.gmail.com>
 <CAMQu2gwvgPfZv_LnB6GnYs=Wt+wj9GFPEDYiDK6C8TiTag3gTg@mail.gmail.com>
 <20120403092524.GD17741@mudshark.cambridge.arm.com>
 <CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com>
 <20120403094749.GH17741@mudshark.cambridge.arm.com>
 <CAMQu2gyFirtVTWpMu4G_qG5sq33J-_s_o2JhVAdrUf7P3qJ3AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:56724 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750838Ab2DCMfV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Apr 2012 08:35:21 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gyFirtVTWpMu4G_qG5sq33J-_s_o2JhVAdrUf7P3qJ3AA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Ming Lei <ming.lei@canonical.com>, "eranian@gmail.com" <eranian@gmail.com>, Maynard Johnson <maynardj@us.ibm.com>, Lik Lik <lik88888@gmail.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

On Tue, Apr 03, 2012 at 11:01:53AM +0100, Shilimkar, Santosh wrote:
> On Tue, Apr 3, 2012 at 3:17 PM, Will Deacon <will.deacon@arm.com> wrote:
> > It seems that they're both needed to get reliable PMU operation. Without the
> > CLKDM_CAN_SWSUP fix, no interrupts are generated at all. Without the patch
> > below ([1]), it seems that we don't generate enough. So it looks like we
> > need them both.
> >
> I see. Can you please confirm if it is still the case with [1].

Right, ignore my previous comment, I was using a vanilla 3.3 kernel without
realising and therefore what I thought were PMU/CTI interrupts were actually
just from a timer. Sorry for the confusion.

So I've gone back to basics. Here is a branch containing what I believe
should be all the patches required for the OMAP4 PMU:

git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git perf/omap4

I've omitted the SWSUSP patch since you say it breaks pm, which is clearly not
acceptable.

The problem is, trying to boot this on my pandaboard results in a hang (see
dmesg below). Even worse, the problem isn't easily bisectable since rebuilding
a working image can give you something that no longer boots and I haven't found
a reliable way to cause the lockup.

I'll take JTAG for a whirl to see where we are. If anything looks wrong in
my dmesg, please shout (there are plenty of things in there that look like
they've gone awry).

Will

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.3.0-00005-gcd122ab (will@mudshark) (gcc version 4.5.2 (Ubuntu/Linaro 4.5.2-8ubuntu3) ) #1 SMP Tue Apr 3 13:19:29 BST 2012
[    0.000000] CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: OMAP4 Panda board
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writealloc
[    0.000000] OMAP4430 ES2.1
[    0.000000] PERCPU: Embedded 8 pages/cpu @c1025000 s11072 r8192 d13504 u32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129792
[    0.000000] Kernel command line: console=ttyO2,115200 root=/dev/nfs nfsroot=10.1.79.58:/exports/linaro-11.11,tcp rw earlyprintk ip=dhcp
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Memory: 511MB = 511MB total
[    0.000000] Memory: 506272k/506272k available, 18016k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc05ebf68   (6032 kB)
[    0.000000]       .init : 0xc05ec000 - 0xc0639b40   ( 311 kB)
[    0.000000]       .data : 0xc063a000 - 0xc06c6d50   ( 564 kB)
[    0.000000]        .bss : 0xc06c6d74 - 0xc0c1cb5c   (5464 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:474
[    0.000000] omap_hwmod: dpll_mpu_m2_ck: missing clockdomain for dpll_mpu_m2_ck.
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
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
[    0.056579] Calibrating delay loop... 2007.19 BogoMIPS (lpj=7839744)
[    0.129791] pid_max: default: 32768 minimum: 301
[    0.135192] Security Framework initialized
[    0.139678] Mount-cache hash table entries: 512
[    0.147979] CPU: Testing write buffer coherency: ok
[    0.153961] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.160278] hw perfevents: enabled with ARMv7 Cortex-A9 PMU driver, 7 counters available
[    0.168853] Setting up static identity map for 0x8043ce60 - 0x8043ced0
[    0.175689] L310 cache controller enabled
[    0.179931] l2x0: 16 ways, CACHE_ID 0x410000c4, AUX_CTRL 0x7e470000, Cache size: 1048576 B
[    0.190856] CPU1: Booted secondary processor
[    0.254028] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.254058] CPU1: Unknown IPI message 0x1
[    0.254180] Brought up 2 CPUs
[    0.254180] SMP: Total of 2 processors activated (4022.78 BogoMIPS).
[    0.286102] omap_hwmod: trace_clk_div_ck: missing clockdomain for trace_clk_div_ck.
[    0.294067] omap_hwmod: l3_div_ck: missing clockdomain for l3_div_ck.
[    0.303955] omap_hwmod: l3_instr: _wait_target_disable failed
[    0.322052] omap_hwmod: debugss: softreset failed (waited 10000 usec)
[    0.332824] omap_hwmod: mcpdm: cannot be enabled (3)
[    0.342315] print_constraints: dummy: 
[    0.347137] NET: Registered protocol family 16
[    0.352264] GPMC revision 6.0
[    0.360229] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.366912] OMAP GPIO hardware version 0.1
[    0.371612] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.378662] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.385772] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.392913] gpiochip_add: registered GPIOs 128 to 159 on device: gpio
[    0.400177] gpiochip_add: registered GPIOs 160 to 191 on device: gpio
[    0.410064] omap_mux_init: Add partition: #1: core, flags: 2
[    0.417327] omap_mux_init: Add partition: #2: wkup, flags: 2
[    0.423339] error setting wl12xx data: -38
[    0.430267] _omap_mux_get_by_name: Could not find signal uart1_cts.uart1_cts
[    0.437622] _omap_mux_get_by_name: Could not find signal uart1_cts.uart1_cts
[    0.444946] omap_hwmod_mux_init: Could not allocate device mux entry
[    0.455047]  usbhs_omap: alias fck already exists
[    0.463409] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
[    0.471710] hw-breakpoint: maximum watchpoint size is 4 bytes.

<hangs here. Would usually print something about "OMAP DMA" next>

