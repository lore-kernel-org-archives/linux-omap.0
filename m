From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: [PATCH] OMAP3: clock3xxx_data: change EMAC clocks aliases
Date: Mon, 06 Feb 2012 09:27:15 +0100
Message-ID: <4F2F8EE3.1050305@visionsystems.de>
References: <1324423634-32581-1-git-send-email-yanok@emcraft.com>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hhlx01.vscom.de ([62.145.30.242]:33295 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab2BFI11 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Feb 2012 03:27:27 -0500
In-Reply-To: <1324423634-32581-1-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ilya Yanok <yanok@emcraft.com>, linux-omap@vger.kernel.org, sasha_d@emcraft.com, Paul Walmsley <paul@pwsan.com>

Am 21.12.2011 00:27, schrieb Ilya Yanok:
> Rename EMAC clocks to match driver expectations: both davinci_emac and
> davinci_mdio drivers call clk_get(dev, NULL) so we have to provide
> ("davinci_emac", NULL) and ("davinci_mdio.0", NULL) clocks instead of
> ("davinci_emac", "emac_clk") and ("davinci_emac", "phy_clk") resp.
> 
> CC: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> ---
>  arch/arm/mach-omap2/clock3xxx_data.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
> index d75e5f6..1a60661 100644
> --- a/arch/arm/mach-omap2/clock3xxx_data.c
> +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> @@ -3465,8 +3465,8 @@ static struct omap_clk omap3xxx_clks[] = {
>  	CLK(NULL,	"ipss_ick",	&ipss_ick,	CK_AM35XX),
>  	CLK(NULL,	"rmii_ck",	&rmii_ck,	CK_AM35XX),
>  	CLK(NULL,	"pclk_ck",	&pclk_ck,	CK_AM35XX),
> -	CLK("davinci_emac",	"emac_clk",	&emac_ick,	CK_AM35XX),
> -	CLK("davinci_emac",	"phy_clk",	&emac_fck,	CK_AM35XX),
> +	CLK("davinci_emac",	NULL,	&emac_ick,	CK_AM35XX),
> +	CLK("davinci_mdio.0",	NULL,	&emac_fck,	CK_AM35XX),
>  	CLK("vpfe-capture",	"master",	&vpfe_ick,	CK_AM35XX),
>  	CLK("vpfe-capture",	"slave",	&vpfe_fck,	CK_AM35XX),
>  	CLK("musb-am35x",	"ick",		&hsotgusb_ick_am35xx,	CK_AM35XX),

Tested-by: Yegor Yefremov <yegorslists@googlemail.com>
