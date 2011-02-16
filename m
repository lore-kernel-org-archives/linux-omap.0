From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] usb: ehci-omap: add support for TLL mode on OMAP4
Date: Wed, 16 Feb 2011 15:43:14 +0530
Message-ID: <1297851194-26264-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The EHCI controller in OMAP4 supports a transceiver-less link
mode (TLL mode), similar to the one in OMAP3. On the OMAP4
however, there are an additional set of clocks that need
to be turned on to get this working.

Request and configure these for each port if that port
is connected in TLL mode.

Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
---
Against linux-next as of today.

 drivers/usb/host/ehci-omap.c |  134 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

Index: linux-omap-usb/drivers/usb/host/ehci-omap.c
===================================================================
--- linux-omap-usb.orig/drivers/usb/host/ehci-omap.c
+++ linux-omap-usb/drivers/usb/host/ehci-omap.c
@@ -195,7 +195,11 @@ struct ehci_hcd_omap {
 	struct clk		*xclk60mhsp1_ck;
 	struct clk		*xclk60mhsp2_ck;
 	struct clk		*utmi_p1_fck;
+	struct clk		*usbhost_p1_fck;
+	struct clk		*usbtll_p1_fck;
 	struct clk		*utmi_p2_fck;
+	struct clk		*usbhost_p2_fck;
+	struct clk		*usbtll_p2_fck;
 
 	/* FIXME the following two workarounds are
 	 * board specific not silicon-specific so these
@@ -410,6 +414,50 @@ static int omap_start_ehc(struct ehci_hc
 			}
 			break;
 		case EHCI_HCD_OMAP_MODE_TLL:
+			omap->xclk60mhsp1_ck = clk_get(omap->dev,
+							"init_60m_fclk");
+			if (IS_ERR(omap->xclk60mhsp1_ck)) {
+				ret = PTR_ERR(omap->xclk60mhsp1_ck);
+				dev_err(omap->dev,
+					"Unable to get Port1 ULPI clock\n");
+			}
+
+			omap->utmi_p1_fck = clk_get(omap->dev,
+							"utmi_p1_gfclk");
+			if (IS_ERR(omap->utmi_p1_fck)) {
+				ret = PTR_ERR(omap->utmi_p1_fck);
+				dev_err(omap->dev,
+					"Unable to get utmi_p1_fck\n");
+			}
+
+			ret = clk_set_parent(omap->utmi_p1_fck,
+						omap->xclk60mhsp1_ck);
+			if (ret != 0) {
+				dev_err(omap->dev,
+					"Unable to set P1 f-clock\n");
+			}
+
+			omap->usbhost_p1_fck = clk_get(omap->dev,
+						"usb_host_hs_utmi_p1_clk");
+			if (IS_ERR(omap->usbhost_p1_fck)) {
+				ret = PTR_ERR(omap->usbhost_p1_fck);
+				dev_err(omap->dev,
+					"Unable to get HOST PORT 1 clk\n");
+			} else {
+				clk_enable(omap->usbhost_p1_fck);
+			}
+
+			omap->usbtll_p1_fck = clk_get(omap->dev,
+						"usb_tll_hs_usb_ch0_clk");
+
+			if (IS_ERR(omap->usbtll_p1_fck)) {
+				ret = PTR_ERR(omap->usbtll_p1_fck);
+				dev_err(omap->dev,
+					"Unable to get TLL CH0 clk\n");
+			} else {
+				clk_enable(omap->usbtll_p1_fck);
+			}
+			break;
 			/* TODO */
 		default:
 			break;
@@ -440,6 +488,50 @@ static int omap_start_ehc(struct ehci_hc
 			}
 			break;
 		case EHCI_HCD_OMAP_MODE_TLL:
+			omap->xclk60mhsp2_ck = clk_get(omap->dev,
+							"init_60m_fclk");
+			if (IS_ERR(omap->xclk60mhsp2_ck)) {
+				ret = PTR_ERR(omap->xclk60mhsp2_ck);
+				dev_err(omap->dev,
+					"Unable to get Port2 ULPI clock\n");
+			}
+
+			omap->utmi_p2_fck = clk_get(omap->dev,
+							"utmi_p2_gfclk");
+			if (IS_ERR(omap->utmi_p2_fck)) {
+				ret = PTR_ERR(omap->utmi_p2_fck);
+				dev_err(omap->dev,
+					"Unable to get utmi_p2_fck\n");
+			}
+
+			ret = clk_set_parent(omap->utmi_p2_fck,
+						omap->xclk60mhsp2_ck);
+			if (ret != 0) {
+				dev_err(omap->dev,
+					"Unable to set P2 f-clock\n");
+			}
+
+			omap->usbhost_p2_fck = clk_get(omap->dev,
+						"usb_host_hs_utmi_p2_clk");
+			if (IS_ERR(omap->usbhost_p2_fck)) {
+				ret = PTR_ERR(omap->usbhost_p2_fck);
+				dev_err(omap->dev,
+					"Unable to get HOST PORT 2 clk\n");
+			} else {
+				clk_enable(omap->usbhost_p2_fck);
+			}
+
+			omap->usbtll_p2_fck = clk_get(omap->dev,
+						"usb_tll_hs_usb_ch1_clk");
+
+			if (IS_ERR(omap->usbtll_p2_fck)) {
+				ret = PTR_ERR(omap->usbtll_p2_fck);
+				dev_err(omap->dev,
+					"Unable to get TLL CH1 clk\n");
+			} else {
+				clk_enable(omap->usbtll_p2_fck);
+			}
+			break;
 			/* TODO */
 		default:
 			break;
@@ -602,6 +694,24 @@ static int omap_start_ehc(struct ehci_hc
 	return 0;
 
 err_sys_status:
+
+	if (omap->usbtll_p2_fck != NULL) {
+		clk_disable(omap->usbtll_p2_fck);
+		clk_put(omap->usbtll_p2_fck);
+	}
+	if (omap->usbhost_p2_fck != NULL) {
+		clk_disable(omap->usbhost_p2_fck);
+		clk_put(omap->usbhost_p2_fck);
+	}
+	if (omap->usbtll_p1_fck != NULL) {
+		clk_disable(omap->usbtll_p1_fck);
+		clk_put(omap->usbtll_p1_fck);
+	}
+	if (omap->usbhost_p1_fck != NULL) {
+		clk_disable(omap->usbhost_p1_fck);
+		clk_put(omap->usbhost_p1_fck);
+	}
+
 	clk_disable(omap->utmi_p2_fck);
 	clk_put(omap->utmi_p2_fck);
 	clk_disable(omap->xclk60mhsp2_ck);
@@ -740,6 +850,30 @@ static void omap_stop_ehc(struct ehci_hc
 			clk_put(omap->utmi_p2_fck);
 			omap->utmi_p2_fck = NULL;
 		}
+
+		if (omap->usbtll_p2_fck != NULL) {
+			clk_disable(omap->usbtll_p2_fck);
+			clk_put(omap->usbtll_p2_fck);
+			omap->usbtll_p2_fck = NULL;
+		}
+
+		if (omap->usbhost_p2_fck != NULL) {
+			clk_disable(omap->usbhost_p2_fck);
+			clk_put(omap->usbhost_p2_fck);
+			omap->usbhost_p2_fck = NULL;
+		}
+
+		if (omap->usbtll_p1_fck != NULL) {
+			clk_disable(omap->usbtll_p1_fck);
+			clk_put(omap->usbtll_p1_fck);
+			omap->usbtll_p1_fck = NULL;
+		}
+
+		if (omap->usbhost_p1_fck != NULL) {
+			clk_disable(omap->usbhost_p1_fck);
+			clk_put(omap->usbhost_p1_fck);
+			omap->usbhost_p1_fck = NULL;
+		}
 	}
 
 	if (omap->phy_reset) {
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
