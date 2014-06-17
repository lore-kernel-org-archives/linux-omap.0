From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] ARM: AM43xx: hwmod: add DSS hwmod data
Date: Tue, 17 Jun 2014 08:16:38 -0500
Message-ID: <20140617131638.GA9070@saruman.home>
References: <1402994233-22599-1-git-send-email-tomi.valkeinen@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49353 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764AbaFQNRZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2014 09:17:25 -0400
Content-Disposition: inline
In-Reply-To: <1402994233-22599-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>, Sathya Prakash M R <sathyap@ti.com>

--rS8CxjVDS/+yyDmU
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2014 at 11:37:13AM +0300, Tomi Valkeinen wrote:
> From: Sathya Prakash M R <sathyap@ti.com>
>=20
> Add DSS hwmod data for AM43xx.
>=20
> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
> [tomi.valkeinen@ti.com: added missing dispc flags]
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Acked-by: Rajendra Nayak <rnayak@ti.com>

tested on top of today's linux-next
(5f295cdf5c5dbbb0c40f10f2ddae02ff46bbf773) with am437x-sk. Works fine:

Tested-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--1yeeQ81UyVL57Vl7
Content-Type: application/vnd.tcpdump.pcap
Content-Disposition: attachment; filename="minicom.cap"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Booting Linux on physical CPU 0x0=0A[    0.000000] Initializ=
ing cgroup subsys cpuset=0A[    0.000000] Initializing cgroup subsys cpu=0A=
[    0.000000] Initializing cgroup subsys cpuacct=0A[    0.000000] Linux ve=
rsion 3.16.0-rc1-next-20140617-00002-g01760e8 (balbi@saruman) (gcc version =
4.8.2 20130902 (prerelease) (crosstool-NG linaro-1.13.1-4.8-2013.09 - Linar=
o GCC 2013.09) ) #200 SMP Tue Jun 17 08:12:35 CDT 2014=0A[    0.000000] CPU=
: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=3D10c5387d=0A[    0.00=
0000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction ca=
che=0A[    0.000000] Machine model: TI AM437x SK EVM=0A[    0.000000] cma: =
CMA: reserved 16 MiB at ae800000=0A[    0.000000] Memory policy: Data cache=
 writeback=0A[    0.000000] On node 0 totalpages: 262144=0A[    0.000000] f=
ree_area_init_node: node 0, pgdat c09aac80, node_mem_map edff1000=0A[    0.=
000000]   Normal zone: 1520 pages used for memmap=0A[    0.000000]   Normal=
 zone: 0 pages reserved=0A[    0.000000]   Normal zone: 194560 pages, LIFO =
batch:31=0A[    0.000000]   HighMem zone: 528 pages used for memmap=0A[    =
0.000000]   HighMem zone: 67584 pages, LIFO batch:15=0A[    0.000000] CPU: =
All CPU(s) started in SVC mode.=0A[    0.000000] AM437x ES1.1 (sgx neon )=
=0A[    0.000000] L2C: platform modifies aux control register: 0x0e030000 -=
> 0x3e430000=0A[    0.000000] L2C: DT/platform modifies aux control registe=
r: 0x0e030000 -> 0x3e430000=0A[    0.000000] L2C-310 enabling early BRESP f=
or Cortex-A9=0A[    0.000000] L2C-310 ID prefetch enabled, offset 1 lines=
=0A[    0.000000] ------------[ cut here ]------------=0A[    0.000000] WAR=
NING: CPU: 0 PID: 0 at arch/arm/mach-omap2/omap4-common.c:192 omap4_l2c310_=
write_sec+0x74/0xa8()=0A[    0.000000] OMAP L2C310: ignoring write to reg 0=
xf80=0A[    0.000000] Modules linked in:=0A[    0.000000] CPU: 0 PID: 0 Com=
m: swapper Not tainted 3.16.0-rc1-next-20140617-00002-g01760e8 #200=0A[    =
0.000000] [<c0015350>] (unwind_backtrace) from [<c0011f8c>] (show_stack+0x1=
0/0x14)=0A[    0.000000] [<c0011f8c>] (show_stack) from [<c05eb368>] (dump_=
stack+0x84/0x9c)=0A[    0.000000] [<c05eb368>] (dump_stack) from [<c0041e7c=
>] (warn_slowpath_common+0x6c/0x90)=0A[    0.000000] [<c0041e7c>] (warn_slo=
wpath_common) from [<c0041ed0>] (warn_slowpath_fmt+0x30/0x40)=0A[    0.0000=
00] [<c0041ed0>] (warn_slowpath_fmt) from [<c002b0ec>] (omap4_l2c310_write_=
sec+0x74/0xa8)=0A[    0.000000] [<c002b0ec>] (omap4_l2c310_write_sec) from =
[<c089ce90>] (l2c310_enable+0x12c/0x1fc)=0A[    0.000000] [<c089ce90>] (l2c=
310_enable) from [<c089ccdc>] (__l2c_init+0x160/0x1e8)=0A[    0.000000] [<c=
089ccdc>] (__l2c_init) from [<c089d3b0>] (l2x0_of_init+0x140/0x164)=0A[    =
0.000000] [<c089d3b0>] (l2x0_of_init) from [<c08a3544>] (omap_l2_cache_init=
+0x60/0x98)=0A[    0.000000] [<c08a3544>] (omap_l2_cache_init) from [<c089e=
584>] (am43xx_init_early+0x58/0x80)=0A[    0.000000] [<c089e584>] (am43xx_i=
nit_early) from [<c0899244>] (setup_arch+0x89c/0x980)=0A[    0.000000] [<c0=
899244>] (setup_arch) from [<c089589c>] (start_kernel+0x80/0x3a0)=0A[    0.=
000000] [<c089589c>] (start_kernel) from [<80008074>] (0x80008074)=0A[    0=
=2E000000] ---[ end trace cb88537fdc8fa200 ]---=0A[    0.000000] L2C-310 dy=
namic clock gating disabled, standby mode disabled=0A[    0.000000] L2C-310=
 cache controller enabled, 16 ways, 256 kB=0A[    0.000000] L2C-310: CACHE_=
