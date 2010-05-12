From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/5] musb: add function to check if Inventra DMA used
Date: Wed, 12 May 2010 17:19:37 +0530
Message-ID: <1273664979-493-3-git-send-email-ajay.gupta@ti.com>
References: <1273664979-493-1-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-2-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1273664979-493-2-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Added is_inventra_dma_enabled() funtion which would be required
for adding workaround for Inventra DMA issues. It can also be
used at other places instead of #ifdefs.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musb_dma.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_dma.h b/drivers/usb/musb/musb_dma.h
index 916065b..b8b385e 100644
--- a/drivers/usb/musb/musb_dma.h
+++ b/drivers/usb/musb/musb_dma.h
@@ -80,6 +80,12 @@ struct musb_hw_ep;
 #define tusb_dma_omap()			0
 #endif
 
+#ifdef CONFIG_USB_INVENTRA_DMA
+#define	is_inventra_dma_enabled()	1
+#else
+#define	is_inventra_dma_enabled()	0
+#endif
+
 /* Anomaly 05000456 - USB Receive Interrupt Is Not Generated in DMA Mode 1
  *	Only allow DMA mode 1 to be used when the USB will actually generate the
  *	interrupts we expect.
-- 
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
