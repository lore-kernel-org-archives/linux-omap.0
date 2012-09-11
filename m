From: Ravi Babu <ravibabu@ti.com>
Subject: [PATCH v10 1/5] usb: musb: add musb_ida for multi instance support
Date: Tue, 11 Sep 2012 21:43:15 +0530
Message-ID: <1347379999-26061-2-git-send-email-ravibabu@ti.com>
References: <1347379999-26061-1-git-send-email-ravibabu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47035 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758393Ab2IKQNb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Sep 2012 12:13:31 -0400
In-Reply-To: <1347379999-26061-1-git-send-email-ravibabu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, tony@atomide.com

From: B, Ravi <ravibabu@ti.com>

Added musb_ida in musb_core.c to manage the multi core ids.

Signed-off-by: Ravi Babu <ravibabu@ti.com>
Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Santhapuri, Damodar <damodar.santhapuri@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/musb/am35x.c     |   42 ++++++++++++++++++++++++++++--------------
 drivers/usb/musb/blackfin.c  |   26 ++++++++++++++++++++------
 drivers/usb/musb/da8xx.c     |   34 ++++++++++++++++++++++++----------
 drivers/usb/musb/davinci.c   |   34 ++++++++++++++++++++++++----------
 drivers/usb/musb/musb_core.c |   31 +++++++++++++++++++++++++++++++
 drivers/usb/musb/musb_core.h |    2 ++
 drivers/usb/musb/musb_dsps.c |   25 ++++++++++++++++++-------
 drivers/usb/musb/omap2430.c  |   26 ++++++++++++++++++++------
 drivers/usb/musb/tusb6010.c  |   26 ++++++++++++++++++++------
 drivers/usb/musb/ux500.c     |   33 +++++++++++++++++++++++----------
 10 files changed, 210 insertions(+), 69 deletions(-)

diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 9fbe736..de717b5 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -458,6 +458,7 @@ static int __devinit am35x_probe(struct platform_device *pdev)
 	struct clk			*clk;
 
 	int				ret = -ENOMEM;
+	int				musbid;
 
 	glue = kzalloc(sizeof(*glue), GFP_KERNEL);
 	if (!glue) {
@@ -465,38 +466,47 @@ static int __devinit am35x_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	musb = platform_device_alloc("musb-hdrc", -1);
+	/* get the musb id */
+	musbid = musb_get_id(&pdev->dev, GFP_KERNEL);
+	if (musbid < 0) {
+		dev_err(&pdev->dev, "failed to allocate musb id\n");
+		ret = -ENOMEM;
+		goto err1;
+	}
+
+	musb = platform_device_alloc("musb-hdrc", musbid);
 	if (!musb) {
 		dev_err(&pdev->dev, "failed to allocate musb device\n");
-		goto err1;
+		goto err2;
 	}
 
 	phy_clk = clk_get(&pdev->dev, "fck");
 	if (IS_ERR(phy_clk)) {
 		dev_err(&pdev->dev, "failed to get PHY clock\n");
 		ret = PTR_ERR(phy_clk);
-		goto err2;
+		goto err3;
 	}
 
 	clk = clk_get(&pdev->dev, "ick");
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
 		ret = PTR_ERR(clk);
-		goto err3;
+		goto err4;
 	}
 
 	ret = clk_enable(phy_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable PHY clock\n");
-		goto err4;
+		goto err5;
 	}
 
 	ret = clk_enable(clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable clock\n");
-		goto err5;
+		goto err6;
 	}
 
+	musb->id			= musbid;
 	musb->dev.parent		= &pdev->dev;
 	musb->dev.dma_mask		= &am35x_dmamask;
 	musb->dev.coherent_dma_mask	= am35x_dmamask;
@@ -514,38 +524,41 @@ static int __devinit am35x_probe(struct platform_device *pdev)
 			pdev->num_resources);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add resources\n");
-		goto err6;
+		goto err7;
 	}
 
 	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add platform_data\n");
-		goto err6;
+		goto err7;
 	}
 
 	ret = platform_device_add(musb);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register musb device\n");
