From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 01/31] dmaengine: PL08x: remove runtime PM support
Date: Thu, 07 Jun 2012 11:46:01 +0100
Message-ID: <E1ScaE5-0003jl-Gx@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54152 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759766Ab2FGKqH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:46:07 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

The runtime PM support conflicts with the generic AMBA bus PM, and also
causes a potential deadlock with the PL011 driver as it results in
interrupts being enabled beneath a spinlock.

I don't presently see any solution to this other than by removing the
runtime PM support entirely from the DMA engine driver.  Alternative
suggestions welcome.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 49ecbbb..5586d9a 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -404,7 +404,6 @@ pl08x_get_phy_channel(struct pl08x_driver_data *pl08x,
 		return NULL;
 	}
 
-	pm_runtime_get_sync(&pl08x->adev->dev);
 	return ch;
 }
 
@@ -418,8 +417,6 @@ static inline void pl08x_put_phy_channel(struct pl08x_driver_data *pl08x,
 	/* Stop the channel and clear its interrupts */
 	pl08x_terminate_phy_chan(pl08x, ch);
 
-	pm_runtime_put(&pl08x->adev->dev);
-
 	/* Mark it as free */
 	ch->serving = NULL;
 	spin_unlock_irqrestore(&ch->lock, flags);
@@ -1851,9 +1848,6 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 		goto out_no_pl08x;
 	}
 
-	pm_runtime_set_active(&adev->dev);
-	pm_runtime_enable(&adev->dev);
-
 	/* Initialize memcpy engine */
 	dma_cap_set(DMA_MEMCPY, pl08x->memcpy.cap_mask);
 	pl08x->memcpy.dev = &adev->dev;
@@ -2007,7 +2001,6 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 		 amba_part(adev), amba_rev(adev),
 		 (unsigned long long)adev->res.start, adev->irq[0]);
 
-	pm_runtime_put(&adev->dev);
 	return 0;
 
 out_no_slave_reg:
@@ -2026,9 +2019,6 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 	dma_pool_destroy(pl08x->pool);
 out_no_lli_pool:
 out_no_platdata:
-	pm_runtime_put(&adev->dev);
-	pm_runtime_disable(&adev->dev);
-
 	kfree(pl08x);
 out_no_pl08x:
 	amba_release_regions(adev);
-- 
1.7.4.4

