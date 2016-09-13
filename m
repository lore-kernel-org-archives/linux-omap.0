From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] dmaengine: cppi41: Ignore EINPROGRESS for PM runtime
Date: Tue, 13 Sep 2016 10:22:43 -0700
Message-ID: <20160913172243.13012-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

We can occasionally get -EINPROGRESS for pm_runtime_get. In that case
we can just continue as we're queueing transfers anyways when
pm_runtime_active is not set.

Fixes: fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/dma/cppi41.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -462,7 +462,7 @@ static void cppi41_dma_issue_pending(struct dma_chan *chan)
 
 	/* PM runtime paired with dmaengine_desc_get_callback_invoke */
 	error = pm_runtime_get(cdd->ddev.dev);
-	if (error < 0) {
+	if ((error != -EINPROGRESS) && error < 0) {
 		dev_err(cdd->ddev.dev, "Failed to pm_runtime_get: %i\n",
 			error);
 
-- 
2.9.3
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
