From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH v2 1/8] usb: ehci-omap: update clock names to be more generic
Date: Mon, 29 Nov 2010 22:55:30 +0530
Message-ID: <1291051537-23743-2-git-send-email-gadiyar@ti.com>
References: <1291051537-23743-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41362 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab0K2RZt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Nov 2010 12:25:49 -0500
In-Reply-To: <1291051537-23743-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Greg KH <gregkh@suse.de>, Keshava Munegowda <keshava_mgowda@ti.com>, Anand Gadiyar <gadiyar@ti.com>

From: Keshava Munegowda <keshava_mgowda@ti.com>

Rename usbhost2_120m_fck to usbhost_hs_fck and usbhost1_48m_fck
to usbhost_fs_fck, to better reflect the clocks' functionalities.

In OMAP4, the frequencies for the corresponding clocks are not
necessarily the same as with OMAP3, however the functionalities
are.

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 drivers/usb/host/ehci-omap.c |   44 +++++++++++++++++++++---------------------
 1 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 116ae28..d042bde 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -156,8 +156,8 @@ struct ehci_hcd_omap {
 	struct device		*dev;
 
 	struct clk		*usbhost_ick;
-	struct clk		*usbhost2_120m_fck;
-	struct clk		*usbhost1_48m_fck;
+	struct clk		*usbhost_hs_fck;
+	struct clk		*usbhost_fs_fck;
 	struct clk		*usbtll_fck;
 	struct clk		*usbtll_ick;
 
@@ -286,19 +286,19 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 	}
 	clk_enable(omap->usbhost_ick);
 
-	omap->usbhost2_120m_fck = clk_get(omap->dev, "usbhost_120m_fck");
-	if (IS_ERR(omap->usbhost2_120m_fck)) {
-		ret = PTR_ERR(omap->usbhost2_120m_fck);
+	omap->usbhost_hs_fck = clk_get(omap->dev, "usbhost_120m_fck");
+	if (IS_ERR(omap->usbhost_hs_fck)) {
+		ret = PTR_ERR(omap->usbhost_hs_fck);
 		goto err_host_120m_fck;
 	}
-	clk_enable(omap->usbhost2_120m_fck);
+	clk_enable(omap->usbhost_hs_fck);
 
-	omap->usbhost1_48m_fck = clk_get(omap->dev, "usbhost_48m_fck");
-	if (IS_ERR(omap->usbhost1_48m_fck)) {
-		ret = PTR_ERR(omap->usbhost1_48m_fck);
+	omap->usbhost_fs_fck = clk_get(omap->dev, "usbhost_48m_fck");
+	if (IS_ERR(omap->usbhost_fs_fck)) {
+		ret = PTR_ERR(omap->usbhost_fs_fck);
 		goto err_host_48m_fck;
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
@@ -484,8 +484,8 @@ err_tll_fck:
 	}
 
 err_host_48m_fck:
-	clk_disable(omap->usbhost2_120m_fck);
-	clk_put(omap->usbhost2_120m_fck);
+	clk_disable(omap->usbhost_hs_fck);
+	clk_put(omap->usbhost_hs_fck);
 
 err_host_120m_fck:
 	clk_disable(omap->usbhost_ick);
@@ -550,16 +550,16 @@ static void omap_stop_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
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
1.7.0.4

