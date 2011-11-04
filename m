From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv3 10/11] omap3+: use lp params for calculating clock setup times
Date: Fri, 04 Nov 2011 14:38:59 -0700
Message-ID: <87lirv600c.fsf@ti.com>
References: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
	<1317835031-8201-11-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:53222 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751493Ab1KDVjD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 17:39:03 -0400
Received: by mail-qy0-f178.google.com with SMTP id 14so2564699qyg.16
        for <linux-omap@vger.kernel.org>; Fri, 04 Nov 2011 14:39:02 -0700 (PDT)
In-Reply-To: <1317835031-8201-11-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Wed, 5 Oct 2011 20:17:10 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <t-kristo@ti.com> writes:

> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Missing descriptive changelog.

> ---
>  arch/arm/mach-omap2/vc.c |   47 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 46 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> index c50e598..ee0edf3 100644
> --- a/arch/arm/mach-omap2/vc.c
> +++ b/arch/arm/mach-omap2/vc.c
> @@ -4,6 +4,8 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  
> +#include <asm/div64.h>
> +
>  #include <plat/cpu.h>
>  #include <plat/prcm.h>
>  
> @@ -13,6 +15,7 @@
>  #include "prm-regbits-44xx.h"
>  #include "prm44xx.h"
>  #include "scrm44xx.h"
> +#include "pm.h"
>  
>  /**
>   * struct omap_vc_channel_cfg - describe the cfg_channel bitfield
> @@ -198,12 +201,28 @@ int omap_vc_bypass_scale(struct voltagedomain *voltdm,
>  	return 0;
>  }
>  
> +static u32 omap_usec_to_32k(u32 usec)
> +{
> +	/* DIV_ROUND_UP expanded to 64bit to avoid overflow */
> +	u64 val = 32768ULL * (u64)usec + 1000000ULL - 1;
> +	do_div(val, 1000000ULL);
> +	return val;
> +}
> +
> +static void omap3_set_clksetup(u32 usec)
> +{
> +	omap3_prm_vcvp_write(omap_usec_to_32k(usec), OMAP3_PRM_CLKSETUP_OFFSET);

Please pass in voltdm and use voltdm->write()

> +}
> +
>  static void omap3_set_ret_timings(struct voltagedomain *voltdm)
>  {
>  	unsigned long voltsetup1;
>  	struct clk *sys_ck;
>  	u32 sys_clk_rate;
>  
> +	/* In retention oscillator is not shut down */
> +	omap3_set_clksetup(1);
> +
>  	sys_ck = clk_get(NULL, "sys_ck");
>  	if (IS_ERR(sys_ck)) {
>  		pr_warning("%s: unable to get sys_ck to calculate "
> @@ -229,6 +248,10 @@ static void omap3_set_off_timings(struct voltagedomain *voltdm)
>  {
>  	unsigned long clksetup;
>  	unsigned long voltsetup2;
> +	u32 tstart, tshut;
> +
> +	omap_pm_get_osc_lp_time(&tstart, &tshut);
> +	omap3_set_clksetup(tstart);
>  
>  	clksetup = voltdm->read(OMAP3_PRM_CLKSETUP_OFFSET);
>  
> @@ -236,7 +259,7 @@ static void omap3_set_off_timings(struct voltagedomain *voltdm)
>  	voltsetup2 = voltdm->vc_param->on / voltdm->pmic->slew_rate;
>  
>  	/* convert to 32k clk cycles */
> -	voltsetup2 = voltsetup2 * 32768 / 1000000 + 1;
> +	voltsetup2 = DIV_ROUND_UP(voltsetup2 * 32768, 1000000);
>  
>  	voltdm->write(voltsetup2, OMAP3_PRM_VOLTSETUP2_OFFSET);
>  
> @@ -300,12 +323,25 @@ static u32 omap4_calc_volt_ramp(struct voltagedomain *voltdm, u32 voltage_diff,
>  		(cycles << OMAP4430_RAMP_UP_COUNT_SHIFT);
>  }
>  
> +static u32 omap4_usec_to_val_scrm(u32 usec, int shift, u32 mask)
> +{
> +	u32 val;
> +
> +	val = omap_usec_to_32k(usec) << shift;
> +
> +	if (val > mask)
> +		val = mask;

This isn't entirely obvious.  At first I thought it should just be 
'val &= mask', but staring at it for awhile I think I understand now.
Adding a comment above with a description would be helpful.

> +	return val;
> +}
> +
>  static void omap4_set_timings(struct voltagedomain *voltdm, bool off_mode)
>  {
>  	struct clk *sys_ck;
>  	u32 sys_clk_rate;
>  	u32 val;
>  	u32 ramp;
> +	u32 tstart, tshut;
>  
>  	sys_ck = clk_get(NULL, "sys_clkin_ck");
>  	if (IS_ERR(sys_ck)) {
> @@ -336,6 +372,15 @@ static void omap4_set_timings(struct voltagedomain *voltdm, bool off_mode)
>  	val |= ramp << OMAP4430_RAMP_UP_COUNT_SHIFT;
>  
>  	voltdm->write(val, voltdm->vfsm->voltsetup_reg);
> +
> +	omap_pm_get_osc_lp_time(&tstart, &tshut);
> +
> +	val = omap4_usec_to_val_scrm(tstart, OMAP4_SETUPTIME_SHIFT,
> +		OMAP4_SETUPTIME_MASK);
> +	val |= omap4_usec_to_val_scrm(tshut, OMAP4_DOWNTIME_SHIFT,
> +		OMAP4_DOWNTIME_MASK);
> +	__raw_writel(val, OMAP4_SCRM_CLKSETUPTIME);
>  }
>  
>  /* OMAP4 specific voltage init functions */

Kevin
