From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv10 4/4] omap3: twl: add external controllers for core voltage regulators
Date: Mon, 20 Feb 2012 12:26:08 +0200
Message-ID: <1329733568-26676-5-git-send-email-t-kristo@ti.com>
References: <1329733568-26676-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45839 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752199Ab2BTK0c (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Feb 2012 05:26:32 -0500
In-Reply-To: <1329733568-26676-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

VDD1 and VDD2 now use voltage processor for controlling the regulators.
This is done by passing additional voltdm data during the regulator init.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/twl-common.c |   33 +++++++++++++++++++++++++++++++--
 1 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 5f62e51..0c453e7 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -31,12 +31,25 @@
 
 #include "twl-common.h"
 #include "pm.h"
+#include "voltage.h"
 
 static struct i2c_board_info __initdata pmic_i2c_board_info = {
 	.addr		= 0x48,
 	.flags		= I2C_CLIENT_WAKE,
 };
 
+static int twl_set_voltage(void *data, int target_uV)
+{
+	struct voltagedomain *voltdm = (struct voltagedomain *)data;
+	return voltdm_scale(voltdm, target_uV);
+}
+
+static int twl_get_voltage(void *data)
+{
+	struct voltagedomain *voltdm = (struct voltagedomain *)data;
+	return voltdm_get_voltage(voltdm);
+}
+
 void __init omap_pmic_init(int bus, u32 clkrate,
 			   const char *pmic_type, int pmic_irq,
 			   struct twl4030_platform_data *pmic_data)
@@ -158,6 +171,16 @@ static struct regulator_init_data omap3_vdd2 = {
 	.consumer_supplies		= omap3_vdd2_supply,
 };
 
+static struct twl_regulator_driver_data omap3_vdd1_drvdata = {
+	.get_voltage = twl_get_voltage,
+	.set_voltage = twl_set_voltage,
+};
+
+static struct twl_regulator_driver_data omap3_vdd2_drvdata = {
+	.get_voltage = twl_get_voltage,
+	.set_voltage = twl_set_voltage,
+};
+
 void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
 				  u32 pdata_flags, u32 regulators_flags)
 {
@@ -165,10 +188,16 @@ void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
 		pmic_data->irq_base = TWL4030_IRQ_BASE;
 	if (!pmic_data->irq_end)
 		pmic_data->irq_end = TWL4030_IRQ_END;
-	if (!pmic_data->vdd1)
+	if (!pmic_data->vdd1) {
+		omap3_vdd1.driver_data = &omap3_vdd1_drvdata;
+		omap3_vdd1_drvdata.data = voltdm_lookup("mpu_iva");
 		pmic_data->vdd1 = &omap3_vdd1;
-	if (!pmic_data->vdd2)
+	}
+	if (!pmic_data->vdd2) {
+		omap3_vdd2.driver_data = &omap3_vdd2_drvdata;
+		omap3_vdd2_drvdata.data = voltdm_lookup("core");
 		pmic_data->vdd2 = &omap3_vdd2;
+	}
 
 	/* Common platform data configurations */
 	if (pdata_flags & TWL_COMMON_PDATA_USB && !pmic_data->usb)
-- 
1.7.4.1

