From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v5 2/9] mfd: omap-usb-host: Get clocks based on hardware revision
Date: Thu, 9 Jan 2014 17:38:16 +0530
Message-ID: <1389269303-30465-3-git-send-email-rogerq@ti.com>
References: <1389269303-30465-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389269303-30465-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, m.paolino-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Not all revisions have all the clocks so get the necessary clocks
based on hardware revision.

This should avoid un-necessary clk_get failure messages that were
observed earlier.

Be more strict and always fail on clk_get() error.

CC: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
CC: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/omap-usb-host.c | 93 +++++++++++++++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 29 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 1c9bca2..7202cc6 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -92,7 +92,6 @@
 #define is_ehci_tll_mode(x)	(x == OMAP_EHCI_PORT_MODE_TLL)
 #define is_ehci_hsic_mode(x)	(x == OMAP_EHCI_PORT_MODE_HSIC)
 
-
 struct usbhs_hcd_omap {
 	int				nports;
 	struct clk			**utmi_clk;
@@ -665,22 +664,41 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 		goto err_mem;
 	}
 
-	need_logic_fck = false;
+	/* Set all clocks as invalid to begin with */
+	omap->ehci_logic_fck = omap->init_60m_fclk = ERR_PTR(-EINVAL);
+	omap->utmi_p1_gfclk = omap->utmi_p2_gfclk = ERR_PTR(-EINVAL);
+	omap->xclk60mhsp1_ck = omap->xclk60mhsp2_ck = ERR_PTR(-EINVAL);
+
 	for (i = 0; i < omap->nports; i++) {
-		if (is_ehci_phy_mode(i) || is_ehci_tll_mode(i) ||
-			is_ehci_hsic_mode(i))
-				need_logic_fck |= true;
+		omap->utmi_clk[i] = ERR_PTR(-EINVAL);
+		omap->hsic480m_clk[i] = ERR_PTR(-EINVAL);
+		omap->hsic60m_clk[i] = ERR_PTR(-EINVAL);
 	}
 
