From: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Subject: Re: [RESEND PATCH v4 3/3] Input: Add tps65217 power button driver
Date: Wed, 7 Sep 2016 13:42:41 +0200
Message-ID: <e24c9dc1-0e7a-0cc1-8f25-521034f09bc8@grinn-global.com>
References: <20160902103526.5050-1-m.niestroj@grinn-global.com>
 <20160902103526.5050-4-m.niestroj@grinn-global.com>
 <20160903175321.GC32345@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160903175321.GC32345@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 03.09.2016 19:53, Dmitry Torokhov wrote:
> On Fri, Sep 02, 2016 at 12:35:26PM +0200, Marcin Niestroj wrote:
>> This driver enables us to use tps65217's power button as KEY_POWER on
>> am335x boards (directly connected button in chiliboard, accessible pin
>> via expansion header in beaglebone). This patch has been tested with
>> chiliboard.
>>
>> Signed-off-by: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
>> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>
> Was it produces by soing s/65218/65217 over
> drivers/input/misc/tps65217-pwrbutton.c? I honestly can't see much
> difference between the 2. Can they be probably be combined?

I didn't think of that earlier. Below is a patch that adds support for
tps65217 power button in tps65218-pwrbutton.c. Is this approach ok for
you? If yes, I will send new patch version with it.

Additionally I guess the file should be renamed to tps6521x-pwrbutton.c
and config option changed to CONFIG_INPUT_TPS6521X_PWRBUTTON?

