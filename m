From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [4.8.0-rc1] am335x-evm boot failure: n_tty_receive_buf_common:
 "Unable to handle kernel paging request.."
Date: Mon, 12 Sep 2016 20:57:58 +0300
Message-ID: <b390ad7c-67df-ebaf-e7dc-917a9ad3cf9c@ti.com>
References: <87ceb885-94a6-b9b3-60b3-2017198c4338@ti.com>
 <CAALWOA_=9fMG156H_XSZBjeckQUK-moDWoRE6_kr-8=Z_-KZuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAALWOA_=9fMG156H_XSZBjeckQUK-moDWoRE6_kr-8=Z_-KZuA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Peter Hurley <peter@hurleysoftware.com>, Lokesh Vutla <lokeshvutla@ti.com>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Matthijs,

On 09/10/2016 01:23 AM, Matthijs van Duin wrote:
> If you look more carefully the first problem is actually a bus error:
> [ 15.776190] Unhandled fault: external abort on non-linefetch (0x1028)
> at 0xf9e3e044
> [ 15.825925] PC is at omap_hwmod_read+0x14/0x28
> [ 15.830583] LR is at omap_rtc_wait_not_busy+0x1c/0x44
> 
> I have no idea how the kernel manages to continue after a bus error in
> a driver (inside local_irq_disable even), but I wouldn't be inclined
> to take any later errors seriously.
> 
> See also the "4.8 crash on BeagleBone" thread on linux-omap.
> 

Thanks for your comments.

I knew about RTc problem with 4.8, so I've reported n_tty_receive_buf_common problem
"in advance" and waited for fix to be merged before re-testing it.