-		goto err6;
+		goto err7;
 	}
 
 	return 0;
 
-err6:
+err7:
 	clk_disable(clk);
 
-err5:
+err6:
 	clk_disable(phy_clk);
 
-err4:
+err5:
 	clk_put(clk);
 
-err3:
+err4:
 	clk_put(phy_clk);
 
-err2:
+err3:
 	platform_device_put(musb);
 
+err2:
+	musb_put_id(&pdev->dev, musbid);
+
 err1:
 	kfree(glue);
 
@@ -557,6 +570,7 @@ static int __devexit am35x_remove(struct platform_device *pdev)
 {
 	struct am35x_glue	*glue = platform_get_drvdata(pdev);
 
+	musb_put_id(&pdev->dev, glue->musb->id);
 	platform_device_del(glue->musb);
 	platform_device_put(glue->musb);
 	clk_disable(glue->clk);
diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index 54f1b98..26cc8b7 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -454,6 +454,7 @@ static int __devinit bfin_probe(struct platform_device *pdev)
 	struct bfin_glue		*glue;
 
 	int				ret = -ENOMEM;
+	int				musbid;
 
 	glue = kzalloc(sizeof(*glue), GFP_KERNEL);
 	if (!glue) {
@@ -461,12 +462,21 @@ static int __devinit bfin_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	musb = platform_device_alloc("musb-hdrc", -1);
+	/* get the musb id */
+	musbid = musb_get_id(&pdev->dev, GFP_KERNEL);
+	if (musbid < 0) {
+		dev_err(&pdev->dev, "failed to allocate musb id\n");
+		ret = -ENOMEM;
+		goto err1;
+	}
+
+	musb = platform_device_alloc("musb-hdrc", musbid);
 	if (!musb) {
 		dev_err(&pdev->dev, "failed to allocate musb device\n");
-		goto err1;
+		goto err2;
 	}
 
+	musb->id			= musbid;
 	musb->dev.parent		= &pdev->dev;
 	musb->dev.dma_mask		= &bfin_dmamask;
 	musb->dev.coherent_dma_mask	= bfin_dmamask;
@@ -482,26 +492,29 @@ static int __devinit bfin_probe(struct platform_device *pdev)
 			pdev->num_resources);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add resources\n");
-		goto err2;
+		goto err3;
 	}
 
 	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add platform_data\n");
-		goto err2;
+		goto err3;
 	}
 
 	ret = platform_device_add(musb);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register musb device\n");
-		goto err2;
+		goto err3;
 	}
 
 	return 0;
 
-err2:
+err3:
 	platform_device_put(musb);
 
+err2:
+	musb_put_id(&pdev->dev, musbid);
+
 err1:
 	kfree(glue);
 
@@ -513,6 +526,7 @@ static int __devexit bfin_remove(struct platform_device *pdev)
 {
 	struct bfin_glue		*glue = platform_get_drvdata(pdev);
 
+	musb_put_id(&pdev->dev, glue->musb->id);
 	platform_device_del(glue->musb);
 	platform_device_put(glue->musb);
 	kfree(glue);
diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index 4e4df9d..ddb9c9c 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -479,6 +479,7 @@ static int __devinit da8xx_probe(struct platform_device *pdev)
 	struct clk			*clk;
 
 	int				ret = -ENOMEM;
+	int				musbid;
 
 	glue = kzalloc(sizeof(*glue), GFP_KERNEL);
 	if (!glue) {
@@ -486,25 +487,34 @@ static int __devinit da8xx_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	musb = platform_device_alloc("musb-hdrc", -1);
+	/* get the musb id */
+	musbid = musb_get_id(&pdev->dev, GFP_KERNEL);
+	if (musbid < 0) {
+		dev_err(&pdev->dev, "failed to allocate musb id\n");
+		ret = -ENOMEM;
+		goto err1;
+	}
+
+	musb = platform_device_alloc("musb-hdrc", musbid);
 	if (!musb) {
 		dev_err(&pdev->dev, "failed to allocate musb device\n");
-		goto err1;
+		goto err2;
 	}
 
 	clk = clk_get(&pdev->dev, "usb20");
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
 		ret = PTR_ERR(clk);
-		goto err2;
+		goto err3;
 	}
 
 	ret = clk_enable(clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable clock\n");
-		goto err3;
+		goto err4;
 	}
 
+	musb->id			= musbid;
 	musb->dev.parent		= &pdev->dev;
 	musb->dev.dma_mask		= &da8xx_dmamask;
 	musb->dev.coherent_dma_mask	= da8xx_dmamask;
@@ -521,32 +531,35 @@ static int __devinit da8xx_probe(struct platform_device *pdev)
 			pdev->num_resources);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add resources\n");
