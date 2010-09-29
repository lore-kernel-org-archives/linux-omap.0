From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 07/11] OMAP3: PM: Adding T2 enabling of smartreflex support
Date: Tue, 28 Sep 2010 17:08:23 -0700
Message-ID: <87aan19zt4.fsf@deeprootsystems.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	<1285166719-19352-8-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34308 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab0I2AI0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 20:08:26 -0400
Received: by pzk34 with SMTP id 34so46357pzk.19
        for <linux-omap@vger.kernel.org>; Tue, 28 Sep 2010 17:08:26 -0700 (PDT)
In-Reply-To: <1285166719-19352-8-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Wed, 22 Sep 2010 20:15:15 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch adds support in the twl4030 driver to hook up
> the API enabling smartreflex support on PMIC side with the
> smartreflex driver. Without this the OMAP smartreflex modules
> will not function.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

This one should be a separate patch with a subject something like

     mfd: twl4030: add SmartReflex support

and the changelog should indicate its dependency on this SR/voltage
series.

Kevin

> ---
>  drivers/mfd/twl-core.c      |    7 +++++--
>  drivers/mfd/twl4030-power.c |   29 +++++++++++++++++++++++++++++
>  include/linux/i2c/twl.h     |    1 +
>  3 files changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 720e099..677b903 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -1009,8 +1009,11 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	clocks_init(&client->dev, pdata->clock);
>  
>  	/* load power event scripts */
> -	if (twl_has_power() && pdata->power)
> -		twl4030_power_init(pdata->power);
> +	if (twl_has_power()) {
> +		twl4030_power_sr_init();
> +		 if (pdata->power)
> +			twl4030_power_init(pdata->power);
> +	}
>  
>  	/* Maybe init the T2 Interrupt subsystem */
>  	if (client->irq
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
> index 7efa878..6d0ad2d 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -31,6 +31,8 @@
>  
>  #include <asm/mach-types.h>
>  
> +#include <plat/smartreflex.h>
> +
>  static u8 twl4030_start_script_address = 0x2b;
>  
>  #define PWR_P1_SW_EVENTS	0x10
> @@ -63,6 +65,10 @@ static u8 twl4030_start_script_address = 0x2b;
>  #define R_MEMORY_ADDRESS	PHY_TO_OFF_PM_MASTER(0x59)
>  #define R_MEMORY_DATA		PHY_TO_OFF_PM_MASTER(0x5a)
>  
> +/* Smartreflex Control */
> +#define R_DCDC_GLOBAL_CFG	PHY_TO_OFF_PM_RECEIVER(0x61)
> +#define CFG_ENABLE_SRFLX	0x08
> +
>  #define R_PROTECT_KEY		0x0E
>  #define R_KEY_1			0xC0
>  #define R_KEY_2			0x0C
> @@ -511,6 +517,29 @@ int twl4030_remove_script(u8 flags)
>  	return err;
>  }
>  
> +/* API to enable smrtreflex on Triton side */
> +static void twl4030_smartreflex_init(void)
> +{
> +	int ret = 0;
> +	u8 read_val;
> +
> +	ret = twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &read_val,
> +			R_DCDC_GLOBAL_CFG);
> +	read_val |= CFG_ENABLE_SRFLX;
> +	ret |= twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, read_val,
> +			R_DCDC_GLOBAL_CFG);
> +}
> +
> +struct omap_smartreflex_pmic_data twl4030_sr_data = {
> +	.sr_pmic_init   = twl4030_smartreflex_init,
> +};
> +
> +void __init twl4030_power_sr_init()
> +{
> +	/* Register the SR init API with the Smartreflex driver */
> +	omap_sr_register_pmic(&twl4030_sr_data);
> +}
> +
>  void __init twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
>  {
>  	int err = 0;
> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> index 6de90bf..b02011e 100644
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -550,6 +550,7 @@ struct twl4030_power_data {
>  };
>  
>  extern void twl4030_power_init(struct twl4030_power_data *triton2_scripts);
> +extern void twl4030_power_sr_init(void);
>  extern int twl4030_remove_script(u8 flags);
>  
>  struct twl4030_codec_audio_data {
