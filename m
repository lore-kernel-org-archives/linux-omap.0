From: Paul Walmsley <paul@pwsan.com>
Subject: MUSB oopses when changing mode on Beagle
Date: Tue, 24 Mar 2009 18:54:18 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0903241851270.9924@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46472 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760874AbZCYAyV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 20:54:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: me@felipebalbi.com


Hi,

echo'ing 'host' to the musb_hdrc/mode sysfs file triggers an oops on 
BeagleBoard rev B4 with linux-omap HEAD.  Passing along the trace with a 
little extra debug to see if anyone happens to know what the problem is.


- Paul

root@beagleboard:/sys# echo host > ./devices/platform/musb_hdrc/mode
musb: musb=c78280d8
musb: musb->xceiv=c78281b4
musb: musb->xceiv.host=c78281c4
musb: musb->xceiv->set_host=c78281d0
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c7028000
[00000000] *pgd=87bb7031, *pte=00000000, *ppte=00000000
Internal error: Oops: 0 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.29-omap1-05523-g4530004-dirty #375)
PC is at 0x0
LR is at musb_platform_set_mode+0x80/0xbc
pc : [<00000000>]    lr : [<c01ef244>]    psr: 60000093
sp : c7b81ed0  ip : c7b81e00  fp : c7b81ee4
r10: c7b81f70  r9 : c79bebb8  r8 : c03705c8
r7 : 00000005  r6 : a0000013  r5 : c78280d8  r4 : c78281b4
r3 : 60000093  r2 : c035995c  r1 : c7828000  r0 : c78281b4
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 87028019  DAC: 00000015
Process echo (pid: 1286, stack limit = 0xc7b802e0)
Stack: (0xc7b81ed0 to 0xc7b82000)
1ec0:                                     c7bb6000 c78280d8 c7b81f04 c7b81ee8
1ee0: c01eef34 c01ef1d0 c793d278 00000005 c79beba0 c035868c c7b81f14 c7b81f08
1f00: c01b3354 c01eeec0 c7b81f44 c7b81f18 c00dedf4 c01b333c c7b81f70 c7831340
1f20: 4001d000 c7b81f70 00000005 4001d000 c7b80000 00000000 c7b81f6c c7b81f48
1f40: c009b404 c00decf0 00000000 00000000 00000000 00000000 c7831340 00000005
1f60: c7b81fa4 c7b81f70 c009b8c4 c009b354 00000000 00000000 c002ff88 00000000
1f80: ffffffff 00000005 4001d000 401c1600 00000004 c0029f08 00000000 c7b81fa8
1fa0: c0029d60 c009b88c 00000005 4001d000 00000001 4001d000 00000005 00000000
1fc0: 00000005 4001d000 401c1600 00000004 00000005 0000001f 0006e02d 0006c67c
1fe0: 00000000 bee46c28 4010a78c 4015799c 60000010 00000001 00000000 00000000
Backtrace:
[<c01ef1c4>] (musb_platform_set_mode+0x0/0xbc) from [<c01eef34>] (musb_mode_store+0x80/0x9c)
 r5:c78280d8 r4:c7bb6000
[<c01eeeb4>] (musb_mode_store+0x0/0x9c) from [<c01b3354>] (dev_attr_store+0x24/0x28)
 r7:c035868c r6:c79beba0 r5:00000005 r4:c793d278
[<c01b3330>] (dev_attr_store+0x0/0x28) from [<c00dedf4>] (sysfs_write_file+0x110/0x144)
[<c00dece4>] (sysfs_write_file+0x0/0x144) from [<c009b404>] (vfs_write+0xbc/0x14c)
[<c009b348>] (vfs_write+0x0/0x14c) from [<c009b8c4>] (sys_write+0x44/0x70)
 r7:00000005 r6:c7831340 r5:00000000 r4:00000000
[<c009b880>] (sys_write+0x0/0x70) from [<c0029d60>] (ret_fast_syscall+0x0/0x2c)
 r8:c0029f08 r7:00000004 r6:401c1600 r5:4001d000 r4:00000005
Code: bad PC value.
---[ end trace 1dc402be61e486ba ]---
Segmentation fault

