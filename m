From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 1/2] regulator: twl: add clk32kg to twl-regulator
Date: Thu, 10 Feb 2011 18:44:50 +0530
Message-ID: <1297343690-4557-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57260 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179Ab1BJNMn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 08:12:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, sameo@linux.intel.com, linux-omap@vger.kernel.org
Cc: tony@atomide.com, Balaji T K <balajitk@ti.com>

In OMAP4 Blaze and Panda, 32KHz clock to WLAN is supplied from Phoenix TWL6030.
The 32KHz clock state (ON/OFF) is configured in CLK32KG_CFG_[GRP, TRANS, STATE]
register. This follows the same register programming model as other regulators
in TWL6030. So add CLK32KG as pseudo regulator.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
v2 changes:
implement TWL6030_FIXED_RESOURCE for clk32kg

 drivers/mfd/twl-core.c            |    4 ++++
 drivers/regulator/twl-regulator.c |   24 +++++++++++++++++++++++-
 include/linux/i2c/twl.h           |    2 ++
 3 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index a35fa7d..7d909cc 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -864,6 +864,10 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 		child = add_regulator(TWL6030_REG_VAUX3_6030, pdata->vaux3);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
+
+		child = add_regulator(TWL6030_REG_CLK32KG, pdata->clk32kg);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
 	}
 
 	if (twl_has_bci() && pdata->bci &&
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index bd332cf..6a29285 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -475,6 +475,13 @@ static struct regulator_ops twlfixed_ops = {
 	.get_status	= twlreg_get_status,
 };
 
+static struct regulator_ops twl6030_fixed_resource = {
+	.enable		= twlreg_enable,
+	.disable	= twlreg_disable,
+	.is_enabled	= twlreg_is_enabled,
+	.get_status	= twlreg_get_status,
+};
+
 /*----------------------------------------------------------------------*/
 
 #define TWL4030_FIXED_LDO(label, offset, mVolts, num, turnon_delay, \
@@ -538,6 +545,20 @@ static struct regulator_ops twlfixed_ops = {
 		}, \
 	}
 
+#define TWL6030_FIXED_RESOURCE(label, offset, num, turnon_delay, remap_conf) { \
+	.base = offset, \
+	.id = num, \
+	.delay = turnon_delay, \
+	.remap = remap_conf, \
+	.desc = { \
+		.name = #label, \
+		.id = TWL6030_REG_##label, \
+		.ops = &twl6030_fixed_resource, \
+		.type = REGULATOR_VOLTAGE, \
+		.owner = THIS_MODULE, \
+		}, \
+	}
+
 /*
  * We list regulators here if systems need some level of
  * software control over them after boot.
@@ -577,7 +598,8 @@ static struct twlreg_info twl_regs[] = {
 	TWL6030_FIXED_LDO(VANA, 0x50, 2100, 15, 0, 0x21),
 	TWL6030_FIXED_LDO(VCXIO, 0x60, 1800, 16, 0, 0x21),
 	TWL6030_FIXED_LDO(VDAC, 0x64, 1800, 17, 0, 0x21),
-	TWL6030_FIXED_LDO(VUSB, 0x70, 3300, 18, 0, 0x21)
+	TWL6030_FIXED_LDO(VUSB, 0x70, 3300, 18, 0, 0x21),
+	TWL6030_FIXED_RESOURCE(CLK32KG, 0x8C, 48, 0, 0x21),
 };
 
 static int __devinit twlreg_probe(struct platform_device *pdev)
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 61b9609..7086e1e 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -698,6 +698,7 @@ struct twl4030_platform_data {
 	struct regulator_init_data              *vana;
 	struct regulator_init_data              *vcxio;
 	struct regulator_init_data              *vusb;
+	struct regulator_init_data		*clk32kg;
 };
 
 /*----------------------------------------------------------------------*/
@@ -777,5 +778,6 @@ static inline int twl4030charger_usb_en(int enable) { return 0; }
 
 /* INTERNAL LDOs */
 #define TWL6030_REG_VRTC	47
+#define TWL6030_REG_CLK32KG	48
 
 #endif /* End of __TWL4030_H */
-- 
1.7.0.4

