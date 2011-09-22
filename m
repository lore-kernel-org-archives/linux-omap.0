From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v16 07/12] OMAP: dmtimer: add timeout to low-level
 routines
Date: Wed, 21 Sep 2011 18:00:46 -0700
Message-ID: <20110922010046.GS2937@atomide.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
 <1316518227-28116-8-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:16747 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750874Ab1IVBAr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 21:00:47 -0400
Content-Disposition: inline
In-Reply-To: <1316518227-28116-8-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110920 03:57]:
> @@ -254,9 +259,15 @@ int omap_dm_timer_prepare(struct omap_dm_timer *timer);
>  static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
>  						int posted)
>  {
> -	if (posted)
> -		while (__raw_readl(timer->pend) & (reg >> WPSHIFT))
> -			cpu_relax();
> +	int i = 0;
> +
> +	if (posted) {
> +		omap_test_timeout(!(__raw_readl(timer->pend) & (reg >> WPSHIFT))
> +						, MAX_WRITE_PEND_WAIT, i);
> +
> +		if (WARN_ON_ONCE(i == MAX_WRITE_PEND_WAIT))
> +			pr_err("Read timeout!\n");
> +	}
>  
>  	return __raw_readl(timer->func_base + (reg & 0xff));
>  }
> @@ -264,9 +275,15 @@ static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
>  static inline void __omap_dm_timer_write(struct omap_dm_timer *timer,
>  					u32 reg, u32 val, int posted)
>  {
> -	if (posted)
> -		while (__raw_readl(timer->pend) & (reg >> WPSHIFT))
> -			cpu_relax();
> +	int i = 0;
> +
> +	if (posted) {
> +		omap_test_timeout(!(__raw_readl(timer->pend) & (reg >> WPSHIFT))
> +						, MAX_WRITE_PEND_WAIT, i);
> +
> +		if (WARN_ON_ONCE(i == MAX_WRITE_PEND_WAIT))
> +			pr_err("Write timeout!\n");
> +	}
>  
>  	__raw_writel(val, timer->func_base + (reg & 0xff));
>  }

Let's leave out these changes for now, they make the
omap2_gp_timer_set_next_event used for system timer interrupts
huge if you take a look at it with objdump.

Later on we might want to split the posted bit check into a separate
inline function, and then you can implement this for the device
driver where things are more likely to go wrong with more complicated
use scenarios.

Regards,

Tony

