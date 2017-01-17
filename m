From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 6/7] dmaengine: cppi41: init_sched(): Get number of channels from DT
Date: Tue, 17 Jan 2017 14:45:39 +0100
Message-ID: <20170117134540.9988-7-abailon@baylibre.com>
References: <20170117134540.9988-1-abailon@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170117134540.9988-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Despite the driver is already using DT to get the number of channels,
init_sched() is using an hardcoded value to get it.
Use DT to get the number of channels.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/dma/cppi41.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index 3b2f57f..303ccee 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -139,6 +139,8 @@ struct cppi41_dd {
 	struct chan_queues td_queue;
 	u16 first_completion_queue;
 	u16 qmgr_num_pend;
+	u32 n_chans;
+	u8 platform;
 
 	struct list_head pending;	/* Pending queued transfers */
 	spinlock_t lock;		/* Lock for pending list */
@@ -720,13 +722,8 @@ static int cppi41_add_chans(struct device *dev, struct cppi41_dd *cdd)
 {
 	struct cppi41_channel *cchan;
 	int i;
-	int ret;
-	u32 n_chans;
+	u32 n_chans = cdd->n_chans;
 
-	ret = of_property_read_u32(dev->of_node, "#dma-channels",
-			&n_chans);
-	if (ret)
-		return ret;
 	/*
 	 * The channels can only be used as TX or as RX. So we add twice
 	 * that much dma channels because USB can only do RX or TX.
@@ -832,7 +829,7 @@ static int init_descs(struct device *dev, struct cppi41_dd *cdd)
 	return 0;
 }
 
-static void init_sched(struct cppi41_dd *cdd)
+static int init_sched(struct device *dev, struct cppi41_dd *cdd)
 {
 	unsigned ch;
 	unsigned word;
@@ -840,7 +837,7 @@ static void init_sched(struct cppi41_dd *cdd)
 
 	word = 0;
 	cppi_writel(0, cdd->sched_mem + DMA_SCHED_CTRL);
-	for (ch = 0; ch < 15 * 2; ch += 2) {
+	for (ch = 0; ch < cdd->n_chans; ch += 2) {
 
 		reg = SCHED_ENTRY0_CHAN(ch);
 		reg |= SCHED_ENTRY1_CHAN(ch) | SCHED_ENTRY1_IS_RX;
@@ -850,9 +847,11 @@ static void init_sched(struct cppi41_dd *cdd)
 		cppi_writel(reg, cdd->sched_mem + DMA_SCHED_WORD(word));
 		word++;
 	}
-	reg = 15 * 2 * 2 - 1;
+	reg = cdd->n_chans * 2 - 1;
 	reg |= DMA_SCHED_CTRL_EN;
 	cppi_writel(reg, cdd->sched_mem + DMA_SCHED_CTRL);
+
+	return 0;
 }
 
 static int init_cppi41(struct device *dev, struct cppi41_dd *cdd)
@@ -871,12 +870,14 @@ static int init_cppi41(struct device *dev, struct cppi41_dd *cdd)
 
 	ret = init_descs(dev, cdd);
 	if (ret)
-		goto err_td;
+		goto deinit;
 
 	cppi_writel(cdd->td_queue.submit, cdd->ctrl_mem + DMA_TDFDQ);
-	init_sched(cdd);
+	ret = init_sched(dev, cdd);
+	if (ret)
+		goto deinit;
 	return 0;
-err_td:
+deinit:
 	deinit_cppi41(dev, cdd);
 	return ret;
 }
@@ -1030,6 +1031,11 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 	cdd->qmgr_num_pend = glue_info->qmgr_num_pend;
 	cdd->first_completion_queue = glue_info->first_completion_queue;
 
+	ret = of_property_read_u32(dev->of_node,
+				   "#dma-channels", &cdd->n_chans);
+	if (ret)
+		goto err_get_n_chans;
+
 	ret = init_cppi41(dev, cdd);
 	if (ret)
 		goto err_init_cppi;
@@ -1072,6 +1078,7 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 	deinit_cppi41(dev, cdd);
 err_init_cppi:
 	pm_runtime_dont_use_autosuspend(dev);
+err_get_n_chans:
 err_get_sync:
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
@@ -1128,7 +1135,7 @@ static int __maybe_unused cppi41_resume(struct device *dev)
 		if (!c->is_tx)
 			cppi_writel(c->q_num, c->gcr_reg + RXHPCRA0);
 
-	init_sched(cdd);
+	init_sched(dev, cdd);
 
 	cppi_writel(cdd->dma_tdfdq, cdd->ctrl_mem + DMA_TDFDQ);
 	cppi_writel(cdd->scratch_phys, cdd->qmgr_mem + QMGR_LRAM0_BASE);
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
