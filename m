From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/8] OMAP4: TWL: add vdda_hdmi_dac regulator supply
Date: Thu, 6 Sep 2012 13:12:28 -0700
Message-ID: <20120906201227.GE1303@atomide.com>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
 <1345729514-2441-4-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59770 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759754Ab2IFUMa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 16:12:30 -0400
Content-Disposition: inline
In-Reply-To: <1345729514-2441-4-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120823 06:46]:
> HDMI requires vdda_hdmi_dac (vdac) power for operation. The regulator,
> or the regulator supplying the vdac, has been enabled by default and
> things have worked without the HDMI driver enabling the vdac.
> 
> I encountered the problem when implementing HDMI device tree support,
> where the regulator was not enabled by default.
> 
> This patch adds the vdda_hdmi_dac to twl-common.c so that the HDMI
> driver can use it.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>

Looks safe to merge vi fb changes:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/mach-omap2/twl-common.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
> index 119d5a9..bf90356 100644
> --- a/arch/arm/mach-omap2/twl-common.c
> +++ b/arch/arm/mach-omap2/twl-common.c
> @@ -257,6 +257,10 @@ static struct twl4030_usb_data omap4_usb_pdata = {
>  	.phy_suspend	= omap4430_phy_suspend,
>  };
>  
> +static struct regulator_consumer_supply omap4_vdda_hdmi_dac_supplies[] = {
> +	REGULATOR_SUPPLY("vdda_hdmi_dac", "omapdss_hdmi"),
> +};
> +
>  static struct regulator_init_data omap4_vdac_idata = {
>  	.constraints = {
>  		.min_uV			= 1800000,
> @@ -266,6 +270,8 @@ static struct regulator_init_data omap4_vdac_idata = {
>  		.valid_ops_mask		= REGULATOR_CHANGE_MODE
>  					| REGULATOR_CHANGE_STATUS,
>  	},
> +	.num_consumer_supplies	= ARRAY_SIZE(omap4_vdda_hdmi_dac_supplies),
> +	.consumer_supplies	= omap4_vdda_hdmi_dac_supplies,
>  	.supply_regulator	= "V2V1",
>  };
>  
> -- 
> 1.7.9.5
> 
