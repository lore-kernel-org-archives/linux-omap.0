From: Pavel Machek <pavel@ucw.cz>
Subject: [rfc] leds: add TI LMU backlight driver
Date: Wed, 29 Aug 2018 23:20:32 +0200
Message-ID: <20180829212032.GB15786@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Here's preview of driver for TI LMU. It controls LEDs on Droid 4
smartphone, including keyboard and screen backlights.

This adds backlight support for the following TI LMU
chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.

Signed-off-by: Milo Kim <milo.kim@ti.com>
[add LED subsystem support for keyboard backlight and rework DT
binding according to Rob Herrings feedback]
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
[remove backlight subsystem support for now]
Signed-off-by: Pavel Machek <pavel@ucw.cz>

---

Does it looks mostly reasonable? I guess it will need some
s/BACKLIGHT/LEDS/ , and I'll need to remove my debugging hacks.

I'd prefer this to be LED driver, first; I'll need to figure out what
to do with backlight. I guess something like existing "backlight"
trigger should do the trick.

Best regards,
								Pavel


diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 44097a3..7b0929e 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -756,6 +756,13 @@ config LEDS_NIC78BX
 	  To compile this driver as a module, choose M here: the module
 	  will be called leds-nic78bx.
=20
+config BACKLIGHT_TI_LMU
+       tristate "Backlight driver for TI LMU"
+       depends on BACKLIGHT_CLASS_DEVICE && MFD_TI_LMU
+       help
+         Say Y to enable the backlight driver for TI LMU devices.
+         This supports LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
+
 comment "LED Triggers"
 source "drivers/leds/trigger/Kconfig"
=20
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 420b5d2..8edb9bf 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -78,6 +78,9 @@ obj-$(CONFIG_LEDS_MT6323)		+=3D leds-mt6323.o
 obj-$(CONFIG_LEDS_LM3692X)		+=3D leds-lm3692x.o
 obj-$(CONFIG_LEDS_SC27XX_BLTC)		+=3D leds-sc27xx-bltc.o
 obj-$(CONFIG_LEDS_LM3601X)		+=3D leds-lm3601x.o
+ti-lmu-backlight-objs                   :=3D ti-lmu-backlight-core.o \
+                                           ti-lmu-backlight-data.o
+obj-$(CONFIG_BACKLIGHT_TI_LMU)          +=3D ti-lmu-backlight.o
=20
 # LED SPI Drivers
 obj-$(CONFIG_LEDS_CR0014114)		+=3D leds-cr0014114.o
