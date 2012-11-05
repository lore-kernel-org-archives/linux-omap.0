From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 1/4] mfd: tps65217: Set PMIC to shutdowm on PWR_EN toggle
Date: Mon, 5 Nov 2012 15:12:26 +0530
Message-ID: <1352108549-9341-2-git-send-email-anilkumar@ti.com>
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60482 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752673Ab2KEJnH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 04:43:07 -0500
In-Reply-To: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: a.zummo@towertech.it, sameo@linux.intel.com, tony@atomide.com
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Colin Foe-Parker <colin.foeparker@logicpd.com>, AnilKumar Ch <anilkumar@ti.com>

From: Colin Foe-Parker <colin.foeparker@logicpd.com>

Set tps65217 PMIC status to OFF if power enable toggle is
supported. Also adds platform data flag, which should be
passed from board init data.

Signed-off-by: Colin Foe-Parker <colin.foeparker@logicpd.com>
[anilkumar@ti.com: move the additions to tps65217 MFD driver]
Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 .../devicetree/bindings/regulator/tps65217.txt     |    4 ++++
 drivers/mfd/tps65217.c                             |   12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/tps65217.txt b/Documentation/devicetree/bindings/regulator/tps65217.txt
index d316fb8..4f05d20 100644
--- a/Documentation/devicetree/bindings/regulator/tps65217.txt
+++ b/Documentation/devicetree/bindings/regulator/tps65217.txt
@@ -11,6 +11,9 @@ Required properties:
   using the standard binding for regulators found at
   Documentation/devicetree/bindings/regulator/regulator.txt.
 
+Optional properties:
+- ti,pmic-shutdown-controller: Telling the PMIC to shutdown on PWR_EN toggle.
+
   The valid names for regulators are:
   tps65217: dcdc1, dcdc2, dcdc3, ldo1, ldo2, ldo3 and ldo4
 
@@ -20,6 +23,7 @@ Example:
 
 	tps: tps@24 {
 		compatible = "ti,tps65217";
+		ti,pmic-shutdown-controller;
 
 		regulators {
 			dcdc1_reg: dcdc1 {
diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index 3fb32e6..c7f17d8 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -160,6 +160,7 @@ static int __devinit tps65217_probe(struct i2c_client *client,
 	unsigned int version;
 	unsigned int chip_id = ids->driver_data;
 	const struct of_device_id *match;
+	bool status_off = false;
 	int ret;
 
 	if (client->dev.of_node) {
@@ -170,6 +171,8 @@ static int __devinit tps65217_probe(struct i2c_client *client,
 			return -EINVAL;
 		}
 		chip_id = (unsigned int)match->data;
+		status_off = of_property_read_bool(client->dev.of_node,
+					"ti,pmic-shutdown-controller");
 	}
 
 	if (!chip_id) {
@@ -207,6 +210,15 @@ static int __devinit tps65217_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	/* Set the PMIC to shutdown on PWR_EN toggle */
+	if (status_off) {
+		ret = tps65217_set_bits(tps, TPS65217_REG_STATUS,
+				TPS65217_STATUS_OFF, TPS65217_STATUS_OFF,
+				TPS65217_PROTECT_NONE);
+		if (ret)
+			dev_warn(tps->dev, "unable to set the status OFF\n");
+	}
+
 	dev_info(tps->dev, "TPS65217 ID %#x version 1.%d\n",
 			(version & TPS65217_CHIPID_CHIP_MASK) >> 4,
 			version & TPS65217_CHIPID_REV_MASK);
-- 
1.7.9.5

