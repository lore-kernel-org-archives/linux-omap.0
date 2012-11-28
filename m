From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 17/22] mfd: omap-usb-host: Get rid of unnecessary spinlock
Date: Wed, 28 Nov 2012 16:49:05 +0200
Message-ID: <1354114150-11941-18-git-send-email-rogerq@ti.com>
References: <1354114150-11941-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50624 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932295Ab2K1Oth (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Nov 2012 09:49:37 -0500
In-Reply-To: <1354114150-11941-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: keshava_mgowda@ti.com, rogerq@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

The driver does not have an interrupt handler and
we don't really need a spinlock, so get rid of it.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-host.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 3b402b7..62e1f21 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -23,7 +23,6 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
-#include <linux/spinlock.h>
 #include <linux/gpio.h>
 #include <plat/cpu.h>
 #include <plat/usb.h>
@@ -104,7 +103,6 @@ struct usbhs_hcd_omap {
 	struct usbhs_omap_platform_data	*pdata;
 
 	u32				usbhs_rev;
-	spinlock_t			lock;
 };
 /*-------------------------------------------------------------------------*/
 
@@ -277,14 +275,12 @@ static bool is_ohci_port(enum usbhs_omap_port_mode pmode)
 static int usbhs_runtime_resume(struct device *dev)
 {
 	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
-	unsigned long			flags;
 	struct usbhs_omap_platform_data *pdata = omap->pdata;
 	int i, r;
 
 	dev_dbg(dev, "usbhs_runtime_resume\n");
 
 	omap_tll_enable();
-	spin_lock_irqsave(&omap->lock, flags);
 
 	if (omap->ehci_logic_fck && !IS_ERR(omap->ehci_logic_fck))
 		clk_enable(omap->ehci_logic_fck);
@@ -326,22 +322,17 @@ static int usbhs_runtime_resume(struct device *dev)
 		}
 	}
 
-	spin_unlock_irqrestore(&omap->lock, flags);
-
 	return 0;
 }
 
 static int usbhs_runtime_suspend(struct device *dev)
 {
 	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
-	unsigned long			flags;
 	struct usbhs_omap_platform_data *pdata = omap->pdata;
 	int i;
 
 	dev_dbg(dev, "usbhs_runtime_suspend\n");
 
-	spin_lock_irqsave(&omap->lock, flags);
-
 	for (i = 0; i < omap->nports; i++) {
 		switch (pdata->port_mode[i]) {
 		case OMAP_EHCI_PORT_MODE_HSIC:
@@ -364,7 +355,6 @@ static int usbhs_runtime_suspend(struct device *dev)
 	if (omap->ehci_logic_fck && !IS_ERR(omap->ehci_logic_fck))
 		clk_disable(omap->ehci_logic_fck);
 
-	spin_unlock_irqrestore(&omap->lock, flags);
 	omap_tll_disable();
 
 	return 0;
@@ -374,7 +364,6 @@ static void omap_usbhs_init(struct device *dev)
 {
 	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
 	struct usbhs_omap_platform_data	*pdata = omap->pdata;
-	unsigned long			flags;
 	unsigned			reg;
 
 	dev_dbg(dev, "starting TI HSUSB Controller\n");
@@ -393,7 +382,6 @@ static void omap_usbhs_init(struct device *dev)
 	}
 
 	pm_runtime_get_sync(dev);
-	spin_lock_irqsave(&omap->lock, flags);
 
 	reg = usbhs_read(omap->uhh_base, OMAP_UHH_HOSTCONFIG);
 	/* setup ULPI bypass and burst configurations */
@@ -456,8 +444,6 @@ static void omap_usbhs_init(struct device *dev)
 	usbhs_write(omap->uhh_base, OMAP_UHH_HOSTCONFIG, reg);
 	dev_dbg(dev, "UHH setup done, uhh_hostconfig=%x\n", reg);
 
-	spin_unlock_irqrestore(&omap->lock, flags);
-
 	pm_runtime_put_sync(dev);
 	if (pdata->ehci_data->phy_reset) {
 		/* Hold the PHY in RESET for enough time till
@@ -521,8 +507,6 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 	if (!omap->uhh_base)
 		return -EADDRNOTAVAIL;
 
-	spin_lock_init(&omap->lock);
-
 	omap->pdata = pdata;
 
 	pm_runtime_enable(dev);
-- 
1.7.4.1

