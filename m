From: NeilBrown <neil@brown.name>
Subject: [PATCH 01/13] twl4030_charger: use runtime_pm to keep usb phy
 active while charging.
Date: Thu, 30 Jul 2015 10:11:24 +1000
Message-ID: <20150730001124.4012.41690.stgit@noble>
References: <20150730001113.4012.18086.stgit@noble>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150730001113.4012.18086.stgit@noble>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

The twl4030 usb phy needs to be active while we are using
the USB VBUS as a current source for charging.
In particular, the usb3v1 regulator must be enabled and the
PHY_PWR_PHYPWD bit must be set to keep the phy powered.

commit ab37813f4093a5f59cb8e083cde277289dc72ed3
    twl4030_charger: Allow charger to control the regulator that feeds it

gave the charger control over the regulator, but didn't resolve
the PHY_PWR_PHYPWD issue.

Now that both of these are controlled by runtime_pm in
phy-twl4030-usb, we can simply take a runtime_pm reference to the USB
phy whenever the charger wants to use it as a current source.

So this patch reverts the above commit, and adds the necessary
runtime_pm calls.

Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/mfd/twl-core.c          |    9 ++++-----
 drivers/power/twl4030_charger.c |   18 +++++-------------
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 489674a2497e..831696ee2472 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -788,9 +788,8 @@ add_children(struct twl4030_platform_data *pdata, unsigned irq_base,
 		static struct regulator_consumer_supply usb1v8 = {
 			.supply =	"usb1v8",
 		};
-		static struct regulator_consumer_supply usb3v1[] = {
-			{ .supply =	"usb3v1" },
-			{ .supply =	"bci3v1" },
+		static struct regulator_consumer_supply usb3v1 = {
+			.supply =	"usb3v1",
 		};
 
 	/* First add the regulators so that they can be used by transceiver */
@@ -818,7 +817,7 @@ add_children(struct twl4030_platform_data *pdata, unsigned irq_base,
 				return PTR_ERR(child);
 
 			child = add_regulator_linked(TWL4030_REG_VUSB3V1,
-						      &usb_fixed, usb3v1, 2,
+						      &usb_fixed, &usb3v1, 1,
 						      features);
 			if (IS_ERR(child))
 				return PTR_ERR(child);
@@ -838,7 +837,7 @@ add_children(struct twl4030_platform_data *pdata, unsigned irq_base,
 		if (IS_ENABLED(CONFIG_REGULATOR_TWL4030) && child) {
 			usb1v5.dev_name = dev_name(child);
 			usb1v8.dev_name = dev_name(child);
-			usb3v1[0].dev_name = dev_name(child);
+			usb3v1.dev_name = dev_name(child);
 		}
 	}
 
diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index 709d90dc75f1..fe71c61109f5 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -22,7 +22,6 @@
 #include <linux/power_supply.h>
 #include <linux/notifier.h>
 #include <linux/usb/otg.h>
-#include <linux/regulator/machine.h>
 
 #define TWL4030_BCIMSTATEC	0x02
 #define TWL4030_BCIICHG		0x08
@@ -94,7 +93,6 @@ struct twl4030_bci {
 	struct work_struct	work;
 	int			irq_chg;
 	int			irq_bci;
-	struct regulator	*usb_reg;
 	int			usb_enabled;
 
 	unsigned long		event;
@@ -208,7 +206,7 @@ static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
 {
 	int ret;
 
-	if (enable) {
+	if (enable && !IS_ERR_OR_NULL(bci->transceiver)) {
 		/* Check for USB charger connected */
 		if (!twl4030_bci_have_vbus(bci))
 			return -ENODEV;
@@ -222,14 +220,9 @@ static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
 			return -EACCES;
 		}
 
-		/* Need to keep regulator on */
+		/* Need to keep phy powered */
 		if (!bci->usb_enabled) {
-			ret = regulator_enable(bci->usb_reg);
-			if (ret) {
-				dev_err(bci->dev,
-					"Failed to enable regulator\n");
-				return ret;
-			}
+			pm_runtime_get_sync(bci->transceiver->dev);
 			bci->usb_enabled = 1;
 		}
 
@@ -244,7 +237,8 @@ static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
 	} else {
 		ret = twl4030_clear_set_boot_bci(TWL4030_BCIAUTOUSB, 0);
 		if (bci->usb_enabled) {
-			regulator_disable(bci->usb_reg);
+			pm_runtime_mark_last_busy(bci->transceiver->dev);
+			pm_runtime_put_autosuspend(bci->transceiver->dev);
 			bci->usb_enabled = 0;
 		}
 	}
@@ -609,8 +603,6 @@ static int __init twl4030_bci_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	bci->usb_reg = regulator_get(bci->dev, "bci3v1");
-
 	bci->usb = devm_power_supply_register(&pdev->dev, &twl4030_bci_usb_desc,
 					      NULL);
 	if (IS_ERR(bci->usb)) {


