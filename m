From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 11/31] dmaengine: PL08x: extract function to to generate cctl
 values
Date: Thu, 07 Jun 2012 11:49:25 +0100
Message-ID: <E1ScaHN-0003kh-Qy@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54197 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760587Ab2FGKta (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:49:30 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Extract the functionality from dma_slave_config to generate the cctl
values for a given bus width and burst size.  This allows us to use
this elsewhere in the driver, namely the prepare functions.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   53 +++++++++++++++++++++++++++------------------
 1 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index bd51a44..fde801f 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1207,14 +1207,40 @@ static u32 pl08x_burst(u32 maxburst)
 	return burst_sizes[i].reg;
 }
 
+static u32 pl08x_get_cctl(struct pl08x_dma_chan *plchan,
+	enum dma_slave_buswidth addr_width, u32 maxburst)
+{
+	u32 width, burst, cctl = 0;
+
+	width = pl08x_width(addr_width);
+	if (width == ~0)
+		return ~0;
+
+	cctl |= width << PL080_CONTROL_SWIDTH_SHIFT;
+	cctl |= width << PL080_CONTROL_DWIDTH_SHIFT;
+
+	/*
+	 * If this channel will only request single transfers, set this
+	 * down to ONE element.  Also select one element if no maxburst
+	 * is specified.
+	 */
+	if (plchan->cd->single)
+		maxburst = 1;
+
+	burst = pl08x_burst(maxburst);
+	cctl |= burst << PL080_CONTROL_SB_SIZE_SHIFT;
+	cctl |= burst << PL080_CONTROL_DB_SIZE_SHIFT;
+
+	return pl08x_cctl(cctl);
+}
+
 static int dma_set_runtime_config(struct dma_chan *chan,
 				  struct dma_slave_config *config)
 {
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
 	struct pl08x_driver_data *pl08x = plchan->host;
 	enum dma_slave_buswidth addr_width;
-	u32 width, burst, maxburst;
-	u32 cctl = 0;
+	u32 maxburst, cctl = 0;
 
 	if (!plchan->slave)
 		return -EINVAL;
@@ -1233,8 +1259,8 @@ static int dma_set_runtime_config(struct dma_chan *chan,
 		return -EINVAL;
 	}
 
-	width = pl08x_width(addr_width);
-	if (width == ~0) {
+	cctl = pl08x_get_cctl(plchan, addr_width, maxburst);
+	if (cctl == ~0) {
 		dev_err(&pl08x->adev->dev,
 			"bad runtime_config: alien address width\n");
 		return -EINVAL;
@@ -1242,25 +1268,10 @@ static int dma_set_runtime_config(struct dma_chan *chan,
 
 	plchan->cfg = *config;
 
-	cctl |= width << PL080_CONTROL_SWIDTH_SHIFT;
-	cctl |= width << PL080_CONTROL_DWIDTH_SHIFT;
-
-	/*
-	 * If this channel will only request single transfers, set this
-	 * down to ONE element.  Also select one element if no maxburst
-	 * is specified.
-	 */
-	if (plchan->cd->single)
-		maxburst = 1;
-
-	burst = pl08x_burst(maxburst);
-	cctl |= burst << PL080_CONTROL_SB_SIZE_SHIFT;
-	cctl |= burst << PL080_CONTROL_DB_SIZE_SHIFT;
-
 	if (plchan->runtime_direction == DMA_DEV_TO_MEM) {
-		plchan->src_cctl = pl08x_cctl(cctl);
+		plchan->src_cctl = cctl;
 	} else {
-		plchan->dst_cctl = pl08x_cctl(cctl);
+		plchan->dst_cctl = cctl;
 	}
 
 	dev_dbg(&pl08x->adev->dev,
-- 
1.7.4.4

