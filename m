From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH V2] ARM: OMAP: counter: add locking to read_persistent_clock
Date: Mon, 24 Sep 2012 17:43:21 -0700
Message-ID: <87d31bj5jq.fsf@deeprootsystems.com>
References: <1347434081-11469-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61307 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab2IYAnZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Sep 2012 20:43:25 -0400
Received: by obbuo13 with SMTP id uo13so5320180obb.19
        for <linux-omap@vger.kernel.org>; Mon, 24 Sep 2012 17:43:25 -0700 (PDT)
In-Reply-To: <1347434081-11469-1-git-send-email-r.sricharan@ti.com>
	(R. Sricharan's message of "Wed, 12 Sep 2012 12:44:41 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: R Sricharan <r.sricharan@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, Colin Cross <ccross@android.com>

R Sricharan <r.sricharan@ti.com> writes:

> From: Colin Cross <ccross@android.com>
>
> read_persistent_clock uses a global variable, use a spinlock to
> ensure non-atomic updates to the variable don't overlap and cause
> time to move backwards.
>
> Signed-off-by: Colin Cross <ccross@android.com>
> Signed-off-by: R Sricharan <r.sricharan@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>

Tony, this should probably be queued up for v3.7-rc and flagged for stable.

Thanks,

Kevin

> ---
>  [V2] Added signed-off-by and looped in "linux-arm-kernel" list
>
>  arch/arm/plat-omap/counter_32k.c |   21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
> index dbf1e03..2bc51fb 100644
> --- a/arch/arm/plat-omap/counter_32k.c
> +++ b/arch/arm/plat-omap/counter_32k.c
> @@ -55,22 +55,29 @@ static u32 notrace omap_32k_read_sched_clock(void)
>   * nsecs and adds to a monotonically increasing timespec.
>   */
>  static struct timespec persistent_ts;
> -static cycles_t cycles, last_cycles;
> +static cycles_t cycles;
>  static unsigned int persistent_mult, persistent_shift;
> +static DEFINE_SPINLOCK(read_persistent_clock_lock);
> +
>  static void omap_read_persistent_clock(struct timespec *ts)
>  {
>  	unsigned long long nsecs;
> -	cycles_t delta;
> -	struct timespec *tsp = &persistent_ts;
> +	cycles_t last_cycles;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&read_persistent_clock_lock, flags);
>  
>  	last_cycles = cycles;
>  	cycles = sync32k_cnt_reg ? __raw_readl(sync32k_cnt_reg) : 0;
> -	delta = cycles - last_cycles;
>  
> -	nsecs = clocksource_cyc2ns(delta, persistent_mult, persistent_shift);
> +	nsecs = clocksource_cyc2ns(cycles - last_cycles,
> +					persistent_mult, persistent_shift);
> +
> +	timespec_add_ns(&persistent_ts, nsecs);
> +
> +	*ts = persistent_ts;
>  
> -	timespec_add_ns(tsp, nsecs);
> -	*ts = *tsp;
> +	spin_unlock_irqrestore(&read_persistent_clock_lock, flags);
>  }
>  
>  /**
