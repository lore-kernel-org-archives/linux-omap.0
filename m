From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 08/10] ASoC: omap-mcbsp: Cleanup of module probe/remove code
Date: Tue, 28 Feb 2012 09:40:18 +0200
Message-ID: <1330414820-4641-9-git-send-email-peter.ujfalusi@ti.com>
References: <1330414820-4641-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:50991 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754213Ab2B1Hkw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 02:40:52 -0500
Received: by lahj13 with SMTP id j13so2374227lah.5
        for <linux-omap@vger.kernel.org>; Mon, 27 Feb 2012 23:40:49 -0800 (PST)
In-Reply-To: <1330414820-4641-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Grazvydas Ignotas <notasas@gmail.com>

Use devm_* where it is possible to save on cleanup path.
Start merging the two mcbsp file content.
Move pm_runtime_enable/disable calls to ASoC probe, remove from module
probe/remove time.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Grazvydas Ignotas <notasas@gmail.com>
Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 sound/soc/omap/mcbsp.c      |  136 +++++++++++--------------------------------
 sound/soc/omap/mcbsp.h      |    4 +-
 sound/soc/omap/omap-mcbsp.c |   51 +++++++++++++++-
 3 files changed, 85 insertions(+), 106 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index 95ba7e0..9e39c58 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -26,7 +26,6 @@
 #include <linux/slab.h>
 
 #include <plat/mcbsp.h>
-#include <linux/pm_runtime.h>
 
 #include "mcbsp.h"
 
@@ -915,90 +914,56 @@ static int __devinit omap_st_add(struct omap_mcbsp *mcbsp,
 	struct omap_mcbsp_st_data *st_data;
 	int err;
 
-	st_data = kzalloc(sizeof(*mcbsp->st_data), GFP_KERNEL);
-	if (!st_data) {
-		err = -ENOMEM;
-		goto err1;
-	}
+	st_data = devm_kzalloc(mcbsp->dev, sizeof(*mcbsp->st_data), GFP_KERNEL);
+	if (!st_data)
+		return -ENOMEM;
 
-	st_data->io_base_st = ioremap(res->start, resource_size(res));
-	if (!st_data->io_base_st) {
-		err = -ENOMEM;
-		goto err2;
-	}
+	st_data->io_base_st = devm_ioremap(mcbsp->dev, res->start,
+					   resource_size(res));
+	if (!st_data->io_base_st)
+		return -ENOMEM;
 
 	err = sysfs_create_group(&mcbsp->dev->kobj, &sidetone_attr_group);
 	if (err)
-		goto err3;
+		return err;
 
 	mcbsp->st_data = st_data;
 	return 0;
-
-err3:
-	iounmap(st_data->io_base_st);
-err2:
-	kfree(st_data);
-err1:
-	return err;
-
-}
-
-static void __devexit omap_st_remove(struct omap_mcbsp *mcbsp)
-{
-	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
-
-	sysfs_remove_group(&mcbsp->dev->kobj, &sidetone_attr_group);
-	iounmap(st_data->io_base_st);
-	kfree(st_data);
 }
 
 /*
  * McBSP1 and McBSP3 are directly mapped on 1610 and 1510.
  * 730 has only 2 McBSP, and both of them are MPU peripherals.
  */
-int __devinit omap_mcbsp_probe(struct platform_device *pdev)
+int __devinit omap_mcbsp_init(struct platform_device *pdev)
 {
-	struct omap_mcbsp_platform_data *pdata = pdev->dev.platform_data;
-	struct omap_mcbsp *mcbsp;
+	struct omap_mcbsp *mcbsp = platform_get_drvdata(pdev);
 	struct resource *res;
 	int ret = 0;
 
-	if (!pdata) {
-		dev_err(&pdev->dev, "McBSP device initialized without"
-				"platform data\n");
-		ret = -EINVAL;
-		goto exit;
-	}
-
-	dev_dbg(&pdev->dev, "Initializing OMAP McBSP (%d).\n", pdev->id);
-
-	mcbsp = kzalloc(sizeof(struct omap_mcbsp), GFP_KERNEL);
-	if (!mcbsp) {
-		ret = -ENOMEM;
-		goto exit;
-	}
-
 	spin_lock_init(&mcbsp->lock);
-	mcbsp->id = pdev->id;
 	mcbsp->free = true;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
 	if (!res) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		if (!res) {
-			dev_err(&pdev->dev, "%s:mcbsp%d has invalid memory"
-					"resource\n", __func__, pdev->id);
-			ret = -ENOMEM;
-			goto exit;
+			dev_err(mcbsp->dev, "invalid memory resource\n");
+			return -ENOMEM;
 		}
 	}
