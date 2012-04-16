From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: dmtimer: cleanup fclk usage
Date: Mon, 16 Apr 2012 10:40:12 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204161034290.29048@utopia.booyaka.com>
References: <1334579125-15566-1-git-send-email-tarun.kanti@ti.com> <1334579125-15566-4-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51743 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201Ab2DPQkN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Apr 2012 12:40:13 -0400
In-Reply-To: <1334579125-15566-4-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, rnayak@ti.com

Hi

a few comments

On Mon, 16 Apr 2012, Tarun Kanti DebBarma wrote:

> Timer clock nodes have been re-named as "timer1_fck", "timer2_fck", ...
> in place of "gpt1_fck", "gpt2_fck", ... This is in line with the names
> present in OMAP4 gptimer hwmod database assigned to oh->main_clk.
> Now we can get the fck name directly from oh->main_clk and pass the
> same to clk_get() to extract the fclk and thus avoid construction
> of fclk clock name.
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
>  arch/arm/mach-omap2/clock2420_data.c       |   72 ++++++++++++++--------------
>  arch/arm/mach-omap2/clock2430_data.c       |   72 ++++++++++++++--------------
>  arch/arm/mach-omap2/clock3xxx_data.c       |   72 ++++++++++++++--------------
>  arch/arm/mach-omap2/clock44xx_data.c       |   22 ++++----
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |   24 +++++-----
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |   24 +++++-----
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   24 +++++-----
>  arch/arm/mach-omap2/timer.c                |    3 +-
>  8 files changed, 156 insertions(+), 157 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
> index bace930..8d12e8e 100644
> --- a/arch/arm/mach-omap2/clock2420_data.c
> +++ b/arch/arm/mach-omap2/clock2420_data.c
> @@ -847,8 +847,8 @@ static struct clk gpt1_ick = {
>  	.recalc		= &followparent_recalc,
>  };
>  
> -static struct clk gpt1_fck = {
> -	.name		= "gpt1_fck",
> +static struct clk timer1_fck = {
> +	.name		= "timer1_fck",

So if you look at the OMAP242x TRM, you can see that the actual name for 
these clocks should be WU_GPT1_CLK and CORE_GPT*_CLK.  That's definitely 
closer to our existing "gpt*_fck" naming scheme, so I don't see the point 
in renaming the existing clock names.  It shouldn't affect the drivers or 
integration code in any way...

> @@ -1823,29 +1823,29 @@ static struct omap_clk omap2420_clks[] = {
>  	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_242X),
>  	/* general l4 interface ck, multi-parent functional clk */
>  	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_242X),
> -	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_242X),
> +	CLK(NULL,	"timer1_fck",	&timer1_fck,	CK_242X),

And these changes can be dropped too.  The only reason that these lines 
need to be kept around at all is because we're still using the clkdev code 
to register clocks (not just provide aliases).

> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index 5d7a0ee..9459d70 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -164,8 +164,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
>  		return -ENXIO;
>  
>  	/* After the dmtimer is using hwmod these clocks won't be needed */
> -	sprintf(name, "gpt%d_fck", gptimer_id);
> -	timer->fclk = clk_get(NULL, name);
> +	timer->fclk = clk_get(NULL, oh->main_clk);
>  	if (IS_ERR(timer->fclk))
>  		return -ENODEV;

If you find yourself accessing struct omap_hwmod structure fields 
directly, something is almost certainly wrong; and this case is not an
exception.  Since the omap_device code is defining an "fck" alias to the 
main_clk, all you should need to do is:

-     sprintf(name, "gpt%d_fck", gptimer_id);
-     timer->fclk = clk_get(NULL, name);  
+     timer->fclk = clk_get(NULL, "fck");


- Paul