-		goto err4;
+		goto err5;
 	}
 
 	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add platform_data\n");
-		goto err4;
+		goto err5;
 	}
 
 	ret = platform_device_add(musb);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register musb device\n");
-		goto err4;
+		goto err5;
 	}
 
 	return 0;
 
-err4:
+err5:
 	clk_disable(clk);
 
-err3:
+err4:
 	clk_put(clk);
 
-err2:
+err3:
 	platform_device_put(musb);
 
+err2:
+	musb_put_id(&pdev->dev, musbid);
+
 err1:
 	kfree(glue);
 
@@ -558,6 +571,7 @@ static int __devexit da8xx_remove(struct platform_device *pdev)
 {
 	struct da8xx_glue		*glue = platform_get_drvdata(pdev);
 
+	musb_put_id(&pdev->dev, glue->musb->id);
 	platform_device_del(glue->musb);
 	platform_device_put(glue->musb);
 	clk_disable(glue->clk);
diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index 8805f80..c269e61 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -511,6 +511,7 @@ static int __devinit davinci_probe(struct platform_device *pdev)
 	struct clk			*clk;
 
 	int				ret = -ENOMEM;
+	int				musbid;
 
 	glue = kzalloc(sizeof(*glue), GFP_KERNEL);
 	if (!glue) {
@@ -518,25 +519,34 @@ static int __devinit davinci_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	musb = platform_device_alloc("musb-hdrc", -1);
+	/* get the musb id */
+	musbid = musb_get_id(&pdev->dev, GFP_KERNEL);
+	if (musbid < 0) {
+		dev_err(&pdev->dev, "failed to allocate musb id\n");
+		ret = -ENOMEM;
+		goto err1;
+	}
+
+	musb = platform_device_alloc("musb-hdrc", musbid);
 	if (!musb) {
 		dev_err(&pdev->dev, "failed to allocate musb device\n");
-		goto err1;
+		goto err2;
 	}
 
 	clk = clk_get(&pdev->dev, "usb");
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
 		ret = PTR_ERR(clk);
-		goto err2;
+		goto err3;
 	}
 
 	ret = clk_enable(clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable clock\n");
-		goto err3;
+		goto err4;
 	}
 
+	musb->id			= musbid;
 	musb->dev.parent		= &pdev->dev;
 	musb->dev.dma_mask		= &davinci_dmamask;
 	musb->dev.coherent_dma_mask	= davinci_dmamask;
@@ -553,32 +563,35 @@ static int __devinit davinci_probe(struct platform_device *pdev)
 			pdev->num_resources);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add resources\n");
-		goto err4;
+		goto err5;
 	}
 
 	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add platform_data\n");
-		goto err4;
+		goto err5;
 	}
 
 	ret = platform_device_add(musb);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register musb device\n");
-		goto err4;
+		goto err5;
 	}
 
 	return 0;
 
-err4:
+err5:
 	clk_disable(clk);
 
-err3:
+err4:
 	clk_put(clk);
 
-err2:
+err3:
 	platform_device_put(musb);
 
+err2:
+	musb_put_id(&pdev->dev, musbid);
+
 err1:
 	kfree(glue);
 
