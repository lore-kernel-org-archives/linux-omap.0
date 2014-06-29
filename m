From: Andre Heider <a.heider@gmail.com>
Subject: [PATCH 03/13] uio: uio_pruss: use devm_ioremap_resource()
Date: Sun, 29 Jun 2014 18:21:37 +0200
Message-ID: <1404058907-21112-4-git-send-email-a.heider@gmail.com>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:42134 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbaF2QV7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Jun 2014 12:21:59 -0400
In-Reply-To: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Matt Porter <mporter@linaro.org>, "Hans J . Koch" <hjk@hansjkoch.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Replace resource_size() followed by ioremap() with
devm_ioremap_resource() and remove the iounmap() call.

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 drivers/uio/uio_pruss.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/uio/uio_pruss.c b/drivers/uio/uio_pruss.c
index f07545b..310598a 100644
--- a/drivers/uio/uio_pruss.c
+++ b/drivers/uio/uio_pruss.c
@@ -100,7 +100,6 @@ static void pruss_cleanup(struct device *dev, struct uio_pruss_dev *gdev)
 		uio_unregister_device(p);
 		kfree(p->name);
 	}
-	iounmap(gdev->prussio_vaddr);
 	if (gdev->ddr_vaddr) {
 		dma_free_coherent(dev, extram_pool_sz, gdev->ddr_vaddr,
 			gdev->ddr_paddr);
@@ -118,7 +117,7 @@ static int pruss_probe(struct platform_device *pdev)
 	struct uio_pruss_dev *gdev;
 	struct resource *regs_prussio;
 	struct device *dev = &pdev->dev;
-	int ret = -ENODEV, cnt = 0, len;
+	int ret = -ENODEV, cnt = 0;
 	struct uio_pruss_pdata *pdata = dev_get_platdata(dev);
 
 	gdev = devm_kzalloc(dev, sizeof(struct uio_pruss_dev), GFP_KERNEL);
@@ -139,13 +138,9 @@ static int pruss_probe(struct platform_device *pdev)
 	}
 
 	regs_prussio = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!regs_prussio) {
-		dev_err(dev, "No PRUSS I/O resource specified\n");
-		goto out_free;
-	}
-
-	if (!regs_prussio->start) {
-		dev_err(dev, "Invalid memory resource\n");
+	gdev->prussio_vaddr = devm_ioremap_resource(dev, regs_prussio);
+	if (IS_ERR(gdev->prussio_vaddr)) {
+		ret = PTR_ERR(gdev->prussio_vaddr);
 		goto out_free;
 	}
 
@@ -167,13 +162,6 @@ static int pruss_probe(struct platform_device *pdev)
 		goto out_free;
 	}
 
-	len = resource_size(regs_prussio);
-	gdev->prussio_vaddr = ioremap(regs_prussio->start, len);
-	if (!gdev->prussio_vaddr) {
-		dev_err(dev, "Can't remap PRUSS I/O  address range\n");
-		goto out_free;
-	}
-
 	gdev->pintc_base = pdata->pintc_base;
 	gdev->hostirq_start = platform_get_irq(pdev, 0);
 
-- 
2.0.0

