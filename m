From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 02/10] usb: musb: Add quirk to avoid skb reserve in gadget mode
Date: Wed, 10 May 2017 11:42:24 +0300
Message-ID: <20170510084231.19302-3-peter.ujfalusi@ti.com>
References: <20170510084231.19302-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170510084231.19302-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: b-liu@ti.com, tony@atomide.com, gregkh@linuxfoundation.org, vinod.koul@intel.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

For tusb6010 the DMA functionality only possible if the buffer is 32bit
aligned (SYNC access to FIFO) since with ASYNC access the TX/RX offset
registers will corrupt eventually.
The MUSB_G_NO_SKB_RESERVE will set the quirk_avoids_skb_reserve flag in
usb_gadget struct to provide correctly aligned buffer.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/usb/musb/musb_core.c | 3 +++
 drivers/usb/musb/musb_core.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 870da18f5077..87cbd56cc761 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2224,6 +2224,9 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 		musb->io.ep_select = musb_flat_ep_select;
 	}
 
+	if (musb->io.quirks & MUSB_G_NO_SKB_RESERVE)
+		musb->g.quirk_avoids_skb_reserve = 1;
+
 	/* At least tusb6010 has its own offsets */
 	if (musb->ops->ep_offset)
 		musb->io.ep_offset = musb->ops->ep_offset;
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 3e98d4268a64..9f22c5b8ce37 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -172,6 +172,7 @@ struct musb_io;
  */
 struct musb_platform_ops {
 
+#define MUSB_G_NO_SKB_RESERVE	BIT(9)
 #define MUSB_DA8XX		BIT(8)
 #define MUSB_PRESERVE_SESSION	BIT(7)
 #define MUSB_DMA_UX500		BIT(6)
-- 
2.12.2
