From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] dma: cppi41: add missing directions bitfield
Date: Wed, 25 Feb 2015 16:54:02 -0600
Message-ID: <1424904842-27902-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Without those we will see a kernel WARN()
when loading musb on am335x devices.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/dma/cppi41.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index 512cb8e2805e..4e9cc8e8100c 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -926,6 +926,7 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 	cdd->ddev.device_issue_pending = cppi41_dma_issue_pending;
 	cdd->ddev.device_prep_slave_sg = cppi41_dma_prep_slave_sg;
 	cdd->ddev.device_terminate_all = cppi41_stop_chan;
+	cdd->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	cdd->ddev.dev = dev;
 	INIT_LIST_HEAD(&cdd->ddev.channels);
 	cpp41_dma_info.dma_cap = cdd->ddev.cap_mask;
-- 
2.3.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
