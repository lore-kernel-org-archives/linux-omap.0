From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH/USB 06/16] usb: musb: hsdma: add wrapper for reading DMA count
Date: Tue, 19 Jan 2010 15:14:05 +0200
Message-ID: <1263906855-28341-7-git-send-email-felipe.balbi@nokia.com>
References: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27323 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539Ab0ASNO7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 08:14:59 -0500
In-Reply-To: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com

From: Anand Gadiyar <gadiyar@ti.com>

Add a wrapper for reading the DMA count register, analogous
to the one for writing to this register.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/musb/musbhsdma.h |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musbhsdma.h b/drivers/usb/musb/musbhsdma.h
index 1299d92..613f95a 100644
--- a/drivers/usb/musb/musbhsdma.h
+++ b/drivers/usb/musb/musbhsdma.h
@@ -55,6 +55,10 @@
 		    MUSB_HSDMA_CHANNEL_OFFSET(bchannel, MUSB_HSDMA_ADDRESS), \
 		    addr)
 
+#define musb_read_hsdma_count(mbase, bchannel)	\
+	musb_readl(mbase,	\
+		   MUSB_HSDMA_CHANNEL_OFFSET(bchannel, MUSB_HSDMA_COUNT))
+
 #define musb_write_hsdma_count(mbase, bchannel, len) \
 	musb_writel(mbase, \
 		    MUSB_HSDMA_CHANNEL_OFFSET(bchannel, MUSB_HSDMA_COUNT), \
@@ -96,6 +100,19 @@ static inline void musb_write_hsdma_addr(void __iomem *mbase,
 		((u16)(((u32) dma_addr >> 16) & 0xFFFF)));
 }
 
+static inline u32 musb_read_hsdma_count(void __iomem *mbase, u8 bchannel)
+{
+	u32 count = musb_readw(mbase,
+		MUSB_HSDMA_CHANNEL_OFFSET(bchannel, MUSB_HSDMA_COUNT_HIGH));
+
+	count = count << 16;
+
+	count |= musb_readw(mbase,
+		MUSB_HSDMA_CHANNEL_OFFSET(bchannel, MUSB_HSDMA_COUNT_LOW));
+
+	return count;
+}
+
 static inline void musb_write_hsdma_count(void __iomem *mbase,
 				u8 bchannel, u32 len)
 {
-- 
1.6.6.rc0

