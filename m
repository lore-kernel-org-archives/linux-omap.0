From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/3] usb: host: ohci-omap3: Remove driver in favor of ohci-platform
Date: Thu, 25 May 2017 09:13:33 -0700
Message-ID: <20170525161333.32639-4-tony@atomide.com>
References: <20170525161333.32639-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170525161333.32639-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This driver is no longer needed and can be removed. The reason why
it's safe to remove this driver is that most omap devices don't have a
USB low-speed or full-speed compatible PHY installed and configured
with drivers/mfd/omap-usb-host.c. This means that devices like
beagleboard and pandaboard need to use a high-speed USB hub in order
to use devices like keyboard and mice.

Currently the only known configured for a full-speed PHY is the
mdm6600 modem on droid 4 and I've verified it works just fine with
ohci-platform.

Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Acked-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Reviewed-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/host/Kconfig      |   6 +-
 drivers/usb/host/Makefile     |   1 -
 drivers/usb/host/ohci-omap3.c | 211 ------------------------------------------
 3 files changed, 5 insertions(+), 213 deletions(-)
 delete mode 100644 drivers/usb/host/ohci-omap3.c

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -473,8 +473,12 @@ config USB_OHCI_HCD_AT91
 config USB_OHCI_HCD_OMAP3
 	tristate "OHCI support for OMAP3 and later chips"
 	depends on (ARCH_OMAP3 || ARCH_OMAP4 || SOC_OMAP5)
+	select USB_OHCI_HCD_PLATFORM
 	default y
-	---help---
+	help
+	  This option is deprecated now and the driver was removed, use
+	  USB_OHCI_HCD_PLATFORM instead.
+
 	  Enables support for the on-chip OHCI controller on
 	  OMAP3 and later chips.
 
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -52,7 +52,6 @@ obj-$(CONFIG_USB_OHCI_HCD_PCI)	+= ohci-pci.o
 obj-$(CONFIG_USB_OHCI_HCD_PLATFORM)	+= ohci-platform.o
 obj-$(CONFIG_USB_OHCI_EXYNOS)	+= ohci-exynos.o
 obj-$(CONFIG_USB_OHCI_HCD_OMAP1)	+= ohci-omap.o
-obj-$(CONFIG_USB_OHCI_HCD_OMAP3)	+= ohci-omap3.o
 obj-$(CONFIG_USB_OHCI_HCD_SPEAR)	+= ohci-spear.o
 obj-$(CONFIG_USB_OHCI_HCD_STI)	+= ohci-st.o
 obj-$(CONFIG_USB_OHCI_HCD_AT91)	+= ohci-at91.o
