From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 3/7] mfd: menelaus: add initial DT support
Date: Sat, 27 Dec 2014 19:52:55 +0200
Message-ID: <1419702779-16001-4-git-send-email-aaro.koskinen@iki.fi>
References: <1419702779-16001-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:45576 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbaL0RxR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Dec 2014 12:53:17 -0500
In-Reply-To: <1419702779-16001-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Add initial DT support.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 Documentation/devicetree/bindings/mfd/menelaus.txt | 30 +++++++++++++
 drivers/mfd/menelaus.c                             | 52 ++++++++++++++++++++--
 2 files changed, 78 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/menelaus.txt

diff --git a/Documentation/devicetree/bindings/mfd/menelaus.txt b/Documentation/devicetree/bindings/mfd/menelaus.txt
new file mode 100644
index 0000000..5f69f23
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/menelaus.txt
@@ -0,0 +1,30 @@
+Menelaus (Texas Instruments TWL92330) Power Management chip
+
+Menelaus provides facilities to control the power resources.
+
+Required properties:
+- compatible: must be "menelaus"
+- reg: I2C address of the chip
+
+Optional properties:
+- interrupts: the interrupt
+- ti,autosleep: All regulators are put to sleep by default.
+- ti,vcore-min-microvolt: Range floor for the HW controlled VCORE
+- ti,vcore-max-microvolt: Range roof for the HW controlled VCORE
+
+The use of ti,autosleep is recommended at least on Nokia N800/N810.
+
+Example:
+
+&i2c1 {
+	clock-frequency = <400000>;
+
+	pmic@72 {
+		compatible = "menelaus";
+		reg = <0x72>;
+		interrupts = <7 IRQ_TYPE_EDGE_RISING>;
+		ti,autosleep;
+		ti,vcore-min-microvolt = <1050000>;
+		ti,vcore-max-microvolt = <1400000>;
+	};
+};
diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index 917fa86..3e04c64 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -16,6 +16,8 @@
  * Amit Kucheria <amit.kucheria@nokia.com>
  * Copyright (C) 2005, 2006 Nokia Corporation
  *
+ * Cleanups and DT modifications by Aaro Koskinen <aaro.koskinen@iki.fi>.
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -767,6 +769,22 @@ out:
 	return ret;
 }
 
+static int menelaus_auto_sleep_regulators(void)
+{
+	u32 val;
+	int ret;
+
+	val = EN_VPLL_SLEEP | EN_VMMC_SLEEP | EN_VAUX_SLEEP | EN_VIO_SLEEP | \
+	      EN_VMEM_SLEEP | EN_DC3_SLEEP  | EN_VC_SLEEP   | EN_DC2_SLEEP;
+	ret = menelaus_set_regulator_sleep(1, val);
+	if (ret < 0) {
+		dev_err(&the_menelaus->client->dev,
+			"could not set regulators to sleep: %d\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
 /*-----------------------------------------------------------------------*/
 
 /* Handles Menelaus interrupts. Does not run in interrupt context */
@@ -1162,6 +1180,7 @@ static int menelaus_probe(struct i2c_client *client,
 	struct menelaus_chip	*menelaus;
 	int			rev = 0;
 	int			err = 0;
+	struct device_node	*np = client->dev.of_node;
 	struct menelaus_platform_data *menelaus_pdata =
 					dev_get_platdata(&client->dev);
 
@@ -1221,10 +1240,35 @@ static int menelaus_probe(struct i2c_client *client,
 	else
 		menelaus->vcore_hw_mode = 0;
 
-	if (menelaus_pdata != NULL && menelaus_pdata->late_init != NULL) {
-		err = menelaus_pdata->late_init(&client->dev);
-		if (err < 0)
-			goto fail;
+	if (menelaus_pdata != NULL) {
+		if (menelaus_pdata->late_init != NULL) {
+			err = menelaus_pdata->late_init(&client->dev);
+			if (err < 0)
+				goto fail;
+		}
+	} else if (np) {
+		u32 vcore_min;
+		u32 vcore_max;
+
+		if (!of_property_read_u32(np, "ti,vcore-min-microvolt",
+					  &vcore_min) &&
+		    !of_property_read_u32(np, "ti,vcore-max-microvolt",
+					  &vcore_max)) {
+			err = menelaus_set_vcore_hw(vcore_max / 1000,
+						    vcore_min / 1000);
+			if (err < 0) {
+				dev_err(&client->dev,
+					"could not set VCORE voltage: %d\n",
+					err);
+				goto fail;
+			}
+		}
+
+		if (of_property_read_bool(np, "ti,autosleep")) {
+			err = menelaus_auto_sleep_regulators();
+			if (err < 0)
+				goto fail;
+		}
 	}
 
 	menelaus_rtc_init(menelaus);
-- 
2.2.0

