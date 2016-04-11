From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] usb: dwc3: omap: get rid of dma_status
Date: Mon, 11 Apr 2016 17:18:25 +0300
Message-ID: <1460384305-21256-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

dma_status bit flag is set but never really used
so get rid of it.

Reported-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/dwc3-omap.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 55da2c7..890b8a6 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -126,8 +126,6 @@ struct dwc3_omap {
 	u32			debug_offset;
 	u32			irq0_offset;
 
-	u32			dma_status:1;
-
 	struct extcon_dev	*edev;
 	struct notifier_block	vbus_nb;
 	struct notifier_block	id_nb;
@@ -277,9 +275,6 @@ static irqreturn_t dwc3_omap_interrupt(int irq, void *_omap)
 
 	reg = dwc3_omap_read_irqmisc_status(omap);
 
-	if (reg & USBOTGSS_IRQMISC_DMADISABLECLR)
-		omap->dma_status = false;
-
 	dwc3_omap_write_irqmisc_status(omap, reg);
 
 	reg = dwc3_omap_read_irq0_status(omap);
@@ -504,7 +499,6 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 
 	/* check the DMA Status */
 	reg = dwc3_omap_readl(omap->base, USBOTGSS_SYSCONFIG);
-	omap->dma_status = !!(reg & USBOTGSS_SYSCONFIG_DMADISABLE);
 
 	ret = devm_request_irq(dev, omap->irq, dwc3_omap_interrupt, 0,
 			"dwc3-omap", omap);
-- 
2.5.0
