From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: OMAP3EVM not booting on l-o master
Date: Thu, 5 Apr 2012 10:11:50 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A9317C47AD@DBDE01.ent.ti.com>
References: <C8443D0743D26F4388EA172BF4E2A7A9317C3A03@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317C3B18@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204050330380.10302@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58744 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753113Ab2DEKLy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 06:11:54 -0400
In-Reply-To: <alpine.DEB.2.00.1204050330380.10302@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Paul,

On Thu, Apr 05, 2012 at 15:03:36, Paul Walmsley wrote:
> Could you try booting with initcall_debug and posting the boot log?

Logs as follows,

Regards
Afzal


Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.4.0-rc1-11705-g33fc21e (afzal@linux-psp-=
server.india.ext.ti.com) (gcc version 4.5.3 20110311 (prerelease) (GCC)=
 ) #5 SMP Thu Apr 5 15:19:27 IST 2012
[    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=3D=
10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasin=
g instruction cache
[    0.000000] Machine: OMAP3 EVM
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 32512
[    0.000000] free_area_init_node: node 0, pgdat c06b3cc0, node_mem_ma=
p c0c0a000
[    0.000000]   Normal zone: 256 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 32256 pages, LIFO batch:7
[    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
[    0.000000] PERCPU: Embedded 8 pages/cpu @c0d0e000 s11456 r8192 d131=
20 u32768
[    0.000000] pcpu-alloc: s11456 r8192 d13120 u32768 alloc=3D8*4096
[    0.000000] pcpu-alloc: [0] 0=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  =
Total pages: 32256
[    0.000000] Kernel command line: console=3DttyO0,115200n8 root/dev/r=
am rw earlyprintk mem=3D128M initrd=3D0x81338000,0x1f6c2f initcall_debu=
g debug
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 =
bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 by=
tes)
[    0.000000] Memory: 127MB =3D 127MB total
[    0.000000] Memory: 114536k/114536k available, 16536k reserved, 0K h=
ighmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc05d2e34   (5932 kB)
[    0.000000]       .init : 0xc05d3000 - 0xc0621cc0   ( 316 kB)
[    0.000000]       .data : 0xc0622000 - 0xc06b5958   ( 591 kB)
[    0.000000]        .bss : 0xc06b597c - 0xc0c09be0   (5457 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:474
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 =
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps=
 every 131071999ms
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, I=
nc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.001129] Calibrating delay loop... 497.82 BogoMIPS (lpj=3D1941504=
)
[    0.085906] pid_max: default: 32768 minimum: 301
[    0.086883] Security Framework initialized
[    0.087219] Mount-cache hash table entries: 512
[    0.093780] CPU: Testing write buffer coherency: ok
[    0.094970] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.095001] calling  init_static_idmap+0x0/0xe0 @ 1
[    0.095123] Setting up static identity map for 0x804278b8 - 0x804279=
28
[    0.095153] initcall init_static_idmap+0x0/0xe0 returned 0 after 0 u=
secs
[    0.095184] calling  omap4_sar_ram_init+0x0/0x60 @ 1
[    0.095214] initcall omap4_sar_ram_init+0x0/0x60 returned -12 after =
0 usecs
[    0.095245] initcall omap4_sar_ram_init+0x0/0x60 returned with error=
 code -12=20
[    0.095275] calling  omap_l2_cache_init+0x0/0xec @ 1
[    0.095306] initcall omap_l2_cache_init+0x0/0xec returned -19 after =
0 usecs
[    0.095336] calling  spawn_ksoftirqd+0x0/0x54 @ 1
[    0.095825] initcall spawn_ksoftirqd+0x0/0x54 returned 0 after 0 use=
cs
[    0.095855] calling  init_workqueues+0x0/0x3c8 @ 1
[    0.097015] initcall init_workqueues+0x0/0x3c8 returned 0 after 0 us=
ecs
[    0.097045] calling  migration_init+0x0/0x78 @ 1
[    0.097106] initcall migration_init+0x0/0x78 returned 0 after 0 usec=
s
[    0.097137] calling  cpu_stop_init+0x0/0xd8 @ 1
[    0.097473] initcall cpu_stop_init+0x0/0xd8 returned 0 after 0 usecs
[    0.097503] calling  rcu_scheduler_really_started+0x0/0x18 @ 1
[    0.097534] initcall rcu_scheduler_really_started+0x0/0x18 returned =
0 after 0 usecs
[    0.097564] calling  tracer_alloc_buffers+0x0/0x1a0 @ 1
[    0.098052] initcall tracer_alloc_buffers+0x0/0x1a0 returned 0 after=
 0 usecs
[    0.098083] calling  init_trace_printk+0x0/0xc @ 1
[    0.098114] initcall init_trace_printk+0x0/0xc returned 0 after 0 us=
ecs
[    0.098144] Brought up 1 CPUs
[    0.098175] SMP: Total of 1 processors activated (497.82 BogoMIPS).
[    0.113342] calling  ipc_ns_init+0x0/0x40 @ 1
[    0.113403] initcall ipc_ns_init+0x0/0x40 returned 0 after 0 usecs
[    0.113433] calling  init_mmap_min_addr+0x0/0x20 @ 1
[    0.113464] initcall init_mmap_min_addr+0x0/0x20 returned 0 after 0 =
usecs
[    0.113494] calling  init_atomic64_lock+0x0/0x3c @ 1
[    0.113525] initcall init_atomic64_lock+0x0/0x3c returned 0 after 0 =
usecs
[    0.113555] calling  net_ns_init+0x0/0x19c @ 1
[    0.113708] initcall net_ns_init+0x0/0x19c returned 0 after 0 usecs
[    0.113861] calling  ptrace_break_init+0x0/0x2c @ 1
[    0.113952] initcall ptrace_break_init+0x0/0x2c returned 0 after 0 u=
secs
[    0.113983] calling  consistent_init+0x0/0x128 @ 1
[    0.114044] initcall consistent_init+0x0/0x128 returned 0 after 0 us=
ecs
[    0.114074] calling  v6_userpage_init+0x0/0x38 @ 1
[    0.114105] initcall v6_userpage_init+0x0/0x38 returned 0 after 0 us=
ecs
[    0.114135] calling  omap_serial_early_init+0x0/0x144 @ 1
[    0.114166] ttyO0 used as console in debug mode uart0 clocks will no=
t be gated
[    0.114227] initcall omap_serial_early_init+0x0/0x144 returned 0 aft=
er 0 usecs
[    0.114257] calling  omap_hwmod_setup_all+0x0/0x34 @ 1
[    0.117523] initcall omap_hwmod_setup_all+0x0/0x34 returned 0 after =
7629 usecs
[    0.117584] calling  omap_device_init+0x0/0x20 @ 1
[    0.117614] initcall omap_device_init+0x0/0x20 returned 0 after 0 us=
ecs
[    0.117614] calling  cpu_hotplug_pm_sync_init+0x0/0x18 @ 1
[    0.117645] initcall cpu_hotplug_pm_sync_init+0x0/0x18 returned 0 af=
ter 0 usecs
[    0.117675] calling  alloc_frozen_cpus+0x0/0x8 @ 1
[    0.117706] initcall alloc_frozen_cpus+0x0/0x8 returned 0 after 0 us=
ecs
[    0.117736] calling  ksysfs_init+0x0/0x98 @ 1
[    0.117950] initcall ksysfs_init+0x0/0x98 returned 0 after 0 usecs
[    0.117980] calling  pm_init+0x0/0x78 @ 1
[    0.118133] initcall pm_init+0x0/0x78 returned 0 after 0 usecs
[    0.118164] calling  init_jiffies_clocksource+0x0/0xc @ 1
[    0.118255] initcall init_jiffies_clocksource+0x0/0xc returned 0 aft=
er 0 usecs
[    0.118286] calling  cpu_pm_init+0x0/0x18 @ 1
[    0.118408] initcall cpu_pm_init+0x0/0x18 returned 0 after 0 usecs
[    0.118438] calling  init_zero_pfn+0x0/0x44 @ 1
[    0.118469] initcall init_zero_pfn+0x0/0x44 returned 0 after 0 usecs
[    0.118499] calling  fsnotify_init+0x0/0x34 @ 1
[    0.118560] initcall fsnotify_init+0x0/0x34 returned 0 after 0 usecs
[    0.118591] calling  filelock_init+0x0/0x40 @ 1
[    0.118713] initcall filelock_init+0x0/0x40 returned 0 after 0 usecs
[    0.118743] calling  init_misc_binfmt+0x0/0x30 @ 1
[    0.118865] initcall init_misc_binfmt+0x0/0x30 returned 0 after 0 us=
ecs
[    0.118896] calling  init_script_binfmt+0x0/0x1c @ 1
[    0.118927] initcall init_script_binfmt+0x0/0x1c returned 0 after 0 =
usecs
[    0.118957] calling  init_elf_binfmt+0x0/0x1c @ 1
[    0.118988] initcall init_elf_binfmt+0x0/0x1c returned 0 after 0 use=
cs
[    0.119018] calling  debugfs_init+0x0/0x60 @ 1
[    0.119079] initcall debugfs_init+0x0/0x60 returned 0 after 0 usecs
[    0.119110] calling  random32_init+0x0/0xdc @ 1
[    0.119140] initcall random32_init+0x0/0xdc returned 0 after 0 usecs
[    0.119171] calling  regulator_init+0x0/0x80 @ 1
[    0.126861] dummy:=20
[    0.128265] initcall regulator_init+0x0/0x80 returned 0 after 7629 u=
secs
[    0.128295] calling  sock_init+0x0/0x94 @ 1
[    0.129455] initcall sock_init+0x0/0x94 returned 0 after 0 usecs
[    0.129486] calling  netlink_proto_init+0x0/0x1a0 @ 1
[    0.129791] NET: Registered protocol family 16
[    0.130065] initcall netlink_proto_init+0x0/0x1a0 returned 0 after 0=
 usecs
