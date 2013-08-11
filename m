From: Sebastian Reichel <sre@debian.org>
Subject: Pandaboard: DT Boot fails when initramfs is loaded
Date: Sun, 11 Aug 2013 15:31:21 +0200
Message-ID: <20130811133119.GA15024@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:44051 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753513Ab3HKNb0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 11 Aug 2013 09:31:26 -0400
Received: from comu.ring0.de (unknown [127.0.0.1])
	by smtp.ring0.de (Postfix) with ESMTP id 4BDFF2C58F9A
	for <linux-omap@vger.kernel.org>; Sun, 11 Aug 2013 15:31:24 +0200 (CEST)
Received: (from spamd@localhost)
	by comu.ring0.de (8.13.8/8.13.8/Submit) id r7BDVO1j025572
	for linux-omap@vger.kernel.org; Sun, 11 Aug 2013 15:31:24 +0200
Received: from sre.ring0.de (unknown [83.68.216.121])
	by smtp.ring0.de (Postfix) with ESMTP id 6AD8B2C58F94
	for <linux-omap@vger.kernel.org>; Sun, 11 Aug 2013 15:31:22 +0200 (CEST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I try to boot the mainline omap kernel (I tried current mainline
kernel from git and mainline 3.10-rc1+) on my Pandaboard using
U-Boot as follows:

mmcinfo
ext2load mmc 0:2 0x80000000 /boot/uImage
ext2load mmc 0:2 0x81600000 /boot/uInitrd
ext2load mmc 0:2 0x90000000 /boot/omap4-panda.dtb
bootm 0x80000000 0x81600000 0x90000000

The kernel does start booting, but it fails once it should load the
initramfs (dmesg attached below). I can boot the 3.10 kernel when
not booting with DT:

mmcinfo
ext2load mmc 0:2 0x80000000 /boot/uImage
ext2load mmc 0:2 0x81600000 /boot/uInitrd
ext2load mmc 0:2 0x90000000 /boot/omap4-panda.dtb
bootm 0x80000000 0x81600000

Can somebody tell me what I'm doing wrong?

Here's the dmesg of the DT boot:

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.10.0-rc1+ (sre@earth) (gcc version 4.7.1 (De=
bian 4.7.1-7) ) #27 SMP Sat May 25 17:55:27 CEST 2013
[    0.000000] CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=3D10c=
5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instr=
uction cache
[    0.000000] Machine: Generic OMAP4 (Flattened Device Tree), model: TI OM=
AP4 PandaBoard
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] cma: dma_contiguous_reserve(limit af800000)
[    0.000000] cma: dma_contiguous_reserve: reserving 16 MiB for global area
[    0.000000] cma: dma_declare_contiguous(size 1000000, base 00000000, lim=
it af800000)
[    0.000000] cma: CMA: reserved 16 MiB at ae800000
[    0.000000] Memory policy: ECC disabled, Data cache writealloc
[    0.000000] On node 0 totalpages: 261888
[    0.000000] free_area_init_node: node 0, pgdat c05ada80, node_mem_map c0=
625000
[    0.000000]   Normal zone: 1520 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 194560 pages, LIFO batch:31
[    0.000000]   HighMem zone: 528 pages used for memmap
[    0.000000]   HighMem zone: 67328 pages, LIFO batch:15
[    0.000000] OMAP4430 ES2.2
[    0.000000] PERCPU: Embedded 9 pages/cpu @c0e34000 s13120 r8192 d15552 u=
36864
[    0.000000] pcpu-alloc: s13120 r8192 d15552 u36864 alloc=3D9*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 260368
[    0.000000] Kernel command line: console=3DttyO2,115200n8 root=3D/dev/mm=
cblk0p2 rw rootwait vram=3D32M omapfb.vram=3D0:16M,1:16M omapdss.def_disp=
=3Dhdmi loglevel=3D8 earlyprintk
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 by=
tes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 byte=
s)
[    0.000000] Memory: 1017MB 6MB =3D 1023MB total
[    0.000000] Memory: 1010708k/1010708k available, 37868k reserved, 264324=
K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc04e49cc   (4979 kB)
[    0.000000]       .init : 0xc04e5000 - 0xc0534340   ( 317 kB)
[    0.000000]       .data : 0xc0536000 - 0xc05aff20   ( 488 kB)
[    0.000000]        .bss : 0xc05aff20 - 0xc0624014   ( 465 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=3D4 to nr_cpu_ids=3D2.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps eve=
ry 131071999ms
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000000] smp_twd: clock not found -2
[    0.000000] Console: colour dummy device 80x30
[    0.014617] Calibrating delay loop... 1594.16 BogoMIPS (lpj=3D7970816)
[    0.109130] pid_max: default: 32768 minimum: 301
[    0.114135] Security Framework initialized
[    0.118560] Mount-cache hash table entries: 512
[    0.127990] Initializing cgroup subsys devices
[    0.132659] Initializing cgroup subsys freezer
[    0.137390] Initializing cgroup subsys net_cls
[    0.142028] Initializing cgroup subsys blkio
[    0.146545] Initializing cgroup subsys perf_event
[    0.151611] CPU: Testing write buffer coherency: ok
[    0.157257] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.163146] Calibrating local timer... 399.11MHz.
[    0.227325] Setting up static identity map for 0xc036e158 - 0xc036e1b0
[    0.234191] L310 cache controller enabled
[    0.238464] l2x0: 16 ways, CACHE_ID 0x410000c4, AUX_CTRL 0x7e470000, Cac=
he size: 1048576 B
[    0.248535] CPU1: Booted secondary processor
[    0.337036] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.337158] Brought up 2 CPUs
[    0.350677] SMP: Total of 2 processors activated (3188.32 BogoMIPS).
[    0.357299] CPU: All CPU(s) started in SVC mode.
[    0.362823] devtmpfs: initialized
[    0.425354] pinctrl core: initialized pinctrl subsystem
[    0.431152] regulator-dummy: no parameters
[    0.435516] cma: cma_init_reserved_areas()
[    0.439819] cma: cma_create_area(base 000ae800, count 1000)
[    0.446868] cma: cma_create_area: returned ed8ee240
[    0.452178] NET: Registered protocol family 16
[    0.456970] cma: dma_alloc_from_contiguous(cma ed8ee240, count 64, align=
 6)
