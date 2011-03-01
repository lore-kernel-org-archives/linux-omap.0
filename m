From: Felipe Balbi <balbi@ti.com>
Subject: [patch-v2.6.39 09/19] usb: ehci: omap: add support for TLL mode on OMAP4
Date: Tue,  1 Mar 2011 17:15:30 +0200
Message-ID: <1298992540-5984-10-git-send-email-balbi@ti.com>
References: <1298992540-5984-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:37981 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756643Ab1CAPQl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 10:16:41 -0500
In-Reply-To: <1298992540-5984-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Anand Gadiyar <gadiyar@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Felipe Balbi <balbi@ti.com>

From: Anand Gadiyar <gadiyar@ti.com>

The EHCI controller in OMAP4 supports a transceiver-less link
mode (TLL mode), similar to the one in OMAP3. On the OMAP4
however, there are an additional set of clocks that need
to be turned on to get this working.

Request and configure these for each port if that port
is connected in TLL mode.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/host/ehci-omap.c |  134 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 134 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index f784ceb..d7e223b 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
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
@@ -410,6 +414,50 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
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
@@ -440,6 +488,50 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
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
@@ -602,6 +694,24 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
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
@@ -740,6 +850,30 @@ static void omap_stop_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
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
1.7.4.rc2

