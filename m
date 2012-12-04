From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 01/23] mfd: omap-usb-host: get rid of cpu_is_omap..() macros
Date: Tue, 4 Dec 2012 16:12:54 +0200
Message-ID: <1354630396-24545-2-git-send-email-rogerq@ti.com>
References: <1354630396-24545-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43134 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753121Ab2LDONc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Dec 2012 09:13:32 -0500
In-Reply-To: <1354630396-24545-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: keshava_mgowda@ti.com, sshtylyov@mvista.com, bjorn@mork.no, rogerq@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Instead of using cpu_is_omap..() macros in the device driver we
rely on information provided in the platform data.

The only information we need is whether the USB Host module has
a single ULPI bypass control bit for all ports or individual bypass
control bits for each port. OMAP3 REV2.1 and earlier have the former.

Signed-off-by: Roger Quadros <rogerq@ti.com>
CC: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/usb-host.c         |    4 ++++
 drivers/mfd/omap-usb-host.c            |    2 +-
 include/linux/platform_data/usb-omap.h |    3 +++
 3 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index d1dbe12..2e44e8a 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -508,6 +508,10 @@ void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
 	if (cpu_is_omap34xx()) {
 		setup_ehci_io_mux(pdata->port_mode);
 		setup_ohci_io_mux(pdata->port_mode);
+
+		if (omap_rev() <= OMAP3430_REV_ES2_1)
+			usbhs_data.single_ulpi_bypass = true;
+
 	} else if (cpu_is_omap44xx()) {
 		setup_4430ehci_io_mux(pdata->port_mode);
 		setup_4430ohci_io_mux(pdata->port_mode);
diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index cebfe0a..fe7906b 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -384,7 +384,7 @@ static void omap_usbhs_init(struct device *dev)
 			reg &= ~OMAP_UHH_HOSTCONFIG_P3_CONNECT_STATUS;
 
 		/* Bypass the TLL module for PHY mode operation */
-		if (cpu_is_omap3430() && (omap_rev() <= OMAP3430_REV_ES2_1)) {
+		if (pdata->single_ulpi_bypass) {
 			dev_dbg(dev, "OMAP3 ES version <= ES2.1\n");
 			if (is_ehci_phy_mode(pdata->port_mode[0]) ||
 				is_ehci_phy_mode(pdata->port_mode[1]) ||
diff --git a/include/linux/platform_data/usb-omap.h b/include/linux/platform_data/usb-omap.h
index 8570bcf..ef65b67 100644
--- a/include/linux/platform_data/usb-omap.h
+++ b/include/linux/platform_data/usb-omap.h
@@ -59,6 +59,9 @@ struct usbhs_omap_platform_data {
 
 	struct ehci_hcd_omap_platform_data	*ehci_data;
 	struct ohci_hcd_omap_platform_data	*ohci_data;
+
+	/* OMAP3 <= ES2.1 have a single ulpi bypass control bit */
+	unsigned				single_ulpi_bypass:1;
 };
 
 /*-------------------------------------------------------------------------*/
-- 
1.7.4.1

