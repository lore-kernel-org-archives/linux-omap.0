From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 11/16] mfd: omap-usb-host: Manage HSIC clocks for HSIC mode
Date: Thu, 15 Nov 2012 16:34:09 +0200
Message-ID: <1352990054-14680-12-git-send-email-rogerq@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352990054-14680-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Enable the optional HSIC clocks (60MHz and 480MHz) for the ports
that are configured in HSIC mode.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/omap-usb-host.c |   56 +++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 0d39bd7..e5ba193 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -88,6 +88,8 @@
 
 struct usbhs_port {
 	struct clk	*utmi_clk;
+	struct clk	*hsic60m_clk;
+	struct clk	*hsic480m_clk;
 };
 
 struct usbhs_hcd_omap {
@@ -300,6 +302,26 @@ static int usbhs_runtime_resume(struct device *dev)
 				}
 			}
 		}
+
+		/* Enable HSIC clocks if required */
+		if (is_ehci_hsic_mode(pdata->port_mode[i])) {
+			if (omap->port[i].hsic60m_clk) {
+				r = clk_enable(omap->port[i].hsic60m_clk);
+				if (r) {
+					dev_err(dev,
+					 "%s: Can't enable port %d hsic60m clk : %d\n",
+					 __func__, i, r);
+				}
+			}
+			if (omap->port[i].hsic480m_clk) {
+				r = clk_enable(omap->port[i].hsic480m_clk);
+				if (r) {
+					dev_err(dev,
+					 "%s: Can't enable port %d hsic480m clk : %d\n",
+					 __func__, i, r);
+				}
+			}
+		}
 	}
 
 	spin_unlock_irqrestore(&omap->lock, flags);
@@ -323,6 +345,14 @@ static int usbhs_runtime_suspend(struct device *dev)
 			if (omap->port[i].utmi_clk)
 				clk_disable(omap->port[i].utmi_clk);
 		}
+
+		if (is_ehci_hsic_mode(pdata->port_mode[i])) {
+			if (omap->port[i].hsic60m_clk)
+				clk_disable(omap->port[i].hsic60m_clk);
+
+			if (omap->port[i].hsic480m_clk)
+				clk_disable(omap->port[i].hsic480m_clk);
+		}
 	}
 
 	if (omap->ehci_logic_fck && !IS_ERR(omap->ehci_logic_fck))
@@ -575,6 +605,7 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 	for (i = 0; i < omap->nports; i++) {
 		struct clk *pclk;
 		char utmi_clk[] = "usb_host_hs_utmi_px_clk";
+		char hsic_clk[] = "usb_host_hs_hsic480m_px_clk";
 
 		/* clock names are indexed from 1*/
 		sprintf(utmi_clk, "usb_host_hs_utmi_p%d_clk", i + 1);
@@ -590,6 +621,21 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 		else
 			omap->port[i].utmi_clk = pclk;
 
+		sprintf(hsic_clk, "usb_host_hs_hsic480m_p%d_clk", i + 1);
+		pclk = clk_get(dev, hsic_clk);
+		if (IS_ERR(pclk))
+			dev_err(dev, "Failed to get clock : %s : %ld\n",
+				hsic_clk, PTR_ERR(pclk));
+		else
+			omap->port[i].hsic480m_clk = pclk;
+
+		sprintf(hsic_clk, "usb_host_hs_hsic60m_p%d_clk", i + 1);
+		pclk = clk_get(dev, hsic_clk);
+		if (IS_ERR(pclk))
+			dev_err(dev, "Failed to get clock : %s : %ld\n",
+				hsic_clk, PTR_ERR(pclk));
+		else
+			omap->port[i].hsic60m_clk = pclk;
 	}
 
 	if (is_ehci_phy_mode(pdata->port_mode[0])) {
@@ -637,8 +683,11 @@ err_alloc:
 	omap_usbhs_deinit(&pdev->dev);
 	iounmap(omap->uhh_base);
 
-	for (i = 0; i < omap->nports; i++)
+	for (i = 0; i < omap->nports; i++) {
 		clk_put(omap->port[i].utmi_clk);
+		clk_put(omap->port[i].hsic60m_clk);
+		clk_put(omap->port[i].hsic480m_clk);
+	}
 
 	clk_put(omap->init_60m_fclk);
 
@@ -673,8 +722,11 @@ static int __devexit usbhs_omap_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	iounmap(omap->uhh_base);
 
-	for (i = 0; i < omap->nports; i++)
+	for (i = 0; i < omap->nports; i++) {
 		clk_put(omap->port[i].utmi_clk);
+		clk_put(omap->port[i].hsic60m_clk);
+		clk_put(omap->port[i].hsic480m_clk);
+	}
 
 	clk_put(omap->init_60m_fclk);
 	clk_put(omap->xclk60mhsp2_ck);
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
