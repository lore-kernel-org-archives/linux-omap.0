From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 02/16] mfd: omap-usb-tll: Clean up clock handling
Date: Thu, 15 Nov 2012 16:34:00 +0200
Message-ID: <1352990054-14680-3-git-send-email-rogerq@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45642 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767985Ab2KOOeT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 09:34:19 -0500
In-Reply-To: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, rogerq@ti.com

Every channel has a functional clock that is similarly named.
It makes sense to use a for loop to manage these clocks as OMAPs
can come with upto 3 channels.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-tll.c |  130 +++++++++++++++++++++++++-------------------
 1 files changed, 74 insertions(+), 56 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index d1750a4..943ac14 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -82,8 +82,12 @@
 #define	OMAP_TLL_ULPI_DEBUG(num)			(0x815 + 0x100 * num)
 #define	OMAP_TLL_ULPI_SCRATCH_REGISTER(num)		(0x816 + 0x100 * num)
 
-#define OMAP_REV2_TLL_CHANNEL_COUNT			2
-#define OMAP_TLL_CHANNEL_COUNT				3
+#define REV2_TLL_CHANNEL_COUNT				2
+#define DEFAULT_TLL_CHANNEL_COUNT			3
+
+/* Update if any chip has more */
+#define MAX_TLL_CHANNEL_COUNT				3
+
 #define OMAP_TLL_CHANNEL_1_EN_MASK			(1 << 0)
 #define OMAP_TLL_CHANNEL_2_EN_MASK			(1 << 1)
 #define OMAP_TLL_CHANNEL_3_EN_MASK			(1 << 2)
@@ -96,8 +100,9 @@
 #define is_ehci_tll_mode(x)	(x == OMAP_EHCI_PORT_MODE_TLL)
 
 struct usbtll_omap {
-	struct clk				*usbtll_p1_fck;
-	struct clk				*usbtll_p2_fck;
+	void __iomem				*base;
+	int					nch;	/* number of channels */
+	struct clk				*ch_clk[MAX_TLL_CHANNEL_COUNT];
 	struct usbtll_omap_platform_data	*pdata;
 	/* secure the register updates */
 	spinlock_t				lock;
@@ -210,49 +215,35 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 	unsigned				reg;
 	unsigned long				flags;
 	int					ret = 0;
-	int					i, ver, count;
+	int					i, ver;
 
 	dev_dbg(dev, "starting TI HSUSB TLL Controller\n");
 
 	tll = kzalloc(sizeof(struct usbtll_omap), GFP_KERNEL);
 	if (!tll) {
 		dev_err(dev, "Memory allocation failed\n");
-		ret = -ENOMEM;
-		goto end;
+		return -ENOMEM;
 	}
 
 	spin_lock_init(&tll->lock);
 
 	tll->pdata = pdata;
 
-	tll->usbtll_p1_fck = clk_get(dev, "usb_tll_hs_usb_ch0_clk");
-	if (IS_ERR(tll->usbtll_p1_fck)) {
-		ret = PTR_ERR(tll->usbtll_p1_fck);
-		dev_err(dev, "usbtll_p1_fck failed error:%d\n", ret);
-		goto err_tll;
-	}
-
-	tll->usbtll_p2_fck = clk_get(dev, "usb_tll_hs_usb_ch1_clk");
-	if (IS_ERR(tll->usbtll_p2_fck)) {
-		ret = PTR_ERR(tll->usbtll_p2_fck);
-		dev_err(dev, "usbtll_p2_fck failed error:%d\n", ret);
-		goto err_usbtll_p1_fck;
-	}
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(dev, "usb tll get resource failed\n");
 		ret = -ENODEV;
-		goto err_usbtll_p2_fck;
+		goto err_mem;
 	}
 
 	base = ioremap(res->start, resource_size(res));
 	if (!base) {
 		dev_err(dev, "TLL ioremap failed\n");
 		ret = -ENOMEM;
-		goto err_usbtll_p2_fck;
+		goto err_mem;
 	}
 