+	if (!devm_request_mem_region(&pdev->dev, res->start, resource_size(res),
+				     dev_name(&pdev->dev))) {
+		dev_err(mcbsp->dev, "memory region already claimed\n");
+		return -ENODEV;
+	}
+
 	mcbsp->phys_base = res->start;
 	mcbsp->reg_cache_size = resource_size(res);
-	mcbsp->io_base = ioremap(res->start, resource_size(res));
-	if (!mcbsp->io_base) {
-		ret = -ENOMEM;
-		goto err_ioremap;
-	}
+	mcbsp->io_base = devm_ioremap(&pdev->dev, res->start,
+				      resource_size(res));
+	if (!mcbsp->io_base)
+		return -ENOMEM;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma");
 	if (!res)
@@ -1015,34 +980,25 @@ int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
 	if (!res) {
-		dev_err(&pdev->dev, "%s:mcbsp%d has invalid rx DMA channel\n",
-					__func__, pdev->id);
-		ret = -ENODEV;
-		goto err_res;
+		dev_err(&pdev->dev, "invalid rx DMA channel\n");
+		return -ENODEV;
 	}
 	mcbsp->dma_rx_sync = res->start;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
 	if (!res) {
-		dev_err(&pdev->dev, "%s:mcbsp%d has invalid tx DMA channel\n",
-					__func__, pdev->id);
-		ret = -ENODEV;
-		goto err_res;
+		dev_err(&pdev->dev, "invalid tx DMA channel\n");
+		return -ENODEV;
 	}
 	mcbsp->dma_tx_sync = res->start;
 
 	mcbsp->fclk = clk_get(&pdev->dev, "fck");
 	if (IS_ERR(mcbsp->fclk)) {
 		ret = PTR_ERR(mcbsp->fclk);
-		dev_err(&pdev->dev, "unable to get fck: %d\n", ret);
-		goto err_res;
+		dev_err(mcbsp->dev, "unable to get fck: %d\n", ret);
+		return ret;
 	}
 
