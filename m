From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] dmaengine: cppi41: Prepare to add PM runtime support
Date: Fri, 19 Aug 2016 15:59:39 -0700
Message-ID: <20160819225940.12653-2-tony@atomide.com>
References: <20160819225940.12653-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160819225940.12653-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Let's just move code from cppi41_dma_issue_pending() to
push_desc_queue() as that's the only call to push_desc_queue().

We want to do this for PM runtime as we need to call push_desc_queue()
also for pending queued transfers from PM runtime resume.

No functional changes, just moves code around.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/dma/cppi41.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index 3b4c842..66b84fe 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -386,21 +386,6 @@ static void push_desc_queue(struct cppi41_channel *c)
 	u32 desc_phys;
 	u32 reg;
 
-	desc_phys = lower_32_bits(c->desc_phys);
-	desc_num = (desc_phys - cdd->descs_phys) / sizeof(struct cppi41_desc);
-	WARN_ON(cdd->chan_busy[desc_num]);
-	cdd->chan_busy[desc_num] = c;
-
-	reg = (sizeof(struct cppi41_desc) - 24) / 4;
-	reg |= desc_phys;
-	cppi_writel(reg, cdd->qmgr_mem + QMGR_QUEUE_D(c->q_num));
-}
-
-static void cppi41_dma_issue_pending(struct dma_chan *chan)
-{
-	struct cppi41_channel *c = to_cpp41_chan(chan);
-	u32 reg;
-
 	c->residue = 0;
 
 	reg = GCR_CHAN_ENABLE;
@@ -418,6 +403,21 @@ static void cppi41_dma_issue_pending(struct dma_chan *chan)
 	 * before starting the dma engine.
 	 */
 	__iowmb();
+
+	desc_phys = lower_32_bits(c->desc_phys);
+	desc_num = (desc_phys - cdd->descs_phys) / sizeof(struct cppi41_desc);
+	WARN_ON(cdd->chan_busy[desc_num]);
+	cdd->chan_busy[desc_num] = c;
+
+	reg = (sizeof(struct cppi41_desc) - 24) / 4;
+	reg |= desc_phys;
+	cppi_writel(reg, cdd->qmgr_mem + QMGR_QUEUE_D(c->q_num));
+}
+
+static void cppi41_dma_issue_pending(struct dma_chan *chan)
+{
+	struct cppi41_channel *c = to_cpp41_chan(chan);
+
 	push_desc_queue(c);
 }
 
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
