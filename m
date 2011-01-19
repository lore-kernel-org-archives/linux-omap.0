From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] OMAP3: PM: Adding T2 enabling of smartreflex
Date: Wed, 19 Jan 2011 11:24:07 +0200
Message-ID: <4D36ADB7.3050807@ti.com>
References: <1295428078-7822-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:39243 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752736Ab1ASJYO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jan 2011 04:24:14 -0500
Received: by yie19 with SMTP id 19so256863yie.31
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 01:24:12 -0800 (PST)
In-Reply-To: <1295428078-7822-1-git-send-email-shweta.gulati@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: shweta gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

shweta gulati wrote, on 01/19/2011 11:07 AM:

could we improve $subject?

> From: Thara Gopinath<thara@ti.com>
>
> The smartreflex bit on twl4030 needs to be enabled by default irrespective
> of whether smartreflex module is enabled on the OMAP side or not.
> This is because without this bit enabled the voltage scaling through
> vp forceupdate does not function properly on OMAP3. There are two
> APIs being added 'omap3_twl_enable_sr' to set SR bit and other API
> 'omap3_twl_disable_sr' to disable SR bit for platforms where voltage
> is not scaled using vpforceupdate or vc_bypass Method.
I cant see how disable_sr is usable, further as discussed in 
http://marc.info/?l=linux-omap&m=129424774929498&w=2 we decided to 
introduce api *if needed*. does any one need it?

>
> This patch is based on LO PM Branch and Smartreflex has been
> tested on OMAP3430 SDP, OMAP3630 SDP and boot tested on
> OMAP2430 SDP.
>
> Signed-off-by: Shweta Gulati<shweta.gulati@ti.com>
> Signed-off-by: Thara Gopinath<thara@ti.com>
> ---
>   arch/arm/mach-omap2/omap_twl.c |   46 ++++++++++++++++++++++++++++++++++++++++
>   arch/arm/mach-omap2/pm.h       |    2 +
>   2 files changed, 48 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
> index 00e1d2b..5b3ca56 100644
> --- a/arch/arm/mach-omap2/omap_twl.c
> +++ b/arch/arm/mach-omap2/omap_twl.c
> @@ -60,7 +60,9 @@
>   static bool is_offset_valid;
>   static u8 smps_offset;
>
> +#define TWL4030_DCDC_GLOBAL_CFG        0x06
>   #define REG_SMPS_OFFSET         0xE0
> +#define SMARTREFLEX_ENABLE     BIT(3)
>
>   static unsigned long twl4030_vsel_to_uv(const u8 vsel)
>   {
> @@ -269,6 +271,15 @@ int __init omap3_twl_init(void)
>   		omap3_core_volt_info.vp_vddmax = OMAP3630_VP2_VLIMITTO_VDDMAX;
>   	}
>
> +	/*
> +	 * The smartreflex bit on twl4030 needs to be enabled by
> +	 * default irrespective of whether smartreflex module is
> +	 * enabled on the OMAP side or not. This is because without
> +	 * this bit enabled the voltage scaling through
> +	 * vp forceupdate does not function properly on OMAP3.
> +	 */
> +	omap3_twl_enable_sr();

I am a bit lost:omap3_twl_init is called from pm.c 
omap2_common_pm_late_init right? as per
http://marc.info/?l=linux-omap&m=129424774929498&w=2
we could optionally override this bit from board file using some api - 
with this being done in pm_late_init, what chance does the board file 
have to do something else?


> +
>   	voltdm = omap_voltage_domain_lookup("mpu");
>   	omap_voltage_register_pmic(voltdm,&omap3_mpu_volt_info);
>
> @@ -277,3 +288,38 @@ int __init omap3_twl_init(void)
>
>   	return 0;
>   }
> +
> +/*
> + * The smartreflex bit on twl4030 is enabled in twl_init
> + * but there are platforms which use OMAP3 and T2 but use
> + * Synchronized Scaling Hardware Strategy (ENABLE_VMODE=1) and
> + * Direct Strategy Software Scaling Mode (ENABLE_VMODE=0).
> + * for setting the voltages of T2, in those scenarios this bit
> + * is to be cleared.
> + */
please read Documentation/kernel-doc-nano-HOWTO.txt line 54 to see how 
to use function comment header

> +void omap3_twl_disable_sr()
a) why is this not returning int? i2c reads and writes can fail.
b) there is no usage of this function - why have it?
> +{
> +	u8 temp;
> +
> +	twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER,&temp,
> +			TWL4030_DCDC_GLOBAL_CFG);
> +	temp&= ~SMARTREFLEX_ENABLE;
> +	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, temp,
> +			TWL4030_DCDC_GLOBAL_CFG);
> +}
> +
> +/*
> + * To enable Smartreflex bit on TWl 4030 to make sure
> + * voltage scaling through Vp forceupdate works.
> + */
> +
and here.
> +void omap3_twl_enable_sr()
a) __init?
b) why is this not returning int? i2c reads and writes can fail.

> +{
> +	u8 temp;
> +
> +	twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER,&temp,
> +			TWL4030_DCDC_GLOBAL_CFG);
> +	temp |= SMARTREFLEX_ENABLE;
> +	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, temp,
> +			TWL4030_DCDC_GLOBAL_CFG);
> +}
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 704766b..8500356 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -127,6 +127,8 @@ static inline void omap_enable_smartreflex_on_init(void) {}
>   #ifdef CONFIG_TWL4030_CORE
>   extern int omap3_twl_init(void);
>   extern int omap4_twl_init(void);
> +extern void omap3_twl_disable_sr(void);
> +extern void omap3_twl_enable_sr(void);
>   #else
>   static inline int omap3_twl_init(void)
>   {


-- 
Regards,
Nishanth Menon