diff --git a/drivers/usb/host/ohci-omap3.c b/drivers/usb/host/ohci-omap3.c
deleted file mode 100644
--- a/drivers/usb/host/ohci-omap3.c
+++ /dev/null
@@ -1,211 +0,0 @@
-/*
- * ohci-omap3.c - driver for OHCI on OMAP3 and later processors
- *
- * Bus Glue for OMAP3 USBHOST 3 port OHCI controller
- * This controller is also used in later OMAPs and AM35x chips
- *
- * Copyright (C) 2007-2010 Texas Instruments, Inc.
- * Author: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
- * Author: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
- * Author: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
- *
- * Based on ehci-omap.c and some other ohci glue layers
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- *
- * TODO (last updated Feb 27, 2011):
- *	- add kernel-doc
- */
-
-#include <linux/dma-mapping.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/usb/otg.h>
-#include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
-#include <linux/usb.h>
-#include <linux/usb/hcd.h>
-
-#include "ohci.h"
-
-#define DRIVER_DESC "OHCI OMAP3 driver"
-
-static const char hcd_name[] = "ohci-omap3";
-static struct hc_driver __read_mostly ohci_omap3_hc_driver;
-
-/*
- * configure so an HC device and id are always provided
- * always called with process context; sleeping is OK
- */
-
-/**
- * ohci_hcd_omap3_probe - initialize OMAP-based HCDs
- *
- * Allocates basic resources for this USB host controller, and
- * then invokes the start() method for the HCD associated with it
- * through the hotplug entry's driver_data.
- */
-static int ohci_hcd_omap3_probe(struct platform_device *pdev)
-{
-	struct device		*dev = &pdev->dev;
-	struct ohci_hcd		*ohci;
-	struct usb_hcd		*hcd = NULL;
-	void __iomem		*regs = NULL;
-	struct resource		*res;
-	int			ret;
-	int			irq;
-
-	if (usb_disabled())
-		return -ENODEV;
-
-	if (!dev->parent) {
-		dev_err(dev, "Missing parent device\n");
-		return -ENODEV;
-	}
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "OHCI irq failed\n");
-		return -ENODEV;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "UHH OHCI get resource failed\n");
-		return -ENOMEM;
-	}
-
-	regs = ioremap(res->start, resource_size(res));
-	if (!regs) {
-		dev_err(dev, "UHH OHCI ioremap failed\n");
-		return -ENOMEM;
-	}
-
-	/*
-	 * Right now device-tree probed devices don't get dma_mask set.
-	 * Since shared usb code relies on it, set it here for now.
-	 * Once we have dma capability bindings this can go away.
-	 */
-	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
-	if (ret)
-		goto err_io;
-
-	ret = -ENODEV;
-	hcd = usb_create_hcd(&ohci_omap3_hc_driver, dev,
-			dev_name(dev));
-	if (!hcd) {
-		dev_err(dev, "usb_create_hcd failed\n");
-		goto err_io;
-	}
-
-	hcd->rsrc_start = res->start;
-	hcd->rsrc_len = resource_size(res);
-	hcd->regs =  regs;
-
-	pm_runtime_enable(dev);
-	pm_runtime_get_sync(dev);
-
-	ohci = hcd_to_ohci(hcd);
-	/*
-	 * RemoteWakeupConnected has to be set explicitly before
-	 * calling ohci_run. The reset value of RWC is 0.
-	 */
-	ohci->hc_control = OHCI_CTRL_RWC;
-
-	ret = usb_add_hcd(hcd, irq, 0);
-	if (ret) {
-		dev_dbg(dev, "failed to add hcd with err %d\n", ret);
-		goto err_add_hcd;
-	}
-	device_wakeup_enable(hcd->self.controller);
-
-	return 0;
-
-err_add_hcd:
-	pm_runtime_put_sync(dev);
-	usb_put_hcd(hcd);
-
-err_io:
-	iounmap(regs);
-
-	return ret;
-}
-
-/*
- * may be called without controller electrically present
- * may be called with controller, bus, and devices active
- */
-
-/**
- * ohci_hcd_omap3_remove - shutdown processing for OHCI HCDs
- * @pdev: USB Host Controller being removed
- *
- * Reverses the effect of ohci_hcd_omap3_probe(), first invoking
- * the HCD's stop() method.  It is always called from a thread
- * context, normally "rmmod", "apmd", or something similar.
- */
-static int ohci_hcd_omap3_remove(struct platform_device *pdev)
-{
-	struct device *dev	= &pdev->dev;
-	struct usb_hcd *hcd	= dev_get_drvdata(dev);
-
-	iounmap(hcd->regs);
-	usb_remove_hcd(hcd);
-	pm_runtime_put_sync(dev);
-	pm_runtime_disable(dev);
-	usb_put_hcd(hcd);
-	return 0;
-}
-
-static const struct of_device_id omap_ohci_dt_ids[] = {
-	{ .compatible = "ti,ohci-omap3" },
-	{ }
-};
-
-MODULE_DEVICE_TABLE(of, omap_ohci_dt_ids);
-
-static struct platform_driver ohci_hcd_omap3_driver = {
-	.probe		= ohci_hcd_omap3_probe,
-	.remove		= ohci_hcd_omap3_remove,
-	.shutdown	= usb_hcd_platform_shutdown,
-	.driver		= {
-		.name	= "ohci-omap3",
-		.of_match_table = omap_ohci_dt_ids,
-	},
-};
-
-static int __init ohci_omap3_init(void)
-{
-	if (usb_disabled())
-		return -ENODEV;
-
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-
-	ohci_init_driver(&ohci_omap3_hc_driver, NULL);
-	return platform_driver_register(&ohci_hcd_omap3_driver);
-}
-module_init(ohci_omap3_init);
-
-static void __exit ohci_omap3_cleanup(void)
-{
-	platform_driver_unregister(&ohci_hcd_omap3_driver);
-}
-module_exit(ohci_omap3_cleanup);
