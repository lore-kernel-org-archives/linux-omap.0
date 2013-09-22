From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v3 2/5] dma: cppi41: s/deinit_cpii41/deinit_cppi41/
Date: Sun, 22 Sep 2013 16:50:01 +0200
Message-ID: <1379861404-8250-3-git-send-email-zonque@gmail.com>
References: <1379861404-8250-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:58542 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093Ab3IVOuL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Sep 2013 10:50:11 -0400
In-Reply-To: <1379861404-8250-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, neumann@teufel.de, bigeasy@linutronix.de, sergei.shtylyov@cogentembedded.com, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com, gregkh@linuxfoundation.org, Daniel Mack <zonque@gmail.com>

Fix a misspelled function name.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/dma/cppi41.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index 53d1d31..5469a15 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -741,7 +741,7 @@ static void disable_sched(struct cppi41_dd *cdd)
 	cppi_writel(0, cdd->sched_mem + DMA_SCHED_CTRL);
 }
 
-static void deinit_cpii41(struct device *dev, struct cppi41_dd *cdd)
+static void deinit_cppi41(struct device *dev, struct cppi41_dd *cdd)
 {
 	disable_sched(cdd);
 
@@ -835,7 +835,7 @@ static int init_cppi41(struct device *dev, struct cppi41_dd *cdd)
 	init_sched(cdd);
 	return 0;
 err_td:
-	deinit_cpii41(dev, cdd);
+	deinit_cppi41(dev, cdd);
 	return ret;
 }
 
@@ -1009,7 +1009,7 @@ err_irq:
 	cppi_writel(0, cdd->usbss_mem + USBSS_IRQ_CLEARR);
 	cleanup_chans(cdd);
 err_chans:
-	deinit_cpii41(&pdev->dev, cdd);
+	deinit_cppi41(&pdev->dev, cdd);
 err_init_cppi:
 	pm_runtime_put(&pdev->dev);
 err_get_sync:
@@ -1033,7 +1033,7 @@ static int cppi41_dma_remove(struct platform_device *pdev)
 	cppi_writel(0, cdd->usbss_mem + USBSS_IRQ_CLEARR);
 	free_irq(cdd->irq, cdd);
 	cleanup_chans(cdd);
-	deinit_cpii41(&pdev->dev, cdd);
+	deinit_cppi41(&pdev->dev, cdd);
 	iounmap(cdd->usbss_mem);
 	iounmap(cdd->ctrl_mem);
 	iounmap(cdd->sched_mem);
-- 
1.8.3.1

