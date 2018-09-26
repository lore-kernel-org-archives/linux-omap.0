From: Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH 7/9] leds: lm3633: Introduce the lm3633 driver
Date: Wed, 26 Sep 2018 08:09:19 -0500
Message-ID: <20180926130921.12329-8-dmurphy@ti.com>
References: <20180926130921.12329-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926130921.12329-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
List-Id: linux-omap@vger.kernel.org

Introduce the LED LM3633 driver.  This LED
driver has 9 total LED outputs with runtime
internal ramp configurations.

Data sheet:
http://www.ti.com/lit/ds/symlink/lm3633.pdf

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/leds/Kconfig       |   8 +
 drivers/leds/Makefile      |   1 +
 drivers/leds/leds-lm3633.c | 430 +++++++++++++++++++++++++++++++++++++
 3 files changed, 439 insertions(+)
 create mode 100644 drivers/leds/leds-lm3633.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 1de4cbb13bd2..1a78588d9806 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -763,8 +763,16 @@ config LEDS_LM3697
           Say Y to enable the LED driver for TI LMU devices.
           This supports the LED device LM3697.
 
+config LEDS_LM3633
+	tristate "LED driver for LM3633"
+ 	depends on LEDS_TI_LMU_COMMON
+	help
+          Say Y to enable the LED driver for TI LMU devices.
+          This supports the LED device LM3633.
+
 config LEDS_TI_LMU_COMMON
 	tristate "LED driver for TI LMU"
+	depends on REGMAP
 	help
           Say Y to enable the LED driver for TI LMU devices.
           This supports common features between the TI LM3532, LM3631, LM3632,
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 6fbce7cfc41c..6ec006892fc0 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_LEDS_LM3692X)		+= leds-lm3692x.o
 obj-$(CONFIG_LEDS_SC27XX_BLTC)		+= leds-sc27xx-bltc.o
 obj-$(CONFIG_LEDS_LM3601X)		+= leds-lm3601x.o
 obj-$(CONFIG_LEDS_LM3697)		+= leds-lm3697.o
+obj-$(CONFIG_LEDS_LM3633)		+= leds-lm3633.o
 obj-$(CONFIG_LEDS_TI_LMU_COMMON)	+= ti-lmu-led-common.o
 
 # LED SPI Drivers
