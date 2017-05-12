From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 4/9] usb: musb: tusb6010_omap: Use one musb_ep_select call in tusb_omap_dma_program
Date: Fri, 12 May 2017 16:57:47 +0300
Message-ID: <20170512135752.1800-5-peter.ujfalusi@ti.com>
References: <20170512135752.1800-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170512135752.1800-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: b-liu@ti.com, tony@atomide.com, gregkh@linuxfoundation.org, vinod.koul@intel.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Having one musb_ep_select() instead the two calls in if/else is the same
thing, but makes the code a bit simpler to follow.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/tusb6010_omap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index 7870b37e0ea5..025b52e0b34d 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -368,15 +368,14 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 	/*
 	 * Prepare MUSB for DMA transfer
 	 */
+	musb_ep_select(mbase, chdat->epnum);
 	if (chdat->tx) {
-		musb_ep_select(mbase, chdat->epnum);
 		csr = musb_readw(hw_ep->regs, MUSB_TXCSR);
 		csr |= (MUSB_TXCSR_AUTOSET | MUSB_TXCSR_DMAENAB
 			| MUSB_TXCSR_DMAMODE | MUSB_TXCSR_MODE);
 		csr &= ~MUSB_TXCSR_P_UNDERRUN;
 		musb_writew(hw_ep->regs, MUSB_TXCSR, csr);
 	} else {
-		musb_ep_select(mbase, chdat->epnum);
 		csr = musb_readw(hw_ep->regs, MUSB_RXCSR);
 		csr |= MUSB_RXCSR_DMAENAB;
 		csr &= ~(MUSB_RXCSR_AUTOCLEAR | MUSB_RXCSR_DMAMODE);
-- 
2.13.0
