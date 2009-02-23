From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-v2.6.29-rc5+ 15/23] usb: host: ehci: disable clocks on error
Date: Mon, 23 Feb 2009 20:55:27 +0200
Message-ID: <1235415335-17408-16-git-send-email-me@felipebalbi.com>
References: <1235415335-17408-1-git-send-email-me@felipebalbi.com>
 <1235415335-17408-2-git-send-email-me@felipebalbi.com>
 <1235415335-17408-3-git-send-email-me@felipebalbi.com>
 <1235415335-17408-4-git-send-email-me@felipebalbi.com>
 <1235415335-17408-5-git-send-email-me@felipebalbi.com>
 <1235415335-17408-6-git-send-email-me@felipebalbi.com>
 <1235415335-17408-7-git-send-email-me@felipebalbi.com>
 <1235415335-17408-8-git-send-email-me@felipebalbi.com>
 <1235415335-17408-9-git-send-email-me@felipebalbi.com>
 <1235415335-17408-10-git-send-email-me@felipebalbi.com>
 <1235415335-17408-11-git-send-email-me@felipebalbi.com>
 <1235415335-17408-12-git-send-email-me@felipebalbi.com>
 <1235415335-17408-13-git-send-email-me@felipebalbi.com>
 <1235415335-17408-14-git-send-email-me@felipebalbi.com>
 <1235415335-17408-15-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42669 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706AbZBWS5a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:57:30 -0500
In-Reply-To: <1235415335-17408-15-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <me@felipebalbi.com>

