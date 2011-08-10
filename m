From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] omap: timer: Set dmtimer used as clocksource in
 autoreload mode
Date: Wed, 10 Aug 2011 07:37:32 -0700
Message-ID: <20110810143732.GN1939@atomide.com>
References: <1312982375-11848-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1312982375-11848-1-git-send-email-hemantp@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Hemant Pedanekar <hemantp@ti.com> [110810 06:14]:
> If CONFIG_OMAP_32K_TIMER is not selected and dmtimer is used as clocksource, the
> timer stops counting once overflow occurs as it was not set in autoreload mode.
> This results into timekeeping failure: for example, 'sleep 1' at the shell after
> the timer counter overflow would hang.
> 
> This patch sets up autoreload when starting the clocksource timer which fixes
> the above issue.

Thanks for updating this, will apply into fixes.

Tony


> 
> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
> ---
>  arch/arm/mach-omap2/timer.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index e964072..cf1de7d 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -293,7 +293,8 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
>  	pr_info("OMAP clocksource: GPTIMER%d at %lu Hz\n",
>  		gptimer_id, clksrc.rate);
>  
> -	__omap_dm_timer_load_start(clksrc.io_base, OMAP_TIMER_CTRL_ST, 0, 1);
> +	__omap_dm_timer_load_start(clksrc.io_base,
> +			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
>  	init_sched_clock(&cd, dmtimer_update_sched_clock, 32, clksrc.rate);
>  
>  	if (clocksource_register_hz(&clocksource_gpt, clksrc.rate))
> -- 
> 1.7.3.5
> 
