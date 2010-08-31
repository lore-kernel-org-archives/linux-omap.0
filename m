From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 10/13] OMAP3: Introduce custom set rate and get rate APIs for scalable devices
Date: Mon, 30 Aug 2010 17:06:36 -0700
Message-ID: <87fwxvwsqb.fsf@deeprootsystems.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
	<1282130412-12027-11-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40626 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283Ab0HaAGk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Aug 2010 20:06:40 -0400
Received: by gxk23 with SMTP id 23so2191030gxk.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Aug 2010 17:06:39 -0700 (PDT)
In-Reply-To: <1282130412-12027-11-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Wed, 18 Aug 2010 16:50:09 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch also introduces omap3_mpu_set_rate, omap3_iva_set_rate,
> omap3_l3_set_rate, omap3_mpu_get_rate, omap3_iva_get_rate,
> omap3_l3_get_rate as device specific set rate and get rate
> APIs for OMAP3 mpu, iva and l3_main devices. This patch also
> calls into opp_populate_rate_fns during system init to register
> various set_rate and get_rate APIs with the generic opp
> framework.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/cpufreq34xx.c |  104 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 104 insertions(+), 0 deletions(-)

These don't belong in cpufreq34xx.c (now known as opp3xxx_data.c)  This
file is only for the OPP data itself.  Any SoC specific code should go
into pm34xx.c.

Kevin

> diff --git a/arch/arm/mach-omap2/cpufreq34xx.c b/arch/arm/mach-omap2/cpufreq34xx.c
> index 195b5bc..8b9ef72 100644
> --- a/arch/arm/mach-omap2/cpufreq34xx.c
> +++ b/arch/arm/mach-omap2/cpufreq34xx.c
> @@ -24,8 +24,22 @@
>  
>  #include <plat/opp.h>
>  #include <plat/cpu.h>
> +#include <plat/clock.h>
> +
> +#include "cm-regbits-34xx.h"
> +#include "prm.h"
>  #include "omap3-opp.h"
>  
> +static int omap3_mpu_set_rate(struct device *dev, unsigned long rate);
> +static int omap3_iva_set_rate(struct device *dev, unsigned long rate);
> +static int omap3_l3_set_rate(struct device *dev, unsigned long rate);
> +
> +static unsigned long omap3_mpu_get_rate(struct device *dev);
> +static unsigned long omap3_iva_get_rate(struct device *dev);
> +static unsigned long omap3_l3_get_rate(struct device *dev);
> +
> +struct clk *dpll1_clk, *dpll2_clk, *dpll3_clk;
> +
>  static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
>  	/* MPU OPP1 */
>  	OMAP_OPP_DEF("mpu", true, 125000000, 975000),
> @@ -92,12 +106,82 @@ static struct omap_opp_def __initdata omap36xx_opp_def_list[] = {
>  };
>  static u32 omap36xx_opp_def_size = ARRAY_SIZE(omap36xx_opp_def_list);
>  
> +
> +static int omap3_mpu_set_rate(struct device *dev, unsigned long rate)
> +{
> +	unsigned long cur_rate = omap3_mpu_get_rate(dev);
> +	int ret;
> +
> +#ifdef CONFIG_CPU_FREQ
> +	struct cpufreq_freqs freqs_notify;
> +
> +	freqs_notify.old = cur_rate / 1000;
> +	freqs_notify.new = rate / 1000;
> +	freqs_notify.cpu = 0;
> +	/* Send pre notification to CPUFreq */
> +	cpufreq_notify_transition(&freqs_notify, CPUFREQ_PRECHANGE);
> +#endif
> +	ret = clk_set_rate(dpll1_clk, rate);
> +	if (ret) {
> +		dev_warn(dev, "%s: Unable to set rate to %ld\n",
> +			__func__, rate);
> +		return ret;
> +	}
> +
> +#ifdef CONFIG_CPU_FREQ
> +	/* Send a post notification to CPUFreq */
> +	cpufreq_notify_transition(&freqs_notify, CPUFREQ_POSTCHANGE);
> +#endif
> +
> +#ifndef CONFIG_CPU_FREQ
> +	/*Update loops_per_jiffy if processor speed is being changed*/
> +	loops_per_jiffy = compute_lpj(loops_per_jiffy,
> +			cur_rate / 1000, rate / 1000);
> +#endif
> +	return 0;
> +}
> +
> +static unsigned long omap3_mpu_get_rate(struct device *dev)
> +{
> +	return dpll1_clk->rate;
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
> +	l3_div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
> +			OMAP3430_CLKSEL_L3_MASK;
> +
> +	return clk_set_rate(dpll3_clk, rate * l3_div);
> +}
> +
> +static unsigned long omap3_l3_get_rate(struct device *dev)
> +{
> +	int l3_div;
> +
> +	l3_div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
> +			OMAP3430_CLKSEL_L3_MASK;
> +	return dpll3_clk->rate / l3_div;
> +}
> +
>  /* Temp variable to allow multiple calls */
>  static u8 __initdata omap3_table_init;
>  
>  int __init omap3_pm_init_opp_table(void)
>  {
>  	struct omap_opp_def *opp_def, *omap3_opp_def_list;
> +	struct device *dev;
>  	u32 omap3_opp_def_size;
>  	int i, r;
>  
> @@ -122,6 +206,26 @@ int __init omap3_pm_init_opp_table(void)
>  			       opp_def->freq, opp_def->hwmod_name);
>  	}
>  
> +	dpll1_clk = clk_get(NULL, "dpll1_ck");
> +	dpll2_clk = clk_get(NULL, "dpll2_ck");
> +	dpll3_clk = clk_get(NULL, "dpll3_m2_ck");
> +
> +	/* Populate the set rate and get rate for mpu, iva and l3 device */
> +	dev = omap2_get_mpuss_device();
> +	if (dev)
> +		opp_populate_rate_fns(dev, omap3_mpu_set_rate,
> +				omap3_mpu_get_rate);
> +
> +	dev = omap2_get_iva_device();
> +	if (dev)
> +		opp_populate_rate_fns(dev, omap3_iva_set_rate,
> +				omap3_iva_get_rate);
> +
> +	dev = omap2_get_l3_device();
> +	if (dev)
> +		opp_populate_rate_fns(dev, omap3_l3_set_rate,
> +				omap3_l3_get_rate);
> +
>  	return 0;
>  }
