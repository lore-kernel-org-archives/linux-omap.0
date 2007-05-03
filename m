From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] musb_hdrc: Clean-up TUSB fifo access
Date: Thu, 3 May 2007 18:43:51 +0000
Message-ID: <20070503184351.GI28985@atomide.com>
References: <11782105181141-git-send-email-tony@atomide.com>
	<11782105222073-git-send-email-tony@atomide.com>
	<11782105223370-git-send-email-tony@atomide.com>
	<11782105221042-git-send-email-tony@atomide.com>
	<11782105222902-git-send-email-tony@atomide.com>
	<11782105231172-git-send-email-tony@atomide.com>
	<117821052378-git-send-email-tony@atomide.com>
	<11782105232838-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TiqCXmo5T1hvSQQg"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <11782105232838-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I found one more patch in addition to these seven patches that has been
pending a while but never got pushed because of the remaining flakeyness.
Seems to work just fine.

Tony

--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline;
	filename="0008-musb_hdrc-Clean-up-TUSB-fifo-access.txt"

>From be9d415b172e8c3fb375058ef3a35aca95192233 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 3 May 2007 18:31:35 +0000
Subject: [PATCH] musb_hdrc: Clean-up TUSB fifo access

This patch cleans-up TUSB fifo access and uses readsl/writesl()
when possible. It also has hooks for some further optimization,
notably synchronous burst access using PIO.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/usb/musb/musbdefs.h |    2 +
 drivers/usb/musb/plat_uds.c |    3 +
 drivers/usb/musb/tusb6010.c |  170 ++++++++++++++++++++++++++-----------------
 3 files changed, 108 insertions(+), 67 deletions(-)

