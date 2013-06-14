From: Graeme Gregory <gg@slimlogic.co.uk>
Subject: Re: [PATCH] mfd: Palmas: Introduce features to select the
 appropriate modules present in the palmas variant
Date: Fri, 14 Jun 2013 10:55:54 +0100
Message-ID: <20130614095554.GF5456@mint>
References: <1371201718-15101-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.xora.org.uk ([80.68.91.202]:46554 "EHLO
	xora.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab3FNJz4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jun 2013 05:55:56 -0400
Content-Disposition: inline
In-Reply-To: <1371201718-15101-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: J Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, ldewangan@nvidia.com, sameo@linux.intel.com

On Fri, Jun 14, 2013 at 02:51:58PM +0530, J Keerthy wrote:
> Introduce features to select the appropriate sub-modules present in the palmas
> variants. This adds the major features present in palmas family of PMICs.
> 
> Boot tested on OMAP5 uevm board.
> Signed-off-by: J Keerthy <j-keerthy@ti.com>
> ---
>  drivers/mfd/palmas.c       |   83 ++++++++++++++++++++++++++++++++++----------
>  include/linux/mfd/palmas.h |   55 +++++++++++++++++++++++++++++
>  2 files changed, 119 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
> index 53e9fe6..0ca5854 100644
> --- a/drivers/mfd/palmas.c
> +++ b/drivers/mfd/palmas.c
> @@ -302,6 +302,27 @@ static void palmas_dt_to_pdata(struct i2c_client *i2c,
>  		palmas_set_pdata_irq_flag(i2c, pdata);
>  }
>  
> +static unsigned int palmas_features = PALMAS_PMIC_FEATURE_WATCHDOG |
> +					PALMAS_PMIC_FEATURE_REGULATORS |
> +					PALMAS_PMIC_FEATURE_BACKUP_BATTERY |
> +					PALMAS_PMIC_FEATURE_32K_CLK |
> +					PALMAS_PMIC_FEATURE_RTC |
> +					PALMAS_PMIC_FEATURE_GPADC |
> +					PALMAS_PMIC_FEATURE_USB_OTG |
> +					PALMAS_PMIC_FEATURE_CHARGER_DETECT |
> +					PALMAS_PMIC_FEATURE_GPIO |
> +					PALMAS_PMIC_FEATURE_PWM_LED |
> +					PALMAS_PMIC_FEATURE_INTERRUPT |
> +					PALMAS_PMIC_FEATURE_SMPS10_BOOST;
> +
> +static const struct of_device_id of_palmas_match_tbl[] = {
> +	{
> +		.compatible = "ti,palmas",
> +		.data = &palmas_features,
> +	},
> +	{ },
> +};
> +
>  static int palmas_i2c_probe(struct i2c_client *i2c,
>  			    const struct i2c_device_id *id)
>  {
> @@ -309,9 +330,10 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
>  	struct palmas_platform_data *pdata;
>  	struct device_node *node = i2c->dev.of_node;
>  	int ret = 0, i;
> -	unsigned int reg, addr;
> +	unsigned int reg, addr, *features;
>  	int slave;
>  	struct mfd_cell *children;
> +	const struct of_device_id *match;
>  
>  	pdata = dev_get_platdata(&i2c->dev);
>  
> @@ -333,9 +355,17 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
>  
>  	i2c_set_clientdata(i2c, palmas);
>  	palmas->dev = &i2c->dev;
> -	palmas->id = id->driver_data;
>  	palmas->irq = i2c->irq;
>  
> +	match = of_match_device(of_match_ptr(of_palmas_match_tbl), &i2c->dev);
> +
> +	if (match) {
> +		features = (unsigned int *)match->data;
> +		palmas->features = *features;
> +	} else {
> +		return -ENODATA;
> +	}
> +
>  	for (i = 0; i < PALMAS_NUM_CLIENTS; i++) {
>  		if (i == 0)
>  			palmas->i2c_clients[i] = i2c;
> @@ -362,6 +392,9 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
>  		}
>  	}
>  
> +	if (!PALMAS_PMIC_HAS(palmas, INTERRUPT))
> +		goto no_int;
> +
>  	/* Change interrupt line output polarity */
>  	if (pdata->irq_flags & IRQ_TYPE_LEVEL_HIGH)
>  		reg = PALMAS_POLARITY_CTRL_INT_POLARITY;
> @@ -388,6 +421,10 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
>  	if (ret < 0)
>  		goto err;
>  
> +no_int:
> +	if (!PALMAS_PMIC_HAS(palmas, GPIO))
> +		goto no_gpio;
> +
>  	slave = PALMAS_BASE_TO_SLAVE(PALMAS_PU_PD_OD_BASE);
>  	addr = PALMAS_BASE_TO_REG(PALMAS_PU_PD_OD_BASE,
>  			PALMAS_PRIMARY_SECONDARY_PAD1);
> @@ -459,7 +496,7 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
>  	ret = regmap_write(palmas->regmap[slave], addr, reg);
>  	if (ret)
>  		goto err_irq;
> -
> +no_gpio:
>  	/*
>  	 * If we are probing with DT do this the DT way and return here
>  	 * otherwise continue and add devices using mfd helpers.
> @@ -479,21 +516,34 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
>  		goto err_irq;
>  	}
>  
> -	children[PALMAS_PMIC_ID].platform_data = pdata->pmic_pdata;
> -	children[PALMAS_PMIC_ID].pdata_size = sizeof(*pdata->pmic_pdata);
> +	if (PALMAS_PMIC_HAS(palmas, REGULATORS)) {
> +		children[PALMAS_PMIC_ID].platform_data = pdata->pmic_pdata;
> +		children[PALMAS_PMIC_ID].pdata_size =
> +				sizeof(*pdata->pmic_pdata);
> +	}
>  

I think a lot of complexity here could actually be removed by removing the
old board file style probing for palmas. I do not beleive either major user
of palmas requires that anymore? I always had in my mind that this bit
was temporary.

> -	children[PALMAS_GPADC_ID].platform_data = pdata->gpadc_pdata;
> -	children[PALMAS_GPADC_ID].pdata_size = sizeof(*pdata->gpadc_pdata);
> +	if (PALMAS_PMIC_HAS(palmas, GPADC)) {
> +		children[PALMAS_GPADC_ID].platform_data = pdata->gpadc_pdata;
> +		children[PALMAS_GPADC_ID].pdata_size =
> +				sizeof(*pdata->gpadc_pdata);
> +	}
>  
> -	children[PALMAS_RESOURCE_ID].platform_data = pdata->resource_pdata;
> -	children[PALMAS_RESOURCE_ID].pdata_size =
> -			sizeof(*pdata->resource_pdata);
> +	if (PALMAS_PMIC_HAS(palmas, RESOURCE)) {
> +		children[PALMAS_RESOURCE_ID].platform_data =
> +				pdata->resource_pdata;
> +		children[PALMAS_RESOURCE_ID].pdata_size =
> +				sizeof(*pdata->resource_pdata);
> +	}
>  
> -	children[PALMAS_USB_ID].platform_data = pdata->usb_pdata;
> -	children[PALMAS_USB_ID].pdata_size = sizeof(*pdata->usb_pdata);
> +	if (PALMAS_PMIC_HAS(palmas, USB_OTG)) {
> +		children[PALMAS_USB_ID].platform_data = pdata->usb_pdata;
> +		children[PALMAS_USB_ID].pdata_size = sizeof(*pdata->usb_pdata);
> +	}
>  
> -	children[PALMAS_CLK_ID].platform_data = pdata->clk_pdata;
> -	children[PALMAS_CLK_ID].pdata_size = sizeof(*pdata->clk_pdata);
> +	if (PALMAS_PMIC_HAS(palmas, 32K_CLK)) {
> +		children[PALMAS_CLK_ID].platform_data = pdata->clk_pdata;
> +		children[PALMAS_CLK_ID].pdata_size = sizeof(*pdata->clk_pdata);
> +	}
>  
>  	ret = mfd_add_devices(palmas->dev, -1,
>  			      children, ARRAY_SIZE(palmas_children),
> @@ -533,11 +583,6 @@ static const struct i2c_device_id palmas_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, palmas_i2c_id);
>  
> -static struct of_device_id of_palmas_match_tbl[] = {
> -	{ .compatible = "ti,palmas", },
> -	{ /* end */ }
> -};
> -
>  static struct i2c_driver palmas_i2c_driver = {
>  	.driver = {
>  		   .name = "palmas",
> diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
> index 8f21daf..cc437a0 100644
> --- a/include/linux/mfd/palmas.h
> +++ b/include/linux/mfd/palmas.h
> @@ -32,6 +32,60 @@
>  			((a) == PALMAS_CHIP_ID))
>  #define is_palmas_charger(a) ((a) == PALMAS_CHIP_CHARGER_ID)
>  
> +/**
> + * DOC: Palmas PMIC feature types
> + *
> + * PALMAS_PMIC_FEATURE_WATCHDOG - used when the PMIC has a built-in
> + *	Watchdog timer.
> + *
> + * PALMAS_PMIC_FEATURE_REGULATORS - used when PMIC has voltage
> + *	regulators(SMPSs and LDOs).
> + *
> + * PALMAS_PMIC_FEATURE_BACKUP_BATTERY - used when the PMIC has back-up battery.
> + *
> + * PALMAS_PMIC_FEATURE_32K_CLK - used when PMIC provides a 32K clock.
> + *
> + * PALMAS_PMIC_FEATURE_RTC - used when the PMIC provides an RTC.
> + *
> + * PALMAS_PMIC_FEATURE_GPADC - used when the PMIC provides a general purpose
> + *	ADC.
> + *
> + * PALMAS_PMIC_FEATURE_USB_OTG - used when the PMIC provides USB OTG.
> + *
> + * PALMAS_PMIC_FEATURE_CHARGER_DETECT - used when the PMIC has charger
> + *	detection ability.
> + *
> + * PALMAS_PMIC_FEATURE_GPIO - used when the PMIC has GPIOs
> + *
> + * PALMAS_PMIC_FEATURE_PWM_LED - used when the PMIC has PWM and LED.
> + *
> + * PALMAS_PMIC_FEATURE_INTERRUPT - used when the PMIC has Interrupt line going
> + *	to an application processor.
> + *
> + * PALMAS_PMIC_FEATURE_SMPS10_BOOST - used when the PMIC provides SMPS10 boost
> + *	voltage supply.
> + *
> + * PALMAS_PMIC_FEATURE_RESOURCE - used when the PMIC has resources like REGEN1.
> + *
> + * PALMAS_PMIC_HAS(b, f) - macro to check if a bandgap device is capable of a
> + *	specific feature (above) or not. Return non-zero, if yes.
> + */
> +#define PALMAS_PMIC_FEATURE_WATCHDOG		BIT(0)
> +#define PALMAS_PMIC_FEATURE_REGULATORS		BIT(1)
> +#define PALMAS_PMIC_FEATURE_BACKUP_BATTERY		BIT(2)
> +#define PALMAS_PMIC_FEATURE_32K_CLK		BIT(3)
> +#define PALMAS_PMIC_FEATURE_RTC		BIT(4)
> +#define PALMAS_PMIC_FEATURE_GPADC		BIT(5)
> +#define PALMAS_PMIC_FEATURE_USB_OTG		BIT(6)
> +#define PALMAS_PMIC_FEATURE_CHARGER_DETECT		BIT(7)
> +#define PALMAS_PMIC_FEATURE_GPIO	BIT(8)
> +#define PALMAS_PMIC_FEATURE_PWM_LED	BIT(9)
> +#define PALMAS_PMIC_FEATURE_INTERRUPT	BIT(10)
> +#define PALMAS_PMIC_FEATURE_SMPS10_BOOST	BIT(11)
> +#define PALMAS_PMIC_FEATURE_RESOURCE        BIT(12)
> +#define PALMAS_PMIC_HAS(b, f)			\
> +			((b)->features & PALMAS_PMIC_FEATURE_ ## f)
> +
>  struct palmas_pmic;
>  struct palmas_gpadc;
>  struct palmas_resource;
> @@ -46,6 +100,7 @@ struct palmas {
>  	/* Stored chip id */
>  	int id;
>  
> +	unsigned int features;
>  	/* IRQ Data */
>  	int irq;
>  	u32 irq_mask;
> -- 
> 1.7.5.4
> 
