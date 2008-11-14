From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 1/2] HSMMC: Make loopback clock configurable
Date: Thu, 13 Nov 2008 22:41:38 -0800
Message-ID: <5e088bd90811132241i3a8ccdc3ua30d941e0315dc6f@mail.gmail.com>
References: <1226612405-7175-1-git-send-email-notasas@gmail.com>
	 <20081113230656.GT3106@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:21488 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbYKNGlk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2008 01:41:40 -0500
Received: by mu-out-0910.google.com with SMTP id g7so1249555muf.1
        for <linux-omap@vger.kernel.org>; Thu, 13 Nov 2008 22:41:38 -0800 (PST)
In-Reply-To: <20081113230656.GT3106@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Nov 13, 2008 at 3:06 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Grazvydas Ignotas <notasas@gmail.com> [081113 13:40]:
>> Some boards use input clock from external pin for MMC/SDIO
>> modules in OMAP chips. Make that option selectable instead of
>> forcing loop back clock on everyone.
>
> Thanks, pushing both today.

Hmm . . . not sure if it is related to this patch, but I now get an
oops on Overo.

Has anyone else seen this?

I'll do some debugging after I get some sleep.

Steve

Unable to handle kernel NULL pointer dereference at virtual address 00000029
pgd = c0004000
[00000029] *pgd=00000000
Internal error: Oops: 5 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.28-rc4-omap1 #1)
PC is at twl_mmc2_set_power+0x20/0x68
LR is at omap_mmc_set_ios+0x78/0x25c
pc : [<c00fb62c>]    lr : [<c02ec7d0>]    psr: 20000013
sp : cf93bf10  ip : cf93bf30  fp : cf93bf2c
r10: 00000000  r9 : 00000000  r8 : 00000000
r7 : cfbb4968  r6 : 00000013  r5 : c04ea960  r4 : cfbb4800
r3 : 00000000  r2 : 00000001  r1 : 00000001  r0 : cf901008
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387f  Table: 80004018  DAC: 00000017
Process kmmcd (pid: 209, stack limit = 0xcf93a2e8)
Stack: (0xcf93bf10 to 0xcf93c000)
bf00:                                     cfbb4800 cfbb4800 cfbb4a00 cfbb4968
bf20: cf93bf4c cf93bf30 c02ec7d0 c00fb618 cfbb4968 cfbb4800 c02e21d0 cf831ea0
bf40: cf93bf64 cf93bf50 c02e1924 c02ec764 cfbb4800 60000013 cf93bf84 cf93bf68
bf60: c02e2270 c02e18c4 c03ecd08 c010a4f8 cf831ea0 cf93a000 cf93bfa4 cf93bf88
bf80: c011e098 c02e21dc cf93bfb8 cf8ec5a0 cf93a000 cf831ea0 cf93bfdc cf93bfa8
bfa0: c011ec34 c011e000 c01219a8 00000000 cf8ec5a0 c0121e90 cf93bfb8 cf93bfb8
bfc0: cf831ea0 c011eb44 00000000 00000000 cf93bff4 cf93bfe0 c01219c0 c011eb50
bfe0: 00000000 00000000 00000000 cf93bff8 c0111360 c0121978 948ee7d5 0e80e45a
Backtrace:
[<c00fb60c>] (twl_mmc2_set_power+0x0/0x68) from [<c02ec7d0>]
(omap_mmc_set_ios+0x78/0x25c)
 r7:cfbb4968 r6:cfbb4a00 r5:cfbb4800 r4:cfbb4800
[<c02ec758>] (omap_mmc_set_ios+0x0/0x25c) from [<c02e1924>]
(mmc_power_up+0x6c/0xb0)
 r7:cf831ea0 r6:c02e21d0 r5:cfbb4800 r4:cfbb4968
[<c02e18b8>] (mmc_power_up+0x0/0xb0) from [<c02e2270>] (mmc_rescan+0xa0/0x1c0)
 r5:60000013 r4:cfbb4800
[<c02e21d0>] (mmc_rescan+0x0/0x1c0) from [<c011e098>] (run_workqueue+0xa4/0x120)
 r5:cf93a000 r4:cf831ea0
[<c011dff4>] (run_workqueue+0x0/0x120) from [<c011ec34>]
(worker_thread+0xf0/0x104)
 r7:cf831ea0 r6:cf93a000 r5:cf8ec5a0 r4:cf93bfb8
[<c011eb44>] (worker_thread+0x0/0x104) from [<c01219c0>] (kthread+0x54/0x80)
 r7:00000000 r6:00000000 r5:c011eb44 r4:cf831ea0
[<c012196c>] (kthread+0x0/0x80) from [<c0111360>] (do_exit+0x0/0x6c8)
 r5:00000000 r4:00000000
Code: e1a06003 e59f5044 0a00000d e5953010 (e5d33029)
---[ end trace 62381099a6bde9b1 ]---
