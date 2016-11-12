From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Subject: [PATCH] mfd: twl-core: make driver DT only
Date: Sat, 12 Nov 2016 14:02:33 +0200
Message-ID: <1478952153-26592-1-git-send-email-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-omap@vger.kernel.org, Nicolae Rosia <Nicolae_Rosia@mentor.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

All users are DT-only and it makes no sense to keep
unused code

Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
---
 drivers/mfd/Kconfig    |   1 +
 drivers/mfd/twl-core.c | 395 ++-----------------------------------------------
 2 files changed, 10 insertions(+), 386 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index c6df644..c180f8b 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1333,6 +1333,7 @@ config MFD_TPS80031
 config TWL4030_CORE
 	bool "TI TWL4030/TWL5030/TWL6030/TPS659x0 Support"
 	depends on I2C=y
+	depends on OF
 	select IRQ_DOMAIN
 	select REGMAP_I2C
 	help
diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index c64615d..2025326 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -13,6 +13,9 @@
  * Code cleanup and modifications to IRQ handler.
  * by syed khasim <x0khasim@ti.com>
  *
+ * Code cleanup and modifications:
+ * Copyright (C) 2016 Nicolae Rosia <nicolae.rosia@gmail.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -604,376 +607,6 @@ int twl_get_hfclk_rate(void)
 }
 EXPORT_SYMBOL_GPL(twl_get_hfclk_rate);
 
