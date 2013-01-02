From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 13/22] mfd: omap-usb-host: override number of ports from platform data
Date: Wed, 2 Jan 2013 17:00:33 +0200
Message-ID: <1357138842-28964-14-git-send-email-rogerq@ti.com>
References: <1357138842-28964-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1357138842-28964-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, sameo@linux.intel.com, tony@atomide.com
Cc: keshava_mgowda@ti.com, sshtylyov@mvista.com, bjorn@mork.no, rogerq@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Both OMAP4 and 5 exhibit the same revision ID in the REVISION register
but they have different number of ports i.e. 2 and 3 respectively.
So we can't rely on REVISION register for number of ports on OMAP5
and depend on platform data (or device tree) instead.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/usb-host.c         |    1 +
 arch/arm/mach-omap2/usb.h              |    1 +
 drivers/mfd/omap-usb-host.c            |   34 +++++++++++++++++++------------
 include/linux/platform_data/usb-omap.h |    1 +
 4 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index 2e44e8a..ee8c473 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -504,6 +504,7 @@ void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
 	ohci_data.es2_compatibility = pdata->es2_compatibility;
 	usbhs_data.ehci_data = &ehci_data;
 	usbhs_data.ohci_data = &ohci_data;
+	usbhs_data.nports = pdata->nports;
 
 	if (cpu_is_omap34xx()) {
 		setup_ehci_io_mux(pdata->port_mode);
diff --git a/arch/arm/mach-omap2/usb.h b/arch/arm/mach-omap2/usb.h
index 9b986ea..7dc0f04 100644
--- a/arch/arm/mach-omap2/usb.h
+++ b/arch/arm/mach-omap2/usb.h
@@ -54,6 +54,7 @@
 #define USBPHY_DATA_POLARITY	(1 << 23)
 
 struct usbhs_omap_board_data {
+	int				nports;
 	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
 
 	/* have to be valid if phy_reset is true and portx is in phy mode */
diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 5edb828..710460d 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -497,19 +497,27 @@ static int usbhs_omap_probe(struct platform_device *pdev)
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
+		omap->nports = pdata->nports;
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
diff --git a/include/linux/platform_data/usb-omap.h b/include/linux/platform_data/usb-omap.h
index ef65b67..57707c7 100644
--- a/include/linux/platform_data/usb-omap.h
+++ b/include/linux/platform_data/usb-omap.h
@@ -55,6 +55,7 @@ struct ohci_hcd_omap_platform_data {
 };
 
 struct usbhs_omap_platform_data {
+	int					nports;
 	enum usbhs_omap_port_mode		port_mode[OMAP3_HS_USB_PORTS];
 
 	struct ehci_hcd_omap_platform_data	*ehci_data;
-- 
1.7.4.1
