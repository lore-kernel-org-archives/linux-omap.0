From: Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 5/5] usb: omap ehci: remove all regulator control from ehci omap
Date: Sun,  2 Dec 2012 23:01:07 +0800
Message-ID: <1354460467-28006-6-git-send-email-tom.leiming@gmail.com>
References: <1354460467-28006-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:37750 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488Ab2LBPC4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Dec 2012 10:02:56 -0500
In-Reply-To: <1354460467-28006-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lan Tianyu <tianyu.lan@intel.com>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Oliver Neukum <oneukum@suse.de>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Andy Green <andy.green@linaro.org>, Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@ti.com>, Ming Lei <tom.leiming@gmail.com>

From: Andy Green <andy.green@linaro.org>

This series migrates it to the hub driver as suggested by
Felipe Balbi.

Cc: Andy Green <andy.green@linaro.org>
Cc: Roger Quadros <rogerq@ti.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/usb/host/ehci-omap.c |   36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index ac17a7c..d25e39e 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -39,7 +39,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/usb/ulpi.h>
-#include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/gpio.h>
 #include <linux/clk.h>
@@ -150,19 +149,6 @@ static int omap_ehci_init(struct usb_hcd *hcd)
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
 
@@ -176,14 +162,11 @@ static void disable_put_regulator(
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
@@ -224,23 +207,6 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
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
 
@@ -266,7 +232,6 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 	return 0;
 
 err_pm_runtime:
-	disable_put_regulator(pdata);
 	pm_runtime_put_sync(dev);
 	usb_put_hcd(hcd);
 
@@ -291,7 +256,6 @@ static int ehci_hcd_omap_remove(struct platform_device *pdev)
 	struct ehci_hcd_omap_platform_data *pdata	= dev->platform_data;
 
 	usb_remove_hcd(hcd);
-	disable_put_regulator(dev->platform_data);
 	iounmap(hcd->regs);
 	usb_put_hcd(hcd);
 
-- 
1.7.9.5

