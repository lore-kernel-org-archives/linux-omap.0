From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: MMC issues with 2.6.27-rc7
Date: Tue, 23 Sep 2008 00:02:51 +0300
Message-ID: <94a0d4530809221402l79abae77re8b062974e1af4a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:57323 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbYIVVCx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Sep 2008 17:02:53 -0400
Received: by ey-out-2122.google.com with SMTP id 6so502465eyi.37
        for <linux-omap@vger.kernel.org>; Mon, 22 Sep 2008 14:02:51 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Hi,

I just moved to 2.6.27-rc7 from rc6 and I'm having a lot of issues with MMC.

== error ==

mmcblk0: error -84 transferring data
end_request: I/O error, dev mmcblk0, sector 882464
end_request: I/O error, dev mmcblk0, sector 882472
end_request: I/O error, dev mmcblk0, sector 882480
end_request: I/O error, dev mmcblk0, sector 882488
end_request: I/O error, dev mmcblk0, sector 882496
end_request: I/O error, dev mmcblk0, sector 882504
end_request: I/O error, dev mmcblk0, sector 882512
end_request: I/O error, dev mmcblk0, sector 882520
end_request: I/O error, dev mmcblk0, sector 882528
end_request: I/O error, dev mmcblk0, sector 882536
end_request: I/O error, dev mmcblk0, sector 882544
end_request: I/O error, dev mmcblk0, sector 882552
end_request: I/O error, dev mmcblk0, sector 882560
end_request: I/O error, dev mmcblk0, sector 882568
end_request: I/O error, dev mmcblk0, sector 882576
end_request: I/O error, dev mmcblk0, sector 882584

== crash ==

Unable to handle kernel NULL pointer dereference at virtual address 00000010
pgd = c6c68000
[00000010] *pgd=86c5e031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1]
Modules linked in: bridgedriver
CPU: 0    Not tainted  (2.6.27-rc7-omap1-05018-g43b5659-dirty #66)
PC is at mmc_omap_irq+0x1cc/0x220
LR is at try_to_wake_up+0x7c/0xb0
pc : [<c02253c8>]    lr : [<c004da58>]    psr: 20000193
sp : c6427f30  ip : 00001eff  fp : c6427f54
r10: 00000420  r9 : c6426000  r8 : 00000000
r7 : 00000000  r6 : 00000000  r5 : 00000003  r4 : c799c9c0
r3 : 00000000  r2 : 00000000  r1 : c78686e0  r0 : 00000001
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 00c5387f  Table: 86c68018  DAC: 00000015
Process gst-launch-0.10 (pid: 394, stack limit = 0xc64262e0)
Stack: (0xc6427f30 to 0xc6428000)
7f20:                                     c7888a60 00000000 00000000 00000053
7f40: 00000000 c6426000 c6427f74 c6427f58 c00768c8 c0225208 c03a6acc 00000053
7f60: 00000000 0006c064 c6427f8c c6427f78 c0078120 c0076898 00000053 c03a6acc
7f80: c6427fac c6427f90 c002e048 c0078058 ffffffff d8200000 0006c060 0006c064
7fa0: 00000000 c6427fb0 c002e9d8 c002e00c 0006c064 00000002 00000001 00000002
7fc0: 00000002 40115604 0006c060 0006c064 00000000 00000000 00000420 0000100c
7fe0: 00000040 418a9b90 400dc47c 400d6d84 20000010 ffffffff 001922c7 00001502
Backtrace:
[<c02251fc>] (mmc_omap_irq+0x0/0x220) from [<c00768c8>]
(handle_IRQ_event+0x3c/0x74)
 r9:c6426000 r8:00000000 r7:00000053 r6:00000000 r5:00000000
r4:c7888a60
[<c007688c>] (handle_IRQ_event+0x0/0x74) from [<c0078120>]
(handle_level_irq+0xd4/0xf0)
 r7:0006c064 r6:00000000 r5:00000053 r4:c03a6acc
[<c007804c>] (handle_level_irq+0x0/0xf0) from [<c002e048>]
(__exception_text_start+0x48/0x64)
 r5:c03a6acc r4:00000053
[<c002e000>] (__exception_text_start+0x0/0x64) from [<c002e9d8>]
(__irq_usr+0x38/0x80)
Exception stack(0xc6427fb0 to 0xc6427ff8)
7fa0:                                     0006c064 00000002 00000001 00000002
7fc0: 00000002 40115604 0006c060 0006c064 00000000 00000000 00000420 0000100c
7fe0: 00000040 418a9b90 400dc47c 400d6d84 20000010 ffffffff
 r7:0006c064 r6:0006c060 r5:d8200000 r4:ffffffff
Code: 0a000015 e3a02000 e5842010 e5c42051 (e5963010)
Kernel panic - not syncing: Fatal exception in interrupt

-- 
Felipe Contreras
