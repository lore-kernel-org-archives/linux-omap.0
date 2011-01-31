From: "Koyamangalath, Abhilash" <abhilash.kv@ti.com>
Subject: RE: [PATCH V2] OMAP3: PM: Set/reset T2 bit for Smartreflex on TWL.
Date: Mon, 31 Jan 2011 19:19:16 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087035FB31201@dbde02.ent.ti.com>
References: <1295847446-20667-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43014 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158Ab1AaNt0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Jan 2011 08:49:26 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p0VDnMcq015149
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 31 Jan 2011 07:49:25 -0600
In-Reply-To: <1295847446-20667-1-git-send-email-shweta.gulati@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gulati, Shweta" <shweta.gulati@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Gopinath, Thara" <thara@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Gulati, Shweta
> Sent: Monday, January 24, 2011 11:07 AM
> To: linux-omap@vger.kernel.org
> Cc: Gopinath, Thara; Gulati, Shweta
> Subject: [PATCH V2] OMAP3: PM: Set/reset T2 bit for Smartreflex on TWL.
> 
> From: Thara Gopinath <thara@ti.com>
> 
> The smartreflex bit on twl4030 needs to be enabled by default irrespective
> of whether smartreflex module is enabled on the OMAP side or not.
> This is because without this bit enabled the voltage scaling through
> vp forceupdate does not function properly on OMAP3.API added
> 'omap3_twl_set_sr_bit' with parameter to set/clear SR bit. It is cleared
> for platforms where voltage is not scaled using vpforceupdate
> or vc_bypass Method. In those cases 'omap3_twl_set_sr_bit' is called
> from board file, to make sure this bit is not overwritten in
> 'omap3_twl_init', a flag 'twl_sr_enable'
> is added.
> 
> This patch is based on LO PM Branch and Smartreflex has been
> tested on OMAP3430 SDP, OMAP3630 SDP and boot tested on
> OMAP2430 SDP.
The function twl4030_vsel_to_uv (where you have added a call to omap3_twl_set_sr_bit) method is getting invoked only from vp_volt_debug_get
(which is for debugfs) and omap_vp_get_curr_volt (which no one seems to be calling). Due to this I was not able to get cpufreq to work.
(I finally got it working by calling omap3_twl_set_sr_bit from omap3_twl_init instead).
It looks like I'm missing something, maybe an intermediate patch? (I'd applied your patch manually on 2.6.37).

-Abhilash


> 
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> ---
>  arch/arm/mach-omap2/omap_twl.c |   62
> ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/pm.h       |    1 +
>  2 files changed, 63 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-
> omap2/omap_twl.c
> index 00e1d2b..871a349 100644
> --- a/arch/arm/mach-omap2/omap_twl.c
> +++ b/arch/arm/mach-omap2/omap_twl.c
> @@ -59,8 +59,15 @@
> 
>  static bool is_offset_valid;
>  static u8 smps_offset;
> +/*
> + * Flag to ensure Smartreflex bit in TWL
> + * being cleared in board file is not overwritten.
> + */
> +static bool twl_sr_enable = true;
> 
> +#define TWL4030_DCDC_GLOBAL_CFG        0x06
>  #define REG_SMPS_OFFSET         0xE0
> +#define SMARTREFLEX_ENABLE     BIT(3)
> 
>  static unsigned long twl4030_vsel_to_uv(const u8 vsel)
>  {
> @@ -269,6 +276,16 @@ int __init omap3_twl_init(void)
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
> +	if (twl_sr_enable)
> +		omap3_twl_set_sr_bit(1);
> +
>  	voltdm = omap_voltage_domain_lookup("mpu");
>  	omap_voltage_register_pmic(voltdm, &omap3_mpu_volt_info);
> 
> @@ -277,3 +294,48 @@ int __init omap3_twl_init(void)
> 
>  	return 0;
>  }
> +
> +/**
> + * omap3_twl_set_sr_bit() - API to Set/Clear SR bit on TWL
> + * @flag: Flag to Set/Clear SR bit
> + *
> + * If flag is non zero, enables Smartreflex bit on TWL 4030
> + * to make sure voltage scaling through Vp forceupdate works.
> + * Else, the smartreflex bit on twl4030 is
> + * cleared as there are platforms which use
> + * OMAP3 and T2 but use Synchronized Scaling Hardware
> + * Strategy (ENABLE_VMODE=1) and Direct Strategy Software
> + * Scaling Mode (ENABLE_VMODE=0), for setting the voltages,
> + * in those scenarios this bit is to be cleared.
> + * API returns 0 on sucess,  error is returned
> + * if I2C read/write fails.
> + */
> +
> +int omap3_twl_set_sr_bit(u8 flag)
> +{
> +	u8 temp;
> +	int ret;
> +
> +	ret = twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &temp,
> +				TWL4030_DCDC_GLOBAL_CFG);
> +	if (ret)
> +		goto err;
> +
> +	if (flag) {
> +		temp |= SMARTREFLEX_ENABLE;
> +		twl_sr_enable = true;
> +	} else {
> +		temp &= ~SMARTREFLEX_ENABLE;
> +		twl_sr_enable = false;
> +	}
> +
> +	ret = twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, temp,
> +			TWL4030_DCDC_GLOBAL_CFG);
> +	if (ret) {
> +err:
> +		pr_err("%s: Unable to Read/Write to TWL4030 through I2C bus "
> +				"\n", __func__);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 704766b..c98be66 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -127,6 +127,7 @@ static inline void
> omap_enable_smartreflex_on_init(void) {}
>  #ifdef CONFIG_TWL4030_CORE
>  extern int omap3_twl_init(void);
>  extern int omap4_twl_init(void);
> +extern int omap3_twl_set_sr_bit(u8 flag);
>  #else
>  static inline int omap3_twl_init(void)
>  {
> --
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
