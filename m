From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] dma: cpp41: Fix handling of error path
Date: Fri, 11 Nov 2016 11:28:52 -0800
Message-ID: <20161111192852.25399-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

If we return early on pm_runtime_get() error, we need to also call
pm_runtime_put_noidle() as pointed out in a musb related thread
by Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>. This is to keep the PM runtime
use counts happy.

Fixes: fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/dma/cppi41.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -366,8 +366,11 @@ static int cppi41_dma_alloc_chan_resources(struct dma_chan *chan)
 	int error;
 
 	error = pm_runtime_get_sync(cdd->ddev.dev);
-	if (error < 0)
+	if (error < 0) {
+		pm_runtime_put_noidle(cdd->ddev.dev);
+
 		return error;
+	}
 
 	dma_cookie_init(chan);
 	dma_async_tx_descriptor_init(&c->txd, chan);
@@ -389,8 +392,11 @@ static void cppi41_dma_free_chan_resources(struct dma_chan *chan)
 	int error;
 
 	error = pm_runtime_get_sync(cdd->ddev.dev);
-	if (error < 0)
+	if (error < 0) {
+		pm_runtime_put_noidle(cdd->ddev.dev);
+
 		return;
+	}
 
 	WARN_ON(!list_empty(&cdd->pending));
 
@@ -466,6 +472,7 @@ static void cppi41_dma_issue_pending(struct dma_chan *chan)
 
 	error = pm_runtime_get(cdd->ddev.dev);
 	if ((error != -EINPROGRESS) && error < 0) {
+		pm_runtime_put_noidle(cdd->ddev.dev);
 		dev_err(cdd->ddev.dev, "Failed to pm_runtime_get: %i\n",
 			error);
 
-- 
2.10.2
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
