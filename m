From: Carlos Hernandez <ceh-l0cyMroinI0@public.gmane.org>
Subject: usb-related linux-next boot failures
Date: Tue, 27 Jun 2017 14:28:56 -0400
Message-ID: <0d1a491c-41c4-a02d-cdf8-e1a95a1fe989@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "lcpd_connectivity-uAqBSO/uNfhBDgjK7y7TUQ@public.gmane.org - Linux Core Product Development -
        Connectivity" <lcpd_connectivity-uAqBSO/uNfhBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Still seeing AM57xx/DRA72/DRA7x usb-related boot failures on linux-next...

Complete boot log including sysrq traces at 
https://pastebin.ubuntu.com/24964903/

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.12.0-rc6-next-20170626 (lcpdbld-pmn0CehDYT60De/e2gt5q7+mxzcB8iz6S6/c0EnIpHkAvxtiuMwx3w@public.gmane.org) (gcc version 6.2.1 20161016 (Linaro GCC 6.2-2016.11)) #2 SMP Mon Jun 26 13:37:10 CDT 2017
[    0.000000] CPU: ARMv7 Processor [412fc0f2] revision 2 (ARMv7), cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] OF: fdt: Machine model: TI AM5728 BeagleBoard-X15
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] cma: Reserved 24 MiB at 0xfe000000
[    0.000000] OMAP4: Map 0xffd00000 to fe600000 for dram barrier
[    0.000000] DRA752 ES2.0
[    0.000000] percpu: Embedded 17 pages/cpu @eed82000 s40744 r8192 d20696 u69632
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 522047
[    0.000000] Kernel command line: console=ttyO2,115200n8  earlyprintk=serial,ttyO2,115200n8 rootwait sysrq_always_enabled  ip=:::::eth0:dhcp  root=/dev/nfs rw nfsroot=192.168.0.1:/home/tigtfarm20/NFS_exports/am57xx-evm/autofs/d3fd317ecf18e621cf951fd5ef72179d,nolock,v3,tcp,rsize=4096,wsize=4096
[    0.000000] sysrq: sysrq always enabled.
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 2025704K/2095100K available (9216K kernel code, 895K rwdata, 3180K rodata, 2048K init, 8708K bss, 44820K reserved, 24576K cma-reserved, 1284092K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0a00000   (10208 kB)
[    0.000000]       .init : 0xc0e00000 - 0xc1000000   (2048 kB)
[    0.000000]       .data : 0xc1000000 - 0xc10dfdd0   ( 896 kB)
[    0.000000]        .bss : 0xc10e910c - 0xc196a314   (8709 kB)
[    0.000000] Running RCU self tests
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU event tracing is enabled.
[    0.000000] 	RCU lockdep checking is enabled.
[    0.000000] 	RCU callback double-/use-after-free debug enabled.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] kmemleak: Kernel memory leak detector disabled
[    0.000000] OMAP clockevent source: timer1 at 32786 Hz
[    0.000000] arch_timer: cp15 timer(s) running at 6.14MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x16af5adb9, max_idle_ns: 440795202250 ns
[    0.000006] sched_clock: 56 bits at 6MHz, resolution 162ns, wraps every 4398046511023ns
[    0.000024] Switching to timer-based delay loop, resolution 162ns
[    0.000468] clocksource: 32k_counter: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 58327039986419 ns
[    0.000485] OMAP clocksource: 32k_counter at 32768 Hz
[    0.001760] Console: colour dummy device 80x30
[    0.001792] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.001807] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.001821] ... MAX_LOCK_DEPTH:          48
[    0.001834] ... MAX_LOCKDEP_KEYS:        8191
[    0.001848] ... CLASSHASH_SIZE:          4096
[    0.001861] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.001874] ... MAX_LOCKDEP_CHAINS:      65536
[    0.001887] ... CHAINHASH_SIZE:          32768
[    0.001901]  memory used by lock dependency info: 5167 kB
[    0.001914]  per task-struct memory footprint: 1536 bytes
[    0.003744] kmemleak: Early log buffer exceeded (9413), please increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE
[    0.003781] Calibrating delay loop (skipped), value calculated using timer frequency.. 12.29 BogoMIPS (lpj=61475)
[    0.003808] pid_max: default: 32768 minimum: 301
[    0.004300] Security Framework initialized
[    0.004496] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.004519] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.007127] CPU: Testing write buffer coherency: ok
[    0.008263] /cpus/cpu@0 missing clock-frequency property
[    0.008295] /cpus/cpu@1 missing clock-frequency property
[    0.008314] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.009594] Setting up static identity map for 0x80100000 - 0x80100078
[    0.010236] Hierarchical SRCU implementation.
[    0.014271] smp: Bringing up secondary CPUs ...
[    0.016957] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.017487] smp: Brought up 1 node, 2 CPUs
[    0.017510] SMP: Total of 2 processors activated (24.59 BogoMIPS).
[    0.017526] CPU: All CPU(s) started in HYP mode.
[    0.017539] CPU: Virtualization extensions available.
[    0.020763] devtmpfs: initialized
[    0.116705] VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
[    0.131168] DMA-API: preallocated 4096 debug entries
[    0.131187] DMA-API: debugging enabled by kernel config
[    0.133361] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.133406] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.134460] pinctrl core: initialized pinctrl subsystem
[    0.137680] random: get_random_u32 called from bucket_table_alloc+0xdc/0x264 with crng_init=0
[    0.138669] NET: Registered protocol family 16
[    0.143933] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.145854] omap_hwmod: l3_main_2 using broken dt data from ocp
[    0.361219] omap_hwmod: dcan1: _wait_target_disable failed
[    0.464375] cpuidle: using governor menu
[    0.488926] OMAP GPIO hardware version 0.1
[    0.572345] No ATAGs?
[    0.572694] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
[    0.572735] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.573275] omap4_sram_init:Unable to allocate sram needed to handle errata I688
[    0.573293] omap4_sram_init:Unable to get sram pool needed to handle errata I688
[    0.575212] OMAP DMA hardware revision 0.0
[    0.641400] omap-dma-engine 4a056000.dma-controller: OMAP DMA engine driver (LinkedList1/2/3 supported)
[    0.643511] edma 43300000.edma: memcpy is disabled
[    0.660043] edma 43300000.edma: TI EDMA DMA engine driver
[    0.670104] vgaarb: loaded
[    0.671468] SCSI subsystem initialized
[    0.672352] usbcore: registered new interface driver usbfs
[    0.672565] usbcore: registered new interface driver hub
[    0.672730] usbcore: registered new device driver usb
[    0.675174] palmas 0-0058: Irq flag is 0x00000008
[    0.707097] palmas 0-0058: Muxing GPIO 2f, PWM 0, LED 0
[    0.710320] SMPS12: supplied by regulator-dummy
[    0.713930] SMPS3: supplied by regulator-dummy
[    0.717252] SMPS45: supplied by regulator-dummy
[    0.720853] SMPS6: supplied by regulator-dummy
[    0.723823] SMPS7: supplied by regulator-dummy
[    0.726734] SMPS8: supplied by regulator-dummy
[    0.729404] SMPS9: supplied by regulator-dummy
[    0.731090] LDO1: supplied by regulator-dummy
[    0.733872] LDO2: supplied by regulator-dummy
[    0.734361] random: fast init done
[    0.743625] LDO3: supplied by regulator-dummy
[    0.753703] LDO4: supplied by regulator-dummy
[    0.763712] LDO5: supplied by regulator-dummy
[    0.765430] LDO6: supplied by regulator-dummy
[    0.767176] LDO7: supplied by regulator-dummy
[    0.768869] LDO8: supplied by regulator-dummy
[    0.770604] LDO9: supplied by regulator-dummy
[    0.773762] LDOLN: supplied by regulator-dummy
[    0.783846] LDOUSB: supplied by regulator-dummy
[    0.801378] omap_i2c 48070000.i2c: bus 0 rev0.12 at 400 kHz
[    0.802959] omap_i2c 48060000.i2c: bus 2 rev0.12 at 400 kHz
[    0.803237] media: Linux media interface: v0.10
[    0.803423] Linux video capture interface: v2.00
[    0.803752] pps_core: LinuxPPS API ver. 1 registered
[    0.803768] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
[    0.803845] PTP clock support registered
[    0.804918] Advanced Linux Sound Architecture Driver Initialized.
[    0.807998] clocksource: Switched to clocksource arch_sys_counter
[    0.968400] VFS: Disk quotas dquot_6.6.0
[    0.968614] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.001488] NET: Registered protocol family 2
[    1.003561] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    1.004076] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    1.006766] TCP: Hash tables configured (established 8192 bind 8192)
[    1.007436] UDP hash table entries: 512 (order: 3, 40960 bytes)
[    1.007827] UDP-Lite hash table entries: 512 (order: 3, 40960 bytes)
[    1.009022] NET: Registered protocol family 1
[    1.010441] RPC: Registered named UNIX socket transport module.
[    1.010473] RPC: Registered udp transport module.
[    1.010490] RPC: Registered tcp transport module.
[    1.010505] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.013592] hw perfevents: no interrupt-affinity property for /pmu, guessing.
[    1.014267] hw perfevents: enabled with armv7_cortex_a15 PMU driver, 7 counters available
[    1.020507] audit: initializing netlink subsys (disabled)
[    1.021494] audit: type=2000 audit(1.013:1): state=initialized audit_enabled=0 res=1
[    1.023817] workingset: timestamp_bits=14 max_order=19 bucket_order=5
[    1.026926] NFS: Registering the id_resolver key type
[    1.027225] Key type id_resolver registered
[    1.027257] Key type id_legacy registered
[    1.027416] jffs2: version 2.2. (NAND) (SUMMARY)   2001-2006 Red Hat, Inc.
[    1.040794] bounce: pool size: 64 pages
[    1.040961] io scheduler noop registered
[    1.040979] io scheduler deadline registered
[    1.041093] io scheduler cfq registered (default)
[    1.041112] io scheduler mq-deadline registered
[    1.041128] io scheduler kyber registered
[    1.051251] pinctrl-single 4a003400.pinmux: 282 pins at pa fc003400 size 1128
[    1.057716] vdd_3v3: supplied by regen1
[    1.058443] aic_dvdd_fixed: supplied by vdd_3v3
[    1.058696] vtt_fixed: supplied by smps3
[    1.064444] Serial: 8250/16550 driver, 6 ports, IRQ sharing enabled
[    1.071800] irq: no irq domain found for /ocp/l4@4a000000/scm@2000/pinmux@1400 !
[    1.071862] omap_uart 48020000.serial: no wakeirq for uart2
[    1.072084] 48020000.serial: ttyO2 at MMIO 0x48020000 (irq = 301, base_baud = 3000000) is a OMAP UART2
[    2.075792] console [ttyO2] enabled
[    2.085469] DSS: OMAP DSS rev 6.1
[    2.090496] omapdss_dss 58000000.dss: bound 58001000.dispc (ops dispc_component_ops)
[    2.100258] omapdss_dss 58000000.dss: bound 58040000.encoder (ops hdmi5_component_ops)
[    2.140870] brd: module loaded
[    2.170185] loop: module loaded
[    2.176177] mtdoops: mtd device (mtddev=name/number) must be supplied
[    2.186890] libphy: Fixed MDIO Bus: probed
[    2.248029] davinci_mdio 48485000.mdio: davinci mdio revision 1.6
[    2.254454] libphy: 48485000.mdio: probed
[    2.265643] davinci_mdio 48485000.mdio: phy[1]: device 48485000.mdio:01, driver Micrel KSZ9031 Gigabit PHY
[    2.275806] davinci_mdio 48485000.mdio: phy[2]: device 48485000.mdio:02, driver Micrel KSZ9031 Gigabit PHY
[    2.287039] cpsw 48484000.ethernet: Detected MACID = a0:f6:fd:a4:01:7e
[    2.294232] cpsw 48484000.ethernet: cpts: overflow check period 500 (jiffies)
[    2.305607] cpsw 48484000.ethernet: cpsw: Detected MACID = a0:f6:fd:a4:01:7f
[    2.316584] usbcore: registered new interface driver smsc95xx
[    2.322642] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.329555] ehci-pci: EHCI PCI platform driver
[    2.334334] i2c /dev entries driver
[    2.342835] omap_hsmmc 4809c000.mmc: Got CD GPIO
[    2.468948] ledtrig-cpu: registered to indicate activity on CPUs
[    2.484786] oprofile: using timer interrupt.
[    2.489852] Initializing XFRM netlink socket
[    2.494854] NET: Registered protocol family 10
[    2.502501] Segment Routing with IPv6
[    2.506669] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    2.514952] NET: Registered protocol family 17
[    2.519835] NET: Registered protocol family 15
[    2.524819] Key type dns_resolver registered
[    2.536852] omap_voltage_late_init: Voltage driver support not added
[    2.545631] sr_dev_init: Unable to get voltage domain pointer for VDD core
[    2.552945] sr_dev_init: Unable to get voltage domain pointer for VDD mpu
[    2.560581] Power Management for TI OMAP4+ devices.
[    2.566119] ThumbEE CPU extension supported.
[    2.570719] Registering SWP/SWPB emulation handler
[    2.575833] SmartReflex Class3 initialized
[    2.580415] mmc0: host does not support reading read-only switch, assuming write-enable
[    2.593503] mmc0: new high speed SDHC card at address aaaa
[    2.602185] mmcblk0: mmc0:aaaa SL08G 7.40 GiB
[    2.610431]  mmcblk0: p1 p2 p3
[    2.620498] mmc1: new high speed MMC card at address 0001
[    2.628653] mmcblk1: mmc1:0001 S10004 3.56 GiB
[    2.635040] mmcblk1boot0: mmc1:0001 S10004 partition 1 4.00 MiB
[    2.643009] mmcblk1boot1: mmc1:0001 S10004 partition 2 4.00 MiB
[    2.651512]  mmcblk1: p1 p2 p3
[    2.668019] dmm 4e000000.dmm: initialized all PAT entries
[    2.676217] hctosys: unable to open rtc device (rtc0)
[    2.681615] sr_init: No PMIC hook to init smartreflex
[    2.687211] sr_init: platform driver register failed for SR
[    2.697865] net eth0: initializing cpsw version 1.15 (0)
[    2.703958] cpsw 48484000.ethernet: initialized cpsw ale version 1.4
[    2.710697] cpsw 48484000.ethernet: ALE Table size 1024
[    2.838773] Micrel KSZ9031 Gigabit PHY 48485000.mdio:01: attached PHY driver [Micrel KSZ9031 Gigabit PHY] (mii_bus:phy_addr=48485000.mdio:01, irq=-1)
[    2.865378] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    7.046719] cpsw 48484000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
[    7.068079] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    7.098017] Sending DHCP requests ., OK
[    7.142164] IP-Config: Got DHCP answer from 192.168.0.1, my address is 192.168.0.57
[    7.150700] IP-Config: Complete:
[    7.154099]      device=eth0, hwaddr=a0:f6:fd:a4:01:7e, ipaddr=192.168.0.57, mask=255.255.255.0, gw=192.168.0.1
[    7.164755]      host=192.168.0.57, domain=ti.com, nis-domain=(none)
[    7.171524]      bootserver=0.0.0.0, rootserver=192.168.0.1, rootpath=     nameserver0=192.0.2.2, nameserver1=192.0.2.3
[    7.184123] aic_dvdd_fixed: disabling
[    7.188959] ldousb: disabling
[    7.192637] ALSA device list:
[    7.195758]   No soundcards found.
[    7.224645] VFS: Mounted root (nfs filesystem) on device 0:14.
[    7.232443] devtmpfs: mounted
[    7.238146] Freeing unused kernel memory: 2048K
[    7.547989] systemd[1]: System time before build time, advancing clock.
[    7.756881] systemd[1]: systemd 229 running in system mode. (+PAM -AUDIT -SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP -LIBCRYPTSETUP -GCRYPT -GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID -ELFUTILS +KMOD -IDN)
[    7.778068] systemd[1]: Detected architecture arm.

