From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] OMAP3: wait on IDLEST after enabling USBTLL fclk
Date: Sat, 19 Jun 2010 02:25:41 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032358E85A@dbde02.ent.ti.com>
References: <1273127288-21590-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45756 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300Ab0FRUzw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jun 2010 16:55:52 -0400
In-Reply-To: <1273127288-21590-1-git-send-email-gadiyar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Gadiyar, Anand wrote:
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

Ping?


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
> 