From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 03/11] dmaengine: cppi41: Move some constants to glue layer
Date: Mon,  9 Jan 2017 17:06:48 +0100
Message-ID: <20170109160656.3470-4-abailon@baylibre.com>
References: <20170109160656.3470-1-abailon@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170109160656.3470-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Some constants are defined and use by the driver whereas they are
specifics to am335x.
Add new variables to the glue layer, initialize them with the constants,
and use them in the driver.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/dma/cppi41.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index 42744ed..d0d3bdd 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -68,7 +68,6 @@
 #define QMGR_MEMCTRL_IDX_SH	16
 #define QMGR_MEMCTRL_DESC_SH	8
 
-#define QMGR_NUM_PEND	5
 #define QMGR_PEND(x)	(0x90 + (x) * 4)
 
 #define QMGR_PENDING_SLOT_Q(x)	(x / 32)
@@ -147,6 +146,8 @@ struct cppi41_dd {
 	const struct chan_queues *queues_rx;
 	const struct chan_queues *queues_tx;
 	struct chan_queues td_queue;
+	u16 first_completion_queue;
+	u16 qmgr_num_pend;
 
 	struct list_head pending;	/* Pending queued transfers */
 	spinlock_t lock;		/* Lock for pending list */
@@ -155,7 +156,6 @@ struct cppi41_dd {
 	unsigned int dma_tdfdq;
 };
 
-#define FIST_COMPLETION_QUEUE	93
 static struct chan_queues am335x_usb_queues_tx[] = {
 	/* USB0 ENDP 1 */
 	[ 0] = { .submit = 32, .complete =  93},
@@ -233,6 +233,8 @@ struct cppi_glue_infos {
 	const struct chan_queues *queues_rx;
 	const struct chan_queues *queues_tx;
 	struct chan_queues td_queue;
+	u16 first_completion_queue;
+	u16 qmgr_num_pend;
 };
 
 static struct cppi41_channel *to_cpp41_chan(struct dma_chan *c)
@@ -286,19 +288,21 @@ static u32 cppi41_pop_desc(struct cppi41_dd *cdd, unsigned queue_num)
 
 static irqreturn_t cppi41_irq(struct cppi41_dd *cdd)
 {
+	u16 first_completion_queue = cdd->first_completion_queue;
+	u16 qmgr_num_pend = cdd->qmgr_num_pend;
 	struct cppi41_channel *c;
 	int i;
 
-	for (i = QMGR_PENDING_SLOT_Q(FIST_COMPLETION_QUEUE); i < QMGR_NUM_PEND;
+	for (i = QMGR_PENDING_SLOT_Q(first_completion_queue); i < qmgr_num_pend;
 			i++) {
 		u32 val;
 		u32 q_num;
 
 		val = cppi_readl(cdd->qmgr_mem + QMGR_PEND(i));
-		if (i == QMGR_PENDING_SLOT_Q(FIST_COMPLETION_QUEUE) && val) {
+		if (i == QMGR_PENDING_SLOT_Q(first_completion_queue) && val) {
 			u32 mask;
 			/* set corresponding bit for completetion Q 93 */
-			mask = 1 << QMGR_PENDING_BIT_Q(FIST_COMPLETION_QUEUE);
+			mask = 1 << QMGR_PENDING_BIT_Q(first_completion_queue);
 			/* not set all bits for queues less than Q 93 */
 			mask--;
 			/* now invert and keep only Q 93+ set */
@@ -876,7 +880,7 @@ static int init_cppi41(struct device *dev, struct cppi41_dd *cdd)
 		return -ENOMEM;
 
 	cppi_writel(cdd->scratch_phys, cdd->qmgr_mem + QMGR_LRAM0_BASE);
-	cppi_writel(QMGR_SCRATCH_SIZE, cdd->qmgr_mem + QMGR_LRAM_SIZE);
+	cppi_writel(TOTAL_DESCS_NUM, cdd->qmgr_mem + QMGR_LRAM_SIZE);
 	cppi_writel(0, cdd->qmgr_mem + QMGR_LRAM1_BASE);
 
 	ret = init_descs(dev, cdd);
@@ -959,6 +963,8 @@ static const struct cppi_glue_infos am335x_usb_infos = {
 	.queues_rx = am335x_usb_queues_rx,
 	.queues_tx = am335x_usb_queues_tx,
 	.td_queue = { .submit = 31, .complete = 0 },
+	.first_completion_queue = 93,
+	.qmgr_num_pend = 5,
 };
 
 static const struct of_device_id cppi41_dma_ids[] = {
@@ -1036,6 +1042,8 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 	cdd->queues_rx = glue_info->queues_rx;
 	cdd->queues_tx = glue_info->queues_tx;
 	cdd->td_queue = glue_info->td_queue;
+	cdd->qmgr_num_pend = glue_info->qmgr_num_pend;
+	cdd->first_completion_queue = glue_info->first_completion_queue;
 
 	ret = init_cppi41(dev, cdd);
 	if (ret)
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