[    0.130279] calling  omap4_l3_init+0x0/0xe8 @ 1
[    0.130310] initcall omap4_l3_init+0x0/0xe8 returned -19 after 0 use=
cs
[    0.130310] calling  omap3_l3_init+0x0/0xb8 @ 1
[    0.131500] initcall omap3_l3_init+0x0/0xb8 returned 0 after 0 usecs
[    0.131530] calling  gpmc_init+0x0/0x2e0 @ 1
[    0.131683] GPMC revision 5.0
[    0.132049] initcall gpmc_init+0x0/0x2e0 returned 0 after 0 usecs
[    0.132080] calling  omap2_common_pm_init+0x0/0x90 @ 1
[    0.135192] initcall omap2_common_pm_init+0x0/0x90 returned 0 after =
7629 usecs
[    0.135223] calling  omap2_gpio_init+0x0/0x18 @ 1
[    0.141510] initcall omap2_gpio_init+0x0/0x18 returned 0 after 7629 =
usecs
[    0.141540] calling  bdi_class_init+0x0/0x58 @ 1
[    0.142272] initcall bdi_class_init+0x0/0x58 returned 0 after 0 usec=
s
[    0.142333] calling  kobject_uevent_init+0x0/0x20 @ 1
[    0.142486] initcall kobject_uevent_init+0x0/0x20 returned 0 after 0=
 usecs
[    0.142517] calling  gpiolib_sysfs_init+0x0/0x98 @ 1
[    0.143341] initcall gpiolib_sysfs_init+0x0/0x98 returned 0 after 0 =
usecs
[    0.143371] calling  omap_gpio_drv_reg+0x0/0xc @ 1
[    0.146240] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.146911] OMAP GPIO hardware version 2.5
[    0.148284] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.150756] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.152679] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.154541] gpiochip_add: registered GPIOs 128 to 159 on device: gpi=
o
[    0.156799] gpiochip_add: registered GPIOs 160 to 191 on device: gpi=
o
[    0.158172] initcall omap_gpio_drv_reg+0x0/0xc returned 0 after 1525=
8 usecs
[    0.158203] calling  lcd_class_init+0x0/0x58 @ 1
[    0.158874] initcall lcd_class_init+0x0/0x58 returned 0 after 0 usec=
s
[    0.158905] calling  tty_class_init+0x0/0x44 @ 1
[    0.159515] initcall tty_class_init+0x0/0x44 returned 0 after 0 usec=
s
[    0.159545] calling  vtconsole_class_init+0x0/0xec @ 1
[    0.161285] initcall vtconsole_class_init+0x0/0xec returned 0 after =
0 usecs
[    0.161315] calling  wakeup_sources_debugfs_init+0x0/0x44 @ 1
[    0.161437] initcall wakeup_sources_debugfs_init+0x0/0x44 returned 0=
 after 0 usecs
[    0.161468] calling  regmap_initcall+0x0/0x10 @ 1
[    0.161529] initcall regmap_initcall+0x0/0x10 returned 0 after 0 use=
cs
[    0.161560] calling  spi_init+0x0/0x8c @ 1
[    0.162963] initcall spi_init+0x0/0x8c returned 0 after 0 usecs
[    0.162994] calling  i2c_init+0x0/0x74 @ 1
[    0.164916] initcall i2c_init+0x0/0x74 returned 0 after 7629 usecs
[    0.164947] calling  omap3_l3_init+0x0/0x14 @ 1
[    0.166076] initcall omap3_l3_init+0x0/0x14 returned 0 after 0 usecs
[    0.166107] calling  omap4_l3_init+0x0/0xc @ 1
[    0.166839] initcall omap4_l3_init+0x0/0xc returned 0 after 0 usecs
[    0.167022] calling  gate_vma_init+0x0/0x40 @ 1
[    0.167053] initcall gate_vma_init+0x0/0x40 returned 0 after 0 usecs
[    0.167083] calling  customize_machine+0x0/0x28 @ 1
[    0.168029] omap_mux_init: Add partition: #1: core, flags: 0
[    0.185943] Reprogramming SDRC clock to 332000000 Hz
[    0.298278] initcall customize_machine+0x0/0x28 returned 0 after 129=
699 usecs
[    0.298339] calling  init_atags_procfs+0x0/0xe4 @ 1
[    0.298400] initcall init_atags_procfs+0x0/0xe4 returned 0 after 0 u=
secs
[    0.298431] calling  arch_hw_breakpoint_init+0x0/0x1e8 @ 1
[    0.298461] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.298492] initcall arch_hw_breakpoint_init+0x0/0x1e8 returned 0 af=
ter 0 usecs
[    0.298522] calling  exceptions_init+0x0/0x90 @ 1
[    0.298553] initcall exceptions_init+0x0/0x90 returned 0 after 0 use=
cs
[    0.298583] calling  omap2_init_devices+0x0/0x74 @ 1
[    0.304321] initcall omap2_init_devices+0x0/0x74 returned 0 after 0 =
usecs
[    0.304382] calling  omap2_dm_timer_init+0x0/0x40 @ 1
[    0.316680] initcall omap2_dm_timer_init+0x0/0x40 returned 0 after 1=
5258 usecs
[    0.316741] calling  omap2_system_dma_init+0x0/0x18 @ 1
[    0.317810] initcall omap2_system_dma_init+0x0/0x18 returned 0 after=
 0 usecs
[    0.317840] calling  omap2_mcbsp_init+0x0/0x24 @ 1
[    0.319061]  omap-mcbsp.2: alias fck already exists
[    0.320068]  omap-mcbsp.3: alias fck already exists
[    0.323364] initcall omap2_mcbsp_init+0x0/0x24 returned 0 after 7629=
 usecs
[    0.323425] calling  pm_dbg_init+0x0/0xcc @ 1
[    0.325012] initcall pm_dbg_init+0x0/0xcc returned 0 after 0 usecs
[    0.325042] calling  omap2xxx_clk_arch_init+0x0/0x50 @ 1
[    0.325073] initcall omap2xxx_clk_arch_init+0x0/0x50 returned 0 afte=
r 0 usecs
[    0.325103] calling  omap3xxx_clk_arch_init+0x0/0x50 @ 1
[    0.325134] initcall omap3xxx_clk_arch_init+0x0/0x50 returned -22 af=
ter 0 usecs
[    0.325164] initcall omap3xxx_clk_arch_init+0x0/0x50 returned with e=
rror code -22=20
[    0.325195] calling  omap_init_devices+0x0/0x18 @ 1
[    0.326141] initcall omap_init_devices+0x0/0x18 returned 0 after 0 u=
secs
[    0.326171] calling  omap_system_dma_init+0x0/0xc @ 1
[    0.326843] OMAP DMA hardware revision 4.0
[    0.327606] initcall omap_system_dma_init+0x0/0xc returned 0 after 0=
 usecs