diff --git a/drivers/usb/musb/musbdefs.h b/drivers/usb/musb/musbdefs.h
index f641297..a64e2ed 100644
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -296,6 +296,7 @@ struct musb_hw_ep {
 	/* TUSB has "asynchronous" and "synchronous" dma modes */
 	dma_addr_t		fifo_async;
 	dma_addr_t		fifo_sync;
+	void __iomem		*fifo_sync_va;
 #endif
 
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
@@ -381,6 +382,7 @@ struct musb {
 #ifdef CONFIG_USB_TUSB6010
 	dma_addr_t		async;
 	dma_addr_t		sync;
+	void __iomem		*sync_va;
 #endif
 
 	/* passed down from chip/board specific irq handlers */
diff --git a/drivers/usb/musb/plat_uds.c b/drivers/usb/musb/plat_uds.c
index 86dd6b2..856075f 100644
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -1269,6 +1269,9 @@ static int __init musb_core_init(u16 wType, struct musb *pThis)
 #ifdef CONFIG_USB_TUSB6010
 		hw_ep->fifo_async = pThis->async + 0x400 + MUSB_FIFO_OFFSET(i);
 		hw_ep->fifo_sync = pThis->sync + 0x400 + MUSB_FIFO_OFFSET(i);
+		hw_ep->fifo_sync_va =
+			pThis->sync_va + 0x400 + MUSB_FIFO_OFFSET(i);
+
 		if (i == 0)
 			hw_ep->conf = pBase - 0x400 + TUSB_EP0_CONF;
 		else
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 9f01329..48c3ab3 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -31,19 +31,58 @@
  * so both loading and unloading FIFOs need explicit byte counts.
  */
 
+static inline void
+tusb_fifo_write_unaligned(void __iomem *fifo, const u8 *buf, u16 len)
+{
+	u32		val;
+	int		i;
+
+	if (len > 4) {
+		for (i = 0; i < (len >> 2); i++) {
+			memcpy(&val, buf, 4);
+			musb_writel(fifo, 0, val);
+			buf += 4;
+		}
+		len %= 4;
+	}
+	if (len > 0) {
+		/* Write the rest 1 - 3 bytes to FIFO */
+		memcpy(&val, buf, len);
+		musb_writel(fifo, 0, val);
+	}
+}
+
+static inline void tusb_fifo_read_unaligned(void __iomem *fifo,
+						void __iomem *buf, u16 len)
+{
+	u32		val;
+	int		i;
+
+	if (len > 4) {
+		for (i = 0; i < (len >> 2); i++) {
+			val = musb_readl(fifo, 0);
+			memcpy(buf, &val, 4);
+			buf += 4;
+		}
+		len %= 4;
+	}
+	if (len > 0) {
+		/* Read the rest 1 - 3 bytes from FIFO */
+		val = musb_readl(fifo, 0);
+		memcpy(buf, &val, len);
+	}
+}
+
 void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *buf)
 {
 	void __iomem	*ep_conf = hw_ep->conf;
 	void __iomem	*fifo = hw_ep->fifo;
 	u8		epnum = hw_ep->bLocalEnd;
-	u8		*bufp = (u8 *)buf;
-	int		i, remain;
-	u32		val;
 
-	prefetch(bufp);
+	prefetch(buf);
 
 	DBG(4, "%cX ep%d fifo %p count %d buf %p\n",
-			'T', epnum, fifo, len, bufp);
+			'T', epnum, fifo, len, buf);
 
 	if (epnum)
 		musb_writel(ep_conf, TUSB_EP_TX_OFFSET,
@@ -52,40 +91,35 @@ void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *buf)
 		musb_writel(ep_conf, 0, TUSB_EP0_CONFIG_DIR_TX |
 			TUSB_EP0_CONFIG_XFR_SIZE(len));
 
-	/* Write 32-bit blocks from buffer to FIFO
-	 * REVISIT: Optimize for burst ... writesl/writesw
-	 */
-	if (len >= 4) {
-		if (((unsigned long)bufp & 0x3) == 0) {
-			for (i = 0; i < (len / 4); i++ ) {
-				val = *(u32 *)bufp;
-				bufp += 4;
-				musb_writel(fifo, 0, val);
-			}
-		} else if (((unsigned long)bufp & 0x2) == 0x2) {
-			for (i = 0; i < (len / 4); i++ ) {
-				val = (u32)(*(u16 *)bufp);
-				bufp += 2;
-				val |= (*(u16 *)bufp) << 16;
-				bufp += 2;
-				musb_writel(fifo, 0, val);
+	if (likely((0x01 & (unsigned long) buf) == 0)) {
+
+		/* Best case is 32bit-aligned destination address */
+		if ((0x02 & (unsigned long) buf) == 0) {
+			if (len >= 4) {
+				writesl(fifo, buf, len >> 2);
+				buf += (len & ~0x03);
+				len &= 0x03;
 			}
 		} else {
-			for (i = 0; i < (len / 4); i++ ) {
-				memcpy(&val, bufp, 4);
-				bufp += 4;
-				musb_writel(fifo, 0, val);
+			if (len >= 2) {
+				u32 val;
+				int i;
+
+				/* Cannot use writesw, fifo is 32-bit */
+				for (i = 0; i < (len >> 2); i++) {
+					val = (u32)(*(u16 *)buf);
+					buf += 2;
+					val |= (*(u16 *)buf) << 16;
+					buf += 2;
+					musb_writel(fifo, 0, val);
+				}
+				len &= 0x03;
 			}
 		}
-		remain = len - (i * 4);
-	} else
-		remain = len;
-
-	if (remain) {
-		/* Write rest of 1-3 bytes from buffer into FIFO */
-		memcpy(&val, bufp, remain);
-		musb_writel(fifo, 0, val);
 	}
+
+	if (len > 0)
+		tusb_fifo_write_unaligned(fifo, buf, len);
 }
 
 void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *buf)
@@ -93,12 +127,9 @@ void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *buf)
 	void __iomem	*ep_conf = hw_ep->conf;
 	void __iomem	*fifo = hw_ep->fifo;
 	u8		epnum = hw_ep->bLocalEnd;
-	u8		*bufp = (u8 *)buf;
-	int		i, remain;
-	u32		val;
 
 	DBG(4, "%cX ep%d fifo %p count %d buf %p\n",
-			'R', epnum, fifo, len, bufp);
+			'R', epnum, fifo, len, buf);
 
 	if (epnum)
 		musb_writel(ep_conf, TUSB_EP_RX_OFFSET,
@@ -106,40 +137,35 @@ void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *buf)
 	else
 		musb_writel(ep_conf, 0, TUSB_EP0_CONFIG_XFR_SIZE(len));
 
-	/* Read 32-bit blocks from FIFO to buffer
-	 * REVISIT: Optimize for burst ... writesl/writesw
-	 */
-	if (len >= 4) {
-		if (((unsigned long)bufp & 0x3) == 0) {
-			for (i = 0; i < (len / 4); i++) {
-				val = musb_readl(fifo, 0);
-				*(u32 *)bufp = val;
-				bufp += 4;
-			}
-		} else if (((unsigned long)bufp & 0x2) == 0x2) {
-			for (i = 0; i < (len / 4); i++) {
-				val = musb_readl(fifo, 0);
-				*(u16 *)bufp = (u16)(val & 0xffff);
-				bufp += 2;
-				*(u16 *)bufp = (u16)(val >> 16);
-				bufp += 2;
+	if (likely((0x01 & (unsigned long) buf) == 0)) {
+
+		/* Best case is 32bit-aligned destination address */
+		if ((0x02 & (unsigned long) buf) == 0) {
+			if (len >= 4) {
+				readsl(fifo, buf, len >> 2);
+				buf += (len & ~0x03);
+				len &= 0x03;
 			}
 		} else {
-			for (i = 0; i < (len / 4); i++) {
-				val = musb_readl(fifo, 0);
-				memcpy(bufp, &val, 4);
-				bufp += 4;
+			if (len >= 2) {
+				u32 val;
+				int i;
+
+				/* Cannot use readsw, fifo is 32-bit */
+				for (i = 0; i < (len >> 2); i++) {
+					val = musb_readl(fifo, 0);
+					*(u16 *)buf = (u16)(val & 0xffff);
+					buf += 2;
+					*(u16 *)buf = (u16)(val >> 16);
+					buf += 2;
+				}
+				len &= 0x03;
 			}
 		}
-		remain = len - (i * 4);
-	} else
-		remain = len;
-
-	if (remain) {
-		/* Read rest of 1-3 bytes from FIFO */
-		val = musb_readl(fifo, 0);
-		memcpy(bufp, &val, remain);
 	}
+
+	if (len > 0)
+		tusb_fifo_read_unaligned(fifo, buf, len);
 }
 
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
@@ -900,6 +926,7 @@ int __init musb_platform_init(struct musb *musb)
 {
 	struct platform_device	*pdev;
 	struct resource		*mem;
+	void __iomem		*sync;
 	int			ret;
 
 	pdev = to_platform_device(musb->controller);
@@ -916,6 +943,13 @@ int __init musb_platform_init(struct musb *musb)
 	}
 	musb->sync = mem->start;
 
+	sync = ioremap(mem->start, mem->end - mem->start + 1);
+	if (!sync) {
+		pr_debug("ioremap for sync failed\n");
+		return -ENOMEM;
+	}
+	musb->sync_va = sync;
+
 	/* Offsets from base: VLYNQ at 0x000, MUSB regs at 0x400,
 	 * FIFOs at 0x600, TUSB at 0x800
 	 */
@@ -946,5 +980,7 @@ int musb_platform_exit(struct musb *musb)
 	if (musb->board_set_power)
 		musb->board_set_power(0);
 
+	iounmap(musb->sync_va);
+
 	return 0;
 }
-- 
1.4.4.2


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--TiqCXmo5T1hvSQQg--
