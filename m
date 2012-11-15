From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 09/16] mfd: omap-usb-host: override number of ports from platform data
Date: Thu, 15 Nov 2012 16:34:07 +0200
Message-ID: <1352990054-14680-10-git-send-email-rogerq@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52160 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768028Ab2KOOe3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 09:34:29 -0500
In-Reply-To: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, rogerq@ti.com

For some platforms e.g. OMAP5, we cannot rely on USBHOST revision
to determine the number of ports available. In such cases we have
to rely on platform data (or FDT) to give us the right number of
ports.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/usb-host.c        |    1 +
 arch/arm/plat-omap/include/plat/usb.h |    2 +
 drivers/mfd/omap-usb-host.c           |   46 +++++++++++++++++++++++----------
 3 files changed, 35 insertions(+), 14 deletions(-)

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
index ad89939..c20234b 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -500,8 +500,8 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 
 	omap->pdata = pdata;
 	platform_set_drvdata(pdev, omap);
-
 	pm_runtime_enable(dev);
+
 	pm_runtime_get_sync(dev);
 	omap->usbhs_rev = usbhs_read(omap->uhh_base, OMAP_UHH_REVISION);
 
@@ -510,19 +510,37 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
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
-		omap->nports = MAX_HS_USB_PORTS;
-		dev_info(dev,
-		  "USB HOST Rev : 0x%d not recognized, assuming %d ports\n",
-		   omap->usbhs_rev, omap->nports);
-		break;
+	/*
+	 * If platform data contains nports then use that
+	 * else make out number of ports from USBHS revision
+	 */
+	if (pdata->nports) {
+		if (omap->nports > MAX_HS_USB_PORTS) {
+			dev_err(dev,
+			 "Platform data says %d ports but MAX_HS_USB_PORTS is %d\n",
+			 omap->nports, MAX_HS_USB_PORTS);
+		} else {
+			omap->nports = pdata->nports;
+		}
+	} else {
+		switch (omap->usbhs_rev) {
+		case OMAP_USBHS_REV1:
+			omap->nports = 3;
+			break;
+		case OMAP_USBHS_REV2:
+		/* Both OMAP4 and 5 show the same revision but they have
+		 * different number of ports i.e. 2 and 3 respectively.
+		 * OMAP5 platforms must supply nports via platform data.
+		 */
+			omap->nports = 2;
+			break;
+		default:
+			omap->nports = MAX_HS_USB_PORTS;
+			dev_info(dev,
+			"USB HOST Rev:0x%d not recognized, assuming %d ports\n",
+				omap->usbhs_rev, omap->nports);
+			break;
+		}
 	}
 
 	need_logic_fck = false;
-- 
1.7.4.1

