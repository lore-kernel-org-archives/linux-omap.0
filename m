From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCHv2 5/7] usb: phy: twl4030-usb: check if vbus is driven by twl itself
Date: Sun, 17 Mar 2013 20:23:25 +0200
Message-ID: <1363544607-17634-6-git-send-email-notasas@gmail.com>
References: <1363544607-17634-1-git-send-email-notasas@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1363544607-17634-1-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, kishon <kishon-l0cyMroinI0@public.gmane.org>, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

At least on pandora, STS_VBUS gets set even when VBUS is driven by twl
itself. Reporting VBUS in this case confuses OMAP musb glue and charger
driver, so check if OTG VBUS charge pump is on before reporting VBUS
event to avoid this problem.

Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/phy/phy-twl4030-usb.c |   36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/phy/phy-twl4030-usb.c b/drivers/usb/phy/phy-twl4030-usb.c
index 425c18a..87bf11d 100644
--- a/drivers/usb/phy/phy-twl4030-usb.c
+++ b/drivers/usb/phy/phy-twl4030-usb.c
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
