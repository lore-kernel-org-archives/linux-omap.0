From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v5 09/48] mfd: palmas: Register with kernel power-off handler
Date: Thu,  6 Nov 2014 08:42:53 -0800
Message-ID: <1415292213-28652-10-git-send-email-linux@roeck-us.net>
References: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56160 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbaKFQoJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2014 11:44:09 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XmQAK-000TLy-Rg
	for linux-omap@vger.kernel.org; Thu, 06 Nov 2014 16:44:09 +0000
In-Reply-To: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
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
- Use devm_register_power_off_handler
- Use dev_warn instead of dev_err

 drivers/mfd/palmas.c       | 28 ++++++++++++++--------------
 include/linux/mfd/palmas.h |  3 +++
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 28cb048..60f81ed 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -19,6 +19,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/err.h>
 #include <linux/mfd/core.h>
@@ -425,20 +426,17 @@ static void palmas_dt_to_pdata(struct i2c_client *i2c,
 			"ti,system-power-controller");
 }
 
-static struct palmas *palmas_dev;
-static void palmas_power_off(void)
+static void palmas_power_off(struct power_off_handler_block *this)
 {
+	struct palmas *palmas = container_of(this, struct palmas, power_off_hb);
 	unsigned int addr;
 	int ret, slave;
 
-	if (!palmas_dev)
-		return;
-
 	slave = PALMAS_BASE_TO_SLAVE(PALMAS_PMU_CONTROL_BASE);
 	addr = PALMAS_BASE_TO_REG(PALMAS_PMU_CONTROL_BASE, PALMAS_DEV_CTRL);
 
 	ret = regmap_update_bits(
-			palmas_dev->regmap[slave],
+			palmas->regmap[slave],
 			addr,
 			PALMAS_DEV_CTRL_DEV_ON,
 			0);
@@ -668,9 +666,16 @@ no_irq:
 		ret = of_platform_populate(node, NULL, NULL, &i2c->dev);
 		if (ret < 0) {
 			goto err_irq;
-		} else if (pdata->pm_off && !pm_power_off) {
-			palmas_dev = palmas;
-			pm_power_off = palmas_power_off;
+		} else if (pdata->pm_off) {
+			int ret2;
+
+			palmas->power_off_hb.handler = palmas_power_off;
+			palmas->power_off_hb.priority = POWER_OFF_PRIORITY_LOW;
+			ret2 = devm_register_power_off_handler(palmas->dev,
+							&palmas->power_off_hb);
+			if (ret2)
+				dev_warn(palmas->dev,
+					 "Failed to register power-off handler");
 		}
 	}
 
@@ -698,11 +703,6 @@ static int palmas_i2c_remove(struct i2c_client *i2c)
 			i2c_unregister_device(palmas->i2c_clients[i]);
 	}
 
-	if (palmas == palmas_dev) {
-		pm_power_off = NULL;
-		palmas_dev = NULL;
-	}
-
 	return 0;
 }
 
diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
index fb0390a..7a43f7b 100644
--- a/include/linux/mfd/palmas.h
+++ b/include/linux/mfd/palmas.h
@@ -18,6 +18,7 @@
 
 #include <linux/usb/otg.h>
 #include <linux/leds.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/extcon.h>
@@ -68,6 +69,8 @@ struct palmas {
 	struct i2c_client *i2c_clients[PALMAS_NUM_CLIENTS];
 	struct regmap *regmap[PALMAS_NUM_CLIENTS];
 
+	struct power_off_handler_block power_off_hb;
+
 	/* Stored chip id */
 	int id;
 
-- 
1.9.1