@@ -590,6 +603,7 @@ static int __devexit davinci_remove(struct platform_device *pdev)
 {
 	struct davinci_glue		*glue = platform_get_drvdata(pdev);
 
+	musb_put_id(&pdev->dev, glue->musb->id);
 	platform_device_del(glue->musb);
 	platform_device_put(glue->musb);
 	clk_disable(glue->clk);
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 5cacccb..61b64fc 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -99,6 +99,7 @@
 #include <linux/prefetch.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/idr.h>
 
 #include "musb_core.h"
 
@@ -114,6 +115,7 @@
 
 #define MUSB_DRIVER_NAME "musb-hdrc"
 const char musb_driver_name[] = MUSB_DRIVER_NAME;
+static DEFINE_IDA(musb_ida);
 
 MODULE_DESCRIPTION(DRIVER_INFO);
 MODULE_AUTHOR(DRIVER_AUTHOR);
@@ -130,6 +132,35 @@ static inline struct musb *dev_to_musb(struct device *dev)
 
 /*-------------------------------------------------------------------------*/
 
+int musb_get_id(struct device *dev, gfp_t gfp_mask)
+{
+	int ret;
+	int id;
+
+	ret = ida_pre_get(&musb_ida, gfp_mask);
+	if (!ret) {
+		dev_err(dev, "failed to reserve resource for id\n");
+		return -ENOMEM;
+	}
+
+	ret = ida_get_new(&musb_ida, &id);
+	if (ret < 0) {
+		dev_err(dev, "failed to allocate a new id\n");
+		return ret;
+	}
+
+	return id;
+}
+EXPORT_SYMBOL_GPL(musb_get_id);
+
+void musb_put_id(struct device *dev, int id)
+{
+
+	dev_dbg(dev, "removing id %d\n", id);
+	ida_remove(&musb_ida, id);
+}
+EXPORT_SYMBOL_GPL(musb_put_id);
+
 #ifndef CONFIG_BLACKFIN
 static int musb_ulpi_read(struct usb_phy *phy, u32 offset)
 {
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index a1a32c6..a69ffd6 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -517,6 +517,8 @@ extern const char musb_driver_name[];
 
 extern void musb_start(struct musb *musb);
 extern void musb_stop(struct musb *musb);
+extern int musb_get_id(struct device *dev, gfp_t gfp_mask);
+extern void musb_put_id(struct device *dev, int id);
 
 extern void musb_write_fifo(struct musb_hw_ep *ep, u16 len, const u8 *src);
 extern void musb_read_fifo(struct musb_hw_ep *ep, u16 len, u8 *dst);
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 51ff1bb..5351e96 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -448,7 +448,7 @@ static int __devinit dsps_create_musb_pdev(struct dsps_glue *glue, u8 id)
 	struct resource *res;
 	struct resource	resources[2];
 	char res_name[10];
-	int ret;
+	int ret, musbid;
 
 	/* get memory resource */
 	sprintf(res_name, "musb%d", id);
@@ -473,14 +473,22 @@ static int __devinit dsps_create_musb_pdev(struct dsps_glue *glue, u8 id)
 	res->parent = NULL;
 	resources[1] = *res;
 
+	/* get the musb id */
+	musbid = musb_get_id(dev, GFP_KERNEL);
+	if (musbid < 0) {
+		dev_err(dev, "failed to allocate musb id\n");
+		ret = -ENOMEM;
+		goto err0;
+	}
 	/* allocate the child platform device */
-	musb = platform_device_alloc("musb-hdrc", -1);
+	musb = platform_device_alloc("musb-hdrc", musbid);
 	if (!musb) {
 		dev_err(dev, "failed to allocate musb device\n");
 		ret = -ENOMEM;
-		goto err0;
+		goto err1;
 	}
 
+	musb->id			= musbid;
 	musb->dev.parent		= dev;
 	musb->dev.dma_mask		= &musb_dmamask;
 	musb->dev.coherent_dma_mask	= musb_dmamask;
@@ -492,31 +500,34 @@ static int __devinit dsps_create_musb_pdev(struct dsps_glue *glue, u8 id)
 	ret = platform_device_add_resources(musb, resources, 2);
 	if (ret) {
 		dev_err(dev, "failed to add resources\n");
-		goto err1;
+		goto err2;
 	}
 
 	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
 	if (ret) {
 		dev_err(dev, "failed to add platform_data\n");
-		goto err1;
+		goto err2;
 	}
 
 	ret = platform_device_add(musb);
 	if (ret) {
 		dev_err(dev, "failed to register musb device\n");
-		goto err1;
+		goto err2;
 	}
 
 	return 0;
 
-err1:
+err2:
 	platform_device_put(musb);
+err1:
+	musb_put_id(dev, musbid);
 err0:
 	return ret;
 }
 
 static void __devexit dsps_delete_musb_pdev(struct dsps_glue *glue)
 {
+	musb_put_id(glue->dev, glue->musb->id);
 	platform_device_del(glue->musb);
 	platform_device_put(glue->musb);
 }
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index d96873b..a538fe1 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -478,6 +478,7 @@ static int __devinit omap2430_probe(struct platform_device *pdev)
 	struct musb_hdrc_config		*config;
 	struct resource			*res;
 	int				ret = -ENOMEM;
+	int				musbid;
 
 	glue = devm_kzalloc(&pdev->dev, sizeof(*glue), GFP_KERNEL);
 	if (!glue) {
@@ -485,12 +486,21 @@ static int __devinit omap2430_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	musb = platform_device_alloc("musb-hdrc", -1);
+	/* get the musb id */
+	musbid = musb_get_id(&pdev->dev, GFP_KERNEL);
+	if (musbid < 0) {
+		dev_err(&pdev->dev, "failed to allocate musb id\n");
+		ret = -ENOMEM;
+		goto err0;
+	}
+
+	musb = platform_device_alloc("musb-hdrc", musbid);
 	if (!musb) {
 		dev_err(&pdev->dev, "failed to allocate musb device\n");
-		goto err0;
+		goto err1;
 	}
 
+	musb->id			= musbid;
 	musb->dev.parent		= &pdev->dev;
 	musb->dev.dma_mask		= &omap2430_dmamask;
 	musb->dev.coherent_dma_mask	= omap2430_dmamask;
@@ -557,13 +567,13 @@ static int __devinit omap2430_probe(struct platform_device *pdev)
 			pdev->num_resources);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add resources\n");
-		goto err1;
+		goto err2;
 	}
 
 	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add platform_data\n");