ID 0x410000c9, AUX_CTRL 0x7e430000=0A[    0.000000] PERCPU: Embedded 9 page=
s/cpu @edfb6000 s14464 r8192 d14208 u36864=0A[    0.000000] pcpu-alloc: s14=
464 r8192 d14208 u36864 alloc=3D9*4096=0A[    0.000000] pcpu-alloc: [0] 0 =
=0A[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  T=
otal pages: 260624=0A[    0.000000] Kernel command line: console=3DttyO0,11=
5200n8 root=3D/dev/mmcblk0p2 rw rootfstype=3Dext4 rootwait=0A[    0.000000]=
 PID hash table entries: 4096 (order: 2, 16384 bytes)=0A[    0.000000] Dent=
ry cache hash table entries: 131072 (order: 7, 524288 bytes)=0A[    0.00000=
0] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)=0A[    0.=
000000] Memory: 1004752K/1048576K available (6276K kernel code, 714K rwdata=
, 2476K rodata, 414K init, 8230K bss, 43824K reserved, 270336K highmem)=0A[=
    0.000000] Virtual kernel memory layout:=0A[    0.000000]     vector  : =
0xffff0000 - 0xffff1000   (   4 kB)=0A[    0.000000]     fixmap  : 0xffc000=
00 - 0xffe00000   (2048 kB)=0A[    0.000000]     vmalloc : 0xf0000000 - 0xf=
f000000   ( 240 MB)=0A[    0.000000]     lowmem  : 0xc0000000 - 0xef800000 =
  ( 760 MB)=0A[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 =
MB)=0A[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)=0A[ =
   0.000000]       .text : 0xc0008000 - 0xc0894668   (8754 kB)=0A[    0.000=
000]       .init : 0xc0895000 - 0xc08fc880   ( 415 kB)=0A[    0.000000]    =
   .data : 0xc08fe000 - 0xc09b0958   ( 715 kB)=0A[    0.000000]        .bss=
 : 0xc09b0958 - 0xc11ba450   (8231 kB)=0A[    0.000000] Hierarchical RCU im=
