From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] dma: cppi41: Fix unpaired pm runtime when only a USB hub is connected
Date: Wed,  9 Nov 2016 09:47:59 -0700
Message-ID: <20161109164759.24913-3-tony@atomide.com>
References: <20161109164759.24913-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161109164759.24913-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On am335x with musb host we can end up with unpaired pm runtime calls
if a hub with no devices is connected and disconnected.

This is because of the conditional pm runtime calls which are always
a bad idea. Let's fix the issue by making them unconditional and
paired in each function.

Fixes: fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/dma/cppi41.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -318,6 +318,11 @@ static irqreturn_t cppi41_irq(int irq, void *data)
 		while (val) {
 			u32 desc, len;
 
+			status = pm_runtime_get(cdd->ddev.dev);
+			if (status < 0)
+				dev_err(cdd->ddev.dev, "%s pm runtime get: %i\n",
+					__func__, status);
+
 			q_num = __fls(val);
 			val &= ~(1 << q_num);
 			q_num += 32 * i;
@@ -338,7 +343,6 @@ static irqreturn_t cppi41_irq(int irq, void *data)
 			dma_cookie_complete(&c->txd);
 			dmaengine_desc_get_callback_invoke(&c->txd, NULL);
 
-			/* Paired with cppi41_dma_issue_pending */
 			pm_runtime_mark_last_busy(cdd->ddev.dev);
 			pm_runtime_put_autosuspend(cdd->ddev.dev);
 		}
@@ -460,7 +464,6 @@ static void cppi41_dma_issue_pending(struct dma_chan *chan)
 	struct cppi41_dd *cdd = c->cdd;
 	int error;
 
-	/* PM runtime paired with dmaengine_desc_get_callback_invoke */
 	error = pm_runtime_get(cdd->ddev.dev);
 	if ((error != -EINPROGRESS) && error < 0) {
 		dev_err(cdd->ddev.dev, "Failed to pm_runtime_get: %i\n",
@@ -473,6 +476,9 @@ static void cppi41_dma_issue_pending(struct dma_chan *chan)
 		push_desc_queue(c);
 	else
 		pending_desc(c);
+
+	pm_runtime_mark_last_busy(cdd->ddev.dev);
+	pm_runtime_put_autosuspend(cdd->ddev.dev);
 }
 
 static u32 get_host_pd0(u32 length)
-- 
2.10.2
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
