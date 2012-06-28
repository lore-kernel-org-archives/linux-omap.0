From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH v3] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset fix issues.
Date: Wed, 27 Jun 2012 18:59:43 -0700
Message-ID: <1340848783-9480-1-git-send-email-Russ.Dill@ti.com>
References: <1339690919-12566-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58238 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754206Ab2F1B7y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 21:59:54 -0400
In-Reply-To: <1339690919-12566-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>, Partha Basak <parthab@india.ti.com>, Igor Grinberg <grinberg@compulab.co.il>, Samuel Ortiz <sameo@linux.intel.com>, mantesh@ti.com, s-sapna1@ti.com, Russ Dill <Russ.Dill@gmail.com>

From: Russ Dill <Russ.Dill@gmail.com>

'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue' (1fcb57d0) fixes
an issue where the ULPI PHYs were not held in reset while initializing
the EHCI controller. However, it also changes behavior in
omap-usb-host.c omap_usbhs_init by releasing reset while the
configuration in that function was done.

This change caused a regression on BB-xM where USB would not function
if 'usb start' had been run from u-boot before booting. A change was
made to release reset a little bit earlier which fixed the issue on
BB-xM and did not cause any regressions on 3430 sdp, the board for
which the fix was originally made.

This new fix, 'USB: EHCI: OMAP: Finish ehci omap phy reset cycle
before adding hcd.', (3aa2ae74) caused a regression on OMAP5.

The original fix to hold the EHCI controller in reset during
initialization was correct, however it appears that changing
omap_usbhs_init to not hold the PHYs in reset during it's
configuration was incorrect. This patch first reverts both fixes, and
then changes ehci_hcd_omap_probe in ehci-omap.c to hold the PHYs in
reset as the original patch had done. It also is sure to incorporate
the _cansleep change that has been made in the meantime.

Tested on Beagleboard xM.

v3 - Don't double free gpio
v2 - Put cansleep gpiolib call outside of spinlock

Signed-off-by: Russ Dill <Russ.Dill@gmail.com>
---
 drivers/mfd/omap-usb-host.c  |   48 +++++++++++++++++++++++++++++++++++++++++-
 drivers/usb/host/ehci-omap.c |   26 +++++++----------------
 2 files changed, 55 insertions(+), 19 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 7e96bb2..41088ec 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -25,6 +25,7 @@
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/spinlock.h>
+#include <linux/gpio.h>
 #include <plat/cpu.h>
 #include <plat/usb.h>
 #include <linux/pm_runtime.h>
@@ -500,8 +501,21 @@ static void omap_usbhs_init(struct device *dev)
 	dev_dbg(dev, "starting TI HSUSB Controller\n");
 
 	pm_runtime_get_sync(dev);
-	spin_lock_irqsave(&omap->lock, flags);
 
+	if (pdata->ehci_data->phy_reset) {
+		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[0]))
+			gpio_request_one(pdata->ehci_data->reset_gpio_port[0],
+					 GPIOF_OUT_INIT_LOW, "USB1 PHY reset");
+
+		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[1]))
+			gpio_request_one(pdata->ehci_data->reset_gpio_port[1],
+					 GPIOF_OUT_INIT_LOW, "USB2 PHY reset");
+
+		/* Hold the PHY in RESET for enough time till DIR is high */
+		udelay(10);
+	}
+
+	spin_lock_irqsave(&omap->lock, flags);
 	omap->usbhs_rev = usbhs_read(omap->uhh_base, OMAP_UHH_REVISION);
 	dev_dbg(dev, "OMAP UHH_REVISION 0x%x\n", omap->usbhs_rev);
 
@@ -581,9 +595,39 @@ static void omap_usbhs_init(struct device *dev)
 	}
 
 	spin_unlock_irqrestore(&omap->lock, flags);
