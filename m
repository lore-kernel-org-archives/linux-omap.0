From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH RFC 1/2] usb: ehci-omap: factor out clock handling
Date: Thu, 13 May 2010 20:30:21 +0530
Message-ID: <1273762822-23073-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Factor out the clock enable/disable calls in the driver for
reuse in the suspend/resume paths.

Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
---
Based off v2.6.34-rc7 + gregkh-07-usb-2.6.34-rc7.patch
and one recent patch I posted [1]

[1] http://marc.info/?l=linux-usb&m=127315680127935&w=2

 drivers/usb/host/ehci-omap.c |   46 +++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

Index: linux-2.6/drivers/usb/host/ehci-omap.c
===================================================================
--- linux-2.6.orig/drivers/usb/host/ehci-omap.c
+++ linux-2.6/drivers/usb/host/ehci-omap.c
@@ -190,6 +190,23 @@ struct ehci_hcd_omap {
 
 /*-------------------------------------------------------------------------*/
 
+static void ehci_omap_clock_power(struct ehci_hcd_omap *omap, int on)
+{
+	if (on) {
+		clk_enable(omap->usbtll_ick);
+		clk_enable(omap->usbtll_fck);
+		clk_enable(omap->usbhost_ick);
+		clk_enable(omap->usbhost1_48m_fck);
+		clk_enable(omap->usbhost2_120m_fck);
+	} else {
+		clk_disable(omap->usbhost2_120m_fck);
+		clk_disable(omap->usbhost1_48m_fck);
+		clk_disable(omap->usbhost_ick);
+		clk_disable(omap->usbtll_fck);
+		clk_disable(omap->usbtll_ick);
+	}
+}
+
 static void omap_usb_utmi_init(struct ehci_hcd_omap *omap, u8 tll_channel_mask)
 {
 	unsigned reg;
@@ -248,27 +265,27 @@ static int omap_start_ehc(struct ehci_hc
 
 	dev_dbg(omap->dev, "starting TI EHCI USB Controller\n");
 
-	/* Enable Clocks for USBHOST */
+	/* Get all the clock handles we need */
 	omap->usbhost_ick = clk_get(omap->dev, "usbhost_ick");
 	if (IS_ERR(omap->usbhost_ick)) {
+		dev_err(omap->dev, "could not get usbhost_ick\n");
 		ret =  PTR_ERR(omap->usbhost_ick);
 		goto err_host_ick;
 	}
-	clk_enable(omap->usbhost_ick);
 
 	omap->usbhost2_120m_fck = clk_get(omap->dev, "usbhost_120m_fck");
 	if (IS_ERR(omap->usbhost2_120m_fck)) {
+		dev_err(omap->dev, "could not get usbhost_120m_fck\n");
 		ret = PTR_ERR(omap->usbhost2_120m_fck);
 		goto err_host_120m_fck;
 	}
-	clk_enable(omap->usbhost2_120m_fck);
 
 	omap->usbhost1_48m_fck = clk_get(omap->dev, "usbhost_48m_fck");
 	if (IS_ERR(omap->usbhost1_48m_fck)) {
+		dev_err(omap->dev, "could not get usbhost_48m_fck\n");
 		ret = PTR_ERR(omap->usbhost1_48m_fck);
 		goto err_host_48m_fck;
 	}
-	clk_enable(omap->usbhost1_48m_fck);
 
 	if (omap->phy_reset) {
 		/* Refer: ISSUE1 */
@@ -288,20 +305,22 @@ static int omap_start_ehc(struct ehci_hc
 		udelay(10);
 	}
 
-	/* Configure TLL for 60Mhz clk for ULPI */
 	omap->usbtll_fck = clk_get(omap->dev, "usbtll_fck");
 	if (IS_ERR(omap->usbtll_fck)) {
+		dev_err(omap->dev, "could not get usbtll_fck\n");
 		ret = PTR_ERR(omap->usbtll_fck);
 		goto err_tll_fck;
 	}
-	clk_enable(omap->usbtll_fck);
 
 	omap->usbtll_ick = clk_get(omap->dev, "usbtll_ick");
 	if (IS_ERR(omap->usbtll_ick)) {
+		dev_err(omap->dev, "could not get usbtll_ick\n");
 		ret = PTR_ERR(omap->usbtll_ick);
 		goto err_tll_ick;
 	}
-	clk_enable(omap->usbtll_ick);
+
+	/* Now enable all the clocks in the correct order */
+	ehci_omap_clock_power(omap, 1);
 
 	/* perform TLL soft reset, and wait until reset is complete */
 	ehci_omap_writel(omap->tll_base, OMAP_USBTLL_SYSCONFIG,
@@ -428,15 +447,13 @@ static int omap_start_ehc(struct ehci_hc
 	return 0;
 
 err_sys_status:
-	clk_disable(omap->usbtll_ick);
+	ehci_omap_clock_power(omap, 0);
 	clk_put(omap->usbtll_ick);
 
 err_tll_ick:
-	clk_disable(omap->usbtll_fck);
 	clk_put(omap->usbtll_fck);
 
 err_tll_fck:
-	clk_disable(omap->usbhost1_48m_fck);
 	clk_put(omap->usbhost1_48m_fck);
 
 	if (omap->phy_reset) {
@@ -448,11 +465,9 @@ err_tll_fck:
 	}
 
 err_host_48m_fck:
-	clk_disable(omap->usbhost2_120m_fck);
 	clk_put(omap->usbhost2_120m_fck);
 
 err_host_120m_fck:
-	clk_disable(omap->usbhost_ick);
 	clk_put(omap->usbhost_ick);
 
 err_host_ick:
@@ -502,32 +517,29 @@ static void omap_stop_ehc(struct ehci_hc
 			dev_dbg(omap->dev, "operation timed out\n");
 	}
 
+	ehci_omap_clock_power(omap, 0);
+
 	if (omap->usbtll_fck != NULL) {
-		clk_disable(omap->usbtll_fck);
 		clk_put(omap->usbtll_fck);
 		omap->usbtll_fck = NULL;
 	}
 
 	if (omap->usbhost_ick != NULL) {
-		clk_disable(omap->usbhost_ick);
 		clk_put(omap->usbhost_ick);
 		omap->usbhost_ick = NULL;
 	}
 
 	if (omap->usbhost1_48m_fck != NULL) {
-		clk_disable(omap->usbhost1_48m_fck);
 		clk_put(omap->usbhost1_48m_fck);
 		omap->usbhost1_48m_fck = NULL;
 	}
 
 	if (omap->usbhost2_120m_fck != NULL) {
-		clk_disable(omap->usbhost2_120m_fck);
 		clk_put(omap->usbhost2_120m_fck);
 		omap->usbhost2_120m_fck = NULL;
 	}
 
 	if (omap->usbtll_ick != NULL) {
-		clk_disable(omap->usbtll_ick);
 		clk_put(omap->usbtll_ick);
 		omap->usbtll_ick = NULL;
 	}
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
