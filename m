From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: 3.11-rc1: OMAP3630 boot crash
Date: Thu, 25 Jul 2013 01:57:24 +0300
Message-ID: <20130724225724.GC26943@blackmetal.musicnaut.iki.fi>
References: <20130716165834.GH3296@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:44762 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708Ab3GXW5d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jul 2013 18:57:33 -0400
Content-Disposition: inline
In-Reply-To: <20130716165834.GH3296@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Tue, Jul 16, 2013 at 07:58:34PM +0300, Aaro Koskinen wrote:
> I get the following boot crash on N950/RM-680 (3630) with unpatched
> 3.11-rc1. The crash looks specific to 3630 (it happens during
> omap3630_init_late), also the same kernel binary works with N900/RX-51
> (3430). You can find the .config after the crash.

I put a debug print to _omap_hwmod_mux_handle_irq
(omap_hwmod_mux_scan_wakeups), and it seems when the crash happens the
pad name is always "uart3_rx_irrx.uart3_rx_irrx". I made another hack
and just "continue" if the pad name is this, and the crash is gone.

Any ideas?

A.

> [    2.386718] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa008fa3
> [    2.394836] Internal error: : 1028 [#1] ARM
> [    2.399261] Modules linked in:
> [    2.402465] CPU: 0 PID: 1 Comm: swapper Not tainted 3.11.0-rc1-n9xx #5
> [    2.409362] task: ef04c000 ti: ef050000 task.ti: ef050000
> [    2.415069] PC is at do_alignment_ldrhstrh+0x38/0xd0
> [    2.420288] LR is at do_alignment+0x2f8/0x76c
> [    2.424896] pc : [<c0019038>]    lr : [<c0019a64>]    psr: 00000193
> [    2.424896] sp : ef051ad8  ip : 00000003  fp : ef051aec
> [    2.436981] r10: 00000004  r9 : c0be5d44  r8 : 00000001
> [    2.442504] r7 : fa008fa3  r6 : c001d25c  r5 : 00000003  r4 : 00000001
> [    2.449371] r3 : 00000000  r2 : ef051c70  r1 : e1d230b0  r0 : fa008fa3
> [    2.456237] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> [    2.464019] Control: 10c5387d  Table: af288019  DAC: 00000015
> [    2.470092] Process swapper (pid: 1, stack limit = 0xef050238)
> [    2.476226] Stack: (0xef051ad8 to 0xef052000)
> [    2.480834] 1ac0:                                                       00000000 ef051c70
> [    2.489440] 1ae0: ef051bbc ef051af0 c0019a64 c001900c ef04c000 ef050000 00000000 ef04ed80
> [    2.498077] 1b00: ef051b24 ef051b10 c0330000 e1d230b0 00000000 ef04c000 ef051b3c ef051b28
> [    2.506683] 1b20: ffffffff ef04c000 ef051b64 ef051b38 c00657fc c003006c c00657b8 ef04c000
> [    2.515319] 1b40: 00000001 c0bcd3b0 c0bcd3b0 c0bcd3b0 c033d3b0 ef04c15c ef051b74 ef04c030
> [    2.523956] 1b60: 00000001 ef04c030 00000001 c0bcd3b0 ffffffff 00000000 ef051bac ef051b88
> [    2.532562] 1b80: c03377bc c00096b8 ffffffff ef06a01c ef04c000 00000001 c001976c c0bb7784
> [    2.541198] 1ba0: fa008fa3 ef051c70 c0be59d6 c0bc3d54 ef051c6c ef051bc0 c0008474 c0019778
> [    2.549804] 1bc0: ffffffff ef04c000 c0bcd3b0 ef050000 ef051c74 ef051be0 c0334a24 c0056fd8
> [    2.558441] 1be0: ef04da30 c0bcd3b0 c0bcd3b0 ef04da00 ef04c000 ef04da30 ef051c3c c0334d3c
> [    2.567047] 1c00: c005a4bc c0059b5c 00000000 00002e7b 00000000 c033d3b0 ef04c000 c0bcd3b0
> [    2.575683] 1c20: 00000000 00000001 c0400e74 ef01d000 ef051c5c ef051c40 c0057504 c005a3dc
> [    2.584320] 1c40: 0000008d ef04da00 60000093 c001d25c 60000193 ffffffff ef051ca4 00000001
> [    2.592926] 1c60: ef051cdc ef051c70 c0335bd8 c0008444 c0bc5098 00000004 fa008fa3 00006f73
> [    2.601562] 1c80: 00000000 ef0c7f00 c0bc5098 00000000 00000001 c0be59d6 c0bc3d54 ef051cdc
> [    2.610168] 1ca0: 00000000 ef051cb8 c0022440 c001d260 60000193 ffffffff c0bc5098 c0bb86f0
> [    2.618804] 1cc0: c001d17c 00000000 0000013b ef0cee00 ef051cfc ef051ce0 c0022440 c001d188
> [    2.627441] 1ce0: ef264bc0 00000020 00000000 00000000 ef051d0c ef051d00 c001d174 c0022414
> [    2.636077] 1d00: ef051d44 ef051d10 c0071e44 c001d164 ef263700 c00ffa98 ef263700 ef0cee00
> [    2.644683] 1d20: 00000020 ef051d98 c0be66f0 ef004d80 ef051d90 ef00803c ef051d5c ef051d48
> [    2.653320] 1d40: c0071fd8 c0071dfc 00020000 ef0cee00 ef051d74 ef051d60 c0074254 c0071fb4
> [    2.661926] 1d60: c00741cc 0000013b ef051d8c ef051d78 c007174c c00741d8 c0bb88e4 00000009
> [    2.670562] 1d80: ef051dcc ef051d90 c002543c c0071730 00000000 00000000 00000200 0000001b
> [    2.679168] 1da0: ef051dbc 0000001b 0000001b 00000000 0000001b c0447250 ef050000 c0467538
> [    2.687805] 1dc0: ef051de4 ef051dd0 c007174c c0025374 00000174 c0bd16fc ef051e04 ef051de8
> [    2.696411] 1de0: c000f5a0 c0071730 00000060 fa200000 ef051e28 c0be6510 ef051e24 ef051e08
> [    2.705047] 1e00: c0008648 c000f574 c04503a4 60000013 ffffffff ef051e5c ef051e9c ef051e28
> [    2.713684] 1e20: c0335c40 c00085f4 ef0cee00 60000013 00000001 00000000 00000000 00000000
> [    2.722290] 1e40: c0be6708 0000005e c0447250 ef050000 c0467538 ef051e9c ef051e50 ef051e70
> [    2.730926] 1e60: c0072ae0 c04503a4 60000013 ffffffff c03ec738 c04500e8 c046fdac 00000007
> [    2.739532] 1e80: c0be5a80 0000005e c0447250 c0467538 ef051eac ef051ea0 c044bc0c c04500f4
> [    2.748168] 1ea0: ef051ebc ef051eb0 c0447274 c044bc04 ef051f4c ef051ec0 c0008888 c044725c
> [    2.756774] 1ec0: 0000006f c0443628 00000000 00000000 ef051efc ef051ee0 ef051f04 ef051ee8
> [    2.765411] 1ee0: c0445100 c0179c6c c04451b0 c14ffb15 c034e32c 0000005e ef051f4c ef051f08
> [    2.774017] 1f00: c004de50 c04451bc c0467510 00000007 00000007 c0443048 00000000 c03e57c8
> [    2.782653] 1f20: ef051f4c c046fdac 00000007 c0be5a80 0000005e c04451b0 c0467530 c0467538
> [    2.791259] 1f40: ef051f94 ef051f50 c044592c c00087a0 00000007 00000007 c04451b0 ffffffff
> [    2.799896] 1f60: ffffffff ffffffff ffffffff 00000000 c032e434 00000000 00000000 00000000
> [    2.808532] 1f80: 00000000 00000000 ef051fac ef051f98 c032e444 c0445848 00000000 00000000
> [    2.817138] 1fa0: 00000000 ef051fb0 c000e738 c032e440 00000000 00000000 00000000 00000000
> [    2.825775] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    2.834411] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 ffffffff ffffffff
> [    2.843017] Backtrace: 
> [    2.845611] [<c0019000>] (do_alignment_ldrhstrh+0x0/0xd0) from [<c0019a64>] (do_alignment+0x2f8/0x76c)
> [    2.855407]  r5:ef051c70 r4:00000000
> [    2.859222] [<c001976c>] (do_alignment+0x0/0x76c) from [<c0008474>] (do_DataAbort+0x3c/0xa0)
> [    2.868103] [<c0008438>] (do_DataAbort+0x0/0xa0) from [<c0335bd8>] (__dabt_svc+0x38/0x60)
> [    2.876739] Exception stack(0xef051c70 to 0xef051cb8)
> [    2.882049] 1c60:                                     c0bc5098 00000004 fa008fa3 00006f73
> [    2.890686] 1c80: 00000000 ef0c7f00 c0bc5098 00000000 00000001 c0be59d6 c0bc3d54 ef051cdc
> [    2.899322] 1ca0: 00000000 ef051cb8 c0022440 c001d260 60000193 ffffffff
> [    2.906249]  r8:00000001 r7:ef051ca4 r6:ffffffff r5:60000193 r4:c001d25c
> [    2.913360] [<c001d17c>] (_omap_hwmod_mux_handle_irq+0x0/0x110) from [<c0022440>] (omap_hwmod_for_each+0x38/0x64)
> [    2.924194] [<c0022408>] (omap_hwmod_for_each+0x0/0x64) from [<c001d174>] (omap_hwmod_mux_handle_irq+0x1c/0x24)
> [    2.934814]  r7:00000000 r6:00000000 r5:00000020 r4:ef264bc0
> [    2.940795] [<c001d158>] (omap_hwmod_mux_handle_irq+0x0/0x24) from [<c0071e44>] (handle_irq_event_percpu+0x54/0x1b8)
> [    2.951904] [<c0071df0>] (handle_irq_event_percpu+0x0/0x1b8) from [<c0071fd8>] (handle_irq_event+0x30/0x40)
> [    2.962158] [<c0071fa8>] (handle_irq_event+0x0/0x40) from [<c0074254>] (handle_level_irq+0x88/0xdc)
> [    2.971679]  r4:ef0cee00 r3:00020000
> [    2.975463] [<c00741cc>] (handle_level_irq+0x0/0xdc) from [<c007174c>] (generic_handle_irq+0x28/0x38)
> [    2.985198]  r4:0000013b r3:c00741cc
> [    2.988983] [<c0071724>] (generic_handle_irq+0x0/0x38) from [<c002543c>] (omap_prcm_irq_handler+0xd4/0x1bc)
> [    2.999237]  r4:00000009 r3:c0bb88e4
> [    3.003021] [<c0025368>] (omap_prcm_irq_handler+0x0/0x1bc) from [<c007174c>] (generic_handle_irq+0x28/0x38)
> [    3.013305] [<c0071724>] (generic_handle_irq+0x0/0x38) from [<c000f5a0>] (handle_IRQ+0x38/0x8c)
> [    3.022460]  r4:c0bd16fc r3:00000174
> [    3.026245] [<c000f568>] (handle_IRQ+0x0/0x8c) from [<c0008648>] (omap3_intc_handle_irq+0x60/0x70)
> [    3.035675]  r6:c0be6510 r5:ef051e28 r4:fa200000 r3:00000060
> [    3.041687] [<c00085e8>] (omap3_intc_handle_irq+0x0/0x70) from [<c0335c40>] (__irq_svc+0x40/0x50)
> [    3.051025] Exception stack(0xef051e28 to 0xef051e70)
> [    3.056335] 1e20:                   ef0cee00 60000013 00000001 00000000 00000000 00000000
> [    3.064971] 1e40: c0be6708 0000005e c0447250 ef050000 c0467538 ef051e9c ef051e50 ef051e70
> [    3.073577] 1e60: c0072ae0 c04503a4 60000013 ffffffff
> [    3.078918]  r7:ef051e5c r6:ffffffff r5:60000013 r4:c04503a4
> [    3.084899] [<c04500e8>] (omap3_pm_init+0x0/0x580) from [<c044bc0c>] (omap3630_init_late+0x14/0x1c)
> [    3.094451] [<c044bbf8>] (omap3630_init_late+0x0/0x1c) from [<c0447274>] (init_machine_late+0x24/0x30)
> [    3.104278] [<c0447250>] (init_machine_late+0x0/0x30) from [<c0008888>] (do_one_initcall+0xf4/0x150)
> [    3.113891] [<c0008794>] (do_one_initcall+0x0/0x150) from [<c044592c>] (kernel_init_freeable+0xf0/0x1b4)
> [    3.123901] [<c044583c>] (kernel_init_freeable+0x0/0x1b4) from [<c032e444>] (kernel_init+0x10/0xec)
> [    3.133453] [<c032e434>] (kernel_init+0x0/0xec) from [<c000e738>] (ret_from_fork+0x14/0x3c)
> [    3.142242]  r4:00000000 r3:00000000
> [    3.145996] Code: 0a00000d e2113601 0a00001d e3a03000 (e4d0c001) 
> [    3.152465] ---[ end trace d67e354272cd1bba ]---
> [    3.157348] Kernel panic - not syncing: Fatal exception in interrupt
> 
> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/arm 3.11.0-rc1 Kernel Configuration
> #
> CONFIG_ARM=y
> CONFIG_SYS_SUPPORTS_APM_EMULATION=y
> CONFIG_HAVE_PROC_CPU=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_HAVE_LATENCYTOP_SUPPORT=y
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> CONFIG_RWSEM_GENERIC_SPINLOCK=y
> CONFIG_ARCH_HAS_CPUFREQ=y
> CONFIG_ARCH_HAS_BANDGAP=y
> CONFIG_GENERIC_HWEIGHT=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_NEED_DMA_MAP_STATE=y
> CONFIG_VECTORS_BASE=0xffff0000
> CONFIG_ARM_PATCH_PHYS_VIRT=y
> CONFIG_GENERIC_BUG=y
> CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
> CONFIG_IRQ_WORK=y
> CONFIG_BUILDTIME_EXTABLE_SORT=y
> 
> #
> # General setup
> #
> CONFIG_BROKEN_ON_SMP=y
> CONFIG_INIT_ENV_ARG_LIMIT=32
> CONFIG_CROSS_COMPILE=""
> # CONFIG_COMPILE_TEST is not set
> CONFIG_LOCALVERSION="-n9xx"
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_HAVE_KERNEL_GZIP=y
> CONFIG_HAVE_KERNEL_LZMA=y
> CONFIG_HAVE_KERNEL_XZ=y
> CONFIG_HAVE_KERNEL_LZO=y
> CONFIG_HAVE_KERNEL_LZ4=y
> # CONFIG_KERNEL_GZIP is not set
> CONFIG_KERNEL_LZMA=y
> # CONFIG_KERNEL_XZ is not set
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> CONFIG_DEFAULT_HOSTNAME="(none)"
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> # CONFIG_POSIX_MQUEUE is not set
> # CONFIG_FHANDLE is not set
> # CONFIG_AUDIT is not set
> CONFIG_HAVE_GENERIC_HARDIRQS=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_HARDIRQS=y
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_HARDIRQS_SW_RESEND=y
> CONFIG_GENERIC_IRQ_CHIP=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_SPARSE_IRQ=y
> CONFIG_KTIME_SCALAR=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
> 
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ_COMMON=y
> # CONFIG_HZ_PERIODIC is not set
> CONFIG_NO_HZ_IDLE=y
> CONFIG_NO_HZ=y
> CONFIG_HIGH_RES_TIMERS=y
> 
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_TICK_CPU_ACCOUNTING=y
> # CONFIG_IRQ_TIME_ACCOUNTING is not set
> CONFIG_BSD_PROCESS_ACCT=y
> # CONFIG_BSD_PROCESS_ACCT_V3 is not set
> # CONFIG_TASKSTATS is not set
> 
> #
> # RCU Subsystem
> #
> CONFIG_TINY_RCU=y
> # CONFIG_PREEMPT_RCU is not set
> # CONFIG_RCU_STALL_COMMON is not set
> # CONFIG_TREE_RCU_TRACE is not set
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> CONFIG_LOG_BUF_SHIFT=20
> CONFIG_GENERIC_SCHED_CLOCK=y
> # CONFIG_CGROUPS is not set
> # CONFIG_CHECKPOINT_RESTORE is not set
> # CONFIG_NAMESPACES is not set
> CONFIG_UIDGID_CONVERTED=y
> # CONFIG_UIDGID_STRICT_TYPE_CHECKS is not set
> # CONFIG_SCHED_AUTOGROUP is not set
> # CONFIG_SYSFS_DEPRECATED is not set
> # CONFIG_RELAY is not set
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> # CONFIG_RD_GZIP is not set
> # CONFIG_RD_BZIP2 is not set
> # CONFIG_RD_LZMA is not set
> # CONFIG_RD_XZ is not set
> # CONFIG_RD_LZO is not set
> # CONFIG_RD_LZ4 is not set
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_SYSCTL=y
> CONFIG_ANON_INODES=y
> CONFIG_HAVE_UID16=y
> CONFIG_EXPERT=y
> CONFIG_UID16=y
> # CONFIG_SYSCTL_SYSCALL is not set
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> CONFIG_PRINTK=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> CONFIG_SHMEM=y
> CONFIG_AIO=y
> # CONFIG_EMBEDDED is not set
> CONFIG_HAVE_PERF_EVENTS=y
> CONFIG_PERF_USE_VMALLOC=y
> 
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=y
> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> CONFIG_VM_EVENT_COUNTERS=y
> CONFIG_SLUB_DEBUG=y
> CONFIG_COMPAT_BRK=y
> # CONFIG_SLAB is not set
> CONFIG_SLUB=y
> # CONFIG_SLOB is not set
> CONFIG_SLUB_CPU_PARTIAL=y
> CONFIG_PROFILING=y
> CONFIG_OPROFILE=y
> CONFIG_HAVE_OPROFILE=y
> CONFIG_KPROBES=y
> # CONFIG_JUMP_LABEL is not set
> # CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
> CONFIG_KRETPROBES=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_ATTRS=y
> CONFIG_HAVE_DMA_CONTIGUOUS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_GENERIC_IDLE_POLL_SETUP=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_CLK=y
> CONFIG_HAVE_DMA_API_DEBUG=y
> CONFIG_HAVE_HW_BREAKPOINT=y
> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> CONFIG_HAVE_CONTEXT_TRACKING=y
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> CONFIG_MODULES_USE_ELF_REL=y
> CONFIG_CLONE_BACKWARDS=y
> CONFIG_OLD_SIGSUSPEND3=y
> CONFIG_OLD_SIGACTION=y
> 
> #
> # GCOV-based kernel profiling
> #
> CONFIG_HAVE_GENERIC_DMA_COHERENT=y
> CONFIG_SLABINFO=y
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=0
> CONFIG_MODULES=y
> CONFIG_MODULE_FORCE_LOAD=y
> CONFIG_MODULE_UNLOAD=y
> CONFIG_MODULE_FORCE_UNLOAD=y
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> # CONFIG_MODULE_SIG is not set
> CONFIG_BLOCK=y
> CONFIG_LBDAF=y
> # CONFIG_BLK_DEV_BSG is not set
> # CONFIG_BLK_DEV_BSGLIB is not set
> # CONFIG_BLK_DEV_INTEGRITY is not set
> 
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=y
> # CONFIG_ACORN_PARTITION is not set
> # CONFIG_AIX_PARTITION is not set
> # CONFIG_OSF_PARTITION is not set
> # CONFIG_AMIGA_PARTITION is not set
> # CONFIG_ATARI_PARTITION is not set
> # CONFIG_MAC_PARTITION is not set
> CONFIG_MSDOS_PARTITION=y
> # CONFIG_BSD_DISKLABEL is not set
> # CONFIG_MINIX_SUBPARTITION is not set
> # CONFIG_SOLARIS_X86_PARTITION is not set
> # CONFIG_UNIXWARE_DISKLABEL is not set
> # CONFIG_LDM_PARTITION is not set
> # CONFIG_SGI_PARTITION is not set
> # CONFIG_ULTRIX_PARTITION is not set
> # CONFIG_SUN_PARTITION is not set
> # CONFIG_KARMA_PARTITION is not set
> CONFIG_EFI_PARTITION=y
> # CONFIG_SYSV68_PARTITION is not set
> 
> #
> # IO Schedulers
> #
> CONFIG_IOSCHED_NOOP=y
> # CONFIG_IOSCHED_DEADLINE is not set
> CONFIG_IOSCHED_CFQ=y
> CONFIG_DEFAULT_CFQ=y
> # CONFIG_DEFAULT_NOOP is not set
> CONFIG_DEFAULT_IOSCHED="cfq"
> CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
> CONFIG_INLINE_READ_UNLOCK=y
> CONFIG_INLINE_READ_UNLOCK_IRQ=y
> CONFIG_INLINE_WRITE_UNLOCK=y
> CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
> CONFIG_FREEZER=y
> 
> #
> # System Type
> #
> CONFIG_MMU=y
> CONFIG_ARCH_MULTIPLATFORM=y
> # CONFIG_ARCH_INTEGRATOR is not set
> # CONFIG_ARCH_REALVIEW is not set
> # CONFIG_ARCH_VERSATILE is not set
> # CONFIG_ARCH_AT91 is not set
> # CONFIG_ARCH_CLPS711X is not set
> # CONFIG_ARCH_GEMINI is not set
> # CONFIG_ARCH_EBSA110 is not set
> # CONFIG_ARCH_EP93XX is not set
> # CONFIG_ARCH_FOOTBRIDGE is not set
> # CONFIG_ARCH_NETX is not set
> # CONFIG_ARCH_IOP13XX is not set
> # CONFIG_ARCH_IOP32X is not set
> # CONFIG_ARCH_IOP33X is not set
> # CONFIG_ARCH_IXP4XX is not set
> # CONFIG_ARCH_DOVE is not set
> # CONFIG_ARCH_KIRKWOOD is not set
> # CONFIG_ARCH_MV78XX0 is not set
> # CONFIG_ARCH_ORION5X is not set
> # CONFIG_ARCH_MMP is not set
> # CONFIG_ARCH_KS8695 is not set
> # CONFIG_ARCH_W90X900 is not set
> # CONFIG_ARCH_LPC32XX is not set
> # CONFIG_ARCH_PXA is not set
> # CONFIG_ARCH_MSM is not set
> # CONFIG_ARCH_SHMOBILE is not set
> # CONFIG_ARCH_RPC is not set
> # CONFIG_ARCH_SA1100 is not set
> # CONFIG_ARCH_S3C24XX is not set
> # CONFIG_ARCH_S3C64XX is not set
> # CONFIG_ARCH_S5P64X0 is not set
> # CONFIG_ARCH_S5PC100 is not set
> # CONFIG_ARCH_S5PV210 is not set
> # CONFIG_ARCH_EXYNOS is not set
> # CONFIG_ARCH_SHARK is not set
> # CONFIG_ARCH_DAVINCI is not set
> # CONFIG_ARCH_OMAP1 is not set
> 
> #
> # Multiple platform selection
> #
> 
> #
> # CPU Core family selection
> #
> # CONFIG_ARCH_MULTI_V6 is not set
> CONFIG_ARCH_MULTI_V7=y
> CONFIG_ARCH_MULTI_V6_V7=y
> # CONFIG_ARCH_MULTI_CPU_AUTO is not set
> # CONFIG_ARCH_MVEBU is not set
> # CONFIG_ARCH_BCM is not set
> # CONFIG_GPIO_PCA953X is not set
> # CONFIG_KEYBOARD_GPIO_POLLED is not set
> # CONFIG_ARCH_HIGHBANK is not set
> # CONFIG_ARCH_KEYSTONE is not set
> # CONFIG_ARCH_MXC is not set
> 
> #
> # TI OMAP Common Features
> #
> 
> #
> # OMAP Feature Selections
> #
> CONFIG_OMAP_RESET_CLOCKS=y
> CONFIG_OMAP_MUX=y
> CONFIG_OMAP_MUX_DEBUG=y
> CONFIG_OMAP_MUX_WARNINGS=y
> CONFIG_OMAP_32K_TIMER=y
> # CONFIG_OMAP3_L2_AUX_SECURE_SAVE_RESTORE is not set
> CONFIG_OMAP_DM_TIMER=y
> CONFIG_OMAP_PM_NOOP=y
> # CONFIG_MACH_OMAP_GENERIC is not set
> CONFIG_ARCH_OMAP=y
> CONFIG_ARCH_OMAP3=y
> # CONFIG_ARCH_OMAP4 is not set
> # CONFIG_SOC_OMAP5 is not set
> # CONFIG_SOC_AM33XX is not set
> # CONFIG_SOC_AM43XX is not set
> CONFIG_ARCH_OMAP2PLUS=y
> 
> #
> # TI OMAP2/3/4 Specific Features
> #
> CONFIG_ARCH_OMAP2PLUS_TYPICAL=y
> CONFIG_SOC_HAS_OMAP2_SDRC=y
> CONFIG_SOC_OMAP3430=y
> # CONFIG_SOC_TI81XX is not set
> CONFIG_OMAP_PACKAGE_CBB=y
> 
> #
> # OMAP Board Type
> #
> # CONFIG_MACH_OMAP3_BEAGLE is not set
> # CONFIG_MACH_DEVKIT8000 is not set
> # CONFIG_MACH_OMAP_LDP is not set
> # CONFIG_MACH_OMAP3530_LV_SOM is not set
> # CONFIG_MACH_OMAP3_TORPEDO is not set
> # CONFIG_MACH_OVERO is not set
> # CONFIG_MACH_OMAP3EVM is not set
> # CONFIG_MACH_OMAP3517EVM is not set
> # CONFIG_MACH_CRANEBOARD is not set
> # CONFIG_MACH_OMAP3_PANDORA is not set
> # CONFIG_MACH_TOUCHBOOK is not set
> # CONFIG_MACH_OMAP_3430SDP is not set
> CONFIG_MACH_NOKIA_RM680=y
> CONFIG_MACH_NOKIA_RX51=y
> # CONFIG_MACH_OMAP_ZOOM2 is not set
> # CONFIG_MACH_OMAP_ZOOM3 is not set
> # CONFIG_MACH_CM_T35 is not set
> # CONFIG_MACH_CM_T3517 is not set
> # CONFIG_MACH_IGEP0020 is not set
> # CONFIG_MACH_IGEP0030 is not set
> # CONFIG_MACH_SBC3530 is not set
> # CONFIG_MACH_OMAP_3630SDP is not set
> # CONFIG_OMAP3_EMU is not set
> # CONFIG_OMAP3_SDRC_AC_TIMING is not set
> # CONFIG_ARCH_ROCKCHIP is not set
> # CONFIG_ARCH_SOCFPGA is not set
> # CONFIG_PLAT_SPEAR is not set
> # CONFIG_ARCH_STI is not set
> # CONFIG_ARCH_SUNXI is not set
> # CONFIG_ARCH_SIRF is not set
> # CONFIG_ARCH_TEGRA is not set
> 
> #
> # ST-Ericsson AB U300/U335 Platform
> #
> 
> #
> # ST-Ericsson Mobile Platform Products
> #
> 
> #
> # ST-Ericsson U300/U335 Feature Selections
> #
> # CONFIG_ARCH_U8500 is not set
> # CONFIG_ARCH_VEXPRESS is not set
> # CONFIG_ARCH_VIRT is not set
> # CONFIG_ARCH_WM8850 is not set
> # CONFIG_ARCH_ZYNQ is not set
> 
> #
> # Processor Type
> #
> CONFIG_CPU_V7=y
> CONFIG_CPU_32v6K=y
> CONFIG_CPU_32v7=y
> CONFIG_CPU_ABRT_EV7=y
> CONFIG_CPU_PABRT_V7=y
> CONFIG_CPU_CACHE_V7=y
> CONFIG_CPU_CACHE_VIPT=y
> CONFIG_CPU_COPY_V6=y
> CONFIG_CPU_TLB_V7=y
> CONFIG_CPU_HAS_ASID=y
> CONFIG_CPU_CP15=y
> CONFIG_CPU_CP15_MMU=y
> 
> #
> # Processor Features
> #
> # CONFIG_ARM_LPAE is not set
> # CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
> CONFIG_ARM_THUMB=y
> CONFIG_ARM_THUMBEE=y
> CONFIG_ARM_VIRT_EXT=y
> # CONFIG_SWP_EMULATE is not set
> # CONFIG_CPU_ICACHE_DISABLE is not set
> # CONFIG_CPU_DCACHE_DISABLE is not set
> # CONFIG_CPU_BPREDICT_DISABLE is not set
> # CONFIG_CACHE_L2X0 is not set
> CONFIG_ARM_L1_CACHE_SHIFT_6=y
> CONFIG_ARM_L1_CACHE_SHIFT=6
> CONFIG_ARM_DMA_MEM_BUFFERABLE=y
> CONFIG_ARM_NR_BANKS=8
> CONFIG_MULTI_IRQ_HANDLER=y
> # CONFIG_ARM_ERRATA_430973 is not set
> # CONFIG_ARM_ERRATA_720789 is not set
> # CONFIG_ARM_ERRATA_754322 is not set
> # CONFIG_ARM_ERRATA_775420 is not set
> CONFIG_TI_PRIV_EDMA=y
> 
> #
> # Bus support
> #
> # CONFIG_PCI_SYSCALL is not set
> # CONFIG_PCCARD is not set
> 
> #
> # Kernel Features
> #
> # CONFIG_HAVE_ARM_ARCH_TIMER is not set
> CONFIG_VMSPLIT_3G=y
> # CONFIG_VMSPLIT_2G is not set
> # CONFIG_VMSPLIT_1G is not set
> CONFIG_PAGE_OFFSET=0xC0000000
> # CONFIG_ARM_PSCI is not set
> CONFIG_ARCH_NR_GPIO=0
> CONFIG_PREEMPT_NONE=y
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT is not set
> CONFIG_HZ=100
> CONFIG_SCHED_HRTICK=y
> # CONFIG_THUMB2_KERNEL is not set
> CONFIG_AEABI=y
> CONFIG_OABI_COMPAT=y
> CONFIG_ARCH_HAS_HOLES_MEMORYMODEL=y
> # CONFIG_ARCH_SPARSEMEM_DEFAULT is not set
> # CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
> CONFIG_HAVE_ARCH_PFN_VALID=y
> CONFIG_HIGHMEM=y
> # CONFIG_HIGHPTE is not set
> CONFIG_HW_PERF_EVENTS=y
> CONFIG_FLATMEM=y
> CONFIG_FLAT_NODE_MEM_MAP=y
> CONFIG_HAVE_MEMBLOCK=y
> # CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
> CONFIG_PAGEFLAGS_EXTENDED=y
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_COMPACTION=y
> CONFIG_MIGRATION=y
> # CONFIG_PHYS_ADDR_T_64BIT is not set
> CONFIG_ZONE_DMA_FLAG=0
> CONFIG_BOUNCE=y
> # CONFIG_KSM is not set
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> CONFIG_CROSS_MEMORY_ATTACH=y
> CONFIG_NEED_PER_CPU_KM=y
> # CONFIG_CLEANCACHE is not set
> # CONFIG_FRONTSWAP is not set
> # CONFIG_ZBUD is not set
> CONFIG_FORCE_MAX_ZONEORDER=11
> CONFIG_ALIGNMENT_TRAP=y
> # CONFIG_UACCESS_WITH_MEMCPY is not set
> # CONFIG_SECCOMP is not set
> # CONFIG_CC_STACKPROTECTOR is not set
> # CONFIG_XEN is not set
> 
> #
> # Boot options
> #
> CONFIG_USE_OF=y
> CONFIG_ATAGS=y
> # CONFIG_DEPRECATED_PARAM_STRUCT is not set
> CONFIG_ZBOOT_ROM_TEXT=0x0
> CONFIG_ZBOOT_ROM_BSS=0x0
> # CONFIG_ARM_APPENDED_DTB is not set
> CONFIG_CMDLINE="console=ttyO2,115200 console=tty"
> # CONFIG_CMDLINE_FROM_BOOTLOADER is not set
> # CONFIG_CMDLINE_EXTEND is not set
> CONFIG_CMDLINE_FORCE=y
> CONFIG_KEXEC=y
> CONFIG_ATAGS_PROC=y
> # CONFIG_CRASH_DUMP is not set
> CONFIG_AUTO_ZRELADDR=y
> 
> #
> # CPU Power Management
> #
> 
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
> # CONFIG_CPU_IDLE is not set
> # CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
> 
> #
> # Floating point emulation
> #
> 
> #
> # At least one emulation must be selected
> #
> # CONFIG_FPE_NWFPE is not set
> # CONFIG_FPE_FASTFPE is not set
> CONFIG_VFP=y
> CONFIG_VFPv3=y
> CONFIG_NEON=y
> 
> #
> # Userspace binary formats
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_ARCH_BINFMT_ELF_RANDOMIZE_PIE=y
> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
> CONFIG_BINFMT_SCRIPT=y
> CONFIG_HAVE_AOUT=y
> # CONFIG_BINFMT_AOUT is not set
> CONFIG_BINFMT_MISC=y
> CONFIG_COREDUMP=y
> 
> #
> # Power management options
> #
> CONFIG_SUSPEND=y
> CONFIG_SUSPEND_FREEZER=y
> CONFIG_PM_SLEEP=y
> # CONFIG_PM_AUTOSLEEP is not set
> # CONFIG_PM_WAKELOCKS is not set
> CONFIG_PM_RUNTIME=y
> CONFIG_PM=y
> CONFIG_PM_DEBUG=y
> # CONFIG_PM_ADVANCED_DEBUG is not set
> # CONFIG_PM_TEST_SUSPEND is not set
> CONFIG_PM_SLEEP_DEBUG=y
> # CONFIG_APM_EMULATION is not set
> CONFIG_ARCH_HAS_OPP=y
> CONFIG_PM_OPP=y
> CONFIG_PM_CLK=y
> # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
> CONFIG_CPU_PM=y
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_ARM_CPU_SUSPEND=y
> CONFIG_NET=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> # CONFIG_PACKET_DIAG is not set
> # CONFIG_UNIX is not set
> # CONFIG_XFRM_USER is not set
> # CONFIG_NET_KEY is not set
> CONFIG_INET=y
> # CONFIG_IP_MULTICAST is not set
> # CONFIG_IP_ADVANCED_ROUTER is not set
> # CONFIG_IP_PNP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE_DEMUX is not set
> # CONFIG_NET_IP_TUNNEL is not set
> # CONFIG_ARPD is not set
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> # CONFIG_INET_XFRM_TUNNEL is not set
> # CONFIG_INET_TUNNEL is not set
> # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> # CONFIG_INET_XFRM_MODE_TUNNEL is not set
> # CONFIG_INET_XFRM_MODE_BEET is not set
> # CONFIG_INET_LRO is not set
> # CONFIG_INET_DIAG is not set
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_DEFAULT_TCP_CONG="cubic"
> # CONFIG_TCP_MD5SIG is not set
> # CONFIG_IPV6 is not set
> # CONFIG_NETWORK_SECMARK is not set
> # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> # CONFIG_NETFILTER is not set
> # CONFIG_IP_DCCP is not set
> # CONFIG_IP_SCTP is not set
> # CONFIG_RDS is not set
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> # CONFIG_L2TP is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> # CONFIG_LLC2 is not set
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_PHONET is not set
> # CONFIG_IEEE802154 is not set
> # CONFIG_NET_SCHED is not set
> # CONFIG_DCB is not set
> # CONFIG_BATMAN_ADV is not set
> # CONFIG_OPENVSWITCH is not set
> # CONFIG_VSOCKETS is not set
> # CONFIG_NETLINK_MMAP is not set
> # CONFIG_NETLINK_DIAG is not set
> # CONFIG_NET_MPLS_GSO is not set
> CONFIG_NET_LL_RX_POLL=y
> CONFIG_BQL=y
> # CONFIG_BPF_JIT is not set
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_NET_TCPPROBE is not set
> # CONFIG_HAMRADIO is not set
> # CONFIG_CAN is not set
> # CONFIG_IRDA is not set
> # CONFIG_BT is not set
> # CONFIG_AF_RXRPC is not set
> # CONFIG_WIRELESS is not set
> # CONFIG_WIMAX is not set
> # CONFIG_RFKILL is not set
> # CONFIG_RFKILL_REGULATOR is not set
> # CONFIG_NET_9P is not set
> # CONFIG_CAIF is not set
> # CONFIG_CEPH_LIB is not set
> # CONFIG_NFC is not set
> CONFIG_HAVE_BPF_JIT=y
> 
> #
> # Device Drivers
> #
> 
> #
> # Generic Driver Options
> #
> CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
> CONFIG_DEVTMPFS=y
> # CONFIG_DEVTMPFS_MOUNT is not set
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> CONFIG_FW_LOADER=y
> CONFIG_FIRMWARE_IN_KERNEL=y
> CONFIG_EXTRA_FIRMWARE=""
> CONFIG_FW_LOADER_USER_HELPER=y
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_SYS_HYPERVISOR is not set
> # CONFIG_GENERIC_CPU_DEVICES is not set
> CONFIG_SOC_BUS=y
> CONFIG_REGMAP=y
> CONFIG_REGMAP_I2C=y
> # CONFIG_DMA_SHARED_BUFFER is not set
> # CONFIG_CMA is not set
> 
> #
> # Bus devices
> #
> # CONFIG_OMAP_OCP2SCP is not set
> CONFIG_OMAP_INTERCONNECT=y
> # CONFIG_ARM_CCI is not set
> # CONFIG_CONNECTOR is not set
> CONFIG_MTD=y
> # CONFIG_MTD_TESTS is not set
> # CONFIG_MTD_REDBOOT_PARTS is not set
> CONFIG_MTD_CMDLINE_PARTS=y
> # CONFIG_MTD_AFS_PARTS is not set
> # CONFIG_MTD_OF_PARTS is not set
> # CONFIG_MTD_AR7_PARTS is not set
> 
> #
> # User Modules And Translation Layers
> #
> CONFIG_MTD_BLKDEVS=y
> CONFIG_MTD_BLOCK=y
> # CONFIG_FTL is not set
> # CONFIG_NFTL is not set
> # CONFIG_INFTL is not set
> # CONFIG_RFD_FTL is not set
> # CONFIG_SSFDC is not set
> # CONFIG_SM_FTL is not set
> CONFIG_MTD_OOPS=y
> # CONFIG_MTD_SWAP is not set
> 
> #
> # RAM/ROM/Flash chip drivers
> #
> CONFIG_MTD_CFI=y
> # CONFIG_MTD_JEDECPROBE is not set
> CONFIG_MTD_GEN_PROBE=y
> # CONFIG_MTD_CFI_ADV_OPTIONS is not set
> CONFIG_MTD_MAP_BANK_WIDTH_1=y
> CONFIG_MTD_MAP_BANK_WIDTH_2=y
> CONFIG_MTD_MAP_BANK_WIDTH_4=y
> # CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
> # CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
> # CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
> CONFIG_MTD_CFI_I1=y
> CONFIG_MTD_CFI_I2=y
> # CONFIG_MTD_CFI_I4 is not set
> # CONFIG_MTD_CFI_I8 is not set
> CONFIG_MTD_CFI_INTELEXT=y
> # CONFIG_MTD_CFI_AMDSTD is not set
> # CONFIG_MTD_CFI_STAA is not set
> CONFIG_MTD_CFI_UTIL=y
> # CONFIG_MTD_RAM is not set
> # CONFIG_MTD_ROM is not set
> # CONFIG_MTD_ABSENT is not set
> 
> #
> # Mapping drivers for chip access
> #
> # CONFIG_MTD_COMPLEX_MAPPINGS is not set
> # CONFIG_MTD_PHYSMAP is not set
> # CONFIG_MTD_PHYSMAP_OF is not set
> # CONFIG_MTD_PLATRAM is not set
> 
> #
> # Self-contained MTD device drivers
> #
> # CONFIG_MTD_DATAFLASH is not set
> # CONFIG_MTD_M25P80 is not set
> # CONFIG_MTD_SST25L is not set
> # CONFIG_MTD_SLRAM is not set
> # CONFIG_MTD_PHRAM is not set
> # CONFIG_MTD_MTDRAM is not set
> # CONFIG_MTD_BLOCK2MTD is not set
> 
> #
> # Disk-On-Chip Device Drivers
> #
> # CONFIG_MTD_DOCG3 is not set
> CONFIG_MTD_NAND_ECC=y
> # CONFIG_MTD_NAND_ECC_SMC is not set
> CONFIG_MTD_NAND=y
> # CONFIG_MTD_NAND_ECC_BCH is not set
> # CONFIG_MTD_SM_COMMON is not set
> # CONFIG_MTD_NAND_DENALI is not set
> # CONFIG_MTD_NAND_GPIO is not set
> CONFIG_MTD_NAND_OMAP2=y
> # CONFIG_MTD_NAND_OMAP_BCH is not set
> CONFIG_MTD_NAND_IDS=y
> # CONFIG_MTD_NAND_DISKONCHIP is not set
> # CONFIG_MTD_NAND_DOCG4 is not set
> # CONFIG_MTD_NAND_NANDSIM is not set
> # CONFIG_MTD_NAND_PLATFORM is not set
> # CONFIG_MTD_ALAUDA is not set
> CONFIG_MTD_ONENAND=y
> CONFIG_MTD_ONENAND_VERIFY_WRITE=y
> # CONFIG_MTD_ONENAND_GENERIC is not set
> CONFIG_MTD_ONENAND_OMAP2=y
> # CONFIG_MTD_ONENAND_OTP is not set
> # CONFIG_MTD_ONENAND_2X_PROGRAM is not set
> 
> #
> # LPDDR flash memory drivers
> #
> # CONFIG_MTD_LPDDR is not set
> CONFIG_MTD_UBI=y
> CONFIG_MTD_UBI_WL_THRESHOLD=4096
> CONFIG_MTD_UBI_BEB_LIMIT=20
> # CONFIG_MTD_UBI_FASTMAP is not set
> # CONFIG_MTD_UBI_GLUEBI is not set
> CONFIG_DTC=y
> CONFIG_OF=y
> 
> #
> # Device Tree and Open Firmware support
> #
> CONFIG_PROC_DEVICETREE=y
> # CONFIG_OF_SELFTEST is not set
> CONFIG_OF_FLATTREE=y
> CONFIG_OF_EARLY_FLATTREE=y
> CONFIG_OF_ADDRESS=y
> CONFIG_OF_IRQ=y
> CONFIG_OF_I2C=y
> CONFIG_OF_MTD=y
> # CONFIG_PARPORT is not set
> # CONFIG_BLK_DEV is not set
> 
> #
> # Misc devices
> #
> CONFIG_SENSORS_LIS3LV02D=m
> # CONFIG_AD525X_DPOT is not set
> # CONFIG_ATMEL_PWM is not set
> # CONFIG_DUMMY_IRQ is not set
> # CONFIG_ICS932S401 is not set
> # CONFIG_ATMEL_SSC is not set
> # CONFIG_ENCLOSURE_SERVICES is not set
> # CONFIG_APDS9802ALS is not set
> # CONFIG_ISL29003 is not set
> # CONFIG_ISL29020 is not set
> # CONFIG_SENSORS_TSL2550 is not set
> # CONFIG_SENSORS_BH1780 is not set
> # CONFIG_SENSORS_BH1770 is not set
> # CONFIG_SENSORS_APDS990X is not set
> # CONFIG_HMC6352 is not set
> # CONFIG_DS1682 is not set
> # CONFIG_TI_DAC7512 is not set
> # CONFIG_BMP085_I2C is not set
> # CONFIG_BMP085_SPI is not set
> # CONFIG_USB_SWITCH_FSA9480 is not set
> # CONFIG_LATTICE_ECP3_CONFIG is not set
> # CONFIG_SRAM is not set
> # CONFIG_C2PORT is not set
> 
> #
> # EEPROM support
> #
> # CONFIG_EEPROM_AT24 is not set
> # CONFIG_EEPROM_AT25 is not set
> # CONFIG_EEPROM_LEGACY is not set
> # CONFIG_EEPROM_MAX6875 is not set
> CONFIG_EEPROM_93CX6=y
> # CONFIG_EEPROM_93XX46 is not set
> 
> #
> # Texas Instruments shared transport line discipline
> #
> # CONFIG_TI_ST is not set
> # CONFIG_SENSORS_LIS3_SPI is not set
> CONFIG_SENSORS_LIS3_I2C=m
> 
> #
> # Altera FPGA firmware download module
> #
> # CONFIG_ALTERA_STAPL is not set
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=y
> # CONFIG_RAID_ATTRS is not set
> CONFIG_SCSI=y
> CONFIG_SCSI_DMA=y
> # CONFIG_SCSI_TGT is not set
> # CONFIG_SCSI_NETLINK is not set
> CONFIG_SCSI_PROC_FS=y
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=y
> # CONFIG_CHR_DEV_ST is not set
> # CONFIG_CHR_DEV_OSST is not set
> # CONFIG_BLK_DEV_SR is not set
> # CONFIG_CHR_DEV_SG is not set
> # CONFIG_CHR_DEV_SCH is not set
> CONFIG_SCSI_MULTI_LUN=y
> # CONFIG_SCSI_CONSTANTS is not set
> # CONFIG_SCSI_LOGGING is not set
> CONFIG_SCSI_SCAN_ASYNC=y
> 
> #
> # SCSI Transports
> #
> # CONFIG_SCSI_SPI_ATTRS is not set
> # CONFIG_SCSI_FC_ATTRS is not set
> # CONFIG_SCSI_ISCSI_ATTRS is not set
> # CONFIG_SCSI_SAS_ATTRS is not set
> # CONFIG_SCSI_SAS_LIBSAS is not set
> # CONFIG_SCSI_SRP_ATTRS is not set
> CONFIG_SCSI_LOWLEVEL=y
> # CONFIG_ISCSI_TCP is not set
> # CONFIG_ISCSI_BOOT_SYSFS is not set
> # CONFIG_SCSI_UFSHCD is not set
> # CONFIG_LIBFC is not set
> # CONFIG_LIBFCOE is not set
> # CONFIG_SCSI_DEBUG is not set
> # CONFIG_SCSI_DH is not set
> # CONFIG_SCSI_OSD_INITIATOR is not set
> # CONFIG_ATA is not set
> # CONFIG_MD is not set
> # CONFIG_TARGET_CORE is not set
> # CONFIG_NETDEVICES is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> # CONFIG_INPUT_FF_MEMLESS is not set
> CONFIG_INPUT_POLLDEV=y
> # CONFIG_INPUT_SPARSEKMAP is not set
> CONFIG_INPUT_MATRIXKMAP=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_JOYDEV=y
> CONFIG_INPUT_EVDEV=y
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> # CONFIG_KEYBOARD_ADP5588 is not set
> # CONFIG_KEYBOARD_ADP5589 is not set
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_QT1070 is not set
> # CONFIG_KEYBOARD_QT2160 is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> CONFIG_KEYBOARD_GPIO=y
> # CONFIG_KEYBOARD_TCA6416 is not set
> # CONFIG_KEYBOARD_TCA8418 is not set
> # CONFIG_KEYBOARD_MATRIX is not set
> # CONFIG_KEYBOARD_LM8333 is not set
> # CONFIG_KEYBOARD_MAX7359 is not set
> # CONFIG_KEYBOARD_MCS is not set
> # CONFIG_KEYBOARD_MPR121 is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_KEYBOARD_OPENCORES is not set
> # CONFIG_KEYBOARD_SAMSUNG is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_OMAP4 is not set
> CONFIG_KEYBOARD_TWL4030=y
> # CONFIG_KEYBOARD_XTKBD is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> CONFIG_MOUSE_PS2_ALPS=y
> CONFIG_MOUSE_PS2_LOGIPS2PP=y
> CONFIG_MOUSE_PS2_SYNAPTICS=y
> CONFIG_MOUSE_PS2_CYPRESS=y
> CONFIG_MOUSE_PS2_TRACKPOINT=y
> # CONFIG_MOUSE_PS2_ELANTECH is not set
> # CONFIG_MOUSE_PS2_SENTELIC is not set
> # CONFIG_MOUSE_PS2_TOUCHKIT is not set
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_APPLETOUCH is not set
> # CONFIG_MOUSE_BCM5974 is not set
> # CONFIG_MOUSE_CYAPA is not set
> # CONFIG_MOUSE_VSXXXAA is not set
> # CONFIG_MOUSE_GPIO is not set
> # CONFIG_MOUSE_SYNAPTICS_I2C is not set
> # CONFIG_MOUSE_SYNAPTICS_USB is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TABLET is not set
> CONFIG_INPUT_TOUCHSCREEN=y
> CONFIG_TOUCHSCREEN_ADS7846=y
> # CONFIG_TOUCHSCREEN_AD7877 is not set
> # CONFIG_TOUCHSCREEN_AD7879 is not set
> # CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
> # CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
> # CONFIG_TOUCHSCREEN_BU21013 is not set
> # CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
> # CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
> # CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
> # CONFIG_TOUCHSCREEN_DYNAPRO is not set
> # CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
> # CONFIG_TOUCHSCREEN_EETI is not set
> # CONFIG_TOUCHSCREEN_EGALAX is not set
> # CONFIG_TOUCHSCREEN_FUJITSU is not set
> # CONFIG_TOUCHSCREEN_ILI210X is not set
> # CONFIG_TOUCHSCREEN_GUNZE is not set
> # CONFIG_TOUCHSCREEN_ELO is not set
> # CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
> # CONFIG_TOUCHSCREEN_WACOM_I2C is not set
> # CONFIG_TOUCHSCREEN_MAX11801 is not set
> # CONFIG_TOUCHSCREEN_MCS5000 is not set
> # CONFIG_TOUCHSCREEN_MMS114 is not set
> # CONFIG_TOUCHSCREEN_MTOUCH is not set
> # CONFIG_TOUCHSCREEN_INEXIO is not set
> # CONFIG_TOUCHSCREEN_MK712 is not set
> # CONFIG_TOUCHSCREEN_PENMOUNT is not set
> # CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
> # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
> # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
> # CONFIG_TOUCHSCREEN_PIXCIR is not set
> # CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
> # CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
> # CONFIG_TOUCHSCREEN_TSC_SERIO is not set
> CONFIG_TOUCHSCREEN_TSC2005=y
> # CONFIG_TOUCHSCREEN_TSC2007 is not set
> # CONFIG_TOUCHSCREEN_W90X900 is not set
> # CONFIG_TOUCHSCREEN_ST1232 is not set
> # CONFIG_TOUCHSCREEN_TPS6507X is not set
> CONFIG_INPUT_MISC=y
> # CONFIG_INPUT_AD714X is not set
> # CONFIG_INPUT_BMA150 is not set
> # CONFIG_INPUT_MMA8450 is not set
> # CONFIG_INPUT_MPU3050 is not set
> # CONFIG_INPUT_GP2A is not set
> # CONFIG_INPUT_GPIO_TILT_POLLED is not set
> # CONFIG_INPUT_ATI_REMOTE2 is not set
> # CONFIG_INPUT_KEYSPAN_REMOTE is not set
> # CONFIG_INPUT_KXTJ9 is not set
> # CONFIG_INPUT_POWERMATE is not set
> # CONFIG_INPUT_YEALINK is not set
> # CONFIG_INPUT_CM109 is not set
> CONFIG_INPUT_TWL4030_PWRBUTTON=y
> # CONFIG_INPUT_TWL4030_VIBRA is not set
> CONFIG_INPUT_UINPUT=y
> # CONFIG_INPUT_PCF8574 is not set
> # CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
> # CONFIG_INPUT_ADXL34X is not set
> # CONFIG_INPUT_CMA3000 is not set
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_SERIO_SERPORT=y
> CONFIG_SERIO_LIBPS2=y
> # CONFIG_SERIO_RAW is not set
> # CONFIG_SERIO_ALTERA_PS2 is not set
> # CONFIG_SERIO_PS2MULT is not set
> # CONFIG_SERIO_ARC_PS2 is not set
> # CONFIG_SERIO_APBPS2 is not set
> # CONFIG_SERIO_OLPC_APSP is not set
> # CONFIG_GAMEPORT is not set
> 
> #
> # Character devices
> #
> CONFIG_TTY=y
> CONFIG_VT=y
> CONFIG_CONSOLE_TRANSLATIONS=y
> CONFIG_VT_CONSOLE=y
> CONFIG_VT_CONSOLE_SLEEP=y
> CONFIG_HW_CONSOLE=y
> CONFIG_VT_HW_CONSOLE_BINDING=y
> CONFIG_UNIX98_PTYS=y
> # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
> # CONFIG_LEGACY_PTYS is not set
> # CONFIG_SERIAL_NONSTANDARD is not set
> # CONFIG_N_GSM is not set
> # CONFIG_TRACE_SINK is not set
> CONFIG_DEVKMEM=y
> 
> #
> # Serial drivers
> #
> # CONFIG_SERIAL_8250 is not set
> 
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_MAX3100 is not set
> # CONFIG_SERIAL_MAX310X is not set
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_SERIAL_OMAP=y
> CONFIG_SERIAL_OMAP_CONSOLE=y
> # CONFIG_SERIAL_SCCNXP is not set
> # CONFIG_SERIAL_TIMBERDALE is not set
> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> # CONFIG_SERIAL_ALTERA_UART is not set
> # CONFIG_SERIAL_IFX6X60 is not set
> # CONFIG_SERIAL_XILINX_PS_UART is not set
> # CONFIG_SERIAL_ARC is not set
> # CONFIG_SERIAL_FSL_LPUART is not set
> # CONFIG_TTY_PRINTK is not set
> # CONFIG_HVC_DCC is not set
> # CONFIG_IPMI_HANDLER is not set
> CONFIG_HW_RANDOM=y
> # CONFIG_HW_RANDOM_TIMERIOMEM is not set
> # CONFIG_HW_RANDOM_ATMEL is not set
> # CONFIG_HW_RANDOM_EXYNOS is not set
> # CONFIG_R3964 is not set
> # CONFIG_RAW_DRIVER is not set
> # CONFIG_TCG_TPM is not set
> CONFIG_I2C=y
> CONFIG_I2C_BOARDINFO=y
> CONFIG_I2C_COMPAT=y
> CONFIG_I2C_CHARDEV=y
> # CONFIG_I2C_MUX is not set
> CONFIG_I2C_HELPER_AUTO=y
> 
> #
> # I2C Hardware Bus support
> #
> 
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> # CONFIG_I2C_CBUS_GPIO is not set
> # CONFIG_I2C_DESIGNWARE_PLATFORM is not set
> # CONFIG_I2C_GPIO is not set
> # CONFIG_I2C_OCORES is not set
> CONFIG_I2C_OMAP=y
> # CONFIG_I2C_PCA_PLATFORM is not set
> # CONFIG_I2C_PXA_PCI is not set
> # CONFIG_I2C_SIMTEC is not set
> # CONFIG_I2C_XILINX is not set
> 
> #
> # External I2C/SMBus adapter drivers
> #
> # CONFIG_I2C_DIOLAN_U2C is not set
> # CONFIG_I2C_PARPORT_LIGHT is not set
> # CONFIG_I2C_TAOS_EVM is not set
> # CONFIG_I2C_TINY_USB is not set
> 
> #
> # Other I2C/SMBus bus drivers
> #
> # CONFIG_I2C_STUB is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> CONFIG_SPI=y
> # CONFIG_SPI_DEBUG is not set
> CONFIG_SPI_MASTER=y
> 
> #
> # SPI Master Controller Drivers
> #
> # CONFIG_SPI_ALTERA is not set
> # CONFIG_SPI_BITBANG is not set
> # CONFIG_SPI_GPIO is not set
> # CONFIG_SPI_FSL_SPI is not set
> # CONFIG_SPI_OC_TINY is not set
> CONFIG_SPI_OMAP24XX=y
> # CONFIG_SPI_PXA2XX_PCI is not set
> # CONFIG_SPI_SC18IS602 is not set
> # CONFIG_SPI_XCOMM is not set
> # CONFIG_SPI_XILINX is not set
> # CONFIG_SPI_DESIGNWARE is not set
> 
> #
> # SPI Protocol Masters
> #
> # CONFIG_SPI_SPIDEV is not set
> # CONFIG_SPI_TLE62X0 is not set
> # CONFIG_HSI is not set
> 
> #
> # PPS support
> #
> # CONFIG_PPS is not set
> 
> #
> # PPS generators support
> #
> 
> #
> # PTP clock support
> #
> # CONFIG_PTP_1588_CLOCK is not set
> 
> #
> # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
> #
> CONFIG_PINCTRL=y
> 
> #
> # Pin controllers
> #
> # CONFIG_PINMUX is not set
> # CONFIG_PINCONF is not set
> # CONFIG_DEBUG_PINCTRL is not set
> # CONFIG_PINCTRL_SINGLE is not set
> CONFIG_ARCH_HAVE_CUSTOM_GPIO_H=y
> CONFIG_ARCH_REQUIRE_GPIOLIB=y
> CONFIG_GPIO_DEVRES=y
> CONFIG_GPIOLIB=y
> CONFIG_OF_GPIO=y
> CONFIG_DEBUG_GPIO=y
> CONFIG_GPIO_SYSFS=y
> 
> #
> # Memory mapped GPIO drivers:
> #
> # CONFIG_GPIO_GENERIC_PLATFORM is not set
> # CONFIG_GPIO_EM is not set
> # CONFIG_GPIO_RCAR is not set
> # CONFIG_GPIO_TS5500 is not set
> # CONFIG_GPIO_GRGPIO is not set
> 
> #
> # I2C GPIO expanders:
> #
> # CONFIG_GPIO_MAX7300 is not set
> # CONFIG_GPIO_MAX732X is not set
> # CONFIG_GPIO_PCF857X is not set
> # CONFIG_GPIO_SX150X is not set
> CONFIG_GPIO_TWL4030=y
> # CONFIG_GPIO_ADP5588 is not set
> # CONFIG_GPIO_ADNP is not set
> 
> #
> # PCI GPIO expanders:
> #
> 
> #
> # SPI GPIO expanders:
> #
> # CONFIG_GPIO_MAX7301 is not set
> # CONFIG_GPIO_MCP23S08 is not set
> # CONFIG_GPIO_MC33880 is not set
> # CONFIG_GPIO_74X164 is not set
> 
> #
> # AC97 GPIO expanders:
> #
> 
> #
> # MODULbus GPIO expanders:
> #
> 
> #
> # USB GPIO expanders:
> #
> # CONFIG_W1 is not set
> CONFIG_POWER_SUPPLY=y
> # CONFIG_POWER_SUPPLY_DEBUG is not set
> # CONFIG_PDA_POWER is not set
> # CONFIG_TEST_POWER is not set
> # CONFIG_BATTERY_DS2780 is not set
> # CONFIG_BATTERY_DS2781 is not set
> # CONFIG_BATTERY_DS2782 is not set
> # CONFIG_BATTERY_SBS is not set
> # CONFIG_BATTERY_BQ27x00 is not set
> # CONFIG_BATTERY_MAX17040 is not set
> # CONFIG_BATTERY_MAX17042 is not set
> # CONFIG_CHARGER_ISP1704 is not set
> # CONFIG_CHARGER_MAX8903 is not set
> # CONFIG_CHARGER_TWL4030 is not set
> # CONFIG_CHARGER_LP8727 is not set
> # CONFIG_CHARGER_GPIO is not set
> # CONFIG_CHARGER_MANAGER is not set
> # CONFIG_CHARGER_BQ2415X is not set
> # CONFIG_CHARGER_SMB347 is not set
> # CONFIG_BATTERY_GOLDFISH is not set
> # CONFIG_POWER_RESET is not set
> # CONFIG_POWER_RESET_RESTART is not set
> # CONFIG_POWER_AVS is not set
> CONFIG_HWMON=y
> # CONFIG_HWMON_VID is not set
> # CONFIG_HWMON_DEBUG_CHIP is not set
> 
> #
> # Native drivers
> #
> # CONFIG_SENSORS_AD7314 is not set
> # CONFIG_SENSORS_AD7414 is not set
> # CONFIG_SENSORS_AD7418 is not set
> # CONFIG_SENSORS_ADCXX is not set
> # CONFIG_SENSORS_ADM1021 is not set
> # CONFIG_SENSORS_ADM1025 is not set
> # CONFIG_SENSORS_ADM1026 is not set
> # CONFIG_SENSORS_ADM1029 is not set
> # CONFIG_SENSORS_ADM1031 is not set
> # CONFIG_SENSORS_ADM9240 is not set
> # CONFIG_SENSORS_ADT7310 is not set
> # CONFIG_SENSORS_ADT7410 is not set
> # CONFIG_SENSORS_ADT7411 is not set
> # CONFIG_SENSORS_ADT7462 is not set
> # CONFIG_SENSORS_ADT7470 is not set
> # CONFIG_SENSORS_ADT7475 is not set
> # CONFIG_SENSORS_ASC7621 is not set
> # CONFIG_SENSORS_ATXP1 is not set
> # CONFIG_SENSORS_DS620 is not set
> # CONFIG_SENSORS_DS1621 is not set
> # CONFIG_SENSORS_F71805F is not set
> # CONFIG_SENSORS_F71882FG is not set
> # CONFIG_SENSORS_F75375S is not set
> # CONFIG_SENSORS_G760A is not set
> # CONFIG_SENSORS_G762 is not set
> # CONFIG_SENSORS_GL518SM is not set
> # CONFIG_SENSORS_GL520SM is not set
> # CONFIG_SENSORS_GPIO_FAN is not set
> # CONFIG_SENSORS_HIH6130 is not set
> # CONFIG_SENSORS_IT87 is not set
> # CONFIG_SENSORS_JC42 is not set
> # CONFIG_SENSORS_LINEAGE is not set
> # CONFIG_SENSORS_LM63 is not set
> # CONFIG_SENSORS_LM70 is not set
> # CONFIG_SENSORS_LM73 is not set
> # CONFIG_SENSORS_LM75 is not set
> # CONFIG_SENSORS_LM77 is not set
> # CONFIG_SENSORS_LM78 is not set
> # CONFIG_SENSORS_LM80 is not set
> # CONFIG_SENSORS_LM83 is not set
> # CONFIG_SENSORS_LM85 is not set
> # CONFIG_SENSORS_LM87 is not set
> # CONFIG_SENSORS_LM90 is not set
> # CONFIG_SENSORS_LM92 is not set
> # CONFIG_SENSORS_LM93 is not set
> # CONFIG_SENSORS_LTC4151 is not set
> # CONFIG_SENSORS_LTC4215 is not set
> # CONFIG_SENSORS_LTC4245 is not set
> # CONFIG_SENSORS_LTC4261 is not set
> # CONFIG_SENSORS_LM95234 is not set
> # CONFIG_SENSORS_LM95241 is not set
> # CONFIG_SENSORS_LM95245 is not set
> # CONFIG_SENSORS_MAX1111 is not set
> # CONFIG_SENSORS_MAX16065 is not set
> # CONFIG_SENSORS_MAX1619 is not set
> # CONFIG_SENSORS_MAX1668 is not set
> # CONFIG_SENSORS_MAX197 is not set
> # CONFIG_SENSORS_MAX6639 is not set
> # CONFIG_SENSORS_MAX6642 is not set
> # CONFIG_SENSORS_MAX6650 is not set
> # CONFIG_SENSORS_MAX6697 is not set
> # CONFIG_SENSORS_MCP3021 is not set
> # CONFIG_SENSORS_NCT6775 is not set
> # CONFIG_SENSORS_PC87360 is not set
> # CONFIG_SENSORS_PC87427 is not set
> # CONFIG_SENSORS_PCF8591 is not set
> # CONFIG_PMBUS is not set
> # CONFIG_SENSORS_SHT15 is not set
> # CONFIG_SENSORS_SHT21 is not set
> # CONFIG_SENSORS_SMM665 is not set
> # CONFIG_SENSORS_DME1737 is not set
> # CONFIG_SENSORS_EMC1403 is not set
> # CONFIG_SENSORS_EMC2103 is not set
> # CONFIG_SENSORS_EMC6W201 is not set
> # CONFIG_SENSORS_SMSC47M1 is not set
> # CONFIG_SENSORS_SMSC47M192 is not set
> # CONFIG_SENSORS_SMSC47B397 is not set
> # CONFIG_SENSORS_SCH56XX_COMMON is not set
> # CONFIG_SENSORS_SCH5627 is not set
> # CONFIG_SENSORS_SCH5636 is not set
> # CONFIG_SENSORS_ADS1015 is not set
> # CONFIG_SENSORS_ADS7828 is not set
> # CONFIG_SENSORS_ADS7871 is not set
> # CONFIG_SENSORS_AMC6821 is not set
> # CONFIG_SENSORS_INA209 is not set
> # CONFIG_SENSORS_INA2XX is not set
> # CONFIG_SENSORS_THMC50 is not set
> # CONFIG_SENSORS_TMP102 is not set
> # CONFIG_SENSORS_TMP401 is not set
> # CONFIG_SENSORS_TMP421 is not set
> # CONFIG_SENSORS_VT1211 is not set
> # CONFIG_SENSORS_W83781D is not set
> # CONFIG_SENSORS_W83791D is not set
> # CONFIG_SENSORS_W83792D is not set
> # CONFIG_SENSORS_W83793 is not set
> # CONFIG_SENSORS_W83795 is not set
> # CONFIG_SENSORS_W83L785TS is not set
> # CONFIG_SENSORS_W83L786NG is not set
> # CONFIG_SENSORS_W83627HF is not set
> # CONFIG_SENSORS_W83627EHF is not set
> # CONFIG_THERMAL is not set
> CONFIG_WATCHDOG=y
> CONFIG_WATCHDOG_CORE=y
> # CONFIG_WATCHDOG_NOWAYOUT is not set
> 
> #
> # Watchdog Device Drivers
> #
> # CONFIG_SOFT_WATCHDOG is not set
> # CONFIG_DW_WATCHDOG is not set
> CONFIG_OMAP_WATCHDOG=y
> CONFIG_TWL4030_WATCHDOG=y
> # CONFIG_MAX63XX_WATCHDOG is not set
> # CONFIG_MEN_A21_WDT is not set
> 
> #
> # USB-based Watchdog Cards
> #
> # CONFIG_USBPCWATCHDOG is not set
> CONFIG_SSB_POSSIBLE=y
> 
> #
> # Sonics Silicon Backplane
> #
> # CONFIG_SSB is not set
> CONFIG_BCMA_POSSIBLE=y
> 
> #
> # Broadcom specific AMBA
> #
> # CONFIG_BCMA is not set
> 
> #
> # Multifunction device drivers
> #
> # CONFIG_MFD_CORE is not set
> # CONFIG_MFD_AS3711 is not set
> # CONFIG_PMIC_ADP5520 is not set
> # CONFIG_MFD_AAT2870_CORE is not set
> # CONFIG_MFD_CROS_EC is not set
> # CONFIG_MFD_ASIC3 is not set
> # CONFIG_PMIC_DA903X is not set
> # CONFIG_MFD_DA9052_SPI is not set
> # CONFIG_MFD_DA9052_I2C is not set
> # CONFIG_MFD_DA9055 is not set
> # CONFIG_MFD_MC13XXX_SPI is not set
> # CONFIG_MFD_MC13XXX_I2C is not set
> # CONFIG_HTC_EGPIO is not set
> # CONFIG_HTC_PASIC3 is not set
> # CONFIG_HTC_I2CPLD is not set
> # CONFIG_MFD_KEMPLD is not set
> # CONFIG_MFD_88PM800 is not set
> # CONFIG_MFD_88PM805 is not set
> # CONFIG_MFD_88PM860X is not set
> # CONFIG_MFD_MAX77686 is not set
> # CONFIG_MFD_MAX77693 is not set
> # CONFIG_MFD_MAX8907 is not set
> # CONFIG_MFD_MAX8925 is not set
> # CONFIG_MFD_MAX8997 is not set
> # CONFIG_MFD_MAX8998 is not set
> # CONFIG_EZX_PCAP is not set
> # CONFIG_MFD_VIPERBOARD is not set
> # CONFIG_MFD_RETU is not set
> # CONFIG_MFD_PCF50633 is not set
> # CONFIG_MFD_RC5T583 is not set
> # CONFIG_MFD_SEC_CORE is not set
> # CONFIG_MFD_SI476X_CORE is not set
> # CONFIG_MFD_SM501 is not set
> # CONFIG_MFD_SMSC is not set
> # CONFIG_ABX500_CORE is not set
> # CONFIG_MFD_STMPE is not set
> # CONFIG_MFD_SYSCON is not set
> # CONFIG_MFD_TI_AM335X_TSCADC is not set
> # CONFIG_MFD_LP8788 is not set
> # CONFIG_MFD_PALMAS is not set
> # CONFIG_TPS6105X is not set
> # CONFIG_TPS65010 is not set
> # CONFIG_TPS6507X is not set
> # CONFIG_MFD_TPS65090 is not set
> # CONFIG_MFD_TPS65217 is not set
> # CONFIG_MFD_TPS6586X is not set
> # CONFIG_MFD_TPS65910 is not set
> # CONFIG_MFD_TPS65912 is not set
> # CONFIG_MFD_TPS65912_I2C is not set
> # CONFIG_MFD_TPS65912_SPI is not set
> # CONFIG_MFD_TPS80031 is not set
> CONFIG_TWL4030_CORE=y
> # CONFIG_TWL4030_MADC is not set
> CONFIG_TWL4030_POWER=y
> # CONFIG_MFD_TWL4030_AUDIO is not set
> # CONFIG_TWL6040_CORE is not set
> # CONFIG_MFD_WL1273_CORE is not set
> # CONFIG_MFD_LM3533 is not set
> # CONFIG_MFD_TC3589X is not set
> # CONFIG_MFD_TMIO is not set
> # CONFIG_MFD_T7L66XB is not set
> # CONFIG_MFD_TC6387XB is not set
> # CONFIG_MFD_TC6393XB is not set
> # CONFIG_MFD_ARIZONA_I2C is not set
> # CONFIG_MFD_ARIZONA_SPI is not set
> # CONFIG_MFD_WM8400 is not set
> # CONFIG_MFD_WM831X_I2C is not set
> # CONFIG_MFD_WM831X_SPI is not set
> # CONFIG_MFD_WM8350_I2C is not set
> # CONFIG_MFD_WM8994 is not set
> # CONFIG_VEXPRESS_CONFIG is not set
> CONFIG_REGULATOR=y
> # CONFIG_REGULATOR_DEBUG is not set
> # CONFIG_REGULATOR_DUMMY is not set
> CONFIG_REGULATOR_FIXED_VOLTAGE=y
> # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
> # CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
> # CONFIG_REGULATOR_GPIO is not set
> # CONFIG_REGULATOR_AD5398 is not set
> # CONFIG_REGULATOR_FAN53555 is not set
> # CONFIG_REGULATOR_ISL6271A is not set
> # CONFIG_REGULATOR_MAX1586 is not set
> # CONFIG_REGULATOR_MAX8649 is not set
> # CONFIG_REGULATOR_MAX8660 is not set
> # CONFIG_REGULATOR_MAX8952 is not set
> # CONFIG_REGULATOR_MAX8973 is not set
> # CONFIG_REGULATOR_LP3971 is not set
> # CONFIG_REGULATOR_LP3972 is not set
> # CONFIG_REGULATOR_LP872X is not set
> # CONFIG_REGULATOR_LP8755 is not set
> # CONFIG_REGULATOR_TPS51632 is not set
> # CONFIG_REGULATOR_TPS62360 is not set
> CONFIG_REGULATOR_TPS65023=y
> CONFIG_REGULATOR_TPS6507X=y
> # CONFIG_REGULATOR_TPS6524X is not set
> CONFIG_REGULATOR_TWL4030=y
> # CONFIG_REGULATOR_TI_ABB is not set
> # CONFIG_MEDIA_SUPPORT is not set
> 
> #
> # Graphics support
> #
> # CONFIG_DRM is not set
> # CONFIG_TEGRA_HOST1X is not set
> # CONFIG_VGASTATE is not set
> # CONFIG_VIDEO_OUTPUT_CONTROL is not set
> CONFIG_VIDEOMODE_HELPERS=y
> CONFIG_FB=y
> CONFIG_FIRMWARE_EDID=y
> # CONFIG_FB_DDC is not set
> # CONFIG_FB_BOOT_VESA_SUPPORT is not set
> CONFIG_FB_CFB_FILLRECT=m
> CONFIG_FB_CFB_COPYAREA=m
> CONFIG_FB_CFB_IMAGEBLIT=m
> # CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
> # CONFIG_FB_SYS_FILLRECT is not set
> # CONFIG_FB_SYS_COPYAREA is not set
> # CONFIG_FB_SYS_IMAGEBLIT is not set
> # CONFIG_FB_FOREIGN_ENDIAN is not set
> # CONFIG_FB_SYS_FOPS is not set
> # CONFIG_FB_SVGALIB is not set
> # CONFIG_FB_MACMODES is not set
> # CONFIG_FB_BACKLIGHT is not set
> CONFIG_FB_MODE_HELPERS=y
> CONFIG_FB_TILEBLITTING=y
> 
> #
> # Frame buffer hardware drivers
> #
> # CONFIG_FB_S1D13XXX is not set
> # CONFIG_FB_SMSCUFX is not set
> # CONFIG_FB_UDL is not set
> # CONFIG_FB_GOLDFISH is not set
> # CONFIG_FB_VIRTUAL is not set
> # CONFIG_FB_METRONOME is not set
> # CONFIG_FB_BROADSHEET is not set
> # CONFIG_FB_AUO_K190X is not set
> # CONFIG_FB_SIMPLE is not set
> CONFIG_OMAP2_VRFB=y
> CONFIG_OMAP2_DSS=y
> # CONFIG_OMAP2_DSS_DEBUG is not set
> # CONFIG_OMAP2_DSS_DPI is not set
> # CONFIG_OMAP2_DSS_RFBI is not set
> CONFIG_OMAP2_DSS_VENC=y
> CONFIG_OMAP4_DSS_HDMI=y
> CONFIG_OMAP2_DSS_SDI=y
> # CONFIG_OMAP2_DSS_DSI is not set
> CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=0
> CONFIG_OMAP2_DSS_SLEEP_AFTER_VENC_RESET=y
> CONFIG_FB_OMAP2=m
> # CONFIG_FB_OMAP2_DEBUG_SUPPORT is not set
> CONFIG_FB_OMAP2_NUM_FBS=3
> 
> #
> # OMAP2/3 Display Device Drivers (old device model)
> #
> CONFIG_PANEL_ACX565AKM=m
> 
> #
> # OMAP Display Device Drivers (new device model)
> #
> # CONFIG_DISPLAY_ENCODER_TFP410 is not set
> # CONFIG_DISPLAY_ENCODER_TPD12S015 is not set
> # CONFIG_DISPLAY_CONNECTOR_DVI is not set
> # CONFIG_DISPLAY_CONNECTOR_HDMI is not set
> # CONFIG_DISPLAY_CONNECTOR_ANALOG_TV is not set
> # CONFIG_DISPLAY_PANEL_DPI is not set
> # CONFIG_DISPLAY_PANEL_DSI_CM is not set
> # CONFIG_DISPLAY_PANEL_SONY_ACX565AKM is not set
> # CONFIG_DISPLAY_PANEL_LGPHILIPS_LB035Q02 is not set
> # CONFIG_DISPLAY_PANEL_SHARP_LS037V7DW01 is not set
> # CONFIG_DISPLAY_PANEL_TPO_TD043MTEA1 is not set
> # CONFIG_DISPLAY_PANEL_NEC_NL8048HL11 is not set
> # CONFIG_EXYNOS_VIDEO is not set
> CONFIG_BACKLIGHT_LCD_SUPPORT=y
> CONFIG_LCD_CLASS_DEVICE=y
> # CONFIG_LCD_L4F00242T03 is not set
> # CONFIG_LCD_LMS283GF05 is not set
> # CONFIG_LCD_LTV350QV is not set
> # CONFIG_LCD_ILI922X is not set
> # CONFIG_LCD_ILI9320 is not set
> # CONFIG_LCD_TDO24M is not set
> # CONFIG_LCD_VGG2432A4 is not set
> CONFIG_LCD_PLATFORM=y
> # CONFIG_LCD_S6E63M0 is not set
> # CONFIG_LCD_LD9040 is not set
> # CONFIG_LCD_AMS369FG06 is not set
> # CONFIG_LCD_LMS501KF03 is not set
> # CONFIG_LCD_HX8357 is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> CONFIG_BACKLIGHT_GENERIC=y
> # CONFIG_BACKLIGHT_ADP8860 is not set
> # CONFIG_BACKLIGHT_ADP8870 is not set
> # CONFIG_BACKLIGHT_LM3630 is not set
> # CONFIG_BACKLIGHT_LM3639 is not set
> # CONFIG_BACKLIGHT_LP855X is not set
> # CONFIG_BACKLIGHT_PANDORA is not set
> 
> #
> # Console display driver support
> #
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> # CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
> CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
> CONFIG_LOGO=y
> CONFIG_LOGO_LINUX_MONO=y
> # CONFIG_LOGO_LINUX_VGA16 is not set
> # CONFIG_LOGO_LINUX_CLUT224 is not set
> # CONFIG_FB_SSD1307 is not set
> # CONFIG_SOUND is not set
> 
> #
> # HID support
> #
> CONFIG_HID=y
> # CONFIG_HID_BATTERY_STRENGTH is not set
> # CONFIG_HIDRAW is not set
> # CONFIG_UHID is not set
> CONFIG_HID_GENERIC=y
> 
> #
> # Special HID drivers
> #
> # CONFIG_HID_A4TECH is not set
> # CONFIG_HID_ACRUX is not set
> # CONFIG_HID_APPLE is not set
> # CONFIG_HID_APPLEIR is not set
> # CONFIG_HID_AUREAL is not set
> # CONFIG_HID_BELKIN is not set
> # CONFIG_HID_CHERRY is not set
> # CONFIG_HID_CHICONY is not set
> # CONFIG_HID_CYPRESS is not set
> # CONFIG_HID_DRAGONRISE is not set
> # CONFIG_HID_EMS_FF is not set
> # CONFIG_HID_ELECOM is not set
> # CONFIG_HID_ELO is not set
> # CONFIG_HID_EZKEY is not set
> # CONFIG_HID_HOLTEK is not set
> # CONFIG_HID_HUION is not set
> # CONFIG_HID_KEYTOUCH is not set
> # CONFIG_HID_KYE is not set
> # CONFIG_HID_UCLOGIC is not set
> # CONFIG_HID_WALTOP is not set
> # CONFIG_HID_GYRATION is not set
> # CONFIG_HID_ICADE is not set
> # CONFIG_HID_TWINHAN is not set
> # CONFIG_HID_KENSINGTON is not set
> # CONFIG_HID_LCPOWER is not set
> # CONFIG_HID_LENOVO_TPKBD is not set
> # CONFIG_HID_LOGITECH is not set
> # CONFIG_HID_MAGICMOUSE is not set
> # CONFIG_HID_MICROSOFT is not set
> # CONFIG_HID_MONTEREY is not set
> # CONFIG_HID_MULTITOUCH is not set
> # CONFIG_HID_NTRIG is not set
> # CONFIG_HID_ORTEK is not set
> # CONFIG_HID_PANTHERLORD is not set
> # CONFIG_HID_PETALYNX is not set
> # CONFIG_HID_PICOLCD is not set
> # CONFIG_HID_PRIMAX is not set
> # CONFIG_HID_ROCCAT is not set
> # CONFIG_HID_SAITEK is not set
> # CONFIG_HID_SAMSUNG is not set
> # CONFIG_HID_SPEEDLINK is not set
> # CONFIG_HID_STEELSERIES is not set
> # CONFIG_HID_SUNPLUS is not set
> # CONFIG_HID_GREENASIA is not set
> # CONFIG_HID_SMARTJOYPLUS is not set
> # CONFIG_HID_TIVO is not set
> # CONFIG_HID_TOPSEED is not set
> # CONFIG_HID_THRUSTMASTER is not set
> # CONFIG_HID_ZEROPLUS is not set
> # CONFIG_HID_ZYDACRON is not set
> # CONFIG_HID_SENSOR_HUB is not set
> 
> #
> # USB HID support
> #
> CONFIG_USB_HID=y
> # CONFIG_HID_PID is not set
> # CONFIG_USB_HIDDEV is not set
> 
> #
> # I2C HID support
> #
> # CONFIG_I2C_HID is not set
> CONFIG_USB_ARCH_HAS_EHCI=y
> CONFIG_USB_SUPPORT=y
> CONFIG_USB_COMMON=y
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB=y
> CONFIG_USB_DEBUG=y
> CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> 
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEFAULT_PERSIST=y
> # CONFIG_USB_DYNAMIC_MINORS is not set
> # CONFIG_USB_OTG is not set
> # CONFIG_USB_OTG_WHITELIST is not set
> # CONFIG_USB_OTG_BLACKLIST_HUB is not set
> # CONFIG_USB_MON is not set
> # CONFIG_USB_WUSB_CBAF is not set
> 
> #
> # USB Host Controller Drivers
> #
> # CONFIG_USB_C67X00_HCD is not set
> # CONFIG_USB_XHCI_HCD is not set
> # CONFIG_USB_EHCI_HCD is not set
> # CONFIG_USB_OXU210HP_HCD is not set
> # CONFIG_USB_ISP116X_HCD is not set
> # CONFIG_USB_ISP1760_HCD is not set
> # CONFIG_USB_ISP1362_HCD is not set
> # CONFIG_USB_FUSBH200_HCD is not set
> # CONFIG_USB_OHCI_HCD is not set
> # CONFIG_USB_SL811_HCD is not set
> # CONFIG_USB_R8A66597_HCD is not set
> CONFIG_USB_MUSB_HDRC=y
> # CONFIG_USB_MUSB_HOST is not set
> # CONFIG_USB_MUSB_GADGET is not set
> CONFIG_USB_MUSB_DUAL_ROLE=y
> # CONFIG_USB_MUSB_TUSB6010 is not set
> CONFIG_USB_MUSB_OMAP2PLUS=y
> # CONFIG_USB_MUSB_AM35X is not set
> # CONFIG_USB_MUSB_DSPS is not set
> # CONFIG_USB_MUSB_UX500 is not set
> # CONFIG_USB_INVENTRA_DMA is not set
> CONFIG_MUSB_PIO_ONLY=y
> # CONFIG_USB_RENESAS_USBHS is not set
> 
> #
> # USB Device Class drivers
> #
> # CONFIG_USB_ACM is not set
> # CONFIG_USB_PRINTER is not set
> # CONFIG_USB_WDM is not set
> # CONFIG_USB_TMC is not set
> 
> #
> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> #
> 
> #
> # also be needed; see USB_STORAGE Help for more info
> #
> # CONFIG_USB_STORAGE is not set
> 
> #
> # USB Imaging devices
> #
> # CONFIG_USB_MDC800 is not set
> # CONFIG_USB_MICROTEK is not set
> # CONFIG_USB_DWC3 is not set
> # CONFIG_USB_CHIPIDEA is not set
> 
> #
> # USB port drivers
> #
> # CONFIG_USB_SERIAL is not set
> 
> #
> # USB Miscellaneous drivers
> #
> # CONFIG_USB_EMI62 is not set
> # CONFIG_USB_EMI26 is not set
> # CONFIG_USB_ADUTUX is not set
> # CONFIG_USB_SEVSEG is not set
> # CONFIG_USB_RIO500 is not set
> # CONFIG_USB_LEGOTOWER is not set
> # CONFIG_USB_LCD is not set
> # CONFIG_USB_LED is not set
> # CONFIG_USB_CYPRESS_CY7C63 is not set
> # CONFIG_USB_CYTHERM is not set
> # CONFIG_USB_IDMOUSE is not set
> # CONFIG_USB_FTDI_ELAN is not set
> # CONFIG_USB_APPLEDISPLAY is not set
> # CONFIG_USB_SISUSBVGA is not set
> # CONFIG_USB_LD is not set
> # CONFIG_USB_TRANCEVIBRATOR is not set
> # CONFIG_USB_IOWARRIOR is not set
> # CONFIG_USB_TEST is not set
> # CONFIG_USB_ISIGHTFW is not set
> # CONFIG_USB_YUREX is not set
> # CONFIG_USB_EZUSB_FX2 is not set
> # CONFIG_USB_HSIC_USB3503 is not set
> CONFIG_USB_PHY=y
> # CONFIG_NOP_USB_XCEIV is not set
> # CONFIG_OMAP_CONTROL_USB is not set
> # CONFIG_OMAP_USB2 is not set
> # CONFIG_OMAP_USB3 is not set
> # CONFIG_SAMSUNG_USB2PHY is not set
> # CONFIG_SAMSUNG_USB3PHY is not set
> CONFIG_TWL4030_USB=y
> # CONFIG_USB_GPIO_VBUS is not set
> # CONFIG_USB_ISP1301 is not set
> # CONFIG_USB_RCAR_PHY is not set
> # CONFIG_USB_ULPI is not set
> CONFIG_USB_GADGET=y
> CONFIG_USB_GADGET_DEBUG=y
> CONFIG_USB_GADGET_DEBUG_FILES=y
> CONFIG_USB_GADGET_VBUS_DRAW=2
> CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
> 
> #
> # USB Peripheral Controller
> #
> # CONFIG_USB_FUSB300 is not set
> # CONFIG_USB_FOTG210_UDC is not set
> # CONFIG_USB_R8A66597 is not set
> # CONFIG_USB_PXA27X is not set
> # CONFIG_USB_MV_UDC is not set
> # CONFIG_USB_MV_U3D is not set
> # CONFIG_USB_M66592 is not set
> # CONFIG_USB_NET2272 is not set
> # CONFIG_USB_DUMMY_HCD is not set
> CONFIG_USB_LIBCOMPOSITE=m
> CONFIG_USB_U_ETHER=m
> CONFIG_USB_U_RNDIS=m
> CONFIG_USB_F_ECM=m
> CONFIG_USB_F_SUBSET=m
> # CONFIG_USB_CONFIGFS is not set
> # CONFIG_USB_ZERO is not set
> CONFIG_USB_ETH=m
> # CONFIG_USB_ETH_RNDIS is not set
> # CONFIG_USB_ETH_EEM is not set
> # CONFIG_USB_G_NCM is not set
> # CONFIG_USB_GADGETFS is not set
> # CONFIG_USB_FUNCTIONFS is not set
> # CONFIG_USB_MASS_STORAGE is not set
> # CONFIG_USB_G_SERIAL is not set
> # CONFIG_USB_G_PRINTER is not set
> # CONFIG_USB_CDC_COMPOSITE is not set
> # CONFIG_USB_G_ACM_MS is not set
> # CONFIG_USB_G_MULTI is not set
> # CONFIG_USB_G_HID is not set
> # CONFIG_USB_G_DBGP is not set
> CONFIG_MMC=y
> # CONFIG_MMC_DEBUG is not set
> CONFIG_MMC_UNSAFE_RESUME=y
> # CONFIG_MMC_CLKGATE is not set
> 
> #
> # MMC/SD/SDIO Card Drivers
> #
> CONFIG_MMC_BLOCK=y
> CONFIG_MMC_BLOCK_MINORS=8
> CONFIG_MMC_BLOCK_BOUNCE=y
> CONFIG_SDIO_UART=y
> # CONFIG_MMC_TEST is not set
> 
> #
> # MMC/SD/SDIO Host Controller Drivers
> #
> # CONFIG_MMC_SDHCI is not set
> # CONFIG_MMC_SDHCI_PXAV3 is not set
> # CONFIG_MMC_SDHCI_PXAV2 is not set
> CONFIG_MMC_OMAP=y
> CONFIG_MMC_OMAP_HS=y
> # CONFIG_MMC_DW is not set
> # CONFIG_MMC_VUB300 is not set
> # CONFIG_MMC_USHC is not set
> # CONFIG_MEMSTICK is not set
> # CONFIG_NEW_LEDS is not set
> # CONFIG_ACCESSIBILITY is not set
> # CONFIG_EDAC is not set
> CONFIG_RTC_LIB=y
> CONFIG_RTC_CLASS=y
> CONFIG_RTC_HCTOSYS=y
> CONFIG_RTC_SYSTOHC=y
> CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
> # CONFIG_RTC_DEBUG is not set
> 
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=y
> CONFIG_RTC_INTF_PROC=y
> CONFIG_RTC_INTF_DEV=y
> # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> # CONFIG_RTC_DRV_TEST is not set
> 
> #
> # I2C RTC drivers
> #
> # CONFIG_RTC_DRV_DS1307 is not set
> # CONFIG_RTC_DRV_DS1374 is not set
> # CONFIG_RTC_DRV_DS1672 is not set
> # CONFIG_RTC_DRV_DS3232 is not set
> # CONFIG_RTC_DRV_MAX6900 is not set
> # CONFIG_RTC_DRV_RS5C372 is not set
> # CONFIG_RTC_DRV_ISL1208 is not set
> # CONFIG_RTC_DRV_ISL12022 is not set
> # CONFIG_RTC_DRV_X1205 is not set
> # CONFIG_RTC_DRV_PCF2127 is not set
> # CONFIG_RTC_DRV_PCF8523 is not set
> # CONFIG_RTC_DRV_PCF8563 is not set
> # CONFIG_RTC_DRV_PCF8583 is not set
> # CONFIG_RTC_DRV_M41T80 is not set
> # CONFIG_RTC_DRV_BQ32K is not set
> CONFIG_RTC_DRV_TWL4030=y
> # CONFIG_RTC_DRV_S35390A is not set
> # CONFIG_RTC_DRV_FM3130 is not set
> # CONFIG_RTC_DRV_RX8581 is not set
> # CONFIG_RTC_DRV_RX8025 is not set
> # CONFIG_RTC_DRV_EM3027 is not set
> # CONFIG_RTC_DRV_RV3029C2 is not set
> 
> #
> # SPI RTC drivers
> #
> # CONFIG_RTC_DRV_M41T93 is not set
> # CONFIG_RTC_DRV_M41T94 is not set
> # CONFIG_RTC_DRV_DS1305 is not set
> # CONFIG_RTC_DRV_DS1390 is not set
> # CONFIG_RTC_DRV_MAX6902 is not set
> # CONFIG_RTC_DRV_R9701 is not set
> # CONFIG_RTC_DRV_RS5C348 is not set
> # CONFIG_RTC_DRV_DS3234 is not set
> # CONFIG_RTC_DRV_PCF2123 is not set
> # CONFIG_RTC_DRV_RX4581 is not set
> 
> #
> # Platform RTC drivers
> #
> # CONFIG_RTC_DRV_CMOS is not set
> # CONFIG_RTC_DRV_DS1286 is not set
> # CONFIG_RTC_DRV_DS1511 is not set
> # CONFIG_RTC_DRV_DS1553 is not set
> # CONFIG_RTC_DRV_DS1742 is not set
> # CONFIG_RTC_DRV_STK17TA8 is not set
> # CONFIG_RTC_DRV_M48T86 is not set
> # CONFIG_RTC_DRV_M48T35 is not set
> # CONFIG_RTC_DRV_M48T59 is not set
> # CONFIG_RTC_DRV_MSM6242 is not set
> # CONFIG_RTC_DRV_BQ4802 is not set
> # CONFIG_RTC_DRV_RP5C01 is not set
> # CONFIG_RTC_DRV_V3020 is not set
> # CONFIG_RTC_DRV_DS2404 is not set
> 
> #
> # on-CPU RTC drivers
> #
> # CONFIG_RTC_DRV_SNVS is not set
> 
> #
> # HID Sensor RTC drivers
> #
> # CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
> CONFIG_DMADEVICES=y
> # CONFIG_DMADEVICES_DEBUG is not set
> 
> #
> # DMA Devices
> #
> # CONFIG_DW_DMAC_CORE is not set
> # CONFIG_DW_DMAC is not set
> # CONFIG_TIMB_DMA is not set
> # CONFIG_TI_EDMA is not set
> CONFIG_DMA_OMAP=y
> CONFIG_DMA_ENGINE=y
> CONFIG_DMA_VIRTUAL_CHANNELS=y
> CONFIG_DMA_OF=y
> 
> #
> # DMA Clients
> #
> # CONFIG_NET_DMA is not set
> # CONFIG_ASYNC_TX_DMA is not set
> # CONFIG_DMATEST is not set
> # CONFIG_AUXDISPLAY is not set
> # CONFIG_UIO is not set
> # CONFIG_VIRT_DRIVERS is not set
> 
> #
> # Virtio drivers
> #
> # CONFIG_VIRTIO_MMIO is not set
> 
> #
> # Microsoft Hyper-V guest support
> #
> # CONFIG_STAGING is not set
> CONFIG_CLKDEV_LOOKUP=y
> CONFIG_HAVE_CLK_PREPARE=y
> CONFIG_COMMON_CLK=y
> 
> #
> # Common Clock Framework
> #
> # CONFIG_COMMON_CLK_DEBUG is not set
> # CONFIG_COMMON_CLK_SI5351 is not set
> 
> #
> # Hardware Spinlock drivers
> #
> CONFIG_CLKSRC_MMIO=y
> # CONFIG_MAILBOX is not set
> CONFIG_IOMMU_SUPPORT=y
> CONFIG_OF_IOMMU=y
> # CONFIG_OMAP_IOMMU is not set
> 
> #
> # Remoteproc drivers
> #
> # CONFIG_STE_MODEM_RPROC is not set
> 
> #
> # Rpmsg drivers
> #
> # CONFIG_PM_DEVFREQ is not set
> # CONFIG_EXTCON is not set
> # CONFIG_MEMORY is not set
> # CONFIG_IIO is not set
> # CONFIG_PWM is not set
> CONFIG_IRQCHIP=y
> # CONFIG_IPACK_BUS is not set
> # CONFIG_RESET_CONTROLLER is not set
> # CONFIG_FMC is not set
> 
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=y
> # CONFIG_EXT2_FS is not set
> # CONFIG_EXT3_FS is not set
> CONFIG_EXT4_FS=y
> CONFIG_EXT4_USE_FOR_EXT23=y
> # CONFIG_EXT4_FS_POSIX_ACL is not set
> # CONFIG_EXT4_FS_SECURITY is not set
> # CONFIG_EXT4_DEBUG is not set
> CONFIG_JBD2=y
> # CONFIG_JBD2_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> # CONFIG_XFS_FS is not set
> # CONFIG_GFS2_FS is not set
> # CONFIG_OCFS2_FS is not set
> # CONFIG_BTRFS_FS is not set
> # CONFIG_NILFS2_FS is not set
> # CONFIG_FS_POSIX_ACL is not set
> # CONFIG_FILE_LOCKING is not set
> # CONFIG_FSNOTIFY is not set
> # CONFIG_DNOTIFY is not set
> # CONFIG_INOTIFY_USER is not set
> # CONFIG_FANOTIFY is not set
> # CONFIG_QUOTA is not set
> # CONFIG_QUOTACTL is not set
> # CONFIG_AUTOFS4_FS is not set
> # CONFIG_FUSE_FS is not set
> 
> #
> # Caches
> #
> # CONFIG_FSCACHE is not set
> 
> #
> # CD-ROM/DVD Filesystems
> #
> # CONFIG_ISO9660_FS is not set
> # CONFIG_UDF_FS is not set
> 
> #
> # DOS/FAT/NT Filesystems
> #
> # CONFIG_MSDOS_FS is not set
> # CONFIG_VFAT_FS is not set
> # CONFIG_NTFS_FS is not set
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_SYSCTL=y
> CONFIG_PROC_PAGE_MONITOR=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> # CONFIG_TMPFS_POSIX_ACL is not set
> # CONFIG_TMPFS_XATTR is not set
> # CONFIG_HUGETLB_PAGE is not set
> CONFIG_CONFIGFS_FS=m
> # CONFIG_MISC_FILESYSTEMS is not set
> # CONFIG_NETWORK_FILESYSTEMS is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_437=y
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> # CONFIG_NLS_ASCII is not set
> CONFIG_NLS_ISO8859_1=y
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> # CONFIG_NLS_ISO8859_15 is not set
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> # CONFIG_NLS_MAC_ROMAN is not set
> # CONFIG_NLS_MAC_CELTIC is not set
> # CONFIG_NLS_MAC_CENTEURO is not set
> # CONFIG_NLS_MAC_CROATIAN is not set
> # CONFIG_NLS_MAC_CYRILLIC is not set
> # CONFIG_NLS_MAC_GAELIC is not set
> # CONFIG_NLS_MAC_GREEK is not set
> # CONFIG_NLS_MAC_ICELAND is not set
> # CONFIG_NLS_MAC_INUIT is not set
> # CONFIG_NLS_MAC_ROMANIAN is not set
> # CONFIG_NLS_MAC_TURKISH is not set
> # CONFIG_NLS_UTF8 is not set
> # CONFIG_DLM is not set
> 
> #
> # Kernel hacking
> #
> 
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=y
> CONFIG_DEFAULT_MESSAGE_LOGLEVEL=7
> # CONFIG_BOOT_PRINTK_DELAY is not set
> 
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=y
> # CONFIG_DEBUG_INFO_REDUCED is not set
> CONFIG_ENABLE_WARN_DEPRECATED=y
> CONFIG_ENABLE_MUST_CHECK=y
> CONFIG_FRAME_WARN=1024
> # CONFIG_STRIP_ASM_SYMS is not set
> # CONFIG_READABLE_ASM is not set
> # CONFIG_UNUSED_SYMBOLS is not set
> # CONFIG_DEBUG_FS is not set
> # CONFIG_HEADERS_CHECK is not set
> # CONFIG_DEBUG_SECTION_MISMATCH is not set
> CONFIG_FRAME_POINTER=y
> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_DEBUG_KERNEL=y
> 
> #
> # Memory Debugging
> #
> # CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_DEBUG_OBJECTS is not set
> # CONFIG_SLUB_DEBUG_ON is not set
> # CONFIG_SLUB_STATS is not set
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> # CONFIG_DEBUG_KMEMLEAK is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> # CONFIG_DEBUG_VM is not set
> # CONFIG_DEBUG_MEMORY_INIT is not set
> # CONFIG_DEBUG_HIGHMEM is not set
> # CONFIG_DEBUG_SHIRQ is not set
> 
> #
> # Debug Lockups and Hangs
> #
> # CONFIG_LOCKUP_DETECTOR is not set
> # CONFIG_DETECT_HUNG_TASK is not set
> # CONFIG_PANIC_ON_OOPS is not set
> CONFIG_PANIC_ON_OOPS_VALUE=0
> # CONFIG_SCHED_DEBUG is not set
> # CONFIG_SCHEDSTATS is not set
> # CONFIG_TIMER_STATS is not set
> 
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> # CONFIG_DEBUG_RT_MUTEXES is not set
> # CONFIG_RT_MUTEX_TESTER is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_MUTEXES is not set
> # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> # CONFIG_DEBUG_LOCK_ALLOC is not set
> # CONFIG_PROVE_LOCKING is not set
> # CONFIG_LOCK_STAT is not set
> # CONFIG_DEBUG_ATOMIC_SLEEP is not set
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> # CONFIG_DEBUG_KOBJECT is not set
> # CONFIG_DEBUG_BUGVERBOSE is not set
> # CONFIG_DEBUG_WRITECOUNT is not set
> # CONFIG_DEBUG_LIST is not set
> # CONFIG_DEBUG_SG is not set
> # CONFIG_DEBUG_NOTIFIERS is not set
> # CONFIG_DEBUG_CREDENTIALS is not set
> 
> #
> # RCU Debugging
> #
> # CONFIG_SPARSE_RCU_POINTER is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_RCU_TRACE is not set
> # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> # CONFIG_FAULT_INJECTION is not set
> # CONFIG_LATENCYTOP is not set
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_HAVE_C_RECORDMCOUNT=y
> CONFIG_TRACE_CLOCK=y
> CONFIG_RING_BUFFER=y
> CONFIG_RING_BUFFER_ALLOW_SWAP=y
> CONFIG_TRACING_SUPPORT=y
> # CONFIG_FTRACE is not set
> 
> #
> # Runtime Testing
> #
> # CONFIG_TEST_LIST_SORT is not set
> # CONFIG_KPROBES_SANITY_TEST is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_RBTREE_TEST is not set
> # CONFIG_INTERVAL_TREE_TEST is not set
> # CONFIG_ATOMIC64_SELFTEST is not set
> # CONFIG_TEST_STRING_HELPERS is not set
> # CONFIG_TEST_KSTRTOX is not set
> # CONFIG_DMA_API_DEBUG is not set
> # CONFIG_SAMPLES is not set
> CONFIG_HAVE_ARCH_KGDB=y
> # CONFIG_KGDB is not set
> # CONFIG_STRICT_DEVMEM is not set
> # CONFIG_ARM_UNWIND is not set
> # CONFIG_DEBUG_USER is not set
> CONFIG_DEBUG_LL=y
> CONFIG_DEBUG_OMAP2PLUS_UART=y
> # CONFIG_DEBUG_ICEDCC is not set
> # CONFIG_DEBUG_SEMIHOSTING is not set
> # CONFIG_DEBUG_OMAP2UART1 is not set
> # CONFIG_DEBUG_OMAP2UART2 is not set
> # CONFIG_DEBUG_OMAP2UART3 is not set
> CONFIG_DEBUG_OMAP3UART3=y
> # CONFIG_DEBUG_OMAP4UART3 is not set
> # CONFIG_DEBUG_OMAP3UART4 is not set
> # CONFIG_DEBUG_OMAP4UART4 is not set
> # CONFIG_DEBUG_TI81XXUART1 is not set
> # CONFIG_DEBUG_TI81XXUART2 is not set
> # CONFIG_DEBUG_TI81XXUART3 is not set
> # CONFIG_DEBUG_AM33XXUART1 is not set
> # CONFIG_DEBUG_ZOOM_UART is not set
> CONFIG_DEBUG_LL_INCLUDE="debug/omap2plus.S"
> CONFIG_UNCOMPRESS_INCLUDE="debug/uncompress.h"
> CONFIG_EARLY_PRINTK=y
> # CONFIG_ARM_KPROBES_TEST is not set
> # CONFIG_PID_IN_CONTEXTIDR is not set
> 
> #
> # Security options
> #
> # CONFIG_KEYS is not set
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> # CONFIG_SECURITY is not set
> # CONFIG_SECURITYFS is not set
> CONFIG_DEFAULT_SECURITY_DAC=y
> CONFIG_DEFAULT_SECURITY=""
> CONFIG_CRYPTO=y
> 
> #
> # Crypto core or helper
> #
> # CONFIG_CRYPTO_FIPS is not set
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG=m
> CONFIG_CRYPTO_RNG2=m
> # CONFIG_CRYPTO_MANAGER is not set
> # CONFIG_CRYPTO_MANAGER2 is not set
> # CONFIG_CRYPTO_USER is not set
> # CONFIG_CRYPTO_GF128MUL is not set
> # CONFIG_CRYPTO_NULL is not set
> # CONFIG_CRYPTO_CRYPTD is not set
> # CONFIG_CRYPTO_AUTHENC is not set
> # CONFIG_CRYPTO_TEST is not set
> 
> #
> # Authenticated Encryption with Associated Data
> #
> # CONFIG_CRYPTO_CCM is not set
> # CONFIG_CRYPTO_GCM is not set
> # CONFIG_CRYPTO_SEQIV is not set
> 
> #
> # Block modes
> #
> # CONFIG_CRYPTO_CBC is not set
> # CONFIG_CRYPTO_CTR is not set
> # CONFIG_CRYPTO_CTS is not set
> # CONFIG_CRYPTO_ECB is not set
> # CONFIG_CRYPTO_LRW is not set
> # CONFIG_CRYPTO_PCBC is not set
> # CONFIG_CRYPTO_XTS is not set
> 
> #
> # Hash modes
> #
> # CONFIG_CRYPTO_CMAC is not set
> # CONFIG_CRYPTO_HMAC is not set
> # CONFIG_CRYPTO_XCBC is not set
> # CONFIG_CRYPTO_VMAC is not set
> 
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=y
> # CONFIG_CRYPTO_CRC32 is not set
> # CONFIG_CRYPTO_CRCT10DIF is not set
> # CONFIG_CRYPTO_GHASH is not set
> # CONFIG_CRYPTO_MD4 is not set
> # CONFIG_CRYPTO_MD5 is not set
> # CONFIG_CRYPTO_MICHAEL_MIC is not set
> # CONFIG_CRYPTO_RMD128 is not set
> # CONFIG_CRYPTO_RMD160 is not set
> # CONFIG_CRYPTO_RMD256 is not set
> # CONFIG_CRYPTO_RMD320 is not set
> # CONFIG_CRYPTO_SHA1 is not set
> # CONFIG_CRYPTO_SHA1_ARM is not set
> # CONFIG_CRYPTO_SHA256 is not set
> # CONFIG_CRYPTO_SHA512 is not set
> # CONFIG_CRYPTO_TGR192 is not set
> # CONFIG_CRYPTO_WP512 is not set
> 
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=y
> # CONFIG_CRYPTO_AES_ARM is not set
> # CONFIG_CRYPTO_ANUBIS is not set
> # CONFIG_CRYPTO_ARC4 is not set
> # CONFIG_CRYPTO_BLOWFISH is not set
> # CONFIG_CRYPTO_CAMELLIA is not set
> # CONFIG_CRYPTO_CAST5 is not set
> # CONFIG_CRYPTO_CAST6 is not set
> # CONFIG_CRYPTO_DES is not set
> # CONFIG_CRYPTO_FCRYPT is not set
> # CONFIG_CRYPTO_KHAZAD is not set
> # CONFIG_CRYPTO_SALSA20 is not set
> # CONFIG_CRYPTO_SEED is not set
> # CONFIG_CRYPTO_SERPENT is not set
> # CONFIG_CRYPTO_TEA is not set
> # CONFIG_CRYPTO_TWOFISH is not set
> 
> #
> # Compression
> #
> # CONFIG_CRYPTO_DEFLATE is not set
> # CONFIG_CRYPTO_ZLIB is not set
> # CONFIG_CRYPTO_LZO is not set
> # CONFIG_CRYPTO_LZ4 is not set
> # CONFIG_CRYPTO_LZ4HC is not set
> 
> #
> # Random Number Generation
> #
> CONFIG_CRYPTO_ANSI_CPRNG=m
> # CONFIG_CRYPTO_USER_API_HASH is not set
> # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
> CONFIG_CRYPTO_HW=y
> # CONFIG_CRYPTO_DEV_OMAP_SHAM is not set
> # CONFIG_CRYPTO_DEV_OMAP_AES is not set
> # CONFIG_BINARY_PRINTF is not set
> 
> #
> # Library routines
> #
> CONFIG_BITREVERSE=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_GENERIC_NET_UTILS=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_GENERIC_IO=y
> # CONFIG_CRC_CCITT is not set
> CONFIG_CRC16=y
> # CONFIG_CRC_T10DIF is not set
> # CONFIG_CRC_ITU_T is not set
> CONFIG_CRC32=y
> # CONFIG_CRC32_SELFTEST is not set
> CONFIG_CRC32_SLICEBY8=y
> # CONFIG_CRC32_SLICEBY4 is not set
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> # CONFIG_CRC7 is not set
> # CONFIG_LIBCRC32C is not set
> # CONFIG_CRC8 is not set
> CONFIG_LZO_COMPRESS=y
> CONFIG_LZO_DECOMPRESS=y
> # CONFIG_XZ_DEC is not set
> # CONFIG_XZ_DEC_BCJ is not set
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT=y
> CONFIG_HAS_DMA=y
> CONFIG_DQL=y
> CONFIG_NLATTR=y
> CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE=y
> # CONFIG_AVERAGE is not set
> # CONFIG_CORDIC is not set
> # CONFIG_DDR is not set
> CONFIG_FONT_SUPPORT=y
> CONFIG_FONTS=y
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> # CONFIG_FONT_6x11 is not set
> # CONFIG_FONT_7x14 is not set
> # CONFIG_FONT_PEARL_8x8 is not set
> # CONFIG_FONT_ACORN_8x8 is not set
> # CONFIG_FONT_MINI_4x6 is not set
> # CONFIG_FONT_SUN8x16 is not set
> # CONFIG_FONT_SUN12x22 is not set
> # CONFIG_FONT_10x18 is not set
> # CONFIG_VIRTUALIZATION is not set
> 
> A.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
