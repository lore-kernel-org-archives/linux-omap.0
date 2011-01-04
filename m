From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP3: PM: Adding T2 enabling of smartreflex
Date: Tue, 04 Jan 2011 14:48:00 -0800
Message-ID: <87ipy45lr3.fsf@ti.com>
References: <1293782878-9756-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:35859 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750795Ab1ADWsE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 17:48:04 -0500
Received: by pzk27 with SMTP id 27so3723864pzk.14
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 14:48:03 -0800 (PST)
In-Reply-To: <1293782878-9756-1-git-send-email-thara@ti.com> (Thara Gopinath's
	message of "Fri, 31 Dec 2010 13:37:58 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, nm@ti.com

Thara Gopinath <thara@ti.com> writes:

> The smartreflex bit on twl4030 needs to be enabled by default irrespective
> of whether smartreflex module is enabled on the OMAP side or not.
> This is because without this bit enabled the voltage scaling through
> vp forceupdate does not function properly on OMAP3.

Based on Nishanth's comments, the abofe statements need a little more
justification.

What is probably needed is some default setting (possibly this one) but
with the possibility of board code to disable this if needed.

Kevin

>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
> This patch is against LO master and has been
> tested on OMAP3430 SDP and OMAP2430 SDP.
>
>  arch/arm/mach-omap2/omap_twl.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
> index 15f8c6c..a59f36b 100644
> --- a/arch/arm/mach-omap2/omap_twl.c
> +++ b/arch/arm/mach-omap2/omap_twl.c
> @@ -58,7 +58,9 @@
>  static bool is_offset_valid;
>  static u8 smps_offset;
>  
> +#define TWL4030_DCDC_GLOBAL_CFG	0x06
>  #define REG_SMPS_OFFSET         0xE0
> +#define SMARTREFLEX_ENABLE	BIT(3)
>  
>  unsigned long twl4030_vsel_to_uv(const u8 vsel)
>  {
> @@ -256,6 +258,7 @@ int __init omap4_twl_init(void)
>  int __init omap3_twl_init(void)
>  {
>  	struct voltagedomain *voltdm;
> +	u8 temp;
>  
>  	if (!cpu_is_omap34xx())
>  		return -ENODEV;
> @@ -267,6 +270,19 @@ int __init omap3_twl_init(void)
>  		omap3_core_volt_info.vp_vddmax = OMAP3630_VP2_VLIMITTO_VDDMAX;
>  	}
>  
> +	/*
> +	 * The smartreflex bit on twl4030 needs to be enabled by
> +	 * default irrespective of whether smartreflex module is
> +	 * enabled on the OMAP side or not. This is because without
> +	 * this bit enabled the voltage scaling through
> +	 * vp forceupdate does not function properly on OMAP3.
> +	 */
> +	twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &temp,
> +			TWL4030_DCDC_GLOBAL_CFG);
> +	temp |= SMARTREFLEX_ENABLE;
> +	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, temp,
> +			TWL4030_DCDC_GLOBAL_CFG);
> +
>  	voltdm = omap_voltage_domain_lookup("mpu");
>  	omap_voltage_register_pmic(voltdm, &omap3_mpu_volt_info);
