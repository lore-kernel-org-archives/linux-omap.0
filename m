From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 07/13] OMAP3: Introduce custom set rate and get rate APIs for scalable devices
Date: Fri, 04 Feb 2011 08:08:31 -0800
Message-ID: <87vd0zsry8.fsf@ti.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
	<1295618465-15234-8-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:52789 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752104Ab1BDQIg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 11:08:36 -0500
Received: by mail-iy0-f173.google.com with SMTP id 19so2301839iye.18
        for <linux-omap@vger.kernel.org>; Fri, 04 Feb 2011 08:08:34 -0800 (PST)
In-Reply-To: <1295618465-15234-8-git-send-email-vishwanath.bs@ti.com>
	(Vishwanath BS's message of "Fri, 21 Jan 2011 19:30:59 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Thara Gopinath <thara@ti.com>

Vishwanath BS <vishwanath.bs@ti.com> writes:

> From: Thara Gopinath <thara@ti.com>
>
> This patch also introduces omap3_mpu_set_rate, omap3_iva_set_rate,
> omap3_l3_set_rate, omap3_mpu_get_rate, omap3_iva_get_rate,
> omap3_l3_get_rate as device specific set rate and get rate
> APIs for OMAP3 mpu, iva and l3_main devices. This patch also
> calls into omap_device_populate_rate_fns during system init to register
> various set_rate and get_rate APIs with the omap device layer
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/pm.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 71 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index d5a102c..1b94ad4 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -23,6 +23,9 @@
>  #include "powerdomain.h"
>  #include "clockdomain.h"
>  #include "pm.h"
> +#include "cm2xxx_3xxx.h"
> +#include "cm-regbits-34xx.h"
> +#include "prm.h"
>  
>  static struct omap_device_pm_latency *pm_lats;
>  
> @@ -31,6 +34,8 @@ static struct device *iva_dev;
>  static struct device *l3_dev;
>  static struct device *dsp_dev;
>  
> +static struct clk *dpll1_clk, *dpll2_clk, *dpll3_clk;
> +
>  struct device *omap2_get_mpuss_device(void)
>  {
>  	WARN_ON_ONCE(!mpu_dev);
> @@ -77,6 +82,55 @@ static int _init_omap_device(char *name, struct device **new_dev)
>  	return 0;
>  }
>  
> +static unsigned long omap3_mpu_get_rate(struct device *dev)
> +{
> +	return dpll1_clk->rate;
> +}
> +
> +static int omap3_mpu_set_rate(struct device *dev, unsigned long rate)
> +{
> +	int ret;
> +
> +	ret = clk_set_rate(dpll1_clk, rate);
> +	if (ret) {
> +		dev_warn(dev, "%s: Unable to set rate to %ld\n",
> +			__func__, rate);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int omap3_iva_set_rate(struct device *dev, unsigned long rate)
> +{
> +	return clk_set_rate(dpll2_clk, rate);
> +}
> +
> +static unsigned long omap3_iva_get_rate(struct device *dev)
> +{
> +	return dpll2_clk->rate;
> +}
> +
> +static int omap3_l3_set_rate(struct device *dev, unsigned long rate)
> +{
> +	int l3_div;
> +
> +	l3_div = omap2_cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
> +			OMAP3430_CLKSEL_L3_MASK;
> +
> +	return clk_set_rate(dpll3_clk, rate * l3_div);
> +}
> +
> +static unsigned long omap3_l3_get_rate(struct device *dev)
> +{
> +	int l3_div;
> +
> +	l3_div = omap2_cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
> +			OMAP3430_CLKSEL_L3_MASK;
> +	return dpll3_clk->rate / l3_div;
> +}
> +
> +
>  /*
>   * Build omap_devices for processors and bus.
>   */
> @@ -90,6 +144,23 @@ static void omap2_init_processor_devices(void)
>  	} else {
>  		_init_omap_device("l3_main", &l3_dev);
>  	}
> +
> +	if (cpu_is_omap34xx()) {
> +		dpll1_clk = clk_get(NULL, "dpll1_ck");
> +		dpll2_clk = clk_get(NULL, "dpll2_ck");
> +		dpll3_clk = clk_get(NULL, "dpll3_m2_ck");

Should check return value of clk_get() calls.

> +		if (mpu_dev)
> +			omap_device_register_dvfs_callbacks(mpu_dev,
> +				omap3_mpu_set_rate, omap3_mpu_get_rate);
> +		if (iva_dev)
> +			omap_device_register_dvfs_callbacks(iva_dev,
> +				omap3_iva_set_rate, omap3_iva_get_rate);
> +		if (l3_dev)
> +			omap_device_register_dvfs_callbacks(l3_dev,
> +				omap3_l3_set_rate, omap3_l3_get_rate);
> +
> +	}
>  }
>  
>  /* Types of sleep_switch used in omap_set_pwrdm_state */

Kevin