plementation.=0A[    0.000000] 	RCU restricting CPUs from NR_CPUS=3D2 to nr=
_cpu_ids=3D1.=0A[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=
=3D16, nr_cpu_ids=3D1=0A[    0.000000] NR_IRQS:16 nr_irqs:16 16=0A[    0.00=
0000] GIC CPU mask not found - kernel will fail to boot.=0A[    0.000000] G=
IC CPU mask not found - kernel will fail to boot.=0A[    0.000000] OMAP clo=
ckevent source: timer2 at 24000000 Hz=0A[    0.000009] sched_clock: 32 bits=
 at 24MHz, resolution 41ns, wraps every 178956969942ns=0A[    0.000059] OMA=
P clocksource: timer1 at 24000000 Hz=0A[    0.000660] Console: colour dummy=
 device 80x30=0A[    0.000698] Lock dependency validator: Copyright (c) 200=
6 Red Hat, Inc., Ingo Molnar=0A[    0.000710] ... MAX_LOCKDEP_SUBCLASSES:  =
8=0A[    0.000719] ... MAX_LOCK_DEPTH:          48=0A[    0.000728] ... MAX=
_LOCKDEP_KEYS:        8191=0A[    0.000737] ... CLASSHASH_SIZE:          40=
96=0A[    0.000746] ... MAX_LOCKDEP_ENTRIES:     32768=0A[    0.000755] ...=
 MAX_LOCKDEP_CHAINS:      65536=0A[    0.000763] ... CHAINHASH_SIZE:       =
   32768=0A[    0.000772]  memory used by lock dependency info: 5167 kB=0A[=
    0.000782]  per task-struct memory footprint: 1152 bytes=0A[    0.000824=
] Calibrating delay loop... 1993.93 BogoMIPS (lpj=3D9969664)=0A[    0.11922=
6] pid_max: default: 32768 minimum: 301=0A[    0.119556] Security Framework=
 initialized=0A[    0.119661] Mount-cache hash table entries: 2048 (order: =
1, 8192 bytes)=0A[    0.119678] Mountpoint-cache hash table entries: 2048 (=
order: 1, 8192 bytes)=0A[    0.122040] Initializing cgroup subsys devices=
=0A[    0.122159] Initializing cgroup subsys freezer=0A[    0.122229] Initi=
alizing cgroup subsys debug=0A[    0.122366] CPU: Testing write buffer cohe=
rency: ok=0A[    0.123387] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000=
=0A[    0.123495] Setting up static identity map for 0x805f68c8 - 0x805f693=
8=0A[    0.126413] Brought up 1 CPUs=0A[    0.126434] SMP: Total of 1 proce=
ssors activated.=0A[    0.126448] CPU: All CPU(s) started in SVC mode.=0A[ =
   0.128848] devtmpfs: initialized=0A[    0.139751] VFP support v0.3: imple=
mentor 41 architecture 3 part 30 variant 9 rev 4=0A[    0.172627] omap_hwmo=
d: tptc0 using broken dt data from edma=0A[    0.172928] omap_hwmod: tptc1 =
using broken dt data from edma=0A[    0.173203] omap_hwmod: tptc2 using bro=
ken dt data from edma=0A[    0.238151] omap_hwmod: dss_dispc: cannot be ena=
bled for reset (3)=0A[    0.241464] omap_hwmod: dss_rfbi: cannot be enabled=
 for reset (3)=0A[    0.243373] pinctrl core: initialized pinctrl subsystem=
=0A[    0.245479] regulator-dummy: no parameters=0A[    0.266815] NET: Regi=
stered protocol family 16=0A[    0.273710] DMA: preallocated 256 KiB pool f=
or atomic coherent allocations=0A[    0.275590] cpuidle: using governor lad=
der=0A[    0.275640] cpuidle: using governor menu=0A[    0.289862] platform=
 49000000.edma: alias fck already exists=0A[    0.289947] platform 49000000=
=2Eedma: alias fck already exists=0A[    0.289968] platform 49000000.edma: =
alias fck already exists=0A[    0.292694] gpiochip_add: registered GPIOs 0 =
to 31 on device: gpio=0A[    0.293302] OMAP GPIO hardware version 0.1=0A[  =
  0.294333] gpiochip_add: registered GPIOs 32 to 63 on device: gpio=0A[    =
0.295575] gpiochip_add: registered GPIOs 64 to 95 on device: gpio=0A[    0.=
299189] platform 53701000.des: Cannot lookup hwmod 'des'=0A[    0.305316] N=
o ATAGs?=0A[    0.305402] hw-breakpoint: found 5 (+1 reserved) breakpoint a=
nd 1 watchpoint registers.=0A[    0.305439] hw-breakpoint: maximum watchpoi=
nt size is 4 bytes.=0A[    0.337853] edma-dma-engine edma-dma-engine.0: TI =
EDMA DMA engine driver=0A[    0.338461] of_get_named_gpiod_flags: can't par=
se gpios property of node '/fixedregulator-sd[0]'=0A[    0.338903] vmmcsd_f=
ixed: 3300 mV =0A[    0.339202] of_get_named_gpiod_flags: can't parse gpios=
 property of node '/fixedregulator-v33[0]'=0A[    0.339624] v33_fixed: 3300=
 mV =0A[    0.339912] of_get_named_gpiod_flags: can't parse gpios property =
of node '/fixedregulator-v18[0]'=0A[    0.340172] v18_fixed: 1800 mV =0A[  =
  0.342914] SCSI subsystem initialized=0A[    0.343499] usbcore: registered=
 new interface driver usbfs=0A[    0.343622] usbcore: registered new interf=
ace driver hub=0A[    0.344181] usbcore: registered new device driver usb=
=0A[    0.344974] omap_i2c 44e0b000.i2c: could not find pctldev for node /p=
inmux@44e10800/i2c0_pins, deferring probe=0A[    0.345023] platform 44e0b00=
0.i2c: Driver omap_i2c requests probe deferral=0A[    0.345079] omap_i2c 48=
02a000.i2c: could not find pctldev for node /pinmux@44e10800/i2c1_pins, def=
erring probe=0A[    0.345103] platform 4802a000.i2c: Driver omap_i2c reques=
ts probe deferral=0A[    0.346045] Advanced Linux Sound Architecture Driver=
 Initialized.=0A[    0.348808] Switched to clocksource timer1=0A[    0.4444=
52] NET: Registered protocol family 2=0A[    0.446040] TCP established hash=
 table entries: 8192 (order: 3, 32768 bytes)=0A[    0.446229] TCP bind hash=
 table entries: 8192 (order: 6, 294912 bytes)=0A[    0.447934] TCP: Hash ta=
bles configured (established 8192 bind 8192)=0A[    0.448261] TCP: reno reg=
istered=0A[    0.448327] UDP hash table entries: 512 (order: 3, 40960 bytes=
)=0A[    0.448577] UDP-Lite hash table entries: 512 (order: 3, 40960 bytes)=
=0A[    0.449765] NET: Registered protocol family 1=0A[    0.451088] RPC: R=
egistered named UNIX socket transport module.=0A[    0.451131] RPC: Registe=
red udp transport module.=0A[    0.451143] RPC: Registered tcp transport mo=
dule.=0A[    0.451155] RPC: Registered tcp NFSv4.1 backchannel transport mo=
dule.=0A[    0.454683] futex hash table entries: 256 (order: 2, 16384 bytes=
)=0A[    0.458299] VFS: Disk quotas dquot_6.5.2=0A[    0.458427] Dquot-cach=
e hash table entries: 1024 (order 0, 4096 bytes)=0A[    0.460345] NFS: Regi=
stering the id_resolver key type=0A[    0.460641] Key type id_resolver regi=
stered=0A[    0.460678] Key type id_legacy registered=0A[    0.460818] jffs=
2: version 2.2. (NAND) (SUMMARY)  \xffffffc2\xffffffa9 2001-2006 Red Hat, I=
nc.=0A[    0.461235] msgmni has been set to 1466=0A[    0.464158] bounce: p=
ool size: 64 pages=0A[    0.464303] io scheduler noop registered=0A[    0.4=
64332] io scheduler deadline registered=0A[    0.464394] io scheduler cfq r=
egistered (default)=0A[    0.468891] pinctrl-single 44e10800.pinmux: 199 pi=
ns at pa f9e10800 size 796=0A[    0.472985] pwm-backlight backlight: GPIO l=
ookup for consumer enable=0A[    0.473008] pwm-backlight backlight: using d=
evice tree for GPIO lookup=0A[    0.473025] of_get_named_gpiod_flags: can't=
 parse gpios property of node '/backlight[0]'=0A[    0.473039] of_get_named=
_gpiod_flags: can't parse gpios property of node '/backlight[0]'=0A[    0.4=
73053] pwm-backlight backlight: using lookup tables for GPIO lookup=0A[    =
0.473169] pwm-backlight backlight: lookup for GPIO enable failed=0A[    0.4=
73275] backlight supply power not found, using dummy regulator=0A[    0.475=
553] DSS: set fck to 200000000=0A[    0.476106] DSS: dss_runtime_get=0A[   =
 0.476151] DSS: dss_restore_context=0A[    0.476195] OMAP DSS rev 2.0=0A[  =
  0.476206] DSS: dss_runtime_put=0A[    0.476220] DSS: dss_save_context=0A[=
    0.476230] DSS: context saved=0A[    0.476697] DISPC: dispc_runtime_get=