The driver wasn't releasing the requested resources
on error, so make that work.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/usb/host/ehci-omap.c |   82 ++++++++++++++++++++++++++++++++++--------
 1 files changed, 67 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 35c645d..b058ada 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -262,6 +262,7 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 {
 	struct ehci_omap_clock_defs *ehci_clocks;
 	unsigned long timeout = jiffies + msecs_to_jiffies(100);
+	int ret = 0;
 
 	dev_dbg(hcd->self.controller, "starting TI EHCI USB Controller\n");
 
@@ -293,7 +294,8 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 
 		if (time_after(timeout, jiffies)) {
 			dev_dbg(hcd->self.controller, "operation timed out\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_idlest2;
 		}
 	}
 	/* End DPLL5 programming */
@@ -317,20 +319,26 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 	/* Enable Clocks for USBHOST */
 	ehci_clocks->usbhost_ick_clk = clk_get(&dev->dev,
 						USBHOST_ICKL);
-	if (IS_ERR(ehci_clocks->usbhost_ick_clk))
-		return PTR_ERR(ehci_clocks->usbhost_ick_clk);
+	if (IS_ERR(ehci_clocks->usbhost_ick_clk)) {
+		ret =  PTR_ERR(ehci_clocks->usbhost_ick_clk);
+		goto err_host_ick;
+	}
 	clk_enable(ehci_clocks->usbhost_ick_clk);
 
 	ehci_clocks->usbhost2_120m_fck_clk = clk_get(&dev->dev,
 							USBHOST_120M_FCLK);
-	if (IS_ERR(ehci_clocks->usbhost2_120m_fck_clk))
-		return PTR_ERR(ehci_clocks->usbhost2_120m_fck_clk);
+	if (IS_ERR(ehci_clocks->usbhost2_120m_fck_clk)) {
+		ret = PTR_ERR(ehci_clocks->usbhost2_120m_fck_clk);
+		goto err_host_120m_fck;
+	}
 	clk_enable(ehci_clocks->usbhost2_120m_fck_clk);
 
 	ehci_clocks->usbhost1_48m_fck_clk = clk_get(&dev->dev,
 						USBHOST_48M_FCLK);
-	if (IS_ERR(ehci_clocks->usbhost1_48m_fck_clk))
-		return PTR_ERR(ehci_clocks->usbhost1_48m_fck_clk);
+	if (IS_ERR(ehci_clocks->usbhost1_48m_fck_clk)) {
+		ret = PTR_ERR(ehci_clocks->usbhost1_48m_fck_clk);
+		goto err_host_48m_fck;
+	}
 	clk_enable(ehci_clocks->usbhost1_48m_fck_clk);
 
 
@@ -346,13 +354,17 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 
 	/* Configure TLL for 60Mhz clk for ULPI */
 	ehci_clocks->usbtll_fck_clk = clk_get(&dev->dev, USBHOST_TLL_FCLK);
-	if (IS_ERR(ehci_clocks->usbtll_fck_clk))
-		return PTR_ERR(ehci_clocks->usbtll_fck_clk);
+	if (IS_ERR(ehci_clocks->usbtll_fck_clk)) {
+		ret = PTR_ERR(ehci_clocks->usbtll_fck_clk);
+		goto err_tll_fck;
+	}
 	clk_enable(ehci_clocks->usbtll_fck_clk);
 
 	ehci_clocks->usbtll_ick_clk = clk_get(&dev->dev, USBHOST_TLL_ICKL);
-	if (IS_ERR(ehci_clocks->usbtll_ick_clk))
-		return PTR_ERR(ehci_clocks->usbtll_ick_clk);
+	if (IS_ERR(ehci_clocks->usbtll_ick_clk)) {
+		ret = PTR_ERR(ehci_clocks->usbtll_ick_clk);
+		goto err_tll_ick;
+	}
 	clk_enable(ehci_clocks->usbtll_ick_clk);
 
 	/* Disable Auto Idle of USBTLL */
@@ -366,7 +378,8 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 
 		if (time_after(timeout, jiffies)) {
 			dev_dbg(hcd->self.controller, "operation timed out\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_idlest3;
 		}
 	}
 
@@ -381,7 +394,8 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 
 		if (time_after(timeout, jiffies)) {
 			dev_dbg(hcd->self.controller, "operation timed out\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_sys_status;
 		}
 	}
 
@@ -418,7 +432,8 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 
 		if (time_after(timeout, jiffies)) {
 			dev_dbg(hcd->self.controller, "operation timed out\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_ulpi_bypass;
 		}
 	}
 
@@ -461,13 +476,50 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 
 		if (time_after(timeout, jiffies)) {
 			dev_dbg(hcd->self.controller, "operation timed out\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_ulpi_control;
 		}
 	}
 
 #endif
 
 	return 0;
+
+#ifdef VBUS_INTERNAL_CHARGEPUMP_HACK
+err_ulpi_control:
+#endif
+#ifdef CONFIG_OMAP_EHCI_PHY_MODE
+err_ulpi_bypass:
+#endif
+err_sys_status:
+err_idlest3:
+	clk_disable(ehci_clocks->usbtll_ick_clk);
+	clk_put(ehci_clocks->usbtll_ick_clk);
+
+err_tll_ick:
+	clk_disable(ehci_clocks->usbtll_fck_clk);
+	clk_put(ehci_clocks->usbtll_fck_clk);
+
+err_tll_fck:
+	clk_disable(ehci_clocks->usbhost1_48m_fck_clk);
+	clk_put(ehci_clocks->usbhost1_48m_fck_clk);
+
+#ifdef EXTERNAL_PHY_RESET
+	gpio_free(EXT_PHY_RESET_GPIO_PORT1);
+	gpio_free(EXT_PHY_RESET_GPIO_PORT2);
+#endif
+
+err_host_48m_fck:
+	clk_disable(ehci_clocks->usbhost2_120m_fck_clk);
+	clk_put(ehci_clocks->usbhost2_120m_fck_clk);
+
+err_host_120m_fck:
+	clk_disable(ehci_clocks->usbhost_ick_clk);
+	clk_put(ehci_clocks->usbhost_ick_clk);
+
+err_host_ick:
+err_idlest2:
+	return ret;
 }
 
 static void omap_stop_ehc(struct platform_device *dev, struct usb_hcd *hcd)
-- 
1.6.1.3

