From: "Juha Kuikka" <juha.kuikka@gmail.com>
Subject: OOPS in OMAP 1-wire driver
Date: Wed, 19 Nov 2008 16:40:34 -0800
Message-ID: <a46a26fd0811191640w70ef4e2cy5551e26a433c0532@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.251]:17926 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbYKTAkf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Nov 2008 19:40:35 -0500
Received: by hs-out-0708.google.com with SMTP id 4so132911hsl.5
        for <linux-omap@vger.kernel.org>; Wed, 19 Nov 2008 16:40:34 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I'm not sure this is the right place for 1-wire stuff but I remember
seeing patches for the OMAP 1w driver so maybe someone is interested.

Running git head on OMAP2430 SDP. Only OMAP master is built into the
kernel, no slave modules.
This happens on boot.

Driver for 1-wire Dallas network protocol.
omap_hdq omap_hdq.0: OMAP HDQ Hardware Rev 0.3. Driver in Interrupt mode
Unable to handle kernel NULL pointer dereference at virtual address 000000f0
pgd = c0004000
[000000f0] *pgd=00000000
Internal error: Oops: 0 [#1] PREEMPT
Modules linked in:
CPU: 0    Not tainted  (2.6.28-rc5-omap1 #21)
PC is at 0xf0
LR is at omap_w1_search_bus+0x64/0x70
pc : [<000000f0>]    lr : [<c01af368>]    psr: 60000013
sp : c7957f68  ip : c7957f68  fp : c7957f8c
r10: 00000000  r9 : 00000000  r8 : 00000000
r7 : 000000f0  r6 : c7829160  r5 : 00000000  r4 : 00000001
r3 : 3d000000  r2 : 00000001  r1 : 3d000000  r0 : c7829160
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387f  Table: 80004000  DAC: 00000017
Process w1_bus_master1 (pid: 263, stack limit = 0xc7956260)
Stack: (0xc7957f68 to 0xc7958000)
7f60:                   00000001 00000000 c01af304 000000f0 c7956000 000003e8
7f80: c7957fa4 c7957f90 c01aed58 c01af310 c7943a00 c7943a00 c7957fbc c7957fa8
7fa0: c01ad880 c01aed20 c7943a68 c7943a00 c7957fdc c7957fc0 c01ad958 c01ad830
7fc0: c7943a00 c01ad8fc 00000000 00000000 c7957ff4 c7957fe0 c0059fd0 c01ad908
7fe0: 00000000 00000000 00000000 c7957ff8 c0048104 c0059f88 ff00ff00 ff00ff00
Backtrace:
[<c01af304>] (omap_w1_search_bus+0x0/0x70) from [<c01aed58>]
(w1_search_devices+0x44/0x50)
 r7:000003e8 r6:c7956000 r5:000000f0 r4:c01af304
[<c01aed14>] (w1_search_devices+0x0/0x50) from [<c01ad880>]
(w1_search_process+0x5c/0xd8)
 r5:c7943a00 r4:c7943a00
[<c01ad824>] (w1_search_process+0x0/0xd8) from [<c01ad958>]
(w1_process+0x5c/0xe0)
 r5:c7943a00 r4:c7943a68
[<c01ad8fc>] (w1_process+0x0/0xe0) from [<c0059fd0>] (kthread+0x54/0x80)
 r7:00000000 r6:00000000 r5:c01ad8fc r4:c7943a00
[<c0059f7c>] (kthread+0x0/0x80) from [<c0048104>] (do_exit+0x0/0x784)
 r5:00000000 r4:00000000
Code: bad PC value.


-- 
Madness takes it's toll. Please have exact change.
