From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [4.8.0-rc1] am335x-evm boot failure: n_tty_receive_buf_common:
 "Unable to handle kernel paging request.."
Date: Thu, 11 Aug 2016 19:50:08 +0300
Message-ID: <87ceb885-94a6-b9b3-60b3-2017198c4338@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-omap@vger.kernel.org

Hi All,

I've run nfs-boot stress test (1000 iteration) with Kernel 4.8.0-rc1
it has been failed ~25 times with "Unable to handle kernel paging request at virtual address 00002244"
triggered form n_tty_receive_buf_common().
config: omap2plus_defconfig

Log is below. Any thoughts? Is it smth. known?

-- 
regards,
-grygorii



Starting kernel ...



[    0.000000] Booting Linux on physical CPU 0x0

[    0.000000] Linux version 4.8.0-rc1-12423-g29b4817 (lcpdbld@dflsdit-build06.dal.design.ti.com) (gcc version 4.9.3 20150413 (prerelease) (Linaro GCC 4.9-2015.05) ) #1 SMP Mon Aug 8 06:10:37 CDT 2016

[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c5387d

[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache

[    0.000000] OF: fdt:Machine model: TI AM335x EVM

[    0.000000] cma: Reserved 16 MiB at 0xbe800000

[    0.000000] Memory policy: Data cache writeback

[    0.000000] CPU: All CPU(s) started in SVC mode.

[    0.000000] AM335X ES2.1 (sgx neon )

[    0.000000] percpu: Embedded 15 pages/cpu @ef6b7000 s31680 r8192 d21568 u61440

[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 259904

[    0.000000] Kernel command line: console=ttyO0,115200n8 earlyprintk=serial,ttyO0,115200n8 rootwait   ip=:::::eth0:dhcp  root=/dev/nfs rw nfsroot=192.168.1.254:/home/NFS_exports/am335x-evm/autofs/8820840e10ba8f8ed7842d9999fc04a3,nolock,v3,tcp,rsize=4096,wsize=4096 

[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)

[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)

[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)

[    0.000000] Memory: 999636K/1046528K available (7168K kernel code, 772K rwdata, 2368K rodata, 1024K init, 8122K bss, 30508K reserved, 16384K cma-reserved, 243712K highmem)

[    0.000000] Virtual kernel memory layout:

[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)

[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)

[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)

[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)

[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)

[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)

[    0.000000]       .text : 0xc0008000 - 0xc0800000   (8160 kB)

[    0.000000]       .init : 0xc0b00000 - 0xc0c00000   (1024 kB)

[    0.000000]       .data : 0xc0c00000 - 0xc0cc11ec   ( 773 kB)

[    0.000000]        .bss : 0xc0cc3000 - 0xc14b1978   (8123 kB)

[    0.000000] Running RCU self tests

[    0.000000] Hierarchical RCU implementation.

[    0.000000] 	RCU lockdep checking is enabled.

[    0.000000] 	Build-time adjustment of leaf fanout to 32.

[    0.000000] 	RCU restricting CPUs from NR_CPUS=2 to nr_cpu_ids=1.

[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=1

[    0.000000] NR_IRQS:16 nr_irqs:16 16

[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 5.0) with 128 interrupts

[    0.000000] OMAP clockevent source: timer2 at 24000000 Hz

[    0.000016] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns

[    0.000041] clocksource: timer1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns

[    0.000092] OMAP clocksource: timer1 at 24000000 Hz

[    0.000621] clocksource_probe: no matching clocksources found

[    0.001559] Console: colour dummy device 80x30

[    0.001620] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar

[    0.001629] ... MAX_LOCKDEP_SUBCLASSES:  8

[    0.001637] ... MAX_LOCK_DEPTH:          48

[    0.001645] ... MAX_LOCKDEP_KEYS:        8191

[    0.001653] ... CLASSHASH_SIZE:          4096

[    0.001660] ... MAX_LOCKDEP_ENTRIES:     32768

[    0.001668] ... MAX_LOCKDEP_CHAINS:      65536

[    0.001675] ... CHAINHASH_SIZE:          32768

[    0.001683]  memory used by lock dependency info: 5167 kB

[    0.001691]  per task-struct memory footprint: 1536 bytes

[    0.001727] Calibrating delay loop... 996.14 BogoMIPS (lpj=4980736)

[    0.078650] pid_max: default: 32768 minimum: 301

[    0.079118] Security Framework initialized

[    0.079258] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)

[    0.079274] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)

[    0.082792] CPU: Testing write buffer coherency: ok

[    0.084542] CPU0: thread -1, cpu 0, socket -1, mpidr 0

[    0.084620] Setting up static identity map for 0x80100000 - 0x80100070

[    0.089260] Brought up 1 CPUs

[    0.089287] SMP: Total of 1 processors activated (996.14 BogoMIPS).

[    0.089298] CPU: All CPU(s) started in SVC mode.

[    0.093269] devtmpfs: initialized

[    0.136008] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3

[    0.136892] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns

[    0.138564] pinctrl core: initialized pinctrl subsystem

[    0.143964] NET: Registered protocol family 16

[    0.149479] DMA: preallocated 256 KiB pool for atomic coherent allocations

[    0.197359] omap_hwmod: debugss: _wait_target_disable failed

[    0.249785] cpuidle: using governor menu

[    0.263440] OMAP GPIO hardware version 0.1

[    0.289144] omap-gpmc 50000000.gpmc: could not find pctldev for node /ocp/l4_wkup@44c00000/scm@210000/pinmux@800/nandflash_pins_s0, deferring probe

[    0.295216] No ATAGs?hw-breakpoint: debug architecture 0x4 unsupported.

[    0.295478] omap4_sram_init:Unable to allocate sram needed to handle errata I688

[    0.295496] omap4_sram_init:Unable to get sram pool needed to handle errata I688

[    0.341776] edma 49000000.edma: TI EDMA DMA engine driver

[    0.348540] SCSI subsystem initialized

[    0.350424] omap_i2c 44e0b000.i2c: could not find pctldev for node /ocp/l4_wkup@44c00000/scm@210000/pinmux@800/pinmux_i2c0_pins, deferring probe

[    0.350540] omap_i2c 4802a000.i2c: could not find pctldev for node /ocp/l4_wkup@44c00000/scm@210000/pinmux@800/pinmux_i2c1_pins, deferring probe

[    0.350861] pps_core: LinuxPPS API ver. 1 registered

[    0.350873] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>

[    0.350924] PTP clock support registered

[    0.355501] clocksource: Switched to clocksource timer1

[    0.457992] VFS: Disk quotas dquot_6.6.0

[    0.458180] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)

[    0.489812] NET: Registered protocol family 2

[    0.491846] TCP established hash table entries: 8192 (order: 3, 32768 bytes)

[    0.492014] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)

[    0.494360] TCP: Hash tables configured (established 8192 bind 8192)

[    0.494644] UDP hash table entries: 512 (order: 3, 40960 bytes)

[    0.494967] UDP-Lite hash table entries: 512 (order: 3, 40960 bytes)

[    0.496118] NET: Registered protocol family 1

[    0.498237] RPC: Registered named UNIX socket transport module.

[    0.498261] RPC: Registered udp transport module.

[    0.498271] RPC: Registered tcp transport module.

[    0.498281] RPC: Registered tcp NFSv4.1 backchannel transport module.

[    0.501000] hw perfevents: /pmu: failed to probe PMU!

[    0.501021] hw perfevents: /pmu: failed to register PMU devices!

[    0.501094] armv7-pmu: probe of pmu failed with error -22

[    0.505862] futex hash table entries: 256 (order: 2, 16384 bytes)

[    0.506088] audit: initializing netlink subsys (disabled)

[    0.506382] audit: type=2000 audit(0.500:1): initialized

[    0.510083] workingset: timestamp_bits=14 max_order=18 bucket_order=4

[    0.512633] NFS: Registering the id_resolver key type

[    0.513007] Key type id_resolver registered

[    0.513022] Key type id_legacy registered

[    0.513180] jffs2: version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.

[    0.518959] bounce: pool size: 64 pages

[    0.519142] io scheduler noop registered

[    0.519159] io scheduler deadline registered

[    0.519286] io scheduler cfq registered (default)

[    0.521705] pinctrl-single 44e10800.pinmux: 142 pins at pa f9e10800 size 568

[    0.526311] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled

[    0.532413] omap_uart 44e09000.serial: no wakeirq for uart0

[    0.533104] 44e09000.serial: ttyO0 at MMIO 0x44e09000 (irq = 158, base_baud = 3000000) is a OMAP UART0

[    1.273865] console [ttyO0] enabled

[    1.279505] omap_uart 48022000.serial: no wakeirq for uart1

[    1.285851] 48022000.serial: ttyO1 at MMIO 0x48022000 (irq = 159, base_baud = 3000000) is a OMAP UART1

[    1.335992] brd: module loaded

[    1.363196] loop: module loaded

[    1.369344] mtdoops: mtd device (mtddev=name/number) must be supplied

[    1.379865] libphy: Fixed MDIO Bus: probed

[    1.455560] davinci_mdio 4a101000.mdio: davinci mdio revision 1.6

[    1.461968] davinci_mdio 4a101000.mdio: detected phy mask fffffffe

[    1.472662] libphy: 4a101000.mdio: probed

[    1.477069] davinci_mdio 4a101000.mdio: phy[0]: device 4a101000.mdio:00, driver Atheros 8031 ethernet

[    1.488315] cpsw 4a100000.ethernet: Detected MACID = c8:a0:30:a1:c2:d7

[    1.500466] mousedev: PS/2 mouse device common for all mice

[    1.506476] i2c /dev entries driver

[    1.512643] omap_hsmmc 48060000.mmc: Got CD GPIO

[    1.667359] ledtrig-cpu: registered to indicate activity on CPUs

[    1.675559] oprofile: no performance counters

[    1.681637] oprofile: using timer interrupt.

[    1.686844] Initializing XFRM netlink socket

[    1.691745] NET: Registered protocol family 10

[    1.703182] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver

[    1.711983] NET: Registered protocol family 17

[    1.716849] NET: Registered protocol family 15

[    1.721890] Key type dns_resolver registered

