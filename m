From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH 3/6] OMAP4: TWL6030: add USB charger detection
Date: Thu, 15 Sep 2011 19:50:00 +0530
Message-ID: <1316096403-6013-4-git-send-email-kishon@ti.com>
References: <1316096403-6013-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1316096403-6013-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org
Cc: p-basak2-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, x0153364-l0cyMroinI0@public.gmane.org, m-sonasath-l0cyMroinI0@public.gmane.org, vishp-l0cyMroinI0@public.gmane.org, hemahk-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>

Charger detection is done in threaded irq and is performed only when OMAP
acts as B-device. Phy is powered on before charger detection and is powered
down once charger detection is completed. The type of charger is sent through
all the registered notifiers.

Signed-off-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Signed-off-by: Partha Basak <p-basak2-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/omap_phy_internal.c |   50 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/usb.h   |    1 +
 drivers/usb/otg/twl6030-usb.c           |   51 ++++++++++++++++++++++--------
 3 files changed, 88 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index a828833..e5a6701 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -27,6 +27,7 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/usb.h>
+#include <linux/power_supply.h>
 
 #include <plat/usb.h>
 #include "control.h"
@@ -42,6 +43,13 @@
 #define	SESSEND				BIT(3)
 #define	IDDIG				BIT(4)
 
+#define CONTROL_USB2PHYCORE		0x620
+#define CHARGER_TYPE_PS2		0x2
+#define CHARGER_TYPE_DEDICATED		0x4
+#define CHARGER_TYPE_HOST		0x5
+#define CHARGER_TYPE_PC			0x6
+#define USB2PHY_CHGDETECTED		BIT(13)
+
 static struct clk *phyclk, *clk48m, *clk32k;
 static void __iomem *ctrl_base;
 static int usbotghs_control;
@@ -107,6 +115,48 @@ int omap4430_phy_set_clk(struct device *dev, int on)
 	return 0;
 }
 
+int omap4_charger_detect(void)
+{
+	unsigned long timeout;
+	int charger = 0;
+	u32 usb2phycore = 0;
+	u32 chargertype = 0;
+
+	omap4430_phy_power(NULL, 0, 1);
+
+	timeout = jiffies + msecs_to_jiffies(500);
+	do {
+		usb2phycore = omap4_ctrl_pad_readl(CONTROL_USB2PHYCORE);
+		chargertype = ((usb2phycore >> 21) & 0x7);
+		if (usb2phycore & USB2PHY_CHGDETECTED)
+			break;
+	} while (!time_after(jiffies, timeout));
+
+	switch (chargertype) {
+	case CHARGER_TYPE_DEDICATED:
+		charger = POWER_SUPPLY_TYPE_USB_DCP;
+		pr_info("DCP detected\n");
+		break;
+	case CHARGER_TYPE_HOST:
+		charger = POWER_SUPPLY_TYPE_USB_CDP;
+		pr_info("CDP detected\n");
+		break;
+	case CHARGER_TYPE_PC:
+		charger = POWER_SUPPLY_TYPE_USB;
+		pr_info("PC detected\n");
+		break;
+	case CHARGER_TYPE_PS2:
+		pr_info("PS/2 detected!\n");
+		break;
+	default:
+		pr_err(KERN_ERR"Unknown charger detected! %d\n", chargertype);
+	}
+
+	omap4430_phy_power(NULL, 0, 0);
+
+	return charger;
+}
+
 int omap4430_phy_power(struct device *dev, int ID, int on)
 {
 	if (on) {
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 17d3c93..582851b 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -107,6 +107,7 @@ extern int omap4430_phy_power(struct device *dev, int ID, int on);
 extern int omap4430_phy_set_clk(struct device *dev, int on);
 extern int omap4430_phy_init(struct device *dev);
 extern int omap4430_phy_exit(struct device *dev);
+extern int omap4_charger_detect(void);
 extern int omap4430_phy_suspend(struct device *dev, int suspend);
 #endif
 
diff --git a/drivers/usb/otg/twl6030-usb.c b/drivers/usb/otg/twl6030-usb.c
index 843c47d..6cb28ea 100644
--- a/drivers/usb/otg/twl6030-usb.c
+++ b/drivers/usb/otg/twl6030-usb.c
@@ -32,6 +32,8 @@
 #include <linux/notifier.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <plat/usb.h>
+#include <linux/power_supply.h>
 
 /* usb register definitions */
 #define USB_VENDOR_ID_LSB		0x00
@@ -102,6 +104,7 @@ struct twl6030_usb {
 	int			irq2;
 	u8			linkstat;
 	u8			asleep;
+	u8			prev_vbus;
 	bool			irq_enabled;
 	bool			vbus_enable;
 	unsigned long		features;
@@ -273,6 +276,7 @@ static irqreturn_t twl6030_usb_irq(int irq, void *_twl)
 {
 	struct twl6030_usb *twl = _twl;
 	struct usb_otg *otg = twl->xceiv.otg;
+	unsigned charger_type;
 	int status;
 	u8 vbus_state, hw_state;
 
@@ -280,29 +284,48 @@ static irqreturn_t twl6030_usb_irq(int irq, void *_twl)
 
 	vbus_state = twl6030_readb(twl, TWL_MODULE_MAIN_CHARGE,
 						CONTROLLER_STAT1);
-	if (!(hw_state & STS_USB_ID)) {
-		if (vbus_state & VBUS_DET) {
-			regulator_enable(twl->usb3v3);
-			twl->asleep = 1;
+	vbus_state = vbus_state & VBUS_DET;
+
+	/* Ignore charger events other than VBUS */
+	if (vbus_state == twl->prev_vbus)
+		return IRQ_HANDLED;
+
+	if ((vbus_state) && !(hw_state & STS_USB_ID)) {
+		regulator_enable(twl->usb3v3);
+		charger_type = omap4_charger_detect();
+		if ((charger_type == POWER_SUPPLY_TYPE_USB_CDP)
+			|| (charger_type == POWER_SUPPLY_TYPE_USB)) {
 			status = USB_EVENT_VBUS;
 			otg->default_a = false;
+			twl->asleep = 1;
 			twl->xceiv.state = USB_PHY_STATE_B_IDLE;
 			twl->linkstat = status;
 			twl->xceiv.last_event = status;
-			atomic_notifier_call_chain(&twl->xceiv.notifier,
-						status, otg->gadget);
-		} else {
-			status = USB_EVENT_NONE;
-			twl->linkstat = status;
+		} else if (charger_type == POWER_SUPPLY_TYPE_USB_DCP) {
+			regulator_disable(twl->usb3v3);
+			status = USB_EVENT_CHARGER;
 			twl->xceiv.last_event = status;
+		} else {
+			regulator_disable(twl->usb3v3);
+			goto vbus_notify;
+		}
+		atomic_notifier_call_chain(&twl->xceiv.notifier,
+						status, &charger_type);
+	}
+	if (!vbus_state) {
+		status = USB_EVENT_NONE;
+		twl->linkstat = status;
+		twl->xceiv.last_event = status;
+		if (twl->asleep) {
 			atomic_notifier_call_chain(&twl->xceiv.notifier,
-						status, otg->gadget);
-			if (twl->asleep) {
-				regulator_disable(twl->usb3v3);
-				twl->asleep = 0;
-			}
+					status, twl->xceiv.otg->gadget);
+			regulator_disable(twl->usb3v3);
+			twl->asleep = 0;
 		}
 	}
+
+vbus_notify:
+	twl->prev_vbus = vbus_state;
 	sysfs_notify(&twl->dev->kobj, NULL, "vbus");
 
 	return IRQ_HANDLED;
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
