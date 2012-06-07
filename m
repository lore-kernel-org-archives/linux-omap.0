From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 04/31] dmaengine: PL08x: remove circular_buffer boolean from
 channel data
Date: Thu, 07 Jun 2012 11:47:02 +0100
Message-ID: <E1ScaF4-0003k1-RZ@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54169 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754267Ab2FGKrJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:47:09 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Circular buffers are not handled in this way; we have a separate API
call now to setup circular buffers.  So lets not mislead people with
this bool.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c   |    7 -------
 include/linux/amba/pl08x.h |    4 ----
 2 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 9c5bae6..5821125 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1701,13 +1701,6 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 				return -ENOMEM;
 			}
 		}
-		if (chan->cd->circular_buffer) {
-			dev_err(&pl08x->adev->dev,
-				"channel %s: circular buffers not supported\n",
-				chan->name);
-			kfree(chan);
-			continue;
-		}
 		dev_dbg(&pl08x->adev->dev,
 			 "initialize virtual channel \"%s\"\n",
 			 chan->name);
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 0254901..0f5b34d 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -51,9 +51,6 @@ enum {
  * can be the address of a FIFO register for burst requests for example.
  * This can be left undefined if the PrimeCell API is used for configuring
  * this.
- * @circular_buffer: whether the buffer passed in is circular and
- * shall simply be looped round round (like a record baby round
- * round round round)
  * @single: the device connected to this channel will request single DMA
  * transfers, not bursts. (Bursts are default.)
  * @periph_buses: the device connected to this channel is accessible via
@@ -66,7 +63,6 @@ struct pl08x_channel_data {
 	u32 muxval;
 	u32 cctl;
 	dma_addr_t addr;
-	bool circular_buffer;
 	bool single;
 	u8 periph_buses;
 };
-- 
1.7.4.4

