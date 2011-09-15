From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 1/6] usb: musb: omap: Configure OTG_INTERFSEL for proper charger detection
Date: Thu, 15 Sep 2011 19:49:58 +0530
Message-ID: <1316096403-6013-2-git-send-email-kishon@ti.com>
References: <1316096403-6013-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41362 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753892Ab1IOORb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 10:17:31 -0400
In-Reply-To: <1316096403-6013-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, heikki.krogerus@linux.intel.com, gregkh@suse.de
Cc: p-basak2@ti.com, kishon@ti.com, balajitk@ti.com, x0153364@ti.com, m-sonasath@ti.com, vishp@ti.com, hemahk@ti.com

Setting OTG_INTERFSEL to UTMI interferes with charger detection resulting
in incorrect detection of charger type. Hence OTG_INTERFSEL is configured to
ULPI initially and changed to UTMI only after receiving USB_EVENT_ID or
USB_EVENT_VBUS notification.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
[sandesh.gowda@ti.com: The interface selection has to be done before the PHY
is activated and is not allowed to change when the PHY clock is already
running]
---
 drivers/usb/musb/omap2430.c |   50 +++++++++++++++++++++++++++++++++++-------
 1 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index fc9377c..724450b 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -228,6 +228,7 @@ static inline void omap2430_low_level_init(struct musb *musb)
 static int musb_otg_notifications(struct notifier_block *nb,
 		unsigned long event, void *unused)
 {
+	u32 val;
 	struct musb	*musb = container_of(nb, struct musb, nb);
 	struct device *dev = musb->controller;
 	struct musb_hdrc_platform_data *pdata = dev->platform_data;
@@ -240,11 +241,32 @@ static int musb_otg_notifications(struct notifier_block *nb,
 		if (is_otg_enabled(musb)) {
 			if (musb->gadget_driver) {
 				pm_runtime_get_sync(musb->controller);
+
+				val = musb_readl(musb->mregs, OTG_INTERFSEL);
+				if (data->interface_type ==
+							MUSB_INTERFACE_UTMI) {
+					val &= ~ULPI_12PIN;
+					val |= UTMI_8BIT;
+				} else {
+					val |= ULPI_12PIN;
+				}
+				musb_writel(musb->mregs, OTG_INTERFSEL, val);
+
 				usb_phy_init(musb->xceiv);
 				omap2430_musb_set_vbus(musb, 1);
 			}
 		} else {
 			pm_runtime_get_sync(musb->controller);
+
+			val = musb_readl(musb->mregs, OTG_INTERFSEL);
+			if (data->interface_type == MUSB_INTERFACE_UTMI) {
+				val &= ~ULPI_12PIN;
+				val |= UTMI_8BIT;
+			} else {
+				val |= ULPI_12PIN;
+			}
+			musb_writel(musb->mregs, OTG_INTERFSEL, val);
+
 			usb_phy_init(musb->xceiv);
 			omap2430_musb_set_vbus(musb, 1);
 		}
@@ -255,6 +277,16 @@ static int musb_otg_notifications(struct notifier_block *nb,
 
 		if (musb->gadget_driver)
 			pm_runtime_get_sync(musb->controller);
+
+		val = musb_readl(musb->mregs, OTG_INTERFSEL);
+		if (data->interface_type == MUSB_INTERFACE_UTMI) {
+			val &= ~ULPI_12PIN;
+			val |= UTMI_8BIT;
+		} else {
+			val |= ULPI_12PIN;
+		}
+		musb_writel(musb->mregs, OTG_INTERFSEL, val);
+
 		usb_phy_init(musb->xceiv);
 		break;
 
@@ -272,6 +304,11 @@ static int musb_otg_notifications(struct notifier_block *nb,
 				otg_set_vbus(musb->xceiv->otg, 0);
 		}
 		usb_phy_shutdown(musb->xceiv);
+
+		val = musb_readl(musb->mregs, OTG_INTERFSEL);
+		val |= ULPI_12PIN;
+		musb_writel(musb->mregs, OTG_INTERFSEL, val);
+
 		break;
 	default:
 		dev_dbg(musb->controller, "ID float\n");
@@ -304,16 +341,11 @@ static int omap2430_musb_init(struct musb *musb)
 		goto err1;
 	}
 
+	/* Set OTG_INTERFSEL to ULPI for correct charger detection.
+	 * This should be later set to UTMI.
+	 */
 	l = musb_readl(musb->mregs, OTG_INTERFSEL);
-
-	if (data->interface_type == MUSB_INTERFACE_UTMI) {
-		/* OMAP4 uses Internal PHY GS70 which uses UTMI interface */
-		l &= ~ULPI_12PIN;       /* Disable ULPI */
-		l |= UTMI_8BIT;         /* Enable UTMI  */
-	} else {
-		l |= ULPI_12PIN;
-	}
-
+	l |= ULPI_12PIN;
 	musb_writel(musb->mregs, OTG_INTERFSEL, l);
 
 	pr_debug("HS USB OTG: revision 0x%x, sysconfig 0x%02x, "
-- 
1.7.0.4