[    0.465972] cma: dma_alloc_from_contiguous(): returned c0bf5000
[    0.473144] DMA: preallocated 256 KiB pool for atomic coherent allocatio=
ns
[    0.492858] OMAP GPIO hardware version 0.1
[    0.500976] omap-gpmc 50000000.gpmc: error: clk_get
[    0.506103] omap-gpmc: probe of 50000000.gpmc failed with error -2
[    0.519836] No ATAGs?
[    0.522003] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchp=
oint registers.
[    0.530578] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.537719] OMAP DMA hardware revision 0.0
[    0.543151] ARM PMU: not yet supported on OMAP4430 due to missing CTI dr=
iver
[    0.553436] bio: create slab <bio-0> at 0
[    0.569732] omap-dma-engine 4a056000.dma-controller: OMAP DMA engine dri=
ver
[    0.577484] hsusb1_reset: 3300 mV=20
[    0.581298] hsusb1_vbus: 3300 mV=20
[    0.586425] usbcore: registered new interface driver usbfs
[    0.592193] usbcore: registered new interface driver hub
[    0.597869] usbcore: registered new device driver usb
[    0.603424] omap_i2c 48070000.i2c: could not find pctldev for node /ocp/=
pinmux@4a100040/pinmux_i2c1_pins, deferring probe
[    0.614776] platform 48070000.i2c: Driver omap_i2c requests probe deferr=
al
[    0.621948] omap_i2c 48072000.i2c: could not find pctldev for node /ocp/=
pinmux@4a100040/pinmux_i2c2_pins, deferring probe
[    0.633300] platform 48072000.i2c: Driver omap_i2c requests probe deferr=
al
[    0.640472] omap_i2c 48060000.i2c: could not find pctldev for node /ocp/=
pinmux@4a100040/pinmux_i2c3_pins, deferring probe
[    0.651824] platform 48060000.i2c: Driver omap_i2c requests probe deferr=
al
[    0.658996] omap_i2c 48350000.i2c: could not find pctldev for node /ocp/=
pinmux@4a100040/pinmux_i2c4_pins, deferring probe
[    0.670349] platform 48350000.i2c: Driver omap_i2c requests probe deferr=
al
[    0.678436] Switching to clocksource 32k_counter
[    0.700286] NET: Registered protocol family 2
[    0.705566] TCP established hash table entries: 8192 (order: 4, 65536 by=
tes)
[    0.713012] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.719879] TCP: Hash tables configured (established 8192 bind 8192)
[    0.726593] TCP: reno registered
[    0.730010] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.736267] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.743225] NET: Registered protocol family 1
[    0.748992] Unpacking initramfs...
[    0.752593] Unable to handle kernel paging request at virtual address ff=
a23000
[    0.760101] pgd =3D c0004000
[    0.762939] [ffa23000] *pgd=3D00000000
[    0.766723] Internal error: Oops: 5 [#1] SMP ARM
[    0.771545] Modules linked in:
[    0.774749] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.10.0-rc1+ #27
[    0.781463] task: ed8639c0 ti: ed864000 task.ti: ed864000
[    0.787109] PC is at unpack_to_rootfs+0x9c/0x294
[    0.791931] LR is at kmem_cache_alloc_trace+0x2c/0x154
[    0.797302] pc : [<c04e63fc>]    lr : [<c00f97dc>]    psr: 20000113
[    0.797302] sp : ed865f00  ip : ed80dc44  fp : 00000000
[    0.809265] r10: c051e4f0  r9 : c04e5278  r8 : c051e4f0
[    0.814727] r7 : ffa23000  r6 : 004def90  r5 : c051e464  r4 : c060e024
[    0.821502] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : eda36000
[    0.828277] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 kernel
[    0.835876] Control: 10c5387d  Table: 8000404a  DAC: 00000015
[    0.841857] Process swapper/0 (pid: 1, stack limit =3D 0xed864240)
[    0.848114] Stack: (0xed865f00 to 0xed866000)
[    0.852691] 5f00: c04e5278 00000000 00000000 c0366d8c c04436d0 ed865f2c =
c05affb4 c051e464
[    0.861175] 5f20: c0530330 c05aff40 c04e6ad4 c04e5278 00000000 c04e6b20 =
00000005 c051e464
[    0.869659] 5f40: c0530330 c0008788 c04e6ad4 00000000 c0530330 00000006 =
00000005 c051e464
[    0.878143] 5f60: c0530330 c05aff40 0000005e c04e5278 c051e474 c04e5984 =
00000005 00000005
[    0.886627] 5f80: c04e5278 00000000 00000000 c0361d30 00000000 00000000 =
00000000 00000000
[    0.895111] 5fa0: 00000000 c0361d38 00000000 c000dd18 00000000 00000000 =
00000000 00000000
[    0.903594] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.912078] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 =
aa9aa2aa aaaaaaaa
[    0.920562] [<c04e63fc>] (unpack_to_rootfs+0x9c/0x294) from [<c04e6b20>]=
 (populate_rootfs+0x4c/0x124)
