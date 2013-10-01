From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/3] dma: cppi41: restore more registers
Date: Tue,  1 Oct 2013 15:31:09 +0200
Message-ID: <1380634271-27588-2-git-send-email-zonque@gmail.com>
References: <1380634271-27588-1-git-send-email-zonque@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380634271-27588-1-git-send-email-zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

With active users over suspend/resume cycles, it turns out that
more registers, in particular DMA_TDFDQ and RXHPCRA0, have to be
restored on resume.

Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/dma/cppi41.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index 89decc9..9a298b1 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -141,6 +141,9 @@ struct cppi41_dd {
 	const struct chan_queues *queues_rx;
 	const struct chan_queues *queues_tx;
 	struct chan_queues td_queue;
+
+	/* context for suspend/resume */
+	unsigned int dma_tdfdq;
 };
 
 #define FIST_COMPLETION_QUEUE	93
@@ -1045,6 +1048,7 @@ static int cppi41_suspend(struct device *dev)
 {
 	struct cppi41_dd *cdd = dev_get_drvdata(dev);
 
+	cdd->dma_tdfdq = cppi_readl(cdd->ctrl_mem + DMA_TDFDQ);
 	cppi_writel(0, cdd->usbss_mem + USBSS_IRQ_CLEARR);
 	disable_sched(cdd);
 
@@ -1054,12 +1058,23 @@ static int cppi41_suspend(struct device *dev)
 static int cppi41_resume(struct device *dev)
 {
 	struct cppi41_dd *cdd = dev_get_drvdata(dev);
+	struct cppi41_channel *c;
 	int i;
 
 	for (i = 0; i < DESCS_AREAS; i++)
 		cppi_writel(cdd->descs_phys, cdd->qmgr_mem + QMGR_MEMBASE(i));
 
+	list_for_each_entry(c, &cdd->ddev.channels, chan.device_node)
+		if (!c->is_tx)
+			cppi_writel(c->q_num, c->gcr_reg + RXHPCRA0);
+
 	init_sched(cdd);
+
+	cppi_writel(cdd->dma_tdfdq, cdd->ctrl_mem + DMA_TDFDQ);
+	cppi_writel(cdd->scratch_phys, cdd->qmgr_mem + QMGR_LRAM0_BASE);
+	cppi_writel(QMGR_SCRATCH_SIZE, cdd->qmgr_mem + QMGR_LRAM_SIZE);
+	cppi_writel(0, cdd->qmgr_mem + QMGR_LRAM1_BASE);
+
 	cppi_writel(USBSS_IRQ_PD_COMP, cdd->usbss_mem + USBSS_IRQ_ENABLER);
 
 	return 0;
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
