From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] OMAP3: PM: Adding T2 enabling of smartreflex
Date: Wed, 19 Jan 2011 15:59:01 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930248474079@dbde02.ent.ti.com>
References: <1295428078-7822-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40910 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811Ab1ASK3K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 05:29:10 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p0JAT7h8016334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 04:29:09 -0600
In-Reply-To: <1295428078-7822-1-git-send-email-shweta.gulati@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Gopinath, Thara" <thara@ti.com>, "Gulati, Shweta" <shweta.gulati@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of shweta gulati
> Sent: Wednesday, January 19, 2011 2:38 PM
> To: linux-omap@vger.kernel.org
> Cc: Gopinath, Thara; Gulati, Shweta
> Subject: [PATCH] OMAP3: PM: Adding T2 enabling of smartreflex

[sp] Few questions interleaved:

> 
> From: Thara Gopinath <thara@ti.com>
> 
> The smartreflex bit on twl4030 needs to be enabled by default 
> irrespective
> of whether smartreflex module is enabled on the OMAP side or not.

[sp] Then shouldn't we set this bit at init - one time only?

> This is because without this bit enabled the voltage scaling through
> vp forceupdate does not function properly on OMAP3. There are two
> APIs being added 'omap3_twl_enable_sr' to set SR bit and other API
> 'omap3_twl_disable_sr' to disable SR bit for platforms where voltage
> is not scaled using vpforceupdate or vc_bypass Method.

[sp] If the intent of the patch is to set the bit "irrespective of
     smartreflex; why would we need API to clear the bit.

     You may also want to consider if  set/reset is better suited
     in the api as compared to enable/disable().

     If there is need to set/clear the bit, I suggest one fuction for
     the purpose e.g. omap3_twl_set_sr(u8 flag) - though suffix "_sr"
     as used in my example still seems to be ambiguous.

~sanjeev

> 
> This patch is based on LO PM Branch and Smartreflex has been
> tested on OMAP3430 SDP, OMAP3630 SDP and boot tested on
> OMAP2430 SDP.
> 
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/omap_twl.c |   46 
> ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/pm.h       |    2 +
>  2 files changed, 48 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_twl.c 
> b/arch/arm/mach-omap2/omap_twl.c
> index 00e1d2b..5b3ca56 100644
> --- a/arch/arm/mach-omap2/omap_twl.c
> +++ b/arch/arm/mach-omap2/omap_twl.c
> @@ -60,7 +60,9 @@
>  static bool is_offset_valid;
>  static u8 smps_offset;
>  
> +#define TWL4030_DCDC_GLOBAL_CFG        0x06
>  #define REG_SMPS_OFFSET         0xE0
> +#define SMARTREFLEX_ENABLE     BIT(3)
>  
>  static unsigned long twl4030_vsel_to_uv(const u8 vsel)
>  {
> @@ -269,6 +271,15 @@ int __init omap3_twl_init(void)
>  		omap3_core_volt_info.vp_vddmax = 
> OMAP3630_VP2_VLIMITTO_VDDMAX;
>  	}
>  
> +	/*
> +	 * The smartreflex bit on twl4030 needs to be enabled by
> +	 * default irrespective of whether smartreflex module is
> +	 * enabled on the OMAP side or not. This is because without
> +	 * this bit enabled the voltage scaling through
> +	 * vp forceupdate does not function properly on OMAP3.
> +	 */
> +	omap3_twl_enable_sr();
> +
>  	voltdm = omap_voltage_domain_lookup("mpu");
>  	omap_voltage_register_pmic(voltdm, &omap3_mpu_volt_info);
>  
> @@ -277,3 +288,38 @@ int __init omap3_twl_init(void)
>  
>  	return 0;
>  }
> +
> +/*
> + * The smartreflex bit on twl4030 is enabled in twl_init
> + * but there are platforms which use OMAP3 and T2 but use
> + * Synchronized Scaling Hardware Strategy (ENABLE_VMODE=1) and
> + * Direct Strategy Software Scaling Mode (ENABLE_VMODE=0).
> + * for setting the voltages of T2, in those scenarios this bit
> + * is to be cleared.
> + */
> +void omap3_twl_disable_sr()
> +{
> +	u8 temp;
> +
> +	twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &temp,
> +			TWL4030_DCDC_GLOBAL_CFG);
> +	temp &= ~SMARTREFLEX_ENABLE;
> +	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, temp,
> +			TWL4030_DCDC_GLOBAL_CFG);
> +}
> +
> +/*
> + * To enable Smartreflex bit on TWl 4030 to make sure
> + * voltage scaling through Vp forceupdate works.
> + */
> +
> +void omap3_twl_enable_sr()
> +{
> +	u8 temp;
> +
> +	twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &temp,
> +			TWL4030_DCDC_GLOBAL_CFG);
> +	temp |= SMARTREFLEX_ENABLE;
> +	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, temp,
> +			TWL4030_DCDC_GLOBAL_CFG);
> +}
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 704766b..8500356 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -127,6 +127,8 @@ static inline void 
> omap_enable_smartreflex_on_init(void) {}
>  #ifdef CONFIG_TWL4030_CORE
>  extern int omap3_twl_init(void);
>  extern int omap4_twl_init(void);
> +extern void omap3_twl_disable_sr(void);
> +extern void omap3_twl_enable_sr(void);
>  #else
>  static inline int omap3_twl_init(void)
>  {
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 