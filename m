From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv2 7/8] OMAP3: PM: Adding T2 enabling of smartreflex support
Date: Fri, 13 Aug 2010 19:17:10 +0530
Message-ID: <1281707231-3026-8-git-send-email-thara@ti.com>
References: <1281707231-3026-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53799 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761649Ab0HMNr0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 09:47:26 -0400
In-Reply-To: <1281707231-3026-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, dderrick@ti.com, Thara Gopinath <thara@ti.com>

This patch adds support in the twl4030 driver to hook up
the API enabling smartreflex support on PMIC side with the
smartreflex driver. Without this the OMAP smartreflex modules
will not function.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 drivers/mfd/twl-core.c      |    7 +++++--
 drivers/mfd/twl4030-power.c |   29 +++++++++++++++++++++++++++++
 include/linux/i2c/twl.h     |    1 +
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 720e099..677b903 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1009,8 +1009,11 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	clocks_init(&client->dev, pdata->clock);
 
 	/* load power event scripts */
-	if (twl_has_power() && pdata->power)
-		twl4030_power_init(pdata->power);
+	if (twl_has_power()) {
+		twl4030_power_sr_init();
+		 if (pdata->power)
+			twl4030_power_init(pdata->power);
+	}
 
 	/* Maybe init the T2 Interrupt subsystem */
 	if (client->irq
diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 7efa878..0e4d215 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -31,6 +31,8 @@
 
 #include <asm/mach-types.h>
 
+#include <plat/smartreflex.h>
+
 static u8 twl4030_start_script_address = 0x2b;
 
 #define PWR_P1_SW_EVENTS	0x10
@@ -63,6 +65,10 @@ static u8 twl4030_start_script_address = 0x2b;
 #define R_MEMORY_ADDRESS	PHY_TO_OFF_PM_MASTER(0x59)
 #define R_MEMORY_DATA		PHY_TO_OFF_PM_MASTER(0x5a)
 
+/* Smartreflex Control */
+#define R_DCDC_GLOBAL_CFG	PHY_TO_OFF_PM_RECEIVER(0x61)
+#define CFG_ENABLE_SRFLX	0x08
+
 #define R_PROTECT_KEY		0x0E
 #define R_KEY_1			0xC0
 #define R_KEY_2			0x0C
@@ -511,6 +517,29 @@ int twl4030_remove_script(u8 flags)
 	return err;
 }
 
+/* API to enable smrtreflex on Triton side */
+static void twl4030_smartreflex_init(void)
+{
+	int ret = 0;
+	u8 read_val;
+
+	ret = twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &read_val,
+			R_DCDC_GLOBAL_CFG);
+	read_val |= CFG_ENABLE_SRFLX;
+	ret |= twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, read_val,
+			R_DCDC_GLOBAL_CFG);
+}
+
+struct omap_smartreflex_pmic_data twl4030_sr_data = {
+       .sr_pmic_init   = twl4030_smartreflex_init,
+};
+
+void __init twl4030_power_sr_init()
+{
+	/* Register the SR init API with the Smartreflex driver */
+	omap_sr_register_pmic(&twl4030_sr_data);
+}
+
 void __init twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
 {
 	int err = 0;
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 6de90bf..b02011e 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -550,6 +550,7 @@ struct twl4030_power_data {
 };
 
 extern void twl4030_power_init(struct twl4030_power_data *triton2_scripts);
+extern void twl4030_power_sr_init(void);
 extern int twl4030_remove_script(u8 flags);
 
 struct twl4030_codec_audio_data {
-- 
1.7.1.GIT

