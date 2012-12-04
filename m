From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 04/23] mfd: omap-usb-tll: Use devm_kzalloc/ioremap and clean up error path
Date: Tue, 4 Dec 2012 16:12:57 +0200
Message-ID: <1354630396-24545-5-git-send-email-rogerq@ti.com>
References: <1354630396-24545-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354630396-24545-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: keshava_mgowda-l0cyMroinI0@public.gmane.org, sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org, bjorn-yOkvZcmFvRU@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Use devm_ variants of kzalloc() and ioremap(). Simplify the error path.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/omap-usb-tll.c |   37 +++++++++++--------------------------
 1 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index e67cafc..828207f 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -215,11 +215,10 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 
 	dev_dbg(dev, "starting TI HSUSB TLL Controller\n");
 
-	tll = kzalloc(sizeof(struct usbtll_omap), GFP_KERNEL);
+	tll = devm_kzalloc(dev, sizeof(struct usbtll_omap), GFP_KERNEL);
 	if (!tll) {
 		dev_err(dev, "Memory allocation failed\n");
-		ret = -ENOMEM;
-		goto end;
+		return -ENOMEM;
 	}
 
 	spin_lock_init(&tll->lock);
@@ -230,28 +229,21 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 	if (IS_ERR(tll->usbtll_p1_fck)) {
 		ret = PTR_ERR(tll->usbtll_p1_fck);
 		dev_err(dev, "usbtll_p1_fck failed error:%d\n", ret);
-		goto err_tll;
+		return ret;
 	}
 
 	tll->usbtll_p2_fck = clk_get(dev, "usb_tll_hs_usb_ch1_clk");
 	if (IS_ERR(tll->usbtll_p2_fck)) {
 		ret = PTR_ERR(tll->usbtll_p2_fck);
 		dev_err(dev, "usbtll_p2_fck failed error:%d\n", ret);
-		goto err_usbtll_p1_fck;
+		goto err_p2_fck;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "usb tll get resource failed\n");
-		ret = -ENODEV;
-		goto err_usbtll_p2_fck;
-	}
-
-	base = ioremap(res->start, resource_size(res));
+	base = devm_request_and_ioremap(dev, res);
 	if (!base) {
-		dev_err(dev, "TLL ioremap failed\n");
-		ret = -ENOMEM;
-		goto err_usbtll_p2_fck;
+		ret = -EADDRNOTAVAIL;
+		goto err_res;
 	}
 
 	platform_set_drvdata(pdev, tll);
@@ -323,23 +315,17 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 	}
 
 	spin_unlock_irqrestore(&tll->lock, flags);
-	iounmap(base);
 	pm_runtime_put_sync(dev);
 	tll_pdev = pdev;
-	if (!ret)
-		goto end;
-	pm_runtime_disable(dev);
 
-err_usbtll_p2_fck:
+	return 0;
+
+err_res:
 	clk_put(tll->usbtll_p2_fck);
 
-err_usbtll_p1_fck:
+err_p2_fck:
 	clk_put(tll->usbtll_p1_fck);
 
-err_tll:
-	kfree(tll);
