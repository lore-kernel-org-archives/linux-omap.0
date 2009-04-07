From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: PM: omap_wdt: modprobe fails
Date: Tue, 07 Apr 2009 14:10:38 +0300
Message-ID: <49DB34AE.3090100@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:21637 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbZDGLLT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2009 07:11:19 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n37BB2MF026735
	for <linux-omap@vger.kernel.org>; Tue, 7 Apr 2009 14:11:12 +0300
Received: from [172.21.39.110] (esdhcp039110.research.nokia.com [172.21.39.110])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n37BB5fA009821
	for <linux-omap@vger.kernel.org>; Tue, 7 Apr 2009 14:11:06 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

hi,

   modprobe omap_wdt fails in omap PM branch. below is the trace log.
any idea why?

   i wonder weather fails in master too.

regards,
-roger

[   37.218078] Unhandled fault: external abort on non-linefetch (0x1028) at 
0xd8314034
[   37.225982] Internal error: : 1028 [#1]
[   37.229888] Modules linked in: omap_wdt(+) tsc2005 rtc_twl4030 rtc_core
[   37.236633] CPU: 0    Not tainted  (2.6.29-omap1-06218-gcc1a62b #93)
[   37.243072] PC is at omap_wdt_disable+0x20/0x4c [omap_wdt]
[   37.248626] LR is at omap_wdt_probe+0xf8/0x1ec [omap_wdt]
[   37.254089] pc : [<bf0180bc>]    lr : [<bf01c130>]    psr: a0000013
[   37.254119] sp : ce927db0  ip : ce927dc0  fp : ce927dbc
[   37.265716] r10: c032ddf0  r9 : bf01928c  r8 : c032ddd0
[   37.270996] r7 : ce9712a0  r6 : c032ddf8  r5 : 00000000  r4 : cf160be0
[   37.277587] r3 : 0000aaaa  r2 : 00000000  r1 : d8314048  r0 : d8314000
[   37.284179] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   37.291412] Control: 10c5387d  Table: 8e94c019  DAC: 00000015
[   37.297210] Process modprobe (pid: 743, stack limit = 0xce9262e0)
[   37.303375] Stack: (0xce927db0 to 0xce928000)
[   37.307769] 7da0:                                     ce927df4 ce927dc0 
bf01c130 bf0180a
[   37.316253] 7dc0: 00000000 c034a3d8 ce927de4 c032ddf8 c032dea4 bf019154 
bf019154 c034a3d
[   37.324707] 7de0: ce926000 40024000 ce927e04 ce927df8 c017bf98 bf01c044 
ce927e24 ce927e0
[   37.333190] 7e00: c017b180 c017bf84 c032ddf8 c032dea4 bf019154 bf019154 
ce927e44 ce927e2
[   37.341644] 7e20: c017b294 c017b0b8 00000000 ce927e48 c017b22c bf019154 
ce927e6c ce927e4
[   37.350128] 7e40: c017a590 c017b238 cf81ce5c c032de4c 00000000 bf019154 
c0354580 ce870aa
[   37.358581] 7e60: ce927e7c ce927e70 c017afc4 c017a550 ce927eac ce927e80 
c017ab58 c017afb
[   37.367065] 7e80: bf018650 00000000 c0029a64 00002518 bf019154 c0354580 
00000000 c0029a6
[   37.375518] 7ea0: ce927ed4 ce927eb0 c017b4b8 c017aabc 00002518 bf019184 
c0354580 0000000
[   37.384002] 7ec0: c0029a64 40024000 ce927ee4 ce927ed8 c017c3b4 c017b42c 
ce927ef4 ce927ee
[   37.392456] 7ee0: bf01c028 c017c354 ce927f7c ce927ef8 c00292c0 bf01c00c 
c014280c c0258b5
[   37.400939] 7f00: bf01c000 00000000 bf019184 ffffffff ce927f34 ce927f20 
c0065548 c014276
[   37.409393] 7f20: 00000000 c03319dc ce927f64 ce927f38 c0065f44 c006552c 
00000000 ce927f4
[   37.417877] 7f40: c0256bf0 00002518 bf019184 4001e000 00000000 00002518 
bf019184 4001e00
[   37.426330] 7f60: 00000000 c0029a64 ce926000 40024000 ce927fa4 ce927f80 
c007ac60 c002926
[   37.434814] 7f80: 00000003 00000000 bea3a98c 4001cbe0 00000000 00000080 
00000000 ce927fa
[   37.443267] 7fa0: c00298e0 c007abd0 bea3a98c 4001cbe0 4001e000 00002518 
0001afa0 0000251
[   37.451751] 7fc0: bea3a98c 4001cbe0 00000000 00000080 00000000 00000000 
40024000 bea3a9c
[   37.460205] 7fe0: 00000000 bea3a94c 0000b6e8 400f0f64 60000010 4001e000 
0177aeee 0000000
[   37.468688] Backtrace:
[   37.471191] [<bf01809c>] (omap_wdt_disable+0x0/0x4c [omap_wdt]) from 
[<bf01c130>] (omap_)
[   37.482238] [<bf01c038>] (omap_wdt_probe+0x0/0x1ec [omap_wdt]) from 
[<c017bf98>] (platfo)
[   37.492492] [<c017bf78>] (platform_drv_probe+0x0/0x24) from [<c017b180>] 
(driver_probe_d)
[   37.502227] [<c017b0ac>] (driver_probe_device+0x0/0x180) from [<c017b294>] 
(__driver_att)
[   37.511657]  r7:bf019154 r6:bf019154 r5:c032dea4 r4:c032ddf8
[   37.517456] [<c017b22c>] (__driver_attach+0x0/0x8c) from [<c017a590>] 
(bus_for_each_dev+)
[   37.526550]  r7:bf019154 r6:c017b22c r5:ce927e48 r4:00000000
[   37.532318] [<c017a544>] (bus_for_each_dev+0x0/0x84) from [<c017afc4>] 
(driver_attach+0x)
[   37.541259]  r7:ce870aa0 r6:c0354580 r5:bf019154 r4:00000000
[   37.547027] [<c017afa4>] (driver_attach+0x0/0x28) from [<c017ab58>] 
(bus_add_driver+0xa8)
[   37.555877] [<c017aab0>] (bus_add_driver+0x0/0x214) from [<c017b4b8>] 
(driver_register+0)
[   37.564971]  r8:c0029a64 r7:00000000 r6:c0354580 r5:bf019154 r4:00002518
[   37.571807] [<c017b420>] (driver_register+0x0/0x120) from [<c017c3b4>] 
(platform_driver_)
[   37.581695] [<c017c348>] (platform_driver_register+0x0/0x88) from 
[<bf01c028>] (omap_wdt)
[   37.592315] [<bf01c000>] (omap_wdt_init+0x0/0x38 [omap_wdt]) from 
[<c00292c0>] (__except)
[   37.602661] [<c0029260>] (__exception_text_end+0x0/0x19c) from [<c007ac60>] 
(sys_init_mo)
[   37.612304] [<c007abc4>] (sys_init_module+0x0/0x1a4) from [<c00298e0>] 
(ret_fast_syscall)
[   37.621429]  r7:00000080 r6:00000000 r5:4001cbe0 r4:bea3a98c
[   37.627197] Code: e30a3aaa e2801048 e5803048 eaffffff (e5903034)
[   37.633514] ---[ end trace 1e4c3ca59877c8bf ]---
udevd-event[741]: run_program: '/sbin/modprobe' abnormal exit

