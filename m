From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/3 v3] musb: AM35x: Workaround for fifo read issue
Date: Tue, 25 May 2010 12:08:42 +0530
Message-ID: <1274769522-28212-3-git-send-email-ajay.gupta@ti.com>
References: <1274769522-28212-1-git-send-email-ajay.gupta@ti.com>
 <1274769522-28212-2-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1274769522-28212-2-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

AM35x supports only 32bit read operations so we need to have
workaround for 8bit and 16bit read operations.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
Changes from v2:
	- Added CONFIG_ARCH_AMx

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
index 5f53ac1..e71049c 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -262,6 +262,7 @@ void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *src)
 	}
 }
 
+#if !defined(CONFIG_ARCH_AM35x)
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
