From: =?windows-1251?B?yvPn5ezq7iDA6+Xq8eDt5PA=?= <kuzemkoa@rambler.ru>
Subject: [OMAP4] 5AI.1.7 Android ICS Release on the omap4430 ES2.3 (HS) device. - omap_hwmod: omap_hwmod_setup_all: _init_clocks failed
Date: Mon, 13 Feb 2012 08:16:28 +0400
Message-ID: <377158626.1329106588.141375896.47996@mperl104.rambler.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx-out-wr-1.rambler.ru ([81.19.92.40]:58623 "EHLO
	mx-out-wr-1.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292Ab2BMEQb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 12 Feb 2012 23:16:31 -0500
Received: from mperl104.rambler.ru (mperl104.rambler.ru [10.32.5.104])
	by mx-out-wr-1.rambler.ru (Postfix) with ESMTP id 6379F13FDAAF
	for <linux-omap@vger.kernel.org>; Mon, 13 Feb 2012 08:16:29 +0400 (MSK)
Received: from mperl104.rambler.ru (localhost [127.0.0.1])
	by mperl104.rambler.ru (Postfix) with ESMTP id 60F3082742D
	for <linux-omap@vger.kernel.org>; Mon, 13 Feb 2012 08:16:29 +0400 (MSK)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org



--
=CA=F3=E7=E5=EC=EA=EE =C0=EB=E5=EA=F1=E0=ED=E4=F0.Hello!
I try boot kernel 5AI.1.7 Android ICS Release from=20
http://www.omapzoom.com/ on the omap4430 ES2.3 (HS) device (Nook Tablet=
)=20
and recive such log:

Starting kernel ...

<5>Linux version 3.1.0-dirty (nook@localhost) (gcc version 4.4.1=20
(Sourcery G++ Lite 2010q1-202) ) #39 SMP PREEMPT Sun Feb 12 19:02:47 EE=
T=20
2012
CPU: ARMv7 Processor [411fc093] revision 3 (ARMv7), cr=3D10c5387f
CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: B@N NOOK TABLET
Setup machine tags finished
Setup machine tags finished
<5>Truncating RAM at a0000000-bfffffff to -afffffff (vmalloc region=20
overlap).
<6>Reserving 33554432 bytes SDRAM for VRAM
Memory policy: ECC disabled, Data cache writealloc
<6>***********************<6>O
MAP4430 ES2.3 type(HS)
<6>id-code (6b95c02f)
<6>Die-id (04C80006-00000001-09110B52-17020017)
<6>Prod-id (000DB95C-000600CC)
<6>***********************<6>SRAM: Mapped pa 0x4030d000 to va 0xfe40d00=
0=20
size: 0x1000
<7>On node 0 totalpages: 169984
<7>free_area_init_node: node 0, pgdat c0756540, node_mem_map c1081000
<7> Normal zone: 1536 pages used for memmap
<7> Normal zone: 0 pages reserved
<7> Normal zone: 168448 pages, LIFO batch:31
<6>PERCPU: Embedded 8 pages/cpu @c168f000 s10496 r8192 d14080 u32768
<7>pcpu-alloc: s10496 r8192 d14080 u32768 alloc=3D8*4096
<7>pcpu-alloc: [0] 0 [0] 1
Built 1 zonelists in Zone order, mobility grouping on. Total pages:=20
168448
<5>Kernel command line: androidboot.console=3DttyO0 console=3DttyO0,115=
200n8=20
mem=3D448M@0x80000000 mem=3D512M@0xA0000000 init=3D/init rootwait=20
vram=3D32M,82000000 omapf0
<6>PID hash table entries: 4096 (order: 2, 16384 bytes)
<6>Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
<6>Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
<6>Memory: 32MB 384MB 248MB =3D 664MB total
<5>Memory: 660272k/660272k available, 60624k reserved, 0K highmem
<5>Virtual kernel memory layout:
 vector : 0xffff0000 - 0xffff1000 ( 4 kB)
 fixmap : 0xfff00000 - 0xfffe0000 ( 896 kB)
 DMA : 0xffc00000 - 0xffe00000 ( 2 MB)
 vmalloc : 0xf0800000 - 0xf8000000 ( 120 MB)
 lowmem : 0xc0000000 - 0xf0000000 ( 768 MB)
 modules : 0xbf000000 - 0xc0000000 ( 16 MB)
 .text : 0xc0008000 - 0xc06a7e80 (6784 kB)
 .init : 0xc06a8000 - 0xc06e2900 ( 235 kB)
 .data : 0xc06e4000 - 0xc0757f70 ( 464 kB)
 .bss : 0xc0757f94 - 0xc0ccfdb8 (5600 kB)
