From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2] gpio: lp87565: Add support for GPIO
Date: Thu, 15 Jun 2017 12:03:11 +0530
Message-ID: <1497508391-2806-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linus.walleij@linaro.org
Cc: j-keerthy@ti.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

Add driver for lp87565 PMIC family GPIOs. Three GPIOs are supported
and can be configured in Open-drain output or Push-pull output.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Latest version of mfd patch:

https://patchwork.kernel.org/patch/9783079/

Changes in v2:

  * included <linux/gpio/driver.h>
  * stored the struct regmap *map instead of whole lp87565 struct
  * clamped return values to [0,1] where necessary.
  * Added more comments to explain the 2 modes.
  * platform_set_drvdata(pdev, gpio)

 drivers/gpio/Kconfig        |  10 +++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-lp87565.c | 190 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+)
 create mode 100644 drivers/gpio/gpio-lp87565.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 2e7d9ff..f235eae 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -965,6 +965,16 @@ config GPIO_LP873X
 	  This driver can also be built as a module. If so, the module will be
           called gpio-lp873x.
 
+config GPIO_LP87565
+	tristate "TI LP87565 GPIO"
+	depends on MFD_TI_LP87565
+	help
+	  This driver supports the GPIO on TI Lp873565 PMICs. 3 GPIOs are present
+	  on LP87565 PMICs.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called gpio-lp87565.
+
 config GPIO_MAX77620
 	tristate "GPIO support for PMIC MAX77620 and MAX20024"
 	depends on MFD_MAX77620
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index bcd0a0b..a9fda6c 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_GPIO_LP3943)	+= gpio-lp3943.o
 obj-$(CONFIG_GPIO_LPC18XX)	+= gpio-lpc18xx.o
 obj-$(CONFIG_ARCH_LPC32XX)	+= gpio-lpc32xx.o
 obj-$(CONFIG_GPIO_LP873X)	+= gpio-lp873x.o
+obj-$(CONFIG_GPIO_LP87565)	+= gpio-lp87565.o
 obj-$(CONFIG_GPIO_LYNXPOINT)	+= gpio-lynxpoint.o
 obj-$(CONFIG_GPIO_MAX730X)	+= gpio-max730x.o
 obj-$(CONFIG_GPIO_MAX7300)	+= gpio-max7300.o
diff --git a/drivers/gpio/gpio-lp87565.c b/drivers/gpio/gpio-lp87565.c
new file mode 100644
index 0000000..6313c50
--- /dev/null
+++ b/drivers/gpio/gpio-lp87565.c
@@ -0,0 +1,190 @@
+/*
+ * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
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
+ * Based on the LP873X driver
+ */
+
+#include <linux/gpio/driver.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <linux/mfd/lp87565.h>
+
+struct lp87565_gpio {
+	struct gpio_chip chip;
+	struct regmap *map;
+};
+
+static int lp87565_gpio_get_direction(struct gpio_chip *chip,
+				      unsigned int offset)
+{
+	struct lp87565_gpio *gpio = gpiochip_get_data(chip);
+	int ret, val;
+
+	ret = regmap_read(gpio->map, LP87565_REG_GPIO_CONFIG, &val);
+	if (ret < 0)
+		return ret;
+
+	return !(val & BIT(offset));
+}
+
+static int lp87565_gpio_direction_input(struct gpio_chip *chip,
+					unsigned int offset)
+{
+	struct lp87565_gpio *gpio = gpiochip_get_data(chip);
+
+	return regmap_update_bits(gpio->map,
+				  LP87565_REG_GPIO_CONFIG,
+				  BIT(offset), 0);
+}
+
+static int lp87565_gpio_direction_output(struct gpio_chip *chip,
+					 unsigned int offset, int value)
+{
+	struct lp87565_gpio *gpio = gpiochip_get_data(chip);
+
+	return regmap_update_bits(gpio->map,
+				  LP87565_REG_GPIO_CONFIG,
+				  BIT(offset), !value ? BIT(offset) : 0);
+}
+
+static int lp87565_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct lp87565_gpio *gpio = gpiochip_get_data(chip);
+	int ret, val;
+
+	ret = regmap_read(gpio->map, LP87565_REG_GPIO_IN, &val);
+	if (ret < 0)
+		return ret;
+
+	return !!(val & BIT(offset));
+}
+
+static void lp87565_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			     int value)
+{
+	struct lp87565_gpio *gpio = gpiochip_get_data(chip);
+
+	regmap_update_bits(gpio->map, LP87565_REG_GPIO_OUT,
+			   BIT(offset), value ? BIT(offset) : 0);
+}
+
+static int lp87565_gpio_request(struct gpio_chip *gc, unsigned int offset)
+{
+	struct lp87565_gpio *gpio = gpiochip_get_data(gc);
+	int ret;
+
+	switch (offset) {
+	case 0:
+	case 1:
+	case 2:
+		/*
+		 * MUX can program the pin to be in EN1/2/3 pin mode
+		 * Or GPIO1/2/3 mode.
+		 * Setup the GPIO*_SEL MUX to GPIO mode
+		 */
+		ret = regmap_update_bits(gpio->map,
+					 LP87565_REG_PIN_FUNCTION,
+					 BIT(offset), BIT(offset));
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
+static int lp87565_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
+				   unsigned long config)
+{
+	struct lp87565_gpio *gpio = gpiochip_get_data(gc);
+
+	switch (pinconf_to_config_param(config)) {
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		return regmap_update_bits(gpio->map,
+					  LP87565_REG_GPIO_CONFIG,
+					  BIT(offset +
+					      __ffs(LP87565_GOIO1_OD)),
+					  BIT(offset +
+					      __ffs(LP87565_GOIO1_OD)));
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		return regmap_update_bits(gpio->map,
+					  LP87565_REG_GPIO_CONFIG,
+					  BIT(offset +
+					      __ffs(LP87565_GOIO1_OD)), 0);
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static const struct gpio_chip template_chip = {
+	.label			= "lp87565-gpio",
+	.owner			= THIS_MODULE,
+	.request		= lp87565_gpio_request,
+	.get_direction		= lp87565_gpio_get_direction,
+	.direction_input	= lp87565_gpio_direction_input,
+	.direction_output	= lp87565_gpio_direction_output,
+	.get			= lp87565_gpio_get,
+	.set			= lp87565_gpio_set,
+	.set_config		= lp87565_gpio_set_config,
+	.base			= -1,
+	.ngpio			= 3,
+	.can_sleep		= true,
+};
+
+static int lp87565_gpio_probe(struct platform_device *pdev)
+{
+	struct lp87565_gpio *gpio;
+	struct lp87565 *lp87565;
+	int ret;
+
+	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
+	if (!gpio)
+		return -ENOMEM;
+
+	lp87565 = dev_get_drvdata(pdev->dev.parent);
+	gpio->chip = template_chip;
+	gpio->chip.parent = lp87565->dev;
+	gpio->map = lp87565->regmap;
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Could not register gpiochip, %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id lp87565_gpio_id_table[] = {
+	{ "lp87565-q1-gpio", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, lp87565_gpio_id_table);
+
+static struct platform_driver lp87565_gpio_driver = {
+	.driver = {
+		.name = "lp87565-gpio",
+	},
+	.probe = lp87565_gpio_probe,
+	.id_table = lp87565_gpio_id_table,
+};
+module_platform_driver(lp87565_gpio_driver);
+
+MODULE_AUTHOR("Keerthy <j-keerthy@ti.com>");
+MODULE_DESCRIPTION("LP87565 GPIO driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