[    0.327636] calling  omap_init_fb+0x0/0xc @ 1
[    0.329040] initcall omap_init_fb+0x0/0xc returned 0 after 7629 usec=
s
[    0.329071] calling  omap_vram_init+0x0/0x8c @ 1
[    0.329193] initcall omap_vram_init+0x0/0x8c returned 0 after 0 usec=
s
[    0.329376] calling  topology_init+0x0/0x74 @ 1
[    0.330413] initcall topology_init+0x0/0x74 returned 0 after 0 usecs
[    0.330444] calling  omap_init_wdt+0x0/0xd0 @ 1
[    0.331573] initcall omap_init_wdt+0x0/0xd0 returned 0 after 0 usecs
[    0.331604] calling  omap4xxx_prcm_init+0x0/0x40 @ 1
[    0.331634] initcall omap4xxx_prcm_init+0x0/0x40 returned 0 after 0 =
usecs
[    0.331665] calling  omap3xxx_prcm_init+0x0/0x50 @ 1
[    0.331817] initcall omap3xxx_prcm_init+0x0/0x50 returned 0 after 0 =
usecs
[    0.331848] calling  rx51_video_init+0x0/0x90 @ 1
[    0.331878] initcall rx51_video_init+0x0/0x90 returned 0 after 0 use=
cs
[    0.331909] calling  omap_register_i2c_bus_cmdline+0x0/0x50 @ 1
[    0.331939] initcall omap_register_i2c_bus_cmdline+0x0/0x50 returned=
 0 after 0 usecs
[    0.331970] calling  param_sysfs_init+0x0/0x1a0 @ 1
[    0.415740] initcall param_sysfs_init+0x0/0x1a0 returned 0 after 839=
23 usecs
[    0.415771] calling  pm_sysrq_init+0x0/0x1c @ 1
[    0.415924] initcall pm_sysrq_init+0x0/0x1c returned 0 after 0 usecs
[    0.415985] calling  default_bdi_init+0x0/0xa8 @ 1
[    0.418121] initcall default_bdi_init+0x0/0xa8 returned 0 after 0 us=
ecs
[    0.418151] calling  init_bio+0x0/0xfc @ 1
[    0.418762] bio: create slab <bio-0> at 0
[    0.418853] initcall init_bio+0x0/0xfc returned 0 after 0 usecs
[    0.418884] calling  fsnotify_notification_init+0x0/0x9c @ 1
[    0.419067] initcall fsnotify_notification_init+0x0/0x9c returned 0 =
after 0 usecs
[    0.419097] calling  cryptomgr_init+0x0/0xc @ 1
[    0.419128] initcall cryptomgr_init+0x0/0xc returned 0 after 0 usecs
[    0.419158] calling  blk_settings_init+0x0/0x34 @ 1
[    0.419189] initcall blk_settings_init+0x0/0x34 returned 0 after 0 u=
secs
[    0.419189] calling  blk_ioc_init+0x0/0x40 @ 1
[    0.419311] initcall blk_ioc_init+0x0/0x40 returned 0 after 0 usecs
[    0.419342] calling  blk_softirq_init+0x0/0x84 @ 1
[    0.419372] initcall blk_softirq_init+0x0/0x84 returned 0 after 0 us=
ecs
[    0.419403] calling  blk_iopoll_setup+0x0/0x84 @ 1
[    0.419433] initcall blk_iopoll_setup+0x0/0x84 returned 0 after 0 us=
ecs
[    0.419464] calling  genhd_device_init+0x0/0x84 @ 1
[    0.420928] initcall genhd_device_init+0x0/0x84 returned 0 after 0 u=
secs
[    0.420959] calling  gpiolib_debugfs_init+0x0/0x3c @ 1
[    0.421081] initcall gpiolib_debugfs_init+0x0/0x3c returned 0 after =
0 usecs
[    0.421112] calling  gpio_twl4030_init+0x0/0xc @ 1
[    0.422637] initcall gpio_twl4030_init+0x0/0xc returned 0 after 7629=
 usecs
[    0.422668] calling  fbmem_init+0x0/0xb0 @ 1
[    0.423614] initcall fbmem_init+0x0/0xb0 returned 0 after 0 usecs
[    0.423645] calling  regulator_fixed_voltage_init+0x0/0xc @ 1
[    0.424926] dummy:=20
[    0.425109] dummy: Failed to create debugfs directory
[    0.425994] initcall regulator_fixed_voltage_init+0x0/0xc returned 0=
 after 0 usecs
[    0.426025] calling  tps_65023_init+0x0/0x10 @ 1
[    0.426727] initcall tps_65023_init+0x0/0x10 returned 0 after 0 usec=
s
[    0.426757] calling  tps6507x_pmic_init+0x0/0xc @ 1
[    0.427581] initcall tps6507x_pmic_init+0x0/0xc returned 0 after 0 u=
secs
[    0.427612] calling  twlreg_init+0x0/0xc @ 1
[    0.428466] initcall twlreg_init+0x0/0xc returned 0 after 0 usecs
[    0.428497] calling  misc_init+0x0/0xc0 @ 1
[    0.429199] initcall misc_init+0x0/0xc0 returned 0 after 0 usecs
[    0.429229] calling  cn_init+0x0/0xac @ 1
[    0.429382] initcall cn_init+0x0/0xac returned 0 after 0 usecs
[    0.429412] calling  twl_init+0x0/0x10 @ 1
[    0.430511] initcall twl_init+0x0/0x10 returned 0 after 7629 usecs
[    0.430541] calling  init_scsi+0x0/0x88 @ 1
[    0.433563] SCSI subsystem initialized
[    0.433624] initcall init_scsi+0x0/0x88 returned 0 after 0 usecs
[    0.433654] calling  omap2_mcspi_init+0x0/0x14 @ 1
[    0.436187] omap2_mcspi omap2_mcspi.1: master is unqueued, this is d=
eprecated
[    0.440551] omap2_mcspi omap2_mcspi.2: master is unqueued, this is d=
eprecated
[    0.442138] omap2_mcspi omap2_mcspi.3: master is unqueued, this is d=
eprecated
[    0.443664] omap2_mcspi omap2_mcspi.4: master is unqueued, this is d=
eprecated
[    0.444519] initcall omap2_mcspi_init+0x0/0x14 returned 0 after 7629=
 usecs
[    0.444549] calling  phy_init+0x0/0x3c @ 1
[    0.446899] initcall phy_init+0x0/0x3c returned 0 after 7629 usecs
[    0.446929] calling  usb_init+0x0/0x17c @ 1
[    0.448669] usbcore: registered new interface driver usbfs
[    0.450103] usbcore: registered new interface driver hub
[    0.451263] usbcore: registered new device driver usb
[    0.451293] initcall usb_init+0x0/0x17c returned 0 after 0 usecs
[    0.451324] calling  usb_udc_init+0x0/0x58 @ 1
[    0.451965] initcall usb_udc_init+0x0/0x58 returned 0 after 0 usecs
[    0.451995] calling  serio_init+0x0/0x38 @ 1
[    0.452728] initcall serio_init+0x0/0x38 returned 0 after 0 usecs
[    0.452758] calling  input_init+0x0/0x11c @ 1
[    0.454010] initcall input_init+0x0/0x11c returned 0 after 7629 usec=
s
[    0.454040] calling  rtc_init+0x0/0x74 @ 1
[    0.454711] initcall rtc_init+0x0/0x74 returned 0 after 0 usecs
[    0.454742] calling  omap_i2c_init_driver+0x0/0xc @ 1
[    0.469177] omap_i2c omap_i2c.1: bus 1 rev1.3.12 at 2600 kHz
[    0.481658] twl 1-0048: PIH (irq 7) chaining IRQs 320..328
[    0.482482] twl 1-0048: power (irq 325) chaining IRQs 328..335
[    0.485992] twl4030_gpio twl4030_gpio: gpio (irq 320) chaining IRQs =
336..353
[    0.487976] gpiochip_add: registered GPIOs 192 to 211 on device: twl=
4030
[    0.501861] VIO: 1800 mV normal standby
[    0.505065] vdd_mpu_iva: 600 <--> 1450 mV normal=20
[    0.507720] vdd_core: 600 <--> 1450 mV normal=20
[    0.511260] VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
[    0.514312] VDAC: 1800 mV normal standby
[    0.517791] VPLL2: 1800 mV normal standby
[    0.520904] VSIM: 1800 <--> 3000 mV at 1800 mV normal standby
[    0.522399] omap_i2c omap_i2c.2: bus 2 rev1.3.12 at 400 kHz
[    0.539276] omap_i2c omap_i2c.3: bus 3 rev1.3.12 at 400 kHz
[    0.541351] initcall omap_i2c_init_driver+0x0/0xc returned 0 after 8=
3923 usecs
[    0.541381] calling  power_supply_class_init+0x0/0x50 @ 1
[    0.542053] initcall power_supply_class_init+0x0/0x50 returned 0 aft=
er 0 usecs
[    0.542083] calling  hwmon_init+0x0/0x48 @ 1
[    0.542694] initcall hwmon_init+0x0/0x48 returned 0 after 0 usecs
[    0.542724] calling  mmc_init+0x0/0x80 @ 1
[    0.544769] initcall mmc_init+0x0/0x80 returned 0 after 0 usecs
[    0.544799] calling  proto_init+0x0/0xc @ 1
[    0.544891] initcall proto_init+0x0/0xc returned 0 after 0 usecs
[    0.544891] calling  net_dev_init+0x0/0x208 @ 1
[    0.550628] initcall net_dev_init+0x0/0x208 returned 0 after 7629 us=
ecs
[    0.550659] calling  neigh_init+0x0/0xa4 @ 1
[    0.550689] initcall neigh_init+0x0/0xa4 returned 0 after 0 usecs
[    0.550720] calling  genl_init+0x0/0x98 @ 1
[    0.551055] initcall genl_init+0x0/0x98 returned 0 after 0 usecs
[    0.551086] calling  wireless_nlevent_init+0x0/0xc @ 1
[    0.551116] initcall wireless_nlevent_init+0x0/0xc returned 0 after =
0 usecs
[    0.551147] calling  net_sysctl_init+0x0/0x48 @ 1
[    0.551177] initcall net_sysctl_init+0x0/0x48 returned 0 after 0 use=
cs
[    0.551391] calling  proc_cpu_init+0x0/0x24 @ 1
[    0.551452] initcall proc_cpu_init+0x0/0x24 returned 0 after 0 usecs
[    0.551483] calling  dma_debug_do_init+0x0/0x20 @ 1
[    0.551544] initcall dma_debug_do_init+0x0/0x20 returned 0 after 0 u=
secs
[    0.551544] calling  alignment_init+0x0/0xe8 @ 1
[    0.551605] initcall alignment_init+0x0/0xe8 returned 0 after 0 usec=
s
[    0.551635] calling  clocksource_done_booting+0x0/0x58 @ 1
[    0.551696] Switching to clocksource 32k_counter
[    0.552276] initcall clocksource_done_booting+0x0/0x58 returned 0 af=
ter 119 usecs
[    0.552307] calling  tracer_init_debugfs+0x0/0x3e0 @ 1
[    0.555725] initcall tracer_init_debugfs+0x0/0x3e0 returned 0 after =
3278 usecs
[    0.555755] calling  init_trace_printk_function_export+0x0/0x40 @ 1
[    0.555908] initcall init_trace_printk_function_export+0x0/0x40 retu=
rned 0 after 89 usecs
[    0.555938] calling  event_trace_init+0x0/0x2a8 @ 1
[    0.631988] initcall event_trace_init+0x0/0x2a8 returned 0 after 742=
07 usecs
[    0.632049] calling  init_kprobe_trace+0x0/0xb0 @ 1
[    0.632171] initcall init_kprobe_trace+0x0/0xb0 returned 0 after 119=
 usecs