Welcome to [1mArago 2016.12[0m!

[    7.810156] systemd[1]: Set hostname to <am57xx-evm>.
[    8.666018] systemd[1]: sysinit.target: Found ordering cycle on sysinit.target/start
[    8.674443] systemd[1]: sysinit.target: Found dependency on alignment.service/start
[    8.682543] systemd[1]: sysinit.target: Found dependency on basic.target/start
[    8.690199] systemd[1]: sysinit.target: Found dependency on sockets.target/start
[    8.698017] systemd[1]: sysinit.target: Found dependency on dbus.socket/start
[    8.705534] systemd[1]: sysinit.target: Found dependency on sysinit.target/start
[    8.713558] systemd[1]: sysinit.target: Breaking ordering cycle by deleting job alignment.service/start
[[0;1;31m SKIP [0m] Ordering cycle found, skipping alignment.service
[[0;32m  OK  [0m] Listening on Network Service Netlink Socket.
[[0;32m  OK  [0m] Created slice User and Session Slice.
[[0;32m  OK  [0m] Listening on Journal Audit Socket.
[[0;32m  OK  [0m] Listening on Journal Socket.
[[0;32m  OK  [0m] Listening on Syslog Socket.
[[0;32m  OK  [0m] Listening on /dev/initctl Compatibility Named Pipe.
[[0;32m  OK  [0m] Reached target Swap.
[[0;32m  OK  [0m] Listening on udev Control Socket.
[[0;32m  OK  [0m] Started Dispatch Password Requests to Console Directory Watch.
[[0;32m  OK  [0m] Created slice System Slice.
[[0;32m  OK  [0m] Reached target Slices.
          Mounting POSIX Message Queue File System...
          Starting Setup Virtual Console...
[[0;32m  OK  [0m] Created slice system-getty.slice.
          Mounting Temporary Directory...
          Mounting Debug File System...
[[0;32m  OK  [0m] Created slice system-serial\x2dgetty.slice.
[[0;32m  OK  [0m] Reached target Remote File Systems.
          Starting Create list of required st... nodes for the current kernel...
          Starting Load Kernel Modules...
[[0;32m  OK  [0m] Listening on udev Kernel Socket.
[[0;32m  OK  [0m] Started Forward Password Requests to Wall Directory Watch.
[[0;32m  OK  [0m] Reached target Paths.
[[0;32m  OK  [0m] Listening on Journal Socket (/dev/log).
          Starting Journal Service...
          Starting Remount Root and Kernel File Systems...
[[0;32m  OK  [0m] Mounted POSIX Message Queue File System.
[[0;32m  OK  [0m] Mounted Debug File System.
[[0;32m  OK  [0m] Mounted Temporary Directory.
[[0;32m  OK  [0m] Started Setup Virtual Console.
[[0;32m  OK  [0m] Started Create list of required sta...ce nodes for the current kernel.
[[0;1;31mFAILED[0m] Failed to start Load Kernel Modules.
See 'systemctl status systemd-modules-load.service' for details.
[[0;32m  OK  [0m] Started Remount Root and Kernel File Systems.
[[0;32m  OK  [0m] Started Journal Service.
          Starting Flush Journal to Persistent Storage...
          Starting udev Coldplug all Devices...
          Mounting Configuration File System...
          Starting Apply Kernel Variables...
          Starting Create Static Device Nodes in /dev...
[[0;32m  OK  [0m] Mounted Configuration File System.
[[0;32m  OK  [0m] Started Apply Kernel Variables.
[   10.520016] systemd-journald[89]: Received request to flush runtime journal from PID 1
[[0;32m  OK  [0m] Started Flush Journal to Persistent Storage.
[[0;32m  OK  [0m] Started Create Static Device Nodes in /dev.
          Starting udev Kernel Device Manager...
[[0;32m  OK  [0m] Reached target Local File Systems (Pre).
          Mounting /var/volatile...
          Mounting /media/ram...
[[0;32m  OK  [0m] Mounted /var/volatile.
[[0;32m  OK  [0m] Mounted /media/ram.
[[0;32m  OK  [0m] Started udev Kernel Device Manager.
          Starting Load/Save Random Seed...
[[0;32m  OK  [0m] Reached target Local File Systems.
          Starting Create Volatile Files and Directories...
[[0;32m  OK  [0m] Started Load/Save Random Seed.
[[0;32m  OK  [0m] Started Create Volatile Files and Directories.
          Starting Update UTMP about System Boot/Shutdown...
          Starting Network Time Synchronization...
[[0;32m  OK  [0m] Started Update UTMP about System Boot/Shutdown.
[[0;32m  OK  [0m] Started Network Time Synchronization.
[[0;32m  OK  [0m] Reached target System Time Synchronized.
          Starting Synchronize System and HW clocks...
[[0;1;31mFAILED[0m] Failed to start Synchronize System and HW clocks.
See 'systemctl status sync-clocks.service' for details.
[[0;32m  OK  [0m] Found device /dev/ttyO2.
[[0;32m  OK  [0m] Started udev Coldplug all Devices.
[[0;32m  OK  [0m] Reached target System Initialization.
[[0;32m  OK  [0m] Listening on Avahi mDNS/DNS-SD Stack Activation Socket.
[   13.608490] omap_rng 48090000.rng: Random Number Generator ver. 20
[   13.864222] tmp102 0-0048: initialized
[   14.056335] at24 0-0050: 4096 byte 24c32 EEPROM, writable, 1 bytes/write
[   14.073057] random: crng init done
[[0;32m  OK  [0m] Listening on dropbear.socket.
[[0;32m  OK  [0m] Listening on RPCbind Server Activation Socket.
[[0;32m  OK  [0m] Listening on D-Bus System Message Bus Socket.
[[0;32m  OK  [0m] Reached target Sockets.
[[0;32m  OK  [0m] Reached target Basic System.
[   14.270985] palmas-rtc 48070000.i2c:tps659038@58:tps659038_rtc: rtc core: registered 48070000.i2c:tps659038@58:tps659038_rtc as rtc1
          Starting Permit User Sessions...
[   14.332660] palmas_pwrbutton 48070000.i2c:tps659038@58:tps659038_pwr_button: h/w controlled shutdown duration=12 seconds
[   14.374825] input: palmas_pwron as /devices/platform/44000000.ocp/48070000.i2c/i2c-0/0-0058/48070000.i2c:tps659038@58:tps659038_pwr_button/input/input0
          Starting Login Service...
          Starting Avahi mDNS/DNS-SD Stack...
[[0;32m  OK  [0m] Started D-Bus System Message Bus.
[   14.872118] omap_rtc 48838000.rtc: rtc core: registered 48838000.rtc as rtc2
[   15.201848] ------------[ cut here ]------------
[   15.206908] WARNING: CPU: 0 PID: 149 at kernel/irq/manage.c:1348 __setup_irq+0x5d0/0x64c
[   15.215406] Modules linked in: dwc3_omap(+) rtc_omap extcon_palmas palmas_pwrbutton rtc_palmas at24 snd_soc_tlv320aic3x nvmem_core rtc_ds1307 tmp102 hwmon omap_rng rng_core sch_fq_codel autofs4
[   15.233644] CPU: 0 PID: 149 Comm: systemd-udevd Not tainted 4.12.0-rc6-next-20170626 #2
[   15.242061] Hardware name: Generic DRA74X (Flattened Device Tree)
[   15.248469] [<c01122f8>] (unwind_backtrace) from [<c010d2b8>] (show_stack+0x10/0x14)
[   15.256605] [<c010d2b8>] (show_stack) from [<c0963fcc>] (dump_stack+0xac/0xe0)
[   15.264197] [<c0963fcc>] (dump_stack) from [<c013b2b8>] (__warn+0xd8/0x104)
[   15.271512] [<c013b2b8>] (__warn) from [<c013b390>] (warn_slowpath_null+0x20/0x28)
[   15.279463] [<c013b390>] (warn_slowpath_null) from [<c01b2020>] (__setup_irq+0x5d0/0x64c)
[   15.288047] [<c01b2020>] (__setup_irq) from [<c01b2240>] (request_threaded_irq+0xdc/0x188)
[   15.296723] [<c01b2240>] (request_threaded_irq) from [<c01b497c>] (devm_request_threaded_irq+0x5c/0xb8)
[   15.306590] [<c01b497c>] (devm_request_threaded_irq) from [<bf09158c>] (dwc3_omap_probe+0x1c0/0x3f4 [dwc3_omap])
[   15.317334] [<bf09158c>] (dwc3_omap_probe [dwc3_omap]) from [<c063c1a8>] (platform_drv_probe+0x50/0xb0)
[   15.327203] [<c063c1a8>] (platform_drv_probe) from [<c0639f38>] (driver_probe_device+0x33c/0x478)
[   15.336518] [<c0639f38>] (driver_probe_device) from [<c063a15c>] (__driver_attach+0xe8/0x110)
[   15.345467] [<c063a15c>] (__driver_attach) from [<c0637e9c>] (bus_for_each_dev+0x6c/0xa0)
[   15.354051] [<c0637e9c>] (bus_for_each_dev) from [<c06391d4>] (bus_add_driver+0x198/0x270)
[   15.362741] [<c06391d4>] (bus_add_driver) from [<c063b194>] (driver_register+0x78/0xf4)
[   15.371152] [<c063b194>] (driver_register) from [<c01018fc>] (do_one_initcall+0x3c/0x16c)
[   15.379753] [<c01018fc>] (do_one_initcall) from [<c01f0268>] (do_init_module+0x5c/0x1e0)
[   15.388254] [<c01f0268>] (do_init_module) from [<c01ef00c>] (load_module+0x2238/0x29d4)
[   15.396663] [<c01ef00c>] (load_module) from [<c01efa30>] (SyS_finit_module+0xa8/0xec)
[   15.404885] [<c01efa30>] (SyS_finit_module) from [<c0108648>] (__sys_trace_return+0x0/0x10)
[   15.413652] ---[ end trace c99598f673dd94c7 ]---
[   16.089450] ahci 4a140000.sata: SSS flag set, parallel bus scan disabled
[   16.098072] ahci 4a140000.sata: AHCI 0001.0300 32 slots 1 ports 3 Gbps 0x1 impl platform mode
[   16.117181] ahci 4a140000.sata: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part ccc apst
[   16.205120] scsi host0: ahci
[   16.209900] ata1: SATA max UDMA/133 mmio [mem 0x4a140000-0x4a1410ff] port 0x100 irq 331
[   16.713444] omap_wdt: OMAP Watchdog Timer Rev 0x01: initial timeout 60 sec
[[0;32m  OK  [0m] Started Avahi mDNS/DNS-SD Stack.
[   16.778156] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   16.796035] ata1.15: Port Multiplier 1.2, 0x197b:0x0325 r0, 15 ports, feat 0x5/0xf
          Starting uim-sysfs.service...
[[0;32m  OK  [0m] Started System Logging Service.
[   17.006602] ata1.00: hard resetting link
[[0;32m  OK  [0m] Started Kernel Logging Service.
[[0;32m  OK  [0m] Started strongSwan IPsec IKEv1/IKEv2 daemon using ipsec.conf.
          Starting Telephony service...
          Starting Network Service...
          Starting Print notice about GPLv3 packages...
[[0;32m  OK  [0m] Started Daily Cleanup of Temporary Directories.
[[0;32m  OK  [0m] Reached target Timers.
[   17.491263] ata1.00: link resume succeeded after 1 retries
[[0;32m  OK  [0m] Started Permit User Sessions.
[   17.623964] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   17.658362] ata1.01: hard resetting link
[   18.108698] ata1.01: link resume succeeded after 1 retries
[   18.225662] ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   18.241547] ata1.02: hard resetting link
[   18.554077] omap-hdmi-audio omap-hdmi-audio.0.auto: snd-soc-dummy-dai <-> 58040000.encoder mapping ok
[   18.577011] gpio-fan gpio_fan: GPIO fan initialized
[   18.598915] ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   18.599067] ata1.03: hard resetting link
[   19.407673] asoc-simple-card sound0: tlv320aic3x-hifi <-> 48468000.mcasp mapping ok
[[0;32m  OK  [0m] Started Network Service.
[   19.704744] ata1.03: failed to resume link (SControl 0)
[   19.724511] ata1.03: SATA link down (SStatus 0 SControl 0)
[   19.760748] ata1.04: hard resetting link
[   19.855515] EXT4-fs (mmcblk0p2): recovery complete
[   19.899631] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
[   20.216978] FAT-fs (mmcblk1p1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[   20.224756] FAT-fs (mmcblk1p3): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[   20.230625] FAT-fs (mmcblk1p2): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[   20.253617] FAT-fs (mmcblk0p1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[   20.265653] FAT-fs (mmcblk0p3): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[   20.948422] ata1.04: failed to resume link (SControl 0)
[   20.990864] ata1.04: SATA link down (SStatus 0 SControl 0)
[   21.017264] ata1.05: hard resetting link
[   22.148253] ata1.05: failed to resume link (SControl 0)
[   22.171022] ata1.05: SATA link down (SStatus 0 SControl 0)
[[0;32m  OK  [0m] Found device /dev/ttyS2.
[   22.211169] ata1.06: hard resetting link
[   22.983170] Bluetooth: Core ver 2.22
[   22.987064] NET: Registered protocol family 31
[   23.007571] Bluetooth: HCI device and connection manager initialized
[   23.045375] Bluetooth: HCI socket layer initialized
[   23.074632] Bluetooth: L2CAP socket layer initialized
[   23.102531] Bluetooth: SCO socket layer initialized
[   23.328483] ata1.06: failed to resume link (SControl 0)
[   23.349838] ata1.06: SATA link down (SStatus 0 SControl 0)
[   23.425243] ata1.07: hard resetting link
[   24.141405] dwc3 488d0000.usb: changing max_speed on rev 5533202a
[   24.551770] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[   24.557711] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 1
[   24.588372] ata1.07: failed to resume link (SControl 0)
[   24.597048] xhci-hcd xhci-hcd.1.auto: hcc params 0x0220f04c hci version 0x100 quirks 0x02010010
[   24.607603] xhci-hcd xhci-hcd.1.auto: irq 354, io mem 0x48890000
[   24.614343] ata1.07: SATA link down (SStatus 0 SControl 0)
[   24.616324] ata1.08: hard resetting link
[   24.635339] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[   24.644536] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   24.653568] usb usb1: Product: xHCI Host Controller
[   24.659550] usb usb1: Manufacturer: Linux 4.12.0-rc6-next-20170626 xhci-hcd
[   24.668758] usb usb1: SerialNumber: xhci-hcd.1.auto
[   24.681328] hub 1-0:1.0: USB hub found
[   24.687299] hub 1-0:1.0: 1 port detected
[   24.703655] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[   24.710164] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 2
[   24.720088] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[   24.736916] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[   24.745175] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   24.754190] usb usb2: Product: xHCI Host Controller
[   24.761002] usb usb2: Manufacturer: Linux 4.12.0-rc6-next-20170626 xhci-hcd
[   24.769118] usb usb2: SerialNumber: xhci-hcd.1.auto
[   24.781144] hub 2-0:1.0: USB hub found
[   24.787836] hub 2-0:1.0: 1 port detected
[   24.809939] Unhandled fault: imprecise external abort (0x1406) at 0x00000000
[   24.817435] pgd = c0004000
[   24.820276] [00000000] *pgd=00000000
[   24.824046] Internal error: : 1406 [#1] SMP ARM
[   24.828796] Modules linked in: xhci_plat_hcd xhci_hcd dwc3 evdev udc_core bluetooth esp4 sha256_generic hmac drbg ecdh_generic snd_soc_simple_card snd_soc_simple_card_utils leds_gpio gpio_fan snd_soc_omap_hdmi_audio cpufreq_dt omap_wdt phy_omap_usb2 ahci_platform libahci_platform libahci ti_soc_thermal libata thermal_sys dwc3_omap rtc_omap extcon_palmas palmas_pwrbutton rtc_palmas at24 snd_soc_tlv320aic3x nvmem_core rtc_ds1307 tmp102 hwmon omap_rng rng_core sch_fq_codel autofs4
[   24.873374] CPU: 0 PID: 19 Comm: kworker/0:1 Tainted: G        W       4.12.0-rc6-next-20170626 #2
[   24.882764] Hardware name: Generic DRA74X (Flattened Device Tree)
[   24.889163] Workqueue: events_power_efficient hub_init_func2
[   24.895096] task: ee2d7100 task.stack: ee2f4000
[   24.899887] PC is at xhci_hub_control+0x9f4/0x1d50 [xhci_hcd]
[   24.905938] LR is at xhci_hub_control+0x9e4/0x1d50 [xhci_hcd]
[   24.911967] pc : [<bf30443c>]    lr : [<bf30442c>]    psr: a00f0093
[   24.918540] sp : ee2f5cd8  ip : 00000004  fp : fa890420
[   24.924015] r10: bf30f0b4  r9 : ec224208  r8 : ec224000
[   24.929494] r7 : 000006e1  r6 : 00000000  r5 : 00000000  r4 : 000206e1
[   24.936336] r3 : fe600000  r2 : 00000000  r1 : 00000000  r0 : 800f0013
[   24.943187] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   24.950763] Control: 10c5387d  Table: ac36406a  DAC: 00000051
[   24.956792] Process kworker/0:1 (pid: 19, stack limit = 0xee2f4218)
[   24.963366] Stack: (0xee2f5cd8 to 0xee2f6000)
[   24.967930] 5cc0:                                                       ffffe000 c1047630
[   24.976504] 5ce0: 600f0013 00000000 00000001 ec2241d8 00000001 ffffffff c1086c90 ed6d6ac0
[   24.985085] 5d00: 014080c0 c01bbaac c1059988 c02bc2cc ec109000 00000000 00000023 800f0013
[   24.993664] 5d20: ed6b2580 ee2d7100 00000001 ed5b9200 ec224000 00000000 bf303a48 00000000
[   25.002242] 5d40: ed6d6ac0 00000000 00002301 c0706d40 ed6d6ac0 00000000 ee2f4000 c019e4f0
[   25.010815] 5d60: 00000004 00000010 00000001 ee2d7718 00000001 00000007 ee2d7100 00000006
[   25.019391] 5d80: 200f0013 00000001 00000023 c019e4f0 c01a5150 ee2d7100 00000001 00000020
[   25.027967] 5da0: ee2d7100 c019e680 ee2d7758 ee2f5e14 c01a5150 c019ea3c 00000000 00000000
[   25.036544] 5dc0: 00000004 ee2f5e14 ee2f5e14 c0c10fac c10ec118 ee2f5e5c ee2f5e14 ed5b9200
[   25.045122] 5de0: ee2f5e10 00000000 ee2f5e5c 000003e8 ec109000 00000001 00000023 c0708da4
[   25.053697] 5e00: 01400000 c01bbaac c1059988 c02bc2cc 00000000 00000000 dead4ead ffffffff
[   25.062275] 5e20: ffffffff c194e974 00000000 00000000 c0c0d634 ee2f5e34 ee2f5e34 80000100
[   25.070852] 5e40: ed6d6b00 00000000 00000001 00000010 80000100 c0708f34 00000000 00000001
[   25.079434] 5e60: ec2fb100 ed5c8e00 00000001 00000000 00000000 00000000 ec109000 ec25ac00
[   25.088014] 5e80: 00000001 c06fda34 00000010 00000001 00000000 00000000 000003e8 ec25ac00
[   25.096587] 5ea0: 00000001 c06ffc64 ee2f5ed6 00000000 c1007968 c01a0eb0 00000001 00000000
[   25.105164] 5ec0: 00000000 00000000 00000001 00000000 600f0013 00010101 eed8e600 ed5c8f54
[   25.113738] 5ee0: ee2d4980 eed8ae00 ee2f5f20 eed8e600 c1043470 c1007968 c10cf1d4 c015afe4
[   25.122316] 5f00: 00000001 00000000 c015af28 00000005 00000000 00000000 00000000 00000000
[   25.130891] 5f20: c194e8d0 c125ce54 00000000 c0c97b00 ee2d4980 eed8ae00 ee2d4998 00000000
[   25.139468] 5f40: eed8ae34 ee2f4000 c1004900 eed8ae00 ee2d4980 c015c0d8 00000000 ee24c900
[   25.148043] 5f60: ffffe000 ee2d4900 00000000 ee24c900 ee2f4000 ee2d4980 c015c09c ee2d4938
[   25.156624] 5f80: ee0d5e90 c0161fa0 ee2f4000 ee24c900 c0161e84 00000000 00000000 00000000
[   25.165201] 5fa0: 00000000 00000000 00000000 c0108570 00000000 00000000 00000000 00000000
[   25.173782] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   25.182353] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00901080
[   25.190983] [<bf30443c>] (xhci_hub_control [xhci_hcd]) from [<c0706d40>] (usb_hcd_submit_urb+0x238/0x9b4)
[   25.201016] [<c0706d40>] (usb_hcd_submit_urb) from [<c0708da4>] (usb_start_wait_urb+0x44/0x138)
[   25.210150] [<c0708da4>] (usb_start_wait_urb) from [<c0708f34>] (usb_control_msg+0x9c/0xd0)
[   25.218913] [<c0708f34>] (usb_control_msg) from [<c06fda34>] (usb_clear_port_feature+0x44/0x4c)
[   25.228041] [<c06fda34>] (usb_clear_port_feature) from [<c06ffc64>] (hub_activate+0x314/0x688)
[   25.237077] [<c06ffc64>] (hub_activate) from [<c015afe4>] (process_one_work+0x248/0x79c)
[   25.245565] [<c015afe4>] (process_one_work) from [<c015c0d8>] (worker_thread+0x3c/0x4ec)
[   25.254056] [<c015c0d8>] (worker_thread) from [<c0161fa0>] (kthread+0x11c/0x160)
[   25.261819] [<c0161fa0>] (kthread) from [<c0108570>] (ret_from_fork+0x14/0x24)
[   25.269404] Code: e1874004 e58b4000 e59b2000 ee075f9a (e59f3664)
[   25.275804] ---[ end trace c99598f673dd94c8 ]---
[   25.280646] Kernel panic - not syncing: Fatal exception
[   25.286132] CPU1: stopping
[   25.288981] CPU: 1 PID: 302 Comm: find Tainted: G      D W       4.12.0-rc6-next-20170626 #2
[   25.297834] Hardware name: Generic DRA74X (Flattened Device Tree)
[   25.304239] [<c01122f8>] (unwind_backtrace) from [<c010d2b8>] (show_stack+0x10/0x14)
[   25.312369] [<c010d2b8>] (show_stack) from [<c0963fcc>] (dump_stack+0xac/0xe0)
[   25.319950] [<c0963fcc>] (dump_stack) from [<c011054c>] (handle_IPI+0x370/0x478)
[   25.327712] [<c011054c>] (handle_IPI) from [<c0101604>] (gic_handle_irq+0x9c/0xb8)
[   25.335657] [<c0101604>] (gic_handle_irq) from [<c0980d70>] (__irq_svc+0x70/0x98)
[   25.343504] Exception stack(0xec0a1de0 to 0xec0a1e28)
[   25.348808] 1de0: ec134748 00000000 00000000 00000001 ec134748 00000000 00000000 00000001
[   25.357390] 1e00: ec0a0000 0000002c 60000013 00000030 00000000 ec0a1e30 c029d974 c01a0e08
[   25.365968] 1e20: 60000013 ffffffff
[   25.369634] [<c0980d70>] (__irq_svc) from [<c01a0e08>] (lock_acquire+0x38/0x294)
[   25.377399] [<c01a0e08>] (lock_acquire) from [<c029d974>] (__might_fault+0x7c/0xb0)
[   25.385436] [<c029d974>] (__might_fault) from [<c0525394>] (strncpy_from_user+0x9c/0x204)
[   25.394022] [<c0525394>] (strncpy_from_user) from [<c02e5f58>] (getname_flags+0x64/0x1b4)
[   25.402603] [<c02e5f58>] (getname_flags) from [<c02e63b0>] (user_path_at_empty+0x24/0x44)
[   25.411188] [<c02e63b0>] (user_path_at_empty) from [<c02da460>] (vfs_statx+0x64/0xb8)
[   25.419408] [<c02da460>] (vfs_statx) from [<c02dac18>] (SyS_lstat64+0x28/0x48)
[   25.426990] [<c02dac18>] (SyS_lstat64) from [<c0108648>] (__sys_trace_return+0x0/0x10)
[   25.435309] ---[ end Kernel panic - not syncing: Fatal exception
[   25.441663] ------------[ cut here ]------------
[   25.446519] WARNING: CPU: 0 PID: 19 at drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x21c/0x348
[   25.456200] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4_PER3_P3 (Idle): Data Access in Supervisor mode during Functional access
[   25.468875] Modules linked in: xhci_plat_hcd xhci_hcd dwc3 evdev udc_core bluetooth esp4 sha256_generic hmac drbg ecdh_generic snd_soc_simple_card snd_soc_simple_card_utils leds_gpio gpio_fan snd_soc_omap_hdmi_audio cpufreq_dt omap_wdt phy_omap_usb2 ahci_platform libahci_platform libahci ti_soc_thermal libata thermal_sys dwc3_omap rtc_omap extcon_palmas palmas_pwrbutton rtc_palmas at24 snd_soc_tlv320aic3x nvmem_core rtc_ds1307 tmp102 hwmon omap_rng rng_core sch_fq_codel autofs4
[   25.513497] CPU: 0 PID: 19 Comm: kworker/0:1 Tainted: G      D W       4.12.0-rc6-next-20170626 #2
[   25.522896] Hardware name: Generic DRA74X (Flattened Device Tree)
[   25.529294] Workqueue: events_power_efficient hub_init_func2
[   25.535239] [<c01122f8>] (unwind_backtrace) from [<c010d2b8>] (show_stack+0x10/0x14)
[   25.543374] [<c010d2b8>] (show_stack) from [<c0963fcc>] (dump_stack+0xac/0xe0)
[   25.550957] [<c0963fcc>] (dump_stack) from [<c013b2b8>] (__warn+0xd8/0x104)
[   25.558265] [<c013b2b8>] (__warn) from [<c013b318>] (warn_slowpath_fmt+0x34/0x44)
[   25.566115] [<c013b318>] (warn_slowpath_fmt) from [<c0528efc>] (l3_interrupt_handler+0x21c/0x348)
[   25.575431] [<c0528efc>] (l3_interrupt_handler) from [<c01afbc4>] (__handle_irq_event_percpu+0x48/0x414)
[   25.585389] [<c01afbc4>] (__handle_irq_event_percpu) from [<c01affac>] (handle_irq_event_percpu+0x1c/0x58)
[   25.595528] [<c01affac>] (handle_irq_event_percpu) from [<c01b0020>] (handle_irq_event+0x38/0x5c)
[   25.604845] [<c01b0020>] (handle_irq_event) from [<c01b3670>] (handle_fasteoi_irq+0xcc/0x1ac)
[   25.613792] [<c01b3670>] (handle_fasteoi_irq) from [<c01aeecc>] (generic_handle_irq+0x20/0x34)
[   25.622828] [<c01aeecc>] (generic_handle_irq) from [<c01af428>] (__handle_domain_irq+0x64/0xe0)
[   25.631963] [<c01af428>] (__handle_domain_irq) from [<c01015bc>] (gic_handle_irq+0x54/0xb8)
[   25.640720] [<c01015bc>] (gic_handle_irq) from [<c0980d70>] (__irq_svc+0x70/0x98)
[   25.648568] Exception stack(0xee2f5a50 to 0xee2f5a98)
[   25.653873] 5a40:                                     c0142fa0 c10ea740 00000000 00000000
[   25.662455] 5a60: ffffe000 ee2f4000 c1007d80 00000000 00000001 ee00e400 c1007fd0 00000282
[   25.671038] 5a80: 04208060 ee2f5aa0 c0142fa0 c0142fa4 600f0113 ffffffff
[   25.677983] [<c0980d70>] (__irq_svc) from [<c0142fa4>] (__do_softirq+0xb4/0x570)
[   25.685744] [<c0142fa4>] (__do_softirq) from [<c01437f8>] (irq_exit+0xe4/0x160)
[   25.693416] [<c01437f8>] (irq_exit) from [<c01af430>] (__handle_domain_irq+0x6c/0xe0)
[   25.701640] [<c01af430>] (__handle_domain_irq) from [<c01015bc>] (gic_handle_irq+0x54/0xb8)
[   25.710407] [<c01015bc>] (gic_handle_irq) from [<c0980d70>] (__irq_svc+0x70/0x98)
[   25.718258] Exception stack(0xee2f5b40 to 0xee2f5b88)
[   25.723566] 5b40: c013b580 00000007 00000001 00000000 c10ea2c8 00000000 0000000b 00000000
[   25.732153] 5b60: c100cd30 00001406 ee2d7100 ffffe000 00000007 ee2f5b90 c013b580 c013b584
[   25.740728] 5b80: 600f0113 ffffffff
[   25.744387] [<c0980d70>] (__irq_svc) from [<c013b584>] (panic+0x1ec/0x26c)
[   25.751607] [<c013b584>] (panic) from [<c010d5ac>] (die+0x2f0/0x32c)
[   25.758277] [<c010d5ac>] (die) from [<c010142c>] (do_DataAbort+0xa8/0xb8)
[   25.765399] [<c010142c>] (do_DataAbort) from [<c0980cc4>] (__dabt_svc+0x64/0xa0)
[   25.773160] Exception stack(0xee2f5c88 to 0xee2f5cd0)
[   25.778468] 5c80:                   800f0013 00000000 00000000 fe600000 000206e1 00000000
[   25.787059] 5ca0: 00000000 000006e1 ec224000 ec224208 bf30f0b4 fa890420 00000004 ee2f5cd8
[   25.795643] 5cc0: bf30442c bf30443c a00f0093 ffffffff
[   25.800986] [<c0980cc4>] (__dabt_svc) from [<bf30443c>] (xhci_hub_control+0x9f4/0x1d50 [xhci_hcd])
[   25.810419] [<bf30443c>] (xhci_hub_control [xhci_hcd]) from [<c0706d40>] (usb_hcd_submit_urb+0x238/0x9b4)
[   25.820473] [<c0706d40>] (usb_hcd_submit_urb) from [<c0708da4>] (usb_start_wait_urb+0x44/0x138)
[   25.829609] [<c0708da4>] (usb_start_wait_urb) from [<c0708f34>] (usb_control_msg+0x9c/0xd0)
[   25.838387] [<c0708f34>] (usb_control_msg) from [<c06fda34>] (usb_clear_port_feature+0x44/0x4c)
[   25.847522] [<c06fda34>] (usb_clear_port_feature) from [<c06ffc64>] (hub_activate+0x314/0x688)
[   25.856565] [<c06ffc64>] (hub_activate) from [<c015afe4>] (process_one_work+0x248/0x79c)
[   25.865050] [<c015afe4>] (process_one_work) from [<c015c0d8>] (worker_thread+0x3c/0x4ec)
[   25.873544] [<c015c0d8>] (worker_thread) from [<c0161fa0>] (kthread+0x11c/0x160)
[   25.881309] [<c0161fa0>] (kthread) from [<c0108570>] (ret_from_fork+0x14/0x24)
[   25.888885] ---[ end trace c99598f673dd94c9 ]---

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
