From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6 3/3] Input: Add support for tps65217 power button
Date: Sat, 10 Sep 2016 10:50:48 -0700
Message-ID: <20160910175048.GB37109@dtor-ws>
References: <20160909084204.26226-1-m.niestroj@grinn-global.com>
 <20160909084204.26226-4-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160909084204.26226-4-m.niestroj@grinn-global.com>
Sender: linux-pm-owner@vger.kernel.org
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 09, 2016 at 10:42:04AM +0200, Marcin Niestroj wrote:
> This driver enables us to use tps65217's power button as KEY_POWER on
> am335x boards (directly connected button in chiliboard, accessible pin
> via expansion header in beaglebone). This patch has been tested with
> chiliboard.
> 
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> ---
> Depends on patches 1-2 in series and commit
> 47d7d5ed68d877269003a392b7008905d65650bb
> ("power_supply: tps65217-charger: Add support for IRQs")
> in power-supply's -next branch.

Since this dependency is no longer true I went ahead and picked up this
patch.

Thanks.

> 
> Changes v5 -> v6 (suggested by Dmitry):
>  * Use dev_get_regmap() instead of fragile pointer calculations
>  * Keep old formatting for flags as single function argument
> 
> Changes v4 -> v5:
>  * Add support for tps65217 power button in tps65218-pwrbutton driver
>    (as suggested by Dmitry)
>  * Device-tree documentation was combined with tps65218-pwrbutton
> 
> Changes v2 -> v4: none
> 
> Changes v1 -> v2:
>  * Added information about parent device in tps65217 power button
>    device-tree binding documentation (suggested by Rob)
> 
>  .../bindings/input/tps65218-pwrbutton.txt          | 17 +++-
>  drivers/input/misc/Kconfig                         |  4 +-
>  drivers/input/misc/tps65218-pwrbutton.c            | 92 +++++++++++++++-------
>  3 files changed, 81 insertions(+), 32 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt b/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
> index e30e0b9..3e5b979 100644
> --- a/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
> +++ b/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
> @@ -1,13 +1,24 @@
> -Texas Instruments TPS65218 power button
> +Texas Instruments TPS65217 and TPS65218 power button
> +
> +This module is part of the TPS65217/TPS65218. For more details about the whole
> +TPS65217 chip see Documentation/devicetree/bindings/regulator/tps65217.txt.
>  
>  This driver provides a simple power button event via an Interrupt.
>  
>  Required properties:
> -- compatible: should be "ti,tps65218-pwrbutton"
> +- compatible: should be "ti,tps65217-pwrbutton" or "ti,tps65218-pwrbutton"
> +
> +Required properties for TPS65218:
>  - interrupts: should be one of the following
>     - <3 IRQ_TYPE_EDGE_BOTH>: For controllers compatible with tps65218
>  
> -Example:
> +Examples:
> +
> +&tps {
> +	tps65217-pwrbutton {
> +		compatible = "ti,tps65217-pwrbutton";
> +	};
> +};
>  
>  &tps {
>  	power-button {
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index efb0ca8..dbd5b75 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -454,10 +454,10 @@ config INPUT_RETU_PWRBUTTON
>  
>  config INPUT_TPS65218_PWRBUTTON
>  	tristate "TPS65218 Power button driver"
> -	depends on MFD_TPS65218
> +	depends on (MFD_TPS65217 || MFD_TPS65218)
>  	help
>  	  Say Y here if you want to enable power buttong reporting for
> -	  the TPS65218 Power Management IC device.
> +	  TPS65217 and TPS65218 Power Management IC device.
>  
>  	  To compile this driver as a module, choose M here. The module will
>  	  be called tps65218-pwrbutton.
> diff --git a/drivers/input/misc/tps65218-pwrbutton.c b/drivers/input/misc/tps65218-pwrbutton.c
> index a39b626..3273217 100644
> --- a/drivers/input/misc/tps65218-pwrbutton.c
> +++ b/drivers/input/misc/tps65218-pwrbutton.c
> @@ -1,8 +1,9 @@
>  /*
> - * Texas Instruments' TPS65218 Power Button Input Driver
> + * Texas Instruments' TPS65217 and TPS65218 Power Button Input Driver
>   *
>   * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com/
>   * Author: Felipe Balbi <balbi@ti.com>
> + * Author: Marcin Niestroj <m.niestroj@grinn-global.com>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -18,31 +19,61 @@
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> +#include <linux/mfd/tps65217.h>
>  #include <linux/mfd/tps65218.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/slab.h>
>  
> -struct tps65218_pwrbutton {
> +struct tps6521x_data {
> +	unsigned int reg_status;
> +	unsigned int pb_mask;
> +	const char *name;
> +};
> +
> +static const struct tps6521x_data tps65217_data = {
> +	.reg_status = TPS65217_REG_STATUS,
> +	.pb_mask = TPS65217_STATUS_PB,
> +	.name = "tps65217_pwrbutton",
> +};
> +
> +static const struct tps6521x_data tps65218_data = {
> +	.reg_status = TPS65218_REG_STATUS,
> +	.pb_mask = TPS65218_STATUS_PB_STATE,
> +	.name = "tps65218_pwrbutton",
> +};
> +
> +struct tps6521x_pwrbutton {
>  	struct device *dev;
> -	struct tps65218 *tps;
> +	struct regmap *regmap;
>  	struct input_dev *idev;
> +	const struct tps6521x_data *data;
> +	char phys[32];
> +};
> +
> +static const struct of_device_id of_tps6521x_pb_match[] = {
> +	{ .compatible = "ti,tps65217-pwrbutton", .data = &tps65217_data },
> +	{ .compatible = "ti,tps65218-pwrbutton", .data = &tps65218_data },
> +	{ },
>  };
> +MODULE_DEVICE_TABLE(of, of_tps6521x_pb_match);
>  
> -static irqreturn_t tps65218_pwr_irq(int irq, void *_pwr)
> +static irqreturn_t tps6521x_pb_irq(int irq, void *_pwr)
>  {
> -	struct tps65218_pwrbutton *pwr = _pwr;
> +	struct tps6521x_pwrbutton *pwr = _pwr;
> +	const struct tps6521x_data *tps_data = pwr->data;
>  	unsigned int reg;
>  	int error;
>  
> -	error = tps65218_reg_read(pwr->tps, TPS65218_REG_STATUS, &reg);
> +	error = regmap_read(pwr->regmap, tps_data->reg_status, &reg);
>  	if (error) {
>  		dev_err(pwr->dev, "can't read register: %d\n", error);
>  		goto out;
>  	}
>  
> -	if (reg & TPS65218_STATUS_PB_STATE) {
> +	if (reg & tps_data->pb_mask) {
>  		input_report_key(pwr->idev, KEY_POWER, 1);
>  		pm_wakeup_event(pwr->dev, 0);
>  	} else {
> @@ -55,42 +86,55 @@ out:
>  	return IRQ_HANDLED;
>  }
>  
> -static int tps65218_pwron_probe(struct platform_device *pdev)
> +static int tps6521x_pb_probe(struct platform_device *pdev)
>  {
> -	struct tps65218 *tps = dev_get_drvdata(pdev->dev.parent);
>  	struct device *dev = &pdev->dev;
> -	struct tps65218_pwrbutton *pwr;
> +	struct tps6521x_pwrbutton *pwr;
>  	struct input_dev *idev;
> +	const struct of_device_id *match;
>  	int error;
>  	int irq;
>  
> +	match = of_match_node(of_tps6521x_pb_match, pdev->dev.of_node);
> +	if (!match)
> +		return -ENXIO;
> +
>  	pwr = devm_kzalloc(dev, sizeof(*pwr), GFP_KERNEL);
>  	if (!pwr)
>  		return -ENOMEM;
>  
> +	pwr->data = match->data;
> +
>  	idev = devm_input_allocate_device(dev);
>  	if (!idev)
>  		return -ENOMEM;
>  
> -	idev->name = "tps65218_pwrbutton";
> -	idev->phys = "tps65218_pwrbutton/input0";
> +	idev->name = pwr->data->name;
> +	snprintf(pwr->phys, sizeof(pwr->phys), "%s/input0",
> +		pwr->data->name);
> +	idev->phys = pwr->phys;
>  	idev->dev.parent = dev;
>  	idev->id.bustype = BUS_I2C;
>  
>  	input_set_capability(idev, EV_KEY, KEY_POWER);
>  
> -	pwr->tps = tps;
> +	pwr->regmap = dev_get_regmap(pdev->dev.parent, NULL);
>  	pwr->dev = dev;
>  	pwr->idev = idev;
>  	platform_set_drvdata(pdev, pwr);
>  	device_init_wakeup(dev, true);
>  
>  	irq = platform_get_irq(pdev, 0);
> -	error = devm_request_threaded_irq(dev, irq, NULL, tps65218_pwr_irq,
> +	if (irq < 0) {
> +		dev_err(dev, "No IRQ resource!\n");
> +		return -EINVAL;
> +	}
> +
> +	error = devm_request_threaded_irq(dev, irq, NULL, tps6521x_pb_irq,
>  					  IRQF_TRIGGER_RISING |
>  						IRQF_TRIGGER_FALLING |
>  						IRQF_ONESHOT,
> -					  "tps65218-pwrbutton", pwr);
> +					  pwr->data->name, pwr);
>  	if (error) {
>  		dev_err(dev, "failed to request IRQ #%d: %d\n",
>  			irq, error);
> @@ -106,21 +150,15 @@ static int tps65218_pwron_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct of_device_id of_tps65218_pwr_match[] = {
> -	{ .compatible = "ti,tps65218-pwrbutton" },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, of_tps65218_pwr_match);
> -
> -static struct platform_driver tps65218_pwron_driver = {
> -	.probe	= tps65218_pwron_probe,
> +static struct platform_driver tps6521x_pb_driver = {
> +	.probe	= tps6521x_pb_probe,
>  	.driver	= {
> -		.name	= "tps65218_pwrbutton",
> -		.of_match_table = of_tps65218_pwr_match,
> +		.name	= "tps6521x_pwrbutton",
> +		.of_match_table = of_tps6521x_pb_match,
>  	},
>  };
> -module_platform_driver(tps65218_pwron_driver);
> +module_platform_driver(tps6521x_pb_driver);
>  
> -MODULE_DESCRIPTION("TPS65218 Power Button");
> +MODULE_DESCRIPTION("TPS6521X Power Button");
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
> -- 
> 2.9.3
> 

-- 
Dmitry
