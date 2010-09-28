From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 07/13 v3] OMAP clock: Add uart4_ick/fck definitions for
 3630
Date: Tue, 28 Sep 2010 15:14:33 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009281512430.5439@utopia.booyaka.com>
References: <43702.10.24.255.17.1285599017.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58511 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab0I1VOe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 17:14:34 -0400
In-Reply-To: <43702.10.24.255.17.1285599017.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>, Tony Lindgren <tony@atomide.com>

Hi,

On Mon, 27 Sep 2010, Govindraj.R wrote:

> This is only valid for omap 36xx family of chips.

This patch should have my ack before being merged.  ... in fact, it really 
shouldn't be part of this series; it's completely orthogonal to the hwmod 
and OMAP serial changes, and should have gone in separately several months 
ago.

But anyway,

Acked-by: Paul Walmsley <paul@pwsan.com>

- Paul
> 
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  arch/arm/mach-omap2/clock3xxx_data.c |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
> index dfdce2d..90a4198 100644
> --- a/arch/arm/mach-omap2/clock3xxx_data.c
> +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> @@ -2465,6 +2465,16 @@ static struct clk uart3_fck = {
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
> @@ -2715,6 +2725,16 @@ static struct clk uart3_ick = {
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
> @@ -3349,6 +3369,7 @@ static struct omap_clk omap3xxx_clks[] = {
>  	CLK(NULL,	"per_96m_fck",	&per_96m_fck,	CK_3XXX),
>  	CLK(NULL,	"per_48m_fck",	&per_48m_fck,	CK_3XXX),
>  	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_3XXX),
> +	CLK(NULL,	"uart4_fck",	&uart4_fck,	CK_36XX),
>  	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_3XXX),
>  	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_3XXX),
>  	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_3XXX),
> @@ -3372,6 +3393,7 @@ static struct omap_clk omap3xxx_clks[] = {
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
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
