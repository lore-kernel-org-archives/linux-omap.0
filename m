From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: [PATCH v2] twl4030: Fix boot with twl4030 usb transceiver enabled
Date: Thu,  1 Oct 2009 11:25:36 +0300
Message-ID: <1254385536-26912-1-git-send-email-ext-roger.quadros@nokia.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932143AbZJAI0e@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sameo@linux.intel.com, tony@atomide.com
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, ext-roger.quadros@nokia.com
List-Id: linux-omap@vger.kernel.org

The usb regulator supplies (usb1v5, usb1v8 & usb3v1) must be available
before adding the twl4030_usb child, else twl4030_usb_ldo_init() will
always fail thus causing boot lock-up.

This patch fixes boot on OMAP systems using the twl4030 usb transceiver.
CONFIG_TWL4030_USB=y

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
 drivers/mfd/twl4030-core.c |   89 ++++++++++++++++++++++---------------------
 1 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl4030-core.c
index e424cf6..e832e97 100644
--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -480,7 +480,6 @@ static int
 add_children(struct twl4030_platform_data *pdata, unsigned long features)
 {
 	struct device	*child;
-	struct device	*usb_transceiver = NULL;
 
 	if (twl_has_bci() && pdata->bci && !(features & TPS_SUBSET)) {
 		child = add_child(3, "twl4030_bci",
@@ -532,16 +531,61 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 	}
 
 	if (twl_has_usb() && pdata->usb) {
+
+		static struct regulator_consumer_supply usb1v5 = {
+			.supply =	"usb1v5",
+		};
+		static struct regulator_consumer_supply usb1v8 = {
+			.supply =	"usb1v8",
+		};
+		static struct regulator_consumer_supply usb3v1 = {
+			.supply =	"usb3v1",
+		};
+
+	/* First add the regulators so that they can be used by transceiver */
+		if (twl_has_regulator()) {
+			/* this is a template that gets copied */
+			struct regulator_init_data usb_fixed = {
+				.constraints.valid_modes_mask =
+					REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+				.constraints.valid_ops_mask =
+					REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+			};
+
+			child = add_regulator_linked(TWL4030_REG_VUSB1V5,
+						      &usb_fixed, &usb1v5, 1);
+			if (IS_ERR(child))
+				return PTR_ERR(child);
+
+			child = add_regulator_linked(TWL4030_REG_VUSB1V8,
+						      &usb_fixed, &usb1v8, 1);
+			if (IS_ERR(child))
+				return PTR_ERR(child);
+
+			child = add_regulator_linked(TWL4030_REG_VUSB3V1,
+						      &usb_fixed, &usb3v1, 1);
+			if (IS_ERR(child))
+				return PTR_ERR(child);
+
+		}
+
 		child = add_child(0, "twl4030_usb",
 				pdata->usb, sizeof(*pdata->usb),
 				true,
 				/* irq0 = USB_PRES, irq1 = USB */
 				pdata->irq_base + 8 + 2, pdata->irq_base + 4);
+
 		if (IS_ERR(child))
 			return PTR_ERR(child);
 
 		/* we need to connect regulators to this transceiver */
-		usb_transceiver = child;
+		if (twl_has_regulator() && child) {
+			usb1v5.dev = child;
+			usb1v8.dev = child;
+			usb3v1.dev = child;
+		}
 	}
 
 	if (twl_has_watchdog()) {
@@ -580,47 +624,6 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 			return PTR_ERR(child);
 	}
 
-	if (twl_has_regulator() && usb_transceiver) {
-		static struct regulator_consumer_supply usb1v5 = {
-			.supply =	"usb1v5",
-		};
-		static struct regulator_consumer_supply usb1v8 = {
-			.supply =	"usb1v8",
-		};
-		static struct regulator_consumer_supply usb3v1 = {
-			.supply =	"usb3v1",
-		};
-
-		/* this is a template that gets copied */
-		struct regulator_init_data usb_fixed = {
-			.constraints.valid_modes_mask =
-				  REGULATOR_MODE_NORMAL
-				| REGULATOR_MODE_STANDBY,
-			.constraints.valid_ops_mask =
-				  REGULATOR_CHANGE_MODE
-				| REGULATOR_CHANGE_STATUS,
-		};
-
-		usb1v5.dev = usb_transceiver;
-		usb1v8.dev = usb_transceiver;
-		usb3v1.dev = usb_transceiver;
-
-		child = add_regulator_linked(TWL4030_REG_VUSB1V5, &usb_fixed,
-				&usb1v5, 1);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator_linked(TWL4030_REG_VUSB1V8, &usb_fixed,
-				&usb1v8, 1);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator_linked(TWL4030_REG_VUSB3V1, &usb_fixed,
-				&usb3v1, 1);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
 	/* maybe add LDOs that are omitted on cost-reduced parts */
 	if (twl_has_regulator() && !(features & TPS_SUBSET)) {
 		child = add_regulator(TWL4030_REG_VPLL2, pdata->vpll2);
-- 
1.6.0.4
