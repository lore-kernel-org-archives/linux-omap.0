From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [BISECTED] v4.3-rc5: OMAP1 boot hang
Date: Wed, 11 Nov 2015 23:44:44 +0200
Message-ID: <20151111214444.GF2260@blackmetal.musicnaut.iki.fi>
References: <20151013073046.GB7588@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20151013073046.GB7588@blackmetal.musicnaut.iki.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

Any suggestions how to debug this further? This happens also with v4.3
final. Is the CPU_SW_DOMAIN_PAN supposed to work with this CPU?

I tried to disable various drivers (e.g. NAND, USB) and it still
hangs... And it seems always at the same printk time stamp (roughly at
25 seconds).

A.

On Tue, Oct 13, 2015 at 10:30:46AM +0300, Aaro Koskinen wrote:
> Hi,
> 
> Amstrad E3 / OMAP1 boot hangs, and I bisected it to
> a5e090acbf545c0a3b04080f8a488b17ec41fe02 ("ARM: software-based
> priviledged-no-access support").
> 
> Below is the boot log. Disabling CPU_SW_DOMAIN_PAN helps.
> 
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Linux version 4.3.0-rc5-e3-los_df2ad+ (aaro@amd-fx-6350) (gcc version 5.2.0 (GCC) ) #1 Tue Oct 13 10:08:05 EEST 2015
> [    0.000000] CPU: ARM925T [54029252] revision 2 (ARMv4T), cr=0000317f
> [    0.000000] CPU: VIVT data cache, VIVT instruction cache
> [    0.000000] Machine: Amstrad E3 (Delta)
> [    0.000000] Ignoring memory below PHYS_OFFSET: 0x02000000-0x10000000
> [    0.000000] Memory policy: Data cache writethrough
> [    0.000000] On node 0 totalpages: 8192
> [    0.000000] free_area_init_node: node 0, pgdat c0427018, node_mem_map c1fb7000
> [    0.000000]   Normal zone: 64 pages used for memmap
> [    0.000000]   Normal zone: 0 pages reserved
> [    0.000000]   Normal zone: 8192 pages, LIFO batch:0
> [    0.000000] OMAP1510
> [    0.000000]  revision 2 handled as 15xx id: bc058c9b93111a16
> [    0.000000] Clocks: ARM_SYSST: 0x1000 DPLL_CTL: 0x2cb3 ARM_CKCTL: 0x250e
> [    0.000000] Clocking rate (xtal/DPLL1/MPU): 12.0/150.0/150.0 MHz
> [    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
> [    0.000000] pcpu-alloc: [0] 0 
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8128
> [    0.000000] Kernel command line: mem=32M console=tty console=ttyS0,115200n8 root=/dev/ram0 initrd=0x11c00000,2894948 initcall_debug=1 loglevel=9
> [    0.000000] PID hash table entries: 128 (order: -3, 512 bytes)
> [    0.000000] Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
> [    0.000000] Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.000000] Memory: 25136K/32768K available (3074K kernel code, 141K rwdata, 864K rodata, 140K init, 212K bss, 7632K reserved, 0K cma-reserved)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
> [    0.000000]     vmalloc : 0xc2800000 - 0xff000000   ( 968 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xc2000000   (  32 MB)
> [    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
> [    0.000000]       .text : 0xc0008000 - 0xc03e0ec4   (3940 kB)
> [    0.000000]       .init : 0xc03e1000 - 0xc0404000   ( 140 kB)
> [    0.000000]       .data : 0xc0404000 - 0xc04277e0   ( 142 kB)
> [    0.000000]        .bss : 0xc04277e0 - 0xc045c9c0   ( 213 kB)
> [    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> [    0.000000] NR_IRQS:16 nr_irqs:16 16
> [    0.000000] Total of 64 interrupts in 2 interrupt banks
> [    0.000131] sched_clock: 32 bits at 6MHz, resolution 166ns, wraps every 357913940908ns
> [    0.000382] clocksource: mpu_timer2: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 318543407797 ns
> [    0.001561] Console: colour dummy device 80x30
> [    0.009527] console [tty0] enabled
> [    0.010230] Calibrating delay loop... 74.13 BogoMIPS (lpj=370688)
> [    0.100420] pid_max: default: 32768 minimum: 301
> [    0.101672] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.102202] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.108589] CPU: Testing write buffer coherency: ok
> [    0.111741] calling  init_static_idmap+0x0/0x11c @ 1
> [    0.112570] Setting up static identity map for 0x10008400 - 0x1000842c
> [    0.113178] initcall init_static_idmap+0x0/0x11c returned 0 after 0 usecs
> [    0.113812] calling  spawn_ksoftirqd+0x0/0x30 @ 1
> [    0.115210] initcall spawn_ksoftirqd+0x0/0x30 returned 0 after 0 usecs
> [    0.115820] calling  init_workqueues+0x0/0x2ec @ 1
> [    0.120426] initcall init_workqueues+0x0/0x2ec returned 0 after 9765 usecs
> [    0.121133] calling  rand_initialize+0x0/0x34 @ 1
> [    0.122426] initcall rand_initialize+0x0/0x34 returned 0 after 0 usecs
> [    0.126229] devtmpfs: initialized
> [    0.136417] calling  ipc_ns_init+0x0/0x44 @ 1
> [    0.136959] initcall ipc_ns_init+0x0/0x44 returned 0 after 0 usecs
> [    0.137461] calling  init_mmap_min_addr+0x0/0x2c @ 1
> [    0.137893] initcall init_mmap_min_addr+0x0/0x2c returned 0 after 0 usecs
> [    0.138440] calling  net_ns_init+0x0/0x1c8 @ 1
> [    0.139019] initcall net_ns_init+0x0/0x1c8 returned 0 after 0 usecs
> [    0.140507] calling  ptrace_break_init+0x0/0x34 @ 1
> [    0.141046] initcall ptrace_break_init+0x0/0x34 returned 0 after 0 usecs
> [    0.141573] calling  omap1_pm_runtime_init+0x0/0x28 @ 1
> [    0.142020] initcall omap1_pm_runtime_init+0x0/0x28 returned 0 after 0 usecs
> [    0.142531] calling  wq_sysfs_init+0x0/0x38 @ 1
> [    0.144169] initcall wq_sysfs_init+0x0/0x38 returned 0 after 0 usecs
> [    0.144753] calling  ksysfs_init+0x0/0xa8 @ 1
> [    0.145728] initcall ksysfs_init+0x0/0xa8 returned 0 after 0 usecs
> [    0.146299] calling  init_jiffies_clocksource+0x0/0x24 @ 1
> [    0.146748] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
> [    0.147420] initcall init_jiffies_clocksource+0x0/0x24 returned 0 after 0 usecs
> [    0.148107] calling  cgroup_wq_init+0x0/0x88 @ 1
> [    0.148790] initcall cgroup_wq_init+0x0/0x88 returned 0 after 0 usecs
> [    0.149374] calling  init_zero_pfn+0x0/0x4c @ 1
> [    0.149843] initcall init_zero_pfn+0x0/0x4c returned 0 after 0 usecs
> [    0.150729] calling  fsnotify_init+0x0/0x2c @ 1
> [    0.151330] initcall fsnotify_init+0x0/0x2c returned 0 after 0 usecs
> [    0.151944] calling  filelock_init+0x0/0x74 @ 1
> [    0.152617] initcall filelock_init+0x0/0x74 returned 0 after 0 usecs
> [    0.153262] calling  init_script_binfmt+0x0/0x24 @ 1
> [    0.153758] initcall init_script_binfmt+0x0/0x24 returned 0 after 0 usecs
> [    0.154365] calling  init_elf_binfmt+0x0/0x24 @ 1
> [    0.154860] initcall init_elf_binfmt+0x0/0x24 returned 0 after 0 usecs
> [    0.155394] calling  prandom_init+0x0/0x98 @ 1
> [    0.155842] initcall prandom_init+0x0/0x98 returned 0 after 0 usecs
> [    0.156362] calling  regulator_init+0x0/0x30 @ 1
> [    0.159541] initcall regulator_init+0x0/0x30 returned 0 after 0 usecs
> [    0.160486] calling  sock_init+0x0/0x98 @ 1
> [    0.161811] initcall sock_init+0x0/0x98 returned 0 after 0 usecs
> [    0.162453] calling  netlink_proto_init+0x0/0x174 @ 1
> [    0.165184] NET: Registered protocol family 16
> [    0.165992] initcall netlink_proto_init+0x0/0x174 returned 0 after 0 usecs
> [    0.167268] calling  atomic_pool_init+0x0/0x12c @ 1
> [    0.172912] DMA: preallocated 256 KiB pool for atomic coherent allocations
> [    0.173557] initcall atomic_pool_init+0x0/0x12c returned 0 after 9765 usecs
> [    0.174094] calling  omap15xx_gpio_init+0x0/0x2c @ 1
> [    0.176129] initcall omap15xx_gpio_init+0x0/0x2c returned 0 after 0 usecs
> [    0.176754] calling  bdi_class_init+0x0/0x48 @ 1
> [    0.177676] initcall bdi_class_init+0x0/0x48 returned 0 after 0 usecs
> [    0.178272] calling  mm_sysfs_init+0x0/0x40 @ 1
> [    0.178887] initcall mm_sysfs_init+0x0/0x40 returned 0 after 0 usecs
> [    0.179438] calling  kobject_uevent_init+0x0/0x1c @ 1
> [    0.180344] initcall kobject_uevent_init+0x0/0x1c returned 0 after 9765 usecs
> [    0.180948] calling  gpiolib_sysfs_init+0x0/0x8c @ 1
> [    0.181879] initcall gpiolib_sysfs_init+0x0/0x8c returned 0 after 0 usecs
> [    0.182462] calling  omap_gpio_drv_reg+0x0/0x20 @ 1
> [    0.183095] omap_gpio omap_gpio.0: Runtime PM disabled, clock forced on.
> [    0.186262] irq: Cannot allocate irq_descs @ IRQ80, assuming pre-allocated
> [    0.188848] irq: Cannot allocate irq_descs @ IRQ96, assuming pre-allocated
> [    0.190596] initcall omap_gpio_drv_reg+0x0/0x20 returned 0 after 9765 usecs
> [    0.191213] calling  tty_class_init+0x0/0x48 @ 1
> [    0.192031] initcall tty_class_init+0x0/0x48 returned 0 after 0 usecs
> [    0.192606] calling  vtconsole_class_init+0x0/0xec @ 1
> [    0.194287] initcall vtconsole_class_init+0x0/0xec returned 0 after 0 usecs
> [    0.194913] calling  i2c_init+0x0/0xac @ 1
> [    0.196657] initcall i2c_init+0x0/0xac returned 0 after 0 usecs
> [    0.197913] calling  gate_vma_init+0x0/0x30 @ 1
> [    0.198402] initcall gate_vma_init+0x0/0x30 returned 0 after 0 usecs
> [    0.198974] calling  customize_machine+0x0/0x30 @ 1
> [    0.199363] MUX: initialized UART1_TX
> [    0.199681] MUX: initialized UART1_RTS
> [    0.200283] MUX: initialized H19_1610_CAM_EXCLK
> [    0.201627] USB: hmc 16, usb0 2 wires
> [    0.207614] Installing fiq handler from c0015fa8, length 0x164
> [    0.208267] request_fiq(): fiq_buffer = c0427c68
> [    0.208769] initcall customize_machine+0x0/0x30 returned 0 after 9765 usecs
> [    0.209370] calling  init_atags_procfs+0x0/0xec @ 1
> [    0.209946] initcall init_atags_procfs+0x0/0xec returned 0 after 0 usecs
> [    0.210890] calling  exceptions_init+0x0/0x9c @ 1
> [    0.211390] initcall exceptions_init+0x0/0x9c returned 0 after 0 usecs
> [    0.211987] calling  omap_init+0x0/0x1c @ 1
> [    0.213251] initcall omap_init+0x0/0x1c returned 0 after 0 usecs
> [    0.213913] calling  omap1_init_devices+0x0/0x28 @ 1
> [    0.216644] Clocking rate (xtal/DPLL1/MPU): 12.0/150.0/150.0 MHz
> [    0.218058] initcall omap1_init_devices+0x0/0x28 returned 0 after 0 usecs
> [    0.218744] calling  omap1_system_dma_init+0x0/0x1e0 @ 1
> [    0.221260] initcall omap1_system_dma_init+0x0/0x1e0 returned 0 after 9765 usecs
> [    0.222100] calling  omap_init_fb+0x0/0x30 @ 1
> [    0.223345] initcall omap_init_fb+0x0/0x30 returned 0 after 0 usecs
> [    0.223925] calling  omap1_dm_timer_init+0x0/0x14 @ 1
> [    0.224366] initcall omap1_dm_timer_init+0x0/0x14 returned 0 after 0 usecs
> [    0.224869] calling  omap_init_lcd_dma+0x0/0x58 @ 1
> [    0.225457] initcall omap_init_lcd_dma+0x0/0x58 returned 0 after 0 usecs
> [    0.225989] calling  omap_system_dma_init+0x0/0x20 @ 1
> [    0.227645] DMA support for OMAP15xx initialized
> [    0.228737] initcall omap_system_dma_init+0x0/0x20 returned 0 after 0 usecs
> [    0.230304] calling  topology_init+0x0/0x30 @ 1
> [    0.231560] initcall topology_init+0x0/0x30 returned 0 after 0 usecs
> [    0.232120] calling  omap_i2c_cmdline+0x0/0x14 @ 1
> [    0.232554] initcall omap_i2c_cmdline+0x0/0x14 returned 0 after 0 usecs
> [    0.233064] calling  uid_cache_init+0x0/0xb0 @ 1
> [    0.233539] initcall uid_cache_init+0x0/0xb0 returned 0 after 0 usecs
> [    0.234060] calling  param_sysfs_init+0x0/0x1e0 @ 1
> [    0.278661] initcall param_sysfs_init+0x0/0x1e0 returned 0 after 39062 usecs
> [    0.279287] calling  pm_sysrq_init+0x0/0x24 @ 1
> [    0.419148] initcall pm_sysrq_init+0x0/0x24 returned 0 after 136718 usecs
> [    0.419796] calling  create_proc_profile+0x0/0x84 @ 1
> [    0.420537] initcall create_proc_profile+0x0/0x84 returned 0 after 0 usecs
> [    0.421140] calling  crash_save_vmcoreinfo_init+0x0/0x450 @ 1
> [    0.422554] initcall crash_save_vmcoreinfo_init+0x0/0x450 returned 0 after 0 usecs
> [    0.423278] calling  crash_notes_memory_init+0x0/0x48 @ 1
> [    0.423813] initcall crash_notes_memory_init+0x0/0x48 returned 0 after 0 usecs
> [    0.424515] calling  default_bdi_init+0x0/0x54 @ 1
> [    0.426953] initcall default_bdi_init+0x0/0x54 returned 0 after 0 usecs
> [    0.427604] calling  percpu_enable_async+0x0/0x24 @ 1
> [    0.428077] initcall percpu_enable_async+0x0/0x24 returned 0 after 0 usecs
> [    0.428604] calling  init_reserve_notifier+0x0/0x14 @ 1
> [    0.429044] initcall init_reserve_notifier+0x0/0x14 returned 0 after 0 usecs
> [    0.429545] calling  init_admin_reserve+0x0/0x3c @ 1
> [    0.429969] initcall init_admin_reserve+0x0/0x3c returned 0 after 0 usecs
> [    0.430805] calling  init_user_reserve+0x0/0x3c @ 1
> [    0.431241] initcall init_user_reserve+0x0/0x3c returned 0 after 0 usecs
> [    0.431747] calling  crypto_wq_init+0x0/0x4c @ 1
> [    0.434665] initcall crypto_wq_init+0x0/0x4c returned 0 after 0 usecs
> [    0.435281] calling  cryptomgr_init+0x0/0x1c @ 1
> [    0.435716] initcall cryptomgr_init+0x0/0x1c returned 0 after 0 usecs
> [    0.436210] calling  init_bio+0x0/0xcc @ 1
> [    0.438101] initcall init_bio+0x0/0xcc returned 0 after 0 usecs
> [    0.438713] calling  blk_settings_init+0x0/0x40 @ 1
> [    0.439156] initcall blk_settings_init+0x0/0x40 returned 0 after 0 usecs
> [    0.439659] calling  blk_ioc_init+0x0/0x48 @ 1
> [    0.440422] initcall blk_ioc_init+0x0/0x48 returned 0 after 0 usecs
> [    0.440981] calling  blk_softirq_init+0x0/0x34 @ 1
> [    0.441427] initcall blk_softirq_init+0x0/0x34 returned 0 after 0 usecs
> [    0.441935] calling  blk_iopoll_setup+0x0/0x34 @ 1
> [    0.442373] initcall blk_iopoll_setup+0x0/0x34 returned 0 after 0 usecs
> [    0.442873] calling  blk_mq_init+0x0/0x18 @ 1
> [    0.443298] initcall blk_mq_init+0x0/0x18 returned 0 after 0 usecs
> [    0.443791] calling  genhd_device_init+0x0/0x8c @ 1
> [    0.447531] initcall genhd_device_init+0x0/0x8c returned 0 after 0 usecs
> [    0.448166] calling  fbmem_init+0x0/0xb4 @ 1
> [    0.449170] initcall fbmem_init+0x0/0xb4 returned 0 after 0 usecs
> [    0.449767] calling  regulator_fixed_voltage_init+0x0/0x20 @ 1
> [    0.451209] initcall regulator_fixed_voltage_init+0x0/0x20 returned 0 after 0 usecs
> [    0.451976] calling  misc_init+0x0/0xd8 @ 1
> [    0.452918] initcall misc_init+0x0/0xd8 returned 0 after 0 usecs
> [    0.453495] calling  init_scsi+0x0/0x84 @ 1
> [    0.456700] SCSI subsystem initialized
> [    0.457253] initcall init_scsi+0x0/0x84 returned 0 after 0 usecs
> [    0.457786] calling  phy_init+0x0/0x44 @ 1
> [    0.460401] initcall phy_init+0x0/0x44 returned 0 after 9765 usecs
> [    0.461024] calling  usb_init+0x0/0x10c @ 1
> [    0.463158] usbcore: registered new interface driver usbfs
> [    0.464403] usbcore: registered new interface driver hub
> [    0.465502] usbcore: registered new device driver usb
> [    0.466036] initcall usb_init+0x0/0x10c returned 0 after 0 usecs
> [    0.466573] calling  serio_init+0x0/0x34 @ 1
> [    0.467848] initcall serio_init+0x0/0x34 returned 0 after 0 usecs
> [    0.468441] calling  input_init+0x0/0x11c @ 1
> [    0.469437] initcall input_init+0x0/0x11c returned 0 after 0 usecs
> [    0.470340] calling  rtc_init+0x0/0x5c @ 1
> [    0.471261] initcall rtc_init+0x0/0x5c returned 0 after 0 usecs
> [    0.471864] calling  omap_i2c_init_driver+0x0/0x20 @ 1
> [    0.472584] omap_i2c omap_i2c.1: Runtime PM disabled, clock forced on.
> [    0.473110] omap_i2c omap_i2c.1: Runtime PM disabled, clock forced on.
> [    0.475050] omap_i2c omap_i2c.1: bus 1 rev1.1 at 100 kHz
> [    0.476134] initcall omap_i2c_init_driver+0x0/0x20 returned 0 after 0 usecs
> [    0.476749] calling  leds_init+0x0/0x54 @ 1
> [    0.477577] initcall leds_init+0x0/0x54 returned 0 after 0 usecs
> [    0.478166] calling  proto_init+0x0/0x1c @ 1
> [    0.478707] initcall proto_init+0x0/0x1c returned 0 after 0 usecs
> [    0.479271] calling  net_dev_init+0x0/0x138 @ 1
> [    0.484931] initcall net_dev_init+0x0/0x138 returned 0 after 9765 usecs
> [    0.485590] calling  neigh_init+0x0/0xac @ 1
> [    0.486049] initcall neigh_init+0x0/0xac returned 0 after 0 usecs
> [    0.486590] calling  genl_init+0x0/0x88 @ 1
> [    0.487237] initcall genl_init+0x0/0x88 returned 0 after 0 usecs
> [    0.488472] calling  proc_cpu_init+0x0/0x2c @ 1
> [    0.489059] initcall proc_cpu_init+0x0/0x2c returned 0 after 0 usecs
> [    0.489660] calling  dma_debug_do_init+0x0/0x14 @ 1
> [    0.490456] initcall dma_debug_do_init+0x0/0x14 returned 0 after 0 usecs
> [    0.491104] calling  alignment_init+0x0/0xe4 @ 1
> [    0.491696] initcall alignment_init+0x0/0xe4 returned 0 after 0 usecs
> [    0.492271] calling  clocksource_done_booting+0x0/0x4c @ 1
> [    0.492750] clocksource: Switched to clocksource mpu_timer2
> [    0.493229] initcall clocksource_done_booting+0x0/0x4c returned 0 after 435 usecs
> [    0.493963] calling  init_pipe_fs+0x0/0x54 @ 1
> [    0.494818] initcall init_pipe_fs+0x0/0x54 returned 0 after 332 usecs
> [    0.495468] calling  inotify_user_setup+0x0/0x5c @ 1
> [    0.496156] initcall inotify_user_setup+0x0/0x5c returned 0 after 152 usecs
> [    0.496803] calling  eventpoll_init+0x0/0xbc @ 1
> [    0.497476] initcall eventpoll_init+0x0/0xbc returned 0 after 150 usecs
> [    0.498117] calling  anon_inode_init+0x0/0x6c @ 1
> [    0.499029] initcall anon_inode_init+0x0/0x6c returned 0 after 373 usecs
> [    0.499697] calling  proc_cmdline_init+0x0/0x40 @ 1
> [    0.500615] initcall proc_cmdline_init+0x0/0x40 returned 0 after 94 usecs
> [    0.501278] calling  proc_consoles_init+0x0/0x40 @ 1
> [    0.501855] initcall proc_consoles_init+0x0/0x40 returned 0 after 72 usecs
> [    0.502477] calling  proc_cpuinfo_init+0x0/0x40 @ 1
> [    0.503308] initcall proc_cpuinfo_init+0x0/0x40 returned 0 after 80 usecs
> [    0.503974] calling  proc_devices_init+0x0/0x40 @ 1
> [    0.504658] initcall proc_devices_init+0x0/0x40 returned 0 after 159 usecs
> [    0.505309] calling  proc_interrupts_init+0x0/0x40 @ 1
> [    0.505900] initcall proc_interrupts_init+0x0/0x40 returned 0 after 73 usecs
> [    0.506526] calling  proc_loadavg_init+0x0/0x40 @ 1
> [    0.507101] initcall proc_loadavg_init+0x0/0x40 returned 0 after 71 usecs
> [    0.507725] calling  proc_meminfo_init+0x0/0x40 @ 1
> [    0.508306] initcall proc_meminfo_init+0x0/0x40 returned 0 after 73 usecs
> [    0.508920] calling  proc_stat_init+0x0/0x40 @ 1
> [    0.509488] initcall proc_stat_init+0x0/0x40 returned 0 after 69 usecs
> [    0.510103] calling  proc_uptime_init+0x0/0x40 @ 1
> [    0.510681] initcall proc_uptime_init+0x0/0x40 returned 0 after 68 usecs
> [    0.511307] calling  proc_version_init+0x0/0x40 @ 1
> [    0.511888] initcall proc_version_init+0x0/0x40 returned 0 after 70 usecs
> [    0.512510] calling  proc_softirqs_init+0x0/0x40 @ 1
> [    0.513448] initcall proc_softirqs_init+0x0/0x40 returned 0 after 86 usecs
> [    0.514122] calling  proc_kmsg_init+0x0/0x40 @ 1
> [    0.514705] initcall proc_kmsg_init+0x0/0x40 returned 0 after 73 usecs
> [    0.515327] calling  proc_page_init+0x0/0x60 @ 1
> [    0.515946] initcall proc_page_init+0x0/0x60 returned 0 after 111 usecs
> [    0.516484] calling  init_ramfs_fs+0x0/0x50 @ 1
> [    0.516909] initcall init_ramfs_fs+0x0/0x50 returned 0 after 7 usecs
> [    0.517410] calling  blk_scsi_ioctl_init+0x0/0xe4 @ 1
> [    0.517864] initcall blk_scsi_ioctl_init+0x0/0xe4 returned 0 after 11 usecs
> [    0.518391] calling  fb_console_init+0x0/0x148 @ 1
> [    0.519805] initcall fb_console_init+0x0/0x148 returned 0 after 920 usecs
> [    0.520411] calling  chr_dev_init+0x0/0xc4 @ 1
> [    0.784268] initcall chr_dev_init+0x0/0xc4 returned 0 after 257183 usecs
> [    0.784931] calling  firmware_class_init+0x0/0x2c @ 1
> [    0.785399] initcall firmware_class_init+0x0/0x2c returned 0 after 6 usecs
> [    0.785970] calling  sysctl_core_init+0x0/0x38 @ 1
> [    0.786759] initcall sysctl_core_init+0x0/0x38 returned 0 after 296 usecs
> [    0.787370] calling  eth_offload_init+0x0/0x20 @ 1
> [    0.787843] initcall eth_offload_init+0x0/0x20 returned 0 after 8 usecs
> [    0.788412] calling  inet_init+0x0/0x234 @ 1
> [    0.789215] NET: Registered protocol family 2
> [    0.795767] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.796417] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.796886] TCP: Hash tables configured (established 1024 bind 1024)
> [    0.798050] UDP hash table entries: 256 (order: 0, 4096 bytes)
> [    0.798587] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
> [    0.800263] initcall inet_init+0x0/0x234 returned 0 after 11062 usecs
> [    0.800927] calling  ipv4_offload_init+0x0/0x64 @ 1
> [    0.801422] initcall ipv4_offload_init+0x0/0x64 returned 0 after 16 usecs
> [    0.801939] calling  af_unix_init+0x0/0x5c @ 1
> [    0.802483] NET: Registered protocol family 1
> [    0.803551] initcall af_unix_init+0x0/0x5c returned 0 after 1123 usecs
> [    0.804126] calling  ipv6_offload_init+0x0/0x7c @ 1
> [    0.804585] initcall ipv6_offload_init+0x0/0x7c returned 0 after 22 usecs
> [    0.805149] calling  populate_rootfs+0x0/0x110 @ 1
> [    0.817628] Unpacking initramfs...
> [   16.319307] Freeing initrd memory: 2828K (c1c00000 - c1ec3000)
> [   16.319929] initcall populate_rootfs+0x0/0x110 returned 0 after 15150660 usecs
> [   16.321251] calling  proc_execdomains_init+0x0/0x40 @ 1
> [   16.321826] initcall proc_execdomains_init+0x0/0x40 returned 0 after 93 usecs
> [   16.322359] calling  ioresources_init+0x0/0x60 @ 1
> [   16.323264] initcall ioresources_init+0x0/0x60 returned 0 after 114 usecs
> [   16.323850] calling  irq_gc_init_ops+0x0/0x20 @ 1
> [   16.324308] initcall irq_gc_init_ops+0x0/0x20 returned 0 after 12 usecs
> [   16.324832] calling  init_posix_timers+0x0/0x21c @ 1
> [   16.325510] initcall init_posix_timers+0x0/0x21c returned 0 after 192 usecs
> [   16.326100] calling  init_posix_cpu_timers+0x0/0xe0 @ 1
> [   16.326585] initcall init_posix_cpu_timers+0x0/0xe0 returned 0 after 20 usecs
> [   16.327123] calling  timekeeping_init_ops+0x0/0x20 @ 1
> [   16.327592] initcall timekeeping_init_ops+0x0/0x20 returned 0 after 11 usecs
> [   16.328131] calling  init_clocksource_sysfs+0x0/0x7c @ 1
> [   16.330341] initcall init_clocksource_sysfs+0x0/0x7c returned 0 after 1675 usecs
> [   16.331109] calling  init_timer_list_procfs+0x0/0x44 @ 1
> [   16.331667] initcall init_timer_list_procfs+0x0/0x44 returned 0 after 86 usecs
> [   16.332357] calling  alarmtimer_init+0x0/0x170 @ 1
> [   16.335004] initcall alarmtimer_init+0x0/0x170 returned 0 after 1770 usecs
> [   16.335648] calling  clockevents_init_sysfs+0x0/0x74 @ 1
> [   16.337701] initcall clockevents_init_sysfs+0x0/0x74 returned 0 after 1517 usecs
> [   16.338467] calling  sched_clock_syscore_init+0x0/0x20 @ 1
> [   16.338949] initcall sched_clock_syscore_init+0x0/0x20 returned 0 after 11 usecs
> [   16.339627] calling  futex_init+0x0/0xc8 @ 1
> [   16.340077] futex hash table entries: 256 (order: -1, 3072 bytes)
> [   16.340623] initcall futex_init+0x0/0xc8 returned 0 after 535 usecs
> [   16.341160] calling  proc_modules_init+0x0/0x40 @ 1
> [   16.341711] initcall proc_modules_init+0x0/0x40 returned 0 after 87 usecs
> [   16.342258] calling  kallsyms_init+0x0/0x40 @ 1
> [   16.343137] initcall kallsyms_init+0x0/0x40 returned 0 after 70 usecs
> [   16.343749] calling  utsname_sysctl_init+0x0/0x20 @ 1
> [   16.344377] initcall utsname_sysctl_init+0x0/0x20 returned 0 after 144 usecs
> [   16.344942] calling  init_per_zone_wmark_min+0x0/0xb4 @ 1
> [   16.345440] initcall init_per_zone_wmark_min+0x0/0xb4 returned 0 after 45 usecs
> [   16.346128] calling  kswapd_init+0x0/0x20 @ 1
> [   16.586092] initcall kswapd_init+0x0/0x20 returned 0 after 233848 usecs
> [   16.586739] calling  setup_vmstat+0x0/0x98 @ 1
> [   16.587417] initcall setup_vmstat+0x0/0x98 returned 0 after 199 usecs
> [   16.587976] calling  slab_proc_init+0x0/0x40 @ 1
> [   16.588519] initcall slab_proc_init+0x0/0x40 returned 0 after 72 usecs
> [   16.589088] calling  workingset_init+0x0/0x58 @ 1
> [   16.589587] initcall workingset_init+0x0/0x58 returned 0 after 24 usecs
> [   16.590148] calling  proc_vmalloc_init+0x0/0x40 @ 1
> [   16.590700] initcall proc_vmalloc_init+0x0/0x40 returned 0 after 72 usecs
> [   16.591300] calling  procswaps_init+0x0/0x40 @ 1
> [   16.591856] initcall procswaps_init+0x0/0x40 returned 0 after 71 usecs
> [   16.592463] calling  slab_sysfs_init+0x0/0x110 @ 1
> [   16.688324] initcall slab_sysfs_init+0x0/0x110 returned 0 after 92767 usecs
> [   16.689011] calling  fcntl_init+0x0/0x48 @ 1
> [   16.689667] initcall fcntl_init+0x0/0x48 returned 0 after 156 usecs
> [   16.690296] calling  proc_filesystems_init+0x0/0x40 @ 1
> [   16.690894] initcall proc_filesystems_init+0x0/0x40 returned 0 after 83 usecs
> [   16.691535] calling  start_dirtytime_writeback+0x0/0x3c @ 1
> [   16.692081] initcall start_dirtytime_writeback+0x0/0x3c returned 0 after 31 usecs
> [   16.693215] calling  dio_init+0x0/0x48 @ 1
> [   16.696056] initcall dio_init+0x0/0x48 returned 0 after 2214 usecs
> [   16.696738] calling  fsnotify_mark_init+0x0/0x44 @ 1
> [   19.150951] initcall fsnotify_mark_init+0x0/0x44 returned 0 after 2396146 usecs
> [   19.151790] calling  aio_setup+0x0/0x8c @ 1
> [   19.155448] initcall aio_setup+0x0/0x8c returned 0 after 3058 usecs
> [   19.156133] calling  proc_locks_init+0x0/0x40 @ 1
> [   19.156729] initcall proc_locks_init+0x0/0x40 returned 0 after 87 usecs
> [   19.157344] calling  init_mbcache+0x0/0x20 @ 1
> [   19.157854] initcall init_mbcache+0x0/0x20 returned 0 after 20 usecs
> [   19.158365] calling  init_devpts_fs+0x0/0x70 @ 1
> [   19.159289] initcall init_devpts_fs+0x0/0x70 returned 0 after 464 usecs
> [   19.159846] calling  ext4_init_fs+0x0/0x274 @ 1
> [   19.172257] initcall ext4_init_fs+0x0/0x274 returned 0 after 11669 usecs
> [   19.173220] calling  journal_init+0x0/0x120 @ 1
> [   19.180704] initcall journal_init+0x0/0x120 returned 0 after 6808 usecs
> [   19.181310] calling  init_nls_cp437+0x0/0x20 @ 1
> [   19.181743] initcall init_nls_cp437+0x0/0x20 returned 0 after 10 usecs
> [   19.182239] calling  init_nls_cp850+0x0/0x20 @ 1
> [   19.182664] initcall init_nls_cp850+0x0/0x20 returned 0 after 8 usecs
> [   19.183579] calling  init_nls_cp852+0x0/0x20 @ 1
> [   19.184022] initcall init_nls_cp852+0x0/0x20 returned 0 after 10 usecs
> [   19.184526] calling  init_nls_iso8859_1+0x0/0x20 @ 1
> [   19.184960] initcall init_nls_iso8859_1+0x0/0x20 returned 0 after 8 usecs
> [   19.185467] calling  init_nls_iso8859_2+0x0/0x20 @ 1
> [   19.185899] initcall init_nls_iso8859_2+0x0/0x20 returned 0 after 8 usecs
> [   19.186384] calling  ipc_init+0x0/0x20 @ 1
> [   19.186987] initcall ipc_init+0x0/0x20 returned 0 after 177 usecs
> [   19.187498] calling  ipc_sysctl_init+0x0/0x20 @ 1
> [   19.188133] initcall ipc_sysctl_init+0x0/0x20 returned 0 after 185 usecs
> [   19.188670] calling  init_mqueue_fs+0x0/0xec @ 1
> [   19.191879] initcall init_mqueue_fs+0x0/0xec returned 0 after 2671 usecs
> [   19.192495] calling  crypto_algapi_init+0x0/0x18 @ 1
> [   19.193417] initcall crypto_algapi_init+0x0/0x18 returned 0 after 91 usecs
> [   19.194004] calling  chainiv_module_init+0x0/0x1c @ 1
> [   19.194472] initcall chainiv_module_init+0x0/0x1c returned 0 after 22 usecs
> [   19.194992] calling  eseqiv_module_init+0x0/0x1c @ 1
> [   19.195446] initcall eseqiv_module_init+0x0/0x1c returned 0 after 17 usecs
> [   19.195964] calling  crypto_null_mod_init+0x0/0x54 @ 1
> [   19.562106] initcall crypto_null_mod_init+0x0/0x54 returned 0 after 357077 usecs
> [   19.563311] calling  aes_init+0x0/0x1c @ 1
> [   19.565230] initcall aes_init+0x0/0x1c returned 0 after 1357 usecs
> [   19.565831] calling  crc32c_mod_init+0x0/0x1c @ 1
> [   19.567808] initcall crc32c_mod_init+0x0/0x1c returned 0 after 1458 usecs
> [   19.568424] calling  proc_genhd_init+0x0/0x60 @ 1
> [   19.568996] initcall proc_genhd_init+0x0/0x60 returned 0 after 126 usecs
> [   19.569520] calling  noop_init+0x0/0x1c @ 1
> [   19.569891] io scheduler noop registered
> [   19.570302] initcall noop_init+0x0/0x1c returned 0 after 342 usecs
> [   19.570795] calling  cfq_init+0x0/0xa0 @ 1
> [   19.574272] io scheduler cfq registered (default)
> [   19.574838] initcall cfq_init+0x0/0xa0 returned 0 after 3506 usecs
> [   19.575361] calling  bgpio_driver_init+0x0/0x20 @ 1
> [   19.579075] initcall bgpio_driver_init+0x0/0x20 returned 0 after 3164 usecs
> [   19.579702] calling  omapfb_init+0x0/0x22c @ 1
> [   19.581926] initcall omapfb_init+0x0/0x22c returned 0 after 1717 usecs
> [   19.582561] calling  ams_delta_panel_driver_init+0x0/0x20 @ 1
> [   19.584103] initcall ams_delta_panel_driver_init+0x0/0x20 returned 0 after 686 usecs
> [   19.584865] calling  pty_init+0x0/0x23c @ 1
> [   19.733808] initcall pty_init+0x0/0x23c returned 0 after 144996 usecs
> [   19.734437] calling  sysrq_init+0x0/0xa0 @ 1
> [   19.734983] initcall sysrq_init+0x0/0xa0 returned 0 after 105 usecs
> [   19.735525] calling  serial8250_init+0x0/0x140 @ 1
> [   19.735911] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [   19.884599] console [ttyS0] disabled
> [   19.905669] serial8250.0: ttyS0 at MMIO 0xfffb0000 (irq = 62, base_baud = 750000) is a ST16654
> [   22.415388] console [ttyS0] enabled
> [   22.667578] serial8250.0: ttyS1 at MMIO 0xfffb0800 (irq = 63, base_baud = 750000) is a ST16654
> [   22.771292] serial8250.0: ttyS2 at MMIO 0xfffb9800 (irq = 31, base_baud = 750000) is a ST16654
> [   22.852692] initcall serial8250_init+0x0/0x140 returned 0 after 3043628 usecs
> [   22.860887] calling  topology_sysfs_init+0x0/0x28 @ 1
> [   22.867194] initcall topology_sysfs_init+0x0/0x28 returned 0 after 419 usecs
> [   22.875239] calling  cacheinfo_sysfs_init+0x0/0x22c @ 1
> [   22.881018] initcall cacheinfo_sysfs_init+0x0/0x22c returned -2 after 7 usecs
> [   22.889132] calling  init_sd+0x0/0x168 @ 1
> [   22.895261] initcall init_sd+0x0/0x168 returned 0 after 1159 usecs
> [   22.902092] calling  init_mtd+0x0/0xd8 @ 1
> [   22.908376] initcall init_mtd+0x0/0xd8 returned 0 after 1339 usecs
> [   22.915575] calling  nand_base_init+0x0/0x28 @ 1
> [   22.920777] initcall nand_base_init+0x0/0x28 returned 0 after 42 usecs
> [   22.928241] calling  ams_delta_nand_driver_init+0x0/0x20 @ 1
> [   22.935494] initcall ams_delta_nand_driver_init+0x0/0x20 returned 0 after 703 usecs
> [   22.944335] calling  net_olddevs_init+0x0/0x70 @ 1
> [   22.949778] initcall net_olddevs_init+0x0/0x70 returned 0 after 116 usecs
> [   22.957487] calling  asix_driver_init+0x0/0x28 @ 1
> [   22.963970] usbcore: registered new interface driver asix
> [   22.969966] initcall asix_driver_init+0x0/0x28 returned 0 after 6672 usecs
> [   22.977793] calling  ax88179_178a_driver_init+0x0/0x28 @ 1
> [   22.984885] usbcore: registered new interface driver ax88179_178a
> [   22.991603] initcall ax88179_178a_driver_init+0x0/0x28 returned 0 after 7271 usecs
> [   23.000267] calling  usbnet_init+0x0/0x38 @ 1
> [   23.005641] initcall usbnet_init+0x0/0x38 returned 0 after 145 usecs
> [   23.012641] calling  ohci_hcd_mod_init+0x0/0x5c @ 1
> [   23.018251] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [   23.025290] initcall ohci_hcd_mod_init+0x0/0x5c returned 0 after 6772 usecs
> [   23.033204] calling  ohci_omap_init+0x0/0x5c @ 1
> [   23.038264] ohci-omap: OHCI OMAP driver
> [   23.043449] ohci ohci: OMAP OHCI
> [   23.047371] ohci ohci: new USB bus registered, assigned bus number 1
> [   23.055708] ohci ohci: irq 54, io mem 0xfffba000
> [   23.413698] hub 1-0:1.0: USB hub found
> [   23.443277] hub 1-0:1.0: 3 ports detected
> [   23.455900] initcall ohci_omap_init+0x0/0x5c returned 0 after 407725 usecs
> [   23.463845] calling  usb_storage_driver_init+0x0/0x40 @ 1
> [   23.471161] usbcore: registered new interface driver usb-storage
> [   23.478136] initcall usb_storage_driver_init+0x0/0x40 returned 0 after 8099 usecs
> [   23.486725] calling  serport_init+0x0/0x34 @ 1
> [   23.491705] initcall serport_init+0x0/0x34 returned 0 after 8 usecs
> [   23.498875] calling  ams_delta_serio_init+0x0/0x178 @ 1
> [   23.505415] serio serio0: AMS DELTA keyboard adapter
> [   23.510968] initcall ams_delta_serio_init+0x0/0x178 returned 0 after 5862 usecs
> [   23.519375] calling  input_leds_init+0x0/0x1c @ 1
> [   23.524955] initcall input_leds_init+0x0/0x1c returned 0 after 17 usecs
> [   23.532203] calling  mousedev_init+0x0/0x8c @ 1
> [   23.693867] mousedev: PS/2 mouse device common for all mice
> [   23.700075] initcall mousedev_init+0x0/0x8c returned 0 after 158726 usecs
> [   23.707815] calling  evdev_init+0x0/0x1c @ 1
> [   23.712627] initcall evdev_init+0x0/0x1c returned 0 after 17 usecs
> [   23.719773] calling  atkbd_init+0x0/0x28 @ 1
> [   23.725690] initcall atkbd_init+0x0/0x28 returned 0 after 754 usecs
> [   23.732625] calling  omap_kp_driver_init+0x0/0x20 @ 1
> [   23.741356] input: omap-keypad as /devices/platform/omap-keypad/input/input0
> [   23.756118] input: AT Raw Set 2 keyboard as /devices/serio0/input/input1
> [   23.863326] usb 1-1: new full-speed USB device number 2 using ohci
> [   23.947848] initcall omap_kp_driver_init+0x0/0x20 returned 0 after 204410 usecs
> [   23.956371] calling  omap_rtc_driver_init+0x0/0x20 @ 1
> [   23.962699] omap_rtc omap_rtc: RTC power up reset detected
> [   24.063698] omap_rtc omap_rtc: rtc core: registered omap_rtc as rtc0
> [   24.071462] initcall omap_rtc_driver_init+0x0/0x20 returned 0 after 106798 usecs
> [   24.080038] calling  i2c_dev_init+0x0/0xe0 @ 1
> [   24.085210] i2c /dev entries driver
> [   24.175343] hub 1-1:1.0: USB hub found
> [   24.183802] hub 1-1:1.0: 4 ports detected
> [   24.253848] initcall i2c_dev_init+0x0/0xe0 returned 0 after 164555 usecs
> [   24.261243] calling  timer_trig_init+0x0/0x1c @ 1
> [   24.266819] initcall timer_trig_init+0x0/0x1c returned 0 after 32 usecs
> [   24.274406] calling  heartbeat_trig_init+0x0/0x48 @ 1
> [   24.280060] initcall heartbeat_trig_init+0x0/0x48 returned 0 after 41 usecs
> [   24.287961] calling  defon_trig_init+0x0/0x1c @ 1
> [   24.293588] initcall defon_trig_init+0x0/0x1c returned 0 after 34 usecs
> [   24.300845] calling  hid_init+0x0/0x4c @ 1
> [   24.306528] initcall hid_init+0x0/0x4c returned 0 after 770 usecs
> [   24.313633] calling  hid_generic_init+0x0/0x28 @ 1
> [   24.319692] initcall hid_generic_init+0x0/0x28 returned 0 after 679 usecs
> [   24.327476] calling  hid_init+0x0/0x64 @ 1
> [   24.333497] usbcore: registered new interface driver usbhid
> [   24.339538] usbhid: USB HID core driver
> [   24.344163] initcall hid_init+0x0/0x64 returned 0 after 11740 usecs
> [   24.351082] calling  sock_diag_init+0x0/0x58 @ 1
> [   24.356846] initcall sock_diag_init+0x0/0x58 returned 0 after 313 usecs
> [   24.364503] calling  gre_offload_init+0x0/0x20 @ 1
> [   24.369870] initcall gre_offload_init+0x0/0x20 returned 0 after 8 usecs
> [   24.377438] calling  sysctl_ipv4_init+0x0/0x5c @ 1
> [   24.384544] initcall sysctl_ipv4_init+0x0/0x5c returned 0 after 1658 usecs
> [   24.392063] calling  cubictcp_register+0x0/0x68 @ 1
> [   24.397757] initcall cubictcp_register+0x0/0x68 returned 0 after 24 usecs
> [   24.405459] calling  packet_init+0x0/0x50 @ 1
> [   24.410266] NET: Registered protocol family 17
> [   24.415590] initcall packet_init+0x0/0x50 returned 0 after 5116 usecs
> [   24.423683] calling  init_machine_late+0x0/0x60 @ 1
> [   24.430758] nand: device found, Manufacturer ID: 0x98, Chip ID: 0x75
> [   24.437972] nand: Toshiba NAND 32MiB 3,3V 8-bit
> [   24.443257] nand: 32 MiB, SLC, erase size: 16 KiB, page size: 512, OOB size: 16
> [   24.451269] Scanning device for bad blocks
> [   25.283058] Bad eraseblock 2000 at 0x000001f40000
> [   25.288464] Bad eraseblock 2001 at 0x000001f44000
> [   25.294138] Bad eraseblock 2002 at 0x000001f48000
> [   25.299520] Bad eraseblock 2003 at 0x000001f4c000
> [   25.305192] Bad eraseblock 2004 at 0x000001f50000
> [   25.310574] Bad eraseblock 2005 at 0x000001f54000
> [   25.316246] Bad eraseblock 2006 at 0x000001f58000
> [   25.321627] Bad eraseblock 2007 at 0x000001f5c000
> [   25.327297] Bad eraseblock 2008 at 0x000001f60000
> [   25.332678] Bad eraseblock 2009 at 0x000001f64000
> [   25.338392] Bad eraseblock 2010 at 0x000001f68000
> [   25.344068] Bad eraseblock 2011 at 0x000001f6c000
> [   25.349448] Bad eraseblock 2012 at 0x000001f70000
> [   25.355115] Bad eraseblock 2013 at 0x000001f74000
> [   25.360496] Bad eraseblock 2014 at 0x000001f78000
> [   25.366167] Bad eraseblock 2015 at 0x000001f7c000
> [   25.371548] Bad eraseblock 2016 at 0x000001f80000
> [   25.377216] Bad eraseblock 2017 at 0x000001f84000
> [   25.382596] Bad eraseblock 2018 at 0x000001f88000
> [   25.388264] Bad eraseblock 2019 at 0x000001f8c000
> [   25.393976] Bad eraseblock 2020 at 0x000001f90000
> [   25.399352] Bad eraseblock 2021 at 0x000001f94000
> [   25.405014] Bad eraseblock 2022 at 0x000001f98000
> [   25.410398] Bad eraseblock 2023 at 0x000001f9c000
> [   25.416068] Bad eraseblock 2024 at 0x000001fa0000
> [   25.421448] Bad eraseblock 2025 at 0x000001fa4000
> [   25.427116] Bad eraseblock 2026 at 0x000001fa8000
> [   25.432498] Bad eraseblock 2027 at 0x000001fac000
> [   25.438164] Bad eraseblock 2028 at 0x000001fb0000
> [   25.443874] Bad eraseblock 2029 at 0x000001fb4000
> [   25.449654] Bad eraseblock 2031 at 0x000001fbc000
> [   25.455324] Bad eraseblock 2032 at 0x000001fc0000
> [   25.460708] Bad eraseblock 2033 at 0x000001fc4000
> [   25.466373] Bad eraseblock 2034 at 0x000001fc8000
> [   25.471763] Bad eraseblock 2035 at 0x000001fcc000
> [   25.477435] Bad eraseblock 2036 at 0x000001fd0000
> [   25.483141] Bad eraseblock 2037 at 0x000001fd4000
> [   25.488537] Bad eraseblock 2038 at 0x000001fd8000
> [   25.494210] Bad eraseblock 2039 at 0x000001fdc000
> [   25.499593] Bad eraseblock 2040 at 0x000001fe0000
> [   25.505263] Bad eraseblock 2041 at 0x000001fe4000
> [   25.510648] Bad eraseblock 2042 at 0x000001fe8000
> [   25.516316] Bad eraseblock 2043 at 0x000001fec000
> [   25.521700] Bad eraseblock 2044 at 0x000001ff0000
> [   25.527367] Bad eraseblock 2045 at 0x000001ff4000
> [   25.723263] usb 1-1.3: new full-speed USB device number 3 using ohci
> 
> A.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
