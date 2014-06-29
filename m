From: Andre Heider <a.heider@gmail.com>
Subject: [PATCH 02/13] uio: uio_pruss: use devm_kzalloc()
Date: Sun, 29 Jun 2014 18:21:36 +0200
Message-ID: <1404058907-21112-3-git-send-email-a.heider@gmail.com>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:48648 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbaF2QV5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Jun 2014 12:21:57 -0400
In-Reply-To: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Matt Porter <mporter@linaro.org>, "Hans J . Koch" <hjk@hansjkoch.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Replace kzalloc() by devm_kzalloc() and remove the kfree() calls.

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 drivers/uio/uio_pruss.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/uio/uio_pruss.c b/drivers/uio/uio_pruss.c
index c28d6e2..f07545b 100644
--- a/drivers/uio/uio_pruss.c
+++ b/drivers/uio/uio_pruss.c
@@ -109,9 +109,7 @@ static void pruss_cleanup(struct device *dev, struct uio_pruss_dev *gdev)
 		gen_pool_free(gdev->sram_pool,
 			      gdev->sram_vaddr,
 			      sram_pool_sz);
-	kfree(gdev->info);
 	clk_put(gdev->pruss_clk);
-	kfree(gdev);
 }
 
 static int pruss_probe(struct platform_device *pdev)
@@ -123,24 +121,19 @@ static int pruss_probe(struct platform_device *pdev)
 	int ret = -ENODEV, cnt = 0, len;
 	struct uio_pruss_pdata *pdata = dev_get_platdata(dev);
 
-	gdev = kzalloc(sizeof(struct uio_pruss_dev), GFP_KERNEL);
+	gdev = devm_kzalloc(dev, sizeof(struct uio_pruss_dev), GFP_KERNEL);
 	if (!gdev)
 		return -ENOMEM;
 
-	gdev->info = kzalloc(sizeof(*p) * MAX_PRUSS_EVT, GFP_KERNEL);
-	if (!gdev->info) {
-		kfree(gdev);
+	gdev->info = devm_kzalloc(dev, sizeof(*p) * MAX_PRUSS_EVT, GFP_KERNEL);
+	if (!gdev->info)
 		return -ENOMEM;
-	}
 
 	/* Power on PRU in case its not done as part of boot-loader */
 	gdev->pruss_clk = clk_get(dev, "pruss");
 	if (IS_ERR(gdev->pruss_clk)) {
 		dev_err(dev, "Failed to get clock\n");
-		ret = PTR_ERR(gdev->pruss_clk);
-		kfree(gdev->info);
-		kfree(gdev);
-		return ret;
+		return PTR_ERR(gdev->pruss_clk);
 	} else {
 		clk_enable(gdev->pruss_clk);
 	}
-- 
2.0.0