[    0.632202] calling  init_pipe_fs+0x0/0x50 @ 1
[    0.633056] initcall init_pipe_fs+0x0/0x50 returned 0 after 804 usec=
s
[    0.633117] calling  eventpoll_init+0x0/0xf0 @ 1
[    0.633483] initcall eventpoll_init+0x0/0xf0 returned 0 after 327 us=
ecs
[    0.633514] calling  anon_inode_init+0x0/0x64 @ 1
[    0.634216] initcall anon_inode_init+0x0/0x64 returned 0 after 625 u=
secs
[    0.634246] calling  blk_scsi_ioctl_init+0x0/0x174 @ 1
[    0.634277] initcall blk_scsi_ioctl_init+0x0/0x174 returned 0 after =
0 usecs
[    0.634307] calling  chr_dev_init+0x0/0xdc @ 1
[    0.706451] initcall chr_dev_init+0x0/0xdc returned 0 after 70393 us=
ecs
[    0.706481] calling  firmware_class_init+0x0/0x14 @ 1
[    0.707275] initcall firmware_class_init+0x0/0x14 returned 0 after 7=
15 usecs
[    0.707305] calling  sysctl_core_init+0x0/0x38 @ 1
[    0.707580] initcall sysctl_core_init+0x0/0x38 returned 0 after 208 =
usecs
[    0.707611] calling  inet_init+0x0/0x2a0 @ 1
[    0.708221] NET: Registered protocol family 2
[    0.709991] IP route cache hash table entries: 1024 (order: 0, 4096 =
bytes)
[    0.712707] TCP established hash table entries: 4096 (order: 3, 3276=
8 bytes)
[    0.713073] TCP bind hash table entries: 4096 (order: 5, 147456 byte=
s)
[    0.715789] TCP: Hash tables configured (established 4096 bind 4096)
[    0.715911] TCP: reno registered
[    0.715942] UDP hash table entries: 64 (order: 0, 5120 bytes)
[    0.716461] UDP-Lite hash table entries: 64 (order: 0, 5120 bytes)
[    0.717651] initcall inet_init+0x0/0x2a0 returned 0 after 9745 usecs
[    0.717681] calling  af_unix_init+0x0/0x54 @ 1
[    0.717803] NET: Registered protocol family 1
[    0.717956] initcall af_unix_init+0x0/0x54 returned 0 after 208 usec=
s
[    0.717987] calling  init_sunrpc+0x0/0x60 @ 1
[    0.719879] RPC: Registered named UNIX socket transport module.
[    0.719909] RPC: Registered udp transport module.
[    0.719909] RPC: Registered tcp transport module.
[    0.719940] RPC: Registered tcp NFSv4.1 backchannel transport module=
=2E
[    0.719970] initcall init_sunrpc+0x0/0x60 returned 0 after 1907 usec=
s
[    0.720031] calling  populate_rootfs+0x0/0x220 @ 1
[    0.721221] Trying to unpack rootfs image as initramfs...
[    0.723937] rootfs image is not initramfs (no cpio magic); looks lik=
e an initrd
[    0.746795] Freeing initrd memory: 2008K
[    0.746856] initcall populate_rootfs+0x0/0x220 returned 0 after 2616=
6 usecs
[    0.747039] calling  fpe_init+0x0/0x78 @ 1
[    0.747070] NetWinder Floating Point Emulator V0.97 (double precisio=
n)
[    0.747192] initcall fpe_init+0x0/0x78 returned 0 after 119 usecs
[    0.747222] calling  sched_clock_syscore_init+0x0/0x18 @ 1
[    0.747283] initcall sched_clock_syscore_init+0x0/0x18 returned 0 af=
ter 29 usecs
[    0.747314] calling  timer_init_syscore_ops+0x0/0x18 @ 1
[    0.747344] initcall timer_init_syscore_ops+0x0/0x18 returned 0 afte=
r 29 usecs
[    0.747375] calling  leds_init+0x0/0x58 @ 1
[    0.749694] initcall leds_init+0x0/0x58 returned 0 after 2235 usecs
[    0.749725] calling  omap3_opp_init+0x0/0x58 @ 1
[    0.750396] initcall omap3_opp_init+0x0/0x58 returned 0 after 596 us=
ecs
[    0.750427] calling  omap4_opp_init+0x0/0x30 @ 1
[    0.750457] initcall omap4_opp_init+0x0/0x30 returned -19 after 0 us=
ecs
[    0.750488] calling  omap_dm_timer_driver_init+0x0/0xc @ 1
[    0.754302] initcall omap_dm_timer_driver_init+0x0/0xc returned 0 af=
ter 3665 usecs
[    0.754333] calling  proc_execdomains_init+0x0/0x38 @ 1
[    0.754425] initcall proc_execdomains_init+0x0/0x38 returned 0 after=
 29 usecs
[    0.754455] calling  ioresources_init+0x0/0x58 @ 1
[    0.754516] initcall ioresources_init+0x0/0x58 returned 0 after 59 u=
secs
[    0.754547] calling  uid_cache_init+0x0/0x94 @ 1
[    0.754852] initcall uid_cache_init+0x0/0x94 returned 0 after 238 us=
ecs
[    0.754882] calling  init_posix_timers+0x0/0x1cc @ 1
[    0.755065] initcall init_posix_timers+0x0/0x1cc returned 0 after 11=
9 usecs
[    0.755096] calling  init_posix_cpu_timers+0x0/0xe4 @ 1
[    0.755126] initcall init_posix_cpu_timers+0x0/0xe4 returned 0 after=
 0 usecs
