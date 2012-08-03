From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/3] ARM: OMAP: timer: allow gp timer clock-event to be
 used on both cpus
Date: Fri, 03 Aug 2012 09:16:54 +0200
Message-ID: <501B7AE6.8080405@gmail.com>
References: <1333114048-26136-1-git-send-email-santosh.shilimkar@ti.com> <1333114048-26136-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54371 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab2HCHQ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Aug 2012 03:16:59 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so113029bkw.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Aug 2012 00:16:58 -0700 (PDT)
In-Reply-To: <1333114048-26136-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, ccross@android.com, Paul Walmsley <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

On 30.03.2012 15:27, Santosh Shilimkar wrote:
> For coupled cpuidle to work when both cpus are active, it needs a global timer
> that can handle events for both cpus.  This timer is used as the broadcast
> clock-event when the per-cpu timer hardware stop in low power states.
> Set the cpumask of clockevent_gpt to all cpus, set the rating correctly, and
> set the irq to allow the clockevent core to determine the affinity of the
> timer.

These patches made it to mainline now, shortly befor 3.6-rc1, and it
breaks boot on my AM33xx board.

Once I revert 1/3, the board boots again but crashes with the Ooops
below. With the entire series reverted, everything works again as
expected. Any idea?

The upstream commit ids are

11d6ec2e "ARM: OMAP: timer: allow gp timer clock-event to be used on
both cpus"
5b4d5bcc "ARM: OMAP4: CPUidle: add synchronization for coupled idle states"
b93d70ae "ARM: OMAP4: CPUidle: Open broadcast clock-event device."