diff --git a/drivers/leds/leds-lm3633.c b/drivers/leds/leds-lm3633.c
new file mode 100644
index 000000000000..3d29b0ed67d3
--- /dev/null
+++ b/drivers/leds/leds-lm3633.c
@@ -0,0 +1,430 @@
+// SPDX-License-Identifier: GPL-2.0
+// TI LM3633 LED chip family driver
+// Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <uapi/linux/uleds.h>
+
+#include "ti-lmu-led-common.h"
+
+#define LM3633_REV			0x0
+#define LM3633_RESET			0x1
+#define LM3633_HVLED_OUTPUT_CONFIG	0x10
+#define LM3633_LVLED_OUTPUT_CONFIG	0x11
+
+#define LM3633_CTRL_A_RAMP		0x12
+#define LM3633_CTRL_B_RAMP		0x13
+#define LM3633_CTRL_C_RAMP		0x14
+#define LM3633_CTRL_D_RAMP		0x15
+#define LM3633_CTRL_E_RAMP		0x16
+#define LM3633_CTRL_F_RAMP		0x17
+#define LM3633_CTRL_G_RAMP		0x18
+#define LM3633_CTRL_H_RAMP		0x19
+
+#define LM3633_CTRL_A_B_RT_RAMP		0x1a
+#define LM3633_CTRL_A_B_RAMP_CFG	0x1b
+#define LM3633_CTRL_C_E_RT_RAMP		0x1c
+#define LM3633_CTRL_F_H_RT_RAMP		0x1d
+
+#define LM3633_CTRL_A_B_BRT_CFG		0x16
+#define LM3633_CTRL_A_FS_CURR_CFG	0x17
+#define LM3633_CTRL_B_FS_CURR_CFG	0x18
+#define LM3633_PWM_CFG			0x1c
+
+#define LM3633_CTRL_ENABLE		0x2b
+
+#define LM3633_CTRL_A_BRT_LSB		0x40
+#define LM3633_CTRL_A_BRT_MSB		0x41
+#define LM3633_CTRL_B_BRT_LSB		0x42
+#define LM3633_CTRL_B_BRT_MSB		0x43
+#define LM3633_CTRL_C_BRT		0x44
+#define LM3633_CTRL_D_BRT		0x45
+#define LM3633_CTRL_E_BRT		0x46
+#define LM3633_CTRL_F_BRT		0x47
+#define LM3633_CTRL_G_BRT		0x48
+#define LM3633_CTRL_H_BRT		0x49
+
+#define LM3633_SW_RESET		BIT(0)
+
+#define LM3633_CTRL_A_EN	BIT(0)
+#define LM3633_CTRL_B_EN	BIT(1)
+#define LM3633_CTRL_C_EN	BIT(2)
+#define LM3633_CTRL_D_EN	BIT(3)
+#define LM3633_CTRL_E_EN	BIT(4)
+#define LM3633_CTRL_F_EN	BIT(5)
+#define LM3633_CTRL_G_EN	BIT(6)
+#define LM3633_CTRL_H_EN	BIT(7)
+#define LM3633_CTRL_A_B_EN	(LM3633_CTRL_A_EN | LM3633_CTRL_B_EN)
+
+#define LM3633_MAX_HVLED_STRINGS	3
+#define LM3633_MAX_LVLED_STRINGS	6
+
+#define LM3633_CONTROL_A	0
+#define LM3633_CONTROL_B	1
+#define LM3633_CONTROL_C	0
+#define LM3633_CONTROL_D	1
+#define LM3633_CONTROL_E	1
+#define LM3633_CONTROL_F	0
+#define LM3633_CONTROL_G	1
+#define LM3633_CONTROL_H	1
+
+#define LM3633_MAX_CONTROL_BANKS 8
+
+#define LM3633_HVLED_ASSIGNMENT	1
+
+/**
+ * struct lm3633_led -
+ * @hvled_strings - Array of high voltage LED strings associated with a control bank
+ * @hvled_strings - Array of low voltage LED strings associated with a control bank
+ * @label - LED label
+ * @led_dev - LED class device
+ * @priv - Pointer to the device struct
+ * @lmu_data - Register and setting values for common code
+ * @control_bank - Control bank the LED is associated to
+ */
+struct lm3633_led {
+	u32 hvled_strings[LM3633_MAX_HVLED_STRINGS];
+	u32 lvled_strings[LM3633_MAX_LVLED_STRINGS];
+	char label[LED_MAX_NAME_SIZE];
+	struct led_classdev led_dev;
+	struct lm3633 *priv;
+	struct ti_lmu_bank lmu_data;
+	int control_bank;
+};
+
+/**
+ * struct lm3633 -
+ * @enable_gpio - Hardware enable gpio
+ * @regulator - LED supply regulator pointer
+ * @client - Pointer to the I2C client
+ * @regmap - Devices register map
+ * @dev - Pointer to the devices device struct
+ * @lock - Lock for reading/writing the device
+ * @leds - Array of LED strings
+ */
+struct lm3633 {
+	struct gpio_desc *enable_gpio;
+	struct regulator *regulator;
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct device *dev;
+	struct mutex lock;
+	struct lm3633_led leds[];
+};
+
+static const struct reg_default lm3633_reg_defs[] = {
+	{LM3633_HVLED_OUTPUT_CONFIG, 0x6},
+	{LM3633_CTRL_A_RAMP, 0x0},
+	{LM3633_CTRL_B_RAMP, 0x0},
+	{LM3633_CTRL_A_B_RT_RAMP, 0x0},
+	{LM3633_CTRL_A_B_RAMP_CFG, 0x0},
+	{LM3633_CTRL_A_B_BRT_CFG, 0x0},
+	{LM3633_CTRL_A_FS_CURR_CFG, 0x13},
+	{LM3633_CTRL_B_FS_CURR_CFG, 0x13},
+	{LM3633_PWM_CFG, 0xc},
+	{LM3633_CTRL_A_BRT_LSB, 0x0},
+	{LM3633_CTRL_A_BRT_MSB, 0x0},
+	{LM3633_CTRL_B_BRT_LSB, 0x0},
+	{LM3633_CTRL_B_BRT_MSB, 0x0},
+	{LM3633_CTRL_ENABLE, 0x0},
+};
+
+static const struct regmap_config lm3633_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = LM3633_CTRL_ENABLE,
+	.reg_defaults = lm3633_reg_defs,
+	.num_reg_defaults = ARRAY_SIZE(lm3633_reg_defs),
+	.cache_type = REGCACHE_FLAT,
+};
+
+static int lm3633_brightness_set(struct led_classdev *led_cdev,
+				enum led_brightness brt_val)
+{
+	struct lm3633_led *led = container_of(led_cdev, struct lm3633_led,
+					      led_dev);
+	int ctrl_en_val;
+	int ret;
+
+	mutex_lock(&led->priv->lock);
+
+	if (led->control_bank == LM3633_CONTROL_A) {
+		led->lmu_data.msb_brightness_reg = LM3633_CTRL_A_BRT_MSB;
+		led->lmu_data.lsb_brightness_reg = LM3633_CTRL_A_BRT_LSB;
+		ctrl_en_val = LM3633_CTRL_A_EN;
+	} else {
+		led->lmu_data.msb_brightness_reg = LM3633_CTRL_B_BRT_MSB;
+		led->lmu_data.lsb_brightness_reg = LM3633_CTRL_B_BRT_LSB;
+		ctrl_en_val = LM3633_CTRL_B_EN;
+	}
+
+	if (brt_val == LED_OFF)
+		ret = regmap_update_bits(led->priv->regmap, LM3633_CTRL_ENABLE,
+					 ctrl_en_val, ~ctrl_en_val);
+	else
+		ret = regmap_update_bits(led->priv->regmap, LM3633_CTRL_ENABLE,
+					 ctrl_en_val, ctrl_en_val);
+
+	ret = ti_lmu_common_set_brightness(&led->lmu_data, brt_val);
+	if (ret)
+		dev_err(&led->priv->client->dev, "Cannot write brightness\n");
+
+	mutex_unlock(&led->priv->lock);
+	return ret;
+}
+
+static int lm3633_set_control_bank(struct lm3633 *priv)
+{
+	u8 control_bank_config = 0;
+	struct lm3633_led *led;
+	int ret, i;
+
+	led = &priv->leds[0];
+	if (led->control_bank == LM3633_CONTROL_A)
+		led = &priv->leds[1];
+
+	for (i = 0; i < LM3633_MAX_HVLED_STRINGS; i++)
+		if (led->hvled_strings[i] == LM3633_HVLED_ASSIGNMENT)
+			control_bank_config |= 1 << i;
+
+	ret = regmap_write(priv->regmap, LM3633_HVLED_OUTPUT_CONFIG,
+			   control_bank_config);
+	if (ret)
+		dev_err(&priv->client->dev, "Cannot write OUTPUT config\n");
+
+	return ret;
+}
+
+static int lm3633_init(struct lm3633 *priv)
+{
+	struct lm3633_led *led;
+	int i, ret;
+
+	if (priv->enable_gpio) {
+		gpiod_direction_output(priv->enable_gpio, 1);
+	} else {
+		ret = regmap_write(priv->regmap, LM3633_RESET, LM3633_SW_RESET);
+		if (ret) {
+			dev_err(&priv->client->dev, "Cannot reset the device\n");
+			goto out;
+		}
+	}
+
+	ret = regmap_write(priv->regmap, LM3633_CTRL_ENABLE, 0x0);
+	if (ret) {
+		dev_err(&priv->client->dev, "Cannot write ctrl enable\n");
+		goto out;
+	}
+
+	ret = lm3633_set_control_bank(priv);
+	if (ret)
+		dev_err(&priv->client->dev, "Setting the CRTL bank failed\n");
+
+	for (i = 0; i < LM3633_MAX_CONTROL_BANKS; i++) {
+		led = &priv->leds[i];
+		ti_lmu_common_set_ramp(&led->lmu_data);
+		if (ret)
+			dev_err(&priv->client->dev, "Setting the ramp rate failed\n");
+	}
+out:
+	return ret;
+}
+
+static int lm3633_probe_dt(struct lm3633 *priv)
+{
+	struct fwnode_handle *child = NULL;
+	struct lm3633_led *led;
+	const char *name;
+	int control_bank;
+	size_t i = 0;
+	int ret;
+
+	priv->enable_gpio = devm_gpiod_get_optional(&priv->client->dev,
+						   "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->enable_gpio)) {
+		ret = PTR_ERR(priv->enable_gpio);
+		dev_err(&priv->client->dev, "Failed to get enable gpio: %d\n",
+			ret);
+		return ret;
+	}
+
+	priv->regulator = devm_regulator_get(&priv->client->dev, "vled");
+	if (IS_ERR(priv->regulator))
+		priv->regulator = NULL;
+
+	device_for_each_child_node(priv->dev, child) {
+		ret = fwnode_property_read_u32(child, "reg", &control_bank);
+		if (ret) {
+			dev_err(&priv->client->dev, "reg property missing\n");
+			fwnode_handle_put(child);
+			goto child_out;
+		}
+
+		if (control_bank > LM3633_CONTROL_B) {
+			dev_err(&priv->client->dev, "reg property is invalid\n");
+			ret = -EINVAL;
+			fwnode_handle_put(child);
+			goto child_out;
+		}
+
+		led = &priv->leds[i];
+
+		led->control_bank = control_bank;
+		led->lmu_data.bank_id = control_bank;
+		led->lmu_data.enable_reg = LM3633_CTRL_ENABLE;
+		led->lmu_data.regmap = priv->regmap;
+		if (control_bank == LM3633_CONTROL_A)
+			led->lmu_data.runtime_ramp_reg = LM3633_CTRL_A_RAMP;
+		else
+			led->lmu_data.runtime_ramp_reg = LM3633_CTRL_B_RAMP;
+
+		if (control_bank <= LM3633_CONTROL_B)
+			ret = fwnode_property_read_u32_array(child, "led-sources",
+						    led->hvled_strings,
+						    LM3633_MAX_HVLED_STRINGS);
+		else
+			ret = fwnode_property_read_u32_array(child, "led-sources",
+						    led->lvled_strings,
+						    LM3633_MAX_LVLED_STRINGS);
+		if (ret) {
+			dev_err(&priv->client->dev, "led-sources property missing\n");
+			fwnode_handle_put(child);
+			goto child_out;
+		}
+
+		ret = ti_lmu_common_get_ramp_params(&priv->client->dev, child, &led->lmu_data);
+		if (ret)
+			dev_warn(&priv->client->dev, "runtime-ramp properties missing\n");
+
+		fwnode_property_read_string(child, "linux,default-trigger",
+					    &led->led_dev.default_trigger);
+
+		ret = fwnode_property_read_string(child, "label", &name);
+		if (ret)
+			snprintf(led->label, sizeof(led->label),
+				"%s::", priv->client->name);
+		else
+			snprintf(led->label, sizeof(led->label),
+				 "%s:%s", priv->client->name, name);
+
+		led->priv = priv;
+		led->led_dev.name = led->label;
+		led->led_dev.brightness_set_blocking = lm3633_brightness_set;
+
+		ret = devm_led_classdev_register(priv->dev, &led->led_dev);
+		if (ret) {
+			dev_err(&priv->client->dev, "led register err: %d\n",
+				ret);
+			fwnode_handle_put(child);
+			goto child_out;
+		}
+
+		i++;
+	}
+
+child_out:
+	return ret;
+}
+
+static int lm3633_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct lm3633 *led;
+	int count;
+	int ret;
+
+	count = device_get_child_node_count(&client->dev);
+	if (!count) {
+		dev_err(&client->dev, "LEDs are not defined in device tree!");
+		return -ENODEV;
+	}
+
+	led = devm_kzalloc(&client->dev, struct_size(led, leds, count),
+			   GFP_KERNEL);
+	if (!led)
+		return -ENOMEM;
+
+	mutex_init(&led->lock);
+	i2c_set_clientdata(client, led);
+
+	led->client = client;
+	led->dev = &client->dev;
+	led->regmap = devm_regmap_init_i2c(client, &lm3633_regmap_config);
+	if (IS_ERR(led->regmap)) {
+		ret = PTR_ERR(led->regmap);
+		dev_err(&client->dev, "Failed to allocate register map: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = lm3633_probe_dt(led);
+	if (ret)
+		return ret;
+
+	return lm3633_init(led);
+}
+
+static int lm3633_remove(struct i2c_client *client)
+{
+	struct lm3633 *led = i2c_get_clientdata(client);
+	int ret;
+
+	ret = regmap_update_bits(led->regmap, LM3633_CTRL_ENABLE,
+				 LM3633_CTRL_A_B_EN, 0);
+	if (ret) {
+		dev_err(&led->client->dev, "Failed to disable the device\n");
+		return ret;
+	}
+
+	if (led->enable_gpio)
+		gpiod_direction_output(led->enable_gpio, 0);
+
+	if (led->regulator) {
+		ret = regulator_disable(led->regulator);
+		if (ret)
+			dev_err(&led->client->dev,
+				"Failed to disable regulator\n");
+	}
+
+	mutex_destroy(&led->lock);
+
+	return 0;
+}
+
+static const struct i2c_device_id lm3633_id[] = {
+	{ "lm3633", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lm3633_id);
+
+static const struct of_device_id of_lm3633_leds_match[] = {
+	{ .compatible = "ti,lm3633", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_lm3633_leds_match);
+
+static struct i2c_driver lm3633_driver = {
+	.driver = {
+		.name	= "lm3633",
+		.of_match_table = of_lm3633_leds_match,
+	},
+	.probe		= lm3633_probe,
+	.remove		= lm3633_remove,
+	.id_table	= lm3633_id,
+};
+module_i2c_driver(lm3633_driver);
+
+MODULE_DESCRIPTION("Texas Instruments LM3633 LED driver");
+MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.19.0
