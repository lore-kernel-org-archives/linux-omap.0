From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4] ARM: omap2: twl-common: Add default power
 configuration
Date: Wed, 3 Apr 2013 08:43:35 -0700
Message-ID: <20130403154335.GU10155@atomide.com>
References: <1364992287-6992-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61219 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761060Ab3DCPnl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Apr 2013 11:43:41 -0400
Content-Disposition: inline
In-Reply-To: <1364992287-6992-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>

* Peter Ujfalusi <peter.ujfalusi@ti.com> [130403 05:36]:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> This patch adds a generic power script configuration.
> When rebooting an OMAP3530 at 125 MHz, the reboot hangs.
> With the generic power script, TWL4030 will be reset
> when a warm reset occures. This way the OMAP3530 does not
> hang on reboot.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Tony, Matthias,
> 
> Changes since v3:
> - remove the __initdata from all the structures introduced by this patch
> 
> If it is OK, I'll send a pull with this patch.

Well I was wondering if you have checked what happens if you re-init
the driver via /sys? Is this safe to do?

Regards,

Tony
 
>  arch/arm/mach-omap2/twl-common.c | 38 ++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/twl-common.h |  1 +
>  2 files changed, 39 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
> index 51e138c..a85531e 100644
> --- a/arch/arm/mach-omap2/twl-common.c
> +++ b/arch/arm/mach-omap2/twl-common.c
> @@ -121,6 +121,41 @@ static struct twl4030_audio_data omap3_audio_pdata = {
>  	.codec = &omap3_codec,
>  };
>  
> +static struct twl4030_ins wrst_seq[] = {
> +	{MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_OFF), 2},
> +	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_WRST), 15},
> +	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_WRST), 15},
> +	{MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_WRST), 0x60},
> +	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2},
> +	{MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_ACTIVE), 2},
> +};
> +
> +static struct twl4030_script wrst_script = {
> +	.script = wrst_seq,
> +	.size	= ARRAY_SIZE(wrst_seq),
> +	.flags	= TWL4030_WRST_SCRIPT,
> +};
> +
> +static struct twl4030_script *omap3_power_scripts[] = {
> +	&wrst_script,
> +};
> +
> +static struct twl4030_resconfig omap3_rconfig[] = {
> +	{ .resource = RES_HFCLKOUT, .devgroup = DEV_GRP_P3, .type = -1,
> +		.type2 = -1 },
> +	{ .resource = RES_VDD1, .devgroup = DEV_GRP_P1, .type = -1,
> +		.type2 = -1 },
> +	{ .resource = RES_VDD2, .devgroup = DEV_GRP_P1, .type = -1,
> +		.type2 = -1 },
> +	{ 0, 0},
> +};
> +
> +static struct twl4030_power_data omap3_power_pdata = {
> +	.scripts	= omap3_power_scripts,
> +	.num		= ARRAY_SIZE(omap3_power_scripts),
> +	.resource_config = omap3_rconfig,
> +};
> +
>  static struct regulator_consumer_supply omap3_vdda_dac_supplies[] = {
>  	REGULATOR_SUPPLY("vdda_dac", "omapdss_venc"),
>  };
> @@ -225,6 +260,9 @@ void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
>  	if (pdata_flags & TWL_COMMON_PDATA_AUDIO && !pmic_data->audio)
>  		pmic_data->audio = &omap3_audio_pdata;
>  
> +	if (pdata_flags & TWL_COMMON_PDATA_POWER && !pmic_data->power)
> +		pmic_data->power = &omap3_power_pdata;
> +
>  	/* Common regulator configurations */
>  	if (regulators_flags & TWL_COMMON_REGULATOR_VDAC && !pmic_data->vdac)
>  		pmic_data->vdac = &omap3_vdac_idata;
> diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/twl-common.h
> index 24b65d0..b64590b8 100644
> --- a/arch/arm/mach-omap2/twl-common.h
> +++ b/arch/arm/mach-omap2/twl-common.h
> @@ -7,6 +7,7 @@
>  #define TWL_COMMON_PDATA_BCI		(1 << 1)
>  #define TWL_COMMON_PDATA_MADC		(1 << 2)
>  #define TWL_COMMON_PDATA_AUDIO		(1 << 3)
> +#define TWL_COMMON_PDATA_POWER		(1 << 4)
>  
>  /* Common LDO regulators for TWL4030/TWL6030 */
>  #define TWL_COMMON_REGULATOR_VDAC	(1 << 0)
> -- 
> 1.8.1.5
> 
