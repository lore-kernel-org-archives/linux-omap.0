From: Felipe Balbi <me@felipebalbi.com>
Subject: omap24xx is broken in current head
Date: Sun, 10 Aug 2008 14:58:19 +0300
Message-ID: <20080810115818.GG7574@frodo>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56818 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbYHJL60 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Aug 2008 07:58:26 -0400
Received: from a91-154-115-238.elisa-laajakaista.fi ([91.154.115.238]:20257 helo=frodo)
	by serv01.siteground211.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <me@felipebalbi.com>)
	id 1KS9Z1-0000S4-TK
	for linux-omap@vger.kernel.org; Sun, 10 Aug 2008 06:58:24 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi,

at least n810 is not booting with current l-o head

The problem is in clockdomain.c:omap2_clkdm_clk_enable/disable()
functions.

Well, just for keep hacking I returned on top of the function and it's
ok so far :-p

Below is the Unhandled fault exception from console.

<5>Kernel command line: root=1f03 rootfstype=jffs2
<6>Clocking rate (Crystal/DPLL/MPU): 19.2/658/329 MHz
<1>Unhandled fault: alignment exception (0x001) at 0xc02c1b4e
Internal error: : 1 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.26-omap1 #10)
PC is at omap2_clkdm_clk_enable+0x2c/0x74
LR is at omap2_clk_enable+0x54/0x9c
pc : [<c00348e0>]    lr : [<c0033118>]    psr: a00001d3
sp : c0307e90  ip : c0307ea8  fp : c0307ea4
r10: 800242c0  r9 : 4107b362  r8 : 00000013
r7 : c032b4c4  r6 : 00000002  r5 : 00000000  r4 : c02c1b42
r3 : c02c1b4e  r2 : 00000000  r1 : c030b5d4  r0 : c02c1b42
Flags: NzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387f  Table: 80004000  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc0306260)
Stack: (0xc0307e90 to 0xc0308000)
7e80:                                     c030b5d4 c030b030 c0307ebc c0307ea8 
7ea0: c0033118 c00348c0 c030b088 c030b030 c0307ed4 c0307ec0 c00330fc c00330d0 
7ec0: c030b500 c030b030 c0307eec c0307ed8 c00330fc c00330d0 c030b6fc c030b030 
7ee0: c0307f04 c0307ef0 c00330fc c00330d0 c030c09c c030b030 c0307f1c c0307f08 
7f00: c00330fc c00330d0 c030dccc c030b030 c0307f34 c0307f20 c00330fc c00330d0 
7f20: 800001d3 c030b030 c0307f4c c0307f38 c0043260 c00330d0 c030dccc c030b030 
7f40: c0307f64 c0307f50 c0043340 c004322c 00000292 c030b030 c0307f94 c0307f68 
7f60: c00114d0 c0043320 00000149 c0309ce0 c0307f94 00000000 c032a8c0 c0025f24 
7f80: c0309ce0 8002435c c0307fac c0307f98 c00107e4 c001130c c0025f28 c032a8c0 
7fa0: c0307fbc c0307fb0 c0011b70 c00107c8 c0307fcc c0307fc0 c000e438 c0011b68 
7fc0: c0307ff4 c0307fd0 c0008c18 c000e40c c0008568 00000000 00000000 c0025f28 
7fe0: 00c5387d c032b24c 00000000 c0307ff8 80008034 c0008ad4 00000000 00000000 
Backtrace: 
[<c00348b4>] (omap2_clkdm_clk_enable+0x0/0x74) from [<c0033118>] (omap2_clk_enable+0x54/0x9c)
 r5:c030b030 r4:c030b5d4
[<c00330c4>] (omap2_clk_enable+0x0/0x9c) from [<c00330fc>] (omap2_clk_enable+0x38/0x9c)
 r5:c030b030 r4:c030b088
[<c00330c4>] (omap2_clk_enable+0x0/0x9c) from [<c00330fc>] (omap2_clk_enable+0x38/0x9c)
 r5:c030b030 r4:c030b500                                                            
[<c00330c4>] (omap2_clk_enable+0x0/0x9c) from [<c00330fc>] (omap2_clk_enable+0x38/0x9c)
 r5:c030b030 r4:c030b6fc                                                            
[<c00330c4>] (omap2_clk_enable+0x0/0x9c) from [<c00330fc>] (omap2_clk_enable+0x38/0x9c)
 r5:c030b030 r4:c030c09c
[<c00330c4>] (omap2_clk_enable+0x0/0x9c) from [<c00330fc>] (omap2_clk_enable+0x38/0x9c)
 r5:c030b030 r4:c030dccc
[<c00330c4>] (omap2_clk_enable+0x0/0x9c) from [<c0043260>] (clk_enable+0x40/0x54)
 r5:c030b030 r4:800001d3
[<c0043220>] (clk_enable+0x0/0x54) from [<c0043340>] (clk_enable_init_clocks+0x2c/0x4c)
 r5:c030b030 r4:c030dccc
[<c0043314>] (clk_enable_init_clocks+0x0/0x4c) from [<c00114d0>] (omap2_clk_init+0x1d0/0x23c)
 r5:c030b030 r4:00000292
[<c0011300>] (omap2_clk_init+0x0/0x23c) from [<c00107e4>] (omap2_init_common_hw+0x28/0x40)
 r8:8002435c r7:c0309ce0 r6:c0025f24 r5:c032a8c0 r4:00000000
[<c00107bc>] (omap2_init_common_hw+0x0/0x40) from [<c0011b70>] (nokia_n800_init_irq+0x14/0x5c)
 r5:c032a8c0 r4:c0025f28
[<c0011b5c>] (nokia_n800_init_irq+0x0/0x5c) from [<c000e438>] (init_IRQ+0x38/0x48)
[<c000e400>] (init_IRQ+0x0/0x48) from [<c0008c18>] (start_kernel+0x150/0x2a8)
[<c0008ac8>] (start_kernel+0x0/0x2a8) from [<80008034>] (0x80008034)
 r5:c032b24c r4:00c5387d
Code: 03a05001 03e00015 089da830 e284300c (e1931f9f) 
<4>---[ end trace 1b75b31a2719ed1c ]---

I'm gonna try to get more info on this later

-- 
balbi
