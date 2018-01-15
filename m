From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v2] mfd: omap-usb-tll: Allocate driver data at once
Date: Mon, 15 Jan 2018 21:25:05 +0100
Message-ID: <20180115202505.GA2628@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Allocating memory to store clk array together with driver
data simplifies error unwinding and allows deleting memory
allocation failure message as there is now only single point
of failure already covered by allocation failure report.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
[Markus Elfring: simplified error unwinding, error message removal]
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Link: https://lkml.org/lkml/2018/1/15/411
---
 Changes:
 - v2: reindent 'rev' debug message
       credit Markus Elfring

 drivers/mfd/omap-usb-tll.c | 60 +++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 35 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 44a5d66314c6..446713dbee27 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -108,9 +108,9 @@
 					 (x) != OMAP_EHCI_PORT_MODE_PHY)
 
 struct usbtll_omap {
-	int					nch;	/* num. of channels */
-	struct clk				**ch_clk;
-	void __iomem				*base;
+	void __iomem	*base;
+	int		nch;		/* num. of channels */
+	struct clk	*ch_clk[0];	/* must be the last member */
 };
 
 /*-------------------------------------------------------------------------*/
@@ -216,53 +216,49 @@ static int usbtll_omap_probe(struct platform_device *pdev)
 	struct device				*dev =  &pdev->dev;
 	struct resource				*res;
 	struct usbtll_omap			*tll;
-	int					ret = 0;
-	int					i, ver;
+	void __iomem				*base;
+	int					i, nch, ver;
 
 	dev_dbg(dev, "starting TI HSUSB TLL Controller\n");
 
-	tll = devm_kzalloc(dev, sizeof(struct usbtll_omap), GFP_KERNEL);
-	if (!tll) {
-		dev_err(dev, "Memory allocation failed\n");
-		return -ENOMEM;
-	}
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	tll->base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(tll->base))
-		return PTR_ERR(tll->base);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
-	platform_set_drvdata(pdev, tll);
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
-	ver =  usbtll_read(tll->base, OMAP_USBTLL_REVISION);
+	ver = usbtll_read(base, OMAP_USBTLL_REVISION);
 	switch (ver) {
 	case OMAP_USBTLL_REV1:
 	case OMAP_USBTLL_REV4:
-		tll->nch = OMAP_TLL_CHANNEL_COUNT;
+		nch = OMAP_TLL_CHANNEL_COUNT;
 		break;
 	case OMAP_USBTLL_REV2:
 	case OMAP_USBTLL_REV3:
-		tll->nch = OMAP_REV2_TLL_CHANNEL_COUNT;
+		nch = OMAP_REV2_TLL_CHANNEL_COUNT;
 		break;
 	default:
-		tll->nch = OMAP_TLL_CHANNEL_COUNT;
-		dev_dbg(dev,
-		 "USB TLL Rev : 0x%x not recognized, assuming %d channels\n",
-			ver, tll->nch);
+		nch = OMAP_TLL_CHANNEL_COUNT;
+		dev_dbg(dev, "rev 0x%x not recognized, assuming %d channels\n",
+			ver, nch);
 		break;
 	}
 
-	tll->ch_clk = devm_kzalloc(dev, sizeof(struct clk *) * tll->nch,
-						GFP_KERNEL);
-	if (!tll->ch_clk) {
-		ret = -ENOMEM;
-		dev_err(dev, "Couldn't allocate memory for channel clocks\n");
-		goto err_clk_alloc;
+	tll = devm_kzalloc(dev, sizeof(*tll) + sizeof(tll->ch_clk[nch]),
+			   GFP_KERNEL);
+	if (!tll) {
+		pm_runtime_put_sync(dev);
+		pm_runtime_disable(dev);
+		return -ENOMEM;
 	}
 
-	for (i = 0; i < tll->nch; i++) {
+	tll->base = base;
+	tll->nch = nch;
+	platform_set_drvdata(pdev, tll);
+
+	for (i = 0; i < nch; i++) {
 		char clkname[] = "usb_tll_hs_usb_chx_clk";
 
 		snprintf(clkname, sizeof(clkname),
@@ -282,12 +278,6 @@ static int usbtll_omap_probe(struct platform_device *pdev)
 	spin_unlock(&tll_lock);
 
 	return 0;
-
-err_clk_alloc:
-	pm_runtime_put_sync(dev);
-	pm_runtime_disable(dev);
-
-	return ret;
 }
 
 /**
-- 
2.15.1
