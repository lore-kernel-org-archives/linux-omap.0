From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 4/4] dmaengine: cppi41: init_sched(): Get number of channels from DT
Date: Thu, 19 Jan 2017 11:37:05 +0100
Message-ID: <20170119103705.13532-5-abailon@baylibre.com>
References: <20170119103705.13532-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170119103705.13532-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Despite the driver is already using DT to get the number of channels,
init_sched() is using an hardcoded value to get it.
Use DT to get the number of channels.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/dma/cppi41.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index 5a40653..9767b97 100644
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
+static void init_sched(struct device *dev, struct cppi41_dd *cdd)
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
@@ -850,7 +847,7 @@ static void init_sched(struct cppi41_dd *cdd)
 		cppi_writel(reg, cdd->sched_mem + DMA_SCHED_WORD(word));
 		word++;
 	}
-	reg = 15 * 2 * 2 - 1;
+	reg = cdd->n_chans * 2 - 1;
 	reg |= DMA_SCHED_CTRL_EN;
 	cppi_writel(reg, cdd->sched_mem + DMA_SCHED_CTRL);
 }
@@ -874,7 +871,8 @@ static int init_cppi41(struct device *dev, struct cppi41_dd *cdd)
 		goto err_td;
 
 	cppi_writel(cdd->td_queue.submit, cdd->ctrl_mem + DMA_TDFDQ);
-	init_sched(cdd);
+	init_sched(dev, cdd);
+
 	return 0;
 err_td:
 	deinit_cppi41(dev, cdd);
@@ -1036,6 +1034,11 @@ static int cppi41_dma_probe(struct platform_device *pdev)
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
@@ -1078,6 +1081,7 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 	deinit_cppi41(dev, cdd);
 err_init_cppi:
 	pm_runtime_dont_use_autosuspend(dev);
+err_get_n_chans:
 err_get_sync:
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
@@ -1134,7 +1138,7 @@ static int __maybe_unused cppi41_resume(struct device *dev)
 		if (!c->is_tx)
 			cppi_writel(c->q_num, c->gcr_reg + RXHPCRA0);
 
-	init_sched(cdd);
+	init_sched(dev, cdd);
 
 	cppi_writel(cdd->dma_tdfdq, cdd->ctrl_mem + DMA_TDFDQ);
 	cppi_writel(cdd->scratch_phys, cdd->qmgr_mem + QMGR_LRAM0_BASE);
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