diff --git a/drivers/leds/ti-lmu-backlight-core.c b/drivers/leds/ti-lmu-bac=
klight-core.c
new file mode 100644
index 0000000..c9af061
--- /dev/null
+++ b/drivers/leds/ti-lmu-backlight-core.c
@@ -0,0 +1,556 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2015 Texas Instruments
+ * Copyright 2018 Sebastian Reichel
+ *
+ * TI LMU Backlight driver, based on previous work from
+ * Milo Kim <milo.kim@ti.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/leds.h>
+#include <linux/mfd/ti-lmu.h>
+#include <linux/mfd/ti-lmu-register.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "ti-lmu-backlight-data.h"
+
+enum ti_lmu_bl_ramp_mode {
+	BL_RAMP_UP,
+	BL_RAMP_DOWN,
+};
+
+#define NUM_DUAL_CHANNEL			2
+#define LMU_BACKLIGHT_DUAL_CHANNEL_USED		(BIT(0) | BIT(1))
+#define LMU_BACKLIGHT_11BIT_LSB_MASK		(BIT(0) | BIT(1) | BIT(2))
+#define LMU_BACKLIGHT_11BIT_MSB_SHIFT		3
+
+struct ti_lmu_bank {
+	struct device *dev;
+	int bank_id;
+	const struct ti_lmu_bl_cfg *cfg;
+	struct ti_lmu *lmu;
+	const char *label;
+	int leds;
+	int current_brightness;
+	u32 default_brightness;
+	u32 ramp_up_msec;
+	u32 ramp_down_msec;
+
+	struct notifier_block nb;
+
+	struct backlight_device *backlight;
+	struct led_classdev *led;
+};
+
+static int ti_lmu_bl_enable(struct ti_lmu_bank *lmu_bank, bool enable)
+{
+	struct regmap *regmap =3D lmu_bank->lmu->regmap;
+	unsigned long enable_time =3D lmu_bank->cfg->reginfo->enable_usec;
+	u8 *reg =3D lmu_bank->cfg->reginfo->enable;
+	u8 mask =3D BIT(lmu_bank->bank_id);
+	u8 val =3D (enable =3D=3D true) ? mask : 0;
+	int ret;
+
+	if (!reg)
+		return -EINVAL;
+
+	ret =3D regmap_update_bits(regmap, *reg, mask, val);
+	if (ret)
+		return ret;
+
+	if (enable_time > 0)
+		usleep_range(enable_time, enable_time + 100);
+
+	return 0;
+}
+
+static int ti_lmu_bl_update_brightness_register(struct ti_lmu_bank *lmu_ba=
nk,
+						       int brightness)
+{
+	const struct ti_lmu_bl_cfg *cfg =3D lmu_bank->cfg;
+	const struct ti_lmu_bl_reg *reginfo =3D cfg->reginfo;
+	struct regmap *regmap =3D lmu_bank->lmu->regmap;
+	u8 reg, val;
+	int ret;
+
+	/*
+	 * Brightness register update
+	 *
+	 * 11 bit dimming: update LSB bits and write MSB byte.
+	 *		   MSB brightness should be shifted.
+	 *  8 bit dimming: write MSB byte.
+	 */
+	if (cfg->max_brightness =3D=3D MAX_BRIGHTNESS_11BIT) {
+		reg =3D reginfo->brightness_lsb[lmu_bank->bank_id];
+		ret =3D regmap_update_bits(regmap, reg,
+					 LMU_BACKLIGHT_11BIT_LSB_MASK,
+					 brightness);
+		if (ret)
+			return ret;
+
+		val =3D brightness >> LMU_BACKLIGHT_11BIT_MSB_SHIFT;
+	} else {
+		val =3D brightness;
+	}
+
+	reg =3D reginfo->brightness_msb[lmu_bank->bank_id];
+	return regmap_write(regmap, reg, val);
+}
+
+static int ti_lmu_bl_set_brightness(struct ti_lmu_bank *lmu_bank,
+				    int brightness)
+{
+	bool enable =3D brightness > 0;
+	int ret;
+
+	ret =3D ti_lmu_bl_enable(lmu_bank, enable);
+	if (ret)
+		return ret;
+
+	lmu_bank->current_brightness =3D brightness;
+
+	return ti_lmu_bl_update_brightness_register(lmu_bank, brightness);
+}
+
+static int ti_lmu_bl_set_led_blocking(struct led_classdev *ledc,
+					     enum led_brightness value)
+{
+	struct ti_lmu_bank *lmu_bank =3D dev_get_drvdata(ledc->dev->parent);
+	int brightness =3D value;
+
+	return ti_lmu_bl_set_brightness(lmu_bank, brightness);
+}
+
+static int ti_lmu_bl_check_channel(struct ti_lmu_bank *lmu_bank)
+{
+	const struct ti_lmu_bl_cfg *cfg =3D lmu_bank->cfg;
+	const struct ti_lmu_bl_reg *reginfo =3D cfg->reginfo;
+
+	if (!reginfo->brightness_msb)
+		return -EINVAL;
+
+	if (cfg->max_brightness > MAX_BRIGHTNESS_8BIT) {
+		if (!reginfo->brightness_lsb)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ti_lmu_bl_create_channel(struct ti_lmu_bank *lmu_bank)
+{
+	struct regmap *regmap =3D lmu_bank->lmu->regmap;
+	const struct lmu_bl_reg_data *regdata =3D lmu_bank->cfg->reginfo->channel;
+	int num_channels =3D lmu_bank->cfg->num_channels;
+	unsigned long led_sources =3D lmu_bank->leds;
+	int i, ret;
+	u8 shift;
+
+	/*
+	 * How to create backlight output channels:
+	 *   Check 'led_sources' bit and update registers.
+	 *
+	 *   1) Dual channel configuration
+	 *     The 1st register data is used for single channel.
+	 *     The 2nd register data is used for dual channel.
+	 *
+	 *   2) Multiple channel configuration
+	 *     Each register data is mapped to bank ID.
+	 *     Bit shift operation is defined in channel registers.
+	 *
+	 * Channel register data consists of address, mask, value.
+	 */
+
+	if (num_channels =3D=3D NUM_DUAL_CHANNEL) {
+		if (led_sources =3D=3D LMU_BACKLIGHT_DUAL_CHANNEL_USED)
+			regdata++;
+
+		return regmap_update_bits(regmap, regdata->reg, regdata->mask,
+					  regdata->val);
+	}
+
+	for (i =3D 0; regdata && i < num_channels; i++) {
+		/*
+		 * Note that the result of regdata->val is shift bit.
+		 * The bank_id should be shifted for the channel configuration.
+		 */
+		if (test_bit(i, &led_sources)) {
+			shift =3D regdata->val;
+			ret =3D regmap_update_bits(regmap, regdata->reg,
+						 regdata->mask,
+						 lmu_bank->bank_id << shift);
+			if (ret)
+				return ret;
+		}
+
+		regdata++;
+	}
+
+	return 0;
+}
+
+static int ti_lmu_bl_update_ctrl_mode(struct ti_lmu_bank *lmu_bank)
+{
+	struct regmap *regmap =3D lmu_bank->lmu->regmap;
+	const struct lmu_bl_reg_data *regdata =3D
+		lmu_bank->cfg->reginfo->mode + lmu_bank->bank_id;
+	u8 val =3D regdata->val;
+
+	if (!regdata)
+		return 0;
+
+	/*
+	 * Update PWM configuration register.
+	 * If the mode is register based, then clear the bit.
+	 */
+	val =3D 0;
+
+	return regmap_update_bits(regmap, regdata->reg, regdata->mask, val);
+}
+
+static int ti_lmu_bl_convert_ramp_to_index(struct ti_lmu_bank *lmu_bank,
+						  enum ti_lmu_bl_ramp_mode mode)
+{
+	const int *ramp_table =3D lmu_bank->cfg->ramp_table;
+	const int size =3D lmu_bank->cfg->size_ramp;
+	unsigned int msec;
+	int i;
+
+	if (!ramp_table)
+		return -EINVAL;
+
+	switch (mode) {
+	case BL_RAMP_UP:
+		msec =3D lmu_bank->ramp_up_msec;
+		break;
+	case BL_RAMP_DOWN:
+		msec =3D lmu_bank->ramp_down_msec;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (msec <=3D ramp_table[0])
+		return 0;
+
+	if (msec > ramp_table[size - 1])
+		return size - 1;
+
+	for (i =3D 1; i < size; i++) {
+		if (msec =3D=3D ramp_table[i])
+			return i;
+
+		/* Find an approximate index by looking up the table */
+		if (msec > ramp_table[i - 1] && msec < ramp_table[i]) {
+			if (msec - ramp_table[i - 1] < ramp_table[i] - msec)
+				return i - 1;
+			else
+				return i;
+		}
+	}
+
+	return -EINVAL;
+}
+
+
+static int ti_lmu_bl_set_ramp(struct ti_lmu_bank *lmu_bank)
+{
+	struct regmap *regmap =3D lmu_bank->lmu->regmap;
+	const struct ti_lmu_bl_reg *reginfo =3D lmu_bank->cfg->reginfo;
+	int offset =3D reginfo->ramp_reg_offset;
+	int i, ret, index;
+	struct lmu_bl_reg_data regdata;
+
+	for (i =3D BL_RAMP_UP; i <=3D BL_RAMP_DOWN; i++) {
+		index =3D ti_lmu_bl_convert_ramp_to_index(lmu_bank, i);
+		if (index > 0) {
+			if (!reginfo->ramp)
+				break;
+
+			regdata =3D reginfo->ramp[i];
+			if (lmu_bank->bank_id !=3D 0)
+				regdata.val +=3D offset;
+
+			/* regdata.val is shift bit */
+			ret =3D regmap_update_bits(regmap, regdata.reg,
+						 regdata.mask,
+						 index << regdata.val);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int ti_lmu_bl_configure(struct ti_lmu_bank *lmu_bank)
+{
+	int ret;
+
+	ret =3D ti_lmu_bl_check_channel(lmu_bank);
+	if (ret)
+		return ret;
+
+	ret =3D ti_lmu_bl_create_channel(lmu_bank);
+	if (ret)
+		return ret;
+
+	ret =3D ti_lmu_bl_update_ctrl_mode(lmu_bank);
+	if (ret)
+		return ret;
+
+	return ti_lmu_bl_set_ramp(lmu_bank);
+}
+
+static int ti_lmu_bl_register_led(struct ti_lmu_bank *lmu_bank)
+{
+	int err;
+
+	printk("lmu: register_led\n");
+
+	lmu_bank->led =3D devm_kzalloc(lmu_bank->dev, sizeof(*lmu_bank->led),
+				     GFP_KERNEL);
+	if (!lmu_bank->led)
+		return -ENOMEM;
+
+	lmu_bank->led->name =3D lmu_bank->label;
+	lmu_bank->led->max_brightness =3D lmu_bank->cfg->max_brightness;
+	lmu_bank->led->brightness_set_blocking =3D
+		ti_lmu_bl_set_led_blocking;
+
+	printk("lmu: register_led\n");
+=09
+	err =3D devm_led_classdev_register(lmu_bank->dev, lmu_bank->led);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int ti_lmu_bl_add_device(struct ti_lmu_bank *lmu_bank)
+{
+	return ti_lmu_bl_register_led(lmu_bank);
+}
+
+static int setup_of_node(struct platform_device *pdev)
+{
+	struct device_node *parent_node =3D pdev->dev.parent->of_node;
+	char *name;
+
+	if (!parent_node)
+		return 0;
+
+	name =3D kasprintf(GFP_KERNEL, "bank%d", pdev->id);
+//		name =3D kasprintf(GFP_KERNEL, "lcd_backlight", pdev->id);
+	if (!name) {
+		printk("No memory?!\n");
+		return -ENOMEM;
+	}
+
+	printk("Searching for device in parent: %pOFn", parent_node);
+
+	pdev->dev.of_node =3D of_get_child_by_name(parent_node, name);
+	kfree(name);
+
+	if (!pdev->dev.of_node) {
+		printk("No such child: %s\n", name);	=09
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int ti_lmu_parse_led_sources(struct device *dev)
+{
+	unsigned long mask =3D 0;
+	int ret;
+	int size, i;
+	u32 *leds;
+
+	size =3D device_property_read_u32_array(dev, "ti,led-sources", NULL, 0);
+	if (size <=3D 0) {
+		dev_err(dev, "Missing or malformed property led-sources: %d\n",
+			size);
+		return size < 0 ? size : -EINVAL;
+	}
+
+	leds =3D kmalloc_array(size, sizeof(u32), GFP_KERNEL);
+	if (!leds)
+		return -ENOMEM;
+
+	ret =3D device_property_read_u32_array(dev, "ti,led-sources", leds, size);
+	if (ret) {
+		dev_err(dev, "Failed to read led-sources property: %d\n", ret);
+		goto out;
+	}
+
+	for (i =3D 0; i < size; i++)
+		set_bit(leds[i], &mask);
+
+	ret =3D mask;
+
+out:
+	kfree(leds);
+	return ret;
+}
+
+static int ti_lmu_bl_init(struct ti_lmu_bank *lmu_bank)
+{
+	struct regmap *regmap =3D lmu_bank->lmu->regmap;
+	const struct lmu_bl_reg_data *regdata =3D
+		lmu_bank->cfg->reginfo->init;
+	int num_init =3D lmu_bank->cfg->reginfo->num_init;
+	int i, ret;
+
+	if (lmu_bank->lmu->backlight_initialized)
+		return 0;
+	lmu_bank->lmu->backlight_initialized =3D true;
+
+	for (i =3D 0; regdata && i < num_init; i++) {
+		ret =3D regmap_update_bits(regmap, regdata->reg, regdata->mask,
+					 regdata->val);
+		if (ret)
+			return ret;
+
+		regdata++;
+	}
+
+	return 0;
+}
+
+static int ti_lmu_bl_reload(struct ti_lmu_bank *lmu_bank)
+{
+	int err;
+
+	ti_lmu_bl_init(lmu_bank);
+
+	err =3D ti_lmu_bl_configure(lmu_bank);
+	if (err)
+		return err;
+
+	printk("lmu: set_brightness %d\n", lmu_bank->default_brightness);	=09
+	return ti_lmu_bl_set_brightness(lmu_bank, lmu_bank->current_brightness);
+}
+
+static int ti_lmu_bl_monitor_notifier(struct notifier_block *nb,
+					     unsigned long action, void *unused)
+{
+	struct ti_lmu_bank *lmu_bank =3D container_of(nb, struct ti_lmu_bank, nb);
+
+	if (action =3D=3D LMU_EVENT_MONITOR_DONE) {
+		if (ti_lmu_bl_reload(lmu_bank))
+			return NOTIFY_STOP;
+	}
+
+	return NOTIFY_OK;
+}
+
+static int ti_lmu_bl_probe(struct platform_device *pdev)
+{
+	struct ti_lmu_bank *lmu_bank;
+	int err;
+
+	printk("lmu: bl probe\n");
+	err =3D setup_of_node(pdev);
+	if (err)
+		return err;
+
+	printk("lmu: bank\n");=09
+	lmu_bank =3D devm_kzalloc(&pdev->dev, sizeof(*lmu_bank), GFP_KERNEL);
+	if (!lmu_bank)
+		return -ENOMEM;
+	lmu_bank->dev =3D &pdev->dev;
+	dev_set_drvdata(&pdev->dev, lmu_bank);
+
+	err =3D device_property_read_string(&pdev->dev, "label",
+					  &lmu_bank->label);
+	if (err)
+		return err;
+
+	if (!strcmp(lmu_bank->label, "keyboard")) {
+		lmu_bank->label =3D "kbd_backlight";
+	} else
+		lmu_bank->default_brightness =3D 255;
+
+	lmu_bank->leds =3D ti_lmu_parse_led_sources(&pdev->dev);
+	if (lmu_bank->leds < 0)
+		return lmu_bank->leds;
+	else if (lmu_bank->leds =3D=3D 0)
+		return -EINVAL;
+
+	device_property_read_u32(&pdev->dev, "default-brightness-level",
+				 &lmu_bank->default_brightness);
+	device_property_read_u32(&pdev->dev, "ti,ramp-up-ms",
+				 &lmu_bank->ramp_up_msec);
+	device_property_read_u32(&pdev->dev, "ti,ramp-down-ms",
+				 &lmu_bank->ramp_down_msec);
+=09
+	lmu_bank->lmu =3D dev_get_drvdata(pdev->dev.parent);
+	lmu_bank->cfg =3D &lmu_bl_cfg[lmu_bank->lmu->id];
+	lmu_bank->bank_id =3D pdev->id;
+
+	ti_lmu_bl_init(lmu_bank);
+
+	err =3D ti_lmu_bl_configure(lmu_bank);
+	if (err)
+		return err;
+
+	err =3D ti_lmu_bl_add_device(lmu_bank);
+	if (err)
+		return err;
+
+	printk("lmu: brightness\n");	=09
+	err =3D ti_lmu_bl_set_brightness(lmu_bank,
+					      lmu_bank->default_brightness);
+	if (err)
+		return err;
+
+	/*
+	 * Notifier callback is required because backlight device needs
+	 * reconfiguration after fault detection procedure is done by
+	 * ti-lmu-fault-monitor driver.
+	 */
+	if (lmu_bank->cfg->fault_monitor_used) {
+		lmu_bank->nb.notifier_call =3D ti_lmu_bl_monitor_notifier;
+		err =3D blocking_notifier_chain_register(&lmu_bank->lmu->notifier,
+						       &lmu_bank->nb);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int ti_lmu_bl_remove(struct platform_device *pdev)
+{
+	struct ti_lmu_bank *lmu_bank =3D platform_get_drvdata(pdev);
+
+	if (lmu_bank->cfg->fault_monitor_used)
+		blocking_notifier_chain_unregister(&lmu_bank->lmu->notifier,
+						   &lmu_bank->nb);
+
+	ti_lmu_bl_set_brightness(lmu_bank, 0);
+
+	return 0;
+}
+
+static struct platform_driver ti_lmu_bl_driver =3D {
+	.probe  =3D ti_lmu_bl_probe,
+	.remove  =3D ti_lmu_bl_remove,
+	.driver =3D {
+		.name =3D "ti-lmu-led-backlight",
+	},
+};
+module_platform_driver(ti_lmu_bl_driver)
+
+MODULE_DESCRIPTION("TI LMU Backlight LED Driver");
+MODULE_AUTHOR("Sebastian Reichel");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:ti-lmu-led-backlight");
diff --git a/drivers/leds/ti-lmu-backlight-data.c b/drivers/leds/ti-lmu-bac=
klight-data.c
new file mode 100644
index 0000000..583136c
--- /dev/null
+++ b/drivers/leds/ti-lmu-backlight-data.c
@@ -0,0 +1,304 @@
+/*
+ * TI LMU (Lighting Management Unit) Backlight Device Data
+ *
+ * Copyright 2015 Texas Instruments
+ *
+ * Author: Milo Kim <milo.kim@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "ti-lmu-backlight-data.h"
+
+/* LM3532 */
+static const struct lmu_bl_reg_data lm3532_init_data[] =3D {
+	{ LM3532_REG_ZONE_CFG_A, LM3532_ZONE_MASK, LM3532_ZONE_0 },
+	{ LM3532_REG_ZONE_CFG_B, LM3532_ZONE_MASK, LM3532_ZONE_1 },
+	{ LM3532_REG_ZONE_CFG_C, LM3532_ZONE_MASK, LM3532_ZONE_2 },
+};
+
+static const struct lmu_bl_reg_data lm3532_channel_data[] =3D {
+	{ LM3532_REG_OUTPUT_CFG, LM3532_ILED1_CFG_MASK,
+	  LM3532_ILED1_CFG_SHIFT },
+	{ LM3532_REG_OUTPUT_CFG, LM3532_ILED2_CFG_MASK,
+	  LM3532_ILED2_CFG_SHIFT },
+	{ LM3532_REG_OUTPUT_CFG, LM3532_ILED3_CFG_MASK,
+	  LM3532_ILED3_CFG_SHIFT },
+};
+
+static const struct lmu_bl_reg_data lm3532_mode_data[] =3D {
+	{ LM3532_REG_PWM_A_CFG, LM3532_PWM_A_MASK, LM3532_PWM_ZONE_0 },
+	{ LM3532_REG_PWM_B_CFG, LM3532_PWM_B_MASK, LM3532_PWM_ZONE_1 },
+	{ LM3532_REG_PWM_C_CFG, LM3532_PWM_C_MASK, LM3532_PWM_ZONE_2 },
+};
+
+static const struct lmu_bl_reg_data lm3532_ramp_data[] =3D {
+	{ LM3532_REG_RAMPUP, LM3532_RAMPUP_MASK, LM3532_RAMPUP_SHIFT },
+	{ LM3532_REG_RAMPDN, LM3532_RAMPDN_MASK, LM3532_RAMPDN_SHIFT },
+};
+
+static u8 lm3532_enable_reg =3D LM3532_REG_ENABLE;
+
+static u8 lm3532_brightness_regs[] =3D {
+	LM3532_REG_BRT_A,
+	LM3532_REG_BRT_B,
+	LM3532_REG_BRT_C,
+};
+
+static const struct ti_lmu_bl_reg lm3532_reg_info =3D {
+	.init		=3D lm3532_init_data,
+	.num_init	=3D ARRAY_SIZE(lm3532_init_data),
+	.channel	=3D lm3532_channel_data,
+	.mode		=3D lm3532_mode_data,
+	.ramp		=3D lm3532_ramp_data,
+	.enable		=3D &lm3532_enable_reg,
+	.brightness_msb	=3D lm3532_brightness_regs,
+};
+
+/* LM3631 */
+static const struct lmu_bl_reg_data lm3631_init_data[] =3D {
+	{ LM3631_REG_BRT_MODE, LM3631_MODE_MASK, LM3631_DEFAULT_MODE },
+	{ LM3631_REG_BL_CFG, LM3631_MAP_MASK, LM3631_EXPONENTIAL_MAP },
+};
+
+static const struct lmu_bl_reg_data lm3631_channel_data[] =3D {
+	{ LM3631_REG_BL_CFG, LM3631_BL_CHANNEL_MASK, LM3631_BL_SINGLE_CHANNEL },
+	{ LM3631_REG_BL_CFG, LM3631_BL_CHANNEL_MASK, LM3631_BL_DUAL_CHANNEL },
+};
+
+static const struct lmu_bl_reg_data lm3631_ramp_data[] =3D {
+	{ LM3631_REG_SLOPE, LM3631_SLOPE_MASK, LM3631_SLOPE_SHIFT },
+};
+
+static u8 lm3631_enable_reg =3D LM3631_REG_DEVCTRL;
+static u8 lm3631_brightness_msb_reg =3D LM3631_REG_BRT_MSB;
+static u8 lm3631_brightness_lsb_reg =3D LM3631_REG_BRT_LSB;
+
+static const struct ti_lmu_bl_reg lm3631_reg_info =3D {
+	.init		=3D lm3631_init_data,
+	.num_init	=3D ARRAY_SIZE(lm3631_init_data),
+	.channel	=3D lm3631_channel_data,
+	.ramp		=3D lm3631_ramp_data,
+	.enable		=3D &lm3631_enable_reg,
+	.brightness_msb	=3D &lm3631_brightness_msb_reg,
+	.brightness_lsb	=3D &lm3631_brightness_lsb_reg,
+};
+
+/* LM3632 */
+static const struct lmu_bl_reg_data lm3632_init_data[] =3D {
+	{ LM3632_REG_CONFIG1, LM3632_OVP_MASK, LM3632_OVP_25V },
+	{ LM3632_REG_CONFIG2, LM3632_SWFREQ_MASK, LM3632_SWFREQ_1MHZ },
+};
+
+static const struct lmu_bl_reg_data lm3632_channel_data[] =3D {
+	{ LM3632_REG_ENABLE, LM3632_BL_CHANNEL_MASK, LM3632_BL_SINGLE_CHANNEL },
+	{ LM3632_REG_ENABLE, LM3632_BL_CHANNEL_MASK, LM3632_BL_DUAL_CHANNEL },
+};
+
+static const struct lmu_bl_reg_data lm3632_mode_data[] =3D {
+	{ LM3632_REG_IO_CTRL, LM3632_PWM_MASK, LM3632_PWM_MODE },
+};
+
+static u8 lm3632_enable_reg =3D LM3632_REG_ENABLE;
+static u8 lm3632_brightness_msb_reg =3D LM3632_REG_BRT_MSB;
+static u8 lm3632_brightness_lsb_reg =3D LM3632_REG_BRT_LSB;
+
+static const struct ti_lmu_bl_reg lm3632_reg_info =3D {
+	.init		=3D lm3632_init_data,
+	.num_init	=3D ARRAY_SIZE(lm3632_init_data),
+	.channel	=3D lm3632_channel_data,
+	.mode		=3D lm3632_mode_data,
+	.enable		=3D &lm3632_enable_reg,
+	.brightness_msb	=3D &lm3632_brightness_msb_reg,
+	.brightness_lsb	=3D &lm3632_brightness_lsb_reg,
+};
+
+/* LM3633 */
+static const struct lmu_bl_reg_data lm3633_init_data[] =3D {
+	{ LM3633_REG_BOOST_CFG, LM3633_OVP_MASK, LM3633_OVP_40V },
+	{ LM3633_REG_BL_RAMP_CONF, LM3633_BL_RAMP_MASK, LM3633_BL_RAMP_EACH },
+};
+
+static const struct lmu_bl_reg_data lm3633_channel_data[] =3D {
+	{ LM3633_REG_HVLED_OUTPUT_CFG, LM3633_HVLED1_CFG_MASK,
+	  LM3633_HVLED1_CFG_SHIFT },
+	{ LM3633_REG_HVLED_OUTPUT_CFG, LM3633_HVLED2_CFG_MASK,
+	  LM3633_HVLED2_CFG_SHIFT },
+	{ LM3633_REG_HVLED_OUTPUT_CFG, LM3633_HVLED3_CFG_MASK,
+	  LM3633_HVLED3_CFG_SHIFT },
+};
+
+static const struct lmu_bl_reg_data lm3633_mode_data[] =3D {
+	{ LM3633_REG_PWM_CFG, LM3633_PWM_A_MASK, LM3633_PWM_A_MASK },
+	{ LM3633_REG_PWM_CFG, LM3633_PWM_B_MASK, LM3633_PWM_B_MASK },
+};
+
+static const struct lmu_bl_reg_data lm3633_ramp_data[] =3D {
+	{ LM3633_REG_BL0_RAMP, LM3633_BL_RAMPUP_MASK, LM3633_BL_RAMPUP_SHIFT },
+	{ LM3633_REG_BL0_RAMP, LM3633_BL_RAMPDN_MASK, LM3633_BL_RAMPDN_SHIFT },
+};
+
+static u8 lm3633_enable_reg =3D LM3633_REG_ENABLE;
+
+static u8 lm3633_brightness_msb_regs[] =3D {
+	LM3633_REG_BRT_HVLED_A_MSB,
+	LM3633_REG_BRT_HVLED_B_MSB,
+};
+
+static u8 lm3633_brightness_lsb_regs[] =3D {
+	LM3633_REG_BRT_HVLED_A_LSB,
+	LM3633_REG_BRT_HVLED_B_LSB,
+};
+
+static const struct ti_lmu_bl_reg lm3633_reg_info =3D {
+	.init		 =3D lm3633_init_data,
+	.num_init	 =3D ARRAY_SIZE(lm3633_init_data),
+	.channel	 =3D lm3633_channel_data,
+	.mode		 =3D lm3633_mode_data,
+	.ramp		 =3D lm3633_ramp_data,
+	.ramp_reg_offset =3D 1, /* For LM3633_REG_BL1_RAMPUP/DN */
+	.enable		 =3D &lm3633_enable_reg,
+	.brightness_msb	 =3D lm3633_brightness_msb_regs,
+	.brightness_lsb	 =3D lm3633_brightness_lsb_regs,
+};
+
+/* LM3695 */
+static const struct lmu_bl_reg_data lm3695_init_data[] =3D {
+	{ LM3695_REG_GP, LM3695_BRT_RW_MASK, LM3695_BRT_RW_MASK },
+};
+
+static const struct lmu_bl_reg_data lm3695_channel_data[] =3D {
+	{ LM3695_REG_GP, LM3695_BL_CHANNEL_MASK, LM3695_BL_SINGLE_CHANNEL },
+	{ LM3695_REG_GP, LM3695_BL_CHANNEL_MASK, LM3695_BL_DUAL_CHANNEL },
+};
+
+static u8 lm3695_enable_reg =3D LM3695_REG_GP;
+static u8 lm3695_brightness_msb_reg =3D LM3695_REG_BRT_MSB;
+static u8 lm3695_brightness_lsb_reg =3D LM3695_REG_BRT_LSB;
+
+static const struct ti_lmu_bl_reg lm3695_reg_info =3D {
+	.init		=3D lm3695_init_data,
+	.num_init	=3D ARRAY_SIZE(lm3695_init_data),
+	.channel	=3D lm3695_channel_data,
+	.enable		=3D &lm3695_enable_reg,
+	.enable_usec	=3D 600,
+	.brightness_msb	=3D &lm3695_brightness_msb_reg,
+	.brightness_lsb	=3D &lm3695_brightness_lsb_reg,
+};
+
+/* LM3697 */
+static const struct lmu_bl_reg_data lm3697_init_data[] =3D {
+	{ LM3697_REG_RAMP_CONF, LM3697_RAMP_MASK, LM3697_RAMP_EACH },
+};
+
+static const struct lmu_bl_reg_data lm3697_channel_data[] =3D {
+	{ LM3697_REG_HVLED_OUTPUT_CFG, LM3697_HVLED1_CFG_MASK,
+	  LM3697_HVLED1_CFG_SHIFT },
+	{ LM3697_REG_HVLED_OUTPUT_CFG, LM3697_HVLED2_CFG_MASK,
+	  LM3697_HVLED2_CFG_SHIFT },
+	{ LM3697_REG_HVLED_OUTPUT_CFG, LM3697_HVLED3_CFG_MASK,
+	  LM3697_HVLED3_CFG_SHIFT },
+};
+
+static const struct lmu_bl_reg_data lm3697_mode_data[] =3D {
+	{ LM3697_REG_PWM_CFG, LM3697_PWM_A_MASK, LM3697_PWM_A_MASK },
+	{ LM3697_REG_PWM_CFG, LM3697_PWM_B_MASK, LM3697_PWM_B_MASK },
+};
+
+static const struct lmu_bl_reg_data lm3697_ramp_data[] =3D {
+	{ LM3697_REG_BL0_RAMP, LM3697_RAMPUP_MASK, LM3697_RAMPUP_SHIFT },
+	{ LM3697_REG_BL0_RAMP, LM3697_RAMPDN_MASK, LM3697_RAMPDN_SHIFT },
+};
+
+static u8 lm3697_enable_reg =3D LM3697_REG_ENABLE;
+
+static u8 lm3697_brightness_msb_regs[] =3D {
+	LM3697_REG_BRT_A_MSB,
+	LM3697_REG_BRT_B_MSB,
+};
+
+static u8 lm3697_brightness_lsb_regs[] =3D {
+	LM3697_REG_BRT_A_LSB,
+	LM3697_REG_BRT_B_LSB,
+};
+
+static const struct ti_lmu_bl_reg lm3697_reg_info =3D {
+	.init		 =3D lm3697_init_data,
+	.num_init	 =3D ARRAY_SIZE(lm3697_init_data),
+	.channel	 =3D lm3697_channel_data,
+	.mode		 =3D lm3697_mode_data,
+	.ramp		 =3D lm3697_ramp_data,
+	.ramp_reg_offset =3D 1, /* For LM3697_REG_BL1_RAMPUP/DN */
+	.enable		 =3D &lm3697_enable_reg,
+	.brightness_msb	 =3D lm3697_brightness_msb_regs,
+	.brightness_lsb	 =3D lm3697_brightness_lsb_regs,
+};
+
+static int lm3532_ramp_table[] =3D { 0, 1, 2, 4, 8, 16, 32, 65 };
+
+static int lm3631_ramp_table[] =3D {
+	   0,   1,   2,    5,   10,   20,   50,  100,
+	 250, 500, 750, 1000, 1500, 2000, 3000, 4000,
+};
+
+static int common_ramp_table[] =3D {
+	   2, 250, 500, 1000, 2000, 4000, 8000, 16000,
+};
+
+#define LM3532_MAX_CHANNELS		3
+#define LM3631_MAX_CHANNELS		2
+#define LM3632_MAX_CHANNELS		2
+#define LM3633_MAX_CHANNELS		3
+#define LM3695_MAX_CHANNELS		2
+#define LM3697_MAX_CHANNELS		3
+
+const struct ti_lmu_bl_cfg lmu_bl_cfg[LMU_MAX_ID] =3D {
+	{
+		.reginfo		=3D &lm3532_reg_info,
+		.num_channels		=3D LM3532_MAX_CHANNELS,
+		.max_brightness		=3D MAX_BRIGHTNESS_8BIT,
+		.pwm_action		=3D UPDATE_PWM_AND_BRT_REGISTER,
+		.ramp_table		=3D lm3532_ramp_table,
+		.size_ramp		=3D ARRAY_SIZE(lm3532_ramp_table),
+	},
+	{
+		.reginfo		=3D &lm3631_reg_info,
+		.num_channels		=3D LM3631_MAX_CHANNELS,
+		.max_brightness		=3D MAX_BRIGHTNESS_11BIT,
+		.pwm_action		=3D UPDATE_PWM_ONLY,
+		.ramp_table		=3D lm3631_ramp_table,
+		.size_ramp		=3D ARRAY_SIZE(lm3631_ramp_table),
+	},
+	{
+		.reginfo		=3D &lm3632_reg_info,
+		.num_channels		=3D LM3632_MAX_CHANNELS,
+		.max_brightness		=3D MAX_BRIGHTNESS_11BIT,
+		.pwm_action		=3D UPDATE_PWM_ONLY,
+	},
+	{
+		.reginfo		=3D &lm3633_reg_info,
+		.num_channels		=3D LM3633_MAX_CHANNELS,
+		.max_brightness		=3D MAX_BRIGHTNESS_11BIT,
+		.pwm_action		=3D UPDATE_MAX_BRT,
+		.ramp_table		=3D common_ramp_table,
+		.size_ramp		=3D ARRAY_SIZE(common_ramp_table),
+		.fault_monitor_used	=3D true,
+	},
+	{
+		.reginfo		=3D &lm3695_reg_info,
+		.num_channels		=3D LM3695_MAX_CHANNELS,
+		.max_brightness		=3D MAX_BRIGHTNESS_11BIT,
+		.pwm_action		=3D UPDATE_PWM_AND_BRT_REGISTER,
+	},
+	{
+		.reginfo		=3D &lm3697_reg_info,
+		.num_channels		=3D LM3697_MAX_CHANNELS,
+		.max_brightness		=3D MAX_BRIGHTNESS_11BIT,
+		.pwm_action		=3D UPDATE_PWM_AND_BRT_REGISTER,
+		.ramp_table		=3D common_ramp_table,
+		.size_ramp		=3D ARRAY_SIZE(common_ramp_table),
+		.fault_monitor_used	=3D true,
+	},
+};
diff --git a/drivers/leds/ti-lmu-backlight-data.h b/drivers/leds/ti-lmu-bac=
klight-data.h
new file mode 100644
index 0000000..c64e8e6
--- /dev/null
+++ b/drivers/leds/ti-lmu-backlight-data.h
@@ -0,0 +1,95 @@
+/*
+ * TI LMU (Lighting Management Unit) Backlight Device Data Definitions
+ *
+ * Copyright 2015 Texas Instruments
+ *
+ * Author: Milo Kim <milo.kim@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __TI_LMU_BACKLIGHT_H__
+#define __TI_LMU_BACKLIGHT_H__
+
+#include <linux/mfd/ti-lmu.h>
+#include <linux/mfd/ti-lmu-register.h>
+
+#define MAX_BRIGHTNESS_8BIT		255
+#define MAX_BRIGHTNESS_11BIT		2047
+
+enum ti_lmu_bl_pwm_action {
+	/* Update PWM duty, no brightness register update is required */
+	UPDATE_PWM_ONLY,
+	/* Update not only duty but also brightness register */
+	UPDATE_PWM_AND_BRT_REGISTER,
+	/* Update max value in brightness registers */
+	UPDATE_MAX_BRT,
+};
+
+struct lmu_bl_reg_data {
+	u8 reg;
+	u8 mask;
+	u8 val;
+};
+
+/**
+ * struct ti_lmu_bl_reg
+ *
+ * @init:		Device initialization registers
+ * @num_init:		Numbers of initialization registers
+ * @channel:		Backlight channel configuration registers
+ * @mode:		Brightness control mode registers
+ * @ramp:		Ramp registers for lighting effect
+ * @ramp_reg_offset:	Ramp register offset.
+ *			Only used for multiple ramp registers.
+ * @enable:		Enable control register address
+ * @enable_usec:	Delay time for updating enable register.
+ *			Unit is microsecond.
+ * @brightness_msb:	Brightness MSB(Upper 8 bits) registers.
+ *			Concatenated with LSB in 11 bit dimming mode.
+ *			In 8 bit dimming, only MSB is used.
+ * @brightness_lsb:	Brightness LSB(Lower 3 bits) registers.
+ *			Only valid in 11 bit dimming mode.
+ */
+struct ti_lmu_bl_reg {
+	const struct lmu_bl_reg_data *init;
+	int num_init;
+	const struct lmu_bl_reg_data *channel;
+	const struct lmu_bl_reg_data *mode;
+	const struct lmu_bl_reg_data *ramp;
+	int ramp_reg_offset;
+	u8 *enable;
+	unsigned long enable_usec;
+	u8 *brightness_msb;
+	u8 *brightness_lsb;
+};
+
+/**
+ * struct ti_lmu_bl_cfg
+ *
+ * @reginfo:		Device register configuration
+ * @num_channels:	Number of backlight channels
+ * @max_brightness:	Max brightness value of backlight device
+ * @pwm_action:		How to control brightness registers in PWM mode
+ * @ramp_table:		[Optional] Ramp time table for lighting effect.
+ *			It's used for searching approximate register index.
+ * @size_ramp:		[Optional] Size of ramp table
+ * @fault_monitor_used:	[Optional] Set true if the device needs to handle
+ *			LMU fault monitor event.
+ *
+ * This structure is used for device specific data configuration.
+ */
+struct ti_lmu_bl_cfg {
+	const struct ti_lmu_bl_reg *reginfo;
+	int num_channels;
+	int max_brightness;
+	enum ti_lmu_bl_pwm_action pwm_action;
+	int *ramp_table;
+	int size_ramp;
+	bool fault_monitor_used;
+};
+
+extern const struct ti_lmu_bl_cfg lmu_bl_cfg[LMU_MAX_ID];
+#endif
=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluHDiAACgkQMOfwapXb+vKzgwCfX8mQtulW8hTYQVMVUIRfAXRI
U1IAoLU/QXNenJyEI/NB9HqdEgtDVoD8
=/hnd
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