=0A[    0.476737] DSS: dss_restore_context=0A[    0.476748] DSS: context re=
stored=0A[    0.476782] DISPC: dispc_restore_context=0A[    0.476809] omapd=
ss_dispc 4832a400.dispc: OMAP DISPC rev 3.0=0A[    0.476820] DISPC: dispc_r=
untime_put=0A[    0.476837] DISPC: dispc_save_context=0A[    0.476872] DISP=
C: context saved=0A[    0.478224] panel-dpi display: GPIO lookup for consum=
er enable=0A[    0.478246] panel-dpi display: using device tree for GPIO lo=
okup=0A[    0.478300] of_get_named_gpiod_flags exited with status 0=0A[    =
0.479831] DISPC: dispc_runtime_get=0A[    0.480109] DISPC: dispc_runtime_pu=
t=0A[    0.480133] DISPC: dispc_save_context=0A[    0.480169] DISPC: contex=
t saved=0A[    0.480377] DISPC: dispc_runtime_get=0A[    0.480530] DISPC: d=
ispc_runtime_put=0A[    0.480570] DISPC: dispc_save_context=0A[    0.480601=
] DISPC: context saved=0A[    0.480625] DISPC: dispc_runtime_get=0A[    0.4=
80654] DISPC: dispc_runtime_put=0A[    0.480668] DISPC: dispc_save_context=
=0A[    0.480692] DISPC: context saved=0A[    0.480712] DISPC: dispc_runtim=
e_get=0A[    0.480738] DISPC: dispc_runtime_put=0A[    0.480752] DISPC: dis=
pc_save_context=0A[    0.480776] DISPC: context saved=0A[    0.480986] DSS:=
 dss_save_context=0A[    0.481036] DSS: context saved=0A[    0.484219] APPL=
Y: omap_dss_mgr_apply(lcd)=0A[    0.485174] Console: switching to colour fr=
ame buffer device 60x34=0A[    0.487065] APPLY: omap_dss_mgr_apply(lcd)=0A[=
    0.487094] APPLY: omap_dss_mgr_apply(lcd)=0A[    0.487108] DPI: dpi_set_=
timings=0A[    0.487268] DISPC: dispc_runtime_get=0A[    0.487394] DSS: dss=
_restore_context=0A[    0.487408] DSS: context restored=0A[    0.487728] DS=
S: set fck to 198000000=0A[    0.490462] APPLY: writing mgr 0 regs=0A[    0=
=2E490515] APPLY: writing ovl 0 regs=0A[    0.490535] DISPC: dispc_ovl_setu=
p 0, pa 0xae840000, pa_uv 0x00000000, sw 480, 0,0, 480x272 -> 480x272, cmod=
e 40, rot 0, mir 0, chan 0 repl 1=0A[    0.490554] DISPC: calc_rot(0): scrw=
 480, 480x272=0A[    0.490566] DISPC: offset0 0, offset1 0, row_inc 1, pix_=
inc 1=0A[    0.490581] DISPC: 0,0 480x272 -> 480x272=0A[    0.490595] APPLY=
: writing ovl 0 regs extra=0A[    0.490605] DISPC: dispc_enable_plane 0, 1=
=0A[    0.490619] DISPC: fifo(0) threshold (bytes), old 960/1023, new 960/1=
023=0A[    0.490628] APPLY: writing ovl 1 regs=0A[    0.490637] APPLY: writ=
ing ovl 1 regs extra=0A[    0.490645] APPLY: writing ovl 2 regs=0A[    0.49=
0654] APPLY: writing ovl 2 regs extra=0A[    0.490663] APPLY: writing mgr 0=
 regs extra=0A[    0.490673] DISPC: channel 0 xres 480 yres 272=0A[    0.49=
0685] DISPC: pck 9000000=0A[    0.490695] DISPC: hsw 4 hfp 8 hbp 43 vsw 10 =
vfp 4 vbp 12=0A[    0.490706] DISPC: vsync_level 1 hsync_level 1 data_pclk_=
edge 1 de_level 0 sync_pclk_edge 0=0A[    0.490716] DISPC: hsync 16822Hz, v=
sync 56Hz=0A[    0.490727] DISPC: lck =3D 198000000 (1)=0A[    0.490737] DI=
SPC: pck =3D 9000000 (22)=0A[    0.491012] omapfb omapfb: using display 'lc=
d' mode 480x272=0A[    0.492728] Serial: 8250/16550 driver, 4 ports, IRQ sh=
aring enabled=0A[    0.497941] omap_uart 44e09000.serial: no wakeirq for ua=
rt0=0A[    0.497976] of_get_named_gpiod_flags: can't parse gpios property o=
f node '/ocp/serial@44e09000[0]'=0A[    0.497996] omap_uart 44e09000.serial=
: No clock speed specified: using default: 48000000=0A[    0.498525] 44e090=
00.serial: ttyO0 at MMIO 0x44e09000 (irq =3D 104, base_baud =3D 3000000) is=
 a OMAP UART0=0A[    1.463396] console [ttyO0] enabled=0A[    1.469912] [dr=
m] Initialized drm 1.1.0 20060810=0A[    1.492826] brd: module loaded=0A[  =
  1.507787] loop: module loaded=0A[    1.514301] ti-qspi 47900000.qspi: mem=
