From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 09/31] dmaengine: PL08x: get rid of device_fc in struct
 pl08x_dma_chan
Date: Thu, 07 Jun 2012 11:48:45 +0100
Message-ID: <E1ScaGj-0003kV-09@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54189 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760567Ab2FGKsu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:48:50 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

As we now store the dma_slave_config in pl08x_dma_chan, we don't need
to store this separately.  Use the one in dma_slave_config directly.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 31447db..7eb0e8e 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -226,9 +226,6 @@ enum pl08x_dma_chan_state {
  * @host: a pointer to the host (internal use)
  * @state: whether the channel is idle, paused, running etc
  * @slave: whether this channel is a device (slave) or for memcpy
- * @device_fc: Flow Controller Settings for ccfg register. Only valid for slave
- * channels. Fill with 'true' if peripheral should be flow controller. Direction
- * will be selected at Runtime.
  * @waiting: a TX descriptor on this channel which is waiting for a physical
  * channel to become available
  */
@@ -249,7 +246,6 @@ struct pl08x_dma_chan {
 	struct pl08x_driver_data *host;
 	enum pl08x_dma_chan_state state;
 	bool slave;
-	bool device_fc;
 	struct pl08x_txd *waiting;
 };
 
@@ -1261,8 +1257,6 @@ static int dma_set_runtime_config(struct dma_chan *chan,
 	cctl |= burst << PL080_CONTROL_SB_SIZE_SHIFT;
 	cctl |= burst << PL080_CONTROL_DB_SIZE_SHIFT;
 
-	plchan->device_fc = config->device_fc;
-
 	if (plchan->runtime_direction == DMA_DEV_TO_MEM) {
 		plchan->src_cctl = pl08x_cctl(cctl) | PL080_CONTROL_DST_INCR |
 			pl08x_select_bus(plchan->cd->periph_buses,
@@ -1492,7 +1486,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 		return NULL;
 	}
 
-	if (plchan->device_fc)
+	if (plchan->cfg.device_fc)
 		tmp = (direction == DMA_MEM_TO_DEV) ? PL080_FLOW_MEM2PER_PER :
 			PL080_FLOW_PER2MEM_PER;
 	else
-- 
1.7.4.4

