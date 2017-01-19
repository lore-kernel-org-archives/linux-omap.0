From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 1/4] dmaengine: cppi41: Remove usbss_mem
Date: Thu, 19 Jan 2017 11:37:02 +0100
Message-ID: <20170119103705.13532-2-abailon@baylibre.com>
References: <20170119103705.13532-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170119103705.13532-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

In order to make CPPI 4.1 DMA driver more generic, accesses to USBSS
have been removed. So it is not required anymore to map the "glue"
register's.
Remove usbss_mem.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/dma/cppi41.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index 4999e7d..1743d3d 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -131,7 +131,6 @@ struct cppi41_dd {
 	u32 first_td_desc;
 	struct cppi41_channel *chan_busy[ALLOC_DECS_NUM];
 
-	void __iomem *usbss_mem;
 	void __iomem *ctrl_mem;
 	void __iomem *sched_mem;
 	void __iomem *qmgr_mem;
@@ -973,6 +972,7 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 	struct cppi41_dd *cdd;
 	struct device *dev = &pdev->dev;
 	const struct cppi_glue_infos *glue_info;
+	int index;
 	int irq;
 	int ret;
 
@@ -999,16 +999,20 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&cdd->ddev.channels);
 	cpp41_dma_info.dma_cap = cdd->ddev.cap_mask;
 
-	cdd->usbss_mem = of_iomap(dev->of_node, 0);
-	cdd->ctrl_mem = of_iomap(dev->of_node, 1);
-	cdd->sched_mem = of_iomap(dev->of_node, 2);
-	cdd->qmgr_mem = of_iomap(dev->of_node, 3);
+	index = of_property_match_string(dev->of_node,
+					 "reg-names", "controller");
+	if (index < 0)
+		return index;
+
+	cdd->ctrl_mem = of_iomap(dev->of_node, index);
+	cdd->sched_mem = of_iomap(dev->of_node, index + 1);
+	cdd->qmgr_mem = of_iomap(dev->of_node, index + 2);
 	spin_lock_init(&cdd->lock);
 	INIT_LIST_HEAD(&cdd->pending);
 
 	platform_set_drvdata(pdev, cdd);
 
-	if (!cdd->usbss_mem || !cdd->ctrl_mem || !cdd->sched_mem ||
+	if (!cdd->ctrl_mem || !cdd->sched_mem ||
 			!cdd->qmgr_mem)
 		return -ENXIO;
 
@@ -1068,7 +1072,6 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 err_get_sync:
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
-	iounmap(cdd->usbss_mem);
 	iounmap(cdd->ctrl_mem);
 	iounmap(cdd->sched_mem);
 	iounmap(cdd->qmgr_mem);
@@ -1090,7 +1093,6 @@ static int cppi41_dma_remove(struct platform_device *pdev)
 	devm_free_irq(&pdev->dev, cdd->irq, cdd);
 	cleanup_chans(cdd);
 	deinit_cppi41(&pdev->dev, cdd);
-	iounmap(cdd->usbss_mem);
 	iounmap(cdd->ctrl_mem);
 	iounmap(cdd->sched_mem);
 	iounmap(cdd->qmgr_mem);
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
