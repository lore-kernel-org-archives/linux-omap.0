From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] musb_hdrc: DMA RX workaround for tusb6010
Date: Thu,  3 May 2007 16:41:56 +0000
Message-ID: <11782105231172-git-send-email-tony@atomide.com>
References: musb-2007-05-03-164131
	<11782105181141-git-send-email-tony@atomide.com>
	<11782105222073-git-send-email-tony@atomide.com>
	<11782105223370-git-send-email-tony@atomide.com>
	<11782105221042-git-send-email-tony@atomide.com>
	<11782105222902-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11782105222902-git-send-email-tony@atomide.com>
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

Async RX DMA on tusb6010 will eventually corrupt the XFR_SIZE
register. This patch blocks DMA transfers for async RX DMA.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/tusb6010_omap.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index 1d9d80f..1ca6a3a 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -169,6 +169,13 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 		remaining = musb_readl(ep_conf, TUSB_EP_RX_OFFSET);
 
 	remaining = TUSB_EP_CONFIG_XFR_SIZE(remaining);
+
+	/* HW issue #10: XFR_SIZE may get corrupt on async DMA */
+	if (unlikely(remaining > chdat->transfer_len)) {
+		WARN("Corrupt XFR_SIZE with async DMA: %lu\n", remaining);
+		remaining = 0;
+	}
+
 	channel->dwActualLength = chdat->transfer_len - remaining;
 	pio = chdat->len - channel->dwActualLength;
 
@@ -246,6 +253,15 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 	if (unlikely(dma_addr & 0x1) || (len < 32) || (len > packet_sz))
 		return FALSE;
 
+	/*
+	 * HW issue #10: Async dma will eventually corrupt the XFR_SIZE
+	 * register which will cause missed DMA interrupt. We could try to
+	 * use a timer for the callback, but it is unsafe as the XFR_SIZE
+	 * register is corrupt, and we won't know if the DMA worked.
+	 */
+	if (dma_addr & 0x2)
+		return FALSE;
+
 	chdat->transfer_len = len & ~0x1f;
 
 	if (len < packet_sz)
-- 
1.4.4.2
