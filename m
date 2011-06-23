From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 08/10] omap2+: Use dmtimer macros for clocksource
Date: Thu, 23 Jun 2011 08:28:02 -0700
Message-ID: <87iprwbm9p.fsf@ti.com>
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092345.357.11154.stgit@kaulin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:46619 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759391Ab1FWP2G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 11:28:06 -0400
Received: by pzk27 with SMTP id 27so1550497pzk.41
        for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 08:28:05 -0700 (PDT)
In-Reply-To: <20110620092345.357.11154.stgit@kaulin> (Tony Lindgren's message
	of "Mon, 20 Jun 2011 02:23:45 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> Use dmtimer macros for clocksource. As with the clockevent,
> this allows us to initialize the rest of dmtimer code later on.
>
> Note that eventually we will be initializing the timesource
> from init_early so sched_clock will work properly for
> CONFIG_PRINTK_TIME.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>

[...]

> +/* Setup free-running counter for clocksource */
> +static void __init omap2_gp_clocksource_init(int gptimer_id,
> +						const char *fck_source)
> +{
> +	int res;
> +
> +	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source);
> +	BUG_ON(res);

This is a change from previous code where the clocksource was requesting
any timer, not a specific one.   

Also, you're using the same gptimer_id here as the clockevent, which
means this is guaranteed to fail.

Kevin
