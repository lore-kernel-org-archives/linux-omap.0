From: Felipe Balbi <balbi@ti.com>
Subject: regression with today's linux-next
Date: Wed, 13 May 2015 13:27:38 -0500
Message-ID: <20150513182738.GA28201@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59637 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752183AbbEMS36 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 May 2015 14:29:58 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Duyck <alexander.h.duyck@redhat.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

your commit 9451980a6646 (net: Use cached copy of pfmemalloc to avoid
accessing page) regresses most OMAP-based boards with a NULL pointer
dereference.

Below you can find git bisect log and a serial console capture of the
problem.

-- git bisect log --

git bisect start
# good: [030bbdbf4c833bc69f502eae58498bc5572db736] Linux 4.1-rc3
git bisect good 030bbdbf4c833bc69f502eae58498bc5572db736
# bad: [b8c256259dfc016a70982a72b0307c3ff759c34f] Add linux-next specific f=
iles for 20150513
git bisect bad b8c256259dfc016a70982a72b0307c3ff759c34f
# bad: [3b133f071f4305bab3e5b811d42e055a60a13afa] Merge remote-tracking bra=
nch 'drm/drm-next'
git bisect bad 3b133f071f4305bab3e5b811d42e055a60a13afa
# good: [6734afa74122f4d23d6b2fb3c6c27be75a0adbe5] Merge remote-tracking br=
anch 'hwmon-staging/hwmon-next'
git bisect good 6734afa74122f4d23d6b2fb3c6c27be75a0adbe5
# bad: [e05b81f04521ad5ea1af66118b2f21c9b73dd3c1] Merge remote-tracking bra=
nch 'net-next/master'
git bisect bad e05b81f04521ad5ea1af66118b2f21c9b73dd3c1
# good: [01319b2ca29a7d5686d300d8d4f53579d4b42fa5] Merge remote-tracking br=
anch 'thermal/next'
git bisect good 01319b2ca29a7d5686d300d8d4f53579d4b42fa5
# good: [82ae9c6060c6dbaf103273a5c51b8f58b951d9a2] Merge branch 'tcp-more-r=
eliable-window-probes'
git bisect good 82ae9c6060c6dbaf103273a5c51b8f58b951d9a2
# good: [3bb45001ac33b4f733e1e8ffb01fb07baccd528c] Merge branch 'handle_ing=
_lightweight'
git bisect good 3bb45001ac33b4f733e1e8ffb01fb07baccd528c
# good: [217c62801f9d4c736806c753cc7d9ab12bd898fe] Merge remote-tracking br=
anch 'slave-dma/next'
git bisect good 217c62801f9d4c736806c753cc7d9ab12bd898fe
# bad: [f8e20a9f87d33865cc1d67f13da0db8d457fc3c9] switchdev: convert parent=
_id_get to switchdev attr get
git bisect bad f8e20a9f87d33865cc1d67f13da0db8d457fc3c9
# bad: [7d525c4edf10e3dc334347f39da74b53a18e21ca] netcp: Replace put_page(v=
irt_to_head_page(ptr)) w/ skb_free_frag
git bisect bad 7d525c4edf10e3dc334347f39da74b53a18e21ca
# bad: [9451980a6646ed487efce04a9df28f450935683e] net: Use cached copy of p=
fmemalloc to avoid accessing page
git bisect bad 9451980a6646ed487efce04a9df28f450935683e
# good: [db65f35f50e031ed5a37e2a92f8e8627ff39df9f] net: fec: add support of=
 ethtool get_regs
git bisect good db65f35f50e031ed5a37e2a92f8e8627ff39df9f
# good: [b396cca6fafccf16206a5d041d59c9e6b65b6f5a] net: sched: deprecate en=
queue_root()
git bisect good b396cca6fafccf16206a5d041d59c9e6b65b6f5a
# first bad commit: [9451980a6646ed487efce04a9df28f450935683e] net: Use cac=
hed copy of pfmemalloc to avoid accessing page

