From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH] ehci: fix port connect status programming
Date: Tue, 13 Oct 2009 17:31:02 +0530
Message-ID: <1255435262-1178-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36895 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917AbZJMMBv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Oct 2009 08:01:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>, Anand Gadiyar <gadiyar@ti.com>

Current programming takes the default vaule of HSUSB port status
from UHH_HOSTCONFIG and write back the same to UHH_HOSTCONFIG
without updating.

This patch updates the port status based on board configuration.

Without this patch EHCI port becomes unusable on OMAP3EVM when a
USB HDD is connected to it through a HS HUB and we get below
error message,

"hub 1-0:1.0: Cannot enable port 1.  Maybe the USB cable is bad?"

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
Patch created against ehci branch.
 drivers/usb/host/ehci-omap.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 45b8a7c..f25e1b1 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -108,6 +108,9 @@
 #define OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN		(1 << 3)
 #define OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN		(1 << 4)
 #define OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN		(1 << 5)
+#define OMAP_UHH_HOSTCONFIG_P1_CONNECT_STATUS		(1 << 8)
+#define OMAP_UHH_HOSTCONFIG_P2_CONNECT_STATUS		(1 << 9)
+#define OMAP_UHH_HOSTCONFIG_P3_CONNECT_STATUS		(1 << 10)
 
 #define	OMAP_UHH_DEBUG_CSR				(0x44)
 
@@ -335,6 +338,13 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 			| OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN);
 	reg &= ~OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN;
 
+	if (omap->port_mode[0] == EHCI_HCD_OMAP_MODE_UNKNOWN)
+		reg &= ~OMAP_UHH_HOSTCONFIG_P1_CONNECT_STATUS;
+	if (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_UNKNOWN)
+		reg &= ~OMAP_UHH_HOSTCONFIG_P2_CONNECT_STATUS;
+	if (omap->port_mode[2] == EHCI_HCD_OMAP_MODE_UNKNOWN)
+		reg &= ~OMAP_UHH_HOSTCONFIG_P3_CONNECT_STATUS;
+
 	/* Bypass the TLL module for PHY mode operation */
 	 if (omap_rev() <= OMAP3430_REV_ES2_1) {
 		dev_dbg(omap->dev, "OMAP3 ES version <= ES2.1 \n");
-- 
1.6.2.4