[    0.755157] calling  proc_schedstat_init+0x0/0x38 @ 1
[    0.755218] initcall proc_schedstat_init+0x0/0x38 returned 0 after 2=
9 usecs
[    0.755249] calling  init_sched_debug_procfs+0x0/0x40 @ 1
[    0.755310] initcall init_sched_debug_procfs+0x0/0x40 returned 0 aft=
er 59 usecs
[    0.755340] calling  create_proc_profile+0x0/0x254 @ 1
[    0.755584] initcall create_proc_profile+0x0/0x254 returned 0 after =
0 usecs
[    0.755645] calling  timekeeping_init_ops+0x0/0x18 @ 1
[    0.755676] initcall timekeeping_init_ops+0x0/0x18 returned 0 after =
29 usecs
[    0.755706] calling  init_clocksource_sysfs+0x0/0x54 @ 1
[    0.757659] initcall init_clocksource_sysfs+0x0/0x54 returned 0 afte=
r 1877 usecs
[    0.757690] calling  init_timer_list_procfs+0x0/0x40 @ 1
[    0.757781] initcall init_timer_list_procfs+0x0/0x40 returned 0 afte=
r 29 usecs
[    0.757812] calling  alarmtimer_init+0x0/0x1cc @ 1
[    0.760009] initcall alarmtimer_init+0x0/0x1cc returned 0 after 2115=
 usecs
[    0.760070] calling  init_tstats_procfs+0x0/0x40 @ 1
[    0.760131] initcall init_tstats_procfs+0x0/0x40 returned 0 after 29=
 usecs
[    0.760162] calling  lockdep_proc_init+0x0/0x74 @ 1
[    0.760253] initcall lockdep_proc_init+0x0/0x74 returned 0 after 89 =
usecs
[    0.760284] calling  futex_init+0x0/0x84 @ 1
[    0.760498] initcall futex_init+0x0/0x84 returned 0 after 149 usecs
[    0.760528] calling  proc_modules_init+0x0/0x38 @ 1
[    0.760559] initcall proc_modules_init+0x0/0x38 returned 0 after 29 =
usecs
[    0.760589] calling  kallsyms_init+0x0/0x38 @ 1
[    0.760650] initcall kallsyms_init+0x0/0x38 returned 0 after 29 usec=
s
[    0.760681] calling  crash_save_vmcoreinfo_init+0x0/0x3b4 @ 1
[    0.760833] initcall crash_save_vmcoreinfo_init+0x0/0x3b4 returned 0=
 after 119 usecs
[    0.760864] calling  crash_notes_memory_init+0x0/0x40 @ 1
[    0.760925] initcall crash_notes_memory_init+0x0/0x40 returned 0 aft=
er 59 usecs
[    0.760955] calling  ikconfig_init+0x0/0x54 @ 1
[    0.761016] initcall ikconfig_init+0x0/0x54 returned 0 after 29 usec=
s
[    0.761047] calling  init_kprobes+0x0/0x10c @ 1
[    0.941192] initcall init_kprobes+0x0/0x10c returned 0 after 175833 =
usecs
[    0.941223] calling  irq_gc_init_ops+0x0/0x18 @ 1
[    0.941284] initcall irq_gc_init_ops+0x0/0x18 returned 0 after 0 use=
cs
[    0.941314] calling  irq_pm_init_ops+0x0/0x18 @ 1
[    0.941345] initcall irq_pm_init_ops+0x0/0x18 returned 0 after 0 use=
cs
[    0.941375] calling  utsname_sysctl_init+0x0/0x18 @ 1
[    0.941467] initcall utsname_sysctl_init+0x0/0x18 returned 0 after 5=
9 usecs
[    0.941497] calling  init_tracepoints+0x0/0xc @ 1
[    0.941528] initcall init_tracepoints+0x0/0xc returned 0 after 0 use=
cs
[    0.941558] calling  init_events+0x0/0x6c @ 1
[    0.941650] initcall init_events+0x0/0x6c returned 0 after 29 usecs
[    0.941680] calling  perf_event_sysfs_init+0x0/0xbc @ 1
[    0.946899] initcall perf_event_sysfs_init+0x0/0xbc returned 0 after=
 5066 usecs
[    0.946929] calling  init_per_zone_wmark_min+0x0/0x94 @ 1
[    0.947326] initcall init_per_zone_wmark_min+0x0/0x94 returned 0 aft=
er 327 usecs
[    0.947357] calling  kswapd_init+0x0/0x24 @ 1
[    0.947845] initcall kswapd_init+0x0/0x24 returned 0 after 476 usecs
[    0.947875] calling  setup_vmstat+0x0/0xec @ 1
[    0.948059] initcall setup_vmstat+0x0/0xec returned 0 after 119 usec=
s
[    0.948089] calling  mm_sysfs_init+0x0/0x3c @ 1
[    0.948150] initcall mm_sysfs_init+0x0/0x3c returned 0 after 59 usec=
s
[    0.948181] calling  proc_vmalloc_init+0x0/0x38 @ 1
[    0.948242] initcall proc_vmalloc_init+0x0/0x38 returned 0 after 29 =
usecs
[    0.948272] calling  memblock_init_debugfs+0x0/0x78 @ 1
[    0.948486] initcall memblock_init_debugfs+0x0/0x78 returned 0 after=
 178 usecs
[    0.948516] calling  procswaps_init+0x0/0x38 @ 1
[    0.948577] initcall procswaps_init+0x0/0x38 returned 0 after 29 use=
cs
[    0.948608] calling  slab_proc_init+0x0/0x38 @ 1
[    0.948669] initcall slab_proc_init+0x0/0x38 returned 0 after 0 usec=
s
[    0.948699] calling  cpucache_init+0x0/0x5c @ 1
[    0.948730] initcall cpucache_init+0x0/0x5c returned 0 after 29 usec=
s
[    0.948760] calling  fcntl_init+0x0/0x40 @ 1
[    0.948944] initcall fcntl_init+0x0/0x40 returned 0 after 149 usecs
[    0.948974] calling  proc_filesystems_init+0x0/0x38 @ 1
[    0.949035] initcall proc_filesystems_init+0x0/0x38 returned 0 after=
 29 usecs
[    0.949066] calling  dio_init+0x0/0x40 @ 1
[    0.949218] initcall dio_init+0x0/0x40 returned 0 after 119 usecs
[    0.949249] calling  fsnotify_mark_init+0x0/0x40 @ 1
[    0.949523] initcall fsnotify_mark_init+0x0/0x40 returned 0 after 26=
8 usecs
[    0.949554] calling  dnotify_init+0x0/0x84 @ 1
[    0.949859] initcall dnotify_init+0x0/0x84 returned 0 after 238 usec=
s
[    0.949890] calling  inotify_user_setup+0x0/0x78 @ 1
[    0.950103] initcall inotify_user_setup+0x0/0x78 returned 0 after 17=
8 usecs
[    0.950103] calling  aio_setup+0x0/0x90 @ 1
[    0.950378] initcall aio_setup+0x0/0x90 returned 0 after 208 usecs
[    0.950408] calling  proc_locks_init+0x0/0x38 @ 1
[    0.950469] initcall proc_locks_init+0x0/0x38 returned 0 after 59 us=
ecs
[    0.950500] calling  dquot_init+0x0/0x138 @ 1
[    0.950531] VFS: Disk quotas dquot_6.5.2
[    0.951171] Dquot-cache hash table entries: 1024 (order 0, 4096 byte=
s)
[    0.951202] initcall dquot_init+0x0/0x138 returned 0 after 685 usecs
[    0.951232] calling  init_v2_quota_format+0x0/0x28 @ 1
[    0.951446] initcall init_v2_quota_format+0x0/0x28 returned 0 after =
178 usecs
[    0.951477] calling  proc_cmdline_init+0x0/0x38 @ 1
[    0.951568] initcall proc_cmdline_init+0x0/0x38 returned 0 after 29 =
usecs
[    0.951599] calling  proc_consoles_init+0x0/0x38 @ 1
[    0.951629] initcall proc_consoles_init+0x0/0x38 returned 0 after 29=
 usecs
[    0.951660] calling  proc_cpuinfo_init+0x0/0x38 @ 1
[    0.951721] initcall proc_cpuinfo_init+0x0/0x38 returned 0 after 29 =
usecs
[    0.951751] calling  proc_devices_init+0x0/0x38 @ 1
[    0.951812] initcall proc_devices_init+0x0/0x38 returned 0 after 0 u=
secs
[    0.951843] calling  proc_interrupts_init+0x0/0x38 @ 1
[    0.951904] initcall proc_interrupts_init+0x0/0x38 returned 0 after =
29 usecs
[    0.951934] calling  proc_loadavg_init+0x0/0x38 @ 1
[    0.951965] initcall proc_loadavg_init+0x0/0x38 returned 0 after 29 =
usecs
[    0.951995] calling  proc_meminfo_init+0x0/0x38 @ 1
[    0.952056] initcall proc_meminfo_init+0x0/0x38 returned 0 after 29 =
usecs
[    0.952087] calling  proc_stat_init+0x0/0x38 @ 1
[    0.952148] initcall proc_stat_init+0x0/0x38 returned 0 after 29 use=
cs
[    0.952178] calling  proc_uptime_init+0x0/0x38 @ 1
[    0.952209] initcall proc_uptime_init+0x0/0x38 returned 0 after 29 u=
secs
[    0.952239] calling  proc_version_init+0x0/0x38 @ 1
[    0.952301] initcall proc_version_init+0x0/0x38 returned 0 after 29 =
usecs
[    0.952331] calling  proc_softirqs_init+0x0/0x38 @ 1
[    0.952392] initcall proc_softirqs_init+0x0/0x38 returned 0 after 29=
 usecs