+	tll->base = base;
 	platform_set_drvdata(pdev, tll);
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
@@ -262,16 +253,33 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 	ver =  usbtll_read(base, OMAP_USBTLL_REVISION);
 	switch (ver) {
 	case OMAP_USBTLL_REV1:
-	case OMAP_USBTLL_REV2:
-		count = OMAP_TLL_CHANNEL_COUNT;
+		tll->nch = DEFAULT_TLL_CHANNEL_COUNT;
 		break;
+	case OMAP_USBTLL_REV2:
 	case OMAP_USBTLL_REV3:
-		count = OMAP_REV2_TLL_CHANNEL_COUNT;
+		tll->nch = REV2_TLL_CHANNEL_COUNT;
 		break;
 	default:
-		dev_err(dev, "TLL version failed\n");
-		ret = -ENODEV;
-		goto err_ioremap;
+		tll->nch = DEFAULT_TLL_CHANNEL_COUNT;
+		dev_info(dev,
+		 "USB TLL Rev : 0x%x not recognized, assuming %d channels\n",
+			ver, tll->nch);
+		break;
+	}
+
+	for (i = 0; i < tll->nch; i++) {
+		char clk_name[] = "usb_tll_hs_usb_chx_clk";
+		struct clk *fck;
+
+		sprintf(clk_name, "usb_tll_hs_usb_ch%d_clk", i);
+		fck = clk_get(dev, clk_name);
+
+		if (IS_ERR(fck)) {
+			dev_err(dev, "can't get clock : %s\n", clk_name);
+			ret = PTR_ERR(fck);
+			goto err_clk;
+		}
+		tll->ch_clk[i] = fck;
 	}
 
 	if (is_ehci_tll_mode(pdata->port_mode[0]) ||
@@ -291,7 +299,7 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 		usbtll_write(base, OMAP_TLL_SHARED_CONF, reg);
 
 		/* Enable channels now */
-		for (i = 0; i < count; i++) {
+		for (i = 0; i < tll->nch; i++) {
 			reg = usbtll_read(base,	OMAP_TLL_CHANNEL_CONF(i));
 
 			if (is_ohci_port(pdata->port_mode[i])) {
@@ -319,25 +327,25 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 		}
 	}
 
-err_ioremap:
-	spin_unlock_irqrestore(&tll->lock, flags);
-	iounmap(base);
-	pm_runtime_put_sync(dev);
 	tll_pdev = pdev;
-	if (!ret)
-		goto end;
-	pm_runtime_disable(dev);
 
-err_usbtll_p2_fck:
-	clk_put(tll->usbtll_p2_fck);
+err_clk:
+	for (--i; i >= 0 ; i--)
+		clk_put(tll->ch_clk[i]);
 
-err_usbtll_p1_fck:
-	clk_put(tll->usbtll_p1_fck);
+	spin_unlock_irqrestore(&tll->lock, flags);
+	pm_runtime_put_sync(dev);
+	if (ret == 0) {
+		pr_info("OMAP USB TLL : revision 0x%x, channels %d\n",
+				ver, tll->nch);
+		return 0;
+	}
 
-err_tll:
-	kfree(tll);
+	iounmap(base);
+	pm_runtime_disable(dev);
 
-end:
+err_mem:
+	kfree(tll);
 	return ret;
 }
 
@@ -350,9 +358,12 @@ end:
 static int __devexit usbtll_omap_remove(struct platform_device *pdev)
 {
 	struct usbtll_omap *tll = platform_get_drvdata(pdev);
+	int i;
+
+	iounmap(tll->base);
+	for (i = 0; i < tll->nch; i++)
+		clk_put(tll->ch_clk[i]);
 
-	clk_put(tll->usbtll_p2_fck);
-	clk_put(tll->usbtll_p1_fck);
 	pm_runtime_disable(&pdev->dev);
 	kfree(tll);
 	return 0;
@@ -363,6 +374,7 @@ static int usbtll_runtime_resume(struct device *dev)
 	struct usbtll_omap			*tll = dev_get_drvdata(dev);
 	struct usbtll_omap_platform_data	*pdata = tll->pdata;
 	unsigned long				flags;
+	int i;
 
 	dev_dbg(dev, "usbtll_runtime_resume\n");
 
@@ -373,11 +385,17 @@ static int usbtll_runtime_resume(struct device *dev)
 
 	spin_lock_irqsave(&tll->lock, flags);
 
-	if (is_ehci_tll_mode(pdata->port_mode[0]))
-		clk_enable(tll->usbtll_p1_fck);
-
-	if (is_ehci_tll_mode(pdata->port_mode[1]))
-		clk_enable(tll->usbtll_p2_fck);
+	for (i = 0; i < tll->nch; i++) {
+		if (is_ehci_tll_mode(pdata->port_mode[i])) {
+			int r;
+			r = clk_enable(tll->ch_clk[i]);
+			if (r) {
+				dev_err(dev,
+				 "%s : Error enabling ch %d clock: %d\n",
+				 __func__, i, r);
+			}
+		}
+	}
 
 	spin_unlock_irqrestore(&tll->lock, flags);
 
@@ -389,6 +407,7 @@ static int usbtll_runtime_suspend(struct device *dev)
 	struct usbtll_omap			*tll = dev_get_drvdata(dev);
 	struct usbtll_omap_platform_data	*pdata = tll->pdata;
 	unsigned long				flags;
+	int i;
 
 	dev_dbg(dev, "usbtll_runtime_suspend\n");
 
@@ -399,11 +418,10 @@ static int usbtll_runtime_suspend(struct device *dev)
 
 	spin_lock_irqsave(&tll->lock, flags);
 
-	if (is_ehci_tll_mode(pdata->port_mode[0]))
-		clk_disable(tll->usbtll_p1_fck);
-
-	if (is_ehci_tll_mode(pdata->port_mode[1]))
-		clk_disable(tll->usbtll_p2_fck);
+	for (i = 0; i < tll->nch; i++) {
+		if (is_ehci_tll_mode(pdata->port_mode[i]))
+			clk_disable(tll->ch_clk[i]);
+	}
 
 	spin_unlock_irqrestore(&tll->lock, flags);
 
-- 
1.7.4.1