-		goto err1;
+		goto err2;
 	}
 
 	pm_runtime_enable(&pdev->dev);
@@ -571,14 +581,17 @@ static int __devinit omap2430_probe(struct platform_device *pdev)
 	ret = platform_device_add(musb);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register musb device\n");
-		goto err1;
+		goto err2;
 	}
 
 	return 0;
 
-err1:
+err2:
 	platform_device_put(musb);
 
+err1:
+	musb_put_id(&pdev->dev, musbid);
+
 err0:
 	return ret;
 }
@@ -588,6 +601,7 @@ static int __devexit omap2430_remove(struct platform_device *pdev)
 	struct omap2430_glue		*glue = platform_get_drvdata(pdev);
 
 	cancel_work_sync(&glue->omap_musb_mailbox_work);
+	musb_put_id(&pdev->dev, glue->musb->id);
 	platform_device_unregister(glue->musb);
 
 	return 0;
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 1d0c090..878655f 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -1159,6 +1159,7 @@ static int __devinit tusb_probe(struct platform_device *pdev)
 	struct tusb6010_glue		*glue;
 
 	int				ret = -ENOMEM;
+	int				musbid;
 
 	glue = kzalloc(sizeof(*glue), GFP_KERNEL);
 	if (!glue) {
@@ -1166,12 +1167,21 @@ static int __devinit tusb_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	musb = platform_device_alloc("musb-hdrc", -1);
+	/* get the musb id */
+	musbid = musb_get_id(&pdev->dev, GFP_KERNEL);
+	if (musbid < 0) {
+		dev_err(&pdev->dev, "failed to allocate musb id\n");
+		ret = -ENOMEM;
+		goto err1;
+	}
+
+	musb = platform_device_alloc("musb-hdrc", musbid);
 	if (!musb) {
 		dev_err(&pdev->dev, "failed to allocate musb device\n");
-		goto err1;
+		goto err2;
 	}
 
+	musb->id			= musbid;
 	musb->dev.parent		= &pdev->dev;
 	musb->dev.dma_mask		= &tusb_dmamask;
 	musb->dev.coherent_dma_mask	= tusb_dmamask;
@@ -1187,26 +1197,29 @@ static int __devinit tusb_probe(struct platform_device *pdev)
 			pdev->num_resources);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add resources\n");
