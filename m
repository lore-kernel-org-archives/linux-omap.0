From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix dmtimer set source clock failure
Date: Tue, 7 Aug 2012 00:34:27 -0700
Message-ID: <20120807073427.GO11011@atomide.com>
References: <1342210323-2129-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:16596 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789Ab2HGHe3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 03:34:29 -0400
Content-Disposition: inline
In-Reply-To: <1342210323-2129-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>, Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi,

* Jon Hunter <jon-hunter@ti.com> [120713 13:17]:
> Calling the dmtimer function omap_dm_timer_set_source() fails if following a
> call to pm_runtime_put() to disable the timer. For example the following
> sequence would fail to set the parent clock ...
> 
> 	omap_dm_timer_stop(gptimer);
> 	omap_dm_timer_set_source(gptimer, OMAP_TIMER_SRC_32_KHZ);
> 
> The following error message would be seen ...
> 
> omap_dm_timer_set_source: failed to set timer_32k_ck as parent
> 
> The problem is that, by design, pm_runtime_put() simply decrements the usage
> count and returns before the timer has actually been disabled. Therefore,
> setting the parent clock failed because the timer was still active when the
> trying to set the parent clock. Setting a parent clock will fail if the clock
> you are setting the parent of has a non-zero usage count. To ensure that this
> does not fail use pm_runtime_put_sync() when disabling the timer.
> 
> Note that this will not be seen on OMAP1 devices, because these devices do
> not use the clock framework for dmtimers.

Kevin care to ack this one? This should also be Cc: stable it seems?

Regards,

Tony
 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/plat-omap/dmtimer.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 626ad8c..7b6689a 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -258,7 +258,7 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
>  
>  void omap_dm_timer_disable(struct omap_dm_timer *timer)
>  {
> -	pm_runtime_put(&timer->pdev->dev);
> +	pm_runtime_put_sync(&timer->pdev->dev);
>  }
>  EXPORT_SYMBOL_GPL(omap_dm_timer_disable);
>  
> -- 
> 1.7.9.5
> 
