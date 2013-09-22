From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2 5/5] dma: cppi41: add support for suspend and resume
Date: Sun, 22 Sep 2013 13:57:48 +0200
Message-ID: <1379851068-18675-6-git-send-email-zonque@gmail.com>
References: <1379851068-18675-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:58130 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753058Ab3IVL6K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Sep 2013 07:58:10 -0400
In-Reply-To: <1379851068-18675-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, neumann@teufel.de, bigeasy@linutronix.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com, gregkh@linuxfoundation.org, Daniel Mack <zonque@gmail.com>

This patch adds support for suspend/resume functionality to the cppi41
DMA driver. The steps neccessary to make the system resume properly were
figured out by hefty trial-and-error. The code as it stands now is the
minimum that has to be done to put the musb host system on an AM33xx
system into an operable state after resume.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/dma/cppi41.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index 3347321..59dfa8e 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -1040,12 +1040,45 @@ static int cppi41_dma_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int cppi41_suspend(struct device *dev)
+{
+	struct cppi41_dd *cdd = dev_get_drvdata(dev);
+
+	cppi_writel(0, cdd->usbss_mem + USBSS_IRQ_CLEARR);
+	disable_sched(cdd);
+
+	return 0;
+}
+
+static int cppi41_resume(struct device *dev)
+{
+	struct cppi41_dd *cdd = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < DESCS_AREAS; i++)
+		cppi_writel(cdd->descs_phys, cdd->qmgr_mem + QMGR_MEMBASE(i));
+
+	init_sched(cdd);
+	cppi_writel(USBSS_IRQ_PD_COMP, cdd->usbss_mem + USBSS_IRQ_ENABLER);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(cppi41_pm_ops, cppi41_suspend, cppi41_resume);
+
+#define DEV_PM_OPS (&cppi41_pm_ops)
+#else
+#define DEV_PM_OPS NULL
+#endif
+
 static struct platform_driver cpp41_dma_driver = {
 	.probe  = cppi41_dma_probe,
 	.remove = cppi41_dma_remove,
 	.driver = {
 		.name = "cppi41-dma-engine",
 		.owner = THIS_MODULE,
+		.pm = DEV_PM_OPS,
 		.of_match_table = of_match_ptr(cppi41_dma_ids),
 	},
 };
-- 
1.8.3.1

