From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 5/7] usb: otg: twl4030-usb: check if vbus is driven by twl itself
Date: Sun, 10 Mar 2013 03:07:59 +0200
Message-ID: <1362877681-8102-6-git-send-email-notasas@gmail.com>
References: <1362877681-8102-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:33703 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693Ab3CJBIU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Mar 2013 20:08:20 -0500
In-Reply-To: <1362877681-8102-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, NeilBrown <neilb@suse.de>, Grazvydas Ignotas <notasas@gmail.com>

At least on pandora, STS_VBUS gets set even when VBUS is driven by twl
itself. Reporting VBUS in this case confuses OMAP musb glue and charger
driver, so check if OTG VBUS charge pump is on before reporting VBUS
event to avoid this problem.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/usb/otg/twl4030-usb.c |   36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index 2c1c27e..8f0d6cf 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -248,11 +248,31 @@ twl4030_usb_clear_bits(struct twl4030_usb *twl, u8 reg, u8 bits)
 
 /*-------------------------------------------------------------------------*/
 
+static bool twl4030_is_driving_vbus(struct twl4030_usb *twl)
+{
+	int ret;
+
+	ret = twl4030_usb_read(twl, PHY_CLK_CTRL_STS);
+	if (ret < 0 || !(ret & PHY_DPLL_CLK))
+		/*
+		 * if clocks are off, registers are not updated,
+		 * but we can assume we don't drive VBUS in this case
+		 */
+		return false;
+
+	ret = twl4030_usb_read(twl, ULPI_OTG_CTRL);
+	if (ret < 0)
+		return false;
+
+	return (ret & (ULPI_OTG_DRVVBUS | ULPI_OTG_CHRGVBUS)) ? true : false;
+}
+
 static enum omap_musb_vbus_id_status
 	twl4030_usb_linkstat(struct twl4030_usb *twl)
 {
 	int	status;
 	enum omap_musb_vbus_id_status linkstat = OMAP_MUSB_UNKNOWN;
+	bool	driving_vbus = false;
 
 	twl->vbus_supplied = false;
 
@@ -270,20 +290,26 @@ static enum omap_musb_vbus_id_status
 	if (status < 0)
 		dev_err(twl->dev, "USB link status err %d\n", status);
 	else if (status & (BIT(7) | BIT(2))) {
-		if (status & (BIT(7)))
-                        twl->vbus_supplied = true;
+		if (status & BIT(7)) {
+			driving_vbus = twl4030_is_driving_vbus(twl);
+			if (driving_vbus)
+				status &= ~BIT(7);
+		}
 
 		if (status & BIT(2))
 			linkstat = OMAP_MUSB_ID_GROUND;
-		else
+		else if (status & BIT(7)) {
 			linkstat = OMAP_MUSB_VBUS_VALID;
+			twl->vbus_supplied = true;
+		} else
+			linkstat = OMAP_MUSB_VBUS_OFF;
 	} else {
 		if (twl->linkstat != OMAP_MUSB_UNKNOWN)
 			linkstat = OMAP_MUSB_VBUS_OFF;
 	}
 
-	dev_dbg(twl->dev, "HW_CONDITIONS 0x%02x/%d; link %d\n",
-			status, status, linkstat);
+	dev_dbg(twl->dev, "HW_CONDITIONS 0x%02x; link %d, driving_vbus %d\n",
+		status, linkstat, driving_vbus);
 
 	/* REVISIT this assumes host and peripheral controllers
 	 * are registered, and that both are active...
-- 
1.7.9.5

