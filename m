From: Felipe Balbi <balbif-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/6] usb: dwc3: core: don't access DMA bits directly
Date: Sat,  2 Apr 2016 11:28:58 +0300
Message-ID: <1459585739-21204-6-git-send-email-felipe.balbi@linux.intel.com>
References: <1459585739-21204-1-git-send-email-felipe.balbi@linux.intel.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459585739-21204-1-git-send-email-felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Ivan T . Ivanov" <ivan.ivanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

instead of manually copying DMA bits from parent
device, we should let DMA API do its job.

Signed-off-by: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/usb/dwc3/core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 17fd81447c9f..d601de20e1cd 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -981,11 +981,7 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	spin_lock_init(&dwc->lock);
 
-	if (!dev->dma_mask) {
-		dev->dma_mask = dev->parent->dma_mask;
-		dev->dma_parms = dev->parent->dma_parms;
-		dma_set_coherent_mask(dev, dev->parent->coherent_dma_mask);
-	}
+	dma_coerce_mask_and_coherent(dev, dma_get_mask(dev->parent));
 
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
