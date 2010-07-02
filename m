From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH resend 3/3] musb: AM35x: Workaround for fifo read issue
Date: Fri,  2 Jul 2010 12:27:59 +0530
Message-ID: <1278053879-6850-3-git-send-email-ajay.gupta@ti.com>
References: <1278053879-6850-1-git-send-email-ajay.gupta@ti.com>
 <1278053879-6850-2-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39263 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754767Ab0GBG6J (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Jul 2010 02:58:09 -0400
In-Reply-To: <1278053879-6850-2-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

AM35x supports only 32bit read operations so we need to have
workaround for 8bit and 16bit read operations.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/am35x.c     |   30 ++++++++++++++++++++++++++++++
 drivers/usb/musb/musb_core.c |    2 ++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 0cdc6bf..cdcd6f3 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -517,3 +517,33 @@ void musb_platform_restore_context(struct musb *musb,
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
index 3b795c5..e22e98b 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -272,6 +272,7 @@ void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *src)
 	}
 }
 
+#if !defined(CONFIG_ARCH_AM35x)
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

