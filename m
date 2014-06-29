From: Andre Heider <a.heider@gmail.com>
Subject: [PATCH 04/13] uio: uio_pruss: use dmam_alloc_coherent()
Date: Sun, 29 Jun 2014 18:21:38 +0200
Message-ID: <1404058907-21112-5-git-send-email-a.heider@gmail.com>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:64396 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbaF2QWA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Jun 2014 12:22:00 -0400
In-Reply-To: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Matt Porter <mporter@linaro.org>, "Hans J . Koch" <hjk@hansjkoch.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Replace dma_alloc_coherent() with dmam_alloc_coherent() and remove the
dma_free_coherent() call.

This shaves off 2 vars in the driver data struct.

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 drivers/uio/uio_pruss.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/uio/uio_pruss.c b/drivers/uio/uio_pruss.c
index 310598a..50ff206 100644
--- a/drivers/uio/uio_pruss.c
+++ b/drivers/uio/uio_pruss.c
@@ -63,10 +63,8 @@ struct uio_pruss_dev {
 	struct uio_info *info;
 	struct clk *pruss_clk;
 	dma_addr_t sram_paddr;
-	dma_addr_t ddr_paddr;
 	void __iomem *prussio_vaddr;
 	unsigned long sram_vaddr;
-	void *ddr_vaddr;
 	unsigned int hostirq_start;
 	unsigned int pintc_base;
 	struct gen_pool *sram_pool;
@@ -100,10 +98,6 @@ static void pruss_cleanup(struct device *dev, struct uio_pruss_dev *gdev)
 		uio_unregister_device(p);
 		kfree(p->name);
 	}
-	if (gdev->ddr_vaddr) {
-		dma_free_coherent(dev, extram_pool_sz, gdev->ddr_vaddr,
-			gdev->ddr_paddr);
-	}
 	if (gdev->sram_vaddr)
 		gen_pool_free(gdev->sram_pool,
 			      gdev->sram_vaddr,
@@ -119,6 +113,7 @@ static int pruss_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int ret = -ENODEV, cnt = 0;
 	struct uio_pruss_pdata *pdata = dev_get_platdata(dev);
+	dma_addr_t ddr_paddr;
 
 	gdev = devm_kzalloc(dev, sizeof(struct uio_pruss_dev), GFP_KERNEL);
 	if (!gdev)
@@ -155,9 +150,8 @@ static int pruss_probe(struct platform_device *pdev)
 		}
 	}
 
-	gdev->ddr_vaddr = dma_alloc_coherent(dev, extram_pool_sz,
-				&(gdev->ddr_paddr), GFP_KERNEL | GFP_DMA);
-	if (!gdev->ddr_vaddr) {
+	if (!dmam_alloc_coherent(dev, extram_pool_sz, &ddr_paddr,
+				 GFP_KERNEL | GFP_DMA)) {
 		dev_err(dev, "Could not allocate external memory\n");
 		goto out_free;
 	}
@@ -174,7 +168,7 @@ static int pruss_probe(struct platform_device *pdev)
 		p->mem[1].size = sram_pool_sz;
 		p->mem[1].memtype = UIO_MEM_PHYS;
 
-		p->mem[2].addr = gdev->ddr_paddr;
+		p->mem[2].addr = ddr_paddr;
 		p->mem[2].size = extram_pool_sz;
 		p->mem[2].memtype = UIO_MEM_PHYS;
 
-- 
2.0.0

