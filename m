From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 11/22] mfd: omap-usb-host: Use devm_kzalloc() and devm_request_and_ioremap()
Date: Wed, 28 Nov 2012 16:48:59 +0200
Message-ID: <1354114150-11941-12-git-send-email-rogerq@ti.com>
References: <1354114150-11941-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354114150-11941-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: keshava_mgowda-l0cyMroinI0@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Use devm_ variants of kzalloc and ioremap. Also clean up error path.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/omap-usb-host.c |   36 +++++++++---------------------------
 1 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index ffd2013..afa0ff6 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -465,17 +465,20 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 
 	if (!pdata) {
 		dev_err(dev, "Missing platform data\n");
-		ret = -ENOMEM;
-		goto end_probe;
+		return -ENODEV;
 	}
 
-	omap = kzalloc(sizeof(*omap), GFP_KERNEL);
+	omap = devm_kzalloc(dev, sizeof(*omap), GFP_KERNEL);
 	if (!omap) {
 		dev_err(dev, "Memory allocation failed\n");
-		ret = -ENOMEM;
-		goto end_probe;
+		return -ENOMEM;
 	}
 
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "uhh");
+	omap->uhh_base = devm_request_and_ioremap(dev, res);
+	if (!omap->uhh_base)
+		return -EADDRNOTAVAIL;
+
 	spin_lock_init(&omap->lock);
 
 	omap->pdata = pdata;
@@ -573,20 +576,6 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 				"failed error:%d\n", ret);
 	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "uhh");
-	if (!res) {
-		dev_err(dev, "UHH EHCI get resource failed\n");
-		ret = -ENODEV;
-		goto err_init_60m_fclk;
-	}
-
-	omap->uhh_base = ioremap(res->start, resource_size(res));
-	if (!omap->uhh_base) {
-		dev_err(dev, "UHH ioremap failed\n");
-		ret = -ENOMEM;
-		goto err_init_60m_fclk;
-	}
-
 	platform_set_drvdata(pdev, omap);
 
 	omap_usbhs_init(dev);
@@ -596,13 +585,10 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 		goto err_alloc;
 	}
 
-	goto end_probe;
+	return 0;
 
 err_alloc:
 	omap_usbhs_deinit(&pdev->dev);
-	iounmap(omap->uhh_base);
-
-err_init_60m_fclk:
 	clk_put(omap->init_60m_fclk);
 
 err_usbhost_p2_fck:
@@ -626,9 +612,7 @@ err_utmi_p1_fck:
 err_end:
 	clk_put(omap->ehci_logic_fck);
 	pm_runtime_disable(dev);
-	kfree(omap);
 
-end_probe:
 	return ret;
 }
 
@@ -643,7 +627,6 @@ static int __devexit usbhs_omap_remove(struct platform_device *pdev)
 	struct usbhs_hcd_omap *omap = platform_get_drvdata(pdev);
 
 	omap_usbhs_deinit(&pdev->dev);
-	iounmap(omap->uhh_base);
 	clk_put(omap->init_60m_fclk);
 	clk_put(omap->usbhost_p2_fck);
 	clk_put(omap->usbhost_p1_fck);
@@ -653,7 +636,6 @@ static int __devexit usbhs_omap_remove(struct platform_device *pdev)
 	clk_put(omap->utmi_p1_fck);
 	clk_put(omap->ehci_logic_fck);
 	pm_runtime_disable(&pdev->dev);
-	kfree(omap);
 
 	return 0;
 }
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
