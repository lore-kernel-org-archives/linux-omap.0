From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/7] ARM: OMAP2+: hwmod/timer: first set of cleanups for
 3.4
Date: Tue, 31 Jan 2012 09:05:04 +0100
Message-ID: <4F27A0B0.50704@ti.com>
References: <20120130101251.10450.58423.stgit@dusk> <87ty3cpyuk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37514 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab2AaIFf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 03:05:35 -0500
In-Reply-To: <87ty3cpyuk.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Kevin and Paul,

On 1/31/2012 12:14 AM, Kevin Hilman wrote:
> Hi Paul,
>
> Paul Walmsley<paul@pwsan.com>  writes:
>
>> This series does some cleanup and documentation on the OMAP hwmod code
>> (and a bit of the OMAP4 data) and timer code. It is the first
>> prerequisite series to removing a big chunk of hwmod data -- that will
>> be done in a later series.
>>
>> Boot-tested on an OMAP35xx BeagleBoard and OMAP44xx ES2 Pandaboard.
>>
>> This series is also available via git from git://git.pwsan.com/linux-2.6 in
>> the branch "hwmod_code_cleanup_3.4".
>
> FYI... I tested this branch on my 4430ES2.1/Panda and got an infinite
> loop of L3 errors.
>
> I haven't debugged which patch causes the problem, but thought you'd
> like to know.   I did notice that that booting v3.3-rc1, I see
>
> [    0.309478] omap_hwmod: ipu: failed to hardreset
>
> but booting your branch I see a few more reset failures:
>
> [    0.308532] omap_hwmod: dsp: failed to hardreset
> [    0.328979] omap_hwmod: dsp: failed to hardreset
> [    0.358001] omap_hwmod: ipu: failed to hardreset
> [    0.378448] omap_hwmod: ipu: failed to hardreset
> [    0.398895] omap_hwmod: ipu: failed to hardreset
> [    0.427520] omap_hwmod: iva: failed to hardreset
> [    0.447967] omap_hwmod: iva: failed to hardreset

It is becasue the code is iterating over every reset lines present in an 
hwmod now: DSP does have 2 lines, IPU: 3 and IVA should have 3 lines???

> There's a full boot log below.
>
> I noticed you tested on Panda too, but one difference between our setups
> is probably that I'm not using u-boot.  Instead, I'm booting over USB
> using the usbboot tool written by Brian Swetland:
> git://github.com/swetland/omap4boot.git.   It could be that the
> different bootloaders are leaving the other IPs in different states.

Thanks to the L3 log error:
[    0.838439] L3 custom error: MASTER:DucatiM3 TARGET:GPMC

I guess that I understand why I was not releasing the hardreset at boot 
time before:-)

DSP and CortexM3 cannot be released from reset until someone loaded a 
firmware in memory. Otherwise they will start executing some random 
instructions that in this case are trying to access an area that is not 
accessible.

We have to let the driver handle the hardreset because it is mainly used 
for processors.

Sorry Paul for having mislead you here.

Regards,
Benoit