[    1.726658] omap_voltage_late_init: Voltage driver support not added

[    1.733340] sr_dev_init: No voltage domain specified for smartreflex0. Cannot initialize

[    1.741865] sr_dev_init: No voltage domain specified for smartreflex1. Cannot initialize

[    1.751110] ThumbEE CPU extension supported.

[    1.755705] Registering SWP/SWPB emulation handler

[    1.760730] SmartReflex Class3 initialized

[    1.766350] omap_hsmmc 47810000.mmc: card claims to support voltages below defined range

[    1.781084] omap-gpmc 50000000.gpmc: omap_device: omap_device_enable() called from invalid state 1

[    1.790664] omap-gpmc 50000000.gpmc: use pm_runtime_put_sync_suspend() in driver?

[    1.798600] omap-gpmc 50000000.gpmc: GPMC revision 6.0

[    1.804237] gpmc_mem_init: disabling cs 0 mapped at 0x0-0x1000000

[    1.815143] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xda

[    1.822006] nand: Micron MT29F2G08ABAEAWP

[    1.826258] nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64

[    1.834269] nand: using OMAP_ECC_BCH8_CODE_HW ECC scheme

[    1.840190] 10 ofpart partitions found on MTD device 8000000.nand

[    1.846625] Creating 10 MTD partitions on "8000000.nand":

[    1.852297] 0x000000000000-0x000000020000 : "NAND.SPL"

[    1.866523] 0x000000020000-0x000000040000 : "NAND.SPL.backup1"

[    1.877640] 0x000000040000-0x000000060000 : "NAND.SPL.backup2"

[    1.889008] 0x000000060000-0x000000080000 : "NAND.SPL.backup3"

[    1.899896] 0x000000080000-0x0000000c0000 : "NAND.u-boot-spl-os"

[    1.911195] 0x0000000c0000-0x0000001c0000 : "NAND.u-boot"

[    1.922772] 0x0000001c0000-0x0000001e0000 : "NAND.u-boot-env"

[    1.931541] random: fast init done

[    1.939123] mmc0: new high speed SDIO card at address 0001

[    1.951649] 0x0000001e0000-0x000000200000 : "NAND.u-boot-env.backup1"

[    1.964278] 0x000000200000-0x000000a00000 : "NAND.kernel"

[    1.977735] 0x000000a00000-0x000010000000 : "NAND.file-system"

[    2.116749] tps65910 0-002d: No interrupt support, no core IRQ

[    2.127194] vrtc: supplied by vbat

[    2.137203] vio: supplied by vbat

[    2.143874] vdd1: supplied by vbat

[    2.151158] vdd2: supplied by vbat

[    2.161306] vdig1: supplied by vbat

[    2.168117] vdig2: supplied by vbat

[    2.174824] vpll: supplied by vbat

[    2.181518] vdac: supplied by vbat

[    2.188161] vaux1: supplied by vbat

[    2.194810] vaux2: supplied by vbat

[    2.201600] vaux33: supplied by vbat

[    2.208401] vmmc: supplied by vbat

[    2.214963] vbb: supplied by vbat

[    2.221466] omap_i2c 44e0b000.i2c: bus 0 rev0.11 at 400 kHz

[    2.232003] omap_i2c 4802a000.i2c: bus 1 rev0.11 at 100 kHz

[    2.239314] omap_hsmmc 48060000.mmc: Got CD GPIO

[    2.308398] hctosys: unable to open rtc device (rtc0)

[    2.313712] sr_init: No PMIC hook to init smartreflex

[    2.319386] sr_init: platform driver register failed for SR

[    2.356324] net eth0: initializing cpsw version 1.12 (0)

[    2.456457] Atheros 8031 ethernet 4a101000.mdio:00: attached PHY driver [Atheros 8031 ethernet] (mii_bus:phy_addr=4a101000.mdio:00, irq=-1)

[    2.469824] libphy: PHY 4a101000.mdio:01 not found

[    2.474851] net eth0: phy "4a101000.mdio:01" not found on slave 1, err -19

[    2.490957] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready

[    2.506027] mmc1: host does not support reading read-only switch, assuming write-enable

[    2.517314] mmc1: new high speed SDHC card at address aaaa

[    2.526875] mmcblk1: mmc1:aaaa SU08G 7.40 GiB 

[    2.536324]  mmcblk1: p1 p2 p3

[    6.646506] cpsw 4a100000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx

[    6.665639] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

[    6.695503] Sending DHCP requests ., OK

[    6.775976] IP-Config: Got DHCP answer from 192.168.1.254, my address is 192.168.1.190

[    6.785086] IP-Config: Complete:

[    6.788610]      device=eth0, hwaddr=c8:a0:30:a1:c2:d7, ipaddr=192.168.1.190, mask=255.255.255.0, gw=192.168.1.254

[    6.799495]      host=192.168.1.190, domain=tidfarm-02.internal.ti.com, nis-domain=(none)

[    6.808089]      bootserver=192.168.1.254, rootserver=192.168.1.254, rootpath=     nameserver0=192.0.2.2, nameserver1=192.0.2.3

[    6.820343] lis3_reg: disabling

[    6.823644] wlan-en-regulator: disabling

[    6.865751] VFS: Mounted root (nfs filesystem) on device 0:14.

[    6.874456] devtmpfs: mounted

[    6.880291] Freeing unused kernel memory: 1024K (c0b00000 - c0c00000)

[    7.422838] systemd[1]: System time before build time, advancing clock.

[    7.630389] systemd[1]: systemd 229 running in system mode. (+PAM -AUDIT -SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP -LIBCRYPTSETUP -GCRYPT -GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID -ELFUTILS +KMOD -IDN)

[    7.651700] systemd[1]: Detected architecture arm.



