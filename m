From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v4 3/3] gpio: lp873x: Add support for General Purpose Outputs
Date: Wed, 29 Jun 2016 15:00:04 +0530
Message-ID: <1467192604-29149-4-git-send-email-j-keerthy@ti.com>
References: <1467192604-29149-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467192604-29149-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com, lee.jones@linaro.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org, robh+dt@kernel.org, j-keerthy@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Add driver for lp873x PMIC family GPOs. Two GPOs are supported
and can be configured in Open-drain output or Push-pull output.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/gpio/Kconfig       |  10 +++
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-lp873x.c | 188 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 199 insertions(+)
 create mode 100644 drivers/gpio/gpio-lp873x.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d35a382..2fb99cb 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -871,6 +871,16 @@ config GPIO_LP3943
 	  LP3943 can be used as a GPIO expander which provides up to 16 GPIOs.
 	  Open drain outputs are required for this usage.
 
+config GPIO_LP873X
+	tristate "TI LP873X GPO"
+	depends on MFD_LP873X
+	help
+	  This driver supports the GPO on TI Lp873x PMICs. 2 GPOs are present
+	  on LP873X PMICs.
+
+	  This driver can also be built as a module. If so, the module will be
+          called gpio-lp873x.
+
 config GPIO_MAX77620
 	tristate "GPIO support for PMIC MAX77620 and MAX20024"
 	depends on MFD_MAX77620
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 6e111fc..f73df0a 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_GPIO_LOONGSON)	+= gpio-loongson.o
 obj-$(CONFIG_GPIO_LP3943)	+= gpio-lp3943.o
 obj-$(CONFIG_GPIO_LPC18XX)	+= gpio-lpc18xx.o
 obj-$(CONFIG_ARCH_LPC32XX)	+= gpio-lpc32xx.o
+obj-$(CONFIG_GPIO_LP873X)	+= gpio-lp873x.o
 obj-$(CONFIG_GPIO_LYNXPOINT)	+= gpio-lynxpoint.o
 obj-$(CONFIG_GPIO_MAX730X)	+= gpio-max730x.o
 obj-$(CONFIG_GPIO_MAX7300)	+= gpio-max7300.o
diff --git a/drivers/gpio/gpio-lp873x.c b/drivers/gpio/gpio-lp873x.c
new file mode 100644
index 0000000..f1b0389
--- /dev/null
+++ b/drivers/gpio/gpio-lp873x.c
@@ -0,0 +1,188 @@
+/*
+ * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
+ *	Keerthy <j-keerthy@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether expressed or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License version 2 for more details.
+ *
+ * Based on the TPS65218 driver
+ */
+
+#include <linux/gpio.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <linux/mfd/lp873x.h>
+
+struct lp873x_gpio {
+	struct gpio_chip chip;
+	struct lp873x *lp873;
+};
+
+static int lp873x_gpio_get_direction(struct gpio_chip *chip,
+				     unsigned int offset)
+{
+	/* This device is output only */
+	return 0;
+}
+
+static int lp873x_gpio_direction_input(struct gpio_chip *chip,
+				       unsigned int offset)
+{
+	/* This device is output only */
+	return -EINVAL;
+}
+
+static int lp873x_gpio_direction_output(struct gpio_chip *chip,
+					unsigned int offset, int value)
+{
+	struct lp873x_gpio *gpio = gpiochip_get_data(chip);
+
+	/* Set the initial value */
+	regmap_update_bits(gpio->lp873->regmap, LP873X_REG_GPO_CTRL,
+			   BIT(offset * 4), value ? BIT(offset * 4) : 0);
+
+	return 0;
+}
+
+static int lp873x_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct lp873x_gpio *gpio = gpiochip_get_data(chip);
+	int ret, val;
+
+	ret = regmap_read(gpio->lp873->regmap, LP873X_REG_GPO_CTRL, &val);
+	if (ret < 0)
+		return ret;
+
+	return val & BIT(offset * 4);
+}
+
+static void lp873x_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			    int value)
+{
+	struct lp873x_gpio *gpio = gpiochip_get_data(chip);
+
+	regmap_update_bits(gpio->lp873->regmap, LP873X_REG_GPO_CTRL,
+			   BIT(offset * 4), value ? BIT(offset * 4) : 0);
+}
+
+static int lp873x_gpio_request(struct gpio_chip *gc, unsigned int offset)
+{
+	struct lp873x_gpio *gpio = gpiochip_get_data(gc);
+	int ret;
+
+	switch (offset) {
+	case 0:
+		/* No MUX Set up Needed for GPO */
+		break;
+	case 1:
+		/* Setup the CLKIN_PIN_SEL MUX to GPO2 */
+		ret = regmap_update_bits(gpio->lp873->regmap, LP873X_REG_CONFIG,
+					 LP873X_CONFIG_CLKIN_PIN_SEL, 0);
+		if (ret)
+			return ret;
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+
+static int lp873x_gpio_set_single_ended(struct gpio_chip *gc,
+					unsigned int offset,
+					enum single_ended_mode mode)
+{
+	struct lp873x_gpio *gpio = gpiochip_get_data(gc);
+
+	switch (mode) {
+	case LINE_MODE_OPEN_DRAIN:
+		return regmap_update_bits(gpio->lp873->regmap,
+					  LP873X_REG_GPO_CTRL,
+					  BIT(offset * 4 + 2),
+					  BIT(offset * 4 + 2));
+	case LINE_MODE_PUSH_PULL:
+		return regmap_update_bits(gpio->lp873->regmap,
+					  LP873X_REG_GPO_CTRL,
+					  BIT(offset * 4 + 2), 0);
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static struct gpio_chip template_chip = {
+	.label			= "lp873x-gpio",
+	.owner			= THIS_MODULE,
+	.request		= lp873x_gpio_request,
+	.get_direction		= lp873x_gpio_get_direction,
+	.direction_input	= lp873x_gpio_direction_input,
+	.direction_output	= lp873x_gpio_direction_output,
+	.get			= lp873x_gpio_get,
+	.set			= lp873x_gpio_set,
+	.set_single_ended	= lp873x_gpio_set_single_ended,
+	.base			= -1,
+	.ngpio			= 2,
+	.can_sleep		= true,
+};
+
+static int lp873x_gpio_probe(struct platform_device *pdev)
+{
+	struct lp873x_gpio *gpio;
+	int ret;
+
+	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
+	if (!gpio)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, gpio);
+
+	gpio->lp873 = dev_get_drvdata(pdev->dev.parent);
+	gpio->chip = template_chip;
+	gpio->chip.parent = gpio->lp873->dev;
+
+	ret = gpiochip_add_data(&gpio->chip, gpio);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Could not register gpiochip, %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int lp873x_gpio_remove(struct platform_device *pdev)
+{
+	struct lp873x_gpio *gpio = platform_get_drvdata(pdev);
+
+	gpiochip_remove(&gpio->chip);
+
+	return 0;
+}
+
+static const struct platform_device_id lp873x_gpio_id_table[] = {
+	{ "lp873x-gpio", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, lp873x_gpio_id_table);
+
+static struct platform_driver lp873x_gpio_driver = {
+	.driver = {
+		.name = "lp873x-gpio",
+	},
+	.probe = lp873x_gpio_probe,
+	.remove = lp873x_gpio_remove,
+	.id_table = lp873x_gpio_id_table,
+};
+module_platform_driver(lp873x_gpio_driver);
+
+MODULE_AUTHOR("Keerthy <j-keerthy@ti.com>");
+MODULE_DESCRIPTION("LP873X GPIO driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
