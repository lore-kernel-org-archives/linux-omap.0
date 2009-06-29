From: Hugo Vincent <hugo.vincent@gmail.com>
Subject: musb Rx DMA (Mentor) failure when one DMA receive is started before
	the previous completes (??)
Date: Mon, 29 Jun 2009 14:50:38 +1200
Message-ID: <5a7b8b7b0906281950u2d135060x1e29fea44c1a7bd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:33221 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbZF2Czq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jun 2009 22:55:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, linux-usb@vger.kernel.org

Hi all,

I'm still seeing a problem with musb receive DMA crashing when large
transfers happen in rapid succession.

I've narrowed it down to this test case: Pinging the OMAP over USB
ethernet gadget, with large (64K) ping packets. At the start, the
system is otherwise idle. If the interval is set higher than the ping
time (i.e. 0.05 = 50ms in the first example), then it doesn't crash.
If I reduce the interval of these packets to 20 ms (second example
below), then start loading the system (increasing the ping time
through 20 ms), I see the crash (log below). Alternately, decreasing
the ping interval to 10 ms causes the crash after one packet.

desktop ~$ sudo ping -i 0.05 -s 65507 192.168.2.2
PING 192.168.2.2 (192.168.2.2) 65507(65535) bytes of data.
65515 bytes from 192.168.2.2: icmp_seq=1 ttl=64 time=19.4 ms
65515 bytes from 192.168.2.2: icmp_seq=2 ttl=64 time=19.4 ms
65515 bytes from 192.168.2.2: icmp_seq=3 ttl=64 time=19.4 ms
...
--> Does NOT crash

desktop ~$ sudo ping -i 0.02 -s 65507 192.168.2.2
PING 192.168.2.2 (192.168.2.2) 65507(65535) bytes of data.
65515 bytes from 192.168.2.2: icmp_seq=1 ttl=64 time=19.5 ms
65515 bytes from 192.168.2.2: icmp_seq=2 ttl=64 time=19.3 ms
65515 bytes from 192.168.2.2: icmp_seq=3 ttl=64 time=19.3 ms
...
--> Does crash, as soon as the system is loaded a bit such that the
ping time would increase beyond 20 ms.



Output of the crash:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 817 [#1] PREEMPT
Modules linked in: g_ether ipv6 evbug
CPU: 0    Not tainted  (2.6.29.5-rt22-omap1 #1)
PC is at dma_channel_program+0x90/0x108
LR is at rxstate+0xc8/0x1b4
pc : [<c02419b8>]    lr : [<c023d2e8>]    psr: 60000013
sp : cf891de8  ip : cf891e30  fp : cf891e2c
r10: 00000000  r9 : 00000154  r8 : 8f9bb802
r7 : 00000200  r6 : cf8f2070  r5 : cf8f2070  r4 : cf8f2000
r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : cf8f2070
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 8fbec019  DAC: 00000017
Process IRQ-12 (pid: 71, stack limit = 0xcf8902f0)
Stack: (0xcf891de8 to 0xcf892000)
1de0:                   00000000 c023d47c cfa16d80 cf83c0d0 00000000 cf83c298
1e00: cf83c0d0 cf8f2000 ceeca7a0 cf83c0d0 00000154 00002003 d80ab110 00000001
1e20: cf891e6c cf891e30 c023d2e8 c0241934 00000154 c02e9a90 cf891eac cf891e48
1e40: c02e9018 00002003 ceeca7a0 cf83c0d0 00000003 cf8f2070 d80ab110 00000001
1e60: cf891eb4 cf891e70 c023db48 c023d22c cf891eb4 cf891e80 00000000 c00444b4
1e80: cf83c298 cf83c2d4 cf8f2070 00000020 cf8f2070 000001ea 8eea7402 cf83c0d0
1ea0: 00000001 8eea75ec cf891ec4 cf891eb8 c02396d8 c023d824 cf891f04 cf891ec8
1ec0: c0241c14 c0239678 c0047ab8 00000000 00000000 00000000 fffffffd 00000000
1ee0: 00000020 cf875030 ffffffff 00000001 00000030 000000ec cf891f3c cf891f08
1f00: c0039084 c0241b58 cf891f3c d80560ec c0068a9c c03dcf54 cf890000 c03d8b60
1f20: 0000000c 00000000 0000000c 00000000 cf891f74 cf891f40 c007a5a8 c0038e20
1f40: cf88c200 00000000 cf891f84 c03dcf54 cf890000 c007ac58 0000000c c03d8b60
1f60: c03dcfac c0417fa8 cf891f9c cf891f78 c007ac08 c007a4e8 c03dcf54 0000000c
1f80: c007ac58 cf890000 60000013 c03dcf94 cf891fd4 cf891fa0 c007ad20 c007abac
1fa0: 00000000 00000032 00000000 cf890000 c03dcf54 c007ac58 00000000 00000000
1fc0: 00000000 00000000 cf891ff4 cf891fd8 c00631a8 c007ac64 00000000 00000000
1fe0: 00000000 00000000 00000000 cf891ff8 c00512b8 c0063158 2227cf00 fb2fee38
Backtrace:
[<c0241928>] (dma_channel_program+0x0/0x108) from [<c023d2e8>]
(rxstate+0xc8/0x1b4)
[<c023d220>] (rxstate+0x0/0x1b4) from [<c023db48>] (musb_g_rx+0x330/0x3ac)
[<c023d818>] (musb_g_rx+0x0/0x3ac) from [<c02396d8>]
(musb_dma_completion+0x6c/0x70)
[<c023966c>] (musb_dma_completion+0x0/0x70) from [<c0241c14>]
(musb_sysdma_completion+0xc8/0xf0)
[<c0241b4c>] (musb_sysdma_completion+0x0/0xf0) from [<c0039084>]
(omap2_dma_irq_handler+0x270/0x2cc)
[<c0038e14>] (omap2_dma_irq_handler+0x0/0x2cc) from [<c007a5a8>]
(handle_IRQ_event+0xcc/0x1d8)
[<c007a4dc>] (handle_IRQ_event+0x0/0x1d8) from [<c007ac08>]
(thread_simple_irq+0x68/0xb8)
[<c007aba0>] (thread_simple_irq+0x0/0xb8) from [<c007ad20>] (do_irqd+0xc8/0x31c)
[<c007ac58>] (do_irqd+0x0/0x31c) from [<c00631a8>] (kthread+0x5c/0x94)
[<c006314c>] (kthread+0x0/0x94) from [<c00512b8>] (do_exit+0x0/0x680)
 r6:00000000 r5:00000000 r4:00000000
Code: 13a03000 03a03001 1a000002 e3a03000 (e5833000)
---[ end trace 43ed0404537df3a4 ]---

I've tried looking for existing patches to fix this without much luck.
I tried the following two patches (freshened appropriately), which
don't seem to fix it.
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg02733.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg07992.html

Note that this is with 2.6.29-omap1 but I've also tried with the
latest linux-omap git and it seems to have the same problem.

Any ideas?

Many thanks,
Hugo Vincent
