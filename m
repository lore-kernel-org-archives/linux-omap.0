From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] usb: musb: tusb6010_omap: Do not reset the other direction's packet size
Date: Fri, 12 May 2017 16:48:48 +0300
Message-ID: <20170512134848.468-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: b-liu@ti.com, tony@atomide.com, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We have one register for each EP to set the maximum packet size for both
TX and RX.
If for example an RX programming would happen before the previous TX
transfer finishes we would reset the TX packet side.

To fix this issue, only modify the TX or RX part of the register.

Fixes: 550a7375fe72 ("USB: Add MUSB and TUSB support")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
---
Bin,

I have separated the patch from the tusb DMAengine conversion series and that
will depend on this patch.

Regards,
Peter

 drivers/usb/musb/tusb6010_omap.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index 8b43c4b99f04..7870b37e0ea5 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -219,6 +219,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 	u32				dma_remaining;
 	int				src_burst, dst_burst;
 	u16				csr;
+	u32				psize;
 	int				ch;
 	s8				dmareq;
 	s8				sync_dev;
@@ -390,15 +391,19 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 
 	if (chdat->tx) {
 		/* Send transfer_packet_sz packets at a time */
-		musb_writel(ep_conf, TUSB_EP_MAX_PACKET_SIZE_OFFSET,
-			chdat->transfer_packet_sz);
+		psize = musb_readl(ep_conf, TUSB_EP_MAX_PACKET_SIZE_OFFSET);
+		psize &= ~0x7ff;
+		psize |= chdat->transfer_packet_sz;
+		musb_writel(ep_conf, TUSB_EP_MAX_PACKET_SIZE_OFFSET, psize);
 
 		musb_writel(ep_conf, TUSB_EP_TX_OFFSET,
 			TUSB_EP_CONFIG_XFR_SIZE(chdat->transfer_len));
 	} else {
 		/* Receive transfer_packet_sz packets at a time */
-		musb_writel(ep_conf, TUSB_EP_MAX_PACKET_SIZE_OFFSET,
-			chdat->transfer_packet_sz << 16);
+		psize = musb_readl(ep_conf, TUSB_EP_MAX_PACKET_SIZE_OFFSET);
+		psize &= ~(0x7ff << 16);
+		psize |= (chdat->transfer_packet_sz << 16);
+		musb_writel(ep_conf, TUSB_EP_MAX_PACKET_SIZE_OFFSET, psize);
 
 		musb_writel(ep_conf, TUSB_EP_RX_OFFSET,
 			TUSB_EP_CONFIG_XFR_SIZE(chdat->transfer_len));
-- 
2.13.0