+
+	if (pdata->ehci_data->phy_reset) {
+		/* Hold the PHY in RESET for enough time till
+		 * PHY is settled and ready
+		 */
+		udelay(10);
+
+		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[0]))
+			gpio_set_value_cansleep
+				(pdata->ehci_data->reset_gpio_port[0], 1);
+
+		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[1]))
+			gpio_set_value_cansleep
+				(pdata->ehci_data->reset_gpio_port[1], 1);
+	}
+
 	pm_runtime_put_sync(dev);
 }
 
+static void omap_usbhs_deinit(struct device *dev)
+{
+	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
+	struct usbhs_omap_platform_data	*pdata = &omap->platdata;
+
+	if (pdata->ehci_data->phy_reset) {
+		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[0]))
+			gpio_free(pdata->ehci_data->reset_gpio_port[0]);
+
+		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[1]))
+			gpio_free(pdata->ehci_data->reset_gpio_port[1]);
+	}
+}
+
 
 /**
  * usbhs_omap_probe - initialize TI-based HCDs
@@ -767,6 +811,7 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 	goto end_probe;
 
 err_alloc:
+	omap_usbhs_deinit(&pdev->dev);
 	iounmap(omap->tll_base);
 
 err_tll:
@@ -818,6 +863,7 @@ static int __devexit usbhs_omap_remove(struct platform_device *pdev)
 {
 	struct usbhs_hcd_omap *omap = platform_get_drvdata(pdev);
 
+	omap_usbhs_deinit(&pdev->dev);
 	iounmap(omap->tll_base);
 	iounmap(omap->uhh_base);
 	clk_put(omap->init_60m_fclk);
diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index a44294d..35f4788 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -192,14 +192,13 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* Hold PHYs in reset while initializing EHCI controller */
 	if (pdata->phy_reset) {
 		if (gpio_is_valid(pdata->reset_gpio_port[0]))
-			gpio_request_one(pdata->reset_gpio_port[0],
-					 GPIOF_OUT_INIT_LOW, "USB1 PHY reset");
+			gpio_set_value_cansleep(pdata->reset_gpio_port[0], 0);
 
 		if (gpio_is_valid(pdata->reset_gpio_port[1]))
-			gpio_request_one(pdata->reset_gpio_port[1],
-					 GPIOF_OUT_INIT_LOW, "USB2 PHY reset");
+			gpio_set_value_cansleep(pdata->reset_gpio_port[1], 0);
 
 		/* Hold the PHY in RESET for enough time till DIR is high */
 		udelay(10);
@@ -241,6 +240,11 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 	omap_ehci->hcs_params = readl(&omap_ehci->caps->hcs_params);
 
 	ehci_reset(omap_ehci);
+	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
+	if (ret) {
+		dev_err(dev, "failed to add hcd with err %d\n", ret);
+		goto err_add_hcd;
+	}
 
 	if (pdata->phy_reset) {
 		/* Hold the PHY in RESET for enough time till
@@ -255,12 +259,6 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 			gpio_set_value_cansleep(pdata->reset_gpio_port[1], 1);
 	}
 
-	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
-	if (ret) {
-		dev_err(dev, "failed to add hcd with err %d\n", ret);
-		goto err_add_hcd;
-	}
-
 	/* root ports should always stay powered */
 	ehci_port_power(omap_ehci, 1);
 
@@ -288,7 +286,6 @@ static int ehci_hcd_omap_remove(struct platform_device *pdev)
 {
 	struct device *dev				= &pdev->dev;
 	struct usb_hcd *hcd				= dev_get_drvdata(dev);
-	struct ehci_hcd_omap_platform_data *pdata	= dev->platform_data;
 
 	usb_remove_hcd(hcd);
 	disable_put_regulator(dev->platform_data);
@@ -297,13 +294,6 @@ static int ehci_hcd_omap_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 
-	if (pdata->phy_reset) {
-		if (gpio_is_valid(pdata->reset_gpio_port[0]))
-			gpio_free(pdata->reset_gpio_port[0]);
-
-		if (gpio_is_valid(pdata->reset_gpio_port[1]))
-			gpio_free(pdata->reset_gpio_port[1]);
-	}
 	return 0;
 }
 
-- 
1.7.10.4