>
> Kevin
>
>
> Uncompressing Linux... done, booting the kernel.
> Warning: Neither atags nor dtb found
> [    0.000000] Booting Linux on physical CPU 0
> [    0.000000] Linux version 3.3.0-rc1-pm+debug+cmdline+panda-00007-g86f3164 (khilman@paris) (gcc version 4.6.1 (Ubuntu/Linaro 4.6.1-9ubuntu3) ) #51 SMP Mon Jan 30 15:00:37 PST 2012
> [    0.000000] CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=10c53c7d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] Machine: OMAP4 Panda board
> [    0.000000] Warning: Neither atags nor dtb found
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] Memory policy: ECC disabled, Data cache writealloc
> [    0.000000] On node 0 totalpages: 116480
> [    0.000000] free_area_init_node: node 0, pgdat c06e96c0, node_mem_map c0c41000
> [    0.000000]   Normal zone: 912 pages used for memmap
> [    0.000000]   Normal zone: 0 pages reserved
> [    0.000000]   Normal zone: 115568 pages, LIFO batch:31
> [    0.000000] OMAP4430 ES2.1
> [    0.000000] PERCPU: Embedded 8 pages/cpu @c0fd9000 s12096 r8192 d12480 u32768
> [    0.000000] pcpu-alloc: s12096 r8192 d12480 u32768 alloc=8*4096
> [    0.000000] pcpu-alloc: [0] 0 [0] 1
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 115568
> [    0.000000] Kernel command line: mem=456M console=ttyO2,115200n8 debug earlyprintk rw ip=dhcp nfsroot=192.168.1.236:/opt/kjh/rootfs/debian/armel,rsize=4096,wsize=4096,nfsvers=3
> [    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> [    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> [    0.000000] Memory: 455MB = 455MB total
> [    0.000000] Memory: 449232k/449232k available, 17712k reserved, 0K highmem
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
> [    0.000000]     vmalloc : 0xdd000000 - 0xff000000   ( 544 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xdc800000   ( 456 MB)
> [    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
> [    0.000000]       .text : 0xc0008000 - 0xc0612a98   (6187 kB)
> [    0.000000]       .init : 0xc0613000 - 0xc0660f40   ( 312 kB)
> [    0.000000]       .data : 0xc0662000 - 0xc06eb0a8   ( 549 kB)
> [    0.000000]        .bss : 0xc06eb0cc - 0xc0c4017c   (5461 kB)
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000] NR_IRQS:410
> [    0.000000] omap_hwmod: dpll_mpu_m2_ck: missing clockdomain for dpll_mpu_m2_ck.
> [    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
> [    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
> [    0.000000] Console: colour dummy device 80x30
> [    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> [    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    0.000000] ... MAX_LOCK_DEPTH:          48
> [    0.000000] ... MAX_LOCKDEP_KEYS:        8191
> [    0.000000] ... CLASSHASH_SIZE:          4096
> [    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
> [    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
> [    0.000000] ... CHAINHASH_SIZE:          16384
> [    0.000000]  memory used by lock dependency info: 3695 kB
> [    0.000000]  per task-struct memory footprint: 1152 bytes
> [    0.056610] Calibrating delay loop... 2007.19 BogoMIPS (lpj=7839744)
> [    0.129852] pid_max: default: 32768 minimum: 301
> [    0.135253] Security Framework initialized
> [    0.139739] Mount-cache hash table entries: 512
> [    0.148162] CPU: Testing write buffer coherency: ok
> [    0.154113] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.160491] Setting up static identity map for 0x804487b0 - 0x80448820
> [    0.167327] L310 cache controller enabled
> [    0.171569] l2x0: 16 ways, CACHE_ID 0x410000c4, AUX_CTRL 0x7e470000, Cache size: 1048576 B
> [    0.182525] CPU1: Booted secondary processor
> [    0.246398] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> [    0.246429] CPU1: Unknown IPI message 0x1
> [    0.246551] Brought up 2 CPUs
> [    0.246582] SMP: Total of 2 processors activated (4022.78 BogoMIPS).
> [    0.277648] ttyO2 used as console in debug mode uart2 clocks will not be gated
> [    0.285247] omap_hwmod: l3_div_ck: missing clockdomain for l3_div_ck.
> [    0.308532] omap_hwmod: dsp: failed to hardreset
> [    0.328979] omap_hwmod: dsp: failed to hardreset
> [    0.336425] omap_hwmod: dsp: cannot be enabled (3)
> [    0.358001] omap_hwmod: ipu: failed to hardreset
> [    0.378417] omap_hwmod: ipu: failed to hardreset
> [    0.398864] omap_hwmod: ipu: failed to hardreset
> [    0.406280] omap_hwmod: ipu: _wait_target_disable failed
> [    0.427459] omap_hwmod: iva: failed to hardreset
> [    0.447906] omap_hwmod: iva: failed to hardreset
> [    0.455505] omap_hwmod: mcpdm: cannot be enabled (3)
> [    0.465301] print_constraints: dummy:
> [    0.470184] NET: Registered protocol family 16
> [    0.475341] GPMC revision 6.0
> [    0.483612] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
> [    0.490325] OMAP GPIO hardware version 0.1
> [    0.494995] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
> [    0.502075] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
> [    0.509155] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
> [    0.516357] gpiochip_add: registered GPIOs 128 to 159 on device: gpio
> [    0.523651] gpiochip_add: registered GPIOs 160 to 191 on device: gpio
> [    0.533355] ------------[ cut here ]------------
> [    0.538177] WARNING: at /work/kernel/omap/pm/arch/arm/mach-omap2/omap_l3_noc.c:113 l3_interrupt_handler+0x134/0x178()
> [    0.549163] L3 custom error: MASTER:DucatiM3 TARGET:GPMC
> [    0.554779] Modules linked in:
> [    0.558013] [<c00141d4>] (unwind_backtrace+0x0/0xf0) from [<c003a0a0>] (warn_slowpath_common+0x4c/0x64)
> [    0.567749] [<c003a0a0>] (warn_slowpath_common+0x4c/0x64) from [<c003a14c>] (warn_slowpath_fmt+0x30/0x40)
> [    0.577667] [<c003a14c>] (warn_slowpath_fmt+0x30/0x40) from [<c002ce0c>] (l3_interrupt_handler+0x134/0x178)
> [    0.587768] [<c002ce0c>] (l3_interrupt_handler+0x134/0x178) from [<c00947a8>] (handle_irq_event_percpu+0x58/0x244)
> [    0.598480] [<c00947a8>] (handle_irq_event_percpu+0x58/0x244) from [<c00949d0>] (handle_irq_event+0x3c/0x5c)
> [    0.608673] [<c00949d0>] (handle_irq_event+0x3c/0x5c) from [<c00973b0>] (handle_fasteoi_irq+0x98/0x140)
> [    0.618408] [<c00973b0>] (handle_fasteoi_irq+0x98/0x140) from [<c0094000>] (generic_handle_irq+0x30/0x48)
> [    0.628326] [<c0094000>] (generic_handle_irq+0x30/0x48) from [<c000e618>] (handle_IRQ+0x4c/0xac)
> [    0.637420] [<c000e618>] (handle_IRQ+0x4c/0xac) from [<c0008654>] (gic_handle_irq+0x24/0xa8)
> [    0.646179] [<c0008654>] (gic_handle_irq+0x24/0xa8) from [<c04435a4>] (__irq_svc+0x44/0x60)
> [    0.654846] Exception stack(0xdc033e30 to 0xdc033e78)
> [    0.660095] 3e20:                                     00000001 00000001 00000000 00000000
> [    0.668579] 3e40: 60000013 c0666114 00000000 c0666114 60000013 0000002a 00000000 0000002a
> [    0.677062] 3e60: 00000490 dc033e78 c0086300 c044328c 20000013 ffffffff
> [    0.683929] [<c04435a4>] (__irq_svc+0x44/0x60) from [<c044328c>] (_raw_spin_unlock_irqrestore+0x34/0x44)
> [    0.693756] [<c044328c>] (_raw_spin_unlock_irqrestore+0x34/0x44) from [<c0095e14>] (__setup_irq+0x348/0x450)
> [    0.703918] [<c0095e14>] (__setup_irq+0x348/0x450) from [<c0095fd4>] (request_threaded_irq+0xb8/0x140)
> [    0.713592] [<c0095fd4>] (request_threaded_irq+0xb8/0x140) from [<c0424f14>] (omap4_l3_probe+0x204/0x29c)
> [    0.723480] [<c0424f14>] (omap4_l3_probe+0x204/0x29c) from [<c0289894>] (platform_drv_probe+0x18/0x1c)
> [    0.733123] [<c0289894>] (platform_drv_probe+0x18/0x1c) from [<c0288520>] (really_probe+0x60/0x15c)
> [    0.742492] [<c0288520>] (really_probe+0x60/0x15c) from [<c0288760>] (driver_probe_device+0x48/0x60)
> [    0.751953] [<c0288760>] (driver_probe_device+0x48/0x60) from [<c028880c>] (__driver_attach+0x94/0x98)
> [    0.761627] [<c028880c>] (__driver_attach+0x94/0x98) from [<c02870c0>] (bus_for_each_dev+0x50/0x7c)
> [    0.770996] [<c02870c0>] (bus_for_each_dev+0x50/0x7c) from [<c0288020>] (bus_add_driver+0x184/0x248)
> [    0.780456] [<c0288020>] (bus_add_driver+0x184/0x248) from [<c0288cdc>] (driver_register+0x78/0x130)
> [    0.789916] [<c0288cdc>] (driver_register+0x78/0x130) from [<c0008818>] (do_one_initcall+0x34/0x178)
> [    0.799377] [<c0008818>] (do_one_initcall+0x34/0x178) from [<c06138ac>] (kernel_init+0x8c/0x130)
> [    0.808502] [<c06138ac>] (kernel_init+0x8c/0x130) from [<c000e870>] (kernel_thread_exit+0x0/0x8)
> [    0.817779] ---[ end trace 1b75b31a2719ed1c ]---
> [    0.822631] ------------[ cut here ]------------
> [    0.827484] WARNING: at /work/kernel/omap/pm/arch/arm/mach-omap2/omap_l3_noc.c:113 l3_interrupt_handler+0x134/0x178()
> [    0.838439] L3 custom error: MASTER:DucatiM3 TARGET:GPMC
> [    0.844055] Modules linked in:
> [    0.847290] [<c00141d4>] (unwind_backtrace+0x0/0xf0) from [<c003a0a0>] (warn_slowpath_common+0x4c/0x64)
> [    0.857025] [<c003a0a0>] (warn_slowpath_common+0x4c/0x64) from [<c003a14c>] (warn_slowpath_fmt+0x30/0x40)
> [    0.866943] [<c003a14c>] (warn_slowpath_fmt+0x30/0x40) from [<c002ce0c>] (l3_interrupt_handler+0x134/0x178)
> [    0.877014] [<c002ce0c>] (l3_interrupt_handler+0x134/0x178) from [<c00947a8>] (handle_irq_event_percpu+0x58/0x244)
> [    0.887725] [<c00947a8>] (handle_irq_event_percpu+0x58/0x244) from [<c00949d0>] (handle_irq_event+0x3c/0x5c)
> [    0.897918] [<c00949d0>] (handle_irq_event+0x3c/0x5c) from [<c00973b0>] (handle_fasteoi_irq+0x98/0x140)
> [    0.907623] [<c00973b0>] (handle_fasteoi_irq+0x98/0x140) from [<c0094000>] (generic_handle_irq+0x30/0x48)
> [    0.917541] [<c0094000>] (generic_handle_irq+0x30/0x48) from [<c000e618>] (handle_IRQ+0x4c/0xac)
> [    0.926635] [<c000e618>] (handle_IRQ+0x4c/0xac) from [<c0008654>] (gic_handle_irq+0x24/0xa8)
> [    0.935394] [<c0008654>] (gic_handle_irq+0x24/0xa8) from [<c04435a4>] (__irq_svc+0x44/0x60)
> [    0.944061] Exception stack(0xdc033d78 to 0xdc033dc0)
> [    0.949310] 3d60:                                                       00000001 00000000
> [    0.957794] 3d80: 00000000 c06fd460 00000202 c0660348 dc032000 0000001d 00000000 0000002a
> [    0.966278] 3da0: 00000000 0000002a 00000000 dc033dc0 c00862bc c0040b84 60000013 ffffffff
> [    0.974761] [<c04435a4>] (__irq_svc+0x44/0x60) from [<c0040b84>] (__do_softirq+0x6c/0x224)
> [    0.983337] [<c0040b84>] (__do_softirq+0x6c/0x224) from [<c00411d4>] (irq_exit+0x94/0x9c)
> [    0.991821] [<c00411d4>] (irq_exit+0x94/0x9c) from [<c000e61c>] (handle_IRQ+0x50/0xac)
> [    1.000030] [<c000e61c>] (handle_IRQ+0x50/0xac) from [<c0008654>] (gic_handle_irq+0x24/0xa8)
> [    1.008789] [<c0008654>] (gic_handle_irq+0x24/0xa8) from [<c04435a4>] (__irq_svc+0x44/0x60)
> [    1.017425] Exception stack(0xdc033e30 to 0xdc033e78)
> [    1.022705] 3e20:                                     00000001 00000001 00000000 00000000
> [    1.031158] 3e40: 60000013 c0666114 00000000 c0666114 60000013 0000002a 00000000 0000002a
> [    1.039642] 3e60: 00000490 dc033e78 c0086300 c044328c 20000013 ffffffff
> [    1.046539] [<c04435a4>] (__irq_svc+0x44/0x60) from [<c044328c>] (_raw_spin_unlock_irqrestore+0x34/0x44)
> [    1.056335] [<c044328c>] (_raw_spin_unlock_irqrestore+0x34/0x44) from [<c0095e14>] (__setup_irq+0x348/0x450)
> [    1.066528] [<c0095e14>] (__setup_irq+0x348/0x450) from [<c0095fd4>] (request_threaded_irq+0xb8/0x140)
> [    1.076171] [<c0095fd4>] (request_threaded_irq+0xb8/0x140) from [<c0424f14>] (omap4_l3_probe+0x204/0x29c)
> [    1.086059] [<c0424f14>] (omap4_l3_probe+0x204/0x29c) from [<c0289894>] (platform_drv_probe+0x18/0x1c)
> [    1.095703] [<c0289894>] (platform_drv_probe+0x18/0x1c) from [<c0288520>] (really_probe+0x60/0x15c)
> [    1.105072] [<c0288520>] (really_probe+0x60/0x15c) from [<c0288760>] (driver_probe_device+0x48/0x60)
> [    1.114532] [<c0288760>] (driver_probe_device+0x48/0x60) from [<c028880c>] (__driver_attach+0x94/0x98)
> [    1.124176] [<c028880c>] (__driver_attach+0x94/0x98) from [<c02870c0>] (bus_for_each_dev+0x50/0x7c)
> [    1.133544] [<c02870c0>] (bus_for_each_dev+0x50/0x7c) from [<c0288020>] (bus_add_driver+0x184/0x248)
> [    1.143005] [<c0288020>] (bus_add_driver+0x184/0x248) from [<c0288cdc>] (driver_register+0x78/0x130)
> [    1.152465] [<c0288cdc>] (driver_register+0x78/0x130) from [<c0008818>] (do_one_initcall+0x34/0x178)
> [    1.161926] [<c0008818>] (do_one_initcall+0x34/0x178) from [<c06138ac>] (kernel_init+0x8c/0x130)
> [    1.171051] [<c06138ac>] (kernel_init+0x8c/0x130) from [<c000e870>] (kernel_thread_exit+0x0/0x8)
> [    1.180145] ---[ end trace 1b75b31a2719ed1d ]---
> [    1.185028] ------------[ cut here ]------------
> [    1.189849] WARNING: at /work/kernel/omap/pm/arch/arm/mach-omap2/omap_l3_noc.c:113 l3_interrupt_handler+0x134/0x178()
> [    1.200836] L3 custom error: MASTER:DucatiM3 TARGET:GPMC
> [    1.206451] Modules linked in:
> [    1.209655] [<c00141d4>] (unwind_backtrace+0x0/0xf0) from [<c003a0a0>] (warn_slowpath_common+0x4c/0x64)
> [    1.219390] [<c003a0a0>] (warn_slowpath_common+0x4c/0x64) from [<c003a14c>] (warn_slowpath_fmt+0x30/0x40)
> [    1.229309] [<c003a14c>] (warn_slowpath_fmt+0x30/0x40) from [<c002ce0c>] (l3_interrupt_handler+0x134/0x178)
> [    1.239410] [<c002ce0c>] (l3_interrupt_handler+0x134/0x178) from [<c00947a8>] (handle_irq_event_percpu+0x58/0x244)
> [    1.250122] [<c00947a8>] (handle_irq_event_percpu+0x58/0x244) from [<c00949d0>] (handle_irq_event+0x3c/0x5c)
> [    1.260284] [<c00949d0>] (handle_irq_event+0x3c/0x5c) from [<c00973b0>] (handle_fasteoi_irq+0x98/0x140)
> [    1.270019] [<c00973b0>] (handle_fasteoi_irq+0x98/0x140) from [<c0094000>] (generic_handle_irq+0x30/0x48)
> [    1.279937] [<c0094000>] (generic_handle_irq+0x30/0x48) from [<c000e618>] (handle_IRQ+0x4c/0xac)
> [    1.289031] [<c000e618>] (handle_IRQ+0x4c/0xac) from [<c0008654>] (gic_handle_irq+0x24/0xa8)
> [    1.297760] [<c0008654>] (gic_handle_irq+0x24/0xa8) from [<c04435a4>] (__irq_svc+0x44/0x60)
> [    1.306427] Exception stack(0xdc033d78 to 0xdc033dc0)
> [    1.311706] 3d60:                                                       00000001 00000000
> [    1.320159] 3d80: 00000000 c06fd460 00000202 c0660348 dc032000 0000001d 00000000 0000002a
> [    1.328643] 3da0: 00000000 0000002a 00000000 dc033dc0 c00862bc c0040b84 60000013 ffffffff
> [    1.337127] [<c04435a4>] (__irq_svc+0x44/0x60) from [<c0040b84>] (__do_softirq+0x6c/0x224)
> [    1.345703] [<c0040b84>] (__do_softirq+0x6c/0x224) from [<c00411d4>] (irq_exit+0x94/0x9c)
> [    1.354187] [<c00411d4>] (irq_exit+0x94/0x9c) from [<c000e61c>] (handle_IRQ+0x50/0xac)
> [    1.362396] [<c000e61c>] (handle_IRQ+0x50/0xac) from [<c0008654>] (gic_handle_irq+0x24/0xa8)
> [    1.371154] [<c0008654>] (gic_handle_irq+0x24/0xa8) from [<c04435a4>] (__irq_svc+0x44/0x60)
> [    1.379791] Exception stack(0xdc033e30 to 0xdc033e78)
> [    1.385070] 3e20:                                     00000001 00000001 00000000 00000000
> [    1.393554] 3e40: 60000013 c0666114 00000000 c0666114 60000013 0000002a 00000000 0000002a
> [    1.402008] 3e60: 00000490 dc033e78 c0086300 c044328c 20000013 ffffffff
> [    1.408905] [<c04435a4>] (__irq_svc+0x44/0x60) from [<c044328c>] (_raw_spin_unlock_irqrestore+0x34/0x44)
> [    1.418701] [<c044328c>] (_raw_spin_unlock_irqrestore+0x34/0x44) from [<c0095e14>] (__setup_irq+0x348/0x450)
> [    1.428894] [<c0095e14>] (__setup_irq+0x348/0x450) from [<c0095fd4>] (request_threaded_irq+0xb8/0x140)
> [    1.438537] [<c0095fd4>] (request_threaded_irq+0xb8/0x140) from [<c0424f14>] (omap4_l3_probe+0x204/0x29c)
> [    1.448425] [<c0424f14>] (omap4_l3_probe+0x204/0x29c) from [<c0289894>] (platform_drv_probe+0x18/0x1c)
> [    1.458068] [<c0289894>] (platform_drv_probe+0x18/0x1c) from [<c0288520>] (really_probe+0x60/0x15c)
> [    1.467437] [<c0288520>] (really_probe+0x60/0x15c) from [<c0288760>] (driver_probe_device+0x48/0x60)
> [    1.476898] [<c0288760>] (driver_probe_device+0x48/0x60) from [<c028880c>] (__driver_attach+0x94/0x98)
> [    1.486541] [<c028880c>] (__driver_attach+0x94/0x98) from [<c02870c0>] (bus_for_each_dev+0x50/0x7c)
> [    1.495910] [<c02870c0>] (bus_for_each_dev+0x50/0x7c) from [<c0288020>] (bus_add_driver+0x184/0x248)
> [    1.505371] [<c0288020>] (bus_add_driver+0x184/0x248) from [<c0288cdc>] (driver_register+0x78/0x130)
> [    1.514831] [<c0288cdc>] (driver_register+0x78/0x130) from [<c0008818>] (do_one_initcall+0x34/0x178)
> [    1.524291] [<c0008818>] (do_one_initcall+0x34/0x178) from [<c06138ac>] (kernel_init+0x8c/0x130)
> [    1.533416] [<c06138ac>] (kernel_init+0x8c/0x130) from [<c000e870>] (kernel_thread_exit+0x0/0x8)
> [    1.542510] ---[ end trace 1b75b31a2719ed1e ]---
> [    1.547332] ------------[ cut here ]------------
>
> ... and it continues forever.
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

