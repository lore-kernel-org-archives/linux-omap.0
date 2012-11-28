From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 18/22] mfd: omap-usb-host: get rid of cpu_is_omap..() macros
Date: Wed, 28 Nov 2012 16:49:06 +0200
Message-ID: <1354114150-11941-19-git-send-email-rogerq@ti.com>
References: <1354114150-11941-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354114150-11941-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: keshava_mgowda-l0cyMroinI0@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Instead of using cpu_is_omap..() macros in the device driver we
rely on information provided in the platform data.

The only information we need is whether the USB Host module has
a single ULPI bypass control bit for all ports or individual bypass
control bits for each port. OMAP3 REV2.1 and earlier have the former.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
CC: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/mach-omap2/usb-host.c        |    4 ++++
 arch/arm/plat-omap/include/plat/usb.h |    3 +++
 drivers/mfd/omap-usb-host.c           |    3 +--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index eb85528..455b135 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -509,6 +509,10 @@ void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
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
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 6b618a1..3f2336a 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -65,6 +65,9 @@ struct usbhs_omap_platform_data {
 
 	struct ehci_hcd_omap_platform_data	*ehci_data;
 	struct ohci_hcd_omap_platform_data	*ohci_data;
+
+	/* OMAP3 <= ES2.1 have a single ulpi bypass control bit */
+	unsigned				single_ulpi_bypass:1;
 };
 
 struct usbtll_omap_platform_data {
diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 62e1f21..aaf272d 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -24,7 +24,6 @@
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/gpio.h>
-#include <plat/cpu.h>
 #include <plat/usb.h>
 #include <linux/pm_runtime.h>
 
@@ -400,7 +399,7 @@ static void omap_usbhs_init(struct device *dev)
 			reg &= ~OMAP_UHH_HOSTCONFIG_P3_CONNECT_STATUS;
 
 		/* Bypass the TLL module for PHY mode operation */
-		if (cpu_is_omap3430() && (omap_rev() <= OMAP3430_REV_ES2_1)) {
+		if (pdata->single_ulpi_bypass) {
 			dev_dbg(dev, "OMAP3 ES version <= ES2.1\n");
 			if (is_ehci_phy_mode(pdata->port_mode[0]) ||
 				is_ehci_phy_mode(pdata->port_mode[1]) ||
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
