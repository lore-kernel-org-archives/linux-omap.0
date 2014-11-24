From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 8/8] usb: musb: Use IS_ENABLED for tusb6010
Date: Mon, 24 Nov 2014 11:05:06 -0800
Message-ID: <1416855906-13931-9-git-send-email-tony@atomide.com>
References: <1416855906-13931-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20066 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803AbaKXTIC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2014 14:08:02 -0500
In-Reply-To: <1416855906-13931-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

This removes the ifdef clutter a bit and saves few lines.

It also makes it easier to detect the remaining places
where we have conditional building of code done based
on if defined for things like DMA.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_core.c | 2 +-
 drivers/usb/musb/musb_core.h | 9 +++------
 drivers/usb/musb/musb_regs.h | 3 ---
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 0875365..0f44676 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1527,7 +1527,7 @@ static int musb_core_init(u16 musb_type, struct musb *musb)
 		struct musb_hw_ep	*hw_ep = musb->endpoints + i;
 
 		hw_ep->fifo = musb->io.fifo_offset(i) + mbase;
-#if defined(CONFIG_USB_MUSB_TUSB6010) || defined (CONFIG_USB_MUSB_TUSB6010_MODULE)
+#if IS_ENABLED(CONFIG_USB_MUSB_TUSB6010)
 		if (musb->io.quirks & MUSB_IN_TUSB) {
 			hw_ep->fifo_async = musb->async + 0x400 + musb->io.fifo_offset(i);
 			hw_ep->fifo_sync = musb->sync + 0x400 + musb->io.fifo_offset(i);
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 02f62cb..841476c 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -216,8 +216,7 @@ struct musb_hw_ep {
 	void __iomem		*fifo;
 	void __iomem		*regs;
 
-#if defined(CONFIG_USB_MUSB_TUSB6010) || \
-	defined(CONFIG_USB_MUSB_TUSB6010_MODULE)
+#if IS_ENABLED(CONFIG_USB_MUSB_TUSB6010)
 	void __iomem		*conf;
 #endif
 
@@ -234,8 +233,7 @@ struct musb_hw_ep {
 	struct dma_channel	*tx_channel;
 	struct dma_channel	*rx_channel;
 
-#if defined(CONFIG_USB_MUSB_TUSB6010) || \
-	defined(CONFIG_USB_MUSB_TUSB6010_MODULE)
+#if IS_ENABLED(CONFIG_USB_MUSB_TUSB6010)
 	/* TUSB has "asynchronous" and "synchronous" dma modes */
 	dma_addr_t		fifo_async;
 	dma_addr_t		fifo_sync;
@@ -339,8 +337,7 @@ struct musb {
 	void __iomem		*ctrl_base;
 	void __iomem		*mregs;
 
-#if defined(CONFIG_USB_MUSB_TUSB6010) || \
-	defined(CONFIG_USB_MUSB_TUSB6010_MODULE)
+#if IS_ENABLED(CONFIG_USB_MUSB_TUSB6010)
 	dma_addr_t		async;
 	dma_addr_t		sync;
 	void __iomem		*sync_va;
diff --git a/drivers/usb/musb/musb_regs.h b/drivers/usb/musb/musb_regs.h
index 92b4c3d..11f0be0 100644
--- a/drivers/usb/musb/musb_regs.h
+++ b/drivers/usb/musb/musb_regs.h
@@ -287,10 +287,7 @@
 #define MUSB_FIFOSIZE		0x0F
 #define MUSB_CONFIGDATA		MUSB_FIFOSIZE	/* Re-used for EP0 */
 
-#if defined(CONFIG_USB_MUSB_TUSB6010) ||	\
-	defined(CONFIG_USB_MUSB_TUSB6010_MODULE)
 #include "tusb6010.h"		/* Needed "only" for TUSB_EP0_CONF */
-#endif
 
 #define MUSB_TXCSR_MODE			0x2000
 
-- 
2.1.3