Welcome to [1mArago 2016.07[0m!



[    7.690900] systemd[1]: Set hostname to <am335x-evm>.

[    8.914721] systemd[1]: Listening on Syslog Socket.

[[0;32m  OK  [0m] Listening on Syslog Socket.

[    8.946899] systemd[1]: Listening on Journal Socket.

[[0;32m  OK  [0m] Listening on Journal Socket.

[    8.977476] systemd[1]: Listening on Journal Audit Socket.

[[0;32m  OK  [0m] Listening on Journal Audit Socket.

[    9.016525] systemd[1]: Listening on Journal Socket (/dev/log).

[[0;32m  OK  [0m] Listening on Journal Socket (/dev/log).

[    9.056305] systemd[1]: Listening on udev Kernel Socket.

[[0;32m  OK  [0m] Listening on udev Kernel Socket.

[    9.093912] systemd[1]: Created slice System Slice.

[[0;32m  OK  [0m] Created slice System Slice.

[    9.137515] systemd[1]: Starting Create list of required static device nodes for the current kernel...

         Starting Create list of required st... nodes for the current kernel...

         Mounting POSIX Message Queue File System...

         Mounting Debug File System...

         Starting Remount Root and Kernel File Systems...

[[0;32m  OK  [0m] Created slice system-getty.slice.

[[0;32m  OK  [0m] Created slice system-serial\x2dgetty.slice.

[[0;32m  OK  [0m] Reached target Swap.

[[0;32m  OK  [0m] Created slice User and Session Slice.

[[0;32m  OK  [0m] Reached target Slices.

[[0;32m  OK  [0m] Listening on Network Service Netlink Socket.

         Starting Journal Service...

         Starting Load Kernel Modules...

[[0;32m  OK  [0m] Listening on /dev/initctl Compatibility Named Pipe.

         Mounting Temporary Directory...

[[0;32m  OK  [0m] Started Dispatch Password Requests to Console Directory Watch.

         Starting Setup Virtual Console...

[[0;32m  OK  [0m] Reached target Remote File Systems.

[[0;32m  OK  [0m] Started Forward Password Requests to Wall Directory Watch.

[[0;32m  OK  [0m] Reached target Paths.

[[0;32m  OK  [0m] Listening on udev Control Socket.

[[0;32m  OK  [0m] Mounted Debug File System.

[[0;32m  OK  [0m] Mounted POSIX Message Queue File System.

[[0;32m  OK  [0m] Mounted Temporary Directory.

[[0;32m  OK  [0m] Started Create list of required sta...ce nodes for the current kernel.

[[0;32m  OK  [0m] Started Remount Root and Kernel File Systems.

[[0;1;31mFAILED[0m] Failed to start Load Kernel Modules.

See 'systemctl status systemd-modules-load.service' for details.

[[0;32m  OK  [0m] Started Setup Virtual Console.

[[0;32m  OK  [0m] Started Journal Service.

         Mounting Configuration File System...

         Starting Apply Kernel Variables...

         Starting udev Coldplug all Devices...

         Starting Flush Journal to Persistent Storage...

         Starting Create Static Device Nodes in /dev...

[[0;32m  OK  [0m] Mounted Configuration File System.

[[0;32m  OK  [0m] Started Apply Kernel Variables.

[   11.327502] systemd-journald[104]: Received request to flush runtime journal from PID 1

[[0;32m  OK  [0m] Started Flush Journal to Persistent Storage.

[[0;32m  OK  [0m] Started Create Static Device Nodes in /dev.

         Starting udev Kernel Device Manager...

[[0;32m  OK  [0m] Reached target Local File Systems (Pre).

         Mounting /var/volatile...

         Mounting /media/ram...

[[0;32m  OK  [0m] Mounted /var/volatile.

[[0;32m  OK  [0m] Mounted /media/ram.

[[0;32m  OK  [0m] Reached target Local File Systems.

         Starting Create Volatile Files and Directories...

         Starting Load/Save Random Seed...

[[0;32m  OK  [0m] Started udev Kernel Device Manager.

[[0;32m  OK  [0m] Started Load/Save Random Seed.

[[0;32m  OK  [0m] Started Create Volatile Files and Directories.

         Starting Network Time Synchronization...

         Starting Update UTMP about System Boot/Shutdown...

[   13.927661] random: crng init done

[[0;32m  OK  [0m] Started Update UTMP about System Boot/Shutdown.

[[0;32m  OK  [0m] Started Network Time Synchronization.

[[0;32m  OK  [0m] Reached target System Time Synchronized.

         Starting Synchronize System and HW clocks...

[[0;1;31mFAILED[0m] Failed to start Synchronize System and HW clocks.

See 'systemctl status sync-clocks.service' for details.

[   15.018147] backlight supply power not found, using dummy regulator

[   15.183618] input: matrix_keypad@0 as /devices/platform/matrix_keypad@0/input/input0

[   15.196236] backlight supply power not found, using dummy regulator

[   15.580512] backlight supply power not found, using dummy regulator

[   15.752864] omap_wdt: OMAP Watchdog Timer Rev 0x01: initial timeout 60 sec

[   15.761943] backlight supply power not found, using dummy regulator

[   15.776190] Unhandled fault: external abort on non-linefetch (0x1028) at 0xf9e3e044

[   15.784193] pgd = eeee8000

[   15.787010] [f9e3e044] *pgd=44e11452(bad)

[   15.791212] Internal error: : 1028 [#1] SMP ARM

[   15.795934] Modules linked in: rtc_omap(+) omap_wdt ti_am335x_tscadc matrix_keypad matrix_keymap pwm_bl autofs4

[   15.806508] CPU: 0 PID: 150 Comm: systemd-udevd Not tainted 4.8.0-rc1-12423-g29b4817 #1

[   15.814843] Hardware name: Generic AM33XX (Flattened Device Tree)

[   15.821188] task: eeec0440 task.stack: eeff4000

[   15.825925] PC is at omap_hwmod_read+0x14/0x28

[   15.830583] LR is at omap_rtc_wait_not_busy+0x1c/0x44

[   15.835874] pc : [<c01218b4>]    lr : [<c0123174>]    psr: 400f0093

[   15.835874] sp : eeff5c30  ip : 00000000  fp : c01857a4

[   15.847898] r10: 00000000  r9 : eeff4000  r8 : 00000004

[   15.853369] r7 : c0c228fc  r6 : c0c81de8  r5 : c0c22074  r4 : 00000032

[   15.860204] r3 : f9e3e000  r2 : eeec0440  r1 : f9e3e044  r0 : c0c22074

[   15.867042] Flags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none

[   15.874606] Control: 10c5387d  Table: aeee8019  DAC: 00000051

[   15.880623] Process systemd-udevd (pid: 150, stack limit = 0xeeff4218)

[   15.887459] Stack: (0xeeff5c30 to 0xeeff6000)

[   15.892025] 5c20:                                     c0c22074 00000003 c0c14cbc c01231e8

[   15.900593] 5c40: c0c22074 c0120ec8 c0c22074 00000020 c0c14cbc c012107c eeff4000 00000000

[   15.909162] 5c60: a00f0093 00000003 c0c22074 00000000 c0cc38b4 c0121300 00000001 00000000

[   15.917731] 5c80: c01219fc c0c22074 c0c220d4 a00f0013 c0c02100 c0121a08 00000000 00000000

[   15.926300] 5ca0: ee988dc0 c0122a40 ee986410 ee9864a0 c0122a94 c0122aa4 ee986410 ee9864a0

[   15.934869] 5cc0: c0122a94 c05371b8 ee986410 c0122a94 ee95bc10 c053720c ee986410 c0122a94

[   15.943438] 5ce0: ee95bc10 c05388e0 ee9864fc c0c029cc ee9864a0 600f0013 c0538c84 fffffffe

[   15.952007] 5d00: 00000000 0000000c 127b71a8 ee986410 ee9864a0 00000004 600f0013 00000000

[   15.960576] 5d20: 0000000c 127b71a8 bf026448 c0538c94 ed848a90 ee986410 ee986400 fffffffe

[   15.969144] 5d40: 00000000 bf025a94 bf0263b0 ee986410 ee986410 bf0263b0 ee986410 ee986410

[   15.977713] 5d60: bf0263b0 fffffdfb 00000000 c052fe7c ee986410 c1495fd4 c1495fdc bf0263b0

[   15.986281] 5d80: 00000000 c052e03c ee986410 bf0263b0 ee986444 c0c8d3e8 00000000 00000001

[   15.994850] 5da0: 127b71a8 c052e1a8 00000000 bf0263b0 c052e0f4 c052c384 ee83fea4 ee989fd0

[   16.003419] 5dc0: bf0263b0 ed870100 00000000 c052d628 bf026334 bf028000 eee77a80 bf0263b0

[   16.011988] 5de0: bf028000 eee77a80 bf026400 c052ef20 bf026400 bf028000 eee77a80 c010186c

[   16.020558] 5e00: 00000000 600f0013 ee800080 024000c0 00000040 c018f260 c0c81ee0 c0cbdc98

[   16.029127] 5e20: ee800080 c01a93b0 eee77a80 c0281ce8 eee77a80 c0191fe4 c0cbdc98 c0c029cc

[   16.037696] 5e40: c01d2bac bf026400 c0c029cc c0cbeaf0 bf026400 c0c029cc eee77a80 bf026400

[   16.046265] 5e60: ed848e80 c022f21c c0c81ee0 c0c029cc c0cbdb1a c0c029cc c0cbeaf0 c01d2bf8

[   16.054835] 5e80: bf02640c 00007fff bf026400 c01d00cc 00000000 c14731a4 bf026554 bf026644

[   16.063404] 5ea0: bf02661c f0c50cf8 bf02640c 00000000 00000000 eeff5f3c ee61729c c029bfb0

[   16.071973] 5ec0: 00000003 00000000 00000000 00000000 00000000 00000000 00000000 00000000

[   16.080542] 5ee0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000

[   16.089111] 5f00: 7fffffff 00000000 00000007 b6d88d90 0000017b 7fffffff 00000000 00000020

[   16.097680] 5f20: 7f60d420 c01d31e8 7fffffff 00000000 00000003 00000000 c01f1008 f0c49000

[   16.106250] 5f40: 0000a7d5 00000000 00000001 f0c49000 0000a7d5 f0c50550 f0c50358 f0c531a8

[   16.114818] 5f60: 00001644 000019b4 00000000 00000000 00000000 00000f64 00000031 00000032

[   16.123387] 5f80: 00000017 00000014 00000012 00000000 00000000 7f5f6928 00000000 c0107a04

[   16.131956] 5fa0: eeff4000 c01079c8 00000000 7f5f6928 00000007 b6d88d90 00000000 00000000

[   16.140525] 5fc0: 00000000 7f5f6928 00000000 0000017b 7f60de30 00000000 7f60de30 7f60d420

[   16.149094] 5fe0: bec139d8 bec139c8 b6d81c08 b6e84df2 80070030 00000007 00000046 00000000

[   16.157668] [<c01218b4>] (omap_hwmod_read) from [<c0123174>] (omap_rtc_wait_not_busy+0x1c/0x44)

[   16.166785] [<c0123174>] (omap_rtc_wait_not_busy) from [<c01231e8>] (omap_hwmod_rtc_unlock+0x18/0x4c)

[   16.176446] [<c01231e8>] (omap_hwmod_rtc_unlock) from [<c0120ec8>] (_write_sysconfig+0x34/0xa4)

[   16.185561] [<c0120ec8>] (_write_sysconfig) from [<c012107c>] (_enable_sysc+0x144/0x238)

[   16.194038] [<c012107c>] (_enable_sysc) from [<c0121300>] (_enable+0x190/0x2c0)

[   16.201697] [<c0121300>] (_enable) from [<c0121a08>] (omap_hwmod_enable+0x28/0x48)

[   16.209629] [<c0121a08>] (omap_hwmod_enable) from [<c0122a40>] (omap_device_enable+0x3c/0x90)

[   16.218562] [<c0122a40>] (omap_device_enable) from [<c0122aa4>] (_od_runtime_resume+0x10/0x38)

[   16.227599] [<c0122aa4>] (_od_runtime_resume) from [<c05371b8>] (__rpm_callback+0x2c/0x60)

[   16.236260] [<c05371b8>] (__rpm_callback) from [<c053720c>] (rpm_callback+0x20/0x80)

[   16.244376] [<c053720c>] (rpm_callback) from [<c05388e0>] (rpm_resume+0x4d0/0x838)

[   16.252310] [<c05388e0>] (rpm_resume) from [<c0538c94>] (__pm_runtime_resume+0x4c/0x64)

[   16.260719] [<c0538c94>] (__pm_runtime_resume) from [<bf025a94>] (omap_rtc_probe+0xf8/0x440 [rtc_omap])

[   16.270578] [<bf025a94>] (omap_rtc_probe [rtc_omap]) from [<c052fe7c>] (platform_drv_probe+0x4c/0xb0)

[   16.280242] [<c052fe7c>] (platform_drv_probe) from [<c052e03c>] (driver_probe_device+0x208/0x2c0)

[   16.289540] [<c052e03c>] (driver_probe_device) from [<c052e1a8>] (__driver_attach+0xb4/0xb8)

[   16.298383] [<c052e1a8>] (__driver_attach) from [<c052c384>] (bus_for_each_dev+0x6c/0xa0)

[   16.306951] [<c052c384>] (bus_for_each_dev) from [<c052d628>] (bus_add_driver+0x18c/0x214)

[   16.315611] [<c052d628>] (bus_add_driver) from [<c052ef20>] (driver_register+0x78/0xf8)

[   16.324000] [<c052ef20>] (driver_register) from [<c010186c>] (do_one_initcall+0x3c/0x178)

[   16.332581] [<c010186c>] (do_one_initcall) from [<c022f21c>] (do_init_module+0x5c/0x1d0)

[   16.341070] [<c022f21c>] (do_init_module) from [<c01d2bf8>] (load_module+0x1d78/0x218c)

[   16.349459] [<c01d2bf8>] (load_module) from [<c01d31e8>] (SyS_finit_module+0x8c/0x9c)

[   16.357671] [<c01d31e8>] (SyS_finit_module) from [<c01079c8>] (__sys_trace_return+0x0/0x10)

[   16.366424] Code: e3130c01 e590305c e0831001 1a000001 (e5910000) 

[   16.372815] ---[ end trace f46c51ec097c071c ]---

[[0;32m  OK  [0m] Started udev Coldplug all Devices.

[[0;32m  OK  [0m] Reached target System Initialization.

[[0;32m  OK  [0m] Listening on RPCbind Server Activation Socket.

[[0;32m  OK  [0m] Started Daily Cleanup of Temporary Directories.

[[0;32m  OK  [0m] Reached target Timers.

[[0;32m  OK  [0m] Listening on D-Bus System Message Bus Socket.

[[0;32m  OK  [0m] Listening on dropbear.socket.

[[0;32m  OK  [0m] Reached target Sockets.

[[0;32m  OK  [0m] Reached target Basic System.

         Starting uim-sysfs.service...

[[0;32m  OK  [0m] Started strongSwan IPsec IKEv1/IKEv2 daemon using ipsec.conf.

         Starting Permit User Sessions...

[   17.522466] tsl2550 1-0039: standard operating mode

[[0;32m  OK  [0m] Started System Logging Service.

[   17.577369] tsl2550 1-0039: support ver. 1.2 enabled

[   17.583362] pwm-backlight backlight: GPIO lookup for consumer enable

[   17.590239] pwm-backlight backlight: using device tree for GPIO lookup

[   17.597154] of_get_named_gpiod_flags: can't parse 'enable-gpios' property of node '/backlight[0]'

[   17.606489] of_get_named_gpiod_flags: can't parse 'enable-gpio' property of node '/backlight[0]'

[   17.615724] pwm-backlight backlight: using lookup tables for GPIO lookup

[   17.622749] pwm-backlight backlight: lookup for GPIO enable failed

[   17.629312] backlight supply power not found, using dummy regulator

         Starting Login Service...

[   17.696528] lis3lv02d: 16 bits lis331dlh sensor found

         Starting Print notice about GPLv3 packages...

[   17.866178] input: ST LIS3LV02DL Accelerometer as /devices/platform/lis3lv02d/input/input1

[[0;32m  OK  [0m] Started Kernel Logging Service.

[[0;32m  OK  [0m] Started D-Bus System Message Bus.

[   18.180397] lm75 1-0048: hwmon0: sensor 'tmp275'

[   18.414038] pwm-backlight backlight: GPIO lookup for consumer enable

[   18.420944] pwm-backlight backlight: using device tree for GPIO lookup

[   18.427876] of_get_named_gpiod_flags: can't parse 'enable-gpios' property of node '/backlight[0]'

[   18.437213] of_get_named_gpiod_flags: can't parse 'enable-gpio' property of node '/backlight[0]'

[   18.446448] pwm-backlight backlight: using lookup tables for GPIO lookup

[   18.453472] pwm-backlight backlight: lookup for GPIO enable failed

[   18.460029] backlight supply power not found, using dummy regulator

[   18.598060] of_get_named_gpiod_flags: can't parse 'gpio-reset' property of node '/ocp/i2c@4802a000/tlv320aic3106@1b[0]'

[   19.338562] pwm-backlight backlight: GPIO lookup for consumer enable

[   19.345251] pwm-backlight backlight: using device tree for GPIO lookup

[   19.352310] of_get_named_gpiod_flags: can't parse 'enable-gpios' property of node '/backlight[0]'

[   19.361668] of_get_named_gpiod_flags: can't parse 'enable-gpio' property of node '/backlight[0]'

[   19.370909] pwm-backlight backlight: using lookup tables for GPIO lookup

[   19.377962] pwm-backlight backlight: lookup for GPIO enable failed

[   19.384492] backlight supply power not found, using dummy regulator

         Starting Network Service...

[[0;32m  OK  [0m] Started Permit User Sessions.

[[0;32m  OK  [0m] Found device /dev/ttyO0.

[[0;32m  OK  [0m] Started Network Service.

[[0;32m  OK  [0m] Started Login Service.

[[0;32m  OK  [0m] Reached target Network.

         Starting Lightning Fast Webserver With Light System Requirements...

         Starting Network Name Resolution...

[[0;32m  OK  [0m] Started Serial Getty on ttyO0.

[[0;32m  OK  [0m] Started Getty on tty1.

[   24.541597] EXT4-fs (mmcblk1p3): mounting ext3 file system using the ext4 subsystem

[   24.592030] EXT4-fs (mmcblk1p2): mounting ext3 file system using the ext4 subsystem

[   24.756085] EXT4-fs (mmcblk1p3): warning: maximal mount count reached, running e2fsck is recommended

[   24.804418] EXT4-fs (mmcblk1p2): warning: maximal mount count reached, running e2fsck is recommended

[   24.898378] EXT4-fs (mmcblk1p3): mounted filesystem with ordered data mode. Opts: (null)

[   24.919997] FAT-fs (mmcblk1p1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.

[   24.975151] EXT4-fs (mmcblk1p2): mounted filesystem with ordered data mode. Opts: (null)

[[0;32m  OK  [0m] Started Network Name Resolution.

[[0;32m  OK  [0m] Started Lightning Fast Webserver With Light System Requirements.

[   28.678980] simple_card_utils: module license 'unspecified' taints kernel.

[   28.765372] simple_card_utils: Unknown symbol snd_soc_of_parse_daifmt (err 0)

[   28.773101] simple_card_utils: Unknown symbol snd_soc_of_parse_card_name (err 0)

[   28.857924] of_get_named_gpiod_flags: parsed 'gpios' property of node '/volume_keys@0/switch@9[0]' - status (0)

[   28.868777] of_get_named_gpiod_flags: parsed 'gpios' property of node '/volume_keys@0/switch@10[0]' - status (0)

[   28.880244] input: volume_keys@0 as /devices/platform/volume_keys@0/input/input2

[   29.179414] simple_card_utils: Unknown symbol snd_soc_of_parse_daifmt (err 0)

[   29.187163] simple_card_utils: Unknown symbol snd_soc_of_parse_card_name (err 0)

[   29.995903] Unable to handle kernel paging request at virtual address 00002244

[   30.003503] pgd = c0004000

[   30.006434] [00002244] *pgd=00000000

[   30.010198] Internal error: Oops: 17 [#2] SMP ARM

[   30.015129] Modules linked in: gpio_keys evdev pwm_tiecap omap_rng(+) rng_core snd_soc_davinci_mcasp(+) snd_soc_tlv320aic3x snd_soc_omap snd_soc_edma snd_soc_core lm75 thermal_sys wlcore_sdio lis3lv02d_i2c hwmon snd_pcm_dmaengine tsl2550 lis3lv02d snd_pcm input_polldev snd_timer snd soundcore musb_am335x(+) rtc_omap(+) omap_wdt ti_am335x_tscadc matrix_keypad matrix_keymap pwm_bl autofs4

[   30.051221] CPU: 0 PID: 169 Comm: kworker/u2:2 Tainted: P      D         4.8.0-rc1-12423-g29b4817 #1

[   30.060787] Hardware name: Generic AM33XX (Flattened Device Tree)

[   30.067193] Workqueue: events_unbound flush_to_ldisc

[   30.072399] task: ed8d6e40 task.stack: eef3c000

[   30.077147] PC is at n_tty_receive_buf_common+0x48/0x9c8

[   30.082712] LR is at 0x0

[   30.085364] pc : [<c04fc0e8>]    lr : [<00000000>]    psr: 80070013

[   30.085364] sp : eef3de28  ip : eef3c000  fp : edd89800

[   30.097387] r10: c0cbe780  r9 : c0c029cc  r8 : ee814c24

[   30.102857] r7 : eda11440  r6 : ee814c00  r5 : ee814c04  r4 : 00000000

[   30.109692] r3 : 00002000  r2 : 00000000  r1 : 00000000  r0 : 00000000

[   30.116529] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none

[   30.124001] Control: 10c5387d  Table: adc18019  DAC: 00000051

[   30.130018] Process kworker/u2:2 (pid: 169, stack limit = 0xeef3c218)

[   30.136764] Stack: (0xeef3de28 to 0xeef3e000)

[   30.141330] de20:                   edc9814f 00000028 edc9804f 00000000 00000000 00002000

[   30.149900] de40: 00000001 00000000 edd89ac4 ee836c00 ee838f00 edd89930 c0c029cc edc98000

[   30.158469] de60: ee814c04 ee814c00 eda11440 ee814c24 c0c029cc c0cbe780 00000001 c04fca7c

[   30.167038] de80: 00000001 ee814c04 ee814c00 c04ff2fc ed88ef80 ee814c04 ee836c00 ee838f00

[   30.175607] dea0: eef3dec8 c0154624 00000001 00000000 c015456c 00000006 00000000 00000000

[   30.184176] dec0: c0154bac 00000088 c1491624 00000000 00000000 c09dbf84 ed88ef80 ee836c00

[   30.192745] dee0: ed88ef98 00000088 ee836c34 eef3c000 c0c02100 ee836c00 ed88ef80 c0154b38

[   30.201314] df00: eeb5f200 ed88ef80 c0154b00 00000000 eeb5f200 ed88ef80 c0154b00 00000000

[   30.209883] df20: 00000000 00000000 00000000 c015ab80 c0c029cc 00000000 00000000 ed88ef80

[   30.218452] df40: 00000000 00000000 dead4ead ffffffff ffffffff c0cc4e74 00000000 00000000

[   30.227020] df60: c099e5dc eef3df64 eef3df64 00000000 00000000 dead4ead ffffffff ffffffff

[   30.235590] df80: c0cc4e74 00000000 00000000 c099e5dc eef3df90 eef3df90 eeb5f200 eeb5f200

[   30.244158] dfa0: c015aaac 00000000 00000000 c01078f0 00000000 00000000 00000000 00000000

[   30.252726] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000

[   30.261293] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000

[   30.269873] [<c04fc0e8>] (n_tty_receive_buf_common) from [<c04fca7c>] (n_tty_receive_buf2+0x14/0x1c)

[   30.279443] [<c04fca7c>] (n_tty_receive_buf2) from [<c04ff2fc>] (flush_to_ldisc+0xc4/0xdc)

[   30.288117] [<c04ff2fc>] (flush_to_ldisc) from [<c0154624>] (process_one_work+0x1e0/0x6bc)

[   30.296781] [<c0154624>] (process_one_work) from [<c0154b38>] (worker_thread+0x38/0x4d0)

[   30.305266] [<c0154b38>] (worker_thread) from [<c015ab80>] (kthread+0xd4/0xf0)

[   30.312844] [<c015ab80>] (kthread) from [<c01078f0>] (ret_from_fork+0x14/0x24)

[   30.320415] Code: e58d3014 e28b3fb1 e58d3020 e59d3014 (e5931244) 

[   30.327113] ---[ end trace f46c51ec097c071d ]---

[   30.332113] Unable to handle kernel paging request at virtual address ffffffd0

[   30.339683] pgd = c0004000

[   30.342515] [ffffffd0] *pgd=afffd861, *pte=00000000, *ppte=00000000

[   30.349105] Internal error: Oops: 37 [#3] SMP ARM

[   30.354031] Modules linked in: gpio_keys evdev pwm_tiecap omap_rng(+) rng_core snd_soc_davinci_mcasp(+) snd_soc_tlv320aic3x snd_soc_omap snd_soc_edma snd_soc_core lm75 thermal_sys wlcore_sdio lis3lv02d_i2c hwmon snd_pcm_dmaengine tsl2550 lis3lv02d snd_pcm input_polldev snd_timer snd soundcore musb_am335x(+) rtc_omap(+) omap_wdt ti_am335x_tscadc matrix_keypad matrix_keymap pwm_bl autofs4

[   30.390111] CPU: 0 PID: 169 Comm: kworker/u2:2 Tainted: P      D         4.8.0-rc1-12423-g29b4817 #1

[   30.399676] Hardware name: Generic AM33XX (Flattened Device Tree)

[   30.406066] task: ed8d6e40 task.stack: eef3c000

[   30.410817] PC is at kthread_data+0x4/0xc

[   30.415023] LR is at wq_worker_sleeping+0x8/0xcc

[   30.419858] pc : [<c015b46c>]    lr : [<c015592c>]    psr: 20070193

[   30.419858] sp : eef3dbb8  ip : edb3f014  fp : eef3dc1c

[   30.431882] r10: ed8d7270  r9 : ef6be000  r8 : ed8d727c

[   30.437352] r7 : 00000000  r6 : c0b77000  r5 : ed8d6e40  r4 : ef6be000

[   30.444188] r3 : 00000000  r2 : 00000000  r1 : ed8d6e40  r0 : ed8d6e40

[   30.451024] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none

[   30.458589] Control: 10c5387d  Table: adc18019  DAC: 00000051

[   30.464606] Process kworker/u2:2 (pid: 169, stack limit = 0xeef3c218)

[   30.471350] Stack: (0xeef3dbb8 to 0xeef3e000)

[   30.475913] dba0:                                                       ef6be000 c07b7f40

[   30.484482] dbc0: 00000000 ed866600 ed8d6e40 ed87f508 c0c02000 c07bd7b4 ed8d6e40 c07b85d4

[   30.493051] dbe0: 00000001 00000000 00000000 c0c02000 c013c840 ef6be010 ed866b04 eef3c000

[   30.501620] dc00: eef3d884 ee89ad80 00000001 eef3dc38 ed8d71d8 00000001 eef3dc2c c07b85d4

[   30.510189] dc20: ed8d6e40 eef3d884 c04fc0ea c013cbe0 00000000 ed8d7370 eef3dc38 eef3dc38

[   30.518758] dc40: 00000001 c0cc3244 eef3ddd8 c0c08254 60070113 0000000b 00000000 00000001

[   30.527327] dc60: c04fc0ea c010c6d0 eef3c218 0000000b c04fc0ec eef3c000 bf000000 00000008

[   30.535897] dc80: 65000000 33643835 20343130 62383265 31626633 38356520 32303364 35652030

[   30.544467] dca0: 30336439 28203431 33393565 34343231 c0002029 eef3dcd4 c0992cac 00002244

[   30.553035] dcc0: eef3ddd8 00000017 00000000 00000000 eef3c000 c0cbe780 edd89800 c011d504

[   30.561604] dce0: 00002244 c07be604 00000001 0001aa6e 00000000 ed8d6e40 c0cbe8ac c018ca10

[   30.570173] dd00: 60010193 00000000 c018c9f0 ed8d6ec0 ef6be060 c0c09224 00000017 c07be418

[   30.578743] dd20: 00002244 eef3ddd8 eef3c000 c0cbe780 edd89800 c0101358 c0176e40 c0c029cc

[   30.587311] dd40: 63ba9b7d 00000001 00000000 c0cbe7d0 800f0193 ef6be060 00000001 00000001

[   30.595880] dd60: 2828a1a9 00000001 02e4d374 00000000 ef6be060 ed8d6ec0 800f0193 ef6be010

[   30.604449] dd80: 800f0193 c0c02810 0000006a 00000000 ee94a248 ee94a240 ee94a1c0 edd89964

[   30.613018] dda0: 00000000 00000000 00000001 00000000 00000001 60070013 c0cbe99c c0193ebc

[   30.621586] ddc0: c04fc0e8 80070013 ffffffff eef3de0c ee814c24 c07bda44 00000000 00000000

[   30.630155] dde0: 00000000 00002000 00000000 ee814c04 ee814c00 eda11440 ee814c24 c0c029cc

[   30.638724] de00: c0cbe780 edd89800 eef3c000 eef3de28 00000000 c04fc0e8 80070013 ffffffff

[   30.647293] de20: 00000051 00000000 edc9814f 00000028 edc9804f 00000000 00000000 00002000

[   30.655862] de40: 00000001 00000000 edd89ac4 ee836c00 ee838f00 edd89930 c0c029cc edc98000

[   30.664431] de60: ee814c04 ee814c00 eda11440 ee814c24 c0c029cc c0cbe780 00000001 c04fca7c

[   30.673000] de80: 00000001 ee814c04 ee814c00 c04ff2fc ed88ef80 ee814c04 ee836c00 ee838f00

[   30.681569] dea0: eef3dec8 c0154624 00000001 00000000 c015456c 00000006 00000000 00000000

[   30.690138] dec0: c0154bac 00000088 c1491624 00000000 00000000 c09dbf84 ed88ef80 ee836c00

[   30.698707] dee0: ed88ef98 00000088 ee836c34 eef3c000 c0c02100 ee836c00 ed88ef80 c0154b38

[   30.707276] df00: eeb5f200 ed88ef80 c0154b00 00000000 eeb5f200 ed88ef80 c0154b00 00000000

[   30.715846] df20: 00000000 00000000 00000000 c015ab80 c0c029cc 00000000 00000000 ed88ef80

[   30.724415] df40: 00000000 00000000 dead4ead ffffffff ffffffff c0cc4e74 00000000 00000000

[   30.732985] df60: c099e5dc eef3df64 eef3df64 00000001 00010001 dead4ead ffffffff ffffffff

[   30.741554] df80: c0cc4e74 00000000 00000000 c099e5dc eef3df90 eef3df90 eeb5f200 eeb5f200

[   30.750123] dfa0: c015aaac 00000000 00000000 c01078f0 00000000 00000000 00000000 00000000

[   30.758692] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000

[   30.767261] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000

[   30.775838] [<c015b46c>] (kthread_data) from [<c015592c>] (wq_worker_sleeping+0x8/0xcc)

[   30.784234] [<c015592c>] (wq_worker_sleeping) from [<c07b7f40>] (__schedule+0x6ac/0xcfc)

[   30.792715] [<c07b7f40>] (__schedule) from [<c07b85d4>] (schedule+0x44/0x9c)

[   30.800105] [<c07b85d4>] (schedule) from [<c013cbe0>] (do_exit+0x778/0xbfc)

[   30.807403] [<c013cbe0>] (do_exit) from [<c010c6d0>] (die+0x43c/0x48c)

[   30.814247] [<c010c6d0>] (die) from [<c011d504>] (__do_kernel_fault.part.0+0x54/0x1e4)

[   30.822553] [<c011d504>] (__do_kernel_fault.part.0) from [<c07be604>] (do_page_fault+0x1ec/0x3f8)

[   30.831852] [<c07be604>] (do_page_fault) from [<c0101358>] (do_DataAbort+0x34/0xb4)

[   30.839877] [<c0101358>] (do_DataAbort) from [<c07bda44>] (__dabt_svc+0x64/0xa0)

[   30.847622] Exception stack(0xeef3ddd8 to 0xeef3de20)

[   30.852912] ddc0:                                                       00000000 00000000

[   30.861481] dde0: 00000000 00002000 00000000 ee814c04 ee814c00 eda11440 ee814c24 c0c029cc

[   30.870051] de00: c0cbe780 edd89800 eef3c000 eef3de28 00000000 c04fc0e8 80070013 ffffffff

[   30.878625] [<c07bda44>] (__dabt_svc) from [<c04fc0e8>] (n_tty_receive_buf_common+0x48/0x9c8)

[   30.887560] [<c04fc0e8>] (n_tty_receive_buf_common) from [<c04fca7c>] (n_tty_receive_buf2+0x14/0x1c)

[   30.897131] [<c04fca7c>] (n_tty_receive_buf2) from [<c04ff2fc>] (flush_to_ldisc+0xc4/0xdc)

[   30.905794] [<c04ff2fc>] (flush_to_ldisc) from [<c0154624>] (process_one_work+0x1e0/0x6bc)

[   30.914455] [<c0154624>] (process_one_work) from [<c0154b38>] (worker_thread+0x38/0x4d0)

[   30.922934] [<c0154b38>] (worker_thread) from [<c015ab80>] (kthread+0xd4/0xf0)

[   30.930505] [<c015ab80>] (kthread) from [<c01078f0>] (ret_from_fork+0x14/0x24)

[   30.938074] Code: e3a02002 eafffe43 c0804dec e59033f0 (e5130030) 

[   30.944461] ---[ end trace f46c51ec097c071e ]---

[   30.949297] Fixing recursive fault but reboot is needed!

[   43.904777] BUG: spinlock lockup suspected on CPU#0, kworker/u2:2/169

[   43.911524]  lock: 0xef6be000, .magic: dead4ead, .owner: kworker/u2:2/169, .owner_cpu: 0

[   43.920000] CPU: 0 PID: 169 Comm: kworker/u2:2 Tainted: P      D         4.8.0-rc1-12423-g29b4817 #1

[   43.929563] Hardware name: Generic AM33XX (Flattened Device Tree)

[   43.935964] [<c01100e4>] (unwind_backtrace) from [<c010c290>] (show_stack+0x10/0x14)

[   43.944081] [<c010c290>] (show_stack) from [<c0486500>] (dump_stack+0xb0/0xe4)

[   43.951651] [<c0486500>] (dump_stack) from [<c0197008>] (do_raw_spin_lock+0xe8/0x1b8)

[   43.959856] [<c0197008>] (do_raw_spin_lock) from [<c07b7998>] (__schedule+0x104/0xcfc)

[   43.968150] [<c07b7998>] (__schedule) from [<c07b85d4>] (schedule+0x44/0x9c)

[   43.975534] [<c07b85d4>] (schedule) from [<c013cd9c>] (do_exit+0x934/0xbfc)

[   43.982827] [<c013cd9c>] (do_exit) from [<c010c6d0>] (die+0x43c/0x48c)

[   43.989666] [<c010c6d0>] (die) from [<c011d504>] (__do_kernel_fault.part.0+0x54/0x1e4)

[   43.997962] [<c011d504>] (__do_kernel_fault.part.0) from [<c07be604>] (do_page_fault+0x1ec/0x3f8)

[   44.007258] [<c07be604>] (do_page_fault) from [<c0101358>] (do_DataAbort+0x34/0xb4)

[   44.015280] [<c0101358>] (do_DataAbort) from [<c07bda44>] (__dabt_svc+0x64/0xa0)

[   44.023023] Exception stack(0xeef3db68 to 0xeef3dbb0)

[   44.028315] db60:                   ed8d6e40 ed8d6e40 00000000 00000000 ef6be000 ed8d6e40

[   44.036883] db80: c0b77000 00000000 ed8d727c ef6be000 ed8d7270 eef3dc1c edb3f014 eef3dbb8

[   44.045448] dba0: c015592c c015b46c 20070193 ffffffff

[   44.050742] [<c07bda44>] (__dabt_svc) from [<c015b46c>] (kthread_data+0x4/0xc)

[   44.058311] [<c015b46c>] (kthread_data) from [<c015592c>] (wq_worker_sleeping+0x8/0xcc)

[   44.066697] [<c015592c>] (wq_worker_sleeping) from [<c07b7f40>] (__schedule+0x6ac/0xcfc)

[   44.075172] [<c07b7f40>] (__schedule) from [<c07b85d4>] (schedule+0x44/0x9c)

[   44.082557] [<c07b85d4>] (schedule) from [<c013cbe0>] (do_exit+0x778/0xbfc)

[   44.089849] [<c013cbe0>] (do_exit) from [<c010c6d0>] (die+0x43c/0x48c)

[   44.096687] [<c010c6d0>] (die) from [<c011d504>] (__do_kernel_fault.part.0+0x54/0x1e4)

[   44.104982] [<c011d504>] (__do_kernel_fault.part.0) from [<c07be604>] (do_page_fault+0x1ec/0x3f8)

[   44.114276] [<c07be604>] (do_page_fault) from [<c0101358>] (do_DataAbort+0x34/0xb4)

[   44.122297] [<c0101358>] (do_DataAbort) from [<c07bda44>] (__dabt_svc+0x64/0xa0)

[   44.130040] Exception stack(0xeef3ddd8 to 0xeef3de20)

[   44.135328] ddc0:                                                       00000000 00000000

[   44.143897] dde0: 00000000 00002000 00000000 ee814c04 ee814c00 eda11440 ee814c24 c0c029cc

[   44.152464] de00: c0cbe780 edd89800 eef3c000 eef3de28 00000000 c04fc0e8 80070013 ffffffff

[   44.161033] [<c07bda44>] (__dabt_svc) from [<c04fc0e8>] (n_tty_receive_buf_common+0x48/0x9c8)

[   44.169966] [<c04fc0e8>] (n_tty_receive_buf_common) from [<c04fca7c>] (n_tty_receive_buf2+0x14/0x1c)

[   44.179535] [<c04fca7c>] (n_tty_receive_buf2) from [<c04ff2fc>] (flush_to_ldisc+0xc4/0xdc)

[   44.188194] [<c04ff2fc>] (flush_to_ldisc) from [<c0154624>] (process_one_work+0x1e0/0x6bc)

[   44.196855] [<c0154624>] (process_one_work) from [<c0154b38>] (worker_thread+0x38/0x4d0)

[   44.205331] [<c0154b38>] (worker_thread) from [<c015ab80>] (kthread+0xd4/0xf0)

[   44.212897] [<c015ab80>] (kthread) from [<c01078f0>] (ret_from_fork+0x14/0x24)

[   44.220460] Sending NMI to all CPUs:

[   44.224201] NMI backtrace for cpu 0

[   44.227855] CPU: 0 PID: 169 Comm: kworker/u2:2 Tainted: P      D         4.8.0-rc1-12423-g29b4817 #1

[   44.237417] Hardware name: Generic AM33XX (Flattened Device Tree)

[   44.243809] [<c01100e4>] (unwind_backtrace) from [<c010c290>] (show_stack+0x10/0x14)

[   44.251921] [<c010c290>] (show_stack) from [<c0486500>] (dump_stack+0xb0/0xe4)

[   44.259493] [<c0486500>] (dump_stack) from [<c0489ed4>] (nmi_cpu_backtrace+0x7c/0x88)

[   44.267698] [<c0489ed4>] (nmi_cpu_backtrace) from [<c010dc38>] (raise_nmi+0x60/0x70)

[   44.275810] [<c010dc38>] (raise_nmi) from [<c0489fa0>] (nmi_trigger_all_cpu_backtrace+0xc0/0xf4)

[   44.285013] [<c0489fa0>] (nmi_trigger_all_cpu_backtrace) from [<c0197014>] (do_raw_spin_lock+0xf4/0x1b8)

[   44.294945] [<c0197014>] (do_raw_spin_lock) from [<c07b7998>] (__schedule+0x104/0xcfc)

[   44.303238] [<c07b7998>] (__schedule) from [<c07b85d4>] (schedule+0x44/0x9c)

[   44.310622] [<c07b85d4>] (schedule) from [<c013cd9c>] (do_exit+0x934/0xbfc)

[   44.317914] [<c013cd9c>] (do_exit) from [<c010c6d0>] (die+0x43c/0x48c)

[   44.324753] [<c010c6d0>] (die) from [<c011d504>] (__do_kernel_fault.part.0+0x54/0x1e4)

[   44.333049] [<c011d504>] (__do_kernel_fault.part.0) from [<c07be604>] (do_page_fault+0x1ec/0x3f8)

[   44.342344] [<c07be604>] (do_page_fault) from [<c0101358>] (do_DataAbort+0x34/0xb4)

[   44.350365] [<c0101358>] (do_DataAbort) from [<c07bda44>] (__dabt_svc+0x64/0xa0)

[   44.358109] Exception stack(0xeef3db68 to 0xeef3dbb0)

[   44.363400] db60:                   ed8d6e40 ed8d6e40 00000000 00000000 ef6be000 ed8d6e40

[   44.371968] db80: c0b77000 00000000 ed8d727c ef6be000 ed8d7270 eef3dc1c edb3f014 eef3dbb8

[   44.380532] dba0: c015592c c015b46c 20070193 ffffffff

[   44.385825] [<c07bda44>] (__dabt_svc) from [<c015b46c>] (kthread_data+0x4/0xc)

[   44.393393] [<c015b46c>] (kthread_data) from [<c015592c>] (wq_worker_sleeping+0x8/0xcc)

[   44.401777] [<c015592c>] (wq_worker_sleeping) from [<c07b7f40>] (__schedule+0x6ac/0xcfc)

[   44.410253] [<c07b7f40>] (__schedule) from [<c07b85d4>] (schedule+0x44/0x9c)

[   44.417637] [<c07b85d4>] (schedule) from [<c013cbe0>] (do_exit+0x778/0xbfc)

[   44.424929] [<c013cbe0>] (do_exit) from [<c010c6d0>] (die+0x43c/0x48c)

[   44.431767] [<c010c6d0>] (die) from [<c011d504>] (__do_kernel_fault.part.0+0x54/0x1e4)

[   44.440063] [<c011d504>] (__do_kernel_fault.part.0) from [<c07be604>] (do_page_fault+0x1ec/0x3f8)

[   44.449358] [<c07be604>] (do_page_fault) from [<c0101358>] (do_DataAbort+0x34/0xb4)

[   44.457378] [<c0101358>] (do_DataAbort) from [<c07bda44>] (__dabt_svc+0x64/0xa0)

[   44.465121] Exception stack(0xeef3ddd8 to 0xeef3de20)

[   44.470409] ddc0:                                                       00000000 00000000

[   44.478977] dde0: 00000000 00002000 00000000 ee814c04 ee814c00 eda11440 ee814c24 c0c029cc

[   44.487544] de00: c0cbe780 edd89800 eef3c000 eef3de28 00000000 c04fc0e8 80070013 ffffffff

[   44.496111] [<c07bda44>] (__dabt_svc) from [<c04fc0e8>] (n_tty_receive_buf_common+0x48/0x9c8)

[   44.505042] [<c04fc0e8>] (n_tty_receive_buf_common) from [<c04fca7c>] (n_tty_receive_buf2+0x14/0x1c)

[   44.514610] [<c04fca7c>] (n_tty_receive_buf2) from [<c04ff2fc>] (flush_to_ldisc+0xc4/0xdc)

[   44.523268] [<c04ff2fc>] (flush_to_ldisc) from [<c0154624>] (process_one_work+0x1e0/0x6bc)

[   44.531927] [<c0154624>] (process_one_work) from [<c0154b38>] (worker_thread+0x38/0x4d0)

[   44.540402] [<c0154b38>] (worker_thread) from [<c015ab80>] (kthread+0xd4/0xf0)

[   44.547969] [<c015ab80>] (kthread) from [<c01078f0>] (ret_from_fork+0x14/0x24)

[   44.555545] Unable to handle kernel NULL pointer dereference at virtual address 00000000

[   44.564015] pgd = c0004000

[   44.566845] [00000000] *pgd=00000000

[   44.570598] Internal error: Oops: 80000007 [#4] SMP ARM

[   44.576069] Modules linked in: gpio_keys evdev pwm_tiecap omap_rng(+) rng_core snd_soc_davinci_mcasp(+) snd_soc_tlv320aic3x snd_soc_omap snd_soc_edma snd_soc_core lm75 thermal_sys wlcore_sdio lis3lv02d_i2c hwmon snd_pcm_dmaengine tsl2550 lis3lv02d snd_pcm input_polldev snd_timer snd soundcore musb_am335x(+) rtc_omap(+) omap_wdt ti_am335x_tscadc matrix_keypad matrix_keymap pwm_bl autofs4

[   44.612132] CPU: 0 PID: 169 Comm: kworker/u2:2 Tainted: P      D         4.8.0-rc1-12423-g29b4817 #1

[   44.621694] Hardware name: Generic AM33XX (Flattened Device Tree)

[   44.628080] task: ed8d6e40 task.stack: eef3c000

[   44.632821] PC is at 0x0

[   44.635474] LR is at nmi_trigger_all_cpu_backtrace+0xc0/0xf4

[   44.641399] pc : [<00000000>]    lr : [<c0489fa0>]    psr: 60070193

[   44.641399] sp : eef3d918  ip : 00000000  fp : eef3d9ac

[   44.653418] r10: 00000001  r9 : 00000000  r8 : 1db00000

[   44.658887] r7 : 00000000  r6 : c010dbd8  r5 : c0c03800  r4 : 00000001

[   44.665720] r3 : 00000000  r2 : 00000000  r1 : 00000007  r0 : c0c03800

[   44.672553] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none

[   44.680115] Control: 10c5387d  Table: adc18019  DAC: 00000051

[   44.686129] Process kworker/u2:2 (pid: 169, stack limit = 0xeef3c218)

[   44.692871] Stack: (0xeef3d918 to 0xeef3e000)

[   44.697432] d900:                                                       ef6be000 c0c81de8

[   44.705999] d920: 1db00000 00000000 1db00000 c0197014 ef6be000 ed8d6e40 c0b77000 ef6be010

[   44.714566] d940: 0000000b ef6be000 00000001 c07b7998 00000000 00000000 c14510b4 0000002c

[   44.723132] d960: 00000000 00000000 00000000 c07b85d4 c0cbe99c ed8d6e40 00000000 c0c08254

[   44.731699] d980: 60070193 ef6be010 00000000 eef3c000 0000000b c0c08254 60070193 0000000b

[   44.740266] d9a0: 00000000 00000001 eef3d9bc c07b85d4 ed8d6e40 0000000b c015b46e c013cd9c

[   44.748833] d9c0: 00000000 00000000 60070193 eef3d9e4 eef3db68 c0cc3244 eef3db68 c0c08254

[   44.757399] d9e0: 60070193 0000000b 00000000 00000001 c015b46e c010c6d0 eef3c218 0000000b

[   44.765966] da00: c015b470 eef3c000 bf000000 00000008 65000000 32306133 20323030 66666165

[   44.774534] da20: 33346566 38306320 65643430 35652063 33333039 28203066 33313565 30333030

[   44.783101] da40: c0002029 eef3da64 000007ff ffffffd0 eef3db68 00000037 00000000 00000000

[   44.791668] da60: eef3c000 ed8d7270 eef3dc1c c011d504 ffffffd0 c07be604 00000000 c144ec87

[   44.800236] da80: ffffffff ef6be060 00000001 00000001 3159b730 00000001 02e100d4 02e10027

[   44.808803] daa0: ef6be060 c0c09224 00000037 c07be418 ffffffd0 eef3db68 eef3c000 ed8d7270

[   44.817371] dac0: eef3dc1c c0101358 00005000 00000001 00000000 60070113 00000000 c0193ebc

[   44.825938] dae0: 00000000 00000000 00000000 c02b1a5c 00000000 00000000 60070113 00000000

[   44.834505] db00: 00000002 ef6be060 00000001 00000001 00000000 ed8d727c ef6be060 00000001

[   44.843072] db20: 00000001 c0176094 00000000 c0c020d0 00000000 00000000 00000000 ef6be010

[   44.851639] db40: 00000000 00000000 00000000 00000000 c015b46c 20070193 ffffffff eef3db9c

[   44.860206] db60: ed8d727c c07bda44 ed8d6e40 ed8d6e40 00000000 00000000 ef6be000 ed8d6e40

[   44.868774] db80: c0b77000 00000000 ed8d727c ef6be000 ed8d7270 eef3dc1c edb3f014 eef3dbb8

[   44.877341] dba0: c015592c c015b46c 20070193 ffffffff 00000051 bf000000 ef6be000 c07b7f40

[   44.885909] dbc0: 00000000 ed866600 ed8d6e40 ed87f508 c0c02000 c07bd7b4 ed8d6e40 c07b85d4

[   44.894477] dbe0: 00000001 00000000 00000000 c0c02000 c013c840 ef6be010 ed866b04 eef3c000

[   44.903045] dc00: eef3d884 ee89ad80 00000001 eef3dc38 ed8d71d8 00000001 eef3dc2c c07b85d4

[   44.911613] dc20: ed8d6e40 eef3d884 c04fc0ea c013cbe0 00000000 ed8d7370 eef3dc38 eef3dc38

[   44.920181] dc40: 00000001 c0cc3244 eef3ddd8 c0c08254 60070113 0000000b 00000000 00000001

[   44.928748] dc60: c04fc0ea c010c6d0 eef3c218 0000000b c04fc0ec eef3c000 bf000000 00000008

[   44.937316] dc80: 65000000 33643835 20343130 62383265 31626633 38356520 32303364 35652030

[   44.945883] dca0: 30336439 28203431 33393565 34343231 c0002029 eef3dcd4 c0992cac 00002244

[   44.954450] dcc0: eef3ddd8 00000017 00000000 00000000 eef3c000 c0cbe780 edd89800 c011d504

[   44.963017] dce0: 00002244 c07be604 00000001 0001aa6e 00000000 ed8d6e40 c0cbe8ac c018ca10

[   44.971584] dd00: 60010193 00000000 c018c9f0 ed8d6ec0 ef6be060 c0c09224 00000017 c07be418

[   44.980152] dd20: 00002244 eef3ddd8 eef3c000 c0cbe780 edd89800 c0101358 c0176e40 c0c029cc

[   44.988720] dd40: 63ba9b7d 00000001 00000000 c0cbe7d0 800f0193 ef6be060 00000001 00000001

[   44.997287] dd60: 2828a1a9 00000001 02e4d374 00000000 ef6be060 ed8d6ec0 800f0193 ef6be010

[   45.005856] dd80: 800f0193 c0c02810 0000006a 00000000 ee94a248 ee94a240 ee94a1c0 edd89964

[   45.014424] dda0: 00000000 00000000 00000001 00000000 00000001 60070013 c0cbe99c c0193ebc

[   45.022992] ddc0: c04fc0e8 80070013 ffffffff eef3de0c ee814c24 c07bda44 00000000 00000000

[   45.031559] dde0: 00000000 00002000 00000000 ee814c04 ee814c00 eda11440 ee814c24 c0c029cc

[   45.040127] de00: c0cbe780 edd89800 eef3c000 eef3de28 00000000 c04fc0e8 80070013 ffffffff

[   45.048694] de20: 00000051 00000000 edc9814f 00000028 edc9804f 00000000 00000000 00002000

[   45.057261] de40: 00000001 00000000 edd89ac4 ee836c00 ee838f00 edd89930 c0c029cc edc98000

[   45.065829] de60: ee814c04 ee814c00 eda11440 ee814c24 c0c029cc c0cbe780 00000001 c04fca7c

[   45.074396] de80: 00000001 ee814c04 ee814c00 c04ff2fc ed88ef80 ee814c04 ee836c00 ee838f00

[   45.082963] dea0: eef3dec8 c0154624 00000001 00000000 c015456c 00000006 00000000 00000000

[   45.091531] dec0: c0154bac 00000088 c1491624 00000000 00000000 c09dbf84 ed88ef80 ee836c00

[   45.100098] dee0: ed88ef98 00000088 ee836c34 eef3c000 c0c02100 ee836c00 ed88ef80 c0154b38

[   45.108665] df00: eeb5f200 ed88ef80 c0154b00 00000000 eeb5f200 ed88ef80 c0154b00 00000000

[   45.117232] df20: 00000000 00000000 00000000 c015ab80 c0c029cc 00000000 00000000 ed88ef80

[   45.125798] df40: 00000000 00000000 dead4ead ffffffff ffffffff c0cc4e74 00000000 00000000

[   45.134365] df60: c099e5dc eef3df64 eef3df64 00000001 00010001 dead4ead ffffffff ffffffff

[   45.142932] df80: c0cc4e74 00000000 00000000 c099e5dc eef3df90 eef3df90 eeb5f200 eeb5f200

[   45.151499] dfa0: c015aaac 00000000 00000000 c01078f0 00000000 00000000 00000000 00000000

[   45.160065] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000

[   45.168631] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000

[   45.177200] [<c0489fa0>] (nmi_trigger_all_cpu_backtrace) from [<c0197014>] (do_raw_spin_lock+0xf4/0x1b8)

[   45.187131] [<c0197014>] (do_raw_spin_lock) from [<c07b7998>] (__schedule+0x104/0xcfc)

[   45.195424] [<c07b7998>] (__schedule) from [<c07b85d4>] (schedule+0x44/0x9c)

[   45.202809] [<c07b85d4>] (schedule) from [<c013cd9c>] (do_exit+0x934/0xbfc)

[   45.210101] [<c013cd9c>] (do_exit) from [<c010c6d0>] (die+0x43c/0x48c)

[   45.216940] [<c010c6d0>] (die) from [<c011d504>] (__do_kernel_fault.part.0+0x54/0x1e4)

[   45.225236] [<c011d504>] (__do_kernel_fault.part.0) from [<c07be604>] (do_page_fault+0x1ec/0x3f8)

[   45.234531] [<c07be604>] (do_page_fault) from [<c0101358>] (do_DataAbort+0x34/0xb4)

[   45.242551] [<c0101358>] (do_DataAbort) from [<c07bda44>] (__dabt_svc+0x64/0xa0)

[   45.250294] Exception stack(0xeef3db68 to 0xeef3dbb0)

[   45.255586] db60:                   ed8d6e40 ed8d6e40 00000000 00000000 ef6be000 ed8d6e40

[   45.264153] db80: c0b77000 00000000 ed8d727c ef6be000 ed8d7270 eef3dc1c edb3f014 eef3dbb8

[   45.272717] dba0: c015592c c015b46c 20070193 ffffffff

[   45.278011] [<c07bda44>] (__dabt_svc) from [<c015b46c>] (kthread_data+0x4/0xc)

[   45.285580] [<c015b46c>] (kthread_data) from [<c015592c>] (wq_worker_sleeping+0x8/0xcc)

[   45.293965] [<c015592c>] (wq_worker_sleeping) from [<c07b7f40>] (__schedule+0x6ac/0xcfc)

[   45.302440] [<c07b7f40>] (__schedule) from [<c07b85d4>] (schedule+0x44/0x9c)

[   45.309823] [<c07b85d4>] (schedule) from [<c013cbe0>] (do_exit+0x778/0xbfc)

[   45.317115] [<c013cbe0>] (do_exit) from [<c010c6d0>] (die+0x43c/0x48c)

[   45.323953] [<c010c6d0>] (die) from [<c011d504>] (__do_kernel_fault.part.0+0x54/0x1e4)

[   45.332248] [<c011d504>] (__do_kernel_fault.part.0) from [<c07be604>] (do_page_fault+0x1ec/0x3f8)

[   45.341543] [<c07be604>] (do_page_fault) from [<c0101358>] (do_DataAbort+0x34/0xb4)

[   45.349563] [<c0101358>] (do_DataAbort) from [<c07bda44>] (__dabt_svc+0x64/0xa0)

[   45.357306] Exception stack(0xeef3ddd8 to 0xeef3de20)

[   45.362594] ddc0:                                                       00000000 00000000

[   45.371161] dde0: 00000000 00002000 00000000 ee814c04 ee814c00 eda11440 ee814c24 c0c029cc

[   45.379728] de00: c0cbe780 edd89800 eef3c000 eef3de28 00000000 c04fc0e8 80070013 ffffffff

[   45.388297] [<c07bda44>] (__dabt_svc) from [<c04fc0e8>] (n_tty_receive_buf_common+0x48/0x9c8)

[   45.397229] [<c04fc0e8>] (n_tty_receive_buf_common) from [<c04fca7c>] (n_tty_receive_buf2+0x14/0x1c)

[   45.406797] [<c04fca7c>] (n_tty_receive_buf2) from [<c04ff2fc>] (flush_to_ldisc+0xc4/0xdc)

[   45.415457] [<c04ff2fc>] (flush_to_ldisc) from [<c0154624>] (process_one_work+0x1e0/0x6bc)

[   45.424116] [<c0154624>] (process_one_work) from [<c0154b38>] (worker_thread+0x38/0x4d0)

[   45.432594] [<c0154b38>] (worker_thread) from [<c015ab80>] (kthread+0xd4/0xf0)

[   45.440161] [<c015ab80>] (kthread) from [<c01078f0>] (ret_from_fork+0x14/0x24)

[   45.447725] Code: bad PC value

[   45.450927] ---[ end trace f46c51ec097c071f ]---

[   45.455761] Fixing recursive fault but reboot is needed!

[   58.411240] BUG: spinlock lockup suspected on CPU#0, kworker/u2:2/169

[   58.417986]  lock: 0xef6be000, .magic: dead4ead, .owner: kworker/u2:2/169, .owner_cpu: 0

[   58.426462] CPU: 0 PID: 169 Comm: kworker/u2:2 Tainted: P      D         4.8.0-rc1-12423-g29b4817 #1

[   58.436025] Hardware name: Generic AM33XX (Flattened Device Tree)

[   58.442422] [<c01100e4>] (unwind_backtrace) from [<c010c290>] (show_stack+0x10/0x14)

[   58.450535] [<c010c290>] (show_stack) from [<c0486500>] (dump_stack+0xb0/0xe4)

[   58.458103] [<c0486500>] (dump_stack) from [<c0197008>] (do_raw_spin_lock+0xe8/0x1b8)

[   58.466307] [<c0197008>] (do_raw_spin_lock) from [<c07b7998>] (__schedule+0x104/0xcfc)

[   58.474602] [<c07b7998>] (__schedule) from [<c07b85d4>] (schedule+0x44/0x9c)

[   58.481986] [<c07b85d4>] (schedule) from [<c013cd9c>] (do_exit+0x934/0xbfc)

[   58.489280] [<c013cd9c>] (do_exit) from [<c010c6d0>] (die+0x43c/0x48c)

[   58.496119] [<c010c6d0>] (die) from [<c011d504>] (__do_kernel_fault.part.0+0x54/0x1e4)

[   58.504416] [<c011d504>] (__do_kernel_fault.part.0) from [<c07be604>] (do_page_fault+0x1ec/0x3f8)

[   58.513713] [<c07be604>] (do_page_fault) from [<c010140c>] (do_PrefetchAbort+0x34/0x98)

[   58.522099] [<c010140c>] (do_PrefetchAbort) from [<c07bdc70>] (__pabt_svc+0x70/0xc0)

[   58.530207] Exception stack(0xeef3d8c8 to 0xeef3d910)

[   58.535499] d8c0:                   c0c03800 00000007 00000000 00000000 00000001 c0c03800

[   58.544069] d8e0: c010dbd8 00000000 1db00000 00000000 00000001 eef3d9ac 00000000 eef3d918

[   58.552634] d900: c0489fa0 00000000 60070193 ffffffff

[   58.557929] [<c07bdc70>] (__pabt_svc) from [<c0489fa0>] (nmi_trigger_all_cpu_backtrace+0xc0/0xf4)

[   58.567226] [<c0489fa0>] (nmi_trigger_all_cpu_backtrace) from [<c0197014>] (do_raw_spin_lock+0xf4/0x1b8)

[   58.577158] [<c0197014>] (do_raw_spin_lock) from [<c07b7998>] (__schedule+0x104/0xcfc)

[   58.585452] [<c07b7998>] (__schedule) from [<c07b85d4>] (schedule+0x44/0x9c)

[   58.592837] [<c07b85d4>] (schedule) from [<c013cd9c>] (do_exit+0x934/0xbfc)

[   58.600130] [<c013cd9c>] (do_exit) from [<c010c6d0>] (die+0x43c/0x48c)

[   58.606969] [<c010c6d0>] (die) from [<c011d504>] (__do_kernel_fault.part.0+0x54/0x1e4)

[   58.615265] [<c011d504>] (__do_kernel_fault.part.0) from [<c07be604>] (do_page_fault+0x1ec/0x3f8)

[   58.624561] [<c07be604>] (do_page_fault) from [<c0101358>] (do_DataAbort+0x34/0xb4)

[   58.632584] [<c0101358>] (do_DataAbort) from [<c07bda44>] (__dabt_svc+0x64/0xa0)

[   58.640329] Exception stack(0xeef3db68 to 0xeef3dbb0)

[   58.645621] db60:                   ed8d6e40 ed8d6e40 00000000 00000000 ef6be000 ed8d6e40

[   58.654189] db80: c0b77000 00000000 ed8d727c ef6be000 ed8d7270 eef3dc1c edb3f014 eef3dbb8

[   58.662754] dba0: c015592c c015b46c 20070193 ffffffff

[   58.668048] [<c07bda44>] (__dabt_svc) from [<c015b46c>] (kthread_data+0x4/0xc)

[   58.675617] [<c015b46c>] (kthread_data) from [<c015592c>] (wq_worker_sleeping+0x8/0xcc)

[   58.684004] [<c015592c>] (wq_worker_sleeping) from [<c07b7f40>] (__schedule+0x6ac/0xcfc)

[   58.692480] [<c07b7f40>] (__schedule) from [<c07b85d4>] (schedule+0x44/0x9c)

[   58.699864] [<c07b85d4>] (schedule) from [<c013cbe0>] (do_exit+0x778/0xbfc)

[   58.707157] [<c013cbe0>] (do_exit) from [<c010c6d0>] (die+0x43c/0x48c)

[   58.713996] [<c010c6d0>] (die) from [<c011d504>] (__do_kernel_fault.part.0+0x54/0x1e4)

[   58.722292] [<c011d504>] (__do_kernel_fault.part.0) from [<c07be604>] (do_page_fault+0x1ec/0x3f8)

[   58.731589] [<c07be604>] (do_page_fault) from [<c0101358>] (do_DataAbort+0x34/0xb4)

[   58.739611] [<c0101358>] (do_DataAbort) from [<c07bda44>] (__dabt_svc+0x64/0xa0)

[   58.747356] Exception stack(0xeef3ddd8 to 0xeef3de20)

[   58.752645] ddc0:                                                       00000000 00000000

[   58.761214] dde0: 00000000 00002000 00000000 ee814c04 ee814c00 eda11440 ee814c24 c0c029cc

[   58.769783] de00: c0cbe780 edd89800 eef3c000 eef3de28 00000000 c04fc0e8 80070013 ffffffff

[   58.778352] [<c07bda44>] (__dabt_svc) from [<c04fc0e8>] (n_tty_receive_buf_common+0x48/0x9c8)

[   58.787284] [<c04fc0e8>] (n_tty_receive_buf_common) from [<c04fca7c>] (n_tty_receive_buf2+0x14/0x1c)

[   58.796854] [<c04fca7c>] (n_tty_receive_buf2) from [<c04ff2fc>] (flush_to_ldisc+0xc4/0xdc)

[   58.805514] [<c04ff2fc>] (flush_to_ldisc) from [<c0154624>] (process_one_work+0x1e0/0x6bc)

[   58.814173] [<c0154624>] (process_one_work) from [<c0154b38>] (worker_thread+0x38/0x4d0)

[   58.822651] [<c0154b38>] (worker_thread) from [<c015ab80>] (kthread+0xd4/0xf0)

[   58.830218] [<c015ab80>] (kthread) from [<c01078f0>] (ret_from_fork+0x14/0x24)

>>>> On command: boot waiting for boot.+?(?-mix:.*\s+login) >>> error: execution expired
Boot attempt 1/1 failed
Failed to boot on iteration 19: #<SystemLoader::SystemloaderException: SystemLoader::SystemloaderException>
