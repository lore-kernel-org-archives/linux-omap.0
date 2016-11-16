From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] dmaengine: cppi41: More PM runtime fixes
Date: Wed, 16 Nov 2016 10:24:15 -0800
Message-ID: <20161116182415.3149-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Fix use of u32 instead of int for checking for negative errors values
as pointed out by Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>.

And while testing the PM runtime error path by randomly returning
failed values in runtime resume, I noticed two more places that need
fixing:

- If pm_runtime_get_sync() fails in probe, we still need to do
  pm_runtime_put_sync() to keep the use count happy. We could call
  pm_runtime_put_noidle() on the error path, but we're just going
  to call pm_runtime_disable() after that so pm_runtime_put_sync()
  will do what we want

- We should print an error if pm_runtime_get_sync() fails in
  cppi41_dma_alloc_chan_resources() so we know where it happens

Reported-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Fixes: 740b4be3f742 ("dmaengine: cpp41: Fix handling of error path")
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/dma/cppi41.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -317,11 +317,12 @@ static irqreturn_t cppi41_irq(int irq, void *data)
 
 		while (val) {
 			u32 desc, len;
+			int error;
 
-			status = pm_runtime_get(cdd->ddev.dev);
-			if (status < 0)
+			error = pm_runtime_get(cdd->ddev.dev);
+			if (error < 0)
 				dev_err(cdd->ddev.dev, "%s pm runtime get: %i\n",
-					__func__, status);
+					__func__, error);
 
 			q_num = __fls(val);
 			val &= ~(1 << q_num);
@@ -367,6 +368,8 @@ static int cppi41_dma_alloc_chan_resources(struct dma_chan *chan)
 
 	error = pm_runtime_get_sync(cdd->ddev.dev);
 	if (error < 0) {
+		dev_err(cdd->ddev.dev, "%s pm runtime get: %i\n",
+			__func__, error);
 		pm_runtime_put_noidle(cdd->ddev.dev);
 
 		return error;
@@ -1072,8 +1075,8 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 	deinit_cppi41(dev, cdd);
 err_init_cppi:
 	pm_runtime_dont_use_autosuspend(dev);
-	pm_runtime_put_sync(dev);
 err_get_sync:
+	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 	iounmap(cdd->usbss_mem);
 	iounmap(cdd->ctrl_mem);
-- 
2.10.2
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
