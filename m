From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH] arm:omap:omap4: Remove hardcoded reg-offs for PWRSTCTRL & PWRSTST
Date: Fri, 06 Jan 2012 11:26:55 -0800
Message-ID: <87ehvc3a4g.fsf@ti.com>
References: <hvaibhav@ti.com>
	<1324371451-2267-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:46368 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752038Ab2AFT07 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jan 2012 14:26:59 -0500
Received: by mail-yw0-f41.google.com with SMTP id o21so5277yho.14
        for <linux-omap@vger.kernel.org>; Fri, 06 Jan 2012 11:26:58 -0800 (PST)
In-Reply-To: <1324371451-2267-1-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Tue, 20 Dec 2011 14:27:31 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Tony Lindgren <tony@atomide.com>

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> PRM module in AM33XX is closer to OMAP4 PRM module, so it makes complete
> sense to reuse all the code from existing OMAP4 implementation.
> Having said that, ther is a catch here with respect to AM33XX device,
>
> The register offset in PRM module is not consistent
> across (crazy IP integration), for example,
>
> PRM_XXX         PWRSTCTRL PWRSTST RSTCTRL RSTST
> ===============================================
> PRM_PER_MOD:    0x0C,     0x08,   0x00,   0x04
> PRM_WKUP_MOD:   0x04,     0x08,   0x00,   0x0C
> PRM_MPU_MOD:    0x00,     0x04,   0x08,   NA
> PRM_DEVICE_MOD: NA,       NA,     0x00,   0x08
>
> So in order to reuse the existing OMAP4 code, we have to add
> separate entry for register offsets, especially
> PWRSTCTRL & PWRSTST.

> This patch removes the existing hard-coded way of providing
> offset to omap4_prminst_xxx API's and instead use offsets
> provided in powerdomainsxxxx_data.

Thanks, I think this is a much better approach.

However, for ease of review, I think it should still be broken up a bit
more.  First, create a patch that just changes the existing OMAP4 code
to use the new fields without changing any functionality.
powerdomain.h, pwerdomain44xx.c, powerdomains44xx_data.c

Then, the AM33x support should be added in a separate patch.

[...]

> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 5192cab..4fd53d4 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1288,14 +1288,14 @@ static int _assert_hardreset(struct omap_hwmod *oh, const char *name)
>  	if (IS_ERR_VALUE(ret))
>  		return ret;
>
> -	if (cpu_is_omap24xx() || cpu_is_omap34xx())
> -		return omap2_prm_assert_hardreset(oh->prcm.omap2.module_offs,
> -						  ohri.rst_shift);

Why are moving this OMAP2/3 code below?  

I assume it is because cpu_is_omap34xx() is true for AM33xx?  If so, a
comment is probably needed here so we don't mess with the ordering.

> -	else if (cpu_is_omap44xx())
> +	if (cpu_is_omap44xx() || cpu_is_am33xx())
>  		return omap4_prminst_assert_hardreset(ohri.rst_shift,
>  				  oh->clkdm->pwrdm.ptr->prcm_partition,
>  				  oh->clkdm->pwrdm.ptr->prcm_offs,
>  				  oh->prcm.omap4.rstctrl_offs);
> +	else if (cpu_is_omap24xx() || cpu_is_omap34xx())
> +		return omap2_prm_assert_hardreset(oh->prcm.omap2.module_offs,
> +						  ohri.rst_shift);
>  	else
>  		return -EINVAL;
>  }
> @@ -1322,11 +1322,7 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
>  	if (IS_ERR_VALUE(ret))
>  		return ret;
>
> -	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
> -		ret = omap2_prm_deassert_hardreset(oh->prcm.omap2.module_offs,
> -						   ohri.rst_shift,
> -						   ohri.st_shift);
> -	} else if (cpu_is_omap44xx()) {
> +	if (cpu_is_omap44xx() || cpu_is_am33xx()) {
>  		if (ohri.st_shift)
>  			pr_err("omap_hwmod: %s: %s: hwmod data error: OMAP4 does not support st_shift\n",
>  			       oh->name, name);
> @@ -1334,6 +1330,10 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
>  				  oh->clkdm->pwrdm.ptr->prcm_partition,
>  				  oh->clkdm->pwrdm.ptr->prcm_offs,
>  				  oh->prcm.omap4.rstctrl_offs);
> +	} else if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
> +		ret = omap2_prm_deassert_hardreset(oh->prcm.omap2.module_offs,
> +						   ohri.rst_shift,
> +						   ohri.st_shift);

same comment as above.

Kevin