-		goto err2;
+		goto err3;
 	}
 
 	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add platform_data\n");
-		goto err2;
+		goto err3;
 	}
 
 	ret = platform_device_add(musb);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register musb device\n");
-		goto err1;
+		goto err3;
 	}
 
 	return 0;
 
-err2:
+err3:
 	platform_device_put(musb);
 
+err2:
+	musb_put_id(&pdev->dev, musbid);
+
 err1:
 	kfree(glue);
 
@@ -1218,6 +1231,7 @@ static int __devexit tusb_remove(struct platform_device *pdev)
 {
 	struct tusb6010_glue		*glue = platform_get_drvdata(pdev);
 
+	musb_put_id(&pdev->dev, glue->musb->id);
 	platform_device_del(glue->musb);
 	platform_device_put(glue->musb);
 	kfree(glue);
diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
index a8c0fad..d62a91f 100644
--- a/drivers/usb/musb/ux500.c
+++ b/drivers/usb/musb/ux500.c
@@ -74,25 +74,34 @@ static int __devinit ux500_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	musb = platform_device_alloc("musb-hdrc", -1);
+	/* get the musb id */
+	musbid = musb_get_id(&pdev->dev, GFP_KERNEL);
+	if (musbid < 0) {
+		dev_err(&pdev->dev, "failed to allocate musb id\n");
+		ret = -ENOMEM;
+		goto err1;
+	}
+
+	musb = platform_device_alloc("musb-hdrc", musbid);
 	if (!musb) {
 		dev_err(&pdev->dev, "failed to allocate musb device\n");
-		goto err1;
+		goto err2;
 	}
 
 	clk = clk_get(&pdev->dev, "usb");
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
 		ret = PTR_ERR(clk);
-		goto err2;
+		goto err3;
 	}
 
 	ret = clk_enable(clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable clock\n");
-		goto err3;
+		goto err4;
 	}
 
+	musb->id			= musbid;
 	musb->dev.parent		= &pdev->dev;
 	musb->dev.dma_mask		= pdev->dev.dma_mask;
 	musb->dev.coherent_dma_mask	= pdev->dev.coherent_dma_mask;
@@ -109,32 +118,35 @@ static int __devinit ux500_probe(struct platform_device *pdev)
 			pdev->num_resources);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add resources\n");
-		goto err4;
+		goto err5;
 	}
 
 	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add platform_data\n");
-		goto err4;
+		goto err5;
 	}
 
 	ret = platform_device_add(musb);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register musb device\n");
-		goto err4;
+		goto err5;
 	}
 
 	return 0;
 
-err4:
+err5:
 	clk_disable(clk);
 
-err3:
+err4:
 	clk_put(clk);
 
-err2:
+err3:
 	platform_device_put(musb);
 
+err2:
+	musb_put_id(&pdev->dev, musbid);
+
 err1:
 	kfree(glue);
 
@@ -146,6 +158,7 @@ static int __devexit ux500_remove(struct platform_device *pdev)
 {
 	struct ux500_glue	*glue = platform_get_drvdata(pdev);
 
+	musb_put_id(&pdev->dev, glue->musb->id);
 	platform_device_del(glue->musb);
 	platform_device_put(glue->musb);
 	clk_disable(glue->clk);
-- 
1.7.0.4