[    0.930145] [<c04e6b20>] (populate_rootfs+0x4c/0x124) from [<c0008788>] =
(do_one_initcall+0x90/0x140)
[    0.939605] [<c0008788>] (do_one_initcall+0x90/0x140) from [<c04e5984>] =
(kernel_init_freeable+0x160/0x22c)
[    0.949645] [<c04e5984>] (kernel_init_freeable+0x160/0x22c) from [<c0361=
d38>] (kernel_init+0x8/0xe4)
[    0.959106] [<c0361d38>] (kernel_init+0x8/0xe4) from [<c000dd18>] (ret_f=
rom_fork+0x14/0x3c)
[    0.967773] Code: e1c821f0 e1a0a008 e5881000 ea00004c (e5d73000)=20
[    0.974151] ---[ end trace 68be233e8ca937ac ]---
[    0.979095] Kernel panic - not syncing: Attempted to kill init! exitcode=
=3D0x0000000b
[    0.979095]=20
[    0.988647] CPU1: stopping
[    0.991516] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D      3.10.0-=
rc1+ #27
[    0.999206] [<c0014a20>] (unwind_backtrace+0x0/0xe0) from [<c0011950>] (=
show_stack+0x10/0x14)
[    1.008056] [<c0011950>] (show_stack+0x10/0x14) from [<c0012e10>] (handl=
e_IPI+0xc0/0x124)
[    1.016540] [<c0012e10>] (handle_IPI+0xc0/0x124) from [<c0008668>] (gic_=
handle_irq+0x58/0x60)
[    1.025390] [<c0008668>] (gic_handle_irq+0x58/0x60) from [<c000d8c0>] (_=
_irq_svc+0x40/0x50)
[    1.034057] Exception stack(0xed8a3fa0 to 0xed8a3fe8)
[    1.039337] 3fa0: ffffffed 00000000 0090c000 00000000 ed8a2000 ed8a2000 =
c0372958 c05b0284
[    1.047821] 3fc0: 8000406a 411fc092 00000000 00000000 00000001 ed8a3fe8 =
c000ee68 c000ee6c
[    1.056304] 3fe0: 60000113 ffffffff
[    1.059967] [<c000d8c0>] (__irq_svc+0x40/0x50) from [<c000ee6c>] (arch_c=
pu_idle+0x30/0x38)
[    1.068572] [<c000ee6c>] (arch_cpu_idle+0x30/0x38) from [<c0074778>] (cp=
u_startup_entry+0x134/0x1cc)
[    1.078033] [<c0074778>] (cpu_startup_entry+0x134/0x1cc) from [<80362c44=
>] (0x80362c44)

