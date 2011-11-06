From: =?ISO-8859-1?Q?Per_F=F6rlin?= <per.forlin@stericsson.com>
Subject: Re: OMAP CRAP: The Continuing Story Of Brokenness
Date: Sun, 6 Nov 2011 16:29:54 +0100
Message-ID: <4EB6A7F2.1010606@stericsson.com>
References: <20111106121829.GB15294@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:54289 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752621Ab1KFPai (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Nov 2011 10:30:38 -0500
In-Reply-To: <20111106121829.GB15294@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Per Forlin <per.forlin@linaro.org>, Chris Ball <cjb@laptop.org>

On 11/06/2011 01:18 PM, Russell King - ARM Linux wrote:
> Yet again I find that I'm having to email about crap on OMAP3.
> 
> I'm getting really fed up with OMAP stuff which keeps breaking in
> idiotic ways - and the way there's fatal build errors at EVERY merge
> window.  The OMAP workflow is totally broken.  Something MUST change
> in the way the OMAP community works to stop the continual breakage
> at every single bloody merge window.
> 
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
> 
> And this, which I reported on August 26th - so it's now over three months
> old is still there.  Clearly, no one cares about this driver so shall I
> delete the omap-hsmmc driver, or is someone going to clean up their crap?
> Or shall we revert all those patches for adding the asynchronous mapping
> of MMC requests until the _REGRESSION_ is fixed properly?
It's possible to disable async mapping in omap_hsmmc.c. Set pre_req and post_req to NULL.

Regards,
Per
