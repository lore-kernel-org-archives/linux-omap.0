From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/2] usb: dwc3: core: enable phy suspend quirk on non-FPGA
Date: Thu, 6 Nov 2014 11:36:05 -0600
Message-ID: <1415295366-593-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58305 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbaKFRf6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Nov 2014 12:35:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

as it turns out, at least AM437x silicon (non-FPGA)
needs to enable PHY suspend quirk. So let's allow
for PHY suspend quirk to be used with non-FPGA
builds too.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/dwc3/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 8ae42b8..25ddc39 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -404,7 +404,7 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->tx_de_emphasis_quirk)
 		reg |= DWC3_GUSB3PIPECTL_TX_DEEPH(dwc->tx_de_emphasis);
 
-	if (dwc->dis_u3_susphy_quirk && dwc->is_fpga)
+	if (dwc->dis_u3_susphy_quirk)
 		reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
 
 	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
@@ -422,7 +422,7 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->revision > DWC3_REVISION_194A)
 		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
 
-	if (dwc->dis_u2_susphy_quirk && dwc->is_fpga)
+	if (dwc->dis_u2_susphy_quirk)
 		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
 
 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
-- 
2.1.0.GIT

