From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 6/7] usb: musb: unmap base if we can't probe
Date: Thu, 21 Jan 2010 15:33:57 +0200
Message-ID: <1264080838-9452-7-git-send-email-felipe.balbi@nokia.com>
References: <1264080838-9452-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1264080838-9452-1-git-send-email-felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

when probe() fails, we should iounmap() the mapped address.

Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/musb_core.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 3e9b3b0..de7b377 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2110,6 +2110,7 @@ static int __init musb_probe(struct platform_device *pdev)
 {
 	struct device	*dev = &pdev->dev;
 	int		irq = platform_get_irq(pdev, 0);
+	int		status;
 	struct resource	*iomem;
 	void __iomem	*base;
 
@@ -2127,7 +2128,12 @@ static int __init musb_probe(struct platform_device *pdev)
 	/* clobbered by use_dma=n */
 	orig_dma_mask = dev->dma_mask;
 #endif
-	return musb_init_controller(dev, irq, base);
+
+	status = musb_init_controller(dev, irq, base);
+	if (status < 0)
+		iounmap(base);
+
+	return status;
 }
 
 static int __exit musb_remove(struct platform_device *pdev)
-- 
1.6.6.rc0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