So, log is below and issue is still here in 4.8.0-rc6 :( Boot failed 10 times from 100.


Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.8.0-rc6-13910-g9395452 (lcpdbld@dflsdit-build06.dal.design.ti.com) (gcc version 4.9.3 20150413 (prerelease) (Linaro GCC 4.9-2015.05) ) #1 SMP Mon Sep 12 05:20:40 CDT 2016
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt:Machine model: TI AM335x EVM
[    0.000000] cma: Reserved 16 MiB at 0xbe800000
[    0.000000] Memory policy: Data cache writeback
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] AM335X ES2.1 (sgx neon )
[    0.000000] percpu: Embedded 15 pages/cpu @ef6b7000 s31168 r8192 d22080 u61440
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
[    0.000000]       .data : 0xc0c00000 - 0xc0cc11ac   ( 773 kB)
[    0.000000]        .bss : 0xc0cc3000 - 0xc14b1878   (8123 kB)
[    0.000000] Running RCU self tests
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU lockdep checking is enabled.
[    0.000000] 	Build-time adjustment of leaf fanout to 32.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=2 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 5.0) with 128 interrupts
[    0.000000] OMAP clockevent source: timer2 at 24000000 Hz
[    0.000019] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
[    0.000042] clocksource: timer1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
[    0.000094] OMAP clocksource: timer1 at 24000000 Hz
[    0.000653] clocksource_probe: no matching clocksources found
[    0.001585] Console: colour dummy device 80x30
[    0.001645] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.001655] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.001663] ... MAX_LOCK_DEPTH:          48
[    0.001671] ... MAX_LOCKDEP_KEYS:        8191
[    0.001679] ... CLASSHASH_SIZE:          4096
[    0.001687] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.001695] ... MAX_LOCKDEP_CHAINS:      65536
[    0.001702] ... CHAINHASH_SIZE:          32768
[    0.001711]  memory used by lock dependency info: 5167 kB
[    0.001719]  per task-struct memory footprint: 1536 bytes
[    0.001756] Calibrating delay loop... 996.14 BogoMIPS (lpj=4980736)
[    0.078616] pid_max: default: 32768 minimum: 301
[    0.079087] Security Framework initialized
[    0.079234] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.079251] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.082794] CPU: Testing write buffer coherency: ok
[    0.084361] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.084441] Setting up static identity map for 0x80100000 - 0x80100070
[    0.089124] Brought up 1 CPUs
[    0.089150] SMP: Total of 1 processors activated (996.14 BogoMIPS).
[    0.089161] CPU: All CPU(s) started in SVC mode.
[    0.093177] devtmpfs: initialized
[    0.137436] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
[    0.138367] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.140281] pinctrl core: initialized pinctrl subsystem
[    0.145507] NET: Registered protocol family 16
[    0.151271] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.199354] omap_hwmod: debugss: _wait_target_disable failed
[    0.251659] cpuidle: using governor menu
[    0.265457] OMAP GPIO hardware version 0.1
[    0.291518] omap-gpmc 50000000.gpmc: could not find pctldev for node /ocp/l4_wkup@44c00000/scm@210000/pinmux@800/nandflash_pins_s0, deferring probe
[    0.297679] No ATAGs?
[    0.297706] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.297958] omap4_sram_init:Unable to allocate sram needed to handle errata I688
[    0.297974] omap4_sram_init:Unable to get sram pool needed to handle errata I688
[    0.345358] edma 49000000.edma: TI EDMA DMA engine driver
[    0.352391] SCSI subsystem initialized
[    0.354164] omap_i2c 44e0b000.i2c: could not find pctldev for node /ocp/l4_wkup@44c00000/scm@210000/pinmux@800/pinmux_i2c0_pins, deferring probe
[    0.354281] omap_i2c 4802a000.i2c: could not find pctldev for node /ocp/l4_wkup@44c00000/scm@210000/pinmux@800/pinmux_i2c1_pins, deferring probe
[    0.354607] pps_core: LinuxPPS API ver. 1 registered
[    0.354620] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.354674] PTP clock support registered
[    0.359492] clocksource: Switched to clocksource timer1
[    0.463483] VFS: Disk quotas dquot_6.6.0
[    0.463673] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.496612] NET: Registered protocol family 2
[    0.498732] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.498901] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    0.501410] TCP: Hash tables configured (established 8192 bind 8192)
[    0.501734] UDP hash table entries: 512 (order: 3, 40960 bytes)
[    0.502061] UDP-Lite hash table entries: 512 (order: 3, 40960 bytes)
[    0.503022] NET: Registered protocol family 1
[    0.505158] RPC: Registered named UNIX socket transport module.
[    0.505186] RPC: Registered udp transport module.
[    0.505196] RPC: Registered tcp transport module.
[    0.505207] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.508251] hw perfevents: enabled with armv7_cortex_a8 PMU driver, 5 counters available
[    0.513177] futex hash table entries: 256 (order: 2, 16384 bytes)
[    0.513402] audit: initializing netlink subsys (disabled)
[    0.513663] audit: type=2000 audit(0.510:1): initialized
[    0.517866] workingset: timestamp_bits=14 max_order=18 bucket_order=4
[    0.521013] NFS: Registering the id_resolver key type
[    0.521391] Key type id_resolver registered
[    0.521409] Key type id_legacy registered
[    0.521572] jffs2: version 2.2. (NAND) (SUMMARY)   2001-2006 Red Hat, Inc.
[    0.527094] bounce: pool size: 64 pages
[    0.527269] io scheduler noop registered
[    0.527283] io scheduler deadline registered
[    0.527408] io scheduler cfq registered (default)
[    0.530203] pinctrl-single 44e10800.pinmux: 142 pins at pa f9e10800 size 568
[    0.534684] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.541159] omap_uart 44e09000.serial: no wakeirq for uart0
[    0.541880] 44e09000.serial: ttyO0 at MMIO 0x44e09000 (irq = 158, base_baud = 3000000) is a OMAP UART0
[    1.275391] console [ttyO0] enabled
[    1.281126] omap_uart 48022000.serial: no wakeirq for uart1
[    1.287365] 48022000.serial: ttyO1 at MMIO 0x48022000 (irq = 159, base_baud = 3000000) is a OMAP UART1
[    1.338657] brd: module loaded
[    1.367185] loop: module loaded
[    1.373352] mtdoops: mtd device (mtddev=name/number) must be supplied
[    1.383884] libphy: Fixed MDIO Bus: probed
[    1.459543] davinci_mdio 4a101000.mdio: davinci mdio revision 1.6
[    1.465952] davinci_mdio 4a101000.mdio: detected phy mask fffffffe
[    1.476726] libphy: 4a101000.mdio: probed
[    1.481137] davinci_mdio 4a101000.mdio: phy[0]: device 4a101000.mdio:00, driver Atheros 8031 ethernet
[    1.492442] cpsw 4a100000.ethernet: Detected MACID = c8:a0:30:a1:c2:d7
[    1.504676] mousedev: PS/2 mouse device common for all mice
[    1.510690] i2c /dev entries driver
[    1.516891] omap_hsmmc 48060000.mmc: Got CD GPIO
[    1.671388] ledtrig-cpu: registered to indicate activity on CPUs
[    1.679632] oprofile: using arm/armv7
[    1.684246] Initializing XFRM netlink socket
[    1.689112] NET: Registered protocol family 10
[    1.700808] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    1.709717] NET: Registered protocol family 17
[    1.714478] NET: Registered protocol family 15
[    1.719607] Key type dns_resolver registered
[    1.724306] omap_voltage_late_init: Voltage driver support not added
[    1.731044] sr_dev_init: No voltage domain specified for smartreflex0. Cannot initialize
[    1.739556] sr_dev_init: No voltage domain specified for smartreflex1. Cannot initialize
[    1.748791] ThumbEE CPU extension supported.
[    1.753396] Registering SWP/SWPB emulation handler
[    1.758421] SmartReflex Class3 initialized
[    1.764038] omap_hsmmc 47810000.mmc: card claims to support voltages below defined range
[    1.778738] omap-gpmc 50000000.gpmc: omap_device: omap_device_enable() called from invalid state 1
[    1.788330] omap-gpmc 50000000.gpmc: use pm_runtime_put_sync_suspend() in driver?
[    1.796265] omap-gpmc 50000000.gpmc: GPMC revision 6.0
[    1.801939] gpmc_mem_init: disabling cs 0 mapped at 0x0-0x1000000
[    1.813067] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xda
[    1.819934] nand: Micron MT29F2G08ABAEAWP
[    1.824144] nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
[    1.832203] nand: using OMAP_ECC_BCH8_CODE_HW ECC scheme
[    1.838097] 10 ofpart partitions found on MTD device 8000000.nand
[    1.844531] Creating 10 MTD partitions on "8000000.nand":
[    1.850242] 0x000000000000-0x000000020000 : "NAND.SPL"
[    1.864561] 0x000000020000-0x000000040000 : "NAND.SPL.backup1"
[    1.875983] 0x000000040000-0x000000060000 : "NAND.SPL.backup2"
[    1.887439] 0x000000060000-0x000000080000 : "NAND.SPL.backup3"
[    1.898545] 0x000000080000-0x0000000c0000 : "NAND.u-boot-spl-os"
[    1.909708] random: fast init done
[    1.917243] mmc0: new high speed SDIO card at address 0001
[    1.929183] 0x0000000c0000-0x0000001c0000 : "NAND.u-boot"
[    1.941324] 0x0000001c0000-0x0000001e0000 : "NAND.u-boot-env"
[    1.951872] 0x0000001e0000-0x000000200000 : "NAND.u-boot-env.backup1"
[    1.963047] 0x000000200000-0x000000a00000 : "NAND.kernel"
[    1.976300] 0x000000a00000-0x000010000000 : "NAND.file-system"
[    2.110733] tps65910 0-002d: No interrupt support, no core IRQ
[    2.121219] vrtc: supplied by vbat
[    2.131238] vio: supplied by vbat
[    2.137933] vdd1: supplied by vbat
[    2.145263] vdd2: supplied by vbat
[    2.155614] vdig1: supplied by vbat
[    2.162564] vdig2: supplied by vbat
[    2.169254] vpll: supplied by vbat
[    2.176017] vdac: supplied by vbat
[    2.182717] vaux1: supplied by vbat
[    2.189509] vaux2: supplied by vbat
[    2.196300] vaux33: supplied by vbat
[    2.203191] vmmc: supplied by vbat
[    2.209980] vbb: supplied by vbat
[    2.216430] omap_i2c 44e0b000.i2c: bus 0 rev0.11 at 400 kHz
[    2.227018] omap_i2c 4802a000.i2c: bus 1 rev0.11 at 100 kHz
[    2.234335] omap_hsmmc 48060000.mmc: Got CD GPIO
[    2.302447] hctosys: unable to open rtc device (rtc0)
[    2.307765] sr_init: No PMIC hook to init smartreflex
[    2.313456] sr_init: platform driver register failed for SR
[    2.350611] net eth0: initializing cpsw version 1.12 (0)
[    2.450430] Atheros 8031 ethernet 4a101000.mdio:00: attached PHY driver [Atheros 8031 ethernet] (mii_bus:phy_addr=4a101000.mdio:00, irq=-1)
[    2.463803] libphy: PHY 4a101000.mdio:01 not found
[    2.468834] net eth0: phy "4a101000.mdio:01" not found on slave 1, err -19
[    2.484836] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    2.499624] mmc1: host does not support reading read-only switch, assuming write-enable
[    2.510945] mmc1: new high speed SDHC card at address aaaa
[    2.520613] mmcblk1: mmc1:aaaa SU08G 7.40 GiB 
[    2.530180]  mmcblk1: p1 p2 p3
[    6.640484] cpsw 4a100000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
[    6.659633] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    6.689483] Sending DHCP requests ., OK
[    6.750215] IP-Config: Got DHCP answer from 192.168.1.254, my address is 192.168.1.190
[    6.759281] IP-Config: Complete:
[    6.762801]      device=eth0, hwaddr=c8:a0:30:a1:c2:d7, ipaddr=192.168.1.190, mask=255.255.255.0, gw=192.168.1.254
[    6.773684]      host=192.168.1.190, domain=tidfarm-02.internal.ti.com, nis-domain=(none)
[    6.782278]      bootserver=192.168.1.254, rootserver=192.168.1.254, rootpath=     nameserver0=192.0.2.2, nameserver1=192.0.2.3
[    6.794660] lis3_reg: disabling
[    6.797962] wlan-en-regulator: disabling
[    6.837717] VFS: Mounted root (nfs filesystem) on device 0:14.
[    6.846579] devtmpfs: mounted
[    6.852447] Freeing unused kernel memory: 1024K (c0b00000 - c0c00000)
[    7.402796] systemd[1]: System time before build time, advancing clock.
[    7.613300] systemd[1]: systemd 229 running in system mode. (+PAM -AUDIT -SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP -LIBCRYPTSETUP -GCRYPT -GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID -ELFUTILS +KMOD -IDN)
[    7.634620] systemd[1]: Detected architecture arm.

