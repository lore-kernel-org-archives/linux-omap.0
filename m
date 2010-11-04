From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 3/6] OMAP4: PM: Program correct init voltages for
 scalable VDDs
Date: Thu, 4 Nov 2010 10:20:10 -0700
Message-ID: <20101104172010.GB9264@atomide.com>
References: <1288196196-15469-1-git-send-email-thara@ti.com>
 <1288196196-15469-4-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63788 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab0KDRUP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Nov 2010 13:20:15 -0400
Content-Disposition: inline
In-Reply-To: <1288196196-15469-4-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Hi Thara,

* Thara Gopinath <thara@ti.com> [101027 09:08]:
> By default the system boots up at nominal voltage for every
> voltage domain in the system. This patch puts vdd_mpu, vdd_iva
> and vdd_core to the correct boot up voltage as per the opp tables
> specified. This patch implements this by matching the rate of
> the main clock of the voltage domain with the opp table and
> picking up the correct voltage.
> 
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/pm.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 353e155..0651667 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -211,6 +211,10 @@ static int __init omap2_common_pm_init(void)
>  	if (cpu_is_omap34xx()) {
>  		omap2_set_init_voltage("mpu", "dpll1_ck", mpu_dev);
>  		omap2_set_init_voltage("core", "l3_ick", l3_dev);
> +	} else if (cpu_is_omap44xx()) {
> +		omap2_set_init_voltage("mpu", "dpll_mpu_ck", mpu_dev);
> +		omap2_set_init_voltage("core", "l3_div_ck", l3_dev);
> +		omap2_set_init_voltage("iva", "dpll_iva_m5x2_ck", iva_dev);
>  	}
>  
>  	omap_pm_if_init();

In general, we want to avoid adding these "if cpu_is_ompa34xx else if"
things all over the place. That makes the code hard to maintain and
requires patching all over the place to add support for new omaps.

Instead, please do something like this:

static int __init omap_common_whatever_init(struct whatever_data *d)
{
	...

	return 0;
}

static int __init omap3_whatever_init(void)
{
	struct whatever_data *d;

	if (!cpu_is_omap34xx())
		return -ENODEV;

	/* Initialize omap3 specific things */
	...

	return omap_common_whatever_init(d);
}
device_initcall(omap3_whatever_init);

static int __init omap4_whatever_init(void)
{
	struct whatever_data *d;

	if (!cpu_is_omap44xx())
		return -ENODEV;

	/* Initialize omap4 specific things */
	...

	return omap_common_whatever_init(d);
}
device_initcall(omap4_whatever_init);
...

This way the common code stays readable and does not need
to be patched when support for new omaps is added. Also the
code for unselected omaps gets optimized out and an extra
level of code indentation is left out.

Regards,

Tony
