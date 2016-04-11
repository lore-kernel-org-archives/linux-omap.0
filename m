From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/2] usb: dwc3: omap: fix up error path on probe()
Date: Mon, 11 Apr 2016 17:12:33 +0300
Message-ID: <1460383954-3240-2-git-send-email-rogerq@ti.com>
References: <1460383954-3240-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460383954-3240-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org
Cc: nsekhar@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <balbi@kernel.org>

Even if pm_runtime_get*() fails, we *MUST* call
pm_runtime_put_sync() before disabling PM.

While at it, remove superfluous dwc3_omap_disable_irqs()
in error path.

Signed-off-by: Felipe Balbi <balbi@kernel.org>
[nsekhar@ti.com: patch description updates]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/dwc3-omap.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 22e9606..55da2c7 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -496,7 +496,7 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
 		dev_err(dev, "get_sync failed with err %d\n", ret);
-		goto err0;
+		goto err1;
 	}
 
 	dwc3_omap_map_offset(omap);
@@ -516,28 +516,24 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 
 	ret = dwc3_omap_extcon_register(omap);
 	if (ret < 0)
-		goto err2;
+		goto err1;
 
 	ret = of_platform_populate(node, NULL, NULL, dev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to create dwc3 core\n");
-		goto err3;
+		goto err2;
 	}
 
 	dwc3_omap_enable_irqs(omap);
 
 	return 0;
 
-err3:
+err2:
 	extcon_unregister_notifier(omap->edev, EXTCON_USB, &omap->vbus_nb);
 	extcon_unregister_notifier(omap->edev, EXTCON_USB_HOST, &omap->id_nb);
-err2:
-	dwc3_omap_disable_irqs(omap);
 
 err1:
 	pm_runtime_put_sync(dev);
-
-err0:
 	pm_runtime_disable(dev);
 
 	return ret;
-- 
2.5.0