<6>Preemptible hierarchical RCU implementation.
<6>NR_IRQS:474
<6>Configuring GIC with 160 sources (3 PPIs)
<6>OMAP clockevent source: GPTIMER1 at 32768 Hz
<6>sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every=20
131071999ms
<6>Console: colour dummy device 80x30
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molna=
r
=2E.. MAX_LOCKDEP_SUBCLASSES: 8
=2E.. MAX_LOCK_DEPTH: 48
=2E.. MAX_LOCKDEP_KEYS: 8191
=2E.. CLASSHASH_SIZE: 4096
=2E.. MAX_LOCKDEP_ENTRIES: 16384
=2E.. MAX_LOCKDEP_CHAINS: 32768
=2E.. CHAINHASH_SIZE: 16384
 memory used by lock dependency info: 3695 kB
 per task-struct memory footprint: 1152 bytes
<6>Calibrating local timer... 492.03MHz.
<6>Calibrating delay loop... <c>1956.77 BogoMIPS (lpj=3D7643136)
<6>pid_max: default: 32768 minimum: 301
<6>Security Framework initialized
<6>Mount-cache hash table entries: 512
<6>CPU: Testing write buffer coherency: ok
<6>hw perfevents: enabled with ARMv7 Cortex-A9 PMU driver, 7 counters=20
available
<6>L310 cache controller enabled
<6>l2x0: 16 ways, CACHE_ID 0x410000c4, AUX_CTRL 0x7e470000, Cache size:=
=20
1048576 B
<6>generating sar_ram layout...
<6>sar ram layout created
CPU1: Booted secondary processor
<2>CPU1: Unknown IPI message 0x1
<6>Brought up 2 CPUs
<6>SMP: Total of 2 processors activated (3921.95 BogoMIPS).
<4>omap_hwmod: ipu: no clkdm_name
<4>omap_hwmod: ipu: cannot _init_clocks
<4>------------[ cut here ]------------
<4>WARNING: at arch/arm/mach-omap2/omap_hwmod.c:2165=20
omap_hwmod_setup_all+0x84/0x9c()
omap_hwmod: omap_hwmod_setup_all: _init_clocks failed
<d>Modules linked in:
[<c001622c>] (unwind_backtrace+0x0/0xfc) from [<c0051dc4>]=20
(warn_slowpath_common+0x54/0x64)
[<c0051dc4>] (warn_slowpath_common+0x54/0x64) from [<c0051e68>]=20
(warn_slowpath_fmt+0x30/0x40)
[<c0051e68>] (warn_slowpath_fmt+0x30/0x40) from [<c06b1a48>]=20
(omap_hwmod_setup_all+0x84/0x9c)
[<c06b1a48>] (omap_hwmod_setup_all+0x84/0x9c) from [<c0008670>]=20
(do_one_initcall+0x34/0x184)
[<c0008670>] (do_one_initcall+0x34/0x184) from [<c06a829c>]=20
(do_basic_setup+0x34/0x40)
[<c06a829c>] (do_basic_setup+0x34/0x40) from [<c06a8324>]=20
(kernel_init+0x7c/0x104)
[<c06a8324>] (kernel_init+0x7c/0x104) from [<c000fa30>]=20
(kernel_thread_exit+0x0/0x8)
<4>---[ end trace 1b75b31a2719ed1c ]---
<4>omap_hwmod: aess: _wait_target_disable failed
<6>print_constraints: dummy:
<6>NET: Registered protocol family 16
<6>GPMC revision 6.0
<4>------------[ cut here ]------------
<4>WARNING: at arch/arm/mach-omap2/pm.c:110=20
_init_omap_device+0x90/0xac()
_init_omap_device: could not find omap_hwmod for fdif
<d>Modules linked in:
[<c001622c>] (unwind_backtrace+0x0/0xfc) from [<c0051dc4>]=20
(warn_slowpath_common+0x54/0x64)
[<c0051dc4>] (warn_slowpath_common+0x54/0x64) from [<c0051e68>]=20
(warn_slowpath_fmt+0x30/0x40)
[<c0051e68>] (warn_slowpath_fmt+0x30/0x40) from [<c0021184>]=20
(_init_omap_device+0x90/0xac)
[<c0021184>] (_init_omap_device+0x90/0xac) from [<c06b111c>]=20
(omap2_common_pm_init+0x8/0x70)
[<c06b111c>] (omap2_common_pm_init+0x8/0x70) from [<c0008670>]=20
(do_one_initcall+0x34/0x184)
[<c0008670>] (do_one_initcall+0x34/0x184) from [<c06a829c>]=20
(do_basic_setup+0x34/0x40)
[<c06a829c>] (do_basic_setup+0x34/0x40) from [<c06a8324>]=20
(kernel_init+0x7c/0x104)
[<c06a8324>] (kernel_init+0x7c/0x104) from [<c000fa30>]=20
(kernel_thread_exit+0x0/0x8)
<4>---[ end trace 1b75b31a2719ed1d ]---
<6>OMAP GPIO hardware version 0.1
<6>Board revision PVT
<6>emif emif.1: Device configured with addr =3D fd100000 and IRQ142
<6>emif emif.2: Device configured with addr =3D fd200000 and IRQ143
<6>omap_mux_init: Add partition: #1: core, flags: 2
<6>omap_mux_init: Add partition: #2: wkup, flags: 2
<6>Board revision PVT
<3>omap_mux_get_by_name: Could not find signal uart1_cts.uart1_cts
<3>omap_hwmod_mux_init: Could not allocate device mux entry
<3>omap_mux_get_by_name: Could not find signal uart4_cts.uart4_cts
<3>omap_hwmod_mux_init: Could not allocate device mux entry
<3>Error setting wl12xx data
board-4430sdp.c: kxtf9_dev_init ...
board-4430sdp.c: kxtf9_dev_init > Init kxtf9 irq pin 66 !
board-4430sdp.c: max17042_dev_init ...
board-4430sdp.c: max17042_dev_init > Init max17042 irq pin 65 !
max17042 GPIO pin read 1
<6>hw-breakpoint: found 6 breakpoint and 1 watchpoint registers.
<6>hw-breakpoint: 1 breakpoint(s) reserved for watchpoint single-step.
<6>hw-breakpoint: maximum watchpoint size is 4 bytes.
<3>omap_init_gpu: Could not look up gpu
<1>Unable to handle kernel NULL pointer dereference at virtual address=20
00000058
<1>pgd =3D c0004000
<1>[00000058] *pgd=3D00000000
<0>Internal error: Oops: 5 [#1] PREEMPT SMP
<d>Modules linked in:
CPU: 0 Tainted: G W (3.1.0-dirty #39)
PC is at omap_hwmod_get_pwrdm+0x14/0x4c
LR is at omap_timer_init+0xcc/0x158
pc : [<c0022584>] lr : [<c06b0cd4>] psr: 60000013
sp : ef033f58 ip : c0719494 fp : 00000000
r10: 00000000 r9 : 00000000 r8 : 00000000
r7 : c0708498 r6 : 00000000 r5 : c0717ccc r4 : ef109d20
r3 : 00000000 r2 : 00000000 r1 : c071a3dc r0 : c0717ccc
=46lags: nZCv IRQs on FIQs on Mode SVC_32 ISA ARM Segment kernel
Control: 10c5387f Table: 8000404a DAC: 00000015

PC: 0xc0022504:
2504 e2801001 e283c01c e1510006 e5837000 e1a05201 e5927008 e0877004=20
e5977004
2524 e5037008 e5927008 e0874004 e5944008 e5838004 e5034004 1affffdf=20
e28bc001
2544 e5da5087 e08cb000 e2899001 e1550009 caffffb3 e1a0000b e28dd008=20
e8bd0ff0
2564 e12fff1e e3a0b000 eaffff61 e3500000 0a000006 e5903030 e3530000=20
0a000005
2584 e5933058 e3530000 15930004 112fff1e e3a00000 e12fff1e e5d03089=20
e3130001
25a4 1afffffa e590c044 e5d02082 e79c1102 e5913010 eafffff1 e3500000=20
1a000001
25c4 e3a00000 e12fff1e e5d03089 e3130001 1afffffa e5d0108a e3510000=20
15900050
25e4 112fff1e eafffff5 e92d4008 e2503000 0a00000b e5d3208a e3520001=20
1a000004

LR: 0xc06b0c54:
0c54 e2504000 1a000006 e5952000 e30a0ad0 e59f10ec e34c005e ebf8b2d1=20
e3e0600b
0c74 ea000034 e28d2014 e5950000 e30a1aec e34c105e ebee9825 e3006dec=20
e34c6002
0c94 e5846000 e5950004 e308c548 e34cc075 e5901008 e5841004 e59d3014=20
e59c20a4
0cb4 e2436001 e1a00632 e3a06000 e3100001 13a00001 15c40009 e1a00005=20
ebe5c626
0cd4 ebe5ed2b e3a0c010 e30c1274 e34c1003 e584100c e1a02005 e1a03004=20
e5c4000a
0cf4 e30a0af8 e58dc000 e34c005e e59fc054 e59d1014 e58d600c e58dc004=20
e3a0c001
0d14 e58dc008 ebe61757 e3700a01 9a000007 e5953000 e30a0b04 e59f1024=20
e34c005e
0d34 e30a2af8 e34c205e ebf8b29d e3e06015 e1a00004 ebe941b4 e1a00006=20
e28dd018

SP: 0xef033ed8:
3ed8 00000002 00000001 c0717c38 ef138000 c05f1ce5 c0504cb0 ef033f50=20
00000000
3ef8 c05f1ce0 c0022584 60000013 ffffffff ef033f44 c04e193c c0717ccc=20
c071a3dc
3f18 00000000 00000000 ef109d20 c0717ccc 00000000 c0708498 00000000=20
00000000
3f38 00000000 00000000 c0719494 ef033f58 c06b0cd4 c0022584 60000013=20
ffffffff
3f58 00000010 c0707f00 00000001 00000000 c0717548 00000002 c064bce0=20
c06b0c08
3f78 c0717ccc c0022c34 c0757fa0 c06dfbc4 c000fa30 00000000 c06b0bc8=20
c06b0be4
3f98 ef032000 c0008670 00000000 c0150000 00000000 c07224e4 000001da=20
c000fa30
3fb8 c06df58c c06dfbc4 c000fa30 00000013 00000000 00000000 00000000=20
c06a829c

IP: 0xc0719414:
9414 00000086 00000000 0000ffff c071a34c c05f1cc0 00000000 00000032=20
00000000
9434 0000ffff c071a368 c05f1e3c c05f1cd4 c071a384 00000000 00000000=20
00000000
9454 c071a394 c064bce0 c071a3b0 00000000 00000000 00000000 00000000=20
00000045
9474 00000000 0000ffff c071a3c0 40000000 00000000 00000046 00000000=20
0000ffff
9494 c071a3dc c064bce0 c071a3f8 00000000 00000000 00000000 00000000=20
00000047
94b4 00000000 0000ffff c071a408 00000000 00000048 00000000 0000ffff=20
c071a424
94d4 00000000 00000049 00000000 0000ffff c071a440 c071a45c 00000000=20
0000004a
94f4 00000000 0000ffff c071a478 c071a494 00000000 0000004b 00000000=20
0000ffff

R0: 0xc0717c4c:
7c4c 00000000 00000000 00000040 00000044 00000001 00000200 c05f18c4=20
c0713aac
7c6c 00000000 c05f0448 c070d80c 00000000 c071947c c0719480 00000015=20
fc318000
7c8c 00000000 00000000 dead4ead ffffffff ffffffff c075862c 00000000=20
00000000
7cac c05ebb50 c0717d44 c0717c1c 00000000 01000000 05040600 00017900=20
00000000
7ccc c05f1ce0 c0719458 00000000 00000000 c0719484 00000000 00000000=20
00000038
7cec 0000003c 00000000 00000200 c05f18e8 00000000 00000000 c05eea6c=20
00000000
7d0c 00000000 c0719494 c0719480 00000000 fa032000 00000000 00000000=20
dead4ead
7d2c ffffffff ffffffff c075862c 00000000 00000000 c05ebb50 c0717dd8=20
c0717cb0

R1: 0xc071a35c:
a35c 00000000 00000000 00000300 c07158f4 c0717b10 c071afcc c05f0d2c=20
00000000
a37c 00000000 00000300 00100000 00b70014 000f0000 c07084a0 c07158f4=20
c0717ba4
a39c c071afec c05f0d2c 00000000 00000000 00000300 00100000 00bf0014=20
00070000
a3bc c07084a0 c0715a1c c0717c38 c071b00c c05f0d48 c071182c 00000000=20
00000300
a3dc c0715988 c0717ccc c071b02c c05f0d2c 00000000 00000000 00000300=20
00100000
a3fc 022a0000 000f0000 c07084a8 c0715988 c0717d60 c071b04c c05f0d2c=20
00000000
a41c 00000000 00000300 c0715988 c0717df4 c071b06c c05f0d2c 00000000=20
00000000
a43c 00000300 c0715860 c0717e88 c071b08c c05f0d5c 00000000 00000000=20
00000100

R4: 0xef109ca0:
9ca0 70616d6f 636d5f32 2e697073 00000031 ef0c8b60 eec01e00 0000003a=20
c075aa44
9cc0 00000004 00000100 c0780720 ef0c8ff0 c0785070 ef0c8ff0 ef0c8b60=20
00000000
9ce0 70616d6f 636d5f32 00697073 00000000 00000000 00000000 00000000=20
00000000
9d00 c071738c 00000000 00000000 00000000 00000000 00000000 00000000=20
00000000
9d20 c0020dec 00000000 00000000 00000000 00000000 00000000 00000000=20
00000000
9d40 65776f70 000f0072 00000000 00000000 00000400 00000000 ef0046f0=20
c0044748
9d60 73627573 65747379 000f006d ef109e98 00000002 00000000 00000001=20
00000000
9d80 70616d6f 69616d2d 786f626c c06e2200 c06e2240 ffffffff ef04cd60=20
00000000

R5: 0xc0717c4c:
7c4c 00000000 00000000 00000040 00000044 00000001 00000200 c05f18c4=20
c0713aac
7c6c 00000000 c05f0448 c070d80c 00000000 c071947c c0719480 00000015=20
fc318000
7c8c 00000000 00000000 dead4ead ffffffff ffffffff c075862c 00000000=20
00000000
7cac c05ebb50 c0717d44 c0717c1c 00000000 01000000 05040600 00017900=20
00000000
7ccc c05f1ce0 c0719458 00000000 00000000 c0719484 00000000 00000000=20
00000038
7cec 0000003c 00000000 00000200 c05f18e8 00000000 00000000 c05eea6c=20
00000000
7d0c 00000000 c0719494 c0719480 00000000 fa032000 00000000 00000000=20
dead4ead
7d2c ffffffff ffffffff c075862c 00000000 00000000 c05ebb50 c0717dd8=20
c0717cb0

R7: 0xc0708418:
8418 00000000 00000000 00000000 00000000 00000000 00000000 00000000=20
00000000
8438 00000000 00000000 00000000 00000000 00000000 00000000 00000000=20
00000000
8458 00000000 00000000 00000000 00000000 00000000 00000000 00000000=20
00000000
8478 00000000 00000000 00000000 00000000 00000000 00000000 00000000=20
00000000
8498 c0715560 c0718840 0203080c 00000001 00020004 00000000 00000002=20
00000000
84b8 00000000 dead4ead ffffffff ffffffff c07084c8 c077eda0 00000000=20
c05ebd08
84d8 00000004 00000080 c00254b4 c0706054 00000000 00000000 00000000=20
c003613c
84f8 00000000 00000000 c0036178 00000002 00000fa0 000030d4 00000000=20
00000012
<0>Process swapper (pid: 1, stack limit =3D 0xef032278)
<0>Stack: (0xef033f58 to 0xef034000)
<0>3f40: 00000010 c0707f00
<0>3f60: 00000001 00000000 c0717548 00000002 c064bce0 c06b0c08 c0717ccc=
=20
c0022c34
<0>3f80: c0757fa0 c06dfbc4 c000fa30 00000000 c06b0bc8 c06b0be4 ef032000=
=20
c0008670
<0>3fa0: 00000000 c0150000 00000000 c07224e4 000001da c000fa30 c06df58c=
=20
c06dfbc4
<0>3fc0: c000fa30 00000013 00000000 00000000 00000000 c06a829c 00000002=
=20
c06df4ac
<0>3fe0: c06df4ac c06a8324 ef033fe8 00000000 c06a82a8 c000fa30 d1882e77=
=20
d1772e88
[<c0022584>] (omap_hwmod_get_pwrdm+0x14/0x4c) from [<c06b0cd4>]=20
(omap_timer_init+0xcc/0x158)
[<c06b0cd4>] (omap_timer_init+0xcc/0x158) from [<c0022c34>]=20
(omap_hwmod_for_each_by_class+0x70/0x90)
[<c0022c34>] (omap_hwmod_for_each_by_class+0x70/0x90) from [<c06b0be4>]=
=20
(omap2_dm_timer_init+0x1c/0x40)
[<c06b0be4>] (omap2_dm_timer_init+0x1c/0x40) from [<c0008670>]=20
(do_one_initcall+0x34/0x184)
[<c0008670>] (do_one_initcall+0x34/0x184) from [<c06a829c>]=20
(do_basic_setup+0x34/0x40)
[<c06a829c>] (do_basic_setup+0x34/0x40) from [<c06a8324>]=20
(kernel_init+0x7c/0x104)
[<c06a8324>] (kernel_init+0x7c/0x104) from [<c000fa30>]=20
(kernel_thread_exit+0x0/0x8)
<0>Code: 0a000006 e5903030 e3530000 0a000005 (e5933058)
<4>---[ end trace 1b75b31a2719ed1e ]---
<0>Kernel panic - not syncing: Attempted to kill init!
<2>CPU1: stopping
[<c001622c>] (unwind_backtrace+0x0/0xfc) from [<c0014018>]=20
(ipi_cpu_stop+0x58/0x68)
[<c0014018>] (ipi_cpu_stop+0x58/0x68) from [<c00141a8>]=20
(handle_IPI+0x10c/0x110)
[<c00141a8>] (handle_IPI+0x10c/0x110) from [<c0008608>]=20
(gic_handle_irq+0x50/0x54)
[<c0008608>] (gic_handle_irq+0x50/0x54) from [<c04e19a4>]=20
(__irq_svc+0x44/0x78)
Exception stack(0xef077f90 to 0xef077fd8)
7f80: c000fad8 c072e924 ef077fd8 00000000
7fa0: ef076000 c0758044 c04eb7cc c07050a0 8000406a 411fc093 00000000=20
00000000
7fc0: ef076018 ef077fd8 c000fad8 c000fadc 60000013 ffffffff
[<c04e19a4>] (__irq_svc+0x44/0x78) from [<c000fadc>]=20
(default_idle+0x28/0x2c)
[<c000fadc>] (default_idle+0x28/0x2c) from [<c00101d4>]=20
(cpu_idle+0xc8/0xfc)
[<c00101d4>] (cpu_idle+0xc8/0xfc) from [<804da454>] (0x804da454)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
