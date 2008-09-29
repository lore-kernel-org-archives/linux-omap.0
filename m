From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 15/22] twl4030: move pm_power_off initialization to twl4030-core.c
Date: Mon, 29 Sep 2008 16:14:32 +0300
Message-ID: <1222694079-16289-16-git-send-email-felipe.balbi@nokia.com>
References: <1222694079-16289-1-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-2-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-3-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-4-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-5-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-6-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-7-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-8-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-9-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-10-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-11-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-12-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-13-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-14-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-15-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29695 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945AbYI2NPc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 09:15:32 -0400
In-Reply-To: <1222694079-16289-15-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

We don't really need a whole new driver just for initializing
one pointer. Move it to core initialization.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/Kconfig            |    4 --
 drivers/i2c/chips/Makefile           |    1 -
 drivers/i2c/chips/twl4030-core.c     |   32 ++++++++++++++-
 drivers/i2c/chips/twl4030-poweroff.c |   76 ----------------------------------
 4 files changed, 31 insertions(+), 82 deletions(-)
 delete mode 100644 drivers/i2c/chips/twl4030-poweroff.c

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index e6ac6a2..819df47 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -186,10 +186,6 @@ config TWL4030_PWRBUTTON
 	tristate "TWL4030 Power button Driver"
 	depends on TWL4030_CORE
 
-config TWL4030_POWEROFF
-	tristate "TWL4030 device poweroff"
-	depends on TWL4030_CORE
-
 config SENSORS_MAX6875
 	tristate "Maxim MAX6875 Power supply supervisor"
 	depends on EXPERIMENTAL
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index 75c531a..221d929 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -26,7 +26,6 @@ obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
 obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
 obj-$(CONFIG_TWL4030_CORE)	+= twl4030-core.o twl4030-pwrirq.o twl4030-power.o
 obj-$(CONFIG_TWL4030_USB)	+= twl4030-usb.o
-obj-$(CONFIG_TWL4030_POWEROFF)	+= twl4030-poweroff.o
 obj-$(CONFIG_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
 obj-$(CONFIG_TWL4030_MADC)	+= twl4030-madc.o
 obj-$(CONFIG_RTC_X1205_I2C)	+= x1205.o
diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index e0a6ef4..6f06b8b 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -165,6 +165,10 @@
 
 #define TWL4030_SIH_CTRL_COR_MASK	(1 << 2)
 
+/* for pm_power_off */
+#define PWR_P1_SW_EVENTS	0x10
+#define PWR_DEVOFF	(1<<0)
+
 /**
  * struct twl4030_mod_iregs - TWL module IMR/ISR regs to mask/clear at init
  * @mod_no: TWL4030 module number (e.g., TWL4030_MODULE_GPIO)
@@ -1032,7 +1036,6 @@ static void twl_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
 				 ARRAY_SIZE(twl4030_mod_regs));
 
 	twl4030_irq_base = irq_base;
-
 	/* install an irq handler for each of the PIH modules */
 	for (i = irq_base; i < irq_end; i++) {
 		set_irq_chip(i, &twl4030_irq_chip);
@@ -1050,6 +1053,30 @@ static void twl_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
 		pr_err("%s: %s[%d]\n", DRIVER_NAME, msg, res);
 }
 
+static void twl4030_poweroff(void)
+{
+	int err;
+	u8 val;
+
+	err = twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &val,
+				  PWR_P1_SW_EVENTS);
+	if (err) {
+		pr_err("%s: i2c error %d while reading TWL4030"
+					"PM_MASTER P1_SW_EVENTS\n",
+					DRIVER_NAME, err);
+		return;
+	}
+
+	val |= PWR_DEVOFF;
+
+	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, val,
+				   PWR_P1_SW_EVENTS);
+	if (err)
+		pr_err("%s: i2c error %d while writing TWL4030"
+				"PM_MASTER P1_SW_EVENTS\n",
+				DRIVER_NAME, err);
+}
+
 /*----------------------------------------------------------------------*/
 
 static int twl4030_remove(struct i2c_client *client)
@@ -1134,6 +1161,9 @@ twl4030_probe(struct i2c_client *client, const struct i2c_device_id *id)
 				client->irq, pdata->irq_base, pdata->irq_end - 1);
 	}
 
+	/* initialize pm_power_off routine */
+	pm_power_off = twl4030_poweroff;
+
 	status = add_children(pdata);
 fail:
 	if (status < 0)
diff --git a/drivers/i2c/chips/twl4030-poweroff.c b/drivers/i2c/chips/twl4030-poweroff.c
deleted file mode 100644
index 0ebab0b..0000000
--- a/drivers/i2c/chips/twl4030-poweroff.c
+++ /dev/null
@@ -1,76 +0,0 @@
-/*
- * linux/drivers/i2c/chips/twl4030_poweroff.c
- *
- * Power off device
- *
- * Copyright (C) 2008 Nokia Corporation
- *
- * Written by Peter De Schrijver <peter.de-schrijver@nokia.com>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License. See the file "COPYING" in the main directory of this
- * archive for more details.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#include <linux/module.h>
-#include <linux/pm.h>
-#include <linux/i2c/twl4030.h>
-
-#define PWR_P1_SW_EVENTS	0x10
-#define PWR_DEVOFF	(1<<0)
-
-static void twl4030_poweroff(void)
-{
-	u8 val;
-	int err;
-
-	err = twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &val,
-				  PWR_P1_SW_EVENTS);
-	if (err) {
-		printk(KERN_WARNING "I2C error %d while reading TWL4030"
-					"PM_MASTER P1_SW_EVENTS\n", err);
-		return ;
-	}
-
-	val |= PWR_DEVOFF;
-
-	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, val,
-				   PWR_P1_SW_EVENTS);
-
-	if (err) {
-		printk(KERN_WARNING "I2C error %d while writing TWL4030"
-					"PM_MASTER P1_SW_EVENTS\n", err);
-		return ;
-	}
-
-	return;
-}
-
-static int __init twl4030_poweroff_init(void)
-{
-	pm_power_off = twl4030_poweroff;
-
-	return 0;
-}
-
-static void __exit twl4030_poweroff_exit(void)
-{
-	pm_power_off = NULL;
-}
-
-module_init(twl4030_poweroff_init);
-module_exit(twl4030_poweroff_exit);
-
-MODULE_ALIAS("i2c:twl4030-poweroff");
-MODULE_DESCRIPTION("Triton2 device power off");
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Peter De Schrijver");
-- 
1.6.0.2.307.gc427