-- serial console --

U-Boot SPL 2014.07-00037-g18637f496efe (May 04 2015 - 11:49:59)
Error: NAND flash not present on this board
SPL: Please implement spl_start_uboot() for your board
SPL: Direct Linux boot not active!
reading u-boot.img
reading u-boot.img


U-Boot 2014.07-00037-g18637f496efe (May 04 2015 - 11:49:59)

I2C:   ready
DRAM:  1 GiB
NAND:  0 MiB
MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
reading uboot.env
Net:   cpsw, usb_ether
Hit any key to stop autoboot:  6 =08=08=08 5 =08=08=08 4 =08=08=08 3 =08=08=
=08 2 =08=08=08 1 =08=08=08 0=20
cpsw Waiting for PHY auto negotiation to complete.. done
link up on port 0, speed 1000, full duplex
Using cpsw device
File transfer via NFS from server 10.0.1.2; our IP address is 10.0.1.100
Filename '/srv/nfs/boot/am437x-sk-evm.dtb'.
Load address: 0x88000000
Loading: *=08########
done
Bytes transferred =3D 39561 (9a89 hex)
link up on port 0, speed 1000, full duplex
Using cpsw device
File transfer via NFS from server 10.0.1.2; our IP address is 10.0.1.100
Filename '/srv/nfs/boot/zImage'.
Load address: 0x82000000
Loading: *=08##############################################################=
###
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 ###########################
done
Bytes transferred =3D 3463032 (34d778 hex)
Kernel image @ 0x82000000 [ 0x000000 - 0x34d778 ]
## Flattened Device Tree blob at 88000000
   Booting using the fdt blob at 0x88000000
   Loading Device Tree to 8fff3000, end 8ffffa88 ... OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.1.0-rc3-next-20150513 (balbi@saruman) (gcc v=
ersion 4.9.2 ( 4.9.2-10) ) #149 SMP Wed May 13 13:24:36 CDT 2015
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=3D10=
c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instr=
uction cache
[    0.000000] Machine model: TI AM437x SK EVM
[    0.000000] cma: Reserved 16 MiB at 0xbf000000
[    0.000000] Memory policy: Data cache writeback
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] AM437x ES1.2 (sgx neon )
[    0.000000] PERCPU: Embedded 13 pages/cpu @eeeb6000 s22976 r8192 d22080 =
u53248
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 260434
[    0.000000] Kernel command line: console=3DttyO0,115200n8 root=3D/dev/nf=
s nfsroot=3D10.0.1.2:/srv/nfs ro ip=3D10.0.1.100:10.0.1.2:10.0.1.1:255.255.=
255.0:am437xsk:eth0:off::
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 by=
tes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 byte=
s)
[    0.000000] Memory: 1003988K/1048576K available (6261K kernel code, 745K=
 rwdata, 2176K rodata, 440K init, 8220K bss, 28204K reserved, 16384K cma-re=
served, 253952K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0845730   (8438 kB)
[    0.000000]       .init : 0xc0846000 - 0xc08b4000   ( 440 kB)
[    0.000000]       .data : 0xc08b4000 - 0xc096e718   ( 746 kB)
[    0.000000]        .bss : 0xc0971000 - 0xc1178300   (8221 kB)
[    0.000000] Running RCU self tests
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU lockdep checking is enabled.
[    0.000000] 	Additional per-CPU info printed with stalls.
[    0.000000] 	Build-time adjustment of leaf fanout to 32.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=3D2 to nr_cpu_ids=3D1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D32, nr_cpu_ids=
=3D1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C: platform modifies aux control register: 0x0e030000 -> 0=
x3e430000
[    0.000000] L2C: DT/platform modifies aux control register: 0x0e030000 -=
> 0x3e430000
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] OMAP L2C310: ROM does not support power control setting
[    0.000000] L2C-310 ID prefetch enabled, offset 1 lines
[    0.000000] L2C-310 dynamic clock gating disabled, standby mode disabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 256 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c9, AUX_CTRL 0x7e430000
[    0.000000] OMAP clockevent source: timer2 at 24000000 Hz
[    0.000013] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every =
89478484971ns
[    0.000032] clocksource timer1: mask: 0xffffffff max_cycles: 0xffffffff,=
 max_idle_ns: 79635851949 ns
