From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: N810 not booting on 2.6.31
Date: Fri, 11 Sep 2009 14:17:18 -0400
Message-ID: <4AAA942E.7040601@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:55618 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707AbZIKSRd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Sep 2009 14:17:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>

Hi folks,

I'm trying to boot a kernel image using the default n8x0_deconfig file,
using the most up-to-dated linux-omap tree (commit
52a962f09ab2306a2ac6e22c2d3bac1a76ac8993).

Unfortunately, this image is not booting on my N810 device.

With the 'kernel low-level debugging' option enabled, I got the
following messages:

Uncompressing
Linux............................................................................
done, booting the kernel.
<5>Linux version 2.6.31-omap1-05923-g52a962f (carlos@einstein) (gcc
version 4.2.1 (CodeSourcery Sourcery G++ Lite 2007q3-51)) #50 Fri Sep 11
11:08:50 AMT 209
CPU: ARMv6-compatible processor [4107b362] revision 2 (ARMv6TEJ),
cr=00c5387f
CPU: VIPT aliasing data cache, VIPT aliasing instruction cache
Machine: Nokia N810
<4>Ignoring unrecognised tag 0x414f4d50
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 32768
<7>free_area_init_node: node 0, pgdat c024e4e0, node_mem_map c0261000
<7>  Normal zone: 256 pages used for memmap
<7>  Normal zone: 0 pages reserved
<7>  Normal zone: 32512 pages, LIFO batch:7
<6>OMAP2420<6>
<6>SRAM: Mapped pa 0x40200000 to va 0xe3000000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
<5>Kernel command line: root=1f03 rootfstype=jffs2 console=ttyS0,115200n8
PID hash table entries: 512 (order: 9, 2048 bytes)
<6>Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
<6>Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
<6>Memory: 64MB 64MB = 128MB total
<5>Memory: 127344KB available (2028K code, 188K data, 100K init, 0K highmem)
<6>SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
<6>Hierarchical RCU implementation.
<6>NR_IRQS:368
<6>Clocking rate (Crystal/DPLL/MPU): 19.2/658/329 MHz
<1>Unable to handle kernel NULL pointer dereference at virtual address
00000004
<1>pgd = c0004000
<1>[00000004] *pgd=00000000
Internal error: Oops: 5 [#1]
<d>Modules linked in:
CPU: 0    Not tainted  (2.6.31-omap1-05923-g52a962f #50)
PC is at _add_initiator_dep+0x18/0x2c
LR is at _enable+0x48/0x198
pc : [<c002bf24>]    lr : [<c002c1b4>]    psr: a00001d3
sp : c0231f80  ip : c0235408  fp : 00000000
r10: 8001e398  r9 : 4107b362  r8 : 8001e400
r7 : c0234318  r6 : c002c690  r5 : 00000000  r4 : c02349b4
r3 : 00000000  r2 : 00000000  r1 : c02349b4  r0 : c02349b4
Flags: NzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387f  Table: 80004000  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc0230268)
Stack: (0xc0231f80 to 0xc0232000)
1f80: c02349b4 c02349b4 c02349b4 c002c704 c02349b4 00000000 c002c690
c002bccc
1fa0: 00000000 00000000 c001fe14 c002c9a0 00000000 c000d678 c001fe18
c024eae0
1fc0: c001fe14 c000e0b4 c001fe18 c000b130 c001fe18 c0008a10 c00084e8
00000000
1fe0: 00000000 c001fe18 00000000 00c5387d c024ee20 80008034 00000000
00000000
[<c002bf24>] (_add_initiator_dep+0x18/0x2c) from [<c002c1b4>]
(_enable+0x48/0x198)
[<c002c1b4>] (_enable+0x48/0x198) from [<c002c704>] (_setup+0x74/0xa8)
[<c002c704>] (_setup+0x74/0xa8) from [<c002bccc>]
(omap_hwmod_for_each+0x28/0x6c)
[<c002bccc>] (omap_hwmod_for_each+0x28/0x6c) from [<c002c9a0>]
(omap_hwmod_late_init+0x58/0x84)
[<c002c9a0>] (omap_hwmod_late_init+0x58/0x84) from [<c000d678>]
(omap2_init_common_hw+0x68/0x9c)
[<c000d678>] (omap2_init_common_hw+0x68/0x9c) from [<c000e0b4>]
(n8x0_init_irq+0x10/0x1c)
[<c000e0b4>] (n8x0_init_irq+0x10/0x1c) from [<c000b130>]
(init_IRQ+0x30/0x40)
[<c000b130>] (init_IRQ+0x30/0x40) from [<c0008a10>]
(start_kernel+0x130/0x298)
[<c0008a10>] (start_kernel+0x130/0x298) from [<80008034>] (0x80008034)
Code: 0a000005 e5913020 e592205c e593305c (e5920004)
<4>---[ end trace 1b75b31a2719ed1c ]---
<0>Kernel panic - not syncing: Attempted to kill the idle task!
[<c002765c>] (unwind_backtrace+0x0/0xe0) from [<c0045c84>]
(panic+0x40/0x108)
[<c0045c84>] (panic+0x40/0x108) from [<c00484f4>] (do_exit+0x5c/0x568)
[<c00484f4>] (do_exit+0x5c/0x568) from [<c0025b7c>] (die+0x12c/0x14c)
[<c0025b7c>] (die+0x12c/0x14c) from [<c00284c0>]
(__do_kernel_fault+0x64/0x74)
[<c00284c0>] (__do_kernel_fault+0x64/0x74) from [<c00286dc>]
(do_page_fault+0x20c/0x22c)
[<c00286dc>] (do_page_fault+0x20c/0x22c) from [<c002122c>]
(do_DataAbort+0x34/0x98)
[<c002122c>] (do_DataAbort+0x34/0x98) from [<c002196c>]
(__dabt_svc+0x4c/0x60)
Exception stack(0xc0231f38 to 0xc0231f80)
1f20:                                                       c02349b4
c02349b4
1f40: 00000000 00000000 c02349b4 00000000 c002c690 c0234318 8001e400
4107b362
1f60: 8001e398 00000000 c0235408 c0231f80 c002c1b4 c002bf24 a00001d3
ffffffff
[<c002196c>] (__dabt_svc+0x4c/0x60) from [<c002bf24>]
(_add_initiator_dep+0x18/0x2c)
[<c002bf24>] (_add_initiator_dep+0x18/0x2c) from [<c002c1b4>]
(_enable+0x48/0x198)
[<c002c1b4>] (_enable+0x48/0x198) from [<c002c704>] (_setup+0x74/0xa8)
[<c002c704>] (_setup+0x74/0xa8) from [<c002bccc>]
(omap_hwmod_for_each+0x28/0x6c)
[<c002bccc>] (omap_hwmod_for_each+0x28/0x6c) from [<c002c9a0>]
(omap_hwmod_late_init+0x58/0x84)
[<c002c9a0>] (omap_hwmod_late_init+0x58/0x84) from [<c000d678>]
(omap2_init_common_hw+0x68/0x9c)
[<c000d678>] (omap2_init_common_hw+0x68/0x9c) from [<c000e0b4>]
(n8x0_init_irq+0x10/0x1c)
[<c000e0b4>] (n8x0_init_irq+0x10/0x1c) from [<c000b130>]
(init_IRQ+0x30/0x40)
[<c000b130>] (init_IRQ+0x30/0x40) from [<c0008a10>]
(start_kernel+0x130/0x298)
[<c0008a10>] (start_kernel+0x130/0x298) from [<80008034>] (0x80008034)

Any hint on how to solve it?

BR,

Carlos.

-- 
Carlos Eduardo Aguiar
Software Developer
Mobile Linux Software
Nokia Institute of Technology - INdT
E-mail: carlos.aguiar@indt.org.br

