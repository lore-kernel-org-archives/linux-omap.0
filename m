From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 13/22] mfd: omap-usb-host: override number of ports from platform data
Date: Wed, 28 Nov 2012 16:49:01 +0200
Message-ID: <1354114150-11941-14-git-send-email-rogerq@ti.com>
References: <1354114150-11941-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34774 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932276Ab2K1Otb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Nov 2012 09:49:31 -0500
In-Reply-To: <1354114150-11941-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: keshava_mgowda@ti.com, rogerq@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Both OMAP4 and 5 exhibit the same revision ID in the REVISION register
but they have different number of ports i.e. 2 and 3 respectively.
So we can't rely on REVISION register for number of ports on OMAP5
and depend on platform data (or device tree) instead.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/usb-host.c        |    1 +
 arch/arm/plat-omap/include/plat/usb.h |    2 +
 drivers/mfd/omap-usb-host.c           |   34 ++++++++++++++++++++------------
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index 3c43449..eb85528 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -504,6 +504,7 @@ void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
 	ohci_data.es2_compatibility = pdata->es2_compatibility;
 	usbhs_data.ehci_data = &ehci_data;
 	usbhs_data.ohci_data = &ohci_data;
+	usbhs_data.nports = pdata->nports;
 
 	if (cpu_is_omap34xx()) {
 		setup_ehci_io_mux(pdata->port_mode);
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 87ee140..6b618a1 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -27,6 +27,7 @@ enum usbhs_omap_port_mode {
 };
 
 struct usbhs_omap_board_data {
+	int				nports;
 	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
 
 	/* have to be valid if phy_reset is true and portx is in phy mode */
@@ -59,6 +60,7 @@ struct ohci_hcd_omap_platform_data {
 };
 
 struct usbhs_omap_platform_data {
+	int					nports;
 	enum usbhs_omap_port_mode		port_mode[OMAP3_HS_USB_PORTS];
 
 	struct ehci_hcd_omap_platform_data	*ehci_data;
diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 87b574b..fda235a 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -495,19 +495,27 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 	 */
 	pm_runtime_put_sync(dev);
 
-	switch (omap->usbhs_rev) {
-	case OMAP_USBHS_REV1:
-		omap->nports = 3;
-		break;
-	case OMAP_USBHS_REV2:
-		omap->nports = 2;
-		break;
-	default:
-		omap->nports = OMAP3_HS_USB_PORTS;
-		dev_dbg(dev,
-		  "USB HOST Rev : 0x%d not recognized, assuming %d ports\n",
-		   omap->usbhs_rev, omap->nports);
-		break;
+	/*
+	 * If platform data contains nports then use that
+	 * else make out number of ports from USBHS revision
+	 */
+	if (pdata->nports) {
+			omap->nports = pdata->nports;
+	} else {
+		switch (omap->usbhs_rev) {
+		case OMAP_USBHS_REV1:
+			omap->nports = 3;
+			break;
+		case OMAP_USBHS_REV2:
+			omap->nports = 2;
+			break;
+		default:
+			omap->nports = OMAP3_HS_USB_PORTS;
+			dev_dbg(dev,
+			"USB HOST Rev:0x%d not recognized, assuming %d ports\n",
+				omap->usbhs_rev, omap->nports);
+			break;
+		}
 	}
 
 	for (i = 0; i < omap->nports; i++)
-- 
1.7.4.1

