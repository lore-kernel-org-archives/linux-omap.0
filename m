From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 2/5] dma: cppi41: s/deinit_cpii41/deinit_cppi41/
Date: Sun, 22 Sep 2013 13:57:45 +0200
Message-ID: <1379851068-18675-3-git-send-email-zonque@gmail.com>
References: <1379851068-18675-1-git-send-email-zonque@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379851068-18675-1-git-send-email-zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Fix a misspelled function name.

Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