> [    2.483556] net eth0: phy found : id is : 0x4dd072
> [    2.489176] Unable to handle kernel NULL pointer dereference at virtual address 00000004
> [    2.497666] pgd = c0004000
> [    2.500507] [00000004] *pgd=00000000
> [    2.504282] Internal error: Oops: 805 [#1] SMP ARM
> [    2.509309] Modules linked in:
> [    2.512530] CPU: 0    Not tainted  (3.6.0-rc1-00036-g6c4c4ee-dirty #152)
> [    2.519579] PC is at cache_alloc_refill+0x1b0/0x620
> [    2.524695] LR is at 0xc0
> [    2.527449] pc : [<c00fc0f0>]    lr : [<000000c0>]    psr: 60000093
> [    2.527449] sp : cf83dd70  ip : 00000014  fp : 00200200
> [    2.539478] r10: 00000028  r9 : c0df68c0  r8 : 00000028
> [    2.544957] r7 : cf928000  r6 : cf87f3c0  r5 : cf88d000  r4 : cf810740
> [    2.551800] r3 : 00100100  r2 : cf87f3c8  r1 : 00000000  r0 : 00000000
> [    2.558647] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> [    2.566400] Control: 10c5387d  Table: 80004019  DAC: 00000017
> [    2.572425] Process swapper/0 (pid: 1, stack limit = 0xcf83c2f8)
> [    2.578723] Stack: (0xcf83dd70 to 0xcf83e000)
> [    2.583297] dd60:                                     00000000 00000000 cf83b3c0 cf87f3d0
> [    2.591875] dd80: cf87f3e4 00000020 00000000 00000000 00000077 cf810740 cfb2a000 00000020
> [    2.600453] dda0: 00000020 60000013 00000001 c03fdd40 cfb8d800 c00fd0f4 00000001 00000020
> [    2.609031] ddc0: cfb8d800 cfb8d800 cfb2a000 cfb2a000 00000700 00000700 cfb46500 c03fdd40
> [    2.617609] dde0: 00000000 cfb8d800 00000700 cfb2a000 cfb46500 00000001 cfb46500 c0400588
> [    2.626187] de00: cfb8de00 00000010 000000d0 c0316ae4 000000d0 c0964698 cfb8dea8 cfb8df28
> [    2.634766] de20: 76616c73 00302d65 00000000 cfb8d800 0000000d 0000016b 00001202 c04ce7c4
> [    2.643343] de40: cfb8d800 cfb8d800 c0502030 00000000 cfb8d82c c089aa80 0000016b 00001202
> [    2.651922] de60: c07ec0c0 c040bb6c c040bad0 cfb8d800 00001203 00001202 00000001 c040bd98
> [    2.660500] de80: 00000000 cfb8d800 00001202 00000003 c07e4154 c040bee4 cfb8d800 c07e416c
> [    2.669076] dea0: 00000003 c07cc3cc 00000001 00000000 00000002 00000000 00000000 00000000
> [    2.677653] dec0: 00000000 00000000 cf83c000 00000000 00000002 00000000 00000000 00000000
> [    2.686230] dee0: 00000000 00000000 c089d23c cf83c000 00000000 00000000 00000002 00000000
> [    2.694807] df00: 00000000 c008c454 00000002 00000000 00000000 c04526a8 00000000 c02aa9ac
> [    2.703385] df20: 60000013 c0851010 cf806440 c089d22c 00000002 cf83c000 00000000 0000009e
> [    2.711963] df40: c07e5dd0 c07ca394 c089d22c c08a35c0 cf83c000 c07d0ee8 c08a35c0 cf83c000
> [    2.720541] df60: 00000000 0000009e c07e5dd8 c07cc230 00000000 c00088ec 80000013 ffffffff
> [    2.729119] df80: c0776b54 c07cc230 0000009e c005c48c c06c904c c0776174 00000007 00000007
> [    2.737697] dfa0: 60000013 c07d0ee8 00000007 c07d0ec8 c08a35c0 0000009e c07e5dd8 c07a21c4
> [    2.746274] dfc0: 00000000 c07a28fc 00000007 00000007 c07a21c4 00000000 00000000 c07a2800
> [    2.754852] dfe0: c00149c0 00000013 00000000 00000000 00000000 c00149c0 55755555 75715555
> [    2.763444] [<c00fc0f0>] (cache_alloc_refill+0x1b0/0x620) from [<c00fd0f4>] (kmem_cache_alloc+0xfc/0x184)
> [    2.773496] [<c00fd0f4>] (kmem_cache_alloc+0xfc/0x184) from [<c03fdd40>] (build_skb+0x24/0xa0)
> [    2.782540] [<c03fdd40>] (build_skb+0x24/0xa0) from [<c0400588>] (__netdev_alloc_skb+0x94/0xdc)
> [    2.791681] [<c0400588>] (__netdev_alloc_skb+0x94/0xdc) from [<c0316ae4>] (cpsw_ndo_open+0x364/0x490)
> [    2.801366] [<c0316ae4>] (cpsw_ndo_open+0x364/0x490) from [<c040bb6c>] (__dev_open+0x9c/0xf8)
> [    2.810314] [<c040bb6c>] (__dev_open+0x9c/0xf8) from [<c040bd98>] (__dev_change_flags+0x78/0x13c)
> [    2.819628] [<c040bd98>] (__dev_change_flags+0x78/0x13c) from [<c040bee4>] (dev_change_flags+0x10/0x48)
> [    2.829493] [<c040bee4>] (dev_change_flags+0x10/0x48) from [<c07cc3cc>] (ip_auto_config+0x19c/0xfec)
> [    2.839079] [<c07cc3cc>] (ip_auto_config+0x19c/0xfec) from [<c00088ec>] (do_one_initcall+0x34/0x184)
> [    2.848679] [<c00088ec>] (do_one_initcall+0x34/0x184) from [<c07a28fc>] (kernel_init+0xfc/0x1c8)
> [    2.857914] [<c07a28fc>] (kernel_init+0xfc/0x1c8) from [<c00149c0>] (kernel_thread_exit+0x0/0x8)
> [    2.867131] Code: e1500001 3affffe9 e8970003 e1a0a008 (e5801004) 
> [    2.873538] ---[ end trace 1020ef2bbda0ff23 ]---

