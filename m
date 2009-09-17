From: "Stefano Panella" <Stefano.Panella@csr.com>
Subject: most up-to-date linux-omap 2.6.31 not booting on N810
Date: Thu, 17 Sep 2009 11:19:31 +0100
Message-ID: <A2AD06B24DC9F846B5C9B99602FA10E7030D6291@cameurexb01.EUROPE.ROOT.PRI>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cluster-g.mailcontrol.com ([208.87.233.190]:36391 "EHLO
	cluster-g.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbZIQKU6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Sep 2009 06:20:58 -0400
Received: from cameurexb01.EUROPE.ROOT.PRI ([193.128.72.68])
	by rly18g.srv.mailcontrol.com (MailControl) with ESMTP id n8HAHC6w023052
	for <linux-omap@vger.kernel.org>; Thu, 17 Sep 2009 11:20:57 +0100
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I have just tried to boot a kernel image using n8x0_defconfig file,
using the most up-to-date linux-omap tree (commit 52a962f09ab2306a2....)

This image is not booting on my N810 device

Enabling 'kernel low-level debugging' option and disabling 
stack unwinding support I obtain this log:

Uncompressing
Linux...................................................................
........... done, booting the kernel.
<5>Linux version 2.6.31-omap1-05923-g52a962f (root@drivers-uwbtest) (gcc
version 4.2.4 (Debian 4.2.4-6)) #10 Thu Sep 17 11:03:13 BST 2009
CPU: ARMv6-compatible processor [4107b362] revision 2 (ARMv6TEJ),
cr=00c5387f
CPU: VIPT aliasing data cache, VIPT aliasing instruction cache
Machine: Nokia N810
<4>Ignoring unrecognised tag 0x414f4d50
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 32768
<7>free_area_init_node: node 0, pgdat c025a4f8, node_mem_map c026d000
<7>  Normal zone: 256 pages used for memmap
<7>  Normal zone: 0 pages reserved
<7>  Normal zone: 32512 pages, LIFO batch:7
<6>OMAP2420<6>
<6>SRAM: Mapped pa 0x40200000 to va 0xe3000000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
32512
<5>Kernel command line: root=1f03 rootfstype=jffs2
console=ttyS0,115200n8
PID hash table entries: 512 (order: 9, 2048 bytes)
<6>Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
<6>Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
<6>Memory: 64MB 64MB = 128MB total
<5>Memory: 127316KB available (2140K code, 188K data, 112K init, 0K
highmem)
<6>SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1,
Nodes=1
<6>Hierarchical RCU implementation.
<6>NR_IRQS:368
<6>Clocking rate (Crystal/DPLL/MPU): 19.2/658/329 MHz
<1>Unable to handle kernel NULL pointer dereference at virtual address
00000004
<1>pgd = c0004000
<1>[00000004] *pgd=00000000
Internal error: Oops: 5 [#1]
<d>Modules linked in:
CPU: 0    Not tainted  (2.6.31-omap1-05923-g52a962f #10)
PC is at _add_initiator_dep+0x28/0x38
LR is at _enable+0x54/0x1a4
pc : [<c002f3c4>]    lr : [<c002f6a8>]    psr: a00001d3
sp : c023df10  ip : c023df20  fp : c023df1c
r10: 80020a28  r9 : 4107b362  r8 : 80020a90
r7 : c024164c  r6 : c002fb78  r5 : 00000000  r4 : c02409cc
r3 : 00000000  r2 : 00000000  r1 : c02409cc  r0 : c02409cc
Flags: NzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387f  Table: 80004000  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc023c268)
Stack: (0xc023df10 to 0xc023e000)
df00:                                     c023df3c c023df20 c002f6a8
c002f3a8
df20: 800001d3 c0240974 c0240e44 c02409cc c023df5c c023df40 c002fbf8
c002f660
df40: c002fdfc c02409cc 00000000 c002fb78 c023df7c c023df60 c002f0d4
c002fb84
df60: 00000000 00000000 c0022e10 c0240338 c023df8c c023df80 c002fed4
c002f0ac
df80: c023dfa4 c023df90 c000df60 c002fe80 c025ab10 c025ab04 c023dfb4
c023dfa8
dfa0: c000eae0 c000defc c023dfc4 c023dfb8 c000b738 c000ead4 c023dff4
c023dfc8
dfc0: c0008acc c000b70c c0008554 00000000 00000000 c0022e10 00000000
00c5387d
dfe0: c025adc0 c0023214 00000000 c023dff8 80008034 c0008998 00000000
00000000
Backtrace:
[<c002f39c>] (_add_initiator_dep+0x0/0x38) from [<c002f6a8>]
(_enable+0x54/0x1a4)
[<c002f654>] (_enable+0x0/0x1a4) from [<c002fbf8>] (_setup+0x80/0xb4)
 r4:c02409cc
[<c002fb78>] (_setup+0x0/0xb4) from [<c002f0d4>]
(omap_hwmod_for_each+0x34/0x78)
 r6:c002fb78 r5:00000000 r4:c02409cc
[<c002f0a0>] (omap_hwmod_for_each+0x0/0x78) from [<c002fed4>]
(omap_hwmod_late_init+0x60/0x8c)
 r7:c0240338 r6:c0022e10 r5:00000000 r4:00000000
[<c002fe74>] (omap_hwmod_late_init+0x0/0x8c) from [<c000df60>]
(omap2_init_common_hw+0x70/0xa8)
[<c000def0>] (omap2_init_common_hw+0x0/0xa8) from [<c000eae0>]
(n8x0_init_irq+0x18/0x24)
 r5:c025ab04 r4:c025ab10
[<c000eac8>] (n8x0_init_irq+0x0/0x24) from [<c000b738>]
(init_IRQ+0x38/0x44)
[<c000b700>] (init_IRQ+0x0/0x44) from [<c0008acc>]
(start_kernel+0x140/0x2c8)
[<c000898c>] (start_kernel+0x0/0x2c8) from [<80008034>] (0x80008034)
 r6:c0023214 r5:c025adc0 r4:00c5387d
Code: 089da800 e5913020 e592205c e593305c (e5920004)
<4>---[ end trace 1b75b31a2719ed1c ]---
<0>Kernel panic - not syncing: Attempted to kill the idle task!
Backtrace:
[<c0028e8c>] (dump_backtrace+0x0/0x110) from [<c0028fd0>]
(dump_stack+0x18/0x1c)
 r6:0000000b r5:c025b424 r4:c023c000
[<c0028fb8>] (dump_stack+0x0/0x1c) from [<c004ad90>] (panic+0x4c/0x124)
[<c004ad44>] (panic+0x0/0x124) from [<c004d9ac>] (do_exit+0x64/0x578)
 r3:00000000 r2:c0246c74 r1:000012f2 r0:c020ece4
[<c004d948>] (do_exit+0x0/0x578) from [<c0029120>] (die+0x12c/0x14c)
[<c0028ff4>] (die+0x0/0x14c) from [<c002b410>]
(__do_kernel_fault+0x6c/0x7c)
[<c002b3a4>] (__do_kernel_fault+0x0/0x7c) from [<c002b644>]
(do_page_fault+0x224/0x244)
 r7:c023dec8 r6:c023f6c8 r5:c02405e4 r4:ffffffff
[<c002b420>] (do_page_fault+0x0/0x244) from [<c002b704>]
(do_translation_fault+0x1c/0x84)
[<c002b6e8>] (do_translation_fault+0x0/0x84) from [<c0024250>]
(do_DataAbort+0x3c/0xa0)
 r6:00000005 r5:c02405e4 r4:ffffffff
[<c0024214>] (do_DataAbort+0x0/0xa0) from [<c00249ec>]
(__dabt_svc+0x4c/0x60)
Exception stack(0xc023dec8 to 0xc023df10)
dec0:                   c02409cc c02409cc 00000000 00000000 c02409cc
00000000
dee0: c002fb78 c024164c 80020a90 4107b362 80020a28 c023df1c c023df20
c023df10
df00: c002f6a8 c002f3c4 a00001d3 ffffffff
 r8:80020a90 r7:c024164c r6:c002fb78 r5:c023defc r4:ffffffff
[<c002f39c>] (_add_initiator_dep+0x0/0x38) from [<c002f6a8>]
(_enable+0x54/0x1a4)
[<c002f654>] (_enable+0x0/0x1a4) from [<c002fbf8>] (_setup+0x80/0xb4)
 r4:c02409cc
[<c002fb78>] (_setup+0x0/0xb4) from [<c002f0d4>]
(omap_hwmod_for_each+0x34/0x78)
 r6:c002fb78 r5:00000000 r4:c02409cc
[<c002f0a0>] (omap_hwmod_for_each+0x0/0x78) from [<c002fed4>]
(omap_hwmod_late_init+0x60/0x8c)
 r7:c0240338 r6:c0022e10 r5:00000000 r4:00000000
[<c002fe74>] (omap_hwmod_late_init+0x0/0x8c) from [<c000df60>]
(omap2_init_common_hw+0x70/0xa8)
[<c000def0>] (omap2_init_common_hw+0x0/0xa8) from [<c000eae0>]
(n8x0_init_irq+0x18/0x24)
 r5:c025ab04 r4:c025ab10
[<c000eac8>] (n8x0_init_irq+0x0/0x24) from [<c000b738>]
(init_IRQ+0x38/0x44)
[<c000b700>] (init_IRQ+0x0/0x44) from [<c0008acc>]
(start_kernel+0x140/0x2c8)
[<c000898c>] (start_kernel+0x0/0x2c8) from [<80008034>] (0x80008034)
 r6:c0023214 r5:c025adc0 r4:00c5387d

any idea how to fix it???

Thanks very much,

Stefano

---
Stefano Panella,
Software Engineer, Drivers
Tel: +44(0)1223 692452
CSR, Churchill House,
Cambridge Business Park,
Cowley Road, Cambridge,
CB4 0WZ



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
