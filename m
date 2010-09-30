From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 3/3 v5] musb: AM35x: Workaround for fifo read issue
Date: Thu, 30 Sep 2010 10:49:09 +0530
Message-ID: <1285823949-27694-3-git-send-email-ajay.gupta@ti.com>
References: <1285823949-27694-1-git-send-email-ajay.gupta@ti.com>
 <1285823949-27694-2-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54221 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608Ab0I3FTR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 01:19:17 -0400
In-Reply-To: <1285823949-27694-2-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

AM35x supports only 32bit read operations so we need to have
workaround for 8bit and 16bit read operations.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
No logical change from v4.

 drivers/usb/musb/am35x.c     |   30 ++++++++++++++++++++++++++++++
 drivers/usb/musb/musb_core.c |    2 ++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 53962a0..b0aabf3 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -492,3 +492,33 @@ void musb_platform_restore_context(struct musb *musb,
 	phy_on();
 }
 #endif
+
+/* AM35x supports only 32bit read operation */
+void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
+{
+	void __iomem *fifo = hw_ep->fifo;
+	u32		val;
+	int		i;
+
+	/* Read for 32bit-aligned destination address */
+	if (likely((0x03 & (unsigned long) dst) == 0) && len >= 4) {
+		readsl(fifo, dst, len >> 2);
+		dst += len & ~0x03;
+		len &= 0x03;
+	}
+	/*
+	 * Now read the remaining 1 to 3 byte or complete length if
+	 * unaligned address.
+	 */
+	if (len > 4) {
+		for (i = 0; i < (len >> 2); i++) {
+			*(u32 *) dst = musb_readl(fifo, 0);
+			dst += 4;
+		}
+		len &= 0x03;
+	}
+	if (len > 0) {
+		val = musb_readl(fifo, 0);
+		memcpy(dst, &val, len);
+	}
+}
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 472b2a7..f03a2aa 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -272,6 +272,7 @@ void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *src)
 	}
 }
 
+#if !defined(CONFIG_USB_MUSB_AM35X)
 /*
  * Unload an endpoint's FIFO
  */
@@ -309,6 +310,7 @@ void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
 		readsb(fifo, dst, len);
 	}
 }
+#endif
 
 #endif	/* normal PIO */
 
-- 
1.6.2.4

