From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 8/52] musb_hdrc: Search and replace pDest with dst
Date: Mon, 13 Aug 2007 06:48:43 -0700
Message-ID: <118701298833-git-send-email-tony@atomide.com>
References: musb <11870129672745-git-send-email-tony@atomide.com>
	<11870129702817-git-send-email-tony@atomide.com>
	<11870129721700-git-send-email-tony@atomide.com>
	<1187012975431-git-send-email-tony@atomide.com>
	<11870129782148-git-send-email-tony@atomide.com>
	<1187012980445-git-send-email-tony@atomide.com>
	<11870129834092-git-send-email-tony@atomide.com>
	<11870129861917-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11870129861917-git-send-email-tony@atomide.com>
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

Search and replace pDest with dst

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musbdefs.h |    2 +-
 drivers/usb/musb/plat_uds.c |   18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -502,7 +502,7 @@ extern void musb_stop(struct musb *musb);
 extern void musb_write_fifo(struct musb_hw_ep *ep,
 			     u16 wCount, const u8 * src);
 extern void musb_read_fifo(struct musb_hw_ep *ep,
-			       u16 wCount, u8 * pDest);
+			       u16 wCount, u8 * dst);
 
 extern void musb_load_testpacket(struct musb *);
 
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -209,38 +209,38 @@ void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 wCount, const u8 *src)
 /*
  * Unload an endpoint's FIFO
  */
-void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 wCount, u8 *pDest)
+void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 wCount, u8 *dst)
 {
 	void __iomem *fifo = hw_ep->fifo;
 
 	DBG(4, "%cX ep%d fifo %p count %d buf %p\n",
-			'R', hw_ep->bLocalEnd, fifo, wCount, pDest);
+			'R', hw_ep->bLocalEnd, fifo, wCount, dst);
 
 	/* we can't assume unaligned writes work */
-	if (likely((0x01 & (unsigned long) pDest) == 0)) {
+	if (likely((0x01 & (unsigned long) dst) == 0)) {
 		u16	index = 0;
 
 		/* best case is 32bit-aligned destination address */
-		if ((0x02 & (unsigned long) pDest) == 0) {
+		if ((0x02 & (unsigned long) dst) == 0) {
 			if (wCount >= 4) {
-				readsl(fifo, pDest, wCount >> 2);
+				readsl(fifo, dst, wCount >> 2);
 				index = wCount & ~0x03;
 			}
 			if (wCount & 0x02) {
-				*(u16*)&pDest[index] = musb_readw(fifo, 0);
+				*(u16*)&dst[index] = musb_readw(fifo, 0);
 				index += 2;
 			}
 		} else {
 			if (wCount >= 2) {
-				readsw(fifo, pDest, wCount >> 1);
+				readsw(fifo, dst, wCount >> 1);
 				index = wCount & ~0x01;
 			}
 		}
 		if (wCount & 0x01)
-			pDest[index] = musb_readb(fifo, 0);
+			dst[index] = musb_readb(fifo, 0);
 	} else  {
 		/* byte aligned */
-		readsb(fifo, pDest, wCount);
+		readsb(fifo, dst, wCount);
 	}
 }
 
-- 
1.5.2.3
