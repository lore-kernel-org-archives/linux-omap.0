From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 11/22] mfd: omap-usb-host: Use devm_kzalloc() and devm_request_and_ioremap()
Date: Wed, 2 Jan 2013 17:00:31 +0200
Message-ID: <1357138842-28964-12-git-send-email-rogerq@ti.com>
References: <1357138842-28964-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1357138842-28964-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, sameo@linux.intel.com, tony@atomide.com
Cc: keshava_mgowda@ti.com, sshtylyov@mvista.com, bjorn@mork.no, rogerq@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Use devm_ variants of kzalloc and ioremap. Also clean up error path.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-host.c |   36 +++++++++---------------------------
 1 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 85a4a43..b24a3ab 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -467,17 +467,20 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 
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
@@ -575,20 +578,6 @@ static int usbhs_omap_probe(struct platform_device *pdev)
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
@@ -598,13 +587,10 @@ static int usbhs_omap_probe(struct platform_device *pdev)
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
@@ -628,9 +614,7 @@ err_utmi_p1_fck:
 err_end:
 	clk_put(omap->ehci_logic_fck);
 	pm_runtime_disable(dev);
-	kfree(omap);
 
-end_probe:
 	return ret;
 }
 
@@ -645,7 +629,6 @@ static int usbhs_omap_remove(struct platform_device *pdev)
 	struct usbhs_hcd_omap *omap = platform_get_drvdata(pdev);
 
 	omap_usbhs_deinit(&pdev->dev);
-	iounmap(omap->uhh_base);
 	clk_put(omap->init_60m_fclk);
 	clk_put(omap->usbhost_p2_fck);
 	clk_put(omap->usbhost_p1_fck);
@@ -655,7 +638,6 @@ static int usbhs_omap_remove(struct platform_device *pdev)
 	clk_put(omap->utmi_p1_fck);
 	clk_put(omap->ehci_logic_fck);
 	pm_runtime_disable(&pdev->dev);
-	kfree(omap);
 
 	return 0;
 }
-- 
1.7.4.1
