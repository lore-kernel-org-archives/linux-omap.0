From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/5] regulator: twl: remap has no meaning for 6030
Date: Fri,  1 Apr 2011 10:22:43 +0530
Message-ID: <1301633566-5212-3-git-send-email-nm@ti.com>
References: <1301633566-5212-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:57254 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751399Ab1DAExP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 00:53:15 -0400
Received: by mail-gx0-f178.google.com with SMTP id 8so1228745gxk.9
        for <linux-omap@vger.kernel.org>; Thu, 31 Mar 2011 21:53:14 -0700 (PDT)
In-Reply-To: <1301633566-5212-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Saquib <saquib@ti.com>, Nishanth Menon <nm@ti.com>

From: Saquib Herman <saquib@ti.com>

TWL6030 does not have remap register. The current implementation
causes value of remap to be written to state register, accidentally
causing the regulators which are probed to be switched on as well.
This is wrong as regulators should be controllable based on calls
to enable/disable for TWL regulator framework. Further, the values
initialized make no sense as well. We hence remove this from the
initalizers and also write to remap register only if the TWL
is 4030.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Saquib Herman <saquib@ti.com>
---
 drivers/regulator/twl-regulator.c |   37 +++++++++++++++++--------------------
 1 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 3e9060c..2e88865 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -517,10 +517,9 @@ static struct regulator_ops twl6030_fixed_resource = {
 			remap_conf) \
 		TWL_FIXED_LDO(label, offset, mVolts, num, turnon_delay, \
 			remap_conf, TWL4030)
-#define TWL6030_FIXED_LDO(label, offset, mVolts, num, turnon_delay, \
-			remap_conf) \
+#define TWL6030_FIXED_LDO(label, offset, mVolts, num, turnon_delay) \
 		TWL_FIXED_LDO(label, offset, mVolts, num, turnon_delay, \
-			remap_conf, TWL6030)
+			0x0, TWL6030)
 
 #define TWL4030_ADJUSTABLE_LDO(label, offset, num, turnon_delay, remap_conf) { \
 	.base = offset, \
@@ -539,13 +538,11 @@ static struct regulator_ops twl6030_fixed_resource = {
 		}, \
 	}
 
-#define TWL6030_ADJUSTABLE_LDO(label, offset, min_mVolts, max_mVolts, num, \
-		remap_conf) { \
+#define TWL6030_ADJUSTABLE_LDO(label, offset, min_mVolts, max_mVolts, num) { \
 	.base = offset, \
 	.id = num, \
 	.min_mV = min_mVolts, \
 	.max_mV = max_mVolts, \
-	.remap = remap_conf, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL6030_REG_##label, \
@@ -574,11 +571,10 @@ static struct regulator_ops twl6030_fixed_resource = {
 		}, \
 	}
 
-#define TWL6030_FIXED_RESOURCE(label, offset, num, turnon_delay, remap_conf) { \
+#define TWL6030_FIXED_RESOURCE(label, offset, num, turnon_delay) { \
 	.base = offset, \
 	.id = num, \
 	.delay = turnon_delay, \
-	.remap = remap_conf, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL6030_REG_##label, \
@@ -618,17 +614,17 @@ static struct twlreg_info twl_regs[] = {
 	/* 6030 REG with base as PMC Slave Misc : 0x0030 */
 	/* Turnon-delay and remap configuration values for 6030 are not
 	   verified since the specification is not public */
-	TWL6030_ADJUSTABLE_LDO(VAUX1_6030, 0x54, 1000, 3300, 1, 0x21),
-	TWL6030_ADJUSTABLE_LDO(VAUX2_6030, 0x58, 1000, 3300, 2, 0x21),
-	TWL6030_ADJUSTABLE_LDO(VAUX3_6030, 0x5c, 1000, 3300, 3, 0x21),
-	TWL6030_ADJUSTABLE_LDO(VMMC, 0x68, 1000, 3300, 4, 0x21),
-	TWL6030_ADJUSTABLE_LDO(VPP, 0x6c, 1000, 3300, 5, 0x21),
-	TWL6030_ADJUSTABLE_LDO(VUSIM, 0x74, 1000, 3300, 7, 0x21),
-	TWL6030_FIXED_LDO(VANA, 0x50, 2100, 15, 0, 0x21),
-	TWL6030_FIXED_LDO(VCXIO, 0x60, 1800, 16, 0, 0x21),
-	TWL6030_FIXED_LDO(VDAC, 0x64, 1800, 17, 0, 0x21),
-	TWL6030_FIXED_LDO(VUSB, 0x70, 3300, 18, 0, 0x21),
-	TWL6030_FIXED_RESOURCE(CLK32KG, 0x8C, 48, 0, 0x21),
+	TWL6030_ADJUSTABLE_LDO(VAUX1_6030, 0x54, 1000, 3300, 1),
+	TWL6030_ADJUSTABLE_LDO(VAUX2_6030, 0x58, 1000, 3300, 2),
+	TWL6030_ADJUSTABLE_LDO(VAUX3_6030, 0x5c, 1000, 3300, 3),
+	TWL6030_ADJUSTABLE_LDO(VMMC, 0x68, 1000, 3300, 4),
+	TWL6030_ADJUSTABLE_LDO(VPP, 0x6c, 1000, 3300, 5),
+	TWL6030_ADJUSTABLE_LDO(VUSIM, 0x74, 1000, 3300, 7),
+	TWL6030_FIXED_LDO(VANA, 0x50, 2100, 15, 0),
+	TWL6030_FIXED_LDO(VCXIO, 0x60, 1800, 16, 0),
+	TWL6030_FIXED_LDO(VDAC, 0x64, 1800, 17, 0),
+	TWL6030_FIXED_LDO(VUSB, 0x70, 3300, 18, 0),
+	TWL6030_FIXED_RESOURCE(CLK32KG, 0x8C, 48, 0),
 };
 
 static int __devinit twlreg_probe(struct platform_device *pdev)
@@ -682,7 +678,8 @@ static int __devinit twlreg_probe(struct platform_device *pdev)
 	}
 	platform_set_drvdata(pdev, rdev);
 
-	twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_REMAP,
+	if (twl_class_is_4030())
+		twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_REMAP,
 						info->remap);
 
 	/* NOTE:  many regulators support short-circuit IRQs (presentable
-- 
1.7.1