ory mapped resource not required=0A[    1.637575] usbcore: registered new i=
nterface driver asix=0A[    1.643562] usbcore: registered new interface dri=
ver ax88179_178a=0A[    1.650126] usbcore: registered new interface driver =
cdc_ether=0A[    1.656360] usbcore: registered new interface driver smsc95x=
x=0A[    1.662529] usbcore: registered new interface driver net1080=0A[    =
1.668542] usbcore: registered new interface driver cdc_subset=0A[    1.6748=
73] usbcore: registered new interface driver zaurus=0A[    1.680915] usbcor=
e: registered new interface driver cdc_ncm=0A[    1.689162] usbcore: regist=
ered new interface driver cdc_wdm=0A[    1.695225] usbcore: registered new =
interface driver usb-storage=0A[    1.701734] usbcore: registered new inter=
face driver usbtest=0A[    1.710179] mousedev: PS/2 mouse device common for=
 all mice=0A[    1.719113] i2c /dev entries driver=0A[    1.722844] Driver =
for 1-wire Dallas network protocol.=0A[    1.730956] omap_wdt: OMAP Watchdo=
g Timer Rev 0x01: initial timeout 60 sec=0A[    1.739545] of_get_named_gpio=
d_flags exited with status 0=0A[    1.739570] of_get_named_gpiod_flags: can=
't parse gpios property of node '/ocp/mmc@48060000[0]'=0A[    1.779480] of_=
get_named_gpiod_flags exited with status 0=0A[    1.779514] of_get_named_gp=
iod_flags exited with status 0=0A[    1.779534] of_get_named_gpiod_flags ex=
ited with status 0=0A[    1.779552] of_get_named_gpiod_flags exited with st=
atus 0=0A[    1.779574] of_get_named_gpiod_flags exited with status 0=0A[  =
  1.780352] of_get_named_gpiod_flags exited with status 0=0A[    1.780779] =
of_get_named_gpiod_flags exited with status 0=0A[    1.781019] of_get_named=
_gpiod_flags exited with status 0=0A[    1.781623] ledtrig-cpu: registered =
to indicate activity on CPUs=0A[    1.788329] usbcore: registered new inter=
face driver usbhid=0A[    1.794324] usbhid: USB HID core driver=0A[    1.80=
9543] davinci_evm sound: ASoC: CODEC (null) not registered=0A[    1.816133]=
 davinci_evm sound: snd_soc_register_card failed (-517)=0A[    1.822768] pl=
atform sound: Driver davinci_evm requests probe deferral=0A[    1.830332] o=
profile: no performance counters=0A[    1.835756] oprofile: using timer int=
errupt.=0A[    1.840886] TCP: cubic registered=0A[    1.844386] Initializin=
g XFRM netlink socket=0A[    1.849159] NET: Registered protocol family 17=
=0A[    1.853893] NET: Registered protocol family 15=0A[    1.858902] Key t=
ype dns_resolver registered=0A[    1.863603] omap_voltage_late_init: Voltag=
e driver support not added=0A[    1.870320] sr_dev_init: No voltage domain =
specified for smartreflex0. Cannot initialize=0A[    1.879008] sr_dev_init:=
 No voltage domain specified for smartreflex1. Cannot initialize=0A[    1.8=
88357] ThumbEE CPU extension supported.=0A[    1.892991] Registering SWP/SW=
PB emulation handler=0A[    1.898015] SmartReflex Class3 initialized=0A[   =
 1.920861] omap_i2c 44e0b000.i2c: bus 0 rev0.12 at 100 kHz=0A[    1.931729]=
 of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/i2c@480=
2a000/edt-ft5306@38[0]'=0A[    1.931815] of_get_named_gpiod_flags exited wi=
th status 0=0A[    1.957462] input: EP0820M09 as /devices/44000000.ocp/4802=
a000.i2c/i2c-1/1-0038/input/input0=0A[    1.971965] of_get_named_gpiod_flag=
s: can't parse gpios property of node '/ocp/i2c@4802a000/tlv320aic3106@1b[0=
]'=0A[    1.972971] omap_i2c 4802a000.i2c: bus 1 rev0.12 at 100 kHz=0A[    =
1.984339] davinci_evm sound: tlv320aic3x-hifi <-> 4803c000.mcasp mapping ok=
=0A[    2.005220] mmc0: host does not support reading read-only switch. ass=
uming write-enable.=0A[    2.033262] mmc0: new high speed SDHC card at addr=
ess aaaa=0A[    2.041958] mmcblk0: mmc0:aaaa SU32G 29.7 GiB =0A[    2.05261=
2]  mmcblk0: p1 p2=0A[    2.078729] davinci_mdio 4a101000.mdio: davinci mdi=
o revision 1.6=0A[    2.085161] davinci_mdio 4a101000.mdio: detected phy ma=
sk ffffffcf=0A[    2.095026] libphy: 4a101000.mdio: probed=0A[    2.099363]=
 davinci_mdio 4a101000.mdio: phy[4]: device 4a101000.mdio:04, driver unknow=
n=0A[    2.107718] davinci_mdio 4a101000.mdio: phy[5]: device 4a101000.mdio=
:05, driver unknown=0A[    2.117044] cpsw 4a100000.ethernet: Detected MACID=
 =3D 34:b1:f7:31:36:c8=0A[    2.125812] cpsw 4a100000.ethernet: cpsw: Detec=
ted MACID =3D 34:b1:f7:31:36:ca=0A[    2.134809] drivers/rtc/hctosys.c: una=
ble to open rtc device (rtc0)=0A[    2.141443] sr_init: No PMIC hook to ini=
t smartreflex=0A[    2.146894] sr_init: platform driver register failed for=
 SR=0A[    2.166401] v18_fixed: disabling=0A[    2.169975] v33_fixed: disab=
