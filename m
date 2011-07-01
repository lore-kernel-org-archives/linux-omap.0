From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC 12/12] omap: mcbsp: Reorganize DMA operating mode and sidetone init/exit code
Date: Fri,  1 Jul 2011 11:52:36 +0300
Message-ID: <1309510356-27147-13-git-send-email-jhnikula@gmail.com>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58452 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755766Ab1GAIxR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 04:53:17 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so2453487bwd.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 01:53:17 -0700 (PDT)
In-Reply-To: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jhnikula@gmail.com>

Reorganize DMA operating mode and sidetone initialization/ext code so that
they are not tied together and can be extended over OMAP3.

Currently DMA operating mode control is added only on OMAP3 but can be
extended in the future. Sidetone initialization is alredy platform
independed based on if the sidetone resource is registered for a device.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/plat-omap/mcbsp.c |  116 ++++++++++++++++++++------------------------
 1 files changed, 52 insertions(+), 64 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index d565b36..dd6a19e 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -1086,16 +1086,6 @@ static const struct attribute_group additional_attr_group = {
 	.attrs = (struct attribute **)additional_attrs,
 };
 
-static inline int __devinit omap_additional_add(struct device *dev)
-{
-	return sysfs_create_group(&dev->kobj, &additional_attr_group);
-}
-
-static inline void __devexit omap_additional_remove(struct device *dev)
-{
-	sysfs_remove_group(&dev->kobj, &additional_attr_group);
-}
-
 static const struct attribute *sidetone_attrs[] = {
 	&dev_attr_st_taps.attr,
 	NULL,
@@ -1105,10 +1095,9 @@ static const struct attribute_group sidetone_attr_group = {
 	.attrs = (struct attribute **)sidetone_attrs,
 };
 
-static int __devinit omap_st_add(struct omap_mcbsp *mcbsp)
+static int __devinit omap_mcbsp_st_add(struct omap_mcbsp *mcbsp,
+				       struct resource *res)
 {
-	struct platform_device *pdev;
-	struct resource *res;
 	struct omap_mcbsp_st_data *st_data;
 	int err;
 
@@ -1118,9 +1107,6 @@ static int __devinit omap_st_add(struct omap_mcbsp *mcbsp)
 		goto err1;
 	}
 
-	pdev = container_of(mcbsp->dev, struct platform_device, dev);
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sidetone");
 	st_data->io_base_st = ioremap(res->start, resource_size(res));
 	if (!st_data->io_base_st) {
 		err = -ENOMEM;
@@ -1140,61 +1126,42 @@ err2:
 	kfree(st_data);
 err1:
 	return err;
-
 }
 
-static void __devexit omap_st_remove(struct omap_mcbsp *mcbsp)
+static void __devexit omap_mcbsp_st_free(struct omap_mcbsp *mcbsp)
 {
 	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
 
-	if (st_data) {
-		sysfs_remove_group(&mcbsp->dev->kobj, &sidetone_attr_group);
-		iounmap(st_data->io_base_st);
-		kfree(st_data);
-	}
+	sysfs_remove_group(&mcbsp->dev->kobj, &sidetone_attr_group);
+	iounmap(st_data->io_base_st);
+	kfree(st_data);
 }
 
-static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp)
+static inline int __devinit omap_mcbsp_dmactrl_add(struct omap_mcbsp *mcbsp)
 {
-	mcbsp->dma_op_mode = MCBSP_DMA_MODE_ELEMENT;
-	if (mcbsp->mcbsp_config_type == MCBSP_CONFIG_TYPE3) {
-		/*
-		 * Initially configure the maximum thresholds to a safe value.
-		 * The McBSP FIFO usage with these values should not go under
-		 * 16 locations.
-		 * If the whole FIFO without safety buffer is used, than there
-		 * is a possibility that the DMA will be not able to push the
-		 * new data on time, causing channel shifts in runtime.
-		 */
-		mcbsp->max_tx_thres = max_thres(mcbsp) - 0x10;
-		mcbsp->max_rx_thres = max_thres(mcbsp) - 0x10;
-		/*
-		 * REVISIT: Set dmap_op_mode to THRESHOLD as default
-		 * for mcbsp2 instances.
-		 */
-		if (omap_additional_add(mcbsp->dev))
-			dev_warn(mcbsp->dev,
-				"Unable to create additional controls\n");
-
-		if (mcbsp->id == 2 || mcbsp->id == 3)
-			if (omap_st_add(mcbsp))
-				dev_warn(mcbsp->dev,
-				 "Unable to create sidetone controls\n");
+	int err;
 
-	} else {
-		mcbsp->max_tx_thres = -EINVAL;
-		mcbsp->max_rx_thres = -EINVAL;
-	}
+	/*
+	 * Initially configure the maximum thresholds to a safe value.
+	 * The McBSP FIFO usage with these values should not go under
+	 * 16 locations.
+	 * If the whole FIFO without safety buffer is used, than there
+	 * is a possibility that the DMA will be not able to push the
+	 * new data on time, causing channel shifts in runtime.
+	 */
+	mcbsp->max_tx_thres = max_thres(mcbsp) - 0x10;
+	mcbsp->max_rx_thres = max_thres(mcbsp) - 0x10;
+
+	err = sysfs_create_group(&mcbsp->dev->kobj, &additional_attr_group);
+	if (err)
+		dev_warn(mcbsp->dev, "Unable to create additional controls\n");
+
+	return err;
 }
 
