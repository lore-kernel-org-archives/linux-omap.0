From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP CRAP: The Continuing Story Of Brokenness
Date: Mon, 7 Nov 2011 09:26:00 -0800
Message-ID: <20111107172600.GS31337@atomide.com>
References: <20111106121829.GB15294@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:24335 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754814Ab1KGR0G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 12:26:06 -0500
Content-Disposition: inline
In-Reply-To: <20111106121829.GB15294@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Per Forlin <per.forlin@linaro.org>, Chris Ball <cjb@laptop.org>, Felipe Balbi <balbi@ti.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [111106 03:44]:
> Yet again I find that I'm having to email about crap on OMAP3.
> 
> I'm getting really fed up with OMAP stuff which keeps breaking in
> idiotic ways - and the way there's fatal build errors at EVERY merge
> window.  The OMAP workflow is totally broken.  Something MUST change
> in the way the OMAP community works to stop the continual breakage
> at every single bloody merge window.

Hmm he following fixes are queued elsewhere and now merged:

omap_hsmmc: fix missing parenthesis in pr_info
PM / OPP: Fix build when CONFIG_PM_OPP is not set 
net: Add back alignment for size for __alloc_skb

Or have you seen some other build errors?

FYI, now all the compile warnings are finally gone with what
I have in fixes branch.
 
> One is new:
> 
> WARNING: at arch/arm/mach-omap2/usb-musb.c:141 usb_musb_init+0xc0/0x174()
> usb_musb_init: could not find omap_hwmod for usb_otg_hs
> Modules linked in:
> Backtrace:
> [<c0017920>] (dump_backtrace+0x0/0x10c) from [<c02d9368>] (dump_stack+0x18/0x1c) r7:c181ff20 r6:c03ceb54 r5:c037545b r4:0000008d
> [<c02d9350>] (dump_stack+0x0/0x1c) from [<c003adfc>] (warn_slowpath_common+0x58/0x70)
> [<c003ada4>] (warn_slowpath_common+0x0/0x70) from [<c003aeb8>] (warn_slowpath_fmt+0x38/0x40)
>  r8:00000000 r7:00000013 r6:c0374b05 r5:c03f06e4 r4:c0374190
> [<c003ae80>] (warn_slowpath_fmt+0x0/0x40) from [<c03ceb54>] (usb_musb_init+0xc0/0x174)
>  r3:c02df894 r2:c03707d9
> [<c03cea94>] (usb_musb_init+0x0/0x174) from [<c03ce02c>] (omap_ldp_init+0xb0/0x100)
>  r6:c003e7d8 r5:c03f06e4 r4:c04053e4
> [<c03cdf7c>] (omap_ldp_init+0x0/0x100) from [<c03c6788>] (customize_machine+0x24/0x30)
>  r4:c03f03a8
> [<c03c6764>] (customize_machine+0x0/0x30) from [<c0008710>] (do_one_initcall+0x9c/0x164)
> [<c0008674>] (do_one_initcall+0x0/0x164) from [<c03c3284>] (kernel_init+0x7c/0x120)
> [<c03c3208>] (kernel_init+0x0/0x120) from [<c003e7d8>] (do_exit+0x0/0x62c)
>  r5:c03c3208 r4:00000000

Felipe, care to check what the status of the musb hwmod issue
above is?


> ---[ end trace 1b75b31a2719ed1c ]---
>  omap_timer.1: alias fck already exists
>  omap_timer.2: alias fck already exists
>  omap_timer.3: alias fck already exists
>  omap_timer.4: alias fck already exists
>  omap_timer.5: alias fck already exists
>  omap_timer.6: alias fck already exists
>  omap_timer.7: alias fck already exists
>  omap_timer.8: alias fck already exists
>  omap_timer.9: alias fck already exists
>  omap_timer.10: alias fck already exists
>  omap_timer.11: alias fck already exists
>  omap_timer.12: alias fck already exists
>  omap-mcbsp.2: alias fck already exists
>  omap-mcbsp.3: alias fck already exists

The fix for this is queued as:

ARM: OMAP2+: clock data: Remove redundant timer clkdev

Regards,

Tony
