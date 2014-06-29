From: Andre Heider <a.heider@gmail.com>
Subject: [PATCH 10/13] uio: uio_pruss: add runtime pm support
Date: Sun, 29 Jun 2014 18:21:44 +0200
Message-ID: <1404058907-21112-11-git-send-email-a.heider@gmail.com>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:54447 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbaF2QWI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Jun 2014 12:22:08 -0400
In-Reply-To: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Matt Porter <mporter@linaro.org>, "Hans J . Koch" <hjk@hansjkoch.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This enables the hwmod's associated clocks and gets the device in a
working state.

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 drivers/uio/uio_pruss.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/uio/uio_pruss.c b/drivers/uio/uio_pruss.c
index 2df54ab..28a1c1f 100644
--- a/drivers/uio/uio_pruss.c
+++ b/drivers/uio/uio_pruss.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/genalloc.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 
 #define DRV_NAME "pruss_uio"
 #define DRV_VERSION "1.0"
@@ -125,6 +126,7 @@ static void pruss_cleanup(struct device *dev, struct uio_pruss_dev *gdev)
 			      gdev->sram_vaddr,
 			      sram_pool_sz);
 	clk_put(gdev->pruss_clk);
+	pm_runtime_disable(dev);
 }
 
 static int pruss_probe(struct platform_device *pdev)
@@ -164,6 +166,13 @@ static int pruss_probe(struct platform_device *pdev)
 		gdev->pintc_base = pdata->pintc_base;
 	}
 
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (IS_ERR_VALUE(ret)) {
+		dev_err(dev, "pm_runtime_get_sync() failed\n");
+		goto out_free;
+	}
+
 	regs_prussio = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	gdev->prussio_vaddr = devm_ioremap_resource(dev, regs_prussio);
 	if (IS_ERR(gdev->prussio_vaddr)) {
-- 
2.0.0

