From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 18/23] mfd: omap-usb-host: Get rid of unnecessary spinlock
Date: Tue, 4 Dec 2012 16:31:49 +0200
Message-ID: <1354631514-24815-3-git-send-email-rogerq@ti.com>
References: <1354631514-24815-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354631514-24815-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: keshava_mgowda-l0cyMroinI0@public.gmane.org, sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org, bjorn-yOkvZcmFvRU@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The driver does not have an interrupt handler and
we don't really need a spinlock, so get rid of it.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/omap-usb-host.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 90dbd17..289b356 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -23,7 +23,6 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
-#include <linux/spinlock.h>
 #include <linux/gpio.h>
 #include <plat/cpu.h>
 #include <linux/platform_device.h>
@@ -107,7 +106,6 @@ struct usbhs_hcd_omap {
 	struct usbhs_omap_platform_data	*pdata;
 
 	u32				usbhs_rev;
-	spinlock_t			lock;
 };
 /*-------------------------------------------------------------------------*/
 
@@ -280,14 +278,12 @@ static bool is_ohci_port(enum usbhs_omap_port_mode pmode)
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
@@ -329,22 +325,17 @@ static int usbhs_runtime_resume(struct device *dev)
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
@@ -367,7 +358,6 @@ static int usbhs_runtime_suspend(struct device *dev)
 	if (omap->ehci_logic_fck && !IS_ERR(omap->ehci_logic_fck))
 		clk_disable(omap->ehci_logic_fck);
 
-	spin_unlock_irqrestore(&omap->lock, flags);
 	omap_tll_disable();
 
 	return 0;
@@ -377,7 +367,6 @@ static void omap_usbhs_init(struct device *dev)
 {
 	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
 	struct usbhs_omap_platform_data	*pdata = omap->pdata;
-	unsigned long			flags;
 	unsigned			reg;
 
 	dev_dbg(dev, "starting TI HSUSB Controller\n");
@@ -396,7 +385,6 @@ static void omap_usbhs_init(struct device *dev)
 	}
 
 	pm_runtime_get_sync(dev);
-	spin_lock_irqsave(&omap->lock, flags);
 
 	reg = usbhs_read(omap->uhh_base, OMAP_UHH_HOSTCONFIG);
 	/* setup ULPI bypass and burst configurations */
@@ -459,8 +447,6 @@ static void omap_usbhs_init(struct device *dev)
 	usbhs_write(omap->uhh_base, OMAP_UHH_HOSTCONFIG, reg);
 	dev_dbg(dev, "UHH setup done, uhh_hostconfig=%x\n", reg);
 
-	spin_unlock_irqrestore(&omap->lock, flags);
-
 	pm_runtime_put_sync(dev);
 	if (pdata->ehci_data->phy_reset) {
 		/* Hold the PHY in RESET for enough time till
@@ -524,8 +510,6 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 	if (!omap->uhh_base)
 		return -EADDRNOTAVAIL;
 
-	spin_lock_init(&omap->lock);