-- Sebastian

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCAAGBQJSB5InAAoJENju1/PIO/qa4pkQAJ2COzZ4MGcAQW6w6HY9xNDE
MhdfvbQAwYSV3+91xAvBLDrMYQpRPRG+LUyfdav2+taGyU4dmdQKn10cFSGVodoY
GchroqobJkKZKDvwpD1fAjZyDghrhE7vvwHVYbfC/7Y+ZOmqfTaEyXDByv5o9dsh
ZDFmaxX3RBw1q3sM6AYgNP8tjPjqB/HktmYcD4GOouqDnsYvLgTHkEd0hPNl2IAz
K3/+eFhsFMZhLkg0TNCmkck/X1B3W18phgVGYc7KvRn0SDnpi2MpuS8xDxOp2H+R
ADqDK7Q2FJiEmFJa5VC6H9e/7/rhS8zR3v4AWbDXfcY6MHXdJXXdu2/fBN0T1tC9
3EJueCO0vTnbd1+M5cFo0d/WoqVPsfhOKwidwP0EcPrmzO3Grs/rN2WKsFKUyL0p
4yteTumCXM+5zCL01pP/mXRX3nRRrt/z2N46m4eKxhxuRxZlYNtqxl1VRH1jfL1v
YCTezpS4Jokzfi3+XkfPo0mbFRGuVJQ1oWOWWQ5TRCpDIaCefyy63fuChLPdjT0l
g6sWztUGKnHb6o4g5ASPLpk5MFBNQ/oluCBtXL8cgux0bpZFiz5FpDZSc7giRGEG
5OYgdgVOWiJVgX2ZDGiN8SDd+xAtCsXdZSIAtAmPi0PDbdsaFNvmZOGQMffyfAgQ
+HVfhIv9EeaXgBNlWNp5
=eAGM
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
