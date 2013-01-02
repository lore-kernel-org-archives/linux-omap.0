From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 03/22] mfd: omap-usb-tll: Use devm_kzalloc/ioremap and
 clean up error path
Date: Wed, 2 Jan 2013 17:00:23 +0200
Message-ID: <1357138842-28964-4-git-send-email-rogerq@ti.com>
References: <1357138842-28964-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1357138842-28964-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com, sameo@linux.intel.com, tony@atomide.com
Cc: sshtylyov@mvista.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, keshava_mgowda@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, bjorn@mork.no, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Use devm_ variants of kzalloc() and ioremap(). Simplify the error path.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-tll.c |   37 +++++++++++--------------------------
 1 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 5d5595b..e225cbc 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -215,11 +215,10 @@ static int usbtll_omap_probe(struct platform_device *pdev)
 
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
@@ -230,28 +229,21 @@ static int usbtll_omap_probe(struct platform_device *pdev)
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
@@ -323,23 +315,17 @@ static int usbtll_omap_probe(struct platform_device *pdev)
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
-
-end:
 	return ret;
 }
 
@@ -356,7 +342,6 @@ static int usbtll_omap_remove(struct platform_device *pdev)
 	clk_put(tll->usbtll_p2_fck);
 	clk_put(tll->usbtll_p1_fck);
 	pm_runtime_disable(&pdev->dev);
-	kfree(tll);
 	return 0;
 }
 
-- 
1.7.4.1
