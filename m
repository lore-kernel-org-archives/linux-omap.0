From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v6 17/48] mfd: tps65910: Register with kernel power-off handler
Date: Sun,  9 Nov 2014 17:42:34 -0800
Message-ID: <1415583785-6980-18-git-send-email-linux@roeck-us.net>
References: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39017 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbaKJBoH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Nov 2014 20:44:07 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Xne1X-000V02-Aw
	for linux-omap@vger.kernel.org; Mon, 10 Nov 2014 01:44:07 +0000
In-Reply-To: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org

Register with kernel power-off handler instead of setting pm_power_off
directly. Register with low priority to reflect that the original code
only sets pm_power_off if it was not already set.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: linux-omap@vger.kernel.org
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v6:
- This patch: No change.
  Global: Replaced priority defines with enum.
v5:
- Rebase to v3.18-rc3
v4:
- Do not use notifiers but internal functions and data structures to manage
  the list of power-off handlers. Drop unused parameters from callbacks, and
  make the power-off function type void
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
- Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
v2:
- Use define to specify poweroff handler priority
- Use dev_warn instead of dev_err

 drivers/mfd/tps65910.c       | 21 +++++++++++++--------
 include/linux/mfd/tps65910.h |  4 ++++
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 7612d89..b312b92 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -23,6 +23,7 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/mfd/core.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/mfd/tps65910.h>
 #include <linux/of.h>
@@ -437,12 +438,10 @@ struct tps65910_board *tps65910_parse_dt(struct i2c_client *client,
 }
 #endif
 
-static struct i2c_client *tps65910_i2c_client;
-static void tps65910_power_off(void)
+static void tps65910_power_off(struct power_off_handler_block *this)
 {
-	struct tps65910 *tps65910;
-
-	tps65910 = dev_get_drvdata(&tps65910_i2c_client->dev);
+	struct tps65910 *tps65910 = container_of(this, struct tps65910,
+						 power_off_hb);
 
 	if (tps65910_reg_set_bits(tps65910, TPS65910_DEVCTRL,
 			DEVCTRL_PWR_OFF_MASK) < 0)
@@ -505,9 +504,13 @@ static int tps65910_i2c_probe(struct i2c_client *i2c,
 	tps65910_ck32k_init(tps65910, pmic_plat_data);
 	tps65910_sleepinit(tps65910, pmic_plat_data);
 
-	if (pmic_plat_data->pm_off && !pm_power_off) {
-		tps65910_i2c_client = i2c;
-		pm_power_off = tps65910_power_off;
+	if (pmic_plat_data->pm_off) {
+		tps65910->power_off_hb.handler = tps65910_power_off;
+		tps65910->power_off_hb.priority = POWER_OFF_PRIORITY_LOW;
+		ret = register_power_off_handler(&tps65910->power_off_hb);
+		if (ret)
+			dev_warn(&i2c->dev,
+				 "failed to register power-off handler\n");
 	}
 
 	ret = mfd_add_devices(tps65910->dev, -1,
@@ -527,6 +530,8 @@ static int tps65910_i2c_remove(struct i2c_client *i2c)
 {
 	struct tps65910 *tps65910 = i2c_get_clientdata(i2c);
 
+	unregister_power_off_handler(&tps65910->power_off_hb);
+
 	tps65910_irq_exit(tps65910);
 	mfd_remove_devices(tps65910->dev);
 
diff --git a/include/linux/mfd/tps65910.h b/include/linux/mfd/tps65910.h
index 6483a6f..a85ad0f 100644
--- a/include/linux/mfd/tps65910.h
+++ b/include/linux/mfd/tps65910.h
@@ -18,6 +18,7 @@
 #define __LINUX_MFD_TPS65910_H
 
 #include <linux/gpio.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 
 /* TPS chip id list */
@@ -905,6 +906,9 @@ struct tps65910 {
 	/* IRQ Handling */
 	int chip_irq;
 	struct regmap_irq_chip_data *irq_data;
+
+	/* Power-off handling */
+	struct power_off_handler_block power_off_hb;
 };
 
 struct tps65910_platform_data {
-- 
1.9.1