ling=0A[    2.173544] ALSA device list:=0A[    2.176642]   #0: AM437x-SK-EV=
M=0A[    2.201031] EXT4-fs (mmcblk0p2): warning: mounting fs with errors, r=
unning e2fsck is recommended=0A[    2.225753] EXT4-fs (mmcblk0p2): mounted =
filesystem with ordered data mode. Opts: (null)=0A[    2.234490] VFS: Mount=
ed root (ext4 filesystem) on device 179:2.=0A[    2.252480] devtmpfs: mount=
ed=0A[    2.256023] Freeing unused kernel memory: 412K (c0895000 - c08fc000=
)=0A[    2.685504] systemd[1]: systemd 204 running in system mode. (+PAM +L=
IBWRAP +AUDIT +SELINUX +IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ)=0A[ =
   2.760454] systemd[1]: Failed to insert module 'autofs4'=0A[    2.766427]=
 systemd[1]: Failed to insert module 'ipv6'=0A[    2.774768] systemd[1]: Se=
t hostname to <saruman>.=0A[    2.808465] random: systemd urandom read with=
 28 bits of entropy available=0A[    3.300126] systemd[1]: Cannot add depen=
dency job for unit display-manager.service, ignoring: Unit display-manager.=
service failed to load: No such file or directory. See system logs and 'sys=
temctl status display-manager.service' for details.=0A[    3.324202] system=
d[1]: Starting Forward Password Requests to Wall Directory Watch.=0A[    3.=
334253] systemd[1]: Started Forward Password Requests to Wall Directory Wat=
ch.=0A[    3.342479] systemd[1]: Expecting device dev-ttyO0.device...=0A[  =
  3.368984] systemd[1]: Starting Remote File Systems (Pre).=0A[    3.389023=
] systemd[1]: Reached target Remote File Systems (Pre).=0A[    3.395507] sy=
stemd[1]: Starting Syslog Socket.=0A[    3.418963] systemd[1]: Listening on=
 Syslog Socket.=0A[    3.424202] systemd[1]: Starting /dev/initctl Compatib=
ility Named Pipe.=0A[    3.448949] systemd[1]: Listening on /dev/initctl Co=
mpatibility Named Pipe.=0A[    3.456327] systemd[1]: Starting Delayed Shutd=
own Socket.=0A[    3.478946] systemd[1]: Listening on Delayed Shutdown Sock=
et.=0A[    3.485074] systemd[1]: Starting Encrypted Volumes.=0A[    3.50894=
1] systemd[1]: Reached target Encrypted Volumes.=0A[    3.514780] systemd[1=
]: Starting Dispatch Password Requests to Console Directory Watch.=0A[    3=
=2E523831] systemd[1]: Started Dispatch Password Requests to Console Direct=
ory Watch.=0A[    3.532347] systemd[1]: Starting Paths.=0A[    3.548931] sy=
stemd[1]: Reached target Paths.=0A[    3.553989] systemd[1]: Starting Arbit=
rary Executable File Formats File System Automount Point.=0A[    3.563713] =
systemd[1]: Failed to open /dev/autofs: No such file or directory=0A[    3.=
571367] systemd[1]: Failed to initialize automounter: No such file or direc=
tory=0A[    3.618929] systemd[1]: Failed to set up automount Arbitrary Exec=
utable File Formats File System Automount Point.=0A[    3.629824] systemd[1=
]: Unit proc-sys-fs-binfmt_misc.automount entered failed state.=0A[    3.63=
8592] systemd[1]: Starting udev Kernel Socket.=0A[    3.658954] systemd[1]:=
 Listening on udev Kernel Socket.=0A[    3.665034] systemd[1]: Starting ude=
v Control Socket.=0A[    3.688957] systemd[1]: Listening on udev Control So=
cket.=0A[    3.694781] systemd[1]: Starting Journal Socket.=0A[    3.718951=
] systemd[1]: Listening on Journal Socket.=0A[    3.724338] systemd[1]: Sta=
rting Syslog.=0A[    3.748933] systemd[1]: Reached target Syslog.=0A[    3.=
753870] systemd[1]: Mounting Debug File System...=0A[    3.785203] systemd[=
1]: Starting udev Coldplug all Devices...=0A[    3.840840] systemd[1]: Star=
ting Apply Kernel Variables...=0A[    3.874612] systemd[1]: Mounting POSIX =
Message Queue File System...=0A[    3.921720] systemd[1]: Started Set Up Ad=
ditional Binary Formats.=0A[    3.944007] systemd[1]: Starting Create stati=
c device nodes in /dev...=0A[    3.998953] systemd[1]: Starting Load Kernel=
 Modules...=0A[    4.044802] systemd[1]: Mounted Huge Pages File System.=0A=
[    4.062493] systemd[1]: Starting Journal Service...=0A[    4.102994] sys=
temd[1]: Started Journal Service.=0A[    4.152118] systemd[1]: Starting Swa=
p.=0A[    4.179133] systemd[1]: Reached target Swap.=0A[    4.183830] syste=
md[1]: Started File System Check on Root Device.=0A[    4.239163] systemd[1=
]: Mounted Debug File System.=0A[    4.279656] systemd[1]: Started Apply Ke=
rnel Variables.=0A[    4.309161] systemd[1]: Mounted POSIX Message Queue Fi=
le System.=0A[    4.369173] systemd[1]: Started Create static device nodes =
in /dev.=0A[    4.377011] systemd[1]: systemd-modules-load.service: main pr=
ocess exited, code=3Dexited, status=3D1/FAILURE=0A[    4.449551] systemd[1]=
: Failed to start Load Kernel Modules.=0A[    4.455567] systemd[1]: Unit sy=
stemd-modules-load.service entered failed state.=0A[    4.479326] systemd[1=
]: Mounted FUSE Control File System.=0A[    4.485175] systemd[1]: Mounted C=
onfiguration File System.=0A[    4.500222] systemd[1]: Starting udev Kernel=
 Device Manager...=0A[    4.645600] systemd-udevd[906]: starting version 20=
