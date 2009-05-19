From: "Hald, Ulrik Bech" <ubh@ti.com>
Subject: Kernel panic on ldp board
Date: Tue, 19 May 2009 18:00:13 +0200
Message-ID: <00695C9C8F8B4448856F48142B4AA201BD293890@dnce02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60887 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbZESQAU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 12:00:20 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4JG0GD9028147
	for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 11:00:21 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id n4JG0Gnv024105
	for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 11:00:16 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n4JG0FJp014196
	for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 11:00:15 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

When booting on ldp (zoom1), I am seeing a kernel panic. I am using lat=
est kernel built from L-O master at:

OMAP:=A0sDMA:=A0Correct=A0the=A0the=A0omap_request_dma_chain()=A0signat=
ure
0b2ce840c9fb58cf489bfdfc2d77f99a09a5dca3

Any one having any idea as to why? Here's my boot trace

## Booting image at 80000000 ...
   Image Name:   Linux-2.6.30-rc6-omap1-05706-g0b
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1843272 Bytes =3D  1.8 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing Linux....................................................=
=2E............................................................... don.
<5>Linux version 2.6.30-rc6-omap1-05706-g0b2ce84 (a0389051@a0389051-ubu=
ntu) (gcc version 4.2.1 (CodeSourcery Sourcery G++ Lite 2007q3-51)) 9
CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=3D10c5387f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP LDP board
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 65536
<7>free_area_init_node: node 0, pgdat c038daf8, node_mem_map c03aa000
<7>  Normal zone: 512 pages used for memmap
<7>  Normal zone: 0 pages reserved
<7>  Normal zone: 65024 pages, LIFO batch:15
<6>OMAP3430 ES2.1
<6>SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65=
024
<5>Kernel command line: console=3DttyS2,115200n8 noinitrd mem=3D256M ro=
ot=3D/dev/nfs rw nfsroot=3D128.247.85.232:/home/a0389051/omap3430/files=
ystemp
<6>NR_IRQS:402
<6>Clocking rate (Crystal/DPLL/ARM core): 26.0/332/500 MHz
<6>GPMC revision 5.0
<6>IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
<6>Total of 96 interrupts on 1 active controller
<6>OMAP34xx GPIO hardware version 2.5
PID hash table entries: 1024 (order: 10, 4096 bytes)
<6>OMAP clockevent source: GPTIMER1 at 32768 Hz
Console: colour dummy device 80x30
<6>Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
<6>Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
<6>Memory: 256MB =3D 256MB total
<5>Memory: 255872KB available (3176K code, 292K data, 132K init, 0K hig=
hmem)
<1>Unhandled fault: external abort on non-linefetch (0x1008) at 0xcf800=
00c
Internal error: : 1008 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.30-rc6-omap1-05706-g0b2ce84 #1)
PC is at cache_alloc_refill+0x3f4/0x4f4
LR is at 0x0
pc : [<c00929e0>]    lr : [<00000000>]    psr: 80000153
sp : c035ff28  ip : 00000002  fp : 000080d0
r10: 000000d0  r9 : 00000010  r8 : c037612c
r7 : c0023808  r6 : 00000000  r5 : cf800000  r4 : cf800000
r3 : 00000028  r2 : 00000000  r1 : c059a020  r0 : c059a000
=46lags: Nzcv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387f  Table: 80004019  DAC: 00000017
Process swapper (pid: 0, stack limit =3D 0xc035e2e0)
Stack: (0xc035ff28 to 0xc0360000)
ff20:                   c037612c 00000020 c00238a4 60000153 c0376110 c0=
37612c=20
ff40: 000080d0 00000020 411fc082 00000008 c0300876 c0092c10 00000000 c0=
376110=20
ff60: 00000020 00042000 00000020 c00937f4 00000000 c03b1540 0000fa25 00=
000002=20
ff80: c038e378 c0022e6b c0361ca0 00000000 c0023808 c0376184 c0376110 c0=
376184=20
ffa0: 411fc082 0000001f 00000000 c00129c4 00000000 c0376148 00000000 00=
000040=20
ffc0: c0022eec c038e240 c0022ee8 c0361ca0 8002106c c0008a84 c00084e8 00=
000000=20
ffe0: 00000000 c0022eec 00000000 10c5387d c038e324 80008034 00000000 00=
000000=20
[<c00929e0>] (cache_alloc_refill+0x3f4/0x4f4) from [<c0092c10>] (kmem_c=
ache_alloc+0x5c/0x94)
[<c0092c10>] (kmem_cache_alloc+0x5c/0x94) from [<c00937f4>] (kmem_cache=
_create+0x1ec/0x438)
[<c00937f4>] (kmem_cache_create+0x1ec/0x438) from [<c00129c4>] (kmem_ca=
che_init+0x14c/0x310)
[<c00129c4>] (kmem_cache_init+0x14c/0x310) from [<c0008a84>] (start_ker=
nel+0x1d0/0x284)
[<c0008a84>] (start_kernel+0x1d0/0x284) from [<80008034>] (0x80008034)
Code: e1a06003 e1a05004 ea000009 e598203c (e594100c)=20
<4>---[ end trace 1b75b31a2719ed1c ]---
<0>Kernel panic - not syncing: Attempted to kill the idle task!


Best Regards
Ulrik Bech Hald

Wireless Terminals Software Development
Texas Instruments Inc.
Desk Phone: (1) 214-567-6943

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
