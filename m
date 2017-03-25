From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 2/7] usb: dwc3: dwc3-omap: fix dwc3_omap_probe() do put_sync when get_sync works
Date: Fri, 24 Mar 2017 18:05:00 -0600
Message-ID: <a7d3539cdb21ef9694869f97a357ce40ace0ddd3.1490387086.git.shuahkh@osg.samsung.com>
References: <cover.1490387086.git.shuahkh@osg.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <cover.1490387086.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1490387086.git.shuahkh@osg.samsung.com>
References: <cover.1490387086.git.shuahkh@osg.samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, kgene@kernel.org, krzk@kernel.org, javier@osg.samsung.com
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

dwc3_omap_probe() does pm_runtime_put_sync() in its err1 handling when
pm_runtime_get_sync() fails.  Fix it to do put_sync only when get_sync
succeeds.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/usb/dwc3/dwc3-omap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 2092e46..55b12a9 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -518,25 +518,26 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(dev, "failed to request IRQ #%d --> %d\n",
 				omap->irq, ret);
-		goto err1;
+		goto put_sync;
 	}
 
 	ret = dwc3_omap_extcon_register(omap);
 	if (ret < 0)
-		goto err1;
+		goto put_sync;
 
 	ret = of_platform_populate(node, NULL, NULL, dev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to create dwc3 core\n");
-		goto err1;
+		goto put_sync;
 	}
 
 	dwc3_omap_enable_irqs(omap);
 	enable_irq(omap->irq);
 	return 0;
 
-err1:
+put_sync:
 	pm_runtime_put_sync(dev);
+err1:
 	pm_runtime_disable(dev);
 
 	return ret;
-- 
2.7.4
