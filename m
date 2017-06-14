From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: possible xhci bug on linux-next
Date: Wed, 14 Jun 2017 20:35:02 +0300
Message-ID: <87h8zi4gmx.fsf@linux.intel.com>
References: <e63a40e3-3f39-0935-9da8-0fcd2b65b6f7@ti.com> <8b2647d6-1dfe-6359-b4d3-8923e549a91b@ti.com> <5941464C.4090105@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5941464C.4090105-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Carlos Hernandez <ceh-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


Hi,

(Carlos, please Cc linux-omap on things related to OMAP :-)

Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:

> Adding Felipe,
>
> First warning is when dwc3_omap requests threaded irq
>
> On 14.06.2017 16:03, Carlos Hernandez wrote:
>> linux-next fails to boot due to what appears to be a xhci bug. Problem observed at least on am57xx-evm, dra72x-evm and dra7xx-evm. According to Tony Lindgren the issue is marking a shared interrupt disabled on start-up.
>>
>> [    0.000000] Booting Linux on physical CPU 0x0
>> [    0.000000] Linux version 4.12.0-rc5-next-20170613 (lcpdbld-pmn0CehDYT60De/e2gt5q7+mxzcB8iz6S6/c0EnIpHkAvxtiuMwx3w@public.gmane.org) (gcc version 6.2.1 20161016 (Linaro GCC 6.2-2016.11) ) #2 SMP Tue Jun 13 13:52:56 CDT 2017
>> [    0.000000] CPU: ARMv7 Processor [412fc0f2] revision 2 (ARMv7), cr=10c5387d
>> [    0.000000] CPU: div instructions available: patching division code
>> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
>> [    0.000000] OF: fdt: Machine model: TI AM5728 BeagleBoard-X15
>> [    0.000000] Memory policy: Data cache writealloc
>> [    0.000000] cma: Reserved 24 MiB at 0xfe000000
>> [    0.000000] OMAP4: Map 0xffd00000 to fe600000 for dram barrier
>> [    0.000000] DRA752 ES1.1
>> [    0.000000] percpu: Embedded 17 pages/cpu @eed82000 s40936 r8192 d20504 u69632
>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 522047
>> [    0.000000] Kernel command line: console=ttyO2,115200n8  earlyprintk=serial,ttyO2,115200n8 rootwait sysrq_always_enabled  ip=:::::eth0:dhcp  root=/dev/nfs rw nfsroot=192.168.0.1:/home/tigtfarm03/NFS_exports/am57xx-evm1//autofs/d3fd317ecf18e621cf951fd5ef72179d,nolock,v3,tcp,rsize=4096,wsize=4096
>> [    0.000000] sysrq: sysrq always enabled.
>> [    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
>> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
>> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
>> [    0.000000] Memory: 2025704K/2095100K available (9216K kernel code, 892K rwdata, 3176K rodata, 2048K init, 8710K bss, 44820K reserved, 24576K cma-reserved, 1284092K highmem)
>> [    0.000000] Virtual kernel memory layout:
>> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
>> [    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
>> [    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
>> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
>> [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
>> [    0.000000]       .text : 0xc0008000 - 0xc0a00000   (10208 kB)
>> [    0.000000]       .init : 0xc0e00000 - 0xc1000000   (2048 kB)
>> [    0.000000]       .data : 0xc1000000 - 0xc10df398   ( 893 kB)
>> [    0.000000]        .bss : 0xc10e90d0 - 0xc196aa80   (8711 kB)
>> [    0.000000] Running RCU self tests
>> [    0.000000] Hierarchical RCU implementation.
>> [    0.000000] 	RCU event tracing is enabled.
>> [    0.000000] 	RCU lockdep checking is enabled.
>> [    0.000000] 	RCU callback double-/use-after-free debug enabled.
>> [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
>> [    0.000000] GIC: Using split EOI/Deactivate mode
>> [    0.000000] kmemleak: Kernel memory leak detector disabled
>> [    0.000000] OMAP clockevent source: timer1 at 32786 Hz
>> [    0.000000] arch_timer: cp15 timer(s) running at 6.14MHz (phys).
>> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x16af5adb9, max_idle_ns: 440795202250 ns
>> [    0.000006] sched_clock: 56 bits at 6MHz, resolution 162ns, wraps every 4398046511023ns
>> [    0.000025] Switching to timer-based delay loop, resolution 162ns
>> [    0.000458] clocksource: 32k_counter: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 58327039986419 ns
>> [    0.000474] OMAP clocksource: 32k_counter at 32768 Hz
>> [    0.001737] Console: colour dummy device 80x30
>> [    0.001770] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
>> [    0.001785] ... MAX_LOCKDEP_SUBCLASSES:  8
>> [    0.001799] ... MAX_LOCK_DEPTH:          48
>> [    0.001813] ... MAX_LOCKDEP_KEYS:        8191
>> [    0.001826] ... CLASSHASH_SIZE:          4096
>> [    0.001840] ... MAX_LOCKDEP_ENTRIES:     32768
>> [    0.001854] ... MAX_LOCKDEP_CHAINS:      65536
>> [    0.001867] ... CHAINHASH_SIZE:          32768
>> [    0.001880]  memory used by lock dependency info: 5167 kB
>> [    0.001894]  per task-struct memory footprint: 1536 bytes
>> [    0.003715] kmemleak: Early log buffer exceeded (9401), please increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE
>> [    0.003751] Calibrating delay loop (skipped), value calculated using timer frequency.. 12.29 BogoMIPS (lpj=61475)
>> [    0.003779] pid_max: default: 32768 minimum: 301
>> [    0.004258] Security Framework initialized
>> [    0.004448] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
>> [    0.004469] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
>> [    0.007060] CPU: Testing write buffer coherency: ok
>> [    0.008191] /cpus/cpu@0 missing clock-frequency property
>> [    0.008222] /cpus/cpu@1 missing clock-frequency property
>> [    0.008241] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
>> [    0.009506] Setting up static identity map for 0x80100000 - 0x80100078
>> [    0.010150] Hierarchical SRCU implementation.
>> [    0.014576] smp: Bringing up secondary CPUs ...
>> [    0.017491] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
>> [    0.017994] smp: Brought up 1 node, 2 CPUs
>> [    0.018018] SMP: Total of 2 processors activated (24.59 BogoMIPS).
>> [    0.018033] CPU: All CPU(s) started in HYP mode.
>> [    0.018048] CPU: Virtualization extensions available.
>> [    0.021157] devtmpfs: initialized
>> [    0.115329] VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
>> [    0.129387] DMA-API: preallocated 4096 debug entries
>> [    0.129407] DMA-API: debugging enabled by kernel config
>> [    0.131620] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
>> [    0.131664] futex hash table entries: 512 (order: 3, 32768 bytes)
>> [    0.132699] pinctrl core: initialized pinctrl subsystem
>> [    0.135884] random: bucket_table_alloc+0xdc/0x264 get_random_u32 called with crng_init=0
>> [    0.136877] NET: Registered protocol family 16
>> [    0.142135] DMA: preallocated 256 KiB pool for atomic coherent allocations
>> [    0.144058] omap_hwmod: l3_main_2 using broken dt data from ocp
>> [    0.360899] omap_hwmod: dcan1: _wait_target_disable failed
>> [    0.463711] cpuidle: using governor menu
>> [    0.487948] OMAP GPIO hardware version 0.1
>> [    0.570353] No ATAGs?
>> [    0.570704] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
>> [    0.570745] hw-breakpoint: maximum watchpoint size is 8 bytes.
>> [    0.571283] omap4_sram_init:Unable to allocate sram needed to handle errata I688
>> [    0.571302] omap4_sram_init:Unable to get sram pool needed to handle errata I688
>> [    0.573251] OMAP DMA hardware revision 0.0
>> [    0.638304] omap-dma-engine 4a056000.dma-controller: OMAP DMA engine driver (LinkedList1/2/3 supported)
>> [    0.640377] edma 43300000.edma: memcpy is disabled
>> [    0.656606] edma 43300000.edma: TI EDMA DMA engine driver
>> [    0.666620] vgaarb: loaded
>> [    0.667938] SCSI subsystem initialized
>> [    0.668764] usbcore: registered new interface driver usbfs
>> [    0.668975] usbcore: registered new interface driver hub
>> [    0.669141] usbcore: registered new device driver usb
>> [    0.671494] palmas 0-0058: Irq flag is 0x00000008
>> [    0.706454] palmas 0-0058: Muxing GPIO 2f, PWM 0, LED 0
>> [    0.709818] SMPS12: supplied by regulator-dummy
>> [    0.713508] SMPS3: supplied by regulator-dummy
>> [    0.717008] SMPS45: supplied by regulator-dummy
>> [    0.720716] SMPS6: supplied by regulator-dummy
>> [    0.723779] SMPS7: supplied by regulator-dummy
>> [    0.726799] SMPS8: supplied by regulator-dummy
>> [    0.729533] SMPS9: supplied by regulator-dummy
>> [    0.731258] LDO1: supplied by regulator-dummy
>> [    0.743992] LDO2: supplied by regulator-dummy
>> [    0.744415] random: fast init done
>> [    0.753686] LDO3: supplied by regulator-dummy
>> [    0.763738] LDO4: supplied by regulator-dummy
>> [    0.773768] LDO5: supplied by regulator-dummy
>> [    0.775553] LDO6: supplied by regulator-dummy
>> [    0.777304] LDO7: supplied by regulator-dummy
>> [    0.779055] LDO8: supplied by regulator-dummy
>> [    0.780824] LDO9: supplied by regulator-dummy
>> [    0.783871] LDOLN: supplied by regulator-dummy
>> [    0.793874] LDOUSB: supplied by regulator-dummy
>> [    0.811399] omap_i2c 48070000.i2c: bus 0 rev0.12 at 400 kHz
>> [    0.812924] omap_i2c 48060000.i2c: bus 2 rev0.12 at 400 kHz
>> [    0.813208] media: Linux media interface: v0.10
>> [    0.813391] Linux video capture interface: v2.00
>> [    0.813715] pps_core: LinuxPPS API ver. 1 registered
>> [    0.813731] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti<giometti-k2GhghHVRtY@public.gmane.org>
>> [    0.813808] PTP clock support registered
>> [    0.814947] Advanced Linux Sound Architecture Driver Initialized.
>> [    0.818041] clocksource: Switched to clocksource arch_sys_counter
>> [    0.974543] VFS: Disk quotas dquot_6.6.0
>> [    0.974759] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
>> [    1.007275] NET: Registered protocol family 2
>> [    1.009346] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
>> [    1.009867] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
>> [    1.012573] TCP: Hash tables configured (established 8192 bind 8192)
>> [    1.013223] UDP hash table entries: 512 (order: 3, 40960 bytes)
>> [    1.013616] UDP-Lite hash table entries: 512 (order: 3, 40960 bytes)
>> [    1.014723] NET: Registered protocol family 1
>> [    1.016098] RPC: Registered named UNIX socket transport module.
>> [    1.016131] RPC: Registered udp transport module.
>> [    1.016148] RPC: Registered tcp transport module.
>> [    1.016164] RPC: Registered tcp NFSv4.1 backchannel transport module.
>> [    1.019490] hw perfevents: no interrupt-affinity property for /pmu, guessing.
>> [    1.020092] hw perfevents: enabled with armv7_cortex_a15 PMU driver, 7 counters available
>> [    1.026192] audit: initializing netlink subsys (disabled)
>> [    1.027211] audit: type=2000 audit(1.019:1): state=initialized audit_enabled=0 res=1
>> [    1.029541] workingset: timestamp_bits=14 max_order=19 bucket_order=5
>> [    1.032776] NFS: Registering the id_resolver key type
>> [    1.033061] Key type id_resolver registered
>> [    1.033094] Key type id_legacy registered
>> [    1.033251] jffs2: version 2.2. (NAND) (SUMMARY)   2001-2006 Red Hat, Inc.
>> [    1.046352] bounce: pool size: 64 pages
>> [    1.046425] io scheduler noop registered
>> [    1.046444] io scheduler deadline registered
>> [    1.046553] io scheduler cfq registered (default)
>> [    1.046571] io scheduler mq-deadline registered
>> [    1.046588] io scheduler kyber registered
>> [    1.063190] pinctrl-single 4a003400.pinmux: 282 pins at pa fc003400 size 1128
>> [    1.070282] vdd_3v3: supplied by regen1
>> [    1.071107] aic_dvdd_fixed: supplied by vdd_3v3
>> [    1.071370] vtt_fixed: supplied by smps3
>> [    1.077132] Serial: 8250/16550 driver, 6 ports, IRQ sharing enabled
>> [    1.083973] irq: no irq domain found for /ocp/l4@4a000000/scm@2000/pinmux@1400 !
>> [    1.084032] omap_uart 48020000.serial: no wakeirq for uart2
>> [    1.084250] 48020000.serial: ttyO2 at MMIO 0x48020000 (irq = 301, base_baud = 3000000) is a OMAP UART2
>> [    2.090365] console [ttyO2] enabled
>> [    2.099791] DSS: OMAP DSS rev 6.1
>> [    2.104788] omapdss_dss 58000000.dss: bound 58001000.dispc (ops dispc_component_ops)
>> [    2.114581] omapdss_dss 58000000.dss: bound 58040000.encoder (ops hdmi5_component_ops)
>> [    2.159335] brd: module loaded
>> [    2.190520] loop: module loaded
>> [    2.196496] mtdoops: mtd device (mtddev=name/number) must be supplied
>> [    2.207155] libphy: Fixed MDIO Bus: probed
>> [    2.278048] davinci_mdio 48485000.mdio: davinci mdio revision 1.6
>> [    2.284482] libphy: 48485000.mdio: probed
>> [    2.296078] davinci_mdio 48485000.mdio: phy[1]: device 48485000.mdio:01, driver Micrel KSZ9031 Gigabit PHY
>> [    2.306253] davinci_mdio 48485000.mdio: phy[2]: device 48485000.mdio:02, driver Micrel KSZ9031 Gigabit PHY
>> [    2.317486] cpsw 48484000.ethernet: Detected MACID = 74:da:ea:08:38:a8
>> [    2.324677] cpsw 48484000.ethernet: cpts: overflow check period 500 (jiffies)
>> [    2.336058] cpsw 48484000.ethernet: cpsw: Detected MACID = 74:da:ea:08:38:a9
>> [    2.347002] usbcore: registered new interface driver smsc95xx
>> [    2.353079] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>> [    2.359997] ehci-pci: EHCI PCI platform driver
>> [    2.364783] i2c /dev entries driver
>> [    2.373300] omap_hsmmc 4809c000.mmc: Got CD GPIO
>> [    2.499009] ledtrig-cpu: registered to indicate activity on CPUs
>> [    2.514843] oprofile: using timer interrupt.
>> [    2.519875] Initializing XFRM netlink socket
>> [    2.524833] NET: Registered protocol family 10
>> [    2.532426] Segment Routing with IPv6
>> [    2.536370] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
>> [    2.544657] NET: Registered protocol family 17
>> [    2.549414] NET: Registered protocol family 15
>> [    2.554332] Key type dns_resolver registered
>> [    2.558999] omap_voltage_late_init: Voltage driver support not added
>> [    2.559177] mmc0: host does not support reading read-only switch, assuming write-enable
>> [    2.563192] mmc0: new high speed SD card at address aaaa
>> [    2.566497] mmcblk0: mmc0:aaaa SU02G 1.84 GiB
>> [    2.577548]  mmcblk0: p1 p2 p3
>> [    2.580556] mmc1: new high speed MMC card at address 0001
>> [    2.583196] mmcblk1: mmc1:0001 S10004 3.56 GiB
>> [    2.585493] mmcblk1boot0: mmc1:0001 S10004 partition 1 4.00 MiB
>> [    2.587422] mmcblk1boot1: mmc1:0001 S10004 partition 2 4.00 MiB
>> [    2.590935]  mmcblk1: p1 p2 p3
>> [    2.615125] sr_dev_init: Unable to get voltage domain pointer for VDD core
>> [    2.622382] sr_dev_init: Unable to get voltage domain pointer for VDD mpu
>> [    2.629870] Power Management for TI OMAP4+ devices.
>> [    2.635336] ThumbEE CPU extension supported.
>> [    2.639884] Registering SWP/SWPB emulation handler
>> [    2.644919] SmartReflex Class3 initialized
>> [    2.724599] dmm 4e000000.dmm: initialized all PAT entries
>> [    2.732904] hctosys: unable to open rtc device (rtc0)
>> [    2.738283] sr_init: No PMIC hook to init smartreflex
>> [    2.743873] sr_init: platform driver register failed for SR
>> [    2.754468] net eth0: initializing cpsw version 1.15 (0)
>> [    2.760569] cpsw 48484000.ethernet: initialized cpsw ale version 1.4
>> [    2.767247] cpsw 48484000.ethernet: ALE Table size 1024
>> [    2.888515] Micrel KSZ9031 Gigabit PHY 48485000.mdio:01: attached PHY driver [Micrel KSZ9031 Gigabit PHY] (mii_bus:phy_addr=48485000.mdio:01, irq=-1)
>> [    2.915138] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
>> [    7.126748] cpsw 48484000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
>> [    7.148103] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
>> [    7.178039] Sending DHCP requests ., OK
>> [    7.222175] IP-Config: Got DHCP answer from 192.168.0.1, my address is 192.168.0.254
>> [    7.230732] IP-Config: Complete:
>> [    7.234132]      device=eth0, hwaddr=74:da:ea:08:38:a8, ipaddr=192.168.0.254, mask=255.255.255.0, gw=192.168.0.1
>> [    7.244854]      host=192.168.0.254, domain=ti.com, nis-domain=(none)
>> [    7.251655]      bootserver=0.0.0.0, rootserver=192.168.0.1, rootpath=     nameserver0=192.0.2.2, nameserver1=192.0.2.3
>> [    7.264251] aic_dvdd_fixed: disabling
>> [    7.268988] ldousb: disabling
>> [    7.272554] ALSA device list:
>> [    7.275666]   No soundcards found.
>> [    7.302714] VFS: Mounted root (nfs filesystem) on device 0:14.
>> [    7.310261] devtmpfs: mounted
>> [    7.315848] Freeing unused kernel memory: 2048K
>> [    7.964899] systemd[1]: System time before build time, advancing clock.
>> [    8.239248] systemd[1]: systemd 229 running in system mode. (+PAM -AUDIT -SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP -LIBCRYPTSETUP -GCRYPT -GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID -ELFUTILS +KMOD -IDN)
>> [    8.260258] systemd[1]: Detected architecture arm.
>>
>> Welcome to [1mArago 2016.12[0m!
>>
>> [    8.308145] systemd[1]: Set hostname to <am57xx-evm>.
>> [    9.235023] systemd[1]: alignment.service: Found ordering cycle on alignment.service/start
>> [    9.243803] systemd[1]: alignment.service: Found dependency on sysinit.target/start
>> [    9.251985] systemd[1]: alignment.service: Found dependency on alignment.service/start
>> [    9.260359] systemd[1]: alignment.service: Breaking ordering cycle by deleting job alignment.service/start
>> [    9.270550] systemd[1]: alignment.service: Job alignment.service/start deleted to break ordering cycle starting with alignment.service/start
>> [[0;1;31m SKIP [0m] Ordering cycle found, skipping alignment.service
>> [    9.321638] systemd[1]: Reached target Swap.
>> [[0;32m  OK  [0m] Reached target Swap.
>> [    9.351373] systemd[1]: Listening on Journal Socket (/dev/log).
>> [[0;32m  OK  [0m] Listening on Journal Socket (/dev/log).
>> [[0;32m  OK  [0m] Listening on Syslog Socket.
>> [[0;32m  OK  [0m] Listening on Network Service Netlink Socket.
>> [[0;32m  OK  [0m] Created slice System Slice.
>> [[0;32m  OK  [0m] Created slice system-serial\x2dgetty.slice.
>> [[0;32m  OK  [0m] Listening on Journal Socket.
>>           Mounting Temporary Directory...
>>           Starting Setup Virtual Console...
>> [[0;32m  OK  [0m] Listening on Journal Audit Socket.
>>           Mounting Debug File System...
>>           Starting Load Kernel Modules...
>>           Starting Create list of required st... nodes for the current kernel...
>> [[0;32m  OK  [0m] Started Forward Password Requests to Wall Directory Watch.
>>           Mounting POSIX Message Queue File System...
>> [[0;32m  OK  [0m] Started Dispatch Password Requests to Console Directory Watch.
>> [[0;32m  OK  [0m] Reached target Paths.
>> [[0;32m  OK  [0m] Created slice User and Session Slice.
>> [[0;32m  OK  [0m] Reached target Slices.
>>           Starting Journal Service...
>>           Starting Remount Root and Kernel File Systems...
>> [[0;32m  OK  [0m] Listening on /dev/initctl Compatibility Named Pipe.
>> [[0;32m  OK  [0m] Listening on udev Control Socket.
>> [[0;32m  OK  [0m] Created slice system-getty.slice.
>> [[0;32m  OK  [0m] Reached target Remote File Systems.
>> [[0;32m  OK  [0m] Listening on udev Kernel Socket.
>> [[0;32m  OK  [0m] Mounted Debug File System.
>> [[0;32m  OK  [0m] Mounted POSIX Message Queue File System.
>> [[0;32m  OK  [0m] Mounted Temporary Directory.
>> [[0;32m  OK  [0m] Started Setup Virtual Console.
>> [[0;1;31mFAILED[0m] Failed to start Load Kernel Modules.
>> See 'systemctl status systemd-modules-load.service' for details.
>> [[0;32m  OK  [0m] Started Create list of required sta...ce nodes for the current kernel.
>> [[0;32m  OK  [0m] Started Remount Root and Kernel File Systems.
>> [[0;32m  OK  [0m] Started Journal Service.
>>           Starting Flush Journal to Persistent Storage...
>>           Starting udev Coldplug all Devices...
>>           Starting Create Static Device Nodes in /dev...
>>           Starting Apply Kernel Variables...
>>           Mounting Configuration File System...
>> [[0;32m  OK  [0m] Mounted Configuration File System.
>> [[0;32m  OK  [0m] Started Apply Kernel Variables.
>> [[0;32m  OK  [0m] Started Create Static Device Nodes in /dev.
>> [   11.163765] systemd-journald[121]: Received request to flush runtime journal from PID 1
>>           Starting udev Kernel Device Manager...
>> [[0;32m  OK  [0m] Reached target Local File Systems (Pre).
>>           Mounting /media/ram...
>>           Mounting /var/volatile...
>> [[0;32m  OK  [0m] Mounted /media/ram.
>> [[0;32m  OK  [0m] Mounted /var/volatile.
>> [[0;32m  OK  [0m] Started Flush Journal to Persistent Storage.
>> [[0;32m  OK  [0m] Started udev Kernel Device Manager.
>>           Starting Load/Save Random Seed...
>> [[0;32m  OK  [0m] Reached target Local File Systems.
>>           Starting Create Volatile Files and Directories...
>> [[0;32m  OK  [0m] Started Load/Save Random Seed.
>> [[0;32m  OK  [0m] Started Create Volatile Files and Directories.
>>           Starting Network Time Synchronization...
>>           Starting Update UTMP about System Boot/Shutdown...
>> [[0;32m  OK  [0m] Started Update UTMP about System Boot/Shutdown.
>> [[0;32m  OK  [0m] Started Network Time Synchronization.
>>           Starting Synchronize System and HW clocks...
>> [[0;32m  OK  [0m] Reached target System Time Synchronized.
>> [[0;1;31mFAILED[0m] Failed to start Synchronize System and HW clocks.
>> See 'systemctl status sync-clocks.service' for details.
>> [[0;32m  OK  [0m] Started udev Coldplug all Devices.
>> [[0;32m  OK  [0m] Reached target System Initialization.
>> [[0;32m  OK  [0m] Listening on RPCbind Server Activation Socket.
>> [[0;32m  OK  [0m] Listening on D-Bus System Message Bus Socket.
>> [[0;32m  OK  [0m] Listening on dropbear.socket.
>> [[0;32m  OK  [0m] Listening on Avahi mDNS/DNS-SD Stack Activation Socket.
>> [[0;32m  OK  [0m] Reached target Sockets.
>> [[0;32m  OK  [0m] Reached target Basic System.
>> [   14.461422] omap_rng 48090000.rng: Random Number Generator ver. 20
>>           Starting Avahi mDNS/DNS-SD Stack...
>> [[0;32m  OK  [0m] Started Kernel Logging Service.
>> [   14.609412] random: crng init done
>> [[0;32m  OK  [0m] Started strongSwan IPsec IKEv1/IKEv2 daemon using ipsec.conf.
>> [   14.649949] tmp102 0-0048: initialized
>> [   14.669843] palmas-rtc 48070000.i2c:tps659038@58:tps659038_rtc: rtc core: registered 48070000.i2c:tps659038@58:tps659038_rtc as rtc1
>> [   14.719104] at24 0-0050: 4096 byte 24c32 EEPROM, writable, 1 bytes/write
>>           Starting Telephony service...
>> [   14.942173] palmas_pwrbutton 48070000.i2c:tps659038@58:tps659038_pwr_button: h/w controlled shutdown duration=12 seconds
>> [[0;32m  OK  [0m] Started System Logging Service.
>> [   15.004361] input: palmas_pwron as /devices/platform/44000000.ocp/48070000.i2c/i2c-0/0-0058/48070000.i2c:tps659038@58:tps659038_pwr_button/input/input0
>> [   15.137288] mmcblk0: error -5 sending stop command, original cmd response 0x900, card status 0x900
>> [   15.137298] mmcblk0: error -5 transferring data, sector 3862520, nr 8, cmd response 0x900, card status 0x80000b00

hmmm, what are these? Seems like there are other problems going on.

>> [[0;32m  OK  [0m] Started D-Bus System Message Bus.
>> [   15.630788] omap_rtc 48838000.rtc: rtc core: registered 48838000.rtc as rtc2
>> [   15.802521] ------------[ cut here ]------------
>> [   15.807559] WARNING: CPU: 1 PID: 180 at kernel/irq/manage.c:1346 __setup_irq+0x5bc/0x638

xhci is a child of dwc3, so if dwc3 fails, xhci will fail too. The funny
thing is that this is failing to request the dwc3-omap IRQ, not dwc3
core. So I can't really help much.

See if -rc5 vanilla (not next) works, then bisect.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
