From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH] OMAP4: DMTIMER: enable autoidle mode
Date: Thu, 16 Jun 2011 10:09:24 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037B9AC19E@dbde02.ent.ti.com>
References: <1308172355-1694-1-git-send-email-ambresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308172355-1694-1-git-send-email-ambresh@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "K, Ambresh" <ambresh@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of K, Ambresh
> Sent: Thursday, June 16, 2011 2:43 AM
> To: Tony Lindgren
> Cc: linux-omap; linux-kernel
> Subject: [PATCH] OMAP4: DMTIMER: enable autoidle mode
> 
> From: Ambresh K <ambresh@ti.com>
> 
> Currently autoidle is only enabled for OMAP2/3; by enabling autoidle,
> the automatic L4 clock gating strategy is applied based on L4 activity,
> otherwise L4 clock to module will be a free running.
> 
> Signed-off-by: Ambresh K <ambresh@ti.com>
> ---
>  arch/arm/plat-omap/dmtimer.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index ee9f6eb..02d0f7a 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -342,8 +342,8 @@ static void omap_dm_timer_reset(struct omap_dm_timer
> *timer)
>  	l |= 0x02 << 3;  /* Set to smart-idle mode */
>  	l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on idle */
> 
> -	/* Enable autoidle on OMAP2 / OMAP3 */
> -	if (cpu_is_omap24xx() || cpu_is_omap34xx())
> +	/* Enable autoidle on OMAP2 CPUs. */
> +	if (cpu_class_is_omap2())
>  		l |= 0x1 << 0;
BTW, in the hwmod adaptation series this is taken care by the framework.
--
Tarun
> 
>  	/*
> --
> 1.6.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
