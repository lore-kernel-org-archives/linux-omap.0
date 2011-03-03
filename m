From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V4] OMAP3: PM: Set/clear T2 bit for Smartreflex on TWL
Date: Wed, 02 Mar 2011 16:31:58 -0800
Message-ID: <87ei6pujr5.fsf@ti.com>
References: <1297756738-2696-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:49482 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751137Ab1CCAcD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 19:32:03 -0500
Received: by mail-yi0-f53.google.com with SMTP id 25so277017yia.40
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 16:32:02 -0800 (PST)
In-Reply-To: <1297756738-2696-1-git-send-email-shweta.gulati@ti.com> (Shweta
	Gulati's message of "Tue, 15 Feb 2011 13:28:58 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>, Nishanth Menon <nm@ti.com>, linux-arm-kernel@lists.infradead.org

Shweta Gulati <shweta.gulati@ti.com> writes:

> From: Thara Gopinath <thara@ti.com>
>
> Voltage control on TWL can be done using VMODE/I2C1/I2C_SR.
> Since almost all platforms use I2C_SR on omap3, omap3_twl_init by
> default expects that OMAP's I2C_SR is plugged in to TWL's I2C
> and calls omap3_twl_set_sr_bit. On platforms where I2C_SR is not connected,
> the board files are expected to call omap3_twl_set_sr_bit(false) to
> ensure that I2C_SR path is not set for voltage control and prevent
> the default behavior of omap3_twl_init.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> Cc: linux-arm-kernel@lists.infradead.org

queueing this one for 2.6.39 (branch: for_2.6.39/pm-misc)

Kevin

> ---
> This patch is based on LO PM Branch and Smartreflex has been
> tested on OMAP3430 SDP, OMAP3630 SDP and boot tested on
> OMAP2430 SDP.
>
>  arch/arm/mach-omap2/omap_twl.c |   60 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/pm.h       |    1 +
>  2 files changed, 61 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
> index 00e1d2b..b341c36 100644
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
> +static bool __initdata twl_sr_enable_autoinit;
>  
> +#define TWL4030_DCDC_GLOBAL_CFG        0x06
>  #define REG_SMPS_OFFSET         0xE0
> +#define SMARTREFLEX_ENABLE     BIT(3)
>  
>  static unsigned long twl4030_vsel_to_uv(const u8 vsel)
>  {
> @@ -269,6 +276,18 @@ int __init omap3_twl_init(void)
>  		omap3_core_volt_info.vp_vddmax = OMAP3630_VP2_VLIMITTO_VDDMAX;
>  	}
>  
> +	/*
> +	 * The smartreflex bit on twl4030 specifies if the setting of voltage
> +	 * is done over the I2C_SR path. Since this setting is independent of
> +	 * the actual usage of smartreflex AVS module, we enable TWL SR bit
> +	 * by default irrespective of whether smartreflex AVS module is enabled
> +	 * on the OMAP side or not. This is because without this bit enabled,
> +	 * the voltage scaling through vp forceupdate/bypass mechanism of
> +	 * voltage scaling will not function on TWL over I2C_SR.
> +	 */
> +	if (!twl_sr_enable_autoinit)
> +		omap3_twl_set_sr_bit(true);
> +
>  	voltdm = omap_voltage_domain_lookup("mpu");
>  	omap_voltage_register_pmic(voltdm, &omap3_mpu_volt_info);
>  
> @@ -277,3 +296,44 @@ int __init omap3_twl_init(void)
>  
>  	return 0;
>  }
> +
> +/**
> + * omap3_twl_set_sr_bit() - Set/Clear SR bit on TWL
> + * @enable: enable SR mode in twl or not
> + *
> + * If 'enable' is true, enables Smartreflex bit on TWL 4030 to make sure
> + * voltage scaling through OMAP SR works. Else, the smartreflex bit
> + * on twl4030 is cleared as there are platforms which use OMAP3 and T2 but
> + * use Synchronized Scaling Hardware Strategy (ENABLE_VMODE=1) and Direct
> + * Strategy Software Scaling Mode (ENABLE_VMODE=0), for setting the voltages,
> + * in those scenarios this bit is to be cleared (enable = false).
> + *
> + * Returns 0 on sucess, error is returned if I2C read/write fails.
> + */
> +int __init omap3_twl_set_sr_bit(bool enable)
> +{
> +	u8 temp;
> +	int ret;
> +	if (twl_sr_enable_autoinit)
> +		pr_warning("%s: unexpected multiple calls\n", __func__);
> +
> +	ret = twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &temp,
> +					TWL4030_DCDC_GLOBAL_CFG);
> +	if (ret)
> +		goto err;
> +
> +	if (enable)
> +		temp |= SMARTREFLEX_ENABLE;
> +	else
> +		temp &= ~SMARTREFLEX_ENABLE;
> +
> +	ret = twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, temp,
> +				TWL4030_DCDC_GLOBAL_CFG);
> +	if (!ret) {
> +		twl_sr_enable_autoinit = true;
> +		return 0;
> +	}
> +err:
> +	pr_err("%s: Error access to TWL4030 (%d)\n", __func__, ret);
> +	return ret;
> +}
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 39580e6..797bfd1 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -127,6 +127,7 @@ static inline void omap_enable_smartreflex_on_init(void) {}
>  #ifdef CONFIG_TWL4030_CORE
>  extern int omap3_twl_init(void);
>  extern int omap4_twl_init(void);
> +extern int omap3_twl_set_sr_bit(bool enable);
>  #else
>  static inline int omap3_twl_init(void)
>  {