[    0.000084] OMAP clocksource: timer1 at 24000000 Hz
[    0.000800] Console: colour dummy device 80x30
[    0.000852] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar
[    0.000861] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000868] ... MAX_LOCK_DEPTH:          48
[    0.000875] ... MAX_LOCKDEP_KEYS:        8191
[    0.000881] ... CLASSHASH_SIZE:          4096
[    0.000887] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.000893] ... MAX_LOCKDEP_CHAINS:      65536
[    0.000899] ... CHAINHASH_SIZE:          32768
[    0.000905]  memory used by lock dependency info: 5167 kB
[    0.000911]  per task-struct memory footprint: 1152 bytes
[    0.000937] Calibrating delay loop... 1993.93 BogoMIPS (lpj=3D9969664)
[    0.118961] pid_max: default: 32768 minimum: 301
[    0.119282] Security Framework initialized
[    0.119400] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.119415] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 by=
tes)
[    0.122052] Initializing cgroup subsys blkio
[    0.122090] Initializing cgroup subsys memory
[    0.122170] Initializing cgroup subsys devices
[    0.122254] Initializing cgroup subsys freezer
[    0.122368] Initializing cgroup subsys perf_event
[    0.122435] CPU: Testing write buffer coherency: ok
[    0.123761] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.123881] Setting up static identity map for 0x80008280 - 0x800082f0
[    0.127912] Brought up 1 CPUs
[    0.127934] SMP: Total of 1 processors activated (1993.93 BogoMIPS).
[    0.127945] CPU: All CPU(s) started in SVC mode.
[    0.131345] devtmpfs: initialized
[    0.133255] VFP support v0.3: implementor 41 architecture 3 part 30 vari=
ant 9 rev 4
[    0.177817] omap_hwmod: tptc0 using broken dt data from edma
[    0.178215] omap_hwmod: tptc1 using broken dt data from edma
[    0.178593] omap_hwmod: tptc2 using broken dt data from edma
[    0.245361] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff=
, max_idle_ns: 19112604462750000 ns
[    0.247763] pinctrl core: initialized pinctrl subsystem
[    0.278733] NET: Registered protocol family 16
[    0.283208] DMA: preallocated 256 KiB pool for atomic coherent allocatio=
ns
[    0.285152] cpuidle: using governor ladder
[    0.285177] cpuidle: using governor menu
[    0.287804] omap_l3_noc 44000000.ocp: L3 debug error: target 8 mod:0 (un=
clearable)
[    0.287954] omap_l3_noc 44000000.ocp: L3 application error: target 8 mod=
:0 (unclearable)
[    0.292401] platform 44e3e000.rtc: Cannot lookup hwmod 'rtc'
[    0.295188] OMAP GPIO hardware version 0.1
[    0.303077] platform 53701000.des: Cannot lookup hwmod 'des'
[    0.310984] No ATAGs?
[    0.311070] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchp=
oint registers.
[    0.311083] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.344916] edma-dma-engine edma-dma-engine.0: TI EDMA DMA engine driver
[    0.347850] SCSI subsystem initialized
[    0.349795] omap_i2c 44e0b000.i2c: could not find pctldev for node /ocp/=
l4_wkup@44c00000/scm@210000/pinmux@800/i2c0_pins, deferring probe
[    0.349899] omap_i2c 4802a000.i2c: could not find pctldev for node /ocp/=
l4_wkup@44c00000/scm@210000/pinmux@800/i2c1_pins, deferring probe
[    0.353626] Switched to clocksource timer1
[    0.470926] NET: Registered protocol family 2
[    0.472774] TCP established hash table entries: 8192 (order: 3, 32768 by=
tes)
[    0.472970] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    0.474797] TCP: Hash tables configured (established 8192 bind 8192)
[    0.475324] UDP hash table entries: 512 (order: 3, 40960 bytes)
[    0.475576] UDP-Lite hash table entries: 512 (order: 3, 40960 bytes)
[    0.476596] NET: Registered protocol family 1
[    0.478389] RPC: Registered named UNIX socket transport module.
[    0.478408] RPC: Registered udp transport module.
[    0.478417] RPC: Registered tcp transport module.
[    0.478426] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.482969] futex hash table entries: 256 (order: 2, 16384 bytes)
[    0.483189] audit: initializing netlink subsys (disabled)
[    0.483651] audit: type=3D2000 audit(0.470:1): initialized
[    0.487281] VFS: Disk quotas dquot_6.6.0
[    0.487589] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 byt=
es)
[    0.489939] NFS: Registering the id_resolver key type
[    0.490338] Key type id_resolver registered
[    0.490352] Key type id_legacy registered
[    0.490572] jffs2: version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red Hat,=
 Inc.