4=0A[    7.049697] random: nonblocking pool is initialized=0A[   11.569503]=
 omap-sham 53100000.sham: hw accel on OMAP rev 0.0=0A[   11.671041] of_get_=
named_gpiod_flags exited with status 0=0A[   11.671079] of_get_named_gpiod_=
flags exited with status 0=0A[   11.671098] of_get_named_gpiod_flags exited=
 with status 0=0A[   11.671118] of_get_named_gpiod_flags exited with status=
 0=0A[   11.672110] input: matrix_keypad@0 as /devices/matrix_keypad@0/inpu=
t/input1=0A[   11.690762] omap-aes 53501000.aes: OMAP AES hw accel rev: 0.1=
=0A[   11.734946] systemd-udevd[1305]: renamed network interface eth0 to et=
h5=0A[   11.776928] systemd-udevd[1306]: renamed network interface eth1 to =
eth9=0A[   11.887060] omap-des 53701000.des: _od_fail_runtime_resume: FIXME=
: missing hwmod/omap_dev info=0A[   11.896258] omap-des 53701000.des: omap_=
des_probe: failed to get_sync(-19)=0A[   11.903589] omap-des 53701000.des: =
initialization failed.=0A[   12.367972] net eth5: initializing cpsw version=
 1.15 (0)=0A[   12.450581] net eth5: phy found : id is : 0x221621=0A[   12.=
627647] net eth9: initializing cpsw version 1.15 (0)=0A[   12.719356] net e=
th9: phy found : id is : 0x221621=0A[   15.590303] xhci-hcd xhci-hcd.0.auto=
: xHCI Host Controller=0A[   15.605892] xhci-hcd xhci-hcd.0.auto: new USB b=
us registered, assigned bus number 1=0A[   15.616209] xhci-hcd xhci-hcd.0.a=
uto: irq 206, io mem 0x483d0000=0A[   15.631707] usb usb1: New USB device f=
ound, idVendor=3D1d6b, idProduct=3D0002=0A[   15.639062] usb usb1: New USB =
device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1=0A[   15.646639] usb=
 usb1: Product: xHCI Host Controller=0A[   15.651819] usb usb1: Manufacture=
r: Linux 3.16.0-rc1-next-20140617-00002-g01760e8 xhci-hcd=0A[   15.660494] =
usb usb1: SerialNumber: xhci-hcd.0.auto=0A[   15.681494] hub 1-0:1.0: USB h=
ub found=0A[   15.687779] hub 1-0:1.0: 1 port detected=0A[   15.702400] xhc=
i-hcd xhci-hcd.0.auto: xHCI Host Controller=0A[   15.712261] xhci-hcd xhci-=
hcd.0.auto: new USB bus registered, assigned bus number 2=0A[   15.722722] =
usb usb2: New USB device found, idVendor=3D1d6b, idProduct=3D0003=0A[   15.=
730008] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, SerialNumbe=
r=3D1=0A[   15.737565] usb usb2: Product: xHCI Host Controller=0A[   15.742=
698] usb usb2: Manufacturer: Linux 3.16.0-rc1-next-20140617-00002-g01760e8 =
xhci-hcd=0A[   15.751355] usb usb2: SerialNumber: xhci-hcd.0.auto=0A[   15.=
769160] hub 2-0:1.0: USB hub found=0A[   15.774008] hub 2-0:1.0: 1 port det=
ected=0A[   19.800744] DISPC: dispc_runtime_put=0A[   19.800870] DISPC: dis=
pc_save_context=0A[   19.800903] DISPC: context saved=0A[   19.802234] DSS:=
 dss_save_context=0A[   19.802251] DSS: context saved=0A[   20.495024] DPI:=
 dpi_set_timings=0A[   20.495115] DISPC: dispc_runtime_get=0A[   20.495172]=
 DSS: dss_restore_context=0A[   20.495177] DSS: context restored=0A[   20.4=
95228] DSS: set fck to 198000000=0A[   20.497271] APPLY: writing mgr 0 regs=
=0A[   20.497335] APPLY: writing ovl 0 regs=0A[   20.497339] APPLY: writing=
 ovl 0 regs extra=0A[   20.497342] APPLY: writing ovl 1 regs=0A[   20.49734=
5] APPLY: writing ovl 1 regs extra=0A[   20.497347] APPLY: writing ovl 2 re=
gs=0A[   20.497350] APPLY: writing ovl 2 regs extra=0A[   20.497353] APPLY:=
 writing mgr 0 regs extra=0A[   20.497358] DISPC: channel 0 xres 480 yres 2=
72=0A[   20.497363] DISPC: pck 9000000=0A[   20.497368] DISPC: hsw 4 hfp 8 =
hbp 43 vsw 10 vfp 4 vbp 12=0A[   20.497373] DISPC: vsync_level 1 hsync_leve=
l 1 data_pclk_edge 1 de_level 0 sync_pclk_edge 0=0A[   20.497376] DISPC: hs=
ync 16822Hz, vsync 56Hz=0A[   20.497382] DISPC: lck =3D 198000000 (1)=0A[  =
 20.497386] DISPC: pck =3D 9000000 (22)=0A[   34.108937] usb 1-1: new full-=
speed USB device number 2 using xhci-hcd=0A[   34.252214] usb 1-1: New USB =
device found, idVendor=3D413c, idProduct=3D1002=0A[   34.259309] usb 1-1: N=
ew USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0=0A[   34.2667=
81] usb 1-1: Product: Dell USB Keyboard Hub=0A[   34.271972] usb 1-1: Manuf=
acturer: Dell=0A[   34.280876] usb 1-1: ep 0x81 - rounding interval to 1024=
 microframes, ep desc says 2040 microframes=0A[   34.399613] hub 1-1:1.0: U=