-	omap->ehci_logic_fck = ERR_PTR(-EINVAL);
-	if (need_logic_fck) {
-		omap->ehci_logic_fck = devm_clk_get(dev, "ehci_logic_fck");
-		if (IS_ERR(omap->ehci_logic_fck)) {
-			ret = PTR_ERR(omap->ehci_logic_fck);
-			dev_dbg(dev, "ehci_logic_fck failed:%d\n", ret);
+	/* for OMAP3 i.e. USBHS REV1 */
+	if (omap->usbhs_rev == OMAP_USBHS_REV1) {
+		need_logic_fck = false;
+		for (i = 0; i < omap->nports; i++) {
+			if (is_ehci_phy_mode(pdata->port_mode[i]) ||
+			    is_ehci_tll_mode(pdata->port_mode[i]) ||
+			    is_ehci_hsic_mode(pdata->port_mode[i]))
+
+				need_logic_fck |= true;
+		}
+
+		if (need_logic_fck) {
+			omap->ehci_logic_fck = clk_get(dev, "usbhost_120m_fck");
+			if (IS_ERR(omap->ehci_logic_fck)) {
+				ret = PTR_ERR(omap->ehci_logic_fck);
+				dev_err(dev, "usbhost_120m_fck failed:%d\n",
+					ret);
+				goto err_mem;
+			}
 		}
+		goto initialize;
 	}
 
+	/* for OMAP4+ i.e. USBHS REV2+ */
 	omap->utmi_p1_gfclk = devm_clk_get(dev, "utmi_p1_gfclk");
 	if (IS_ERR(omap->utmi_p1_gfclk)) {
 		ret = PTR_ERR(omap->utmi_p1_gfclk);
@@ -728,54 +746,71 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 		 * them
 		 */
 		omap->utmi_clk[i] = devm_clk_get(dev, clkname);
-		if (IS_ERR(omap->utmi_clk[i]))
-			dev_dbg(dev, "Failed to get clock : %s : %ld\n",
-				clkname, PTR_ERR(omap->utmi_clk[i]));
+		if (IS_ERR(omap->utmi_clk[i])) {
+			ret = PTR_ERR(omap->utmi_clk[i]);
+			dev_err(dev, "Failed to get clock : %s : %d\n",
+				clkname, ret);
+			goto err_mem;
+		}
 
 		snprintf(clkname, sizeof(clkname),
 				"usb_host_hs_hsic480m_p%d_clk", i + 1);
 		omap->hsic480m_clk[i] = devm_clk_get(dev, clkname);
-		if (IS_ERR(omap->hsic480m_clk[i]))
-			dev_dbg(dev, "Failed to get clock : %s : %ld\n",
-				clkname, PTR_ERR(omap->hsic480m_clk[i]));
+		if (IS_ERR(omap->hsic480m_clk[i])) {
+			ret = PTR_ERR(omap->hsic480m_clk[i]);
+			dev_err(dev, "Failed to get clock : %s : %d\n",
+				clkname, ret);
+			goto err_mem;
+		}
 
 		snprintf(clkname, sizeof(clkname),
 				"usb_host_hs_hsic60m_p%d_clk", i + 1);
 		omap->hsic60m_clk[i] = devm_clk_get(dev, clkname);
-		if (IS_ERR(omap->hsic60m_clk[i]))
-			dev_dbg(dev, "Failed to get clock : %s : %ld\n",
-				clkname, PTR_ERR(omap->hsic60m_clk[i]));
+		if (IS_ERR(omap->hsic60m_clk[i])) {
+			ret = PTR_ERR(omap->hsic60m_clk[i]);
+			dev_err(dev, "Failed to get clock : %s : %d\n",
+				clkname, ret);
+			goto err_mem;
+		}
 	}
 
 	if (is_ehci_phy_mode(pdata->port_mode[0])) {
-		/* for OMAP3, clk_set_parent fails */
 		ret = clk_set_parent(omap->utmi_p1_gfclk,
 					omap->xclk60mhsp1_ck);
-		if (ret != 0)
-			dev_dbg(dev, "xclk60mhsp1_ck set parent failed: %d\n",
+		if (ret != 0) {
+			dev_err(dev, "xclk60mhsp1_ck set parent failed: %d\n",
 					ret);
+			goto err_mem;
+		}
 	} else if (is_ehci_tll_mode(pdata->port_mode[0])) {
 		ret = clk_set_parent(omap->utmi_p1_gfclk,
 					omap->init_60m_fclk);
-		if (ret != 0)
-			dev_dbg(dev, "P0 init_60m_fclk set parent failed: %d\n",
+		if (ret != 0) {
+			dev_err(dev, "P0 init_60m_fclk set parent failed: %d\n",
 					ret);
+			goto err_mem;
+		}
 	}
 
 	if (is_ehci_phy_mode(pdata->port_mode[1])) {
 		ret = clk_set_parent(omap->utmi_p2_gfclk,
 					omap->xclk60mhsp2_ck);
-		if (ret != 0)
-			dev_dbg(dev, "xclk60mhsp2_ck set parent failed: %d\n",
+		if (ret != 0) {
+			dev_err(dev, "xclk60mhsp2_ck set parent failed: %d\n",
 					ret);
+			goto err_mem;
+		}
 	} else if (is_ehci_tll_mode(pdata->port_mode[1])) {
 		ret = clk_set_parent(omap->utmi_p2_gfclk,
 						omap->init_60m_fclk);
-		if (ret != 0)
-			dev_dbg(dev, "P1 init_60m_fclk set parent failed: %d\n",
+		if (ret != 0) {
+			dev_err(dev, "P1 init_60m_fclk set parent failed: %d\n",
 					ret);
+			goto err_mem;
+		}
 	}
 
+initialize:
 	omap_usbhs_init(dev);
 
 	if (dev->of_node) {
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
