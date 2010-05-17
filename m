From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 3/3] musb: AM35x: Workaround for fifo read issue
Date: Mon, 17 May 2010 16:17:15 +0530
Message-ID: <1274093235-7616-3-git-send-email-ajay.gupta@ti.com>
References: <1274093235-7616-1-git-send-email-ajay.gupta@ti.com>
 <1274093235-7616-2-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38694 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754627Ab0EQKr0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 May 2010 06:47:26 -0400
In-Reply-To: <1274093235-7616-2-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

AM35x supports only 32bit read operations so we need to have
workaround for 8bit and 16bit read operations.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
Patch created against linus'tree + all musb patches in Greg's queue
Changes from v2:
	- fixed multipline comment style
 drivers/usb/musb/am3517.c    |   31 +++++++++++++++++++++++++++++++
 drivers/usb/musb/musb_core.c |    2 ++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/am3517.c b/drivers/usb/musb/am3517.c
index b74e664..c68c784 100644
--- a/drivers/usb/musb/am3517.c
+++ b/drivers/usb/musb/am3517.c
@@ -515,3 +515,34 @@ void musb_platform_restore_context(struct musb_context_registers
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
+	/*
+	 * Now read the rest 1 to 3 bytes or complete length if
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
index 4093f6d..9c59a8e 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -262,6 +262,7 @@ void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *src)
 	}
 }
 
+#if !defined(CONFIG_MACH_OMAP3517EVM)
 /*
  * Unload an endpoint's FIFO
  */
@@ -299,6 +300,7 @@ void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
 		readsb(fifo, dst, len);
 	}
 }
+#endif
 
 #endif	/* normal PIO */
 
-- 
1.6.2.4

