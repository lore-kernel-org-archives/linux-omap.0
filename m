From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [BRIDGE] bridgedriver load/unload problem
Date: Mon, 10 Nov 2008 13:59:17 +0200 (EET)
Message-ID: <20081110.135917.46194187.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:22714 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306AbYKJL7q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 06:59:46 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ramesh <x0023949@ti.com>
Cc: linux-omap@vger.kernel.org, vpasam@ti.com

Hi,

I got the following error, has anyone got the similar problem?

custom:~# cat test.sh
#!/bin/sh

modprobe bridgedriver \
    base_img=./ddspbase_tiomap3430.dof64P && \
    ./ping.out 1 && \
    rmmod bridgedriver

custom:~# ./test.sh
DSP device detected !! 
DSPNodeCreate succeeded 
DSPNode_registerNotify succeeded 
DSPNode_run succeeded 
Ping: Id 1.000000 Msg 0.000000 Mem 15408.000000
custom:~# 
custom:~# ./test.sh
DSP device detected !! Unable to handle kernel paging request at virtual address be5e7017

pgd = c0004000
[be5e7017] *pgd=00000000
Internal error: Oops: 805 [#1] PREEMPT
Modules linked in: bridgedriver smc91x mii tsc2005 omap_hsmmc mmc_core rtc_twl4030 rtc_core [last unloaded: bridgedriver]
CPU: 0    Not tainted  (2.6.27-omap1 #70)
PC is at PrintDSPDebugTrace+0xe4/0x114 [bridgedriver]
LR is at PrintDSPDebugTrace+0xc8/0x114 [bridgedriver]
pc : [<bf0315b0>]    lr : [<bf031594>]    psr: 40000013
sp : cf423ed8  ip : cf5f0018  fp : cf423eec
r10: cf776158  r9 : ff3f1000  r8 : cea9f018
r7 : cf776758  r6 : ff3f93f0  r5 : cea9f018  r4 : eeff5000
r3 : 00000000  r2 : be5e5018  r1 : 00001fff  r0 : bf08028c
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387f  Table: 8eaa8018  DAC: 00000017
Process ksoftirqd/0 (pid: 3, stack limit = 0xcf4222e0)
Stack: (0xcf423ed8 to 0xcf424000)
3ec0:                                                       0000ffff 0000ffff 
3ee0: cf423f4c cf423ef0 bf0322ac bf0314d8 9343a811 00000022 cf422000 00000000 
3f00: ff3f9360 ff3f9370 00000000 00000000 00000000 fffffffe cea407f8 cf776758 
3f20: cf423f54 cf776b78 00000001 00000001 00000000 00000000 00000000 00000000 
3f40: cf423f6c cf423f50 bf02b394 bf0319e4 00000001 00000000 0000000a 00000000 
3f60: cf423f84 cf423f70 c0055804 bf02b330 00000001 c036f3f4 cf423fa4 cf423f88 
3f80: c0055600 c00557a4 60000013 00000000 00000000 00000000 cf423fbc cf423fa8 
3fa0: c00556b8 c00555b0 cf422000 00000000 cf423fdc cf423fc0 c0055aa0 c0055674 
3fc0: 00000000 c0055a28 00000000 00000000 cf423ff4 cf423fe0 c0065758 c0055a34 
3fe0: 00000000 00000000 00000000 cf423ff8 c00533f0 c0065710 00000000 00000000 
Backtrace: 
[<bf0314cc>] (PrintDSPDebugTrace+0x0/0x114 [bridgedriver]) from [<bf0322ac>] (IO_DPC+0x8d4/0x960 [bridgedriver])
 r5:0000ffff r4:0000ffff
[<bf0319d8>] (IO_DPC+0x0/0x960 [bridgedriver]) from [<bf02b394>] (DPC_DeferredProcedure+0x70/0xb8 [bridgedriver])
[<bf02b324>] (DPC_DeferredProcedure+0x0/0xb8 [bridgedriver]) from [<c0055804>] (tasklet_action+0x6c/0xb8)
 r7:00000000 r6:0000000a r5:00000000 r4:00000001
[<c0055798>] (tasklet_action+0x0/0xb8) from [<c0055600>] (__do_softirq+0x5c/0xc4)
 r5:c036f3f4 r4:00000001
[<c00555a4>] (__do_softirq+0x0/0xc4) from [<c00556b8>] (do_softirq+0x50/0x5c)
 r7:00000000 r6:00000000 r5:00000000 r4:60000013
[<c0055668>] (do_softirq+0x0/0x5c) from [<c0055aa0>] (ksoftirqd+0x78/0x14c)
 r5:00000000 r4:cf422000
[<c0055a28>] (ksoftirqd+0x0/0x14c) from [<c0065758>] (kthread+0x54/0x80)
 r7:00000000 r6:00000000 r5:c0055a28 r4:00000000
[<c0065704>] (kthread+0x0/0x80) from [<c00533f0>] (do_exit+0x0/0x788)
 r5:00000000 r4:00000000
Code: e0631001 e59f002c e0822004 e3a03000 (e7c23001) 
Kernel panic - not syncing: Fatal exception in interrupt

You can get the whole GT_str enabled log from:

http://4869037.web.fc2.com/bridge-load-problem.txt

Any info would be appreciated.

    Hiroshi DOYU