[    0.495456] bounce: pool size: 64 pages
[    0.495660] io scheduler noop registered
[    0.495683] io scheduler deadline registered
[    0.495732] io scheduler cfq registered (default)
[    0.498562] pinctrl-single 44e10800.pinmux: 199 pins at pa f9e10800 size=
 796
[    0.501674] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.506896] omap_uart 44e09000.serial: no wakeirq for uart0
[    0.506940] omap_uart 44e09000.serial: No clock speed specified: using d=
efault: 48000000
[    0.507567] 44e09000.serial: ttyO0 at MMIO 0x44e09000 (irq =3D 23, base_=
baud =3D 3000000) is a OMAP UART0
[    1.301408] console [ttyO0] enabled
[    1.332188] brd: module loaded
[    1.350407] loop: module loaded
[    1.356124] mtdoops: mtd device (mtddev=3Dname/number) must be supplied
[    1.368611] mousedev: PS/2 mouse device common for all mice
[    1.374570] i2c /dev entries driver
[    1.380173] omap_hsmmc 48060000.mmc: Got CD GPIO
[    1.386360] omap_hsmmc 48060000.mmc: unable to get vmmc regulator -517
[    1.394364] ledtrig-cpu: registered to indicate activity on CPUs
[    1.401674] oprofile: no performance counters
[    1.407790] oprofile: using timer interrupt.
[    1.412979] Initializing XFRM netlink socket
[    1.417718] NET: Registered protocol family 17
[    1.422438] NET: Registered protocol family 15
[    1.427525] Key type dns_resolver registered
[    1.432187] omap_voltage_late_init: Voltage driver support not added
[    1.438925] sr_dev_init: No voltage domain specified for smartreflex0. C=
annot initialize
[    1.447425] sr_dev_init: No voltage domain specified for smartreflex1. C=
annot initialize
[    1.456970] ThumbEE CPU extension supported.
[    1.461468] Registering SWP/SWPB emulation handler
[    1.466588] SmartReflex Class3 initialized
[    1.511544] omap_i2c 44e0b000.i2c: bus 0 rev0.12 at 400 kHz
[    1.521126] omap_i2c 4802a000.i2c: bus 1 rev0.12 at 400 kHz
[    1.528006] omap_hsmmc 48060000.mmc: Got CD GPIO
[    1.633554] davinci_mdio 4a101000.mdio: davinci mdio revision 1.6
[    1.639959] davinci_mdio 4a101000.mdio: detected phy mask ffffffcf
[    1.652076] libphy: 4a101000.mdio: probed
[    1.656388] davinci_mdio 4a101000.mdio: phy[4]: device 4a101000.mdio:04,=
 driver unknown
