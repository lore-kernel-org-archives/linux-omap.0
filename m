From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH][linux-next] dmaengine: cppi41: Fix an Oops happening in cppi41_dma_probe()
Date: Wed,  5 Apr 2017 18:35:16 +0200
Message-ID: <20170405163516.13627-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This fix an Oops happening on all platforms using the old dt bindings
(all platforms but da8xx).
This update cppi41_dma_probe() to use the index variable which is
required to keep compatibility between old and new dt bindings.

Fixes: 8e3ba95f4190 ("dmaengine: cppi41: use managed functions devm_*()")
Reported-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/dma/cppi41.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index 0be56c9..f7e965f 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -1038,17 +1038,17 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 	if (index < 0)
 		return index;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, index);
 	cdd->ctrl_mem = devm_ioremap_resource(dev, mem);
 	if (IS_ERR(cdd->ctrl_mem))
 		return PTR_ERR(cdd->ctrl_mem);
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, index + 1);
 	cdd->sched_mem = devm_ioremap_resource(dev, mem);
 	if (IS_ERR(cdd->sched_mem))
 		return PTR_ERR(cdd->sched_mem);
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, index + 2);
 	cdd->qmgr_mem = devm_ioremap_resource(dev, mem);
 	if (IS_ERR(cdd->qmgr_mem))
 		return PTR_ERR(cdd->qmgr_mem);
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
