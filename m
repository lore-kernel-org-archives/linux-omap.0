From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/3 v2] musb: AM35x: Workaround for fifo read issue
Date: Tue, 18 May 2010 17:39:46 +0530
Message-ID: <1274184586-28843-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

AM35x supports only 32bit read operations so we need to have
workaround for 8bit and 16bit read operations.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
Patch created against linus'tree + all musb patches in Greg's queue 
Changes from v1:
	- removed unnecessary parens.
	- Removed 'memcpy' for 32 bit read loops.

 drivers/usb/musb/am3517.c    |   30 ++++++++++++++++++++++++++++++
 drivers/usb/musb/musb_core.c |    2 ++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/am3517.c b/drivers/usb/musb/am3517.c
index b74e664..3299c66 100644
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
+	if (likely((0x03 & (unsigned long) dst) == 0) && len >= 4) {
+		readsl(fifo, dst, len >> 2);
+		dst += len & ~0x03;
+		len &= 0x03;
+	}
+	/*
+	 * Now read the rest 1 to 3 bytes or complete length if
+	 * unaligned address.
+	 */
+	if (len > 4) {
+		for (i = 0; i < (len >> 2); i++) {
+			*(u32 *) dst = musb_readl(fifo, 0);
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
