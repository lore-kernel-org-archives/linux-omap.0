From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [RESEND PATCH 08/11] ARM: OMAP: USB: Change the TLL clock names
Date: Wed, 31 Oct 2012 19:56:49 +0530
Message-ID: <1351693612-23314-9-git-send-email-keshava_mgowda@ti.com>
References: <1351693612-23314-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1351693612-23314-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, sameo@linux.intel.com, b-cousson@ti.com
List-Id: linux-omap@vger.kernel.org

The tll ports clock names are renamed as channel clocks.
This is change is just adhere to TRM words

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
---
 drivers/mfd/omap-usb-tll.c |   46 ++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index f457883..c882d91 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -97,8 +97,8 @@
 #define is_ehci_tll_mode(x)	(x == OMAP_EHCI_PORT_MODE_TLL)
 
 struct usbtll_omap {
-	struct clk				*usbtll_p1_fck;
-	struct clk				*usbtll_p2_fck;
+	struct clk				*usbtll_ch0_clk;
+	struct clk				*usbtll_ch1_clk;
 	void __iomem				*base;
 	enum usbhs_omap_port_mode		port_mode[OMAP3_HS_USB_PORTS];
 
@@ -316,32 +316,32 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 
 	spin_lock_init(&tll->lock);
 
-	tll->usbtll_p1_fck = clk_get(dev, "usb_tll_hs_usb_ch0_clk");
-	if (IS_ERR(tll->usbtll_p1_fck)) {
-		ret = PTR_ERR(tll->usbtll_p1_fck);
-		dev_err(dev, "usbtll_p1_fck failed error:%d\n", ret);
+	tll->usbtll_ch0_clk = clk_get(dev, "usb_tll_hs_usb_ch0_clk");
+	if (IS_ERR(tll->usbtll_ch0_clk)) {
+		ret = PTR_ERR(tll->usbtll_ch0_clk);
+		dev_err(dev, "usb_tll_hs_usb_ch0_clk failed error:%d\n", ret);
 		goto err_tll;
 	}
 
-	tll->usbtll_p2_fck = clk_get(dev, "usb_tll_hs_usb_ch1_clk");
-	if (IS_ERR(tll->usbtll_p2_fck)) {
-		ret = PTR_ERR(tll->usbtll_p2_fck);
-		dev_err(dev, "usbtll_p2_fck failed error:%d\n", ret);
-		goto err_usbtll_p1_fck;
+	tll->usbtll_ch1_clk = clk_get(dev, "usb_tll_hs_usb_ch1_clk");
+	if (IS_ERR(tll->usbtll_ch1_clk)) {
+		ret = PTR_ERR(tll->usbtll_ch1_clk);
+		dev_err(dev, "usb_tll_hs_usb_ch1_clk failed error:%d\n", ret);
+		goto err_usbtll_ch0_clk;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(dev, "usb tll get resource failed\n");
 		ret = -ENODEV;
-		goto err_usbtll_p2_fck;
+		goto err_usbtll_ch1_clk;
 	}
 
 	tll->base = ioremap(res->start, resource_size(res));
 	if (!tll->base) {
 		dev_err(dev, "TLL ioremap failed\n");
 		ret = -ENOMEM;
-		goto err_usbtll_p2_fck;
+		goto err_usbtll_ch1_clk;
 	}
 
 	platform_set_drvdata(pdev, tll);
@@ -349,11 +349,11 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 	tll_pdev = pdev;
 	return 0;
 
-err_usbtll_p2_fck:
-	clk_put(tll->usbtll_p2_fck);
+err_usbtll_ch1_clk:
+	clk_put(tll->usbtll_ch0_clk);
 
-err_usbtll_p1_fck:
-	clk_put(tll->usbtll_p1_fck);
+err_usbtll_ch0_clk:
+	clk_put(tll->usbtll_ch1_clk);
 
 err_tll:
 	kfree(tll);
@@ -370,8 +370,8 @@ static int __devexit usbtll_omap_remove(struct platform_device *pdev)
 {
 	struct usbtll_omap *tll = platform_get_drvdata(pdev);
 
-	clk_put(tll->usbtll_p2_fck);
-	clk_put(tll->usbtll_p1_fck);
+	clk_put(tll->usbtll_ch1_clk);
+	clk_put(tll->usbtll_ch0_clk);
 	pm_runtime_disable(&pdev->dev);
 	kfree(tll);
 	return 0;
@@ -392,10 +392,10 @@ static int usbtll_runtime_resume(struct device *dev)
 	spin_lock_irqsave(&tll->lock, flags);
 
 	if (is_ehci_tll_mode(tll->port_mode[0]))
-		clk_enable(tll->usbtll_p1_fck);
+		clk_enable(tll->usbtll_ch0_clk);
 
 	if (is_ehci_tll_mode(tll->port_mode[1]))
-		clk_enable(tll->usbtll_p2_fck);
+		clk_enable(tll->usbtll_ch1_clk);
 
 	spin_unlock_irqrestore(&tll->lock, flags);
 
@@ -417,10 +417,10 @@ static int usbtll_runtime_suspend(struct device *dev)
 	spin_lock_irqsave(&tll->lock, flags);
 
 	if (is_ehci_tll_mode(tll->port_mode[0]))
-		clk_disable(tll->usbtll_p1_fck);
+		clk_disable(tll->usbtll_ch0_clk);
 
 	if (is_ehci_tll_mode(tll->port_mode[1]))
-		clk_disable(tll->usbtll_p2_fck);
+		clk_disable(tll->usbtll_ch1_clk);
 
 	spin_unlock_irqrestore(&tll->lock, flags);
 
-- 
1.7.9.5

