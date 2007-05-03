From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] musb_hdrc: Allow tusb dma to transfer various data sizes
Date: Thu,  3 May 2007 16:41:54 +0000
Message-ID: <11782105221042-git-send-email-tony@atomide.com>
References: musb-2007-05-03-164131
	<11782105181141-git-send-email-tony@atomide.com>
	<11782105222073-git-send-email-tony@atomide.com>
	<11782105223370-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11782105223370-git-send-email-tony@atomide.com>
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

With this patch tusb can transfer sizes that are not
multiples of 32 bytes.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/tusb6010_omap.c |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index 07f9efe..8e864d6 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -171,7 +171,22 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 	remaining = TUSB_EP_CONFIG_XFR_SIZE(remaining);
 	channel->dwActualLength = chdat->transfer_len - remaining;
 
-	DBG(2, "remaining %lu/%u\n", remaining, chdat->transfer_len);
+	DBG(2, "DMA remaining %lu/%u\n", remaining, chdat->transfer_len);
+
+	/* Transfer remaining 1 - 31 bytes if DMA worked */
+	if (remaining == 0) {
+		u32	pio;
+		u8	*buf;
+
+		pio = chdat->len - channel->dwActualLength;
+		buf = phys_to_virt((u32)chdat->dma_addr)
+				+ chdat->transfer_len;
+		if (chdat->tx)
+			musb_write_fifo(hw_ep, pio, buf);
+		else
+			musb_read_fifo(hw_ep, pio, buf);
+		channel->dwActualLength += pio;
+	}
 
 	if (!dmareq_works())
 		tusb_omap_free_shared_dmareq(chdat);
@@ -224,14 +239,10 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 	s8				dmareq;
 	s8				sync_dev;
 
-	if (unlikely(dma_addr & 0x1))
-		return FALSE;
-	if (len < 32)
-		return FALSE;
-	if ((len % 32 != 0))
+	if (unlikely(dma_addr & 0x1) || len < 32)
 		return FALSE;
-	else
-		chdat->transfer_len = len;
+
+	chdat->transfer_len = len & ~0x1f;
 
 	if (len < packet_sz)
 		chdat->transfer_packet_sz = chdat->transfer_len;
-- 
1.4.4.2
