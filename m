From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 14/19] omap3+: sr: introduce notifiers flags
Date: Wed, 02 Mar 2011 16:17:55 -0800
Message-ID: <87vd01ukek.fsf@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>
	<1298116918-30744-15-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:39169 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752897Ab1CCAR7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 19:17:59 -0500
Received: by gxk7 with SMTP id 7so211374gxk.13
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 16:17:58 -0800 (PST)
In-Reply-To: <1298116918-30744-15-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sat, 19 Feb 2011 17:31:53 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Nishanth Menon <nm@ti.com> writes:

> SmartReflex IP v1 and v2 have different registers and offsets.
> Currently, we pass the status as is to the class driver. However,
> since we dont pass the version of the underlying SR hardware
> to the Class driver, it will not be unable to make consistent
> sense of the status bits coming over to it.
>
> A class driver should be able to function without dependency
> on the exact IP version it is actually running on. We hence
> introduce our own translation in s/w level for a generic
> notification flag.
>
> As part of this change, we will now call the notifier iff we get
> a match with the notifier flags that the class driver requested.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Looks fine, minor comment below...

[...]

> diff --git a/arch/arm/plat-omap/include/plat/smartreflex.h b/arch/arm/plat-omap/include/plat/smartreflex.h
> index 8b6ecd9..ff07d1e 100644
> --- a/arch/arm/plat-omap/include/plat/smartreflex.h
> +++ b/arch/arm/plat-omap/include/plat/smartreflex.h
> @@ -141,6 +141,12 @@
>  #define OMAP3430_SR_ERRWEIGHT		0x04
>  #define OMAP3430_SR_ERRMAXLIMIT		0x02
>  
> +/* Smart reflex notifiers for class drivers to use */
> +#define SR_NOTIFY_MCUACCUM     (0x1 << 0)
> +#define SR_NOTIFY_MCUVALID     (0x1 << 1)
> +#define SR_NOTIFY_MCUBOUND     (0x1 << 2)
> +#define SR_NOTIFY_MCUDISACK    (0x1 << 3)
> +

Please use BIT(x)

Kevin
