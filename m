From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 3/3 v2] musb: AM35x: Workaround for fifo read issue
Date: Fri, 14 May 2010 17:35:37 +0530
Message-ID: <1273838737-6995-3-git-send-email-ajay.gupta@ti.com>
References: <1273838737-6995-1-git-send-email-ajay.gupta@ti.com>
 <1273838737-6995-2-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59135 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755218Ab0ENMFm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 May 2010 08:05:42 -0400
In-Reply-To: <1273838737-6995-2-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Ajay Kumar Gupta <ajay.gupta@ti.com>

AM35x supports only 32bit read operations so we need to have
workaround for 8bit and 16bit read operations.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/am3517.c    |   30 ++++++++++++++++++++++++++++++
 drivers/usb/musb/musb_core.c |    2 ++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/am3517.c b/drivers/usb/musb/am3517.c
index dd9e883..24bdc2e 100644
--- a/drivers/usb/musb/am3517.c
+++ b/drivers/usb/musb/am3517.c
@@ -515,3 +515,33 @@ void musb_platform_restore_context(struct musb_context_registers
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
+	if ((likely((0x03 & (unsigned long) dst) == 0)) && len >= 4) {
+		readsl(fifo, dst, len >> 2);
+		dst += (len & ~0x03);
+		len &= 0x03;
+	}
+	/* Now read the rest 1 to 3 bytes or complete length if
+	 * unaligned address.
+	 */
+	if (len > 4) {
+		for (i = 0; i < (len >> 2); i++) {
+			val = musb_readl(fifo, 0);
+			memcpy(dst, &val, 4);
+			dst += 4;
+		}
+		len %= 4;
+	}
+	if (len > 0) {
+		val = musb_readl(fifo, 0);
+		memcpy(dst, &val, len);
+	}
+}
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 705cc4a..bc2cf14 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -191,6 +191,7 @@ void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *src)
 	}
 }
 
+#if !defined(CONFIG_MACH_OMAP3517EVM)
 /*
  * Unload an endpoint's FIFO
  */
@@ -228,6 +229,7 @@ void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
 		readsb(fifo, dst, len);
 	}
 }
+#endif
 
 #endif	/* normal PIO */
 
-- 
1.6.2.4

