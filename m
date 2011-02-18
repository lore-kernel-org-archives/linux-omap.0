From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v10 00/11] dmtimer adaptation to platform_driver
Date: Fri, 18 Feb 2011 11:16:29 +0530
Message-ID: <106a7a107bdd8b83317510d139620757@mail.gmail.com>
References: <1297861220-831-1-git-send-email-tarun.kanti@ti.com> <20110218005706.GR20795@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:56315 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750841Ab1BRFqc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 00:46:32 -0500
Received: by qwd7 with SMTP id 7so98768qwd.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 21:46:30 -0800 (PST)
In-Reply-To: <20110218005706.GR20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Friday, February 18, 2011 6:27 AM
> To: Tarun Kanti DebBarma
> Cc: linux-omap@vger.kernel.org; khilman@ti.com
> Subject: Re: [PATCH v10 00/11] dmtimer adaptation to platform_driver
>
> Hi,
>
> * Tarun Kanti DebBarma <tarun.kanti@ti.com> [110216 04:56]:
> > dmtimer adaptation to platform_driver.
> >
> > This patch series is adaptation of dmtimer code to platform driver
> > using omap_device and omap_hwmod abstraction.
>
> Looks like this needs rebasing on top of current omap-for-linus
> because of the omap4 hwmod data being merged.
>
> Also note that you may need to change things with the clock
> init with init_early changes.
>
> That's something we need to consider carefully as we don't
> necessarily want to have the system timer depend on hwmod
> and clock framework. But that can be fixed later on after
> your patch series.
>
This is interesting. Major work of the timer series was around
making this early timer work with hwmod. We had such a
discussion earlier, to leave OS tick timer from hwmod because
of various implications.

Regards,
Santosh
