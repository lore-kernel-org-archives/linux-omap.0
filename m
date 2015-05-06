From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] ARM: OMAP2+: Fix bogus struct clk comparison for timer
 clock
Date: Tue, 5 May 2015 22:35:39 -0700
Message-ID: <20150506053539.GA10871@codeaurora.org>
References: <1430848941-27106-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50796 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbEFFfl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 May 2015 01:35:41 -0400
Content-Disposition: inline
In-Reply-To: <1430848941-27106-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Michael Turquette <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>

On 05/05, Tony Lindgren wrote:
> With recent changes to use determine_rate, the comparison of two
> clocks won't work without doing __clk_get_hw on the clocks
> first.
> 
> Cc: Michael Turquette <mturquette@linaro.org>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Found one more of these, the coccinelle scripts do not seem
> to match this?

I don't think the coccinelle script was ever merged...

> 
> ---
>  arch/arm/mach-omap2/timer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index cef67af..22c7a8e 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -35,6 +35,7 @@
>  #include <linux/irq.h>
>  #include <linux/clocksource.h>
>  #include <linux/clockchips.h>
> +#include <linux/clk-provider.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> @@ -298,7 +299,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
>  	if (IS_ERR(src))
>  		return PTR_ERR(src);
>  
> -	if (clk_get_parent(timer->fclk) != src) {
> +	if (__clk_get_hw(clk_get_parent(timer->fclk)) != __clk_get_hw(src)) {

Please use clk_is_match() instead so we can find these instances
with an easy grep.

>  		r = clk_set_parent(timer->fclk, src);
>  		if (r < 0) {
>  			pr_warn("%s: %s cannot set source\n", __func__,

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
