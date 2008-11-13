From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] minor mmc-twl4030 cleanups
Date: Thu, 13 Nov 2008 15:05:55 -0800
Message-ID: <20081113230555.GS3106@atomide.com>
References: <1226483285-7443-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49995 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbYKMXF6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 18:05:58 -0500
Content-Disposition: inline
In-Reply-To: <1226483285-7443-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org

* Grazvydas Ignotas <notasas@gmail.com> [081112 01:48]:
> Remove the unused devconf_loopback_clock field from twl_mmc_controller.
> control_devconf_offset only changes for DEVCONF1, so move it out.

Pushing today.

Tony

> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
>  arch/arm/mach-omap2/mmc-twl4030.c |   19 +++++++------------
>  1 files changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
> index 32625e7..b1fe0f3 100644
> --- a/arch/arm/mach-omap2/mmc-twl4030.c
> +++ b/arch/arm/mach-omap2/mmc-twl4030.c
> @@ -50,26 +50,21 @@
>  #define VMMC_DEV_GRP_P1		0x20
>  
>  static u16 control_pbias_offset;
> +static u16 control_devconf1_offset;
>  
>  #define HSMMC_NAME_LEN	9
>  
>  static struct twl_mmc_controller {
>  	struct omap_mmc_platform_data	*mmc;
> -	u32		devconf_loopback_clock;
> -	u16		control_devconf_offset;
>  	u8		twl_vmmc_dev_grp;
>  	u8		twl_mmc_dedicated;
>  	char		name[HSMMC_NAME_LEN];
>  } hsmmc[] = {
>  	{
> -		.control_devconf_offset		= OMAP2_CONTROL_DEVCONF0,
> -		.devconf_loopback_clock		= OMAP2_MMCSDIO1ADPCLKISEL,
>  		.twl_vmmc_dev_grp		= VMMC1_DEV_GRP,
>  		.twl_mmc_dedicated		= VMMC1_DEDICATED,
>  	},
>  	{
> -		/* control_devconf_offset set dynamically */
> -		.devconf_loopback_clock		= OMAP2_MMCSDIO2ADPCLKISEL,
>  		.twl_vmmc_dev_grp		= VMMC2_DEV_GRP,
>  		.twl_mmc_dedicated		= VMMC2_DEDICATED,
>  	},
> @@ -257,9 +252,9 @@ static int twl_mmc1_set_power(struct device *dev, int slot, int power_on,
>  
>  		/* REVISIT: Loop back clock not needed for 2430? */
>  		if (!cpu_is_omap2430()) {
> -			reg = omap_ctrl_readl(c->control_devconf_offset);
> +			reg = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
>  			reg |= OMAP2_MMCSDIO1ADPCLKISEL;
> -			omap_ctrl_writel(reg, c->control_devconf_offset);
> +			omap_ctrl_writel(reg, OMAP2_CONTROL_DEVCONF0);
>  		}
>  
>  		reg = omap_ctrl_readl(control_pbias_offset);
> @@ -305,9 +300,9 @@ static int twl_mmc2_set_power(struct device *dev, int slot, int power_on, int vd
>  	if (power_on) {
>  		u32 reg;
>  
> -		reg = omap_ctrl_readl(c->control_devconf_offset);
> +		reg = omap_ctrl_readl(control_devconf1_offset);
>  		reg |= OMAP2_MMCSDIO2ADPCLKISEL;
> -		omap_ctrl_writel(reg, c->control_devconf_offset);
> +		omap_ctrl_writel(reg, control_devconf1_offset);
>  		ret = twl_mmc_set_voltage(c, vdd);
>  	} else {
>  		ret = twl_mmc_set_voltage(c, 0);
> @@ -325,11 +320,11 @@ void __init hsmmc_init(struct twl4030_hsmmc_info *controllers)
>  
>  	if (cpu_is_omap2430()) {
>  		control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
> -		hsmmc[1].control_devconf_offset = OMAP243X_CONTROL_DEVCONF1;
> +		control_devconf1_offset = OMAP243X_CONTROL_DEVCONF1;
>  		nr_hsmmc = 2;
>  	} else {
>  		control_pbias_offset = OMAP343X_CONTROL_PBIAS_LITE;
> -		hsmmc[1].control_devconf_offset = OMAP343X_CONTROL_DEVCONF1;
> +		control_devconf1_offset = OMAP343X_CONTROL_DEVCONF1;
>  	}
>  
>  	for (c = controllers; c->mmc; c++) {
> -- 
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
