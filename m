From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v5 14/14] OMAP: PM: DMA: Enable runtime pm
Date: Wed, 24 Nov 2010 18:21:50 +0530
Message-ID: <1290603110-14119-15-git-send-email-manjugk@ti.com>
References: <1290603110-14119-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50349 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753998Ab0KXMxJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 07:53:09 -0500
In-Reply-To: <1290603110-14119-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>

Enable runtime pm and use pm_runtime_get_sync and pm_runtime_put
for OMAP DMA driver.

Since DMA driver callback will happen from interrupt context and
DMA client driver will release all DMA resources from interrupt
context itself, pm_runtime_put_sync() cannot be used in DMA driver.
Instead, pm_runtime_put() is used which is asynchronous call and
gets executed in work queue.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/plat-omap/dma.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index a859c70..527ebfc 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -32,6 +32,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/pm_runtime.h>
 
 #include <plat/dma.h>
 #include <plat/tc.h>
@@ -302,6 +303,7 @@ int omap_request_dma(int dev_id, const char *dev_name,
 	unsigned long flags;
 	struct omap_dma_lch *chan;
 
+	pm_runtime_get_sync(&pd->dev);
 	spin_lock_irqsave(&dma_chan_lock, flags);
 	for (ch = 0; ch < dma_chan_count; ch++) {
 		if (free_ch == -1 && dma_chan[ch].dev_id == -1) {
@@ -312,6 +314,7 @@ int omap_request_dma(int dev_id, const char *dev_name,
 	}
 	if (free_ch == -1) {
 		spin_unlock_irqrestore(&dma_chan_lock, flags);
+		pm_runtime_put(&pd->dev);
 		return -EBUSY;
 	}
 	chan = dma_chan + free_ch;
@@ -403,6 +406,7 @@ void omap_free_dma(int lch)
 		omap_clear_dma(lch);
 		p->clear_sglist_mode(lch);
 	}
+	pm_runtime_put(&pd->dev);
 	spin_lock_irqsave(&dma_chan_lock, flags);
 	dma_chan[lch].dev_id = -1;
 	dma_chan[lch].next_lch = -1;
@@ -734,6 +738,9 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 	dma_chan		= d->chan;
 	enable_1510_mode	= d->dev_caps & ENABLE_1510_MODE;
 
+	pm_runtime_enable(&pd->dev);
+	pm_runtime_get_sync(&pd->dev);
+
 	spin_lock_init(&dma_chan_lock);
 	for (ch = 0; ch < dma_chan_count; ch++) {
 		unsigned long flags;
@@ -760,6 +767,14 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 		dma_chan[1].dev_id = 1;
 	}
 	p->show_dma_caps();
+
+	/*
+	 * Note: If dma channels are reserved through boot paramters,
+	 * then dma device is always enabled.
+	 */
+	if (!omap_dma_reserve_channels)
+		pm_runtime_put(&pd->dev);
+
 	return 0;
 }
 
-- 
1.7.1

