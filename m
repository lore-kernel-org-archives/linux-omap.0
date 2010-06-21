From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: wait on IDLEST after enabling USBTLL fclk
Date: Mon, 21 Jun 2010 08:07:31 -0700
Message-ID: <878w682zm4.fsf@deeprootsystems.com>
References: <1273127288-21590-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45042 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932343Ab0FUPHh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 11:07:37 -0400
Received: by pwj8 with SMTP id 8so349687pwj.19
        for <linux-omap@vger.kernel.org>; Mon, 21 Jun 2010 08:07:36 -0700 (PDT)
In-Reply-To: <1273127288-21590-1-git-send-email-gadiyar@ti.com> (Anand Gadiyar's message of "Thu\,  6 May 2010 11\:58\:08 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Anand Gadiyar <gadiyar@ti.com> writes:

> We need to wait on the IDLEST bit after the clocks are enabled
> before attempting to access any register.
>
> Currently, the USBTLL i-clock ops uses the clkops_omap2_dflt_wait,
> while the USBTLL f-clock ops uses clkops_omap2_dflt. If the
> i-clock is enabled first, the clkops_omap2_dflt_wait is
> short-circuited as the companion f-clock is not enabled.
> This can cause a data abort if the IDLEST has not transitioned,
> and we try to access a USBTLL register.
>
> Since the USBTLL i-clock and f-clock could be enabled in any order,
> this is a bug. Fix it by changing the clkops for the f-clock.
>
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

> ---
>
>  arch/arm/mach-omap2/clock3xxx_data.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: linux-omap-2.6/arch/arm/mach-omap2/clock3xxx_data.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/clock3xxx_data.c
> +++ linux-omap-2.6/arch/arm/mach-omap2/clock3xxx_data.c
> @@ -1484,7 +1484,7 @@ static struct clk ts_fck = {
>  
>  static struct clk usbtll_fck = {
>  	.name		= "usbtll_fck",
> -	.ops		= &clkops_omap2_dflt,
> +	.ops		= &clkops_omap2_dflt_wait,
>  	.parent		= &dpll5_m2_ck,
>  	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
>  	.enable_bit	= OMAP3430ES2_EN_USBTLL_SHIFT,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
