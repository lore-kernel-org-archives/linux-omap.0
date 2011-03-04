From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v11 6/8] dmtimer: switch-over to platform device driver
Date: Fri, 4 Mar 2011 09:23:21 -0800
Message-ID: <20110304172320.GY20560@atomide.com>
References: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
 <1298546811-27055-7-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:32682 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759907Ab1CDRXe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 12:23:34 -0500
Content-Disposition: inline
In-Reply-To: <1298546811-27055-7-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110224 03:23]:
> --- a/arch/arm/mach-omap2/dmtimer.c
> +++ b/arch/arm/mach-omap2/dmtimer.c
> @@ -197,3 +197,64 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
>  
>  	return ret;
>  }
> +
> +/**
> + * omap2_dm_timer_early_init - top level early timer initialization
> + * called in the last part of omap2_init_common_hw
> + *
> + * Uses dedicated hwmod api to parse through hwmod database for
> + * given class name and then build and register the timer device.
> + * At the end driver is registered and early probe initiated.
> + */
> +void __init omap2_dm_timer_early_init(void)
> +{
> +	int ret = omap_hwmod_for_each_by_class("timer",
> +			omap_timer_init, NULL);

Here we really only want to initialize the system timer. The rest we
want to do later, so let's not init all of them early.

Regards,

Tony
