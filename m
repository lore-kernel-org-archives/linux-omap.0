From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] musb_hdrc: Transfer remaining bytes with PIO
Date: Thu,  3 May 2007 16:41:55 +0000
Message-ID: <11782105222902-git-send-email-tony@atomide.com>
References: musb-2007-05-03-164131
	<11782105181141-git-send-email-tony@atomide.com>
	<11782105222073-git-send-email-tony@atomide.com>
	<11782105223370-git-send-email-tony@atomide.com>
	<11782105221042-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11782105221042-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

DMA callback can manually transfer remaining 1 - 31 bytes
after DMA transfer using PIO. This allows transferring
a wider range of sizes with DMA.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/tusb6010_omap.c |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index 8e864d6..1d9d80f 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -146,7 +146,7 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 	struct musb_hw_ep	*hw_ep = chdat->hw_ep;
 	void __iomem		*ep_conf = hw_ep->conf;
 	void __iomem		*musb_base = musb->pRegs;
-	unsigned long		remaining, flags;
+	unsigned long		remaining, flags, pio;
 	int			ch;
 
 	spin_lock_irqsave(&musb->Lock, flags);
@@ -170,21 +170,25 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 
 	remaining = TUSB_EP_CONFIG_XFR_SIZE(remaining);
 	channel->dwActualLength = chdat->transfer_len - remaining;
+	pio = chdat->len - channel->dwActualLength;
 
 	DBG(2, "DMA remaining %lu/%u\n", remaining, chdat->transfer_len);
 
-	/* Transfer remaining 1 - 31 bytes if DMA worked */
-	if (remaining == 0) {
-		u32	pio;
+	/* Transfer remaining 1 - 31 bytes */
+	if (pio > 0 && pio < 32) {
 		u8	*buf;
 
-		pio = chdat->len - channel->dwActualLength;
-		buf = phys_to_virt((u32)chdat->dma_addr)
-				+ chdat->transfer_len;
-		if (chdat->tx)
+		DBG(2, "Using PIO for remaining %i bytes\n", pio);
+		buf = phys_to_virt((u32)chdat->dma_addr) + chdat->transfer_len;
+		if (chdat->tx) {
+			consistent_sync(phys_to_virt((u32)chdat->dma_addr),
+					chdat->transfer_len, DMA_TO_DEVICE);
 			musb_write_fifo(hw_ep, pio, buf);
-		else
+		} else {
 			musb_read_fifo(hw_ep, pio, buf);
+			consistent_sync(phys_to_virt((u32)chdat->dma_addr),
+					chdat->transfer_len, DMA_FROM_DEVICE);
+		}
 		channel->dwActualLength += pio;
 	}
 
@@ -201,7 +205,7 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 	if (!chdat->tx)
 		musb_dma_completion(musb, chdat->epnum, chdat->tx);
 
-	/* We musb terminate short tx transfers manually by setting TXPKTRDY.
+	/* We must terminate short tx transfers manually by setting TXPKTRDY.
 	 * REVISIT: This same problem may occur with other MUSB dma as well.
 	 * Easy to test with g_ether by pinging the MUSB board with ping -s54.
 	 */
@@ -239,7 +243,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 	s8				dmareq;
 	s8				sync_dev;
 
-	if (unlikely(dma_addr & 0x1) || len < 32)
+	if (unlikely(dma_addr & 0x1) || (len < 32) || (len > packet_sz))
 		return FALSE;
 
 	chdat->transfer_len = len & ~0x1f;
-- 
1.4.4.2
