From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] dma: cppi41: Fix list not empty warning on module removal
Date: Wed,  9 Nov 2016 09:47:58 -0700
Message-ID: <20161109164759.24913-2-tony@atomide.com>
References: <20161109164759.24913-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161109164759.24913-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

If musb controller is configured with USB peripherals and we have
enumerated with a USB host, we can get warnings on removal of the
modules:

WARNING: CPU: 0 PID: 1269 at drivers/dma/cppi41.c:391
cppi41_dma_free_chan_resources

Fix the issue by adding the missing pm_runtime_get to
cppi41_dma_free_chan_resources to make sure the pending work
list is cleared on removal.

Fixes: fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/dma/cppi41.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -1072,7 +1072,12 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 static int cppi41_dma_remove(struct platform_device *pdev)
 {
 	struct cppi41_dd *cdd = platform_get_drvdata(pdev);
+	int error;
 
+	error = pm_runtime_get_sync(&pdev->dev);
+	if (error < 0)
+		dev_err(&pdev->dev, "%s could not pm_runtime_get: %i\n",
+			__func__, error);
 	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&cdd->ddev);
 
-- 
2.10.2
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
