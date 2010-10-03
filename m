From: Ming Lei <tom.leiming@gmail.com>
Subject: beagle hangs in uart3 disabling clocks
Date: Sun, 3 Oct 2010 17:04:11 +0800
Message-ID: <AANLkTi=9T=5swvF2UcrfDAL8cpHOcfpOU3Fi1O50Z6Tm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41416 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512Ab0JCJEN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 3 Oct 2010 05:04:13 -0400
Received: by wyb28 with SMTP id 28so4107401wyb.19
        for <linux-omap@vger.kernel.org>; Sun, 03 Oct 2010 02:04:11 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

Hi,

I just tested pm branch of tony's linux-omap-2.6 tree, and found my
beagle will hang in uart3 disabling clocks, follows the log info:


Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Linux version 2.6.36-rc6+ (tom@tom-lei) (gcc version 4.3.3 (Sourcery
G++ Lite 2009q1-203) ) #320 PREEM
PT Sun Oct 3 16:46:04 CST 2010
CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP3 Beagle Board
bootconsole [earlycon0] enabled
Memory policy: ECC disabled, Data cache writeback
OMAP3430/3530 ES2.1 (l2cache iva sgx neon isp )
SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x10000
On node 0 totalpages: 32768
free_area_init_node: node 0, pgdat c04a1a00, node_mem_map c06b8000
  Normal zone: 256 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 32512 pages, LIFO batch:7
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: console=ttyO2,115200n8 root=/dev/mmcblk0p2 rw
rootdelay=1 earlyprintk initcall_de
bug=1 loglevel=8
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128MB = 128MB total
Memory: 123068k/123068k available, 8004k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xc8800000 - 0xf8000000   ( 760 MB)
    lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .init : 0xc0008000 - 0xc0034000   ( 176 kB)
      .text : 0xc0034000 - 0xc046c000   (4320 kB)
      .data : 0xc046c000 - 0xc04a2000   ( 216 kB)
Preemptable hierarchical RCU implementation.
        RCU-based detection of stalled CPUs is disabled.
        Verbose stalled-CPUs detection is disabled.
