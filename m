From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: RFC: changing DMA slave configuration API
Date: Sun, 10 Jun 2012 11:20:23 +0100
Message-ID: <20120610102023.GC11404@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55540 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561Ab2FJKU3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jun 2012 06:20:29 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

Dan, Vinod,

There's a change I would like to do to the DMA slave configuration.
It's currently a pain to have the source and destination parameters in
the dma_slave_config structure as separate elements; it means when you
want to extract them, you end up with code in DMA engine drivers like:

+	if (dir == DMA_DEV_TO_MEM) {
+		dev_addr = c->src_addr;
+		dev_width = c->src_addr_width;
+		burst = c->src_maxburst;
+	} else if (dir == DMA_MEM_TO_DEV) {
+		dev_addr = c->dst_addr;
+		dev_width = c->dst_addr_width;
+		burst = c->dst_maxburst;
+	}

If we redefine the structure as below, this all becomes more simple:

+	if (dir == DMA_DEV_TO_MEM)
+		cfg = &c->dev_src;
+	else if (dir == DMA_MEM_TO_DEV)
+		cfg = &c->dev_dst;

and then we can access the data through cfg->{element} rather than having
to cache each individual elements value in a local variable.

Thoughts?

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 56377df..e6519f7 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -367,6 +367,18 @@ struct dma_slave_config {
 	bool device_fc;
 };
 
+struct dma_dev_cfg {
+	dma_addr_t addr;
+	enum dma_slave_buswidth width;
+	u32 maxburst;
+};
+
+struct dma_slave_cfg {
+	struct dma_dev_cfg dev_src;
+	struct dma_dev_cfg dev_dst;
+	bool device_fc;
+};
+
 static inline const char *dma_chan_name(struct dma_chan *chan)
 {
 	return dev_name(&chan->dev->device);