diff --git a/drivers/input/misc/tps65218-pwrbutton.c 
b/drivers/input/misc/tps65218-pwrbutton.c
index a39b626..19d2bb1 100644
--- a/drivers/input/misc/tps65218-pwrbutton.c
+++ b/drivers/input/misc/tps65218-pwrbutton.c
@@ -1,8 +1,9 @@
  /*
- * Texas Instruments' TPS65218 Power Button Input Driver
+ * Texas Instruments' TPS65217 and TPS65218 Power Button Input Driver
   *
   * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com/
   * Author: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
+ * Author: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
   *
   * This program is free software; you can redistribute it and/or modify
   * it under the terms of the GNU General Public License version 2 as
@@ -18,31 +19,73 @@
  #include <linux/input.h>
  #include <linux/interrupt.h>
  #include <linux/kernel.h>
+#include <linux/mfd/tps65217.h>
  #include <linux/mfd/tps65218.h>
  #include <linux/module.h>
  #include <linux/of.h>
  #include <linux/platform_device.h>
  #include <linux/slab.h>

-struct tps65218_pwrbutton {
+struct tps6521x_data {
+	unsigned int reg_status;
+	unsigned int pb_mask;
+	const char *name;
+};
+
+static const struct tps6521x_data tps65217_data = {
+	.reg_status = TPS65217_REG_STATUS,
+	.pb_mask = TPS65217_STATUS_PB,
+	.name = "tps65217_pwrbutton",
+};
+
+static const struct tps6521x_data tps65218_data = {
+	.reg_status = TPS65218_REG_STATUS,
+	.pb_mask = TPS65218_STATUS_PB_STATE,
+	.name = "tps65218_pwrbutton",
+};
+
+struct tps6521x_pwrbutton {
  	struct device *dev;
-	struct tps65218 *tps;
+	void *tps;
  	struct input_dev *idev;
+	const struct tps6521x_data *data;
+	char phys[32];
  };

-static irqreturn_t tps65218_pwr_irq(int irq, void *_pwr)
+static const struct of_device_id of_tps6521x_pwr_match[] = {
+	{ .compatible = "ti,tps65217-pwrbutton", .data = &tps65217_data },
+	{ .compatible = "ti,tps65218-pwrbutton", .data = &tps65218_data },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, of_tps6521x_pwr_match);
+
+static int tps6521x_reg_read(struct tps6521x_pwrbutton *pwr, unsigned 
int reg,
+		unsigned int *val)
  {
-	struct tps65218_pwrbutton *pwr = _pwr;
+	if (pwr->data == &tps65217_data)
+		return tps65217_reg_read((struct tps65217 *) pwr->tps,
+					reg, val);
+	else if (pwr->data == &tps65218_data)
+		return tps65218_reg_read((struct tps65218 *) pwr->tps,
+					reg, val);
+
+	return -EINVAL;
+}
+
+static irqreturn_t tps6521x_pb_irq(int irq, void *_pwr)
+{
+	struct tps6521x_pwrbutton *pwr = _pwr;
+	const struct tps6521x_data *tps_data = pwr->data;
  	unsigned int reg;
  	int error;

-	error = tps65218_reg_read(pwr->tps, TPS65218_REG_STATUS, &reg);
+	error = tps6521x_reg_read(pwr, tps_data->reg_status, &reg);
  	if (error) {
  		dev_err(pwr->dev, "can't read register: %d\n", error);
  		goto out;
  	}

-	if (reg & TPS65218_STATUS_PB_STATE) {
+	if (reg & tps_data->pb_mask) {
  		input_report_key(pwr->idev, KEY_POWER, 1);
  		pm_wakeup_event(pwr->dev, 0);
  	} else {
@@ -55,25 +98,34 @@ out:
  	return IRQ_HANDLED;
  }

-static int tps65218_pwron_probe(struct platform_device *pdev)
+static int tps6521x_pb_probe(struct platform_device *pdev)
  {
-	struct tps65218 *tps = dev_get_drvdata(pdev->dev.parent);
+	void *tps = dev_get_drvdata(pdev->dev.parent);
  	struct device *dev = &pdev->dev;
-	struct tps65218_pwrbutton *pwr;
+	struct tps6521x_pwrbutton *pwr;
  	struct input_dev *idev;
+	const struct of_device_id *match;
  	int error;
  	int irq;

+	match = of_match_node(of_tps6521x_pwr_match, pdev->dev.of_node);
+	if (!match)
+		return -ENXIO;
+
  	pwr = devm_kzalloc(dev, sizeof(*pwr), GFP_KERNEL);
  	if (!pwr)
  		return -ENOMEM;

+	pwr->data = match->data;
+
  	idev = devm_input_allocate_device(dev);
  	if (!idev)
  		return -ENOMEM;

-	idev->name = "tps65218_pwrbutton";
-	idev->phys = "tps65218_pwrbutton/input0";
+	idev->name = pwr->data->name;
+	snprintf(pwr->phys, sizeof(pwr->phys), "%s/input0",
+		pwr->data->name);
+	idev->phys = pwr->phys;
  	idev->dev.parent = dev;
  	idev->id.bustype = BUS_I2C;

@@ -86,11 +138,16 @@ static int tps65218_pwron_probe(struct 
platform_device *pdev)
  	device_init_wakeup(dev, true);

  	irq = platform_get_irq(pdev, 0);
-	error = devm_request_threaded_irq(dev, irq, NULL, tps65218_pwr_irq,
-					  IRQF_TRIGGER_RISING |
-						IRQF_TRIGGER_FALLING |
-						IRQF_ONESHOT,
-					  "tps65218-pwrbutton", pwr);
+	if (irq < 0) {
+		dev_err(dev, "No IRQ resource!\n");
+		return -EINVAL;
+	}
+
+	error = devm_request_threaded_irq(dev, irq, NULL, tps6521x_pb_irq,
+					IRQF_TRIGGER_RISING |
+					IRQF_TRIGGER_FALLING |
+					IRQF_ONESHOT,
+					pwr->data->name, pwr);
  	if (error) {
  		dev_err(dev, "failed to request IRQ #%d: %d\n",
  			irq, error);
@@ -106,21 +163,15 @@ static int tps65218_pwron_probe(struct 
platform_device *pdev)
  	return 0;
  }

-static const struct of_device_id of_tps65218_pwr_match[] = {
-	{ .compatible = "ti,tps65218-pwrbutton" },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, of_tps65218_pwr_match);
-
-static struct platform_driver tps65218_pwron_driver = {
-	.probe	= tps65218_pwron_probe,
+static struct platform_driver tps6521x_pb_driver = {
+	.probe	= tps6521x_pb_probe,
  	.driver	= {
-		.name	= "tps65218_pwrbutton",
-		.of_match_table = of_tps65218_pwr_match,
+		.name	= "tps6521x_pwrbutton",
+		.of_match_table = of_tps6521x_pwr_match,
  	},
  };
-module_platform_driver(tps65218_pwron_driver);
+module_platform_driver(tps6521x_pb_driver);

-MODULE_DESCRIPTION("TPS65218 Power Button");
+MODULE_DESCRIPTION("TPS6521X Power Button");
  MODULE_LICENSE("GPL v2");
  MODULE_AUTHOR("Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>");


>
> Thanks.
>
>> ---
>> Depends on patches 1-2 in series and commit
>> 47d7d5ed68d877269003a392b7008905d65650bb
>> ("power_supply: tps65217-charger: Add support for IRQs")
>> in power-supply's -next branch.
>>
>> Changes v2 -> v4: none
>>
>> Changes v1 -> v2:
>>  * Added information about parent device in tps65217 power button
>>    device-tree binding documentation (suggested by Rob)
>>
>>  .../bindings/input/tps65217-pwrbutton.txt          |  17 +++
>>  drivers/input/misc/Kconfig                         |  10 ++
>>  drivers/input/misc/Makefile                        |   1 +
>>  drivers/input/misc/tps65217-pwrbutton.c            | 131 +++++++++++++++++++++
>>  4 files changed, 159 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/input/tps65217-pwrbutton.txt
>>  create mode 100644 drivers/input/misc/tps65217-pwrbutton.c
>>
>> diff --git a/Documentation/devicetree/bindings/input/tps65217-pwrbutton.txt b/Documentation/devicetree/bindings/input/tps65217-pwrbutton.txt
>> new file mode 100644
>> index 0000000..d5f5cce
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/tps65217-pwrbutton.txt
>> @@ -0,0 +1,17 @@
>> +Texas Instruments TPS65217 power button
>> +
>> +This module is part of the TPS65217. For more details about the whole
>> +chip see Documentation/devicetree/bindings/regulator/tps65217.txt.
>> +
>> +This module provides a simple power button event via an Interrupt.
>> +
>> +Required properties:
>> +- compatible: should be "ti,tps65217-pwrbutton"
>> +
>> +Example:
>> +
>> +&tps {
>> +	tps65217-pwrbutton {
>> +		compatible = "ti,tps65217-pwrbutton";
>> +	};
>> +};
>> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
>> index efb0ca8..826f62b6 100644
>> --- a/drivers/input/misc/Kconfig
>> +++ b/drivers/input/misc/Kconfig
>> @@ -452,6 +452,16 @@ config INPUT_RETU_PWRBUTTON
>>  	  To compile this driver as a module, choose M here. The module will
>>  	  be called retu-pwrbutton.
>>
>> +config INPUT_TPS65217_PWRBUTTON
>> +	tristate "TPS65217 Power button driver"
>> +	depends on MFD_TPS65217
>> +	help
>> +	  Say Y here if you want to enable power button reporting for
>> +	  the TPS65217 Power Management IC device.
>> +
>> +	  To compile this driver as a module, choose M here. The module will
>> +	  be called tps65217-pwrbutton.
>> +
>>  config INPUT_TPS65218_PWRBUTTON
>>  	tristate "TPS65218 Power button driver"
>>  	depends on MFD_TPS65218
>> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
>> index 6a1e5e2..bb5ac44 100644
>> --- a/drivers/input/misc/Makefile
>> +++ b/drivers/input/misc/Makefile
>> @@ -67,6 +67,7 @@ obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
>>  obj-$(CONFIG_INPUT_SIRFSOC_ONKEY)	+= sirfsoc-onkey.o
>>  obj-$(CONFIG_INPUT_SOC_BUTTON_ARRAY)	+= soc_button_array.o
>>  obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
>> +obj-$(CONFIG_INPUT_TPS65217_PWRBUTTON)	+= tps65217-pwrbutton.o
>>  obj-$(CONFIG_INPUT_TPS65218_PWRBUTTON)	+= tps65218-pwrbutton.o
>>  obj-$(CONFIG_INPUT_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
>>  obj-$(CONFIG_INPUT_TWL4030_VIBRA)	+= twl4030-vibra.o
>> diff --git a/drivers/input/misc/tps65217-pwrbutton.c b/drivers/input/misc/tps65217-pwrbutton.c
>> new file mode 100644
>> index 0000000..50372bf
>> --- /dev/null
>> +++ b/drivers/input/misc/tps65217-pwrbutton.c
>> @@ -0,0 +1,131 @@
>> +/*
>> + * Texas Instruments' TPS65217 Power Button Input Driver
>> + *
>> + * Copyright (C) 2016 Grinn - http://www.grinn-global.com/
>> + * Author: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>> + * kind, whether express or implied; without even the implied warranty
>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/input.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mfd/tps65217.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +
>> +struct tps65217_pwrbutton {
>> +	struct device *dev;
>> +	struct tps65217 *tps;
>> +	struct input_dev *idev;
>> +};
>> +
>> +static irqreturn_t tps65217_pb_irq(int irq, void *data)
>> +{
>> +	struct tps65217_pwrbutton *pwr = data;
>> +	unsigned int reg;
>> +	int error;
>> +
>> +	error = tps65217_reg_read(pwr->tps, TPS65217_REG_STATUS, &reg);
>> +	if (error) {
>> +		dev_err(pwr->dev, "can't read register: %d\n", error);
>> +		goto out;
>> +	}
>> +
>> +	if (reg & TPS65217_STATUS_PB) {
>> +		input_report_key(pwr->idev, KEY_POWER, 1);
>> +		pm_wakeup_event(pwr->dev, 0);
>> +	} else {
>> +		input_report_key(pwr->idev, KEY_POWER, 0);
>> +	}
>> +
>> +	input_sync(pwr->idev);
>> +
>> +out:
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int tps65217_pb_probe(struct platform_device *pdev)
>> +{
>> +	struct tps65217 *tps = dev_get_drvdata(pdev->dev.parent);
>> +	struct device *dev = &pdev->dev;
>> +	struct tps65217_pwrbutton *pwr;
>> +	struct input_dev *idev;
>> +	int error;
>> +	int irq;
>> +
>> +	pwr = devm_kzalloc(dev, sizeof(*pwr), GFP_KERNEL);
>> +	if (!pwr)
>> +		return -ENOMEM;
>> +
>> +	idev = devm_input_allocate_device(dev);
>> +	if (!idev)
>> +		return -ENOMEM;
>> +
>> +	idev->name = "tps65217_pwrbutton";
>> +	idev->phys = "tps65217_pwrbutton/input0";
>> +	idev->dev.parent = dev;
>> +	idev->id.bustype = BUS_I2C;
>> +
>> +	input_set_capability(idev, EV_KEY, KEY_POWER);
>> +
>> +	pwr->tps = tps;
>> +	pwr->dev = dev;
>> +	pwr->idev = idev;
>> +	platform_set_drvdata(pdev, pwr);
>> +	device_init_wakeup(dev, true);
>> +
>> +	irq = platform_get_irq_byname(pdev, "PB");
>> +	if (irq < 0) {
>> +		dev_err(dev, "No IRQ resource!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	error = devm_request_threaded_irq(dev, irq, NULL, tps65217_pb_irq,
>> +					IRQF_TRIGGER_RISING |
>> +					IRQF_TRIGGER_FALLING |
>> +					IRQF_ONESHOT,
>> +					"tps65217-pwrbutton", pwr);
>> +	if (error) {
>> +		dev_err(dev, "failed to request IRQ #%d: %d\n",
>> +			irq, error);
>> +		return error;
>> +	}
>> +
>> +	error = input_register_device(idev);
>> +	if (error) {
>> +		dev_err(dev, "Can't register power button: %d\n", error);
>> +		return error;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id tps65217_pb_match[] = {
>> +	{ .compatible = "ti,tps65217-pwrbutton" },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, tps65217_pb_match);
>> +
>> +static struct platform_driver tps65217_pb_driver = {
>> +	.probe	= tps65217_pb_probe,
>> +	.driver	= {
>> +		.name	= "tps65217-pwrbutton",
>> +		.of_match_table = tps65217_pb_match,
>> +	},
>> +};
>> +module_platform_driver(tps65217_pb_driver);
>> +
>> +MODULE_DESCRIPTION("TPS65217 Power Button");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_AUTHOR("Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>");
>> --
>> 2.9.3
>>
>

-- 
Marcin Niestroj
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