[    0.952423] calling  proc_kmsg_init+0x0/0x38 @ 1
[    0.952484] initcall proc_kmsg_init+0x0/0x38 returned 0 after 29 use=
cs
[    0.952514] calling  proc_page_init+0x0/0x58 @ 1
[    0.952575] initcall proc_page_init+0x0/0x58 returned 0 after 59 use=
cs
[    0.952606] calling  init_devpts_fs+0x0/0x68 @ 1
[    0.953552] initcall init_devpts_fs+0x0/0x68 returned 0 after 894 us=
ecs
[    0.953582] calling  init_ext3_fs+0x0/0x78 @ 1
[    0.953765] initcall init_ext3_fs+0x0/0x78 returned 0 after 149 usec=
s
[    0.953796] calling  init_ext2_fs+0x0/0x78 @ 1
[    0.953918] initcall init_ext2_fs+0x0/0x78 returned 0 after 119 usec=
s
[    0.953948] calling  journal_init+0x0/0xb4 @ 1
[    0.954406] initcall journal_init+0x0/0xb4 returned 0 after 387 usec=
s
[    0.954437] calling  init_cramfs_fs+0x0/0x3c @ 1
[    0.954528] initcall init_cramfs_fs+0x0/0x3c returned 0 after 89 use=
cs
[    0.954559] calling  init_ramfs_fs+0x0/0xc @ 1
[    0.954589] initcall init_ramfs_fs+0x0/0xc returned 0 after 0 usecs
[    0.954620] calling  init_fat_fs+0x0/0x60 @ 1
[    0.954864] initcall init_fat_fs+0x0/0x60 returned 0 after 178 usecs
[    0.954895] calling  init_vfat_fs+0x0/0xc @ 1
[    0.954925] initcall init_vfat_fs+0x0/0xc returned 0 after 0 usecs
[    0.954956] calling  init_msdos_fs+0x0/0xc @ 1
[    0.954986] initcall init_msdos_fs+0x0/0xc returned 0 after 0 usecs
[    0.955017] calling  init_nfs_fs+0x0/0x144 @ 1
[    0.955017] NFS: Registering the id_resolver key type
[    0.957427] initcall init_nfs_fs+0x0/0x144 returned 0 after 2324 use=
cs
[    0.957458] calling  init_nlm+0x0/0x4c @ 1
[    0.957550] initcall init_nlm+0x0/0x4c returned 0 after 59 usecs
[    0.957580] calling  init_nls_cp437+0x0/0xc @ 1
[    0.957733] initcall init_nls_cp437+0x0/0xc returned 0 after 89 usec=
s
[    0.957763] calling  init_nls_iso8859_1+0x0/0xc @ 1
[    0.957794] initcall init_nls_iso8859_1+0x0/0xc returned 0 after 0 u=
secs
[    0.957824] calling  init_jffs2_fs+0x0/0xd8 @ 1
[    0.957855] jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 R=
ed Hat, Inc.
[    0.959747] initcall init_jffs2_fs+0x0/0xd8 returned 0 after 1847 us=
ecs
[    0.959777] calling  ipc_init+0x0/0x24 @ 1
[    0.959838] msgmni has been set to 227
[    0.959930] initcall ipc_init+0x0/0x24 returned 0 after 149 usecs
[    0.959960] calling  ipc_sysctl_init+0x0/0x18 @ 1
[    0.960052] initcall ipc_sysctl_init+0x0/0x18 returned 0 after 59 us=
ecs
[    0.960083] calling  init_mqueue_fs+0x0/0xc0 @ 1
[    0.961181] initcall init_mqueue_fs+0x0/0xc0 returned 0 after 1043 u=
secs
[    0.961212] calling  key_proc_init+0x0/0x4c @ 1
[    0.961303] initcall key_proc_init+0x0/0x4c returned 0 after 29 usec=
s
[    0.961303] calling  crypto_wq_init+0x0/0x48 @ 1
[    0.961700] initcall crypto_wq_init+0x0/0x48 returned 0 after 357 us=
ecs
[    0.961730] calling  crypto_algapi_init+0x0/0x10 @ 1
[    0.961822] initcall crypto_algapi_init+0x0/0x10 returned 0 after 29=
 usecs
[    0.961853] calling  skcipher_module_init+0x0/0x48 @ 1
[    0.961883] initcall skcipher_module_init+0x0/0x48 returned 0 after =
0 usecs
[    0.961914] calling  chainiv_module_init+0x0/0xc @ 1
[    0.962310] initcall chainiv_module_init+0x0/0xc returned 0 after 38=
7 usecs
[    0.962371] calling  eseqiv_module_init+0x0/0xc @ 1
[    0.962402] initcall eseqiv_module_init+0x0/0xc returned 0 after 29 =
usecs
[    0.962432] calling  deflate_mod_init+0x0/0xc @ 1
[    0.963409] initcall deflate_mod_init+0x0/0xc returned 0 after 923 u=
secs
[    0.963439] calling  michael_mic_init+0x0/0xc @ 1
[    0.963897] initcall michael_mic_init+0x0/0xc returned 0 after 417 u=
secs
[    0.963928] calling  crc32c_mod_init+0x0/0xc @ 1
[    0.964355] initcall crc32c_mod_init+0x0/0xc returned 0 after 387 us=
ecs
[    0.964385] calling  lzo_mod_init+0x0/0xc @ 1
[    0.964813] initcall lzo_mod_init+0x0/0xc returned 0 after 387 usecs
[    0.964843] calling  krng_mod_init+0x0/0xc @ 1
[    0.965240] initcall krng_mod_init+0x0/0xc returned 0 after 387 usec=
s
[    0.965270] calling  proc_genhd_init+0x0/0x58 @ 1
[    0.965393] initcall proc_genhd_init+0x0/0x58 returned 0 after 59 us=
ecs
[    0.965423] calling  noop_init+0x0/0xc @ 1
[    0.965545] io scheduler noop registered
[    0.965606] initcall noop_init+0x0/0xc returned 0 after 149 usecs
[    0.965606] calling  deadline_init+0x0/0xc @ 1
[    0.965637] io scheduler deadline registered
[    0.965667] initcall deadline_init+0x0/0xc returned 0 after 29 usecs
[    0.965698] calling  cfq_init+0x0/0x9c @ 1
[    0.966064] io scheduler cfq registered (default)
[    0.966094] initcall cfq_init+0x0/0x9c returned 0 after 357 usecs
[    0.966125] calling  libcrc32c_mod_init+0x0/0x38 @ 1
[    0.966217] initcall libcrc32c_mod_init+0x0/0x38 returned 0 after 59=
 usecs
[    0.966247] calling  percpu_counter_startup+0x0/0x1c @ 1
[    0.966278] initcall percpu_counter_startup+0x0/0x1c returned 0 afte=
r 29 usecs
[    0.966461] calling  fb_console_init+0x0/0x168 @ 1
[    0.967834] initcall fb_console_init+0x0/0x168 returned 0 after 1281=
 usecs
[    0.967864] calling  platform_lcd_driver_init+0x0/0xc @ 1
[    0.968872] initcall platform_lcd_driver_init+0x0/0xc returned 0 aft=
er 953 usecs
[    0.968902] calling  pty_init+0x0/0x24c @ 1
[    0.969940] initcall pty_init+0x0/0x24c returned 0 after 953 usecs
[    0.969970] calling  sysrq_init+0x0/0xa4 @ 1
[    0.970092] initcall sysrq_init+0x0/0xa4 returned 0 after 59 usecs
[    0.970123] calling  serial8250_init+0x0/0x184 @ 1
[    0.970123] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.978668] initcall serial8250_init+0x0/0x184 returned 0 after 8285=
 usecs
