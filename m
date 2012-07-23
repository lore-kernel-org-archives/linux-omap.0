From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: am3517: USB state in 3.5-rc6
Date: Mon, 23 Jul 2012 09:08:02 +0200
Message-ID: <500CF852.4020005@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hhlx01.vscom.de ([62.145.30.242]:40179 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156Ab2GWHIQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jul 2012 03:08:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Mark A. Greer" <mgreer@animalcreek.com>, "Porter, Matt" <mporter@ti.com>

After getting MMC working I now have following issues: both musb and EHCI make problems.

musb:

musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
musb-am35x musb-am35x: failed to get clock
musb-am35x: probe of musb-am35x failed with error -2  

EHCI with attached smsc9514:

LR is at __func__.12097+0x81924/0xda0c4
pc : [<c02e5250>]    lr : [<c0549a80>]    psr: 60000013
sp : cf92dea8  ip : 00000000  fp : 00000002
r10: cfb07000  r9 : 00000001  r8 : 00000003
r7 : cfb11800  r6 : 00000032  r5 : 00000000  r4 : cfb2cc00
r3 : c05919a0  r2 : c05851fc  r1 : c0585220  r0 : cfb2cc68
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 80004019  DAC: 00000015
Process khubd (pid: 385, stack limit = 0xcf92c2f0)
Stack: (0xcf92dea8 to 0xcf92e000)
dea0:                   00000002 00000000 00000001 00000000 cfb07000 c006eb24
dec0: a0000013 00000000 00000003 cfb11c00 00000000 c0496a9c cfb2cc00 cfb07000
dee0: cfb2cc00 cfb11800 00000000 cfb11c18 00000001 cfb11c00 00000002 c02e6e0c
df00: 00000501 00000000 c0585740 c04959c0 00000001 20000093 cfb07008 cfb1189c
df20: cfb11400 00000000 cfb07078 cfb07070 cfb07008 cfb07000 cfb11800 cfb11420
df40: cfb11800 cfb11420 cfb11c00 00000009 cf92df84 c00590e4 00000000 cf92c000
df60: 00000000 cf8b8100 c0051304 cf92df6c cf92df6c 00000000 05010000 c006eb24
df80: 60000013 cf82df18 cf92dfb4 00000000 c02e66e4 00000000 00000000 00000000
dfa0: 00000000 c00508dc cf92c000 00000000 00000000 00000000 00000001 dead4ead
dfc0: ffffffff ffffffff c06894d8 00000000 00000000 c054b8a4 cf92dfd8 cf92dfd8
dfe0: cf82df18 cf82df18 c0050850 c00146f0 00000013 c00146f0 ffffffff ffffffff
[<c02e5250>] (hub_port_init+0x14c/0x97c) from [<c02e6e0c>] (hub_thread+0x728/0x13b0)
[<c02e6e0c>] (hub_thread+0x728/0x13b0) from [<c00508dc>] (kthread+0x8c/0x98)
[<c00508dc>] (kthread+0x8c/0x98) from [<c00146f0>] (kernel_thread_exit+0x0/0x8)
Code: e59f17fc e592c080 e59f27f8 11a0200e (e59cc000)
---[ end trace 56f9d1e7cf52e660 ]---   

Yegor                    
