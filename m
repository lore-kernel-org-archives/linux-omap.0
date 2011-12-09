From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 5/5] omap3: twl: add external controllers for core voltage regulators
Date: Fri, 9 Dec 2011 17:29:49 +0200
Message-ID: <1323444589-19940-6-git-send-email-t-kristo@ti.com>
References: <1323444589-19940-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59059 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996Ab1LIPaD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 10:30:03 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id pB9FU3IH019917
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 9 Dec 2011 09:30:03 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id pB9FU3na000670
	for <linux-omap@vger.kernel.org>; Fri, 9 Dec 2011 09:30:03 -0600 (CST)
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pB9FU3LX018984
	for <linux-omap@vger.kernel.org>; Fri, 9 Dec 2011 09:30:03 -0600 (CST)
Received: from localhost.localdomain (h88-4.vpn.ti.com [172.24.88.4])	by
 dlelxv22.itg.ti.com (8.13.8/8.13.8) with ESMTP id pB9FTtvG006466	for
 <linux-omap@vger.kernel.org>; Fri, 9 Dec 2011 09:30:02 -0600
In-Reply-To: <1323444589-19940-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

VDD1 and VDD2 now use voltage processor for controlling the regulators.
This is done by passing additional voltdm data during the regulator init.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/twl-common.c |   33 +++++++++++++++++++++++++++++++--
 1 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 7cf5347..d2557d1 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -30,6 +30,19 @@
 #include <plat/usb.h>
 
 #include "twl-common.h"
+#include "voltage.h"
+
+static int twl_set_voltage(void *data, int min_uV)
+{
+	struct voltagedomain *voltdm = (struct voltagedomain *)data;
+	return voltdm_scale(voltdm, min_uV);
+}
+
+static int twl_get_voltage(void *data)
+{
+	struct voltagedomain *voltdm = (struct voltagedomain *)data;
+	return voltdm_get_voltage(voltdm);
+}
 
 static struct i2c_board_info __initdata pmic_i2c_board_info = {
 	.addr		= 0x48,
@@ -147,6 +160,16 @@ static struct regulator_init_data omap3_vdd2 = {
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
@@ -154,10 +177,16 @@ void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
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

