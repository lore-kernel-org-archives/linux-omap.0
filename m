From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 6/6 v2] musb: dma: use optimal transfer element for sdma
Date: Tue, 18 May 2010 17:38:40 +0530
Message-ID: <1274184520-28783-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34230 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756176Ab0ERMIq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 May 2010 08:08:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Ajay Kumar Gupta <ajay.gupta@ti.com>

Use optimal values of transfer element based on buffer address in system
DMA programming. This would improve the performance.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
Patch created against linus'tree + all musb patches in Greg's queue
Changes from v1:
	- fixed extra identation in switch statement.

 drivers/usb/musb/musbhsdma.c |   29 ++++++++++++++++++++++++++---
 1 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index d29e487..22a2978 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -52,11 +52,34 @@ static void musb_sdma_channel_program(struct musb *musb,
 		struct musb_dma_channel *musb_channel,
 		dma_addr_t dma_addr, u32 len)
 {
+	u16 frame = len;
+	int data_type = OMAP_DMA_DATA_TYPE_S8;
+
+	switch (dma_addr & 0x3) {
+	case 0:
+		if ((len % 4) == 0) {
+			data_type = OMAP_DMA_DATA_TYPE_S32;
+			frame = len / 4;
+			break;
+		}
+	case 2:
+		if ((len % 2) == 0) {
+			data_type = OMAP_DMA_DATA_TYPE_S16;
+			frame = len / 2;
+			break;
+		}
+	case 1:
+	case 3:
+	default:
+		data_type = OMAP_DMA_DATA_TYPE_S8;
+		frame = len;
+		break;
+	}
 	/* set transfer parameters */
 	omap_set_dma_transfer_params(musb_channel->sysdma_channel,
-				OMAP_DMA_DATA_TYPE_S8,
-				len ? len : 1, 1, /* One frame */
-				OMAP_DMA_SYNC_ELEMENT,
+				data_type,
+				len ? frame : 1, 1, /* One frame */
+				OMAP_DMA_SYNC_FRAME,
 				OMAP24XX_DMA_NO_DEVICE,
 				0); /* Src Sync */
 
-- 
1.6.2.4

