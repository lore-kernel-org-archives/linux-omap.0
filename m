From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] OMAP3: PM: Adding T2 enabling of smartreflex
Date: Mon, 03 Jan 2011 09:51:57 -0600
Message-ID: <4D21F09D.3040007@ti.com>
References: <1293782878-9756-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:50510 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755230Ab1ACPwB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 10:52:01 -0500
Received: by mail-gx0-f169.google.com with SMTP id 5so6653372gxk.14
        for <linux-omap@vger.kernel.org>; Mon, 03 Jan 2011 07:52:00 -0800 (PST)
In-Reply-To: <1293782878-9756-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath had written, on 12/31/2010 02:07 AM, the following:
> The smartreflex bit on twl4030 needs to be enabled by default irrespective
> of whether smartreflex module is enabled on the OMAP side or not.
> This is because without this bit enabled the voltage scaling through
> vp forceupdate does not function properly on OMAP3.
s/does not function properly/ does not function ;)
SR I2C is used for forceupdate/vc bypass modes - so neither will 
function without switching t2 mode.

T2 voltages could be set in quiet a few methods:
a) Synchronized Scaling Hardware Strategy (ENABLE_VMODE = 1) (for OMAP2 
and I had worked on one OMAP3430 product which used this as well) using 
VDD1_VFLOOR and VDD1_VROOF
b) Direct Strategy Software Scaling Mode (ENABLE_VMODE = 0) (Smart 
reflex disabled) - VDD1_VSEL
c) using smart reflex - as done below - allows OMAP with smart reflex 
hardware wired to the twl to use that functionality.

Blindly setting it to smartreflex mode is not correct IMHO. It might 
work on SDP and few TI and non-TI platforms, but not all.

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
>  


-- 
Regards,
Nishanth Menon
