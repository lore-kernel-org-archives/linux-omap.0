From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/5] usb: ehci: omap: Update clock names to be same across OMAP3 and OMAP4
Date: Wed, 18 Aug 2010 08:25:41 +0530
Message-ID: <1282100145-27485-2-git-send-email-keshava_mgowda@ti.com>
References: <1282100145-27485-1-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1282100145-27485-1-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Rename usbhost2_120m_fck to usbhost_hs_fck and
usbhost1_48m_fck to usbhost_fs_fck, so that we can reuse the
names across OMAP3 and OMAP4.

OMAP3 and OMAP4 have similar clocks, with different frequencies.
The driver should not need to care about these.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/host/ehci-omap.c |   56 +++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

Index: linux-2.6/drivers/usb/host/ehci-omap.c
===================================================================
--- linux-2.6.orig/drivers/usb/host/ehci-omap.c
+++ linux-2.6/drivers/usb/host/ehci-omap.c
@@ -156,8 +156,8 @@ struct ehci_hcd_omap {
 	struct device		*dev;
 
 	struct clk		*usbhost_ick;
-	struct clk		*usbhost2_120m_fck;
-	struct clk		*usbhost1_48m_fck;
+	struct clk		*usbhost_hs_fck;
+	struct clk		*usbhost_fs_fck;
 	struct clk		*usbtll_fck;
 	struct clk		*usbtll_ick;
 
@@ -286,19 +286,19 @@ static int omap_start_ehc(struct ehci_hc
 	}
 	clk_enable(omap->usbhost_ick);
 
-	omap->usbhost2_120m_fck = clk_get(omap->dev, "usbhost_120m_fck");
-	if (IS_ERR(omap->usbhost2_120m_fck)) {
-		ret = PTR_ERR(omap->usbhost2_120m_fck);
-		goto err_host_120m_fck;
-	}
-	clk_enable(omap->usbhost2_120m_fck);
-
-	omap->usbhost1_48m_fck = clk_get(omap->dev, "usbhost_48m_fck");
-	if (IS_ERR(omap->usbhost1_48m_fck)) {
-		ret = PTR_ERR(omap->usbhost1_48m_fck);
-		goto err_host_48m_fck;
+	omap->usbhost_hs_fck = clk_get(omap->dev, "usbhost_120m_fck");
+	if (IS_ERR(omap->usbhost_hs_fck)) {
+		ret = PTR_ERR(omap->usbhost_hs_fck);
+		goto err_host_hs_fck;
+	}
+	clk_enable(omap->usbhost_hs_fck);
+
+	omap->usbhost_fs_fck = clk_get(omap->dev, "usbhost_48m_fck");
+	if (IS_ERR(omap->usbhost_fs_fck)) {
+		ret = PTR_ERR(omap->usbhost_fs_fck);
+		goto err_host_fs_fck;
 	}
-	clk_enable(omap->usbhost1_48m_fck);
+	clk_enable(omap->usbhost_fs_fck);
 
 	if (omap->phy_reset) {
 		/* Refer: ISSUE1 */
@@ -472,8 +472,8 @@ err_tll_ick:
 	clk_put(omap->usbtll_fck);
 
 err_tll_fck:
-	clk_disable(omap->usbhost1_48m_fck);
-	clk_put(omap->usbhost1_48m_fck);
+	clk_disable(omap->usbhost_fs_fck);
+	clk_put(omap->usbhost_fs_fck);
 
 	if (omap->phy_reset) {
 		if (gpio_is_valid(omap->reset_gpio_port[0]))
@@ -483,11 +483,11 @@ err_tll_fck:
 			gpio_free(omap->reset_gpio_port[1]);
 	}
 
-err_host_48m_fck:
-	clk_disable(omap->usbhost2_120m_fck);
-	clk_put(omap->usbhost2_120m_fck);
+err_host_fs_fck:
+	clk_disable(omap->usbhost_hs_fck);
+	clk_put(omap->usbhost_hs_fck);
 
-err_host_120m_fck:
+err_host_hs_fck:
 	clk_disable(omap->usbhost_ick);
 	clk_put(omap->usbhost_ick);
 
@@ -550,16 +550,16 @@ static void omap_stop_ehc(struct ehci_hc
 		omap->usbhost_ick = NULL;
 	}
 
-	if (omap->usbhost1_48m_fck != NULL) {
-		clk_disable(omap->usbhost1_48m_fck);
-		clk_put(omap->usbhost1_48m_fck);
-		omap->usbhost1_48m_fck = NULL;
+	if (omap->usbhost_fs_fck != NULL) {
+		clk_disable(omap->usbhost_fs_fck);
+		clk_put(omap->usbhost_fs_fck);
+		omap->usbhost_fs_fck = NULL;
 	}
 
-	if (omap->usbhost2_120m_fck != NULL) {
-		clk_disable(omap->usbhost2_120m_fck);
-		clk_put(omap->usbhost2_120m_fck);
-		omap->usbhost2_120m_fck = NULL;
+	if (omap->usbhost_hs_fck != NULL) {
+		clk_disable(omap->usbhost_hs_fck);
+		clk_put(omap->usbhost_hs_fck);
+		omap->usbhost_hs_fck = NULL;
 	}
 
 	if (omap->usbtll_ick != NULL) {
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