-static struct device *
-add_numbered_child(unsigned mod_no, const char *name, int num,
-		void *pdata, unsigned pdata_len,
-		bool can_wakeup, int irq0, int irq1)
-{
-	struct platform_device	*pdev;
-	struct twl_client	*twl;
-	int			status, sid;
-
-	if (unlikely(mod_no >= twl_get_last_module())) {
-		pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
-		return ERR_PTR(-EPERM);
-	}
-	sid = twl_priv->twl_map[mod_no].sid;
-	twl = &twl_priv->twl_modules[sid];
-
-	pdev = platform_device_alloc(name, num);
-	if (!pdev)
-		return ERR_PTR(-ENOMEM);
-
-	pdev->dev.parent = &twl->client->dev;
-
-	if (pdata) {
-		status = platform_device_add_data(pdev, pdata, pdata_len);
-		if (status < 0) {
-			dev_dbg(&pdev->dev, "can't add platform_data\n");
-			goto put_device;
-		}
-	}
-
-	if (irq0) {
-		struct resource r[2] = {
-			{ .start = irq0, .flags = IORESOURCE_IRQ, },
-			{ .start = irq1, .flags = IORESOURCE_IRQ, },
-		};
-
-		status = platform_device_add_resources(pdev, r, irq1 ? 2 : 1);
-		if (status < 0) {
-			dev_dbg(&pdev->dev, "can't add irqs\n");
-			goto put_device;
-		}
-	}
-
-	status = platform_device_add(pdev);
-	if (status)
-		goto put_device;
-
-	device_init_wakeup(&pdev->dev, can_wakeup);
-
-	return &pdev->dev;
-
-put_device:
-	platform_device_put(pdev);
-	dev_err(&twl->client->dev, "failed to add device %s\n", name);
-	return ERR_PTR(status);
-}
-
-static inline struct device *add_child(unsigned mod_no, const char *name,
-		void *pdata, unsigned pdata_len,
-		bool can_wakeup, int irq0, int irq1)
-{
-	return add_numbered_child(mod_no, name, -1, pdata, pdata_len,
-		can_wakeup, irq0, irq1);
-}
-
-static struct device *
-add_regulator_linked(int num, struct regulator_init_data *pdata,
-		struct regulator_consumer_supply *consumers,
-		unsigned num_consumers, unsigned long features)
-{
-	struct twl_regulator_driver_data drv_data;
-
-	/* regulator framework demands init_data ... */
-	if (!pdata)
-		return NULL;
-
-	if (consumers) {
-		pdata->consumer_supplies = consumers;
-		pdata->num_consumer_supplies = num_consumers;
-	}
-
-	if (pdata->driver_data) {
-		/* If we have existing drv_data, just add the flags */
-		struct twl_regulator_driver_data *tmp;
-		tmp = pdata->driver_data;
-		tmp->features |= features;
-	} else {
-		/* add new driver data struct, used only during init */
-		drv_data.features = features;
-		drv_data.set_voltage = NULL;
-		drv_data.get_voltage = NULL;
-		drv_data.data = NULL;
-		pdata->driver_data = &drv_data;
-	}
-
-	/* NOTE:  we currently ignore regulator IRQs, e.g. for short circuits */
-	return add_numbered_child(TWL_MODULE_PM_MASTER, "twl_reg", num,
-		pdata, sizeof(*pdata), false, 0, 0);
-}
-
-static struct device *
-add_regulator(int num, struct regulator_init_data *pdata,
-		unsigned long features)
-{
-	return add_regulator_linked(num, pdata, NULL, 0, features);
-}
-
-/*
- * NOTE:  We know the first 8 IRQs after pdata->base_irq are
- * for the PIH, and the next are for the PWR_INT SIH, since
- * that's how twl_init_irq() sets things up.
- */
-
-static int
-add_children(struct twl4030_platform_data *pdata, unsigned irq_base,
-		unsigned long features)
-{
-	struct device	*child;
-
-	if (IS_ENABLED(CONFIG_GPIO_TWL4030) && pdata->gpio) {
-		child = add_child(TWL4030_MODULE_GPIO, "twl4030_gpio",
-				pdata->gpio, sizeof(*pdata->gpio),
-				false, irq_base + GPIO_INTR_OFFSET, 0);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	if (IS_ENABLED(CONFIG_KEYBOARD_TWL4030) && pdata->keypad) {
-		child = add_child(TWL4030_MODULE_KEYPAD, "twl4030_keypad",
-				pdata->keypad, sizeof(*pdata->keypad),
-				true, irq_base + KEYPAD_INTR_OFFSET, 0);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	if (IS_ENABLED(CONFIG_TWL4030_MADC) && pdata->madc &&
-	    twl_class_is_4030()) {
-		child = add_child(TWL4030_MODULE_MADC, "twl4030_madc",
-				pdata->madc, sizeof(*pdata->madc),
-				true, irq_base + MADC_INTR_OFFSET, 0);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	if (IS_ENABLED(CONFIG_RTC_DRV_TWL4030)) {
-		/*
-		 * REVISIT platform_data here currently might expose the
-		 * "msecure" line ... but for now we just expect board
-		 * setup to tell the chip "it's always ok to SET_TIME".
-		 * Eventually, Linux might become more aware of such
-		 * HW security concerns, and "least privilege".
-		 */
-		child = add_child(TWL_MODULE_RTC, "twl_rtc", NULL, 0,
-				true, irq_base + RTC_INTR_OFFSET, 0);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	if (IS_ENABLED(CONFIG_PWM_TWL)) {
-		child = add_child(TWL_MODULE_PWM, "twl-pwm", NULL, 0,
-				  false, 0, 0);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	if (IS_ENABLED(CONFIG_PWM_TWL_LED)) {
-		child = add_child(TWL_MODULE_LED, "twl-pwmled", NULL, 0,
-				  false, 0, 0);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	if (IS_ENABLED(CONFIG_TWL4030_USB) && pdata->usb &&
-	    twl_class_is_4030()) {
-
-		static struct regulator_consumer_supply usb1v5 = {
-			.supply =	"usb1v5",
-		};
-		static struct regulator_consumer_supply usb1v8 = {
-			.supply =	"usb1v8",
-		};
-		static struct regulator_consumer_supply usb3v1 = {
-			.supply =	"usb3v1",
-		};
-
-	/* First add the regulators so that they can be used by transceiver */
-		if (IS_ENABLED(CONFIG_REGULATOR_TWL4030)) {
-			/* this is a template that gets copied */
-			struct regulator_init_data usb_fixed = {
-				.constraints.valid_modes_mask =
-					REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-				.constraints.valid_ops_mask =
-					REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-			};
-
-			child = add_regulator_linked(TWL4030_REG_VUSB1V5,
-						      &usb_fixed, &usb1v5, 1,
-						      features);
-			if (IS_ERR(child))
-				return PTR_ERR(child);
-
-			child = add_regulator_linked(TWL4030_REG_VUSB1V8,
-						      &usb_fixed, &usb1v8, 1,
-						      features);
-			if (IS_ERR(child))
-				return PTR_ERR(child);
-
-			child = add_regulator_linked(TWL4030_REG_VUSB3V1,
-						      &usb_fixed, &usb3v1, 1,
-						      features);
-			if (IS_ERR(child))
-				return PTR_ERR(child);
-
-		}
-
-		child = add_child(TWL_MODULE_USB, "twl4030_usb",
-				pdata->usb, sizeof(*pdata->usb), true,
-				/* irq0 = USB_PRES, irq1 = USB */
-				irq_base + USB_PRES_INTR_OFFSET,
-				irq_base + USB_INTR_OFFSET);
-
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		/* we need to connect regulators to this transceiver */
-		if (IS_ENABLED(CONFIG_REGULATOR_TWL4030) && child) {
-			usb1v5.dev_name = dev_name(child);
-			usb1v8.dev_name = dev_name(child);
-			usb3v1.dev_name = dev_name(child);
-		}
-	}
-
-	if (IS_ENABLED(CONFIG_TWL4030_WATCHDOG) && twl_class_is_4030()) {
-		child = add_child(TWL_MODULE_PM_RECEIVER, "twl4030_wdt", NULL,
-				  0, false, 0, 0);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	if (IS_ENABLED(CONFIG_INPUT_TWL4030_PWRBUTTON) && twl_class_is_4030()) {
-		child = add_child(TWL_MODULE_PM_MASTER, "twl4030_pwrbutton",
-				  NULL, 0, true, irq_base + 8 + 0, 0);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	if (IS_ENABLED(CONFIG_MFD_TWL4030_AUDIO) && pdata->audio &&
-	    twl_class_is_4030()) {
-		child = add_child(TWL4030_MODULE_AUDIO_VOICE, "twl4030-audio",
-				pdata->audio, sizeof(*pdata->audio),
-				false, 0, 0);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	/* twl4030 regulators */
-	if (IS_ENABLED(CONFIG_REGULATOR_TWL4030) && twl_class_is_4030()) {
-		child = add_regulator(TWL4030_REG_VPLL1, pdata->vpll1,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VIO, pdata->vio,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VDD1, pdata->vdd1,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VDD2, pdata->vdd2,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VMMC1, pdata->vmmc1,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VDAC, pdata->vdac,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator((features & TWL4030_VAUX2)
-					? TWL4030_REG_VAUX2_4030
-					: TWL4030_REG_VAUX2,
-				pdata->vaux2, features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VINTANA1, pdata->vintana1,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VINTANA2, pdata->vintana2,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VINTDIG, pdata->vintdig,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	/* maybe add LDOs that are omitted on cost-reduced parts */
-	if (IS_ENABLED(CONFIG_REGULATOR_TWL4030) && !(features & TPS_SUBSET)
-	  && twl_class_is_4030()) {
-		child = add_regulator(TWL4030_REG_VPLL2, pdata->vpll2,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VMMC2, pdata->vmmc2,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VSIM, pdata->vsim,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VAUX1, pdata->vaux1,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VAUX3, pdata->vaux3,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VAUX4, pdata->vaux4,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	if (IS_ENABLED(CONFIG_CHARGER_TWL4030) && pdata->bci &&
-			!(features & (TPS_SUBSET | TWL5031))) {
-		child = add_child(TWL_MODULE_MAIN_CHARGE, "twl4030_bci",
-				pdata->bci, sizeof(*pdata->bci), false,
-				/* irq0 = CHG_PRES, irq1 = BCI */
-				irq_base + BCI_PRES_INTR_OFFSET,
-				irq_base + BCI_INTR_OFFSET);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	if (IS_ENABLED(CONFIG_TWL4030_POWER) && pdata->power) {
-		child = add_child(TWL_MODULE_PM_MASTER, "twl4030_power",
-				  pdata->power, sizeof(*pdata->power), false,
-				  0, 0);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	return 0;
-}
-
-/*----------------------------------------------------------------------*/
-
 /*
  * These three functions initialize the on-chip clock framework,
  * letting it generate the right frequencies for USB, MADC, and
@@ -1000,8 +633,7 @@ static inline int __init unprotect_pm_master(void)
 	return e;
 }
 
-static void clocks_init(struct device *dev,
-			struct twl4030_clock_init_data *clock)
+static void clocks_init(struct device *dev)
 {
 	int e = 0;
 	struct clk *osc;
@@ -1031,8 +663,6 @@ static void clocks_init(struct device *dev,
 	}
 
 	ctrl |= HIGH_PERF_SQ;
-	if (clock && clock->ck32k_lowpwr_enable)
-		ctrl |= CK32K_LOWPWR_EN;
 
 	e |= unprotect_pm_master();
 	/* effect->MADC+USB ck en */
@@ -1080,7 +710,6 @@ static struct of_dev_auxdata twl_auxdata_lookup[] = {
 static int
 twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
-	struct twl4030_platform_data	*pdata = dev_get_platdata(&client->dev);
 	struct device_node		*node = client->dev.of_node;
 	struct platform_device		*pdev;
 	const struct regmap_config	*twl_regmap_config;
@@ -1088,8 +717,8 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	int				status;
 	unsigned			i, num_slaves;
 
-	if (!node && !pdata) {
-		dev_err(&client->dev, "no platform data\n");
+	if (!node) {
+		dev_err(&client->dev, "no DT info\n");
 		return -EINVAL;
 	}
 
@@ -1177,7 +806,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	twl_priv->ready = true;
 
 	/* setup clock framework */
-	clocks_init(&pdev->dev, pdata ? pdata->clock : NULL);
+	clocks_init(&pdev->dev);
 
 	/* read TWL IDCODE Register */
 	if (twl_class_is_4030()) {
@@ -1225,14 +854,8 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 				 TWL4030_DCDC_GLOBAL_CFG);
 	}
 
-	if (node) {
-		if (pdata)
-			twl_auxdata_lookup[0].platform_data = pdata->gpio;
-		status = of_platform_populate(node, NULL, twl_auxdata_lookup,
-					      &client->dev);
-	} else {
-		status = add_children(pdata, irq_base, id->driver_data);
-	}
+	status = of_platform_populate(node, NULL, twl_auxdata_lookup,
+					&client->dev);
 
 fail:
 	if (status < 0)
-- 
2.5.5
