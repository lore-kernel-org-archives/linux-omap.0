From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: SmartReflex: pass device dependent data via
 platform data
Date: Mon, 17 Sep 2012 15:20:50 -0700
Message-ID: <20120917222048.GH11762@atomide.com>
References: <1347615554-28351-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:42208 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756741Ab2IQWUx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Sep 2012 18:20:53 -0400
Content-Disposition: inline
In-Reply-To: <1347615554-28351-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, J Keerthy <j-keerthy@ti.com>, Jean Pihet <j-pihet@ti.com>

Hi,

* jean.pihet@newoldbits.com <jean.pihet@newoldbits.com> [120914 02:40]:
> From: Jean Pihet <j-pihet@ti.com>
> 
> Remove the device dependent settings (cpu_is_xxx(), IP clock name)
> from the driver code and pass them instead via the platform
> data.
> This allows a clean separation of the driver code and the platform
> code.

Thanks for fixing this. Looks like this should be queued by the
drivers/power/avs maintainers and there should not be merge
conflicts with other omap changes queued.

Maybe do $ scripts/get_maintainer.pl -f drivers/power/avs
and resend both patches to the maintainers?

One comment below on the clocks though..
 
> --- a/arch/arm/mach-omap2/sr_device.c
> +++ b/arch/arm/mach-omap2/sr_device.c
> @@ -122,6 +122,26 @@ static int __init sr_dev_init(struct omap_hwmod *oh, void *user)
>  	sr_data->senn_mod = 0x1;
>  	sr_data->senp_mod = 0x1;
>  
> +	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
> +		sr_data->err_weight = OMAP3430_SR_ERRWEIGHT;
> +		sr_data->err_maxlimit = OMAP3430_SR_ERRMAXLIMIT;
> +		sr_data->accum_data = OMAP3430_SR_ACCUMDATA;
> +		if (!(strcmp(sr_data->name, "smartreflex_mpu_iva"))) {
> +			sr_data->senn_avgweight = OMAP3430_SR1_SENNAVGWEIGHT;
> +			sr_data->senp_avgweight = OMAP3430_SR1_SENPAVGWEIGHT;
> +		} else {
> +			sr_data->senn_avgweight = OMAP3430_SR2_SENNAVGWEIGHT;
> +			sr_data->senp_avgweight = OMAP3430_SR2_SENPAVGWEIGHT;
> +		}
> +	}
> +
> +	if (cpu_is_omap34xx())
> +		strncpy(sr_data->sys_clk_name, "sys_ck",
> +			sizeof(sr_data->sys_clk_name));
> +	else
> +		strncpy(sr_data->sys_clk_name, "sys_clkin_ck",
> +			sizeof(sr_data->sys_clk_name));
> +
>  	sr_data->voltdm = voltdm_lookup(sr_dev_attr->sensor_voltdm_name);
>  	if (IS_ERR(sr_data->voltdm)) {
>  		pr_err("%s: Unable to get voltage domain pointer for VDD %s\n",

Here you should not pass clocks around. The driver should be able to
clk_get(dev, "fck") as long as you have the proper CLK() aliases set
in the arch/arm/mach-omap2/clock*_data.c files.

Regards,

Tony