-static inline void __devexit omap34xx_device_exit(struct omap_mcbsp *mcbsp)
+static inline void __devexit omap_mcbsp_dmactrl_free(struct omap_mcbsp *mcbsp)
 {
-	if (mcbsp->mcbsp_config_type == MCBSP_CONFIG_TYPE3) {
-		omap_additional_remove(mcbsp->dev);
-
-		if (mcbsp->id == 2 || mcbsp->id == 3)
-			omap_st_remove(mcbsp);
-	}
+	sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_group);
 }
 
 /*
@@ -1295,13 +1262,32 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 	mcbsp_ptr[id] = mcbsp;
 	mcbsp->mcbsp_config_type = pdata->mcbsp_config_type;
 	platform_set_drvdata(pdev, mcbsp);
-	pm_runtime_enable(mcbsp->dev);
 
-	/* Initialize mcbsp properties for OMAP34XX if needed / applicable */
-	omap34xx_device_init(mcbsp);
+	mcbsp->dma_op_mode = MCBSP_DMA_MODE_ELEMENT;
+	if (mcbsp->mcbsp_config_type == MCBSP_CONFIG_TYPE3) {
+		ret = omap_mcbsp_dmactrl_add(mcbsp);
+		if (ret)
+			goto err_thres;
+	} else {
+		mcbsp->max_tx_thres = -EINVAL;
+		mcbsp->max_rx_thres = -EINVAL;
+	}
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sidetone");
+	if (res) {
+		ret = omap_mcbsp_st_add(mcbsp, res);
+		if (ret)
+			goto err_st;
+	}
+
+	pm_runtime_enable(mcbsp->dev);
 
 	return 0;
 
+err_st:
+	if (mcbsp->mcbsp_config_type == MCBSP_CONFIG_TYPE3)
+		omap_mcbsp_dmactrl_free(mcbsp);
+err_thres:
+	clk_put(mcbsp->fclk);
 err_res:
 	iounmap(mcbsp->io_base);
 err_ioremap:
@@ -1316,12 +1302,14 @@ static int __devexit omap_mcbsp_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 	if (mcbsp) {
-
 		if (mcbsp->pdata && mcbsp->pdata->ops &&
 				mcbsp->pdata->ops->free)
 			mcbsp->pdata->ops->free(mcbsp->id);
 
-		omap34xx_device_exit(mcbsp);
+		if (mcbsp->mcbsp_config_type == MCBSP_CONFIG_TYPE3)
+			omap_mcbsp_dmactrl_free(mcbsp);
+		if (mcbsp->st_data)
+			omap_mcbsp_st_free(mcbsp);
 
 		clk_put(mcbsp->fclk);
 
-- 
1.7.0.4

