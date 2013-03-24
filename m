From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCHv3 1/3] usb: phy: twl4030-usb: check if vbus is driven by twl itself
Date: Sun, 24 Mar 2013 17:36:53 +0200
Message-ID: <1364139415-16695-2-git-send-email-notasas@gmail.com>
References: <1364139415-16695-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f169.google.com ([209.85.215.169]:65141 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049Ab3CXPhF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 24 Mar 2013 11:37:05 -0400
In-Reply-To: <1364139415-16695-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, kishon <kishon@ti.com>, Grazvydas Ignotas <notasas@gmail.com>

At least on pandora, STS_VBUS gets set even when VBUS is driven by twl
itself. Reporting VBUS in this case confuses OMAP musb glue and charger
driver, so check if OTG VBUS charge pump is on before reporting VBUS
event to avoid this problem.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/usb/phy/phy-twl4030-usb.c |   31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/phy/phy-twl4030-usb.c b/drivers/usb/phy/phy-twl4030-usb.c
index 61fe7e2..3f9858f 100644
--- a/drivers/usb/phy/phy-twl4030-usb.c
+++ b/drivers/usb/phy/phy-twl4030-usb.c
@@ -248,6 +248,25 @@ twl4030_usb_clear_bits(struct twl4030_usb *twl, u8 reg, u8 bits)
 
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
@@ -270,13 +289,19 @@ static enum omap_musb_vbus_id_status
 	if (status < 0)
 		dev_err(twl->dev, "USB link status err %d\n", status);
 	else if (status & (BIT(7) | BIT(2))) {
-		if (status & (BIT(7)))
-                        twl->vbus_supplied = true;
+		if (status & BIT(7)) {
+			if (twl4030_is_driving_vbus(twl))
+				status &= ~BIT(7);
+			else
+				twl->vbus_supplied = true;
+		}
 
 		if (status & BIT(2))
 			linkstat = OMAP_MUSB_ID_GROUND;
-		else
+		else if (status & BIT(7))
 			linkstat = OMAP_MUSB_VBUS_VALID;
+		else
+			linkstat = OMAP_MUSB_VBUS_OFF;
 	} else {
 		if (twl->linkstat != OMAP_MUSB_UNKNOWN)
 			linkstat = OMAP_MUSB_VBUS_OFF;
-- 
1.7.9.5

