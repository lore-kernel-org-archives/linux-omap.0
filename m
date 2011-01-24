From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH] OMAP: PM: DMA: Enable runtime pm
Date: Mon, 24 Jan 2011 14:50:19 +0530
Message-ID: <1295860819-20142-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40858 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460Ab1AXJVN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 04:21:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, tony@atomide.com

From: Manjunath G Kondaiah <manjugk@ti.com>

Enable runtime pm and use pm_runtime_get_sync and pm_runtime_put
for OMAP DMA driver.

Since DMA driver callback will happen from interrupt context and
DMA client driver will release all DMA resources from interrupt
context itself, pm_runtime_put_sync() cannot be used in DMA driver.
Instead, pm_runtime_put() is used which is asynchronous call and
gets executed in work queue.

Boot tested on OMAP4 blaze and all applicable tests are executed
along with dma hwmod series.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
---
Discussion and alignment for using runtime API's in DMA can be accessed at:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg37819.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg38355.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg38391.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg38400.html

 arch/arm/plat-omap/dma.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index c4b2b47..48ee292 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -35,6 +35,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/pm_runtime.h>
 
 #include <asm/system.h>
 #include <mach/hardware.h>
@@ -58,6 +59,7 @@ enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
 #define OMAP_FUNC_MUX_ARM_BASE		(0xfffe1000 + 0xec)
 
 static struct omap_system_dma_plat_info *p;
+static struct platform_device           *pd;
 static struct omap_dma_dev_attr *d;
 
 static int enable_1510_mode;
@@ -676,6 +678,7 @@ int omap_request_dma(int dev_id, const char *dev_name,
 	unsigned long flags;
 	struct omap_dma_lch *chan;
 
+	pm_runtime_get_sync(&pd->dev);
 	spin_lock_irqsave(&dma_chan_lock, flags);
 	for (ch = 0; ch < dma_chan_count; ch++) {
 		if (free_ch == -1 && dma_chan[ch].dev_id == -1) {
@@ -686,6 +689,7 @@ int omap_request_dma(int dev_id, const char *dev_name,
 	}
 	if (free_ch == -1) {
 		spin_unlock_irqrestore(&dma_chan_lock, flags);
+		pm_runtime_put(&pd->dev);
 		return -EBUSY;
 	}
 	chan = dma_chan + free_ch;
@@ -779,7 +783,7 @@ void omap_free_dma(int lch)
 		p->dma_write(0, CCR, lch);
 		omap_clear_dma(lch);
 	}
-
+	pm_runtime_put(&pd->dev);
 	spin_lock_irqsave(&dma_chan_lock, flags);
 	dma_chan[lch].dev_id = -1;
 	dma_chan[lch].next_lch = -1;
@@ -1979,6 +1983,7 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	pd			= pdev;
 	d			= p->dma_attr;
 	errata			= p->errata;
 
@@ -2000,6 +2005,9 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 		}
 	}
 
+	pm_runtime_enable(&pd->dev);
+	pm_runtime_get_sync(&pd->dev);
+
 	spin_lock_init(&dma_chan_lock);
 	for (ch = 0; ch < dma_chan_count; ch++) {
 		omap_clear_dma(ch);
@@ -2065,6 +2073,14 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
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
 
 exit_dma_irq_fail:
-- 
1.7.1