SB hub found=0A[   34.403909] hub 1-1:1.0: 3 ports detected=0A[   34.698906=
] usb 1-1.1: new full-speed USB device number 3 using xhci-hcd=0A[   34.800=
117] usb 1-1.1: New USB device found, idVendor=3D413c, idProduct=3D2002=0A[=
   34.807327] usb 1-1.1: New USB device strings: Mfr=3D1, Product=3D2, Seri=
alNumber=3D0=0A[   34.815071] usb 1-1.1: Product: Dell USB Keyboard Hub=0A[=
   34.820394] usb 1-1.1: Manufacturer: Dell=0A[   34.830267] usb 1-1.1: ep =
0x81 - rounding interval to 128 microframes, ep desc says 192 microframes=
=0A[   34.839897] usb 1-1.1: ep 0x82 - rounding interval to 256 microframes=
, ep desc says 384 microframes=0A[   34.917091] input: Dell Dell USB Keyboa=
rd Hub as /devices/44000000.ocp/483c0000.omap_dwc3/483d0000.usb/xhci-hcd.0.=
auto/usb1/1-1/1-1.1/1-1.1:1.0/0003:413C:2002.0001/input/input2=0A[   34.950=
963] hid-generic 0003:413C:2002.0001: input: USB HID v1.10 Keyboard [Dell D=
ell USB Keyboard Hub] on usb-xhci-hcd.0.auto-1.1/input0=0A[   34.974264] in=
put: Dell Dell USB Keyboard Hub as /devices/44000000.ocp/483c0000.omap_dwc3=
/483d0000.usb/xhci-hcd.0.auto/usb1/1-1/1-1.1/1-1.1:1.1/0003:413C:2002.0002/=
input/input3=0A[   35.014320] hid-generic 0003:413C:2002.0002: input: USB H=
ID v1.10 Device [Dell Dell USB Keyboard Hub] on usb-xhci-hcd.0.auto-1.1/inp=
ut1=0A[   59.449665] APPLY: omap_dss_mgr_apply(lcd)=0A[   59.449712] APPLY:=
 writing mgr 0 regs=0A[   59.449750] APPLY: writing ovl 0 regs=0A[   59.449=
765] DISPC: dispc_ovl_setup 0, pa 0xae840000, pa_uv 0x00000000, sw 480, 0,0=
, 480x272 -> 480x272, cmode 40, rot 0, mir 0, chan 0 repl 1=0A[   59.449778=
] DISPC: calc_rot(0): scrw 480, 480x272=0A[   59.449784] DISPC: offset0 0, =
offset1 0, row_inc 1, pix_inc 1=0A[   59.449792] DISPC: 0,0 480x272 -> 480x=
272=0A[   59.449800] APPLY: writing ovl 0 regs extra=0A[   59.449803] APPLY=
: writing ovl 1 regs=0A[   59.449806] APPLY: writing ovl 1 regs extra=0A[  =
 59.449808] APPLY: writing ovl 2 regs=0A[   59.449811] APPLY: writing ovl 2=
 regs extra=0A[   59.449814] APPLY: writing mgr 0 regs extra=0A[   59.44987=
5] DISPC: GO LCD=0A[   59.451528] APPLY: writing mgr 0 regs=0A[   59.451585=
] APPLY: writing ovl 0 regs=0A[   59.451590] APPLY: writing ovl 0 regs extr=
a=0A[   59.451593] APPLY: writing ovl 1 regs=0A[   59.451595] APPLY: writin=
g ovl 1 regs extra=0A[   59.451598] APPLY: writing ovl 2 regs=0A[   59.4516=
01] APPLY: writing ovl 2 regs extra=0A[   59.451603] APPLY: writing mgr 0 r=
egs extra=0Aroot@saruman:~# =0A
--1yeeQ81UyVL57Vl7--

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJToD+2AAoJEIaOsuA1yqREa24QAI3TgIL0hlM0Xc/Tm6OFiS6A
syu7uRMd6G8CkuSIcoNMXt1/lZ58xKshTrV4T48eXAgX7jFzGQXiyoP04tbzKoWs
afOvemsnV/XFHlXE7g00TnkBSIW4lF9CjY3+ghjNXYexakBAaN8hPR5jLjrFQ5xO
QSx5R05Pv4oEdYHB9L0bnQiZ8bU2zXRqYd2fSRuL/TwDSjUKwZ5vioMVkivByLGj
8wFZLQvd85Fo2rpLB6sNvn5h88yDjKfXnR4DG1e0hN8LNhGLvvtcYDOlF05pZBtM
IkeHiLUyG9mj9XdlAzoVDtkbhxl1bI3Xs/IzYYBjvkw287NsJi94dIqFVbAbdZAq
U3dmsmUmPQmIhNh93rSoHYmBIZwH5O6w3iUdVi5hiinAntwM2+7yxkTmHUadPp30
g7dSY44WP+J7mz7/3vUZxQYqDNpxuySeqbDA9KdNzadXBtxNlI+wkyK7tzfzvDVT
4xIPXb3UWdlh1UsSaymiOv/VmOYcGH+HLm9hUiBCpaydMj4CbHnhtbYYG4sEec3O
9w379Hce/ztTS60DPWhLC09cjy7shCFPyGPzfQ1agFsn+8wCMkyicpacxsKKq2H0
67l6ur85i71vgj/4TayqqAmXkcnsv7GAhOrMv6GFersqSsJnHzL9NkAp39y1rsXc
M960xMiVv/jCGn6170Aj
=wFlH
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