Welcome to [1mArago 2016.07[0m!

[    7.674036] systemd[1]: Set hostname to <am335x-evm>.
[    8.901409] systemd[1]: Reached target Remote File Systems.
[[0;32m  OK  [0m] Reached target Remote File Systems.
[    8.946707] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[[0;32m  OK  [0m] Listening on /dev/initctl Compatibility Named Pipe.
[    8.981758] systemd[1]: Listening on Journal Socket (/dev/log).
[[0;32m  OK  [0m] Listening on Journal Socket (/dev/log).
[    9.021277] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[[0;32m  OK  [0m] Started Dispatch Password Requests to Console Directory Watch.
[    9.059914] systemd[1]: Reached target Swap.
[[0;32m  OK  [0m] Reached target Swap.
[    9.092890] systemd[1]: Listening on udev Control Socket.
[[0;32m  OK  [0m] Listening on udev Control Socket.
[    9.131059] systemd[1]: Listening on Network Service Netlink Socket.
[[0;32m  OK  [0m] Listening on Network Service Netlink Socket.
[[0;32m  OK  [0m] Listening on Journal Audit Socket.
[[0;32m  OK  [0m] Listening on udev Kernel Socket.
[[0;32m  OK  [0m] Listening on Journal Socket.
[[0;32m  OK  [0m] Listening on Syslog Socket.
[[0;32m  OK  [0m] Created slice System Slice.
[[0;32m  OK  [0m] Created slice system-getty.slice.
         Mounting Temporary Directory...
         Starting Create list of required st... nodes for the current kernel...
         Starting Setup Virtual Console...
         Starting Remount Root and Kernel File Systems...
         Starting Load Kernel Modules...
         Mounting POSIX Message Queue File System...
         Mounting Debug File System...
[[0;32m  OK  [0m] Created slice User and Session Slice.
[[0;32m  OK  [0m] Reached target Slices.
         Starting Journal Service...
[[0;32m  OK  [0m] Started Forward Password Requests to Wall Directory Watch.
[[0;32m  OK  [0m] Reached target Paths.
[[0;32m  OK  [0m] Created slice system-serial\x2dgetty.slice.
[[0;32m  OK  [0m] Mounted Debug File System.
[[0;32m  OK  [0m] Mounted POSIX Message Queue File System.
[[0;32m  OK  [0m] Mounted Temporary Directory.
[[0;32m  OK  [0m] Started Create list of required sta...ce nodes for the current kernel.
[[0;32m  OK  [0m] Started Setup Virtual Console.
[[0;32m  OK  [0m] Started Remount Root and Kernel File Systems.
[[0;1;31mFAILED[0m] Failed to start Load Kernel Modules.
See 'systemctl status systemd-modules-load.service' for details.
[[0;32m  OK  [0m] Started Journal Service.
         Mounting Configuration File System...
         Starting Apply Kernel Variables...
         Starting udev Coldplug all Devices...
         Starting Flush Journal to Persistent Storage...
         Starting Create Static Device Nodes in /dev...
[[0;32m  OK  [0m] Mounted Configuration File System.
[[0;32m  OK  [0m] Started Apply Kernel Variables.
[   11.528911] systemd-journald[108]: Received request to flush runtime journal from PID 1
[[0;32m  OK  [0m] Started Flush Journal to Persistent Storage.
[[0;32m  OK  [0m] Started Create Static Device Nodes in /dev.
         Starting udev Kernel Device Manager...
[[0;32m  OK  [0m] Reached target Local File Systems (Pre).
         Mounting /var/volatile...
         Mounting /media/ram...
[[0;32m  OK  [0m] Mounted /var/volatile.
[[0;32m  OK  [0m] Mounted /media/ram.
         Starting Load/Save Random Seed...
[[0;32m  OK  [0m] Reached target Local File Systems.
         Starting Create Volatile Files and Directories...
[[0;32m  OK  [0m] Started udev Kernel Device Manager.
[[0;32m  OK  [0m] Started Load/Save Random Seed.
[[0;32m  OK  [0m] Started Create Volatile Files and Directories.
         Starting Update UTMP about System Boot/Shutdown...
         Starting Network Time Synchronization...
[[0;32m  OK  [0m] Started Update UTMP about System Boot/Shutdown.
[   14.259996] random: crng init done
[[0;32m  OK  [0m] Started Network Time Synchronization.
         Starting Synchronize System and HW clocks...
[[0;32m  OK  [0m] Reached target System Time Synchronized.
[[0;1;31mFAILED[0m] Failed to start Synchronize System and HW clocks.
See 'systemctl status sync-clocks.service' for details.
[   15.320043] backlight supply power not found, using dummy regulator
[   15.495920] input: matrix_keypad@0 as /devices/platform/matrix_keypad@0/input/input0
[   15.507099] backlight supply power not found, using dummy regulator
[   15.896508] omap_wdt: OMAP Watchdog Timer Rev 0x01: initial timeout 60 sec
[   15.905551] backlight supply power not found, using dummy regulator
[[0;32m  OK  [0m] Started udev Coldplug all Devices.
[   15.984386] backlight supply power not found, using dummy regulator
[[0;32m  OK  [0m] Reached target System Initialization.
[   16.070501] omap_rtc 44e3e000.rtc: rtc core: registered 44e3e000.rtc as rtc0
[[0;32m  OK  [0m] Listening on RPCbind Server Activation Socket.
[   16.081234] backlight supply power not found, using dummy regulator
[[0;32m  OK  [0m] Listening on D-Bus System Message Bus Socket.
[   16.245427] backlight supply power not found, using dummy regulator
[[0;32m  OK  [0m] Listening on dropbear.socket.
[[0;32m  OK  [0m] Reached target Sockets.
[[0;32m  OK  [0m] Reached target Basic System.
[[0;32m  OK  [0m] Started D-Bus System Message Bus.
[   17.805752] tsl2550 1-0039: standard operating mode
[   17.842234] tsl2550 1-0039: support ver. 1.2 enabled
[   17.848683] backlight supply power not found, using dummy regulator
[   17.886401] lis3lv02d: 16 bits lis331dlh sensor found
[   18.050713] input: ST LIS3LV02DL Accelerometer as /devices/platform/lis3lv02d/input/input1
[   18.121114] backlight supply power not found, using dummy regulator
[   18.482681] backlight supply power not found, using dummy regulator
[   18.654570] lm75 1-0048: hwmon0: sensor 'tmp275'
[   18.661075] backlight supply power not found, using dummy regulator
[   18.968529] omap_rng 48310000.rng: OMAP Random Number Generator ver. 20
[   18.976964] backlight supply power not found, using dummy regulator
[   19.201619] backlight supply power not found, using dummy regulator
[   19.323419] backlight supply power not found, using dummy regulator
         Starting Network Service...
         Starting Login Service...
         Starting Permit User Sessions...
[[0;32m  OK  [0m] Started System Logging Service.
         Starting Print notice about GPLv3 packages...
         Starting uim-sysfs.service...
[[0;32m  OK  [0m] Started Kernel Logging Service.
[[0;32m  OK  [0m] Started strongSwan IPsec IKEv1/IKEv2 daemon using ipsec.conf.
[[0;32m  OK  [0m] Started Daily Cleanup of Temporary Directories.
[[0;32m  OK  [0m] Reached target Timers.
[[0;32m  OK  [0m] Started Permit User Sessions.
[[0;32m  OK  [0m] Found device /dev/ttyO0.
[   25.250490] input: volume_keys@0 as /devices/platform/volume_keys@0/input/input2
[   25.808394] asoc-simple-card sound: tlv320aic3x-hifi <-> 4803c000.mcasp mapping ok
[[0;32m  OK  [0m] Started Network Service.
[   30.220412] EXT4-fs (mmcblk1p2): mounting ext3 file system using the ext4 subsystem
[   30.242502] EXT4-fs (mmcblk1p3): mounting ext3 file system using the ext4 subsystem
[   30.474149] EXT4-fs (mmcblk1p2): warning: maximal mount count reached, running e2fsck is recommended
[   30.488925] EXT4-fs (mmcblk1p3): warning: maximal mount count reached, running e2fsck is recommended
[   30.654914] EXT4-fs (mmcblk1p3): mounted filesystem with ordered data mode. Opts: (null)
[   30.668221] EXT4-fs (mmcblk1p2): mounted filesystem with ordered data mode. Opts: (null)
[   30.732853] FAT-fs (mmcblk1p1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[[0;32m  OK  [0m] Found device /dev/ttyS0.
[[0;32m  OK  [0m] Found device /dev/ttyS3.
[   35.870145] Unable to handle kernel paging request at virtual address 00002244
[   35.877743] pgd = c0004000
[   35.880736] [00002244] *pgd=00000000
[   35.884506] Internal error: Oops: 5 [#1] SMP ARM
[   35.889346] Modules linked in: snd_soc_simple_card snd_soc_simple_card_utils gpio_keys evdev snd_soc_davinci_mcasp snd_soc_omap snd_soc_tlv320aic3x snd_soc_edma pwm_tiecap snd_soc_core omap_rng rng_core lm75 thermal_sys wlcore_sdio snd_pcm_dmaengine hwmon snd_pcm lis3lv02d_i2c tsl2550 lis3lv02d input_polldev snd_timer snd soundcore musb_am335x rtc_omap ti_am335x_tscadc omap_wdt matrix_keypad matrix_keymap pwm_bl autofs4
[   35.928550] CPU: 0 PID: 172 Comm: kworker/u2:2 Not tainted 4.8.0-rc6-13910-g9395452 #1
[   35.936842] Hardware name: Generic AM33XX (Flattened Device Tree)
[   35.943250] Workqueue: events_unbound flush_to_ldisc
[   35.948456] task: ed8aa0c0 task.stack: ed86c000
[   35.953203] PC is at n_tty_receive_buf_common+0x48/0x9c8
[   35.958775] LR is at __bfs+0x160/0x294
[   35.962701] pc : [<c04fc740>]    lr : [<c018e930>]    psr: 80000013
[   35.962701] sp : ed86de28  ip : 0000009a  fp : edb9d400
[   35.974725] r10: c0cbe740  r9 : c0c029cc  r8 : ee814c24
[   35.980196] r7 : ed9703c0  r6 : ee814c00  r5 : ee814c04  r4 : 00000000
[   35.987033] r3 : 00002000  r2 : 00000000  r1 : 0000000e  r0 : 00000001
[   35.993871] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   36.001346] Control: 10c5387d  Table: add68019  DAC: 00000051
[   36.007364] Process kworker/u2:2 (pid: 172, stack limit = 0xed86c218)
[   36.014111] Stack: (0xed86de28 to 0xed86e000)
[   36.018678] de20:                   eda4ed18 00000100 eda4ec18 00000000 00000000 00002000
[   36.027248] de40: 00000001 00000000 edb9d6c4 ee836c00 ee838f00 edb9d530 c0c029cc eda4ec00
[   36.035818] de60: ee814c04 ee814c00 ed9703c0 ee814c24 c0c029cc c0cbe740 c0cbd983 c04fd0d4
[   36.044388] de80: 00000001 ee814c04 ee814c00 c04ff954 eef17100 ee814c04 ee836c00 ee838f00
[   36.052958] dea0: ed86dec8 c0154724 00000001 00000000 c015466c 00000008 00000000 00000000
[   36.061527] dec0: c0154cac 00000088 c1491624 c0e1a2c4 00000000 c09dcc7c eef17100 ee836c00
[   36.070097] dee0: eef17118 00000088 ee836c34 ed86c000 c0c02100 ee836c00 eef17100 c0154c38
[   36.078666] df00: eefbcdc0 eef17100 c0154c00 00000000 eefbcdc0 eef17100 c0154c00 00000000
[   36.087236] df20: 00000000 00000000 00000000 c015ac80 c0c029cc 00000000 00000000 eef17100
[   36.095805] df40: 00000000 00000000 dead4ead ffffffff ffffffff c0cc4e74 00000000 00000000
[   36.104376] df60: c099e8ec ed86df64 ed86df64 00000000 00000000 dead4ead ffffffff ffffffff
[   36.112945] df80: c0cc4e74 00000000 00000000 c099e8ec ed86df90 ed86df90 eefbcdc0 eefbcdc0
[   36.121514] dfa0: c015abac 00000000 00000000 c01078f0 00000000 00000000 00000000 00000000
[   36.130084] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   36.138653] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[   36.147235] [<c04fc740>] (n_tty_receive_buf_common) from [<c04fd0d4>] (n_tty_receive_buf2+0x14/0x1c)
[   36.156806] [<c04fd0d4>] (n_tty_receive_buf2) from [<c04ff954>] (flush_to_ldisc+0xc4/0xdc)
[   36.165481] [<c04ff954>] (flush_to_ldisc) from [<c0154724>] (process_one_work+0x1e0/0x6bc)
[   36.174146] [<c0154724>] (process_one_work) from [<c0154c38>] (worker_thread+0x38/0x4d0)
[   36.182632] [<c0154c38>] (worker_thread) from [<c015ac80>] (kthread+0xd4/0xf0)
[   36.190211] [<c015ac80>] (kthread) from [<c01078f0>] (ret_from_fork+0x14/0x24)
[   36.197783] Code: e58d3014 e28b3fb1 e58d3020 e59d3014 (e5931244) 
[   36.204499] ---[ end trace d359ab6fc09c1b55 ]---

-- 
regards,
-grygorii
