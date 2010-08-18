From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/5] usb: ehci: relocate PHY reset code
Date: Wed, 18 Aug 2010 08:25:43 +0530
Message-ID: <1282100145-27485-4-git-send-email-keshava_mgowda@ti.com>
References: <1282100145-27485-1-git-send-email-keshava_mgowda@ti.com>
 <1282100145-27485-2-git-send-email-keshava_mgowda@ti.com>
 <1282100145-27485-3-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1282100145-27485-3-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The PHY reset code is moved at the begining and end of the function
omap_start_ehc. This simplfies the writing clocks enabling code for 
OMAP4 later. 

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/host/ehci-omap.c |   52 +++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

Index: linux-2.6/drivers/usb/host/ehci-omap.c
===================================================================
--- linux-2.6.orig/drivers/usb/host/ehci-omap.c
+++ linux-2.6/drivers/usb/host/ehci-omap.c
@@ -279,6 +279,24 @@ static int omap_start_ehc(struct ehci_hc
 
 	dev_dbg(omap->dev, "starting TI EHCI USB Controller\n");
 
+	if (omap->phy_reset) {
+		/* Refer: ISSUE1 */
+		if (gpio_is_valid(omap->reset_gpio_port[0])) {
+			gpio_request(omap->reset_gpio_port[0],
+						"USB1 PHY reset");
+			gpio_direction_output(omap->reset_gpio_port[0], 0);
+		}
+
+		if (gpio_is_valid(omap->reset_gpio_port[1])) {
+			gpio_request(omap->reset_gpio_port[1],
+						"USB2 PHY reset");
+			gpio_direction_output(omap->reset_gpio_port[1], 0);
+		}
+
+		/* Hold the PHY in RESET for enough time till DIR is high */
+		udelay(10);
+	}
+
 	/* Enable Clocks for USBHOST */
 	omap->usbhost_ick = clk_get(omap->dev, "usbhost_ick");
 	if (IS_ERR(omap->usbhost_ick)) {
@@ -301,24 +319,6 @@ static int omap_start_ehc(struct ehci_hc
 	}
 	clk_enable(omap->usbhost_fs_fck);
 
-	if (omap->phy_reset) {
-		/* Refer: ISSUE1 */
-		if (gpio_is_valid(omap->reset_gpio_port[0])) {
-			gpio_request(omap->reset_gpio_port[0],
-						"USB1 PHY reset");
-			gpio_direction_output(omap->reset_gpio_port[0], 0);
-		}
-
-		if (gpio_is_valid(omap->reset_gpio_port[1])) {
-			gpio_request(omap->reset_gpio_port[1],
-						"USB2 PHY reset");
-			gpio_direction_output(omap->reset_gpio_port[1], 0);
-		}
-
-		/* Hold the PHY in RESET for enough time till DIR is high */
-		udelay(10);
-	}
-
 	/* Configure TLL for 60Mhz clk for ULPI */
 	omap->usbtll_fck = clk_get(omap->dev, "usbtll_fck");
 	if (IS_ERR(omap->usbtll_fck)) {
@@ -476,14 +476,6 @@ err_tll_fck:
 	clk_disable(omap->usbhost_fs_fck);
 	clk_put(omap->usbhost_fs_fck);
 
-	if (omap->phy_reset) {
-		if (gpio_is_valid(omap->reset_gpio_port[0]))
-			gpio_free(omap->reset_gpio_port[0]);
-
-		if (gpio_is_valid(omap->reset_gpio_port[1]))
-			gpio_free(omap->reset_gpio_port[1]);
-	}
