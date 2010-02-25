From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC][PATCH 2/3] OMAP clock: Add uart4_ick/fck definitions for
 3630
Date: Thu, 25 Feb 2010 14:04:53 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002251404380.2701@utopia.booyaka.com>
References: <1267108876-18028-1-git-send-email-saaguirre@ti.com> <1267108876-18028-3-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54979 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933645Ab0BYVEy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 16:04:54 -0500
In-Reply-To: <1267108876-18028-3-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergio Aguirre <saaguirre@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, 25 Feb 2010, Sergio Aguirre wrote:

> This is only valid for omap 36xx family of chips.
> 
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>

Reviewed-by: Paul Walmsley <paul@pwsan.com>

Nice work Sergio.

> ---
>  arch/arm/mach-omap2/clock34xx_data.c |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
> index 8728f1f..5d783bd 100644
> --- a/arch/arm/mach-omap2/clock34xx_data.c
> +++ b/arch/arm/mach-omap2/clock34xx_data.c
> @@ -2381,6 +2381,16 @@ static struct clk uart3_fck = {
>  	.recalc		= &followparent_recalc,
>  };
>  
> +static struct clk uart4_fck = {
> +	.name		= "uart4_fck",
> +	.ops		= &clkops_omap2_dflt_wait,
> +	.parent		= &per_48m_fck,
> +	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
> +	.enable_bit	= OMAP3630_EN_UART4_SHIFT,
> +	.clkdm_name	= "per_clkdm",
> +	.recalc		= &followparent_recalc,
> +};
> +
>  static struct clk gpt2_fck = {
>  	.name		= "gpt2_fck",
>  	.ops		= &clkops_omap2_dflt_wait,
> @@ -2631,6 +2641,16 @@ static struct clk uart3_ick = {
>  	.recalc		= &followparent_recalc,
>  };
>  
> +static struct clk uart4_ick = {
> +	.name		= "uart4_ick",
> +	.ops		= &clkops_omap2_dflt_wait,
> +	.parent		= &per_l4_ick,
> +	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
> +	.enable_bit	= OMAP3630_EN_UART4_SHIFT,
> +	.clkdm_name	= "per_clkdm",
> +	.recalc		= &followparent_recalc,
> +};
> +
>  static struct clk gpt9_ick = {
>  	.name		= "gpt9_ick",
>  	.ops		= &clkops_omap2_dflt_wait,
> @@ -3160,6 +3180,7 @@ static struct omap_clk omap3xxx_clks[] = {
>  	CLK(NULL,	"per_96m_fck",	&per_96m_fck,	CK_3XXX),
>  	CLK(NULL,	"per_48m_fck",	&per_48m_fck,	CK_3XXX),
>  	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_3XXX),
> +	CLK(NULL,	"uart4_fck",	&uart4_fck,	CK_36XX),
>  	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_3XXX),
>  	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_3XXX),
>  	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_3XXX),
> @@ -3183,6 +3204,7 @@ static struct omap_clk omap3xxx_clks[] = {
>  	CLK(NULL,	"gpio2_ick",	&gpio2_ick,	CK_3XXX),
>  	CLK(NULL,	"wdt3_ick",	&wdt3_ick,	CK_3XXX),
>  	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_3XXX),
> +	CLK(NULL,	"uart4_ick",	&uart4_ick,	CK_36XX),
>  	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_3XXX),
>  	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_3XXX),
>  	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_3XXX),
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
