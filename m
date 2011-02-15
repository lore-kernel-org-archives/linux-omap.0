From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [2/7 v2] usb: otg: Remove one unnecessary I2C read request.
Date: Tue, 15 Feb 2011 15:12:33 +0530
Message-ID: <1297762958-26199-2-git-send-email-hemahk@ti.com>
References: <1297762958-26199-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297762958-26199-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Kalliguddi, Hema <hemahk-l0cyMroinI0@public.gmane.org>

To get the ID status there was an I2C read transfer. Removed this I2C
read transfer as this info can be used from existing variable(linkstat).

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

---
drivers/usb/otg/twl6030-usb.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

Index: linux-2.6/drivers/usb/otg/twl6030-usb.c
===================================================================
--- linux-2.6.orig/drivers/usb/otg/twl6030-usb.c
+++ linux-2.6/drivers/usb/otg/twl6030-usb.c
@@ -149,7 +149,6 @@ static int twl6030_set_phy_clk(struct ot
 
 static int twl6030_phy_init(struct otg_transceiver *x)
 {
-	u8 hw_state;
 	struct twl6030_usb *twl;
 	struct device *dev;
 	struct twl4030_usb_data *pdata;
@@ -158,9 +157,7 @@ static int twl6030_phy_init(struct otg_t
 	dev  = twl->dev;
 	pdata = dev->platform_data;
 
-	hw_state = twl6030_readb(twl, TWL6030_MODULE_ID0, STS_HW_CONDITIONS);