[    1.664794] davinci_mdio 4a101000.mdio: phy[5]: device 4a101000.mdio:05,=
 driver unknown
[    1.674729] cpsw 4a100000.ethernet: Detected MACID =3D 34:b1:f7:31:40:0e
[    1.683956] cpsw 4a100000.ethernet: cpsw: Detected MACID =3D 34:b1:f7:31=
:40:10
[    1.692773] hctosys: unable to open rtc device (rtc0)
[    1.698144] sr_init: No PMIC hook to init smartreflex
[    1.703725] sr_init: platform driver register failed for SR
[    1.728519] net eth0: initializing cpsw version 1.15 (0)
[    1.742023] mmc0: host does not support reading read-only switch, assumi=
ng write-enable
[    1.752798] mmc0: new high speed SDHC card at address aaaa
[    1.761089] mmcblk0: mmc0:aaaa SU32G 29.7 GiB=20
[    1.769934]  mmcblk0: p1 p2
[    1.814044] net eth0: phy found : id is : 0x221622
[    5.814470] cpsw 4a100000.ethernet eth0: Link is Up - 1Gbps/Full - flow =
control rx/tx
[    5.834450] IP-Config: Complete:
[    5.837857]      device=3Deth0, hwaddr=3D34:b1:f7:31:40:0e, ipaddr=3D10.=
0.1.100, mask=3D255.255.255.0, gw=3D10.0.1.1
[    5.848058]      host=3Dam437xsk, domain=3D, nis-domain=3D(none)
[    5.853823]      bootserver=3D10.0.1.2, rootserver=3D10.0.1.2, rootpath=
=3D
[    5.868807] Unable to handle kernel NULL pointer dereference at virtual =
address 000006a2
[    5.877340] pgd =3D c0004000
[    5.880175] [000006a2] *pgd=3D00000000
[    5.883953] Internal error: Oops: 5 [#1] SMP ARM
[    5.888784] Modules linked in:
[    5.891986] CPU: 0 PID: 5 Comm: kworker/0:0H Not tainted 4.1.0-rc3-next-=
20150513 #149
[    5.900155] Hardware name: Generic AM43 (Flattened Device Tree)
[    5.906351] Workqueue: rpciod rpc_async_schedule
[    5.911177] task: ee0b4c00 ti: ee0b6000 task.ti: ee0b6000
[    5.916803] PC is at cpsw_rx_handler+0x14/0x1c4
[    5.921537] LR is at __cpdma_chan_process+0xe8/0x128
[    5.926709] pc : [<c048f5d4>]    lr : [<c048c8f8>]    psr: 60000113
[    5.926709] sp : ee0b7a80  ip : 00000002  fp : 00000040
[    5.938669] r10: ffff8d1c  r9 : ee4b34d0  r8 : 0000003c
[    5.944115] r7 : ee4a1430  r6 : ee4d27c0  r5 : 00010000  r4 : 00000000
[    5.950916] r3 : c048f5c0  r2 : 00010000  r1 : 0000003c  r0 : ee4d27c0
[    5.957714] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 kernel
[    5.965324] Control: 10c5387d  Table: 80004059  DAC: 00000015
[    5.971307] Process kworker/0:0H (pid: 5, stack limit =3D 0xee0b6218)
[    5.977833] Stack: (0xee0b7a80 to 0xee0b8000)
[    5.982380] 7a80: 00010000 f01ec000 ee4a1410 00010000 f01ec000 ee4a1430 =
0000003c c048c8f8
[    5.990905] 7aa0: 00000001 00000000 ee4a1410 00000040 00000000 ee0b7af0 =
c08b2800 c048c974
[    5.999422] 7ac0: ee4af5e8 00000001 00000040 c048ec18 ee4af5e8 00000001 =
0000012c eeebb800
[    6.007945] 7ae0: ee0b7af0 c0503df8 2e609000 eeebb800 ee0b7af0 ee0b7af0 =
ee0b7af8 ee0b7af8
[    6.016476] 7b00: c0500600 c08b608c 00000003 00000001 c096bb6c 00000001 =
0000000c 00000101
[    6.024999] 7b20: 00000000 c00441c4 ee4af000 c053bac8 0000000a ffff8d1b =
04208060 00000000
[    6.033522] 7b40: 00000004 60000193 c053bb0c c053d860 ee4af000 ee51ee40 =
0201000a c096b926
[    6.042046] 7b60: 00000000 c0044514 00000200 c0044600 00000000 c096b926 =
c053d860 c053bb28
[    6.050569] 7b80: 00000000 00000000 c053b858 00000000 00000001 ee4af14c =
ee4af150 ee0b4c00
[    6.059099] 7ba0: 00000001 0201000a 00000070 feff31d0 ee50e1c0 00000000 =
ee4af000 00000070
[    6.067618] 7bc0: 00000000 00000001 00000000 c053d860 00000001 00000000 =
c053e2b8 00000000
[    6.076147] 7be0: ee0b7cd8 ee23c7c0 ee0b7c3c ee0b7d7c c053a304 00000000 =
ee23cae8 c053e48c
[    6.084664] 7c00: ee0b56f8 c053a304 ee0b7d7c c095d380 0011005c ee23c7c0 =
ee4e4024 00000000
[    6.093192] 7c20: c05671d0 00000000 ee23cae8 c053e2b8 00000000 ffff0000 =
c095d3d0 ee0b7c3c
[    6.101720] 7c40: ee0b7c3c ee50e1c0 0011005c ee23c7c0 ee4e4024 00000000 =
ee0b7cd8 00000000
[    6.110252] 7c60: ee23cae8 c05671d0 00000000 ee23c7c0 ee50e1c0 00000054 =
ee0b7cd8 0000005c
[    6.118787] 7c80: 0201000a c0568fd8 0000005c 00000008 ee0b7cc4 ee0b7cc0 =
00004040 ee0b7d7c
[    6.127327] 7ca0: c096b994 00000000 c053a304 c04e8464 00006f00 0201000a =
c095d380 00000000
[    6.135851] 7cc0: 00000000 0201000a 00000000 00000000 ffff0000 ee0b51d0 =
00000002 00000001
[    6.144386] 7ce0: 00000000 00110000 00000000 6401000a 0201000a 09ab6f00 =
00000001 00000054
[    6.152927] 7d00: ee0b7d7c c008cc50 00000200 c0575140 00000000 c004459c =
ee23c7c0 c096b994
[    6.161466] 7d20: 00000000 c0575140 ee23c7c0 c0575a74 00000000 00000000 =
c0575948 ee51c004
[    6.170020] 7d40: 00000000 00000000 edab44c0 00000054 ee0b7e0c 00000000 =
ee51c80c c04e8464
[    6.178562] 7d60: 00000054 c05c038c 00000054 00000000 c11338c4 ee51c004 =
00000054 ee51c80c
[    6.187108] 7d80: 00000010 00000003 00000000 00000000 ee0b7d7c 00000000 =
00000000 00000000
[    6.195641] 7da0: 00004040 00000000 00000000 00000001 ee51de04 c05c042c =
00000000 00000000
[    6.204180] 7dc0: ee0b7e28 00000010 c1133880 00000000 60000113 ee51c800 =
ee51de00 ee51de00
[    6.212714] 7de0: ee4db440 00000000 00000000 c096e560 00000001 c05c07ec =
00000000 00000001
[    6.221242] 7e00: ee0b7e0c ee51c800 ee51de00 00000000 ee51c800 ee51de00 =
ee51de74 ee51cbc0
[    6.229766] 7e20: ee4db440 c05be38c 5d7c6504 00000001 ee4db440 ee51de00 =
ee51de00 00000681
[    6.238298] 7e40: 02000000 f4a89bfc 00000000 c05bb22c ee519a40 00000000 =
c0058228 ee4db440
[    6.246837] 7e60: ee02b140 c05bb0d0 ee51dd00 c05bb0d0 c096e434 c05c5640 =
00000000 c008a048
[    6.255378] 7e80: ee0b4c00 00000000 feff3905 ee4db484 ee02b140 eeebab80 =
feff3900 00000000
[    6.263906] 7ea0: ee0b7ec8 c096bbf8 c096bbf8 c00582bc 00000001 00000000 =
c0058228 ee02b140
[    6.272434] 7ec0: 00000000 00000001 c11755f4 c0ac5c30 00000000 c07dda94 =
eeebad50 eeebab80
[    6.280964] 7ee0: ee02b158 eeebabb0 ee0b6000 00000008 c096b44f ee02b140 =
eeebab80 c00585f4
[    6.289488] 7f00: eeebad50 00000000 c00585b8 00000000 ee030a00 ee02b140 =
c00585b8 00000000
[    6.298011] 7f20: 00000000 00000000 00000000 c005dfe4 bf08fcbb 00000000 =
ee0b4c00 ee02b140
[    6.306535] 7f40: 00000000 00000000 dead4ead ffffffff ffffffff c0972e14 =
00000000 00000000
[    6.315087] 7f60: c076ee10 ee0b7f64 ee0b7f64 00000000 00000000 dead4ead =
ffffffff ffffffff
[    6.323628] 7f80: c0972e14 00000000 00000000 c076ee10 ee0b7f90 ee0b7f90 =
ee0b7fac ee030a00
[    6.332170] 7fa0: c005df10 00000000 00000000 c000f570 00000000 00000000 =
00000000 00000000
[    6.340700] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    6.349235] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 =
7d3e3fff e2816aea
[    6.357792] [<c048f5d4>] (cpsw_rx_handler) from [<c048c8f8>] (__cpdma_ch=
an_process+0xe8/0x128)
[    6.366790] [<c048c8f8>] (__cpdma_chan_process) from [<c048c974>] (cpdma=
_chan_process+0x3c/0x5c)
[    6.375967] [<c048c974>] (cpdma_chan_process) from [<c048ec18>] (cpsw_po=
ll+0x28/0xd4)
[    6.384168] [<c048ec18>] (cpsw_poll) from [<c0503df8>] (net_rx_action+0x=
1d4/0x338)
[    6.392097] [<c0503df8>] (net_rx_action) from [<c00441c4>] (__do_softirq=
+0xd8/0x358)
[    6.400189] [<c00441c4>] (__do_softirq) from [<c0044514>] (do_softirq+0x=
74/0x80)
[    6.407930] [<c0044514>] (do_softirq) from [<c0044600>] (__local_bh_enab=
le_ip+0xe0/0x104)
[    6.416480] [<c0044600>] (__local_bh_enable_ip) from [<c053bb28>] (ip_fi=
nish_output+0x450/0x12e8)
[    6.425753] [<c053bb28>] (ip_finish_output) from [<c053d860>] (ip_output=
+0x168/0x1bc)
[    6.433935] [<c053d860>] (ip_output) from [<c053e2b8>] (ip_send_skb+0x18=
/0xec)
[    6.441490] [<c053e2b8>] (ip_send_skb) from [<c05671d0>] (udp_send_skb+0=
xe4/0x2e0)
[    6.449415] [<c05671d0>] (udp_send_skb) from [<c0568fd8>] (udp_sendmsg+0=
x24c/0x964)
[    6.457426] [<c0568fd8>] (udp_sendmsg) from [<c04e8464>] (sock_sendmsg+0=
x14/0x24)
[    6.465260] [<c04e8464>] (sock_sendmsg) from [<c05c038c>] (xs_send_kvec+=
0x84/0x94)
[    6.473170] [<c05c038c>] (xs_send_kvec) from [<c05c042c>] (xs_sendpages+=
0x90/0x25c)
[    6.481184] [<c05c042c>] (xs_sendpages) from [<c05c07ec>] (xs_udp_send_r=
equest+0x54/0xec)
[    6.489752] [<c05c07ec>] (xs_udp_send_request) from [<c05be38c>] (xprt_t=
ransmit+0x54/0x298)
[    6.498491] [<c05be38c>] (xprt_transmit) from [<c05bb22c>] (call_transmi=
t+0x15c/0x208)
[    6.506762] [<c05bb22c>] (call_transmit) from [<c05c5640>] (__rpc_execut=
e+0x74/0x334)
[    6.514968] [<c05c5640>] (__rpc_execute) from [<c00582bc>] (process_one_=
work+0x1b4/0x4b0)
[    6.523516] [<c00582bc>] (process_one_work) from [<c00585f4>] (worker_th=
read+0x3c/0x4a0)
[    6.531981] [<c00585f4>] (worker_thread) from [<c005dfe4>] (kthread+0xd4=
/0xf0)
[    6.539541] [<c005dfe4>] (kthread) from [<c000f570>] (ret_from_fork+0x14=
/0x24)
[    6.547087] Code: e1a06000 e5904014 e24dd008 e1a08001 (e5d436a2)=20
[    6.553521] ---[ end trace df83acbd69cbff08 ]---
[    6.558350] Kernel panic - not syncing: Fatal exception in interrupt
[    6.564997] ---[ end Kernel panic - not syncing: Fatal exception in inte=
rrupt

-- listing of cpsw_rx_handler+0x14 --

(gdb) l *(cpsw_rx_handler+0x14)
0xc048f5d4 is in cpsw_rx_handler (drivers/net/ethernet/ti/cpsw.c:712).
707		struct sk_buff		*new_skb;
708		struct net_device	*ndev =3D skb->dev;
709		struct cpsw_priv	*priv =3D netdev_priv(ndev);
710		int			ret =3D 0;
711=09
712		cpsw_dual_emac_src_port_detect(status, priv, ndev, skb);
713=09
714		if (unlikely(status < 0) || unlikely(!netif_running(ndev))) {
715			bool ndev_status =3D false;
716			struct cpsw_slave *slave =3D priv->slaves;
(gdb)=20

regards

--=20
balbi

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVU5eaAAoJEIaOsuA1yqREOwIP/1pa/4hEWYznFF0y+CY5arab
hyazVua7qEA8E2BeaUjmy/VKd5r8kVaBlk/NSNTAw5d7XBZF33TvV5HBNXaJdbJt
AhRD2j5OyAFV9dQ9j2UASvBvs/Mdq3ieppCdp5NPkSTl7AGVli6bhjkntrWcz6er
wA0ETrdvt3U6A0Fu+UjMO5IghMxmTLfj68ovc5051UCYrJku45F3xgzWQCn916QV
WDGCsyDnv2eT1eCvIslZqawgoZInvWa7UmaFRFFYKubBEc0PrHcd2OK52fsGTBaB
l6BEXNvj57ElS+CIt8SfllzqMTKkujR3uOFuGpTNskG8J1SyWISiRBA4jL8p5yUU
vN/Ih7BbWZbvRNf+kU3Qu0FjshxQfs0nvoVWkgW9+xRYUek+m4FvuzSLjEiEhnrD
wyo+eNJne2KGk8AiiJa79pPnsVkNtHtR4zy8UlksTcxWBIxiIVebM77+m1g4tByr
zzZGE8oVw9n7SPMj3KpRcyEjMGfK2J/odVAFPJ1GgBHdrOeZxj5hVnjpP79wSY2+
LDZRzEzAA03Gx9VJ877MNCwvwp1zyPtqKB1o/7kGt+jnzMDVsGpkmJqJas3gh4C0
XpmhcyMzUSpN9HGy+Z3z+tGeE4TLd+8VhVrld5yCmYaI6pMOeqJSH1JBZef4YB39
aXqzK09y/5/5jIRTBbYS
=CTVg
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