[    0.978698] calling  serial_omap_init+0x0/0x3c @ 1
[    0.979675] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is a =
OMAP UART0
[    4.628906] console [ttyO0] enabled
[    4.635833] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73) is a =
OMAP UART1
[    4.645568] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74) is a =
OMAP UART2
[    4.655639] initcall serial_omap_init+0x0/0x3c returned 0 after 3590=
703 usecs
[    4.663330] calling  rand_initialize+0x0/0x2c @ 1
[    4.668579] initcall rand_initialize+0x0/0x2c returned 0 after 238 u=
secs
[    4.675750] calling  omap_rng_init+0x0/0x2c @ 1
[    4.680603] initcall omap_rng_init+0x0/0x2c returned -19 after 0 use=
cs
[    4.687561] calling  cn_proc_init+0x0/0x3c @ 1
[    4.692382] initcall cn_proc_init+0x0/0x3c returned 0 after 89 usecs
[    4.699188] calling  topology_sysfs_init+0x0/0x70 @ 1
[    4.704742] initcall topology_sysfs_init+0x0/0x70 returned 0 after 1=
19 usecs
[    4.712249] calling  brd_init+0x0/0x1b8 @ 1
[    4.760437] brd: module loaded
[    4.764068] initcall brd_init+0x0/0x1b8 returned 0 after 46223 usecs
[    4.770782] calling  loop_init+0x0/0x11c @ 1
[    4.801818] loop: module loaded
[    4.805511] initcall loop_init+0x0/0x11c returned 0 after 29414 usec=
s
[    4.812377] calling  menelaus_init+0x0/0x34 @ 1
[    4.818267] initcall menelaus_init+0x0/0x34 returned 0 after 1043 us=
ecs
[    4.825256] calling  twl4030_audio_driver_init+0x0/0xc @ 1
[    4.834777] initcall twl4030_audio_driver_init+0x0/0xc returned 0 af=
ter 3486 usecs
[    4.842926] calling  init_sd+0x0/0x120 @ 1
[    4.849029] initcall init_sd+0x0/0x120 returned 0 after 1698 usecs
[    4.855743] calling  init_mtd+0x0/0xd8 @ 1
[    4.864410] initcall init_mtd+0x0/0xd8 returned 0 after 4142 usecs
[    4.871154] calling  cmdline_parser_init+0x0/0xc @ 1
[    4.876678] initcall cmdline_parser_init+0x0/0xc returned 0 after 17=
8 usecs
[    4.884094] calling  init_mtdchar+0x0/0x8c @ 1
[    4.888916] initcall init_mtdchar+0x0/0x8c returned 0 after 59 usecs
[    4.895629] calling  init_mtdblock+0x0/0xc @ 1
[    4.900604] initcall init_mtdblock+0x0/0xc returned 0 after 178 usec=
s
[    4.907470] calling  mtdoops_init+0x0/0x16c @ 1
[    4.912322] mtdoops: mtd device (mtddev=3Dname/number) must be suppl=
ied
[    4.919128] initcall mtdoops_init+0x0/0x16c returned -22 after 6616 =
usecs
[    4.926330] initcall mtdoops_init+0x0/0x16c returned with error code=
 -22=20
[    4.933593] calling  cfi_probe_init+0x0/0x18 @ 1
[    4.938629] initcall cfi_probe_init+0x0/0x18 returned 0 after 119 us=
ecs
[    4.945678] calling  nand_base_init+0x0/0x8 @ 1
[    4.950469] initcall nand_base_init+0x0/0x8 returned 0 after 0 usecs
[    4.957244] calling  omap_nand_driver_init+0x0/0xc @ 1
[    4.963775] initcall omap_nand_driver_init+0x0/0xc returned 0 after =
983 usecs
[    4.971588] calling  omap2_onenand_init+0x0/0x20 @ 1
[    4.976898] OneNAND driver initializing
[    4.981872] initcall omap2_onenand_init+0x0/0x20 returned 0 after 48=
27 usecs
[    4.989471] calling  ubi_init+0x0/0x2e0 @ 1
[    4.995727] initcall ubi_init+0x0/0x2e0 returned 0 after 1698 usecs
[    5.002532] calling  net_olddevs_init+0x0/0xc0 @ 1
[    5.007720] initcall net_olddevs_init+0x0/0xc0 returned 0 after 0 us=
ecs
[    5.014770] calling  smsc_init+0x0/0x90 @ 1
[    5.022735] initcall smsc_init+0x0/0x90 returned 0 after 3457 usecs
[    5.029541] calling  ks8851_init+0x0/0xc @ 1
[    5.034729] initcall ks8851_init+0x0/0xc returned 0 after 655 usecs
[    5.041564] calling  ks8851_platform_driver_init+0x0/0xc @ 1
[    5.048522] initcall ks8851_platform_driver_init+0x0/0xc returned 0 =
after 864 usecs
[    5.056762] calling  smc_driver_init+0x0/0xc @ 1
[    5.062622] initcall smc_driver_init+0x0/0xc returned 0 after 864 us=
ecs
[    5.069763] calling  smsc911x_init_module+0x0/0xc @ 1
[    5.075286] smsc911x: Driver version 2008-10-21
[    5.081665] async_waiting @ 1
[    5.085327] calling  1_regulator_bulk_enable_async+0x0/0x18 @ 5
[    5.091827] initcall 1_regulator_bulk_enable_async+0x0/0x18 returned=
 0 after 59 usecs
[    5.100341] calling  2_regulator_bulk_enable_async+0x0/0x18 @ 5
[    5.106597] initcall 2_regulator_bulk_enable_async+0x0/0x18 returned=
 0 after 29 usecs
[    5.115051] async_continuing @ 1 after 29414 usec
[    5.129608] smsc911x-mdio: probed
[    5.133605] smsc911x smsc911x.0: eth0: attached PHY driver [SMSC LAN=
8700] (mii_bus:phy_addr=3Dsmsc911x-0:01, irq=3D-1)
[    5.144989] smsc911x smsc911x.0: eth0: MAC Address: 00:50:c2:7e:90:f=
c
[    5.152801] initcall smsc911x_init_module+0x0/0xc returned 0 after 7=
5876 usecs
[    5.160736] calling  asix_driver_init+0x0/0x18 @ 1
[    5.166717] usbcore: registered new interface driver asix
[    5.172576] initcall asix_driver_init+0x0/0x18 returned 0 after 6526=
 usecs
[    5.179901] calling  cdc_driver_init+0x0/0x18 @ 1
[    5.185699] usbcore: registered new interface driver cdc_ether
[    5.191864] initcall cdc_driver_init+0x0/0x18 returned 0 after 6794 =
usecs
[    5.199218] calling  net1080_driver_init+0x0/0x18 @ 1
[    5.205352] usbcore: registered new interface driver net1080
[    5.211486] initcall net1080_driver_init+0x0/0x18 returned 0 after 6=
705 usecs
[    5.219085] calling  cdc_subset_driver_init+0x0/0x18 @ 1
[    5.225463] usbcore: registered new interface driver cdc_subset
[    5.231750] initcall cdc_subset_driver_init+0x0/0x18 returned 0 afte=
r 6794 usecs
[    5.239685] calling  zaurus_driver_init+0x0/0x18 @ 1
[    5.245727] usbcore: registered new interface driver zaurus
[    5.251770] initcall zaurus_driver_init+0x0/0x18 returned 0 after 65=
86 usecs
[    5.259277] calling  usbnet_init+0x0/0x30 @ 1
[    5.264007] initcall usbnet_init+0x0/0x30 returned 0 after 29 usecs
[    5.270629] calling  cdc_ncm_driver_init+0x0/0x18 @ 1
[    5.276733] usbcore: registered new interface driver cdc_ncm
[    5.282897] initcall cdc_ncm_driver_init+0x0/0x18 returned 0 after 6=
705 usecs
[    5.290496] calling  mon_init+0x0/0x100 @ 1
[    5.297149] initcall mon_init+0x0/0x100 returned 0 after 2086 usecs
[    5.303955] calling  wdm_driver_init+0x0/0x18 @ 1
[    5.309722] usbcore: registered new interface driver cdc_wdm
[    5.315887] initcall wdm_driver_init+0x0/0x18 returned 0 after 6794 =
usecs
[    5.323120] calling  usb_stor_init+0x0/0x4c @ 1
[    5.327972] Initializing USB Mass Storage driver...
[    5.334106] usbcore: registered new interface driver usb-storage
[    5.340454] USB Mass Storage support registered.
[    5.345581] initcall usb_stor_init+0x0/0x4c returned 0 after 17166 u=
secs
[    5.352722] calling  usb_usual_init+0x0/0x44 @ 1
[    5.359069] usbcore: registered new interface driver libusual
[    5.365325] initcall usb_usual_init+0x0/0x44 returned 0 after 7450 u=
secs
[    5.372406] calling  usbtest_init+0x0/0x44 @ 1
[    5.377990] usbcore: registered new interface driver usbtest
[    5.384124] initcall usbtest_init+0x0/0x44 returned 0 after 6765 use=
cs
[    5.391082] calling  serport_init+0x0/0x30 @ 1
[    5.395782] initcall serport_init+0x0/0x30 returned 0 after 0 usecs
[    5.402465] calling  mousedev_init+0x0/0x88 @ 1
[    5.409484] mousedev: PS/2 mouse device common for all mice
[    5.415588] initcall mousedev_init+0x0/0x88 returned 0 after 8046 us=
ecs
[    5.422637] calling  joydev_init+0x0/0xc @ 1
[    5.427154] initcall joydev_init+0x0/0xc returned 0 after 29 usecs
[    5.433746] calling  evdev_init+0x0/0xc @ 1
[    5.438232] initcall evdev_init+0x0/0xc returned 0 after 0 usecs
[    5.444671] calling  atkbd_init+0x0/0x18 @ 1
[    5.450256] initcall atkbd_init+0x0/0x18 returned 0 after 1043 usecs
[    5.457153] calling  twl4030_kp_driver_init+0x0/0xc @ 1
[    5.464965] input: TWL4030 Keypad as /devices/platform/omap_i2c.1/i2=
c-1/1-004a/twl4030_keypad/input/input0
[    5.480285] initcall twl4030_kp_driver_init+0x0/0xc returned 0 after=
 17106 usecs
