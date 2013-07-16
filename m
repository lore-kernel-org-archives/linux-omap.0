From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] ARM: OMAP3: Beagle: Fix USB Host on beagle xM Ax/Bx
Date: Tue, 16 Jul 2013 17:37:34 +0300
Message-ID: <51E55AAE.3000209@ti.com>
References: <1366024808-4691-1-git-send-email-rogerq@ti.com> <51DC09E7.1070302@denx.de> <51DC164B.5010608@ti.com> <51DC1B47.7070504@denx.de> <51DE87D3.5030600@ti.com> <51DEA7F1.1050902@denx.de> <51DEC2CE.70400@ti.com> <51DED076.3040000@denx.de> <51DEF0DE.4050607@denx.de> <51DFC92F.1050701@ti.com> <51DFDFD4.3040900@denx.de> <51E3AFF4.7060607@ti.com> <51E3B1B1.3060202@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41688 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932455Ab3GPOiE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Jul 2013 10:38:04 -0400
In-Reply-To: <51E3B1B1.3060202@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, Alan Stern <stern@rowland.harvard.edu>

+Alan

On 07/15/2013 11:24 AM, Stefan Roese wrote:
> On 07/15/2013 10:16 AM, Roger Quadros wrote:
>>>> I can only test on beagle-xm (which is also rev. C2) with integrated SMSC ethernet chip
>>>> as I don't have an external USB-ethernet adapter.
>>>
>>> Too bad. This difference in boards makes the tests a bit less
>>> meaningful. Is there really no USB-ethernet adapter somewhere in your
>>> department (perhaps a non-SMSC95xx might serve as well?)? I might
>>> send/order you one if necessary. ;)
>>
>> Thanks for the offer :). I'll just get one for myself by today/tomorrow.
>> The one available here uses this driver "drivers/net/usb/asix.c"
> 
> Great.
> 

OK. Finally managed to reproduce the problem.

Don't know the root cause yet. Will need to investigate.

[   92.054138] ------------[ cut here ]------------
[   92.059082] WARNING: at net/sched/sch_generic.c:255 dev_watchdog+0x278/0x29c()
[   92.066741] NETDEV WATCHDOG: eth0 (asix): transmit queue 0 timed out
[   92.073425] Modules linked in:
[   92.076721] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.10.0-06007-g83bebb4 #837
[   92.084594] [<c001b868>] (unwind_backtrace+0x0/0xf0) from [<c0017bbc>] (show_stack+0x10/0x14)
[   92.093597] [<c0017bbc>] (show_stack+0x10/0x14) from [<c04f7658>] (dump_stack+0x78/0x94)
[   92.102172] [<c04f7658>] (dump_stack+0x78/0x94) from [<c00440b8>] (warn_slowpath_common+0x4c/0x6c)
[   92.111694] [<c00440b8>] (warn_slowpath_common+0x4c/0x6c) from [<c004416c>] (warn_slowpath_fmt+0x30/0x40)
[   92.121826] [<c004416c>] (warn_slowpath_fmt+0x30/0x40) from [<c045aa28>] (dev_watchdog+0x278/0x29c)
[   92.131439] [<c045aa28>] (dev_watchdog+0x278/0x29c) from [<c0052d0c>] (call_timer_fn+0x80/0x168)
[   92.140747] [<c0052d0c>] (call_timer_fn+0x80/0x168) from [<c0052f98>] (run_timer_softirq+0x1a4/0x290)
[   92.150512] [<c0052f98>] (run_timer_softirq+0x1a4/0x290) from [<c004bddc>] (__do_softirq+0x100/0x27c)
[   92.160308] [<c004bddc>] (__do_softirq+0x100/0x27c) from [<c004c2fc>] (irq_exit+0xa0/0xdc)
[   92.169067] [<c004c2fc>] (irq_exit+0xa0/0xdc) from [<c0014ccc>] (handle_IRQ+0x50/0xb0)
[   92.177490] [<c0014ccc>] (handle_IRQ+0x50/0xb0) from [<c000862c>] (omap3_intc_handle_irq+0x60/0x74)
[   92.187072] [<c000862c>] (omap3_intc_handle_irq+0x60/0x74) from [<c04fd5a4>] (__irq_svc+0x44/0x5c)
[   92.196563] Exception stack(0xc0775f58 to 0xc0775fa0)
[   92.201873] 5f40:                                                       00000001 00000001
[   92.210540] 5f60: 00000000 c077fd08 c0774000 00000000 c080acc0 c080a5ee c080acc0 c0509860
[   92.219207] 5f80: c077c9a8 c0774000 ce0ce578 c0775fa0 c0097b18 c0015034 200f0013 ffffffff
[   92.227874] [<c04fd5a4>] (__irq_svc+0x44/0x5c) from [<c0015034>] (arch_cpu_idle+0x20/0x3c)
[   92.236663] [<c0015034>] (arch_cpu_idle+0x20/0x3c) from [<c0086268>] (cpu_startup_entry+0x80/0x21c)
[   92.246276] [<c0086268>] (cpu_startup_entry+0x80/0x21c) from [<c0714820>] (start_kernel+0x2c4/0x320)
[   92.255950] ---[ end trace 29c2af54cf6c8fa8 ]---
[   92.272674] ehci-omap 48064800.ehci: IAA watchdog: status e008 cmd 10075
[   92.291137] ehci-omap 48064800.ehci: IAA watchdog: status e008 cmd 10075

cheers,
-roger
