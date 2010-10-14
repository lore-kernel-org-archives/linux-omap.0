From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 10/11] OMAP3: PM: Program correct init voltages for VDD1 and VDD2
Date: Thu, 14 Oct 2010 16:53:28 -0700
Message-ID: <871v7spc07.fsf@deeprootsystems.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	<1285166719-19352-11-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:48402 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754411Ab0JNXxb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Oct 2010 19:53:31 -0400
Received: by pxi16 with SMTP id 16so20914pxi.19
        for <linux-omap@vger.kernel.org>; Thu, 14 Oct 2010 16:53:30 -0700 (PDT)
In-Reply-To: <1285166719-19352-11-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Wed, 22 Sep 2010 20:15:18 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> By default the system boots up at nominal voltage for every
> voltage domain in the system. This patch puts VDD1 and VDD2
> to the correct boot up voltage as per the opp tables specified.
> This patch implements this by matching the rate of the main clock
> of the voltage domain with the opp table and picking up the correct
> voltage.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

For de-coupling the init from OPP, I like this approach better.  Thanks.

Minor comment below...

> ---
>  arch/arm/mach-omap2/pm.c |   67 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 66 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 71c5a77..86c7bf1 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -13,6 +13,7 @@
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/err.h>
> +#include <linux/clk.h>
>  
>  #include <plat/omap-pm.h>
>  #include <plat/omap_device.h>
> @@ -20,6 +21,7 @@
>  
>  #include <plat/powerdomain.h>
>  #include <plat/clockdomain.h>
> +#include <plat/voltage.h>
>  
>  #include "pm.h"
>  
> @@ -138,12 +140,75 @@ err:
>  	return ret;
>  }
>  
> +/*
> + * This is to be called during init to put the various voltage
> + * domains to the voltage as per the opp table. Typically we boot up
> + * at the nominal voltage. So this function finds out the rate of
> + * the clock associated with the voltage domain, finds out the correct
> + * opp entry and puts the voltage domain to the voltage specifies
> + * in the opp entry
> + */
> +static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
> +						struct device *dev)
> +{
> +	struct voltagedomain *voltdm;
> +	struct clk *_clk;

s/_clk/clk/

> +	struct omap_opp *opp;
> +	unsigned long freq, bootup_volt;
> +
> +	if (!vdd_name || !clk_name || !dev) {
> +		printk(KERN_ERR "%s: Invalid parameters!\n", __func__);
> +		goto exit;
> +	}
> +
> +	voltdm = omap_voltage_domain_get(vdd_name);
> +	if (IS_ERR(voltdm)) {
> +		printk(KERN_ERR "%s: Unable to get vdd pointer for vdd_%s\n",
> +			__func__, vdd_name);
> +		goto exit;
> +	}
> +
> +	_clk =  clk_get(NULL, clk_name);
> +	if (IS_ERR(_clk)) {
> +		printk(KERN_ERR "%s: unable to get clk %s\n",
> +			__func__, clk_name);
> +		goto exit;
> +	}
> +
> +	freq = _clk->rate;
> +	opp = opp_find_freq_ceil(dev, &freq);
> +	if (IS_ERR(opp)) {
> +		printk(KERN_ERR "%s: unable to find boot up OPP for vdd_%s\n",
> +			__func__, vdd_name);
> +		goto exit;
> +	}
> +
> +	bootup_volt = opp_get_voltage(opp);
> +	if (!bootup_volt) {
> +		printk(KERN_ERR "%s: unable to find voltage corresponding"
> +			"to the bootup OPP for vdd_%s\n", __func__, vdd_name);
> +		goto exit;
> +	}
> +
> +	omap_voltage_scale_vdd(voltdm, bootup_volt);
> +
> +	return 0;
> +
> +exit:
> +	printk(KERN_ERR "%s: Unable to put vdd_%s to its init voltage\n\n",
> +		__func__, vdd_name);
> +	return -EINVAL;
> +}
> +
>  static int __init omap2_common_pm_init(void)
>  {
>  	omap2_init_processor_devices();
>  
> -	if (cpu_is_omap34xx())
> +	if (cpu_is_omap34xx()) {
>  		omap3_pm_init_opp_table();
> +		omap2_set_init_voltage("mpu", "dpll1_ck", mpu_dev);
> +		omap2_set_init_voltage("core", "l3_ick", l3_dev);
> +	}
>  
>  	omap_pm_if_init();