[    5.488311] calling  psmouse_init+0x0/0x88 @ 1
[    5.494354] initcall psmouse_init+0x0/0x88 returned 0 after 1251 use=
cs
[    5.501464] calling  ads7846_driver_init+0x0/0xc @ 1
[    5.510925] ads7846 spi1.0: touchscreen, irq 271
[    5.519653] input: ADS7846 Touchscreen as /devices/platform/omap2_mc=
spi.1/spi_master/spi1/spi1.0/input/input1
[    5.533203] initcall ads7846_driver_init+0x0/0xc returned 0 after 25=
779 usecs
[    5.540924] calling  twl4030_pwrbutton_init+0x0/0x14 @ 1
[    5.549896] input: twl4030_pwrbutton as /devices/platform/omap_i2c.1=
/i2c-1/1-0049/twl4030_pwrbutton/input/input2
[    5.562683] initcall twl4030_pwrbutton_init+0x0/0x14 returned 0 afte=
r 15676 usecs
[    5.570739] calling  twl_rtc_init+0x0/0x40 @ 1
[    5.576171] twl_rtc twl_rtc: Power up reset detected.
[    5.581665] twl_rtc twl_rtc: Enabling TWL-RTC
[    5.591674] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    5.600189] initcall twl_rtc_init+0x0/0x40 returned 0 after 24139 us=
ecs
[    5.607299] calling  i2c_dev_init+0x0/0xd0 @ 1
[    5.611968] i2c /dev entries driver
[    5.620758] initcall i2c_dev_init+0x0/0xd0 returned 0 after 8553 use=
cs
[    5.627868] calling  w1_init+0x0/0xa4 @ 1
[    5.632171] Driver for 1-wire Dallas network protocol.
[    5.639923] initcall w1_init+0x0/0xa4 returned 0 after 7539 usecs
[    5.646484] calling  omap_wdt_driver_init+0x0/0xc @ 1
[    5.654266] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout =
60 sec
[    5.662536] initcall omap_wdt_driver_init+0x0/0xc returned 0 after 1=
0430 usecs
[    5.670318] calling  twl4030_wdt_driver_init+0x0/0xc @ 1
[    5.676483] twl4030_wdt twl4030_wdt: Failed to register misc device
[    5.683319] twl4030_wdt: probe of twl4030_wdt failed with error -16
[    5.690826] initcall twl4030_wdt_driver_init+0x0/0xc returned 0 afte=
r 14513 usecs
[    5.698852] calling  mmc_blk_init+0x0/0x80 @ 1
[    5.704345] initcall mmc_blk_init+0x0/0x80 returned 0 after 685 usec=
s
[    5.711303] calling  sdio_uart_init+0x0/0xf0 @ 1
[    5.717010] initcall sdio_uart_init+0x0/0xf0 returned 0 after 804 us=
ecs
[    5.723999] calling  mmc_omap_init+0x0/0x70 @ 1
[    5.731506] initcall mmc_omap_init+0x0/0x70 returned -19 after 2503 =
usecs
[    5.738861] calling  omap_hsmmc_init+0x0/0x14 @ 1
[    5.754089] initcall omap_hsmmc_init+0x0/0x14 returned 0 after 9894 =
usecs
[    5.761413] calling  hid_init+0x0/0x5c @ 1
[    5.766754] initcall hid_init+0x0/0x5c returned 0 after 894 usecs
[    5.773376] calling  hid_init+0x0/0x78 @ 1
[    5.779449] usbcore: registered new interface driver usbhid
[    5.785339] usbhid: USB HID core driver
[    5.789550] initcall hid_init+0x0/0x78 returned 0 after 11533 usecs
[    5.796234] calling  oprofile_init+0x0/0x6c @ 1
[    5.801025] oprofile: hardware counters not available
[    5.806427] oprofile: using timer interrupt.
[    5.811004] initcall oprofile_init+0x0/0x6c returned 0 after 9745 us=
ecs
[    5.818084] calling  sock_diag_init+0x0/0x54 @ 1
[    5.823028] initcall sock_diag_init+0x0/0x54 returned 0 after 89 use=
cs
[    5.829986] calling  flow_cache_init_global+0x0/0x1ac @ 1
[    5.836059] initcall flow_cache_init_global+0x0/0x1ac returned 0 aft=
er 298 usecs
[    5.843963] calling  sysctl_ipv4_init+0x0/0x94 @ 1
[    5.849456] initcall sysctl_ipv4_init+0x0/0x94 returned 0 after 447 =
usecs
[    5.856628] calling  xfrm4_beet_init+0x0/0x10 @ 1
[    5.861694] initcall xfrm4_beet_init+0x0/0x10 returned 0 after 0 use=
cs
[    5.868652] calling  xfrm4_transport_init+0x0/0x10 @ 1
[    5.874145] initcall xfrm4_transport_init+0x0/0x10 returned 0 after =
0 usecs
[    5.881591] calling  xfrm4_mode_tunnel_init+0x0/0x10 @ 1
[    5.887207] initcall xfrm4_mode_tunnel_init+0x0/0x10 returned 0 afte=
r 0 usecs
[    5.894805] calling  ipv4_netfilter_init+0x0/0xc @ 1
[    5.900329] initcall ipv4_netfilter_init+0x0/0xc returned 0 after 20=
8 usecs
[    5.907775] calling  inet_diag_init+0x0/0x8c @ 1
[    5.912872] initcall inet_diag_init+0x0/0x8c returned 0 after 149 us=
ecs
[    5.919952] calling  tcp_diag_init+0x0/0xc @ 1
[    5.924743] initcall tcp_diag_init+0x0/0xc returned 0 after 119 usec=
s
[    5.931610] calling  cubictcp_register+0x0/0x74 @ 1
[    5.936828] TCP: cubic registered
[    5.940338] initcall cubictcp_register+0x0/0x74 returned 0 after 342=
7 usecs
[    5.947784] calling  xfrm_user_init+0x0/0x48 @ 1
[    5.952728] Initializing XFRM netlink socket
[    5.957427] initcall xfrm_user_init+0x0/0x48 returned 0 after 4589 u=
secs
[    5.964569] calling  packet_init+0x0/0x48 @ 1
[    5.969268] NET: Registered protocol family 17
[    5.974060] initcall packet_init+0x0/0x48 returned 0 after 4678 usec=
s
[    5.980957] calling  ipsec_pfkey_init+0x0/0x7c @ 1
[    5.986145] NET: Registered protocol family 15
[    5.990905] initcall ipsec_pfkey_init+0x0/0x7c returned 0 after 4708=
 usecs
[    5.998229] calling  init_rpcsec_gss+0x0/0x64 @ 1
[    6.003601] initcall init_rpcsec_gss+0x0/0x64 returned 0 after 417 u=
secs
[    6.011016] calling  init_dns_resolver+0x0/0x14c @ 1
[    6.016326] Registering the dns_resolver key type
[    6.021850] initcall init_dns_resolver+0x0/0x14c returned 0 after 53=
64 usecs
[    6.029571] calling  vfp_init+0x0/0x1a4 @ 1
[    6.033996] VFP support v0.3: implementor 41 architecture 3 part 30 =
variant c rev 1
[    6.042297] initcall vfp_init+0x0/0x1a4 returned 0 after 8136 usecs
[    6.049041] calling  thumbee_init+0x0/0x5c @ 1
[    6.053802] ThumbEE CPU extension supported.
[    6.058319] initcall thumbee_init+0x0/0x5c returned 0 after 4410 use=
cs
[    6.065307] calling  omap_mux_late_init+0x0/0x1a0 @ 1
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
