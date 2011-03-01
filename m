From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 04/10 v1] arm: omap: usb: create common enums and
 structures for ehci and ohci
Date: Tue, 1 Mar 2011 14:35:43 +0200
Message-ID: <20110301123543.GY2942@legolas.emea.dhcp.ti.com>
References: <1298910712-2051-1-git-send-email-keshava_mgowda@ti.com>
 <1298910712-2051-2-git-send-email-keshava_mgowda@ti.com>
 <1298910712-2051-3-git-send-email-keshava_mgowda@ti.com>
 <1298910712-2051-4-git-send-email-keshava_mgowda@ti.com>
 <1298910712-2051-5-git-send-email-keshava_mgowda@ti.com>
 <20110301104940.GS2942@legolas.emea.dhcp.ti.com>
 <d228b38c51a625e4a8aa37aaa9253d70@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:56351 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754051Ab1CAMft (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 07:35:49 -0500
Content-Disposition: inline
In-Reply-To: <d228b38c51a625e4a8aa37aaa9253d70@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Anand Gadiyar <gadiyar@ti.com>, Partha Basak <p-basak2@ti.com>

On Tue, Mar 01, 2011 at 05:07:34PM +0530, Keshava Munegowda wrote:
> > -----Original Message-----
> > From: Felipe Balbi [mailto:balbi@ti.com]
> > Sent: Tuesday, March 01, 2011 4:20 PM
> > To: Keshava Munegowda
> > Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; balbi@ti.com;
> gadiyar@ti.com; p-
> > basak2@ti.com
> > Subject: Re: [PATCH 04/10 v1] arm: omap: usb: create common enums and
> structures for ehci and ohci
> >
> > On Mon, Feb 28, 2011 at 10:01:46PM +0530, Keshava Munegowda wrote:
> > > Create the ehci and ohci specific platform data structures.
> > > The port enum values are made common for both ehci and ohci.
> > >
> > > Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> >
> > Applying: arm: omap: usb: create common enums and structures for ehci
> and ohci
> > error: patch failed: drivers/usb/host/ehci-omap.c:409
> > error: drivers/usb/host/ehci-omap.c: patch does not apply
> > Patch failed at 0005 arm: omap: usb: create common enums and structures
> for ehci and ohci
> > When you have resolved this problem run "git am --resolved".
> > If you would prefer to skip this patch, instead run "git am --skip".
> > To restore the original branch and stop patching run "git am --abort".
> >
> > Which tree did you use as base for these patches ? I'm trying to apply
> > on top of v.2.6.38-rc6
> 
> Balbi
> 
> I tried at my side on l2.6.38-rc6 , it dint see any failures its working.
> 
> These patches are apply correctly on l2.6.38-rc6
> Commit id: f5412be599602124d2bdd49947b231dd77c0bf99
> 
> Please check; its working my side.

You have to rebase on top of this patch which is going to mainline:

commit ba39e359220928e6f303593c9e7066691912214a
Author: Anand Gadiyar <gadiyar@ti.com>
Date:   Wed Feb 16 15:43:14 2011 +0530

    usb: ehci: omap: add support for TLL mode on OMAP4
    
    The EHCI controller in OMAP4 supports a transceiver-less link
    mode (TLL mode), similar to the one in OMAP3. On the OMAP4
    however, there are an additional set of clocks that need
    to be turned on to get this working.
    
    Request and configure these for each port if that port
    is connected in TLL mode.
    
    Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
    Cc: Greg Kroah-Hartman <gregkh@suse.de>
    Signed-off-by: Felipe Balbi <balbi@ti.com>

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
balbi
