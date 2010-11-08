From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v4 13/13] OMAP: PM: DMA: Enable runtime pm
Date: Mon,  8 Nov 2010 19:37:52 +0530
Message-ID: <1289225272-9767-14-git-send-email-manjugk@ti.com>
References: <1289225272-9767-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57506 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754371Ab0KHOIO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 09:08:14 -0500
In-Reply-To: <1289225272-9767-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Enable runtime pm and use pm_runtime_get and pm_runtime_put
for OMAP DMA driver.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/dma.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 51b6a71..6eb760c 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -35,6 +35,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/pm_runtime.h>
 
 #include <asm/system.h>
 #include <mach/hardware.h>
@@ -330,6 +331,8 @@ int omap_request_dma(int dev_id, const char *dev_name,
 	chan = dma_chan + free_ch;
 	chan->dev_id = dev_id;
 
+	pm_runtime_get(&pd->dev);
+
 	if (d->dev_caps & IS_WORD_16)
 		p->clear_lch_regs(free_ch);
 	else
@@ -415,6 +418,7 @@ void omap_free_dma(int lch)
 		omap_clear_dma(lch);
 		p->clear_dma_sglist_mode(lch);
 	}
+	pm_runtime_put(&pd->dev);
 	spin_lock_irqsave(&dma_chan_lock, flags);
 	dma_chan[lch].dev_id = -1;
 	dma_chan[lch].next_lch = -1;
@@ -782,6 +786,11 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 	dma_chan_count		= d->chan_count;
 	dma_chan		= d->chan;
 
+	/* Enable run time PM */
+	pm_runtime_enable(&pd->dev);
+
+	/* Accessing hw registers, get clock */
+	pm_runtime_get(&pd->dev);
 	for (ch = 0; ch < dma_chan_count; ch++) {
 		unsigned long flags;
 		omap_clear_dma(ch);
@@ -809,6 +818,10 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 		dma_chan[0].dev_id = 0;
 		dma_chan[1].dev_id = 1;
 	}
+
+	if (!omap_dma_reserve_channels)
+		pm_runtime_put(&pd->dev);
+
 	return 0;
 
 exit_release_region:
-- 
1.7.1