-	mcbsp->pdata = pdata;
-	mcbsp->dev = &pdev->dev;
-	platform_set_drvdata(pdev, mcbsp);
-	pm_runtime_enable(mcbsp->dev);
-
 	mcbsp->dma_op_mode = MCBSP_DMA_MODE_ELEMENT;
 	if (mcbsp->pdata->buffer_size) {
 		/*
@@ -1082,41 +1038,17 @@ int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 
 err_st:
 	if (mcbsp->pdata->buffer_size)
-		sysfs_remove_group(&mcbsp->dev->kobj,
-				   &additional_attr_group);
+		sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_group);
 err_thres:
 	clk_put(mcbsp->fclk);
-err_res:
-	iounmap(mcbsp->io_base);
-err_ioremap:
-	kfree(mcbsp);
-exit:
 	return ret;
 }
 
-int __devexit omap_mcbsp_remove(struct platform_device *pdev)
+void __devexit omap_mcbsp_sysfs_remove(struct omap_mcbsp *mcbsp)
 {
-	struct omap_mcbsp *mcbsp = platform_get_drvdata(pdev);
-
-	platform_set_drvdata(pdev, NULL);
-	if (mcbsp) {
-
-		if (mcbsp->pdata && mcbsp->pdata->ops &&
-				mcbsp->pdata->ops->free)
-			mcbsp->pdata->ops->free(mcbsp->id);
-
-		if (mcbsp->pdata->buffer_size)
-			sysfs_remove_group(&mcbsp->dev->kobj,
-					   &additional_attr_group);
-
-		if (mcbsp->st_data)
-			omap_st_remove(mcbsp);
-
-		clk_put(mcbsp->fclk);
-
-		iounmap(mcbsp->io_base);
-		kfree(mcbsp);
-	}
+	if (mcbsp->pdata->buffer_size)
+		sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_group);
 
-	return 0;
+	if (mcbsp->st_data)
+		sysfs_remove_group(&mcbsp->dev->kobj, &sidetone_attr_group);
 }
diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
index a991e1d..ac90c1a 100644
--- a/sound/soc/omap/mcbsp.h
+++ b/sound/soc/omap/mcbsp.h
@@ -341,7 +341,7 @@ int omap_st_enable(struct omap_mcbsp *mcbsp);
 int omap_st_disable(struct omap_mcbsp *mcbsp);
 int omap_st_is_enabled(struct omap_mcbsp *mcbsp);
 
-int __devinit omap_mcbsp_probe(struct platform_device *pdev);
-int __devexit omap_mcbsp_remove(struct platform_device *pdev);
+int __devinit omap_mcbsp_init(struct platform_device *pdev);
+void __devexit omap_mcbsp_sysfs_remove(struct omap_mcbsp *mcbsp);
 
 #endif /* __ASOC_MCBSP_H */
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 9c703f1..69a44aa 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -25,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/pm_runtime.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -603,7 +604,27 @@ static const struct snd_soc_dai_ops mcbsp_dai_ops = {
 	.set_sysclk	= omap_mcbsp_dai_set_dai_sysclk,
 };
 
+static int omap_mcbsp_probe(struct snd_soc_dai *dai)
+{
+	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(dai);
+
+	pm_runtime_enable(mcbsp->dev);
+
+	return 0;
+}
+
+static int omap_mcbsp_remove(struct snd_soc_dai *dai)
+{
+	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(dai);
+
+	pm_runtime_disable(mcbsp->dev);
+
+	return 0;
+}
+
 static struct snd_soc_dai_driver omap_mcbsp_dai = {
+	.probe = omap_mcbsp_probe,
+	.remove = omap_mcbsp_remove,
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 16,
@@ -756,9 +777,24 @@ EXPORT_SYMBOL_GPL(omap_mcbsp_st_add_controls);
 
 static __devinit int asoc_mcbsp_probe(struct platform_device *pdev)
 {
+	struct omap_mcbsp_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct omap_mcbsp *mcbsp;
 	int ret;
 
-	ret = omap_mcbsp_probe(pdev);
+	if (!pdata) {
+		dev_err(&pdev->dev, "missing platform data.\n");
+		return -EINVAL;
+	}
+	mcbsp = devm_kzalloc(&pdev->dev, sizeof(struct omap_mcbsp), GFP_KERNEL);
+	if (!mcbsp)
+		return -ENOMEM;
+
+	mcbsp->id = pdev->id;
+	mcbsp->pdata = pdata;
+	mcbsp->dev = &pdev->dev;
+	platform_set_drvdata(pdev, mcbsp);
+
+	ret = omap_mcbsp_init(pdev);
 	if (!ret)
 		return snd_soc_register_dai(&pdev->dev, &omap_mcbsp_dai);
 
@@ -767,8 +803,19 @@ static __devinit int asoc_mcbsp_probe(struct platform_device *pdev)
 
 static int __devexit asoc_mcbsp_remove(struct platform_device *pdev)
 {
-	omap_mcbsp_remove(pdev);
+	struct omap_mcbsp *mcbsp = platform_get_drvdata(pdev);
+
 	snd_soc_unregister_dai(&pdev->dev);
+
+	if (mcbsp->pdata->ops && mcbsp->pdata->ops->free)
+		mcbsp->pdata->ops->free(mcbsp->id);
+
+	omap_mcbsp_sysfs_remove(mcbsp);
+
+	clk_put(mcbsp->fclk);
+
+	platform_set_drvdata(pdev, NULL);
+
 	return 0;
 }
 
-- 
1.7.8.4

