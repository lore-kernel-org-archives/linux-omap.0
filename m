From: Shreyas Mahajan <mahajan.shreyas@gmail.com>
Subject: Failure for IOREMAP
Date: Sat, 7 Feb 2009 16:01:31 +0530
Message-ID: <d105d8d00902070231t7d37faabwda9fb45bff5a1e43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.236]:49379 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbZBGKbd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 7 Feb 2009 05:31:33 -0500
Received: by qb-out-0506.google.com with SMTP id q18so734800qba.17
        for <linux-omap@vger.kernel.org>; Sat, 07 Feb 2009 02:31:32 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,
        Currently I am working on OMAP LDP board. I currently have 128
MB of Memory, of which I am booting with 64MB with 'mem=64M' option. I
tried to use ioremap function to remap some memory above 64MB.
Function call to IOREMAP from  'omap_ldp_init' in 'board-ldp.c' works
fine returning a virtual address  (0xc4808000 every time). But when I
tried to read from that memory, it gives
'Unhandled fault: external abort on non-linefetch (0x1008) at
0xc4808000'. Entire Log is:

'Unhandled fault: external abort on non-linefetch (0x1008) at 0xc4808000
Internal error: : 1008 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.29-rc3-omap1-05417-gc00b556-dirty #80)
PC is at omap_ldp_init+0x134/0x1a4
LR is at release_console_sem+0x190/0x1a4
pc : [<c0011afc>]    lr : [<c004921c>]    psr: 60000013
sp : c3817f30  ip : c3817e60  fp : c3817f44
r10: 00000000  r9 : 00000000  r8 : 00000000
r7 : 00000000  r6 : c021c820  r5 : c021d4f0  r4 : 00000000
r3 : c4808000  r2 : c0207434  r1 : 0000070f  r0 : c01d3d20
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387f  Table: 80004019  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc38162e0)
Stack: (0xc3817f30 to 0xc3818000)
7f20:                                     c001c57c c001c530 c3817f54 c3817f48
7f40: c000e650 c00119d4 c3817fdc c3817f58 c0023298 c000e63c c383d0a0 c020e530
7f60: c000e630 00000000 c3817f94 c3817f78 c00d3600 c00d33b0 c3817f94 c383e800
7f80: c00d3740 c3817f9e c3817fc4 c3817f98 c006e7ac c00d35d0 c3817fb4 3533f9f0
7fa0: 00000031 00000000 00000170 c001c530 00000000 c001c57c c001c530 00000000
7fc0: 00000000 00000000 00000000 00000000 c3817ff4 c3817fe0 c00088b8 c0023244
7fe0: 00000000 00000000 00000000 c3817ff8 c004b598 c0008854 00ffff00 00ffff00
Backtrace:
[<c00119c8>] (omap_ldp_init+0x0/0x1a4) from [<c000e650>]
(customize_machine+0x20/0x2c)
 r5:c001c530 r4:c001c57c
[<c000e630>] (customize_machine+0x0/0x2c) from [<c0023298>]
(__exception_text_end+0x60/0x198)
[<c0023238>] (__exception_text_end+0x0/0x198) from [<c00088b8>]
(kernel_init+0x70/0xdc)
[<c0008848>] (kernel_init+0x0/0xdc) from [<c004b598>] (do_exit+0x0/0x65c)
 r5:00000000 r4:00000000
Code: e3a04000 e59f503c e59f0064 e5953008 (e7d31004)
<4>---[ end trace 1b75b31a2719ed1c ]---
<0>Kernel panic - not syncing: Attempted to kill init!'


I tried to find cause of fault but failed. Could anyone please help me with it?

Thanks,
Shreyas.