NR_IRQS:402
omap_hwmod: l3_main: registering
omap_hwmod: l3_main: MPU OCP slave port ID  0
omap_hwmod: l3_main: no MPU register target found
omap_hwmod: l4_core: registering
omap_hwmod: l4_core: MPU OCP slave port ID  0
omap_hwmod: l4_core: no MPU register target found
omap_hwmod: l4_per: registering
omap_hwmod: l4_per: MPU OCP slave port ID  0
omap_hwmod: l4_per: no MPU register target found
omap_hwmod: l4_wkup: registering
omap_hwmod: l4_wkup: MPU OCP slave port ID  0
omap_hwmod: l4_wkup: no MPU register target found
omap_hwmod: mpu: registering
omap_hwmod: iva: registering
omap_hwmod: wd_timer2: registering
omap_hwmod: wd_timer2: MPU OCP slave port ID  0
omap_hwmod: wd_timer2: MPU register target at va fa314000
omap_hwmod: uart1: registering
omap_hwmod: uart1: MPU OCP slave port ID  0
omap_hwmod: uart1: MPU register target at va fa06a000
omap_hwmod: uart2: registering
omap_hwmod: uart2: MPU OCP slave port ID  0
omap_hwmod: uart2: MPU register target at va fa06c000
omap_hwmod: uart3: registering
omap_hwmod: uart3: MPU OCP slave port ID  0
omap_hwmod: uart3: MPU register target at va fb020000
omap_hwmod: i2c1: registering
omap_hwmod: i2c1: MPU OCP slave port ID  0
omap_hwmod: i2c1: MPU register target at va fa070000
omap_hwmod: i2c2: registering
omap_hwmod: i2c2: MPU OCP slave port ID  0
omap_hwmod: i2c2: MPU register target at va fa072000
omap_hwmod: i2c3: registering
omap_hwmod: i2c3: MPU OCP slave port ID  0
omap_hwmod: i2c3: MPU register target at va fa060000
omap_hwmod: sr1_hwmod: registering
omap_hwmod: sr1_hwmod: MPU OCP slave port ID  0
omap_hwmod: sr1_hwmod: MPU register target at va fa0c9000
omap_hwmod: sr2_hwmod: registering
omap_hwmod: sr2_hwmod: MPU OCP slave port ID  0
omap_hwmod: sr2_hwmod: MPU register target at va fa0cb000
Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
omap_hwmod: l3_main: looking up clocks
omap_hwmod: l4_core: looking up clocks
omap_hwmod: l4_per: looking up clocks
omap_hwmod: l4_wkup: looking up clocks
omap_hwmod: mpu: looking up clocks
omap_hwmod: iva: looking up clocks
omap_hwmod: wd_timer2: looking up clocks
omap_hwmod: uart1: looking up clocks
omap_hwmod: uart2: looking up clocks
omap_hwmod: uart3: looking up clocks
omap_hwmod: i2c1: looking up clocks
omap_hwmod: i2c2: looking up clocks
omap_hwmod: i2c3: looking up clocks
omap_hwmod: sr1_hwmod: looking up clocks
omap_hwmod: sr1_fck: missing clockdomain for sr1_fck.
omap_hwmod: sr2_hwmod: looking up clocks
omap_hwmod: sr2_fck: missing clockdomain for sr2_fck.
omap_hwmod: l3_main: enabling
omap_hwmod: l3_main: enabling clocks
omap_hwmod: l3_main: idling
omap_hwmod: l3_main: disabling clocks
omap_hwmod: l4_core: enabling
omap_hwmod: l4_core: enabling clocks
omap_hwmod: l4_core: idling
omap_hwmod: l4_core: disabling clocks
omap_hwmod: l4_per: enabling
omap_hwmod: l4_per: enabling clocks
omap_hwmod: l4_per: idling
omap_hwmod: l4_per: disabling clocks
omap_hwmod: l4_wkup: enabling
omap_hwmod: l4_wkup: enabling clocks
omap_hwmod: l4_wkup: idling
omap_hwmod: l4_wkup: disabling clocks
omap_hwmod: mpu: enabling
omap_hwmod: mpu: enabling clocks
omap_hwmod: mpu: idling
omap_hwmod: mpu: disabling clocks
omap_hwmod: iva: enabling
omap_hwmod: iva: enabling clocks
omap_hwmod: iva: idling
omap_hwmod: iva: disabling clocks
omap_hwmod: wd_timer2: enabling
omap_hwmod: wd_timer2: enabling clocks
omap_hwmod: wd_timer2: resetting
omap_hwmod: wd_timer2: softreset in 0 usec
omap_hwmod: wd_timer2: idling
omap_hwmod: wd_timer2: disabling clocks
omap_hwmod: uart1: enabling
omap_hwmod: uart1: enabling clocks
omap_hwmod: uart2: enabling
omap_hwmod: uart2: enabling clocks
omap_hwmod: uart3: enabling
omap_hwmod: uart3: enabling clocks
omap_hwmod: i2c1: enabling
omap_hwmod: i2c1: enabling clocks
omap_hwmod: i2c1: resetting
omap_hwmod: i2c1: softreset in 0 usec
omap_hwmod: i2c1: idling
omap_hwmod: i2c1: disabling clocks
omap_hwmod: i2c2: enabling
omap_hwmod: i2c2: enabling clocks
omap_hwmod: i2c2: resetting
omap_hwmod: i2c2: softreset in 0 usec
omap_hwmod: i2c2: idling
omap_hwmod: i2c2: disabling clocks
omap_hwmod: i2c3: enabling
omap_hwmod: i2c3: enabling clocks
omap_hwmod: i2c3: resetting
omap_hwmod: i2c3: softreset in 0 usec
omap_hwmod: i2c3: idling
omap_hwmod: i2c3: disabling clocks
omap_hwmod: sr1_hwmod: enabling
omap_hwmod: sr1_hwmod: enabling clocks
omap_hwmod: sr1_hwmod: idling
omap_hwmod: sr1_hwmod: disabling clocks
omap_hwmod: sr2_hwmod: enabling
omap_hwmod: sr2_hwmod: enabling clocks
omap_hwmod: sr2_hwmod: idling
omap_hwmod: sr2_hwmod: disabling clocks
Reprogramming SDRC clock to 332000000 Hz
GPMC revision 5.0
IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP GPIO hardware version 2.5
OMAP clockevent source: GPTIMER12 at 32768 Hz
Console: colour dummy device 80x30
Calibrating delay loop... 471.61 BogoMIPS (lpj=1843200)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
calling  spawn_ksoftirqd+0x0/0x50 @ 1
initcall spawn_ksoftirqd+0x0/0x50 returned 0 after 0 usecs
calling  init_workqueues+0x0/0x234 @ 1
initcall init_workqueues+0x0/0x234 returned 0 after 0 usecs
devtmpfs: initialized
device: 'platform': device_add
PM: Adding info for No Bus:platform
bus: 'platform': registered
Registering sysdev class 'cpu'
calling  init_mmap_min_addr+0x0/0x18 @ 1
initcall init_mmap_min_addr+0x0/0x18 returned 0 after 0 usecs
calling  init_cpufreq_transition_notifier_list+0x0/0x2c @ 1
initcall init_cpufreq_transition_notifier_list+0x0/0x2c returned 0 after 0 usecs
calling  net_ns_init+0x0/0x180 @ 1
initcall net_ns_init+0x0/0x180 returned 0 after 0 usecs
calling  ptrace_break_init+0x0/0x34 @ 1
initcall ptrace_break_init+0x0/0x34 returned 0 after 0 usecs
calling  consistent_init+0x0/0xc0 @ 1
initcall consistent_init+0x0/0xc0 returned 0 after 0 usecs
calling  v6_userpage_init+0x0/0x14 @ 1
initcall v6_userpage_init+0x0/0x14 returned 0 after 0 usecs
calling  omap_voltage_init+0x0/0x4b4 @ 1
vp_latch_vsel: PMIC function to convert voltage in uV to vsel not registered
init_voltageprocessor: vp_latch_vsel failed
vp_latch_vsel: PMIC function to convert voltage in uV to vsel not registered
init_voltageprocessor: vp_latch_vsel failed
initcall omap_voltage_init+0x0/0x4b4 returned 0 after 22888 usecs
calling  omap_pm_runtime_init+0x0/0x9c @ 1
initcall omap_pm_runtime_init+0x0/0x9c returned 0 after 0 usecs
calling  omap_device_init+0x0/0x1c @ 1
device: 'omap': device_add
PM: Adding info for No Bus:omap
initcall omap_device_init+0x0/0x1c returned 0 after 7629 usecs
calling  sysctl_init+0x0/0x24 @ 1
initcall sysctl_init+0x0/0x24 returned 0 after 0 usecs
calling  ksysfs_init+0x0/0xa0 @ 1
initcall ksysfs_init+0x0/0xa0 returned 0 after 0 usecs
calling  init_jiffies_clocksource+0x0/0x1c @ 1
initcall init_jiffies_clocksource+0x0/0x1c returned 0 after 0 usecs
calling  pm_init+0x0/0x7c @ 1
initcall pm_init+0x0/0x7c returned 0 after 0 usecs
calling  init_zero_pfn+0x0/0x3c @ 1
initcall init_zero_pfn+0x0/0x3c returned 0 after 0 usecs
calling  fsnotify_init+0x0/0x2c @ 1
initcall fsnotify_init+0x0/0x2c returned 0 after 0 usecs
calling  filelock_init+0x0/0x4c @ 1
initcall filelock_init+0x0/0x4c returned 0 after 0 usecs
calling  init_misc_binfmt+0x0/0x48 @ 1
initcall init_misc_binfmt+0x0/0x48 returned 0 after 0 usecs
calling  init_script_binfmt+0x0/0x20 @ 1
initcall init_script_binfmt+0x0/0x20 returned 0 after 0 usecs
calling  init_elf_binfmt+0x0/0x20 @ 1
initcall init_elf_binfmt+0x0/0x20 returned 0 after 0 usecs
calling  debugfs_init+0x0/0x68 @ 1
initcall debugfs_init+0x0/0x68 returned 0 after 0 usecs
calling  random32_init+0x0/0x98 @ 1
initcall random32_init+0x0/0x98 returned 0 after 0 usecs
calling  regulator_init+0x0/0x38 @ 1
regulator: core version 0.5
device class 'regulator': registering
initcall regulator_init+0x0/0x38 returned 0 after 7629 usecs
calling  cpufreq_core_init+0x0/0x6c @ 1
initcall cpufreq_core_init+0x0/0x6c returned 0 after 0 usecs
calling  cpuidle_init+0x0/0x34 @ 1
initcall cpuidle_init+0x0/0x34 returned 0 after 0 usecs
calling  sock_init+0x0/0x78 @ 1
initcall sock_init+0x0/0x78 returned 0 after 0 usecs
calling  netpoll_init+0x0/0x2c @ 1
initcall netpoll_init+0x0/0x2c returned 0 after 0 usecs
calling  netlink_proto_init+0x0/0x1a0 @ 1
NET: Registered protocol family 16
initcall netlink_proto_init+0x0/0x1a0 returned 0 after 0 usecs
calling  bdi_class_init+0x0/0x64 @ 1
device class 'bdi': registering
initcall bdi_class_init+0x0/0x64 returned 0 after 0 usecs
calling  kobject_uevent_init+0x0/0x28 @ 1
initcall kobject_uevent_init+0x0/0x28 returned 0 after 0 usecs
calling  gpiolib_sysfs_init+0x0/0xec @ 1
device class 'gpio': registering
device: 'gpiochip0': device_add
PM: Adding info for No Bus:gpiochip0
device: 'gpiochip32': device_add
PM: Adding info for No Bus:gpiochip32
device: 'gpiochip64': device_add
PM: Adding info for No Bus:gpiochip64
device: 'gpiochip96': device_add
PM: Adding info for No Bus:gpiochip96
device: 'gpiochip128': device_add
PM: Adding info for No Bus:gpiochip128
device: 'gpiochip160': device_add
PM: Adding info for No Bus:gpiochip160
initcall gpiolib_sysfs_init+0x0/0xec returned 0 after 45776 usecs
calling  tty_class_init+0x0/0x4c @ 1
device class 'tty': registering
initcall tty_class_init+0x0/0x4c returned 0 after 7629 usecs
calling  vtconsole_class_init+0x0/0xf0 @ 1
device class 'vtconsole': registering
device: 'vtcon0': device_add
PM: Adding info for No Bus:vtcon0
initcall vtconsole_class_init+0x0/0xf0 returned 0 after 7629 usecs
calling  i2c_init+0x0/0x74 @ 1
bus: 'i2c': registered
bus: 'i2c': add driver dummy
initcall i2c_init+0x0/0x74 returned 0 after 0 usecs
calling  customize_machine+0x0/0x2c @ 1
mux: Setting signal mcspi1_clk.gpio171 0x0100 -> 0x011c
mux: Setting signal mcspi1_simo.gpio172 0x0100 -> 0x011c
mux: Setting signal mcspi1_somi.gpio173 0x0100 -> 0x011c
OMAP3 Beagle Rev: Ax/Bx
omap_device: i2c_omap: building with 1 hwmods
omap_device: i2c_omap: counted 4 total resources across 1 hwmods
omap_device: i2c_omap: registering
Registering platform device 'i2c_omap.1'. Parent at omap
device: 'i2c_omap.1': device_add
bus: 'platform': add device i2c_omap.1
PM: Adding info for platform:i2c_omap.1
mux: Setting signal i2c3_scl.i2c3_scl 0x0118 -> 0x0100
mux: Setting signal i2c3_sda.i2c3_sda 0x0118 -> 0x0100
omap_device: i2c_omap: building with 1 hwmods
omap_device: i2c_omap: counted 4 total resources across 1 hwmods
omap_device: i2c_omap: registering
Registering platform device 'i2c_omap.3'. Parent at omap
device: 'i2c_omap.3': device_add
bus: 'platform': add device i2c_omap.3
PM: Adding info for platform:i2c_omap.3
Registering platform device 'leds-gpio'. Parent at platform
device: 'leds-gpio': device_add
bus: 'platform': add device leds-gpio
PM: Adding info for platform:leds-gpio
Registering platform device 'gpio-keys'. Parent at platform
device: 'gpio-keys': device_add
bus: 'platform': add device gpio-keys
PM: Adding info for platform:gpio-keys
Registering platform device 'omapdss'. Parent at platform
device: 'omapdss': device_add
bus: 'platform': add device omapdss
PM: Adding info for platform:omapdss
omap_device: omap-hsuart: building with 1 hwmods
omap_device: omap-hsuart: counted 4 total resources across 1 hwmods
omap_device: omap-hsuart: registering
Registering platform device 'omap-hsuart.0'. Parent at omap
device: 'omap-hsuart.0': device_add
bus: 'platform': add device omap-hsuart.0
PM: Adding info for platform:omap-hsuart.0
omap_hwmod: uart1: idling
omap_hwmod: uart1: disabling clocks
omap_device: omap-hsuart: activating
omap_hwmod: uart1: enabling
omap_hwmod: uart1: enabling clocks
omap_device: omap-hsuart: pm_lat 0: activate: elapsed time 0 nsec
omap_device: omap-hsuart: deactivating
omap_hwmod: uart1: idling
omap_hwmod: uart1: disabling clocks
omap_device: omap-hsuart: pm_lat 0: deactivate: elapsed time 0 nsec
omap_device: omap-hsuart: activating
omap_hwmod: uart1: enabling
omap_hwmod: uart1: enabling clocks
omap_device: omap-hsuart: pm_lat 0: activate: elapsed time 0 nsec
omap_device: omap-hsuart: building with 1 hwmods
omap_device: omap-hsuart: counted 4 total resources across 1 hwmods
omap_device: omap-hsuart: registering
Registering platform device 'omap-hsuart.1'. Parent at omap
device: 'omap-hsuart.1': device_add
bus: 'platform': add device omap-hsuart.1
PM: Adding info for platform:omap-hsuart.1
omap_hwmod: uart2: idling
omap_hwmod: uart2: disabling clocks
omap_device: omap-hsuart: activating
omap_hwmod: uart2: enabling
omap_hwmod: uart2: enabling clocks
omap_device: omap-hsuart: pm_lat 0: activate: elapsed time 0 nsec
omap_device: omap-hsuart: deactivating
omap_hwmod: uart2: idling
omap_hwmod: uart2: disabling clocks
omap_device: omap-hsuart: pm_lat 0: deactivate: elapsed time 0 nsec
omap_device: omap-hsuart: activating
omap_hwmod: uart2: enabling
omap_hwmod: uart2: enabling clocks
omap_device: omap-hsuart: pm_lat 0: activate: elapsed time 0 nsec
omap_device: omap-hsuart: building with 1 hwmods
omap_device: omap-hsuart: counted 4 total resources across 1 hwmods
omap_device: omap-hsuart: registering
Registering platform device 'omap-hsuart.2'. Parent at omap
device: 'omap-hsuart.2': device_add
bus: 'platform': add device omap-hsuart.2
PM: Adding info for platform:omap-hsuart.2
omap_hwmod: uart3: idling
omap_hwmod: uart3: disabling clocks

Texas Instruments X-Loader 1.41
Starting OS Bootloader...


U-Boot 1.3.3 (Jul 10 2008 - 16:33:09)

OMAP3530-GP rev 2, CPU-OPP2 L3-165MHz
OMAP3 Beagle Board + LPDDR/NAND
DRAM:  128 MB
NAND:


-- 
Lei Ming
