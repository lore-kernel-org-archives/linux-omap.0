From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 06/11] dmaengine: cppi41: Only configure am335x's registers on amm335x platform
Date: Mon,  9 Jan 2017 17:06:51 +0100
Message-ID: <20170109160656.3470-7-abailon@baylibre.com>
References: <20170109160656.3470-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170109160656.3470-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Currently, the driver configure some am335x's usb registers.
Test if the driver is running on am335x before to configure
these registers.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/dma/cppi41.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index 58b27ef..939398e 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -1077,7 +1077,9 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
-	cppi_writel(USBSS_IRQ_PD_COMP, cdd->usbss_mem + USBSS_IRQ_ENABLER);
+	if (is_am335x_cppi41(dev))
+		cppi_writel(USBSS_IRQ_PD_COMP,
+			    cdd->usbss_mem + USBSS_IRQ_ENABLER);
 
 	ret = devm_request_irq(&pdev->dev, irq, glue_info->isr, IRQF_SHARED,
 			dev_name(dev), cdd);
@@ -1102,7 +1104,8 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 	dma_async_device_unregister(&cdd->ddev);
 err_dma_reg:
 err_irq:
-	cppi_writel(0, cdd->usbss_mem + USBSS_IRQ_CLEARR);
+	if (is_am335x_cppi41(dev))
+		cppi_writel(0, cdd->usbss_mem + USBSS_IRQ_CLEARR);
 	cleanup_chans(cdd);
 err_chans:
 	deinit_cppi41(dev, cdd);
@@ -1131,7 +1134,8 @@ static int cppi41_dma_remove(struct platform_device *pdev)
 	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&cdd->ddev);
 
-	cppi_writel(0, cdd->usbss_mem + USBSS_IRQ_CLEARR);
+	if (is_am335x_cppi41(&pdev->dev))
+		cppi_writel(0, cdd->usbss_mem + USBSS_IRQ_CLEARR);
 	devm_free_irq(&pdev->dev, cdd->irq, cdd);
 	cleanup_chans(cdd);
 	deinit_cppi41(&pdev->dev, cdd);
@@ -1150,7 +1154,8 @@ static int __maybe_unused cppi41_suspend(struct device *dev)
 	struct cppi41_dd *cdd = dev_get_drvdata(dev);
 
 	cdd->dma_tdfdq = cppi_readl(cdd->ctrl_mem + DMA_TDFDQ);
-	cppi_writel(0, cdd->usbss_mem + USBSS_IRQ_CLEARR);
+	if (is_am335x_cppi41(dev))
+		cppi_writel(0, cdd->usbss_mem + USBSS_IRQ_CLEARR);
 	disable_sched(cdd);
 
 	return 0;
@@ -1176,7 +1181,9 @@ static int __maybe_unused cppi41_resume(struct device *dev)
 	cppi_writel(QMGR_SCRATCH_SIZE, cdd->qmgr_mem + QMGR_LRAM_SIZE);
 	cppi_writel(0, cdd->qmgr_mem + QMGR_LRAM1_BASE);
 
-	cppi_writel(USBSS_IRQ_PD_COMP, cdd->usbss_mem + USBSS_IRQ_ENABLER);
+	if (is_am335x_cppi41(dev))
+		cppi_writel(USBSS_IRQ_PD_COMP,
+			    cdd->usbss_mem + USBSS_IRQ_ENABLER);
 
 	return 0;
 }
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
