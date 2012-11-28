From: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [try#1 PATCH 4/7] usb: omap ehci: remove all regulator control from
 ehci omap
Date: Wed, 28 Nov 2012 12:59:50 +0000
Message-ID: <20121128125950.29569.68156.stgit@build.warmcat.com>
References: <20121128124744.29569.52739.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121128124744.29569.52739.stgit-Ak/hGR4SqtBG2qbu2SEcwgC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This series migrates it to be assets of the logical ehci-omap.0
device object.

Signed-off-by: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/mach-omap2/usb-host.c        |    1 -
 arch/arm/plat-omap/include/plat/usb.h |    7 ------
 drivers/usb/host/ehci-omap.c          |   37 ---------------------------------
 3 files changed, 45 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index 3c43449..98f3287 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -498,7 +498,6 @@ void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
 		ohci_data.port_mode[i] = pdata->port_mode[i];
 		ehci_data.port_mode[i] = pdata->port_mode[i];
 		ehci_data.reset_gpio_port[i] = pdata->reset_gpio_port[i];
-		ehci_data.regulator[i] = pdata->regulator[i];
 	}
 	ehci_data.phy_reset = pdata->phy_reset;
 	ohci_data.es2_compatibility = pdata->es2_compatibility;
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 87ee140..70acdee 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -36,12 +36,6 @@ struct usbhs_omap_board_data {
 	unsigned			es2_compatibility:1;
 
 	unsigned			phy_reset:1;
-
-	/*
-	 * Regulators for USB PHYs.
-	 * Each PHY can have a separate regulator.
-	 */
-	struct regulator		*regulator[OMAP3_HS_USB_PORTS];
 };
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
@@ -49,7 +43,6 @@ struct usbhs_omap_board_data {
 struct ehci_hcd_omap_platform_data {
 	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
 	int				reset_gpio_port[OMAP3_HS_USB_PORTS];
-	struct regulator		*regulator[OMAP3_HS_USB_PORTS];
 	unsigned			phy_reset:1;
 };
 
diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 44e7d0f..7ab7c54 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -40,7 +40,6 @@
 #include <linux/slab.h>
 #include <linux/usb/ulpi.h>
 #include <plat/usb.h>
-#include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/gpio.h>
 #include <linux/clk.h>
@@ -149,19 +148,6 @@ static int omap_ehci_init(struct usb_hcd *hcd)
 	return rc;
 }
 
-static void disable_put_regulator(
-		struct ehci_hcd_omap_platform_data *pdata)
-{
-	int i;
-
-	for (i = 0 ; i < OMAP3_HS_USB_PORTS ; i++) {
-		if (pdata->regulator[i]) {
-			regulator_disable(pdata->regulator[i]);
-			regulator_put(pdata->regulator[i]);
-		}
-	}
-}
-
 /* configure so an HC device and id are always provided */
 /* always called with process context; sleeping is OK */
 
@@ -175,14 +161,11 @@ static void disable_put_regulator(
 static int ehci_hcd_omap_probe(struct platform_device *pdev)
 {
 	struct device				*dev = &pdev->dev;
-	struct ehci_hcd_omap_platform_data	*pdata = dev->platform_data;
 	struct resource				*res;
 	struct usb_hcd				*hcd;
 	void __iomem				*regs;
 	int					ret = -ENODEV;
 	int					irq;
-	int					i;
-	char					supply[7];
 
 	if (usb_disabled())
 		return -ENODEV;
@@ -223,23 +206,6 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 	hcd->rsrc_len = resource_size(res);
 	hcd->regs = regs;
 
-	/* get ehci regulator and enable */
-	for (i = 0 ; i < OMAP3_HS_USB_PORTS ; i++) {
-		if (pdata->port_mode[i] != OMAP_EHCI_PORT_MODE_PHY) {
-			pdata->regulator[i] = NULL;
-			continue;
-		}
-		snprintf(supply, sizeof(supply), "hsusb%d", i);
-		pdata->regulator[i] = regulator_get(dev, supply);
-		if (IS_ERR(pdata->regulator[i])) {
-			pdata->regulator[i] = NULL;
-			dev_dbg(dev,
-			"failed to get ehci port%d regulator\n", i);
-		} else {
-			regulator_enable(pdata->regulator[i]);
-		}
-	}
-
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
@@ -261,11 +227,9 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 		goto err_pm_runtime;
 	}
 
