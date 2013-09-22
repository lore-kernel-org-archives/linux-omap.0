From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2 3/5] dma: cppi41: add shortcut to &pdev->dev in cppi41_dma_probe()
Date: Sun, 22 Sep 2013 13:57:46 +0200
Message-ID: <1379851068-18675-4-git-send-email-zonque@gmail.com>
References: <1379851068-18675-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:58113 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752879Ab3IVL6H (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Sep 2013 07:58:07 -0400
In-Reply-To: <1379851068-18675-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, neumann@teufel.de, bigeasy@linutronix.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com, gregkh@linuxfoundation.org, Daniel Mack <zonque@gmail.com>

Makes the code more readable and compact. No functional change.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/dma/cppi41.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index 5469a15..d689706 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -927,11 +927,12 @@ static const struct cppi_glue_infos *get_glue_info(struct device *dev)
 static int cppi41_dma_probe(struct platform_device *pdev)
 {
 	struct cppi41_dd *cdd;
+	struct device *dev = &pdev->dev;
 	const struct cppi_glue_infos *glue_info;
 	int irq;
 	int ret;
 
-	glue_info = get_glue_info(&pdev->dev);
+	glue_info = get_glue_info(dev);
 	if (!glue_info)
 		return -EINVAL;
 
@@ -946,14 +947,14 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 	cdd->ddev.device_issue_pending = cppi41_dma_issue_pending;
 	cdd->ddev.device_prep_slave_sg = cppi41_dma_prep_slave_sg;
 	cdd->ddev.device_control = cppi41_dma_control;
-	cdd->ddev.dev = &pdev->dev;
+	cdd->ddev.dev = dev;
 	INIT_LIST_HEAD(&cdd->ddev.channels);
 	cpp41_dma_info.dma_cap = cdd->ddev.cap_mask;
 
-	cdd->usbss_mem = of_iomap(pdev->dev.of_node, 0);
-	cdd->ctrl_mem = of_iomap(pdev->dev.of_node, 1);
-	cdd->sched_mem = of_iomap(pdev->dev.of_node, 2);
-	cdd->qmgr_mem = of_iomap(pdev->dev.of_node, 3);
+	cdd->usbss_mem = of_iomap(dev->of_node, 0);
+	cdd->ctrl_mem = of_iomap(dev->of_node, 1);
+	cdd->sched_mem = of_iomap(dev->of_node, 2);
+	cdd->qmgr_mem = of_iomap(dev->of_node, 3);
 
 	if (!cdd->usbss_mem || !cdd->ctrl_mem || !cdd->sched_mem ||
 			!cdd->qmgr_mem) {
@@ -961,8 +962,8 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 		goto err_remap;
 	}
 
-	pm_runtime_enable(&pdev->dev);
-	ret = pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
 	if (ret)
 		goto err_get_sync;
 
@@ -970,22 +971,22 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 	cdd->queues_tx = glue_info->queues_tx;
 	cdd->td_queue = glue_info->td_queue;
 
-	ret = init_cppi41(&pdev->dev, cdd);
+	ret = init_cppi41(dev, cdd);
 	if (ret)
 		goto err_init_cppi;
 
-	ret = cppi41_add_chans(&pdev->dev, cdd);
+	ret = cppi41_add_chans(dev, cdd);
 	if (ret)
 		goto err_chans;
 
-	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	irq = irq_of_parse_and_map(dev->of_node, 0);
 	if (!irq)
 		goto err_irq;
 
 	cppi_writel(USBSS_IRQ_PD_COMP, cdd->usbss_mem + USBSS_IRQ_ENABLER);
 
 	ret = request_irq(irq, glue_info->isr, IRQF_SHARED,
-			dev_name(&pdev->dev), cdd);
+			dev_name(dev), cdd);
 	if (ret)
 		goto err_irq;
 	cdd->irq = irq;
@@ -994,7 +995,7 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_dma_reg;
 
-	ret = of_dma_controller_register(pdev->dev.of_node,
+	ret = of_dma_controller_register(dev->of_node,
 			cppi41_dma_xlate, &cpp41_dma_info);
 	if (ret)
 		goto err_of;
@@ -1009,11 +1010,11 @@ err_irq:
 	cppi_writel(0, cdd->usbss_mem + USBSS_IRQ_CLEARR);
 	cleanup_chans(cdd);
 err_chans:
-	deinit_cppi41(&pdev->dev, cdd);
+	deinit_cppi41(dev, cdd);
 err_init_cppi:
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put(dev);
 err_get_sync:
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
 	iounmap(cdd->usbss_mem);
 	iounmap(cdd->ctrl_mem);
 	iounmap(cdd->sched_mem);
-- 
1.8.3.1

