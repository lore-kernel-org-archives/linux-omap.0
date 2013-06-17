From: Graeme Gregory <gg@slimlogic.co.uk>
Subject: Re: [PATCH] mfd: Palmas: Remove code which is not necessary for a
 device tree boot
Date: Mon, 17 Jun 2013 07:18:15 +0100
Message-ID: <20130617061815.GI19403@mint>
References: <1371447962-9092-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.xora.org.uk ([80.68.91.202]:52647 "EHLO
	xora.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755584Ab3FQGST (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jun 2013 02:18:19 -0400
Content-Disposition: inline
In-Reply-To: <1371447962-9092-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: J Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, ldewangan@nvidia.com, sameo@linux.intel.com

On Mon, Jun 17, 2013 at 11:16:02AM +0530, J Keerthy wrote:
> Remove code which is not necessary for a device tree boot.
> 
> Boot tested on OMAP5-UEVM board.
> 
> Signed-off-by: J Keerthy <j-keerthy@ti.com>

This looks good to me!

Acked-by: Graeme Gregory <gg@slimlogic.co.uk>

> ---
>  drivers/mfd/palmas.c |  106 --------------------------------------------------
>  1 files changed, 0 insertions(+), 106 deletions(-)
> 
> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
> index 53e9fe6..62fa728 100644
> --- a/drivers/mfd/palmas.c
> +++ b/drivers/mfd/palmas.c
> @@ -25,77 +25,6 @@
>  #include <linux/mfd/palmas.h>
>  #include <linux/of_platform.h>
>  
> -enum palmas_ids {
> -	PALMAS_PMIC_ID,
> -	PALMAS_GPIO_ID,
> -	PALMAS_LEDS_ID,
> -	PALMAS_WDT_ID,
> -	PALMAS_RTC_ID,
> -	PALMAS_PWRBUTTON_ID,
> -	PALMAS_GPADC_ID,
> -	PALMAS_RESOURCE_ID,
> -	PALMAS_CLK_ID,
> -	PALMAS_PWM_ID,
> -	PALMAS_USB_ID,
> -};
> -
> -static struct resource palmas_rtc_resources[] = {
> -	{
> -		.start  = PALMAS_RTC_ALARM_IRQ,
> -		.end    = PALMAS_RTC_ALARM_IRQ,
> -		.flags  = IORESOURCE_IRQ,
> -	},
> -};
> -
> -static const struct mfd_cell palmas_children[] = {
> -	{
> -		.name = "palmas-pmic",
> -		.id = PALMAS_PMIC_ID,
> -	},
> -	{
> -		.name = "palmas-gpio",
> -		.id = PALMAS_GPIO_ID,
> -	},
> -	{
> -		.name = "palmas-leds",
> -		.id = PALMAS_LEDS_ID,
> -	},
> -	{
> -		.name = "palmas-wdt",
> -		.id = PALMAS_WDT_ID,
> -	},
> -	{
> -		.name = "palmas-rtc",
> -		.id = PALMAS_RTC_ID,
> -		.resources = &palmas_rtc_resources[0],
> -		.num_resources = ARRAY_SIZE(palmas_rtc_resources),
> -	},
> -	{
> -		.name = "palmas-pwrbutton",
> -		.id = PALMAS_PWRBUTTON_ID,
> -	},
> -	{
> -		.name = "palmas-gpadc",
> -		.id = PALMAS_GPADC_ID,
> -	},
> -	{
> -		.name = "palmas-resource",
> -		.id = PALMAS_RESOURCE_ID,
> -	},
> -	{
> -		.name = "palmas-clk",
> -		.id = PALMAS_CLK_ID,
> -	},
> -	{
> -		.name = "palmas-pwm",
> -		.id = PALMAS_PWM_ID,
> -	},
> -	{
> -		.name = "palmas-usb",
> -		.id = PALMAS_USB_ID,
> -	}
> -};
> -
>  static const struct regmap_config palmas_regmap_config[PALMAS_NUM_CLIENTS] = {
>  	{
>  		.reg_bits = 8,
> @@ -311,7 +240,6 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
>  	int ret = 0, i;
>  	unsigned int reg, addr;
>  	int slave;
> -	struct mfd_cell *children;
>  
>  	pdata = dev_get_platdata(&i2c->dev);
>  
> @@ -472,42 +400,8 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
>  			return ret;
>  	}
>  
> -	children = kmemdup(palmas_children, sizeof(palmas_children),
> -			   GFP_KERNEL);
> -	if (!children) {
> -		ret = -ENOMEM;
> -		goto err_irq;
> -	}
> -
> -	children[PALMAS_PMIC_ID].platform_data = pdata->pmic_pdata;
> -	children[PALMAS_PMIC_ID].pdata_size = sizeof(*pdata->pmic_pdata);
> -
> -	children[PALMAS_GPADC_ID].platform_data = pdata->gpadc_pdata;
> -	children[PALMAS_GPADC_ID].pdata_size = sizeof(*pdata->gpadc_pdata);
> -
> -	children[PALMAS_RESOURCE_ID].platform_data = pdata->resource_pdata;
> -	children[PALMAS_RESOURCE_ID].pdata_size =
> -			sizeof(*pdata->resource_pdata);
> -
> -	children[PALMAS_USB_ID].platform_data = pdata->usb_pdata;
> -	children[PALMAS_USB_ID].pdata_size = sizeof(*pdata->usb_pdata);
> -
> -	children[PALMAS_CLK_ID].platform_data = pdata->clk_pdata;
> -	children[PALMAS_CLK_ID].pdata_size = sizeof(*pdata->clk_pdata);
> -
> -	ret = mfd_add_devices(palmas->dev, -1,
> -			      children, ARRAY_SIZE(palmas_children),
> -			      NULL, 0,
> -			      regmap_irq_get_domain(palmas->irq_data));
> -	kfree(children);
> -
> -	if (ret < 0)
> -		goto err_devices;
> -
>  	return ret;
>  
> -err_devices:
> -	mfd_remove_devices(palmas->dev);
>  err_irq:
>  	regmap_del_irq_chip(palmas->irq, palmas->irq_data);
>  err:
> -- 
> 1.7.5.4
> 
