From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH resend 06/13] omap: mcbsp: Make threshold based transfer code generic
Date: Mon, 26 Sep 2011 10:45:42 +0300
Message-ID: <1317023150-6730-7-git-send-email-jarkko.nikula@bitmer.com>
References: <1317023150-6730-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:49013 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713Ab1IZHqb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 03:46:31 -0400
In-Reply-To: <1317023150-6730-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Jarkko Nikula <jarkko.nikula@bitmer.com>

Remove CONFIG_ARCH_OMAP3 conditional compilation and cpu_is_omap34xx test
around buffer threshold based transfer and DMA operating mode control. Use
instead the buffer_size in platform data to determine when these sysfs
controls are exposed and when to access related McBSP registers. Rationale
for this is to make code generic and to allow to use it on OMAP4 that also
supports threshold based transfers.

Currently buffer_size variable is set only for OMAP3 SoCs but it is easy
to extend to OMAP4 and any later OMAP version.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 arch/arm/plat-omap/include/plat/mcbsp.h |   15 +----
 arch/arm/plat-omap/mcbsp.c              |  120 +++++++++++++++----------------
 2 files changed, 59 insertions(+), 76 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index eed20ef..0fad63c 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -354,10 +354,10 @@ struct omap_mcbsp {
 	struct clk *fclk;
 #ifdef CONFIG_ARCH_OMAP3
 	struct omap_mcbsp_st_data *st_data;
+#endif
 	int dma_op_mode;
 	u16 max_tx_thres;
 	u16 max_rx_thres;
-#endif
 	void *reg_cache;
 };
 
@@ -377,7 +377,6 @@ extern int omap_mcbsp_count, omap_mcbsp_cache_size;
 
 int omap_mcbsp_init(void);
 void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg * config);
-#ifdef CONFIG_ARCH_OMAP3
 void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold);
 void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold);
 u16 omap_mcbsp_get_max_tx_threshold(unsigned int id);
@@ -386,18 +385,6 @@ u16 omap_mcbsp_get_fifo_size(unsigned int id);
 u16 omap_mcbsp_get_tx_delay(unsigned int id);
 u16 omap_mcbsp_get_rx_delay(unsigned int id);
 int omap_mcbsp_get_dma_op_mode(unsigned int id);
-#else
-static inline void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
-{ }
-static inline void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold)
-{ }
-static inline u16 omap_mcbsp_get_max_tx_threshold(unsigned int id) { return 0; }
-static inline u16 omap_mcbsp_get_max_rx_threshold(unsigned int id) { return 0; }
-static inline u16 omap_mcbsp_get_fifo_size(unsigned int id) { return 0; }
-static inline u16 omap_mcbsp_get_tx_delay(unsigned int id) { return 0; }
-static inline u16 omap_mcbsp_get_rx_delay(unsigned int id) { return 0; }
-static inline int omap_mcbsp_get_dma_op_mode(unsigned int id) { return 0; }
-#endif
 int omap_mcbsp_request(unsigned int id);
 void omap_mcbsp_free(unsigned int id);
 void omap_mcbsp_start(unsigned int id, int tx, int rx);
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 97bcbfa..234ab16 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -492,6 +492,11 @@ int omap_st_is_enabled(unsigned int id)
 }
 EXPORT_SYMBOL(omap_st_is_enabled);
 
+#else
+static inline void omap_st_start(struct omap_mcbsp *mcbsp) {}
+static inline void omap_st_stop(struct omap_mcbsp *mcbsp) {}
+#endif
+
 /*
  * omap_mcbsp_set_rx_threshold configures the transmit threshold in words.
  * The threshold parameter is 1 based, and it is converted (threshold - 1)
@@ -501,14 +506,13 @@ void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
 {
 	struct omap_mcbsp *mcbsp;
 
-	if (!cpu_is_omap34xx() && !cpu_is_omap44xx())
-		return;
-
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
 		return;
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
+	if (mcbsp->pdata->buffer_size == 0)
+		return;
 
 	if (threshold && threshold <= mcbsp->max_tx_thres)
 		MCBSP_WRITE(mcbsp, THRSH2, threshold - 1);
@@ -524,14 +528,13 @@ void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold)
 {
 	struct omap_mcbsp *mcbsp;
 
-	if (!cpu_is_omap34xx() && !cpu_is_omap44xx())
-		return;
-
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
 		return;
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
+	if (mcbsp->pdata->buffer_size == 0)
+		return;
 
 	if (threshold && threshold <= mcbsp->max_rx_thres)
 		MCBSP_WRITE(mcbsp, THRSH1, threshold - 1);
@@ -601,6 +604,8 @@ u16 omap_mcbsp_get_tx_delay(unsigned int id)
 		return -ENODEV;
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
+	if (mcbsp->pdata->buffer_size == 0)
+		return 0;
 
 	/* Returns the number of free locations in the buffer */
 	buffstat = MCBSP_READ(mcbsp, XBUFFSTAT);
@@ -624,6 +629,8 @@ u16 omap_mcbsp_get_rx_delay(unsigned int id)
 		return -ENODEV;
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
+	if (mcbsp->pdata->buffer_size == 0)
+		return 0;
 
 	/* Returns the number of used locations in the buffer */
 	buffstat = MCBSP_READ(mcbsp, RBUFFSTAT);
@@ -659,11 +666,6 @@ int omap_mcbsp_get_dma_op_mode(unsigned int id)
 }
 EXPORT_SYMBOL(omap_mcbsp_get_dma_op_mode);
 
-#else
-static inline void omap_st_start(struct omap_mcbsp *mcbsp) {}
-static inline void omap_st_stop(struct omap_mcbsp *mcbsp) {}
-#endif
-
 int omap_mcbsp_request(unsigned int id)
 {
 	struct omap_mcbsp *mcbsp;
@@ -937,7 +939,6 @@ void omap2_mcbsp1_mux_fsr_src(u8 mux)
 }
 #endif
 
-#ifdef CONFIG_ARCH_OMAP3
 #define max_thres(m)			(mcbsp->pdata->buffer_size)
 #define valid_threshold(m, val)		((val) <= max_thres(m))
 #define THRESHOLD_PROP_BUILDER(prop)					\
@@ -1028,6 +1029,18 @@ unlock:
 
 static DEVICE_ATTR(dma_op_mode, 0644, dma_op_mode_show, dma_op_mode_store);
 
+static const struct attribute *additional_attrs[] = {
+	&dev_attr_max_tx_thres.attr,
+	&dev_attr_max_rx_thres.attr,
+	&dev_attr_dma_op_mode.attr,
+	NULL,
+};
+
+static const struct attribute_group additional_attr_group = {
+	.attrs = (struct attribute **)additional_attrs,
+};
+
+#ifdef CONFIG_ARCH_OMAP3
 static ssize_t st_taps_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
@@ -1086,27 +1099,6 @@ out:
 
 static DEVICE_ATTR(st_taps, 0644, st_taps_show, st_taps_store);
 
-static const struct attribute *additional_attrs[] = {
-	&dev_attr_max_tx_thres.attr,
-	&dev_attr_max_rx_thres.attr,
-	&dev_attr_dma_op_mode.attr,
-	NULL,
-};
-
-static const struct attribute_group additional_attr_group = {
-	.attrs = (struct attribute **)additional_attrs,
-};
-
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
@@ -1167,45 +1159,18 @@ static void __devexit omap_st_remove(struct omap_mcbsp *mcbsp)
 
 static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp)
 {
-	mcbsp->dma_op_mode = MCBSP_DMA_MODE_ELEMENT;
-	if (cpu_is_omap34xx()) {
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
+	if (cpu_is_omap34xx())
 		if (mcbsp->id == 2 || mcbsp->id == 3)
 			if (omap_st_add(mcbsp))
 				dev_warn(mcbsp->dev,
 				 "Unable to create sidetone controls\n");
-
-	} else {
-		mcbsp->max_tx_thres = -EINVAL;
-		mcbsp->max_rx_thres = -EINVAL;
-	}
 }
 
 static inline void __devexit omap34xx_device_exit(struct omap_mcbsp *mcbsp)
 {
-	if (cpu_is_omap34xx()) {
-		omap_additional_remove(mcbsp->dev);
-
+	if (cpu_is_omap34xx())
 		if (mcbsp->id == 2 || mcbsp->id == 3)
 			omap_st_remove(mcbsp);
-	}
 }
 #else
 static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp) {}
@@ -1311,11 +1276,38 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, mcbsp);
 	pm_runtime_enable(mcbsp->dev);
 
+	mcbsp->dma_op_mode = MCBSP_DMA_MODE_ELEMENT;
+	if (mcbsp->pdata->buffer_size) {
+		/*
+		 * Initially configure the maximum thresholds to a safe value.
+		 * The McBSP FIFO usage with these values should not go under
+		 * 16 locations.
+		 * If the whole FIFO without safety buffer is used, than there
+		 * is a possibility that the DMA will be not able to push the
+		 * new data on time, causing channel shifts in runtime.
+		 */
+		mcbsp->max_tx_thres = max_thres(mcbsp) - 0x10;
+		mcbsp->max_rx_thres = max_thres(mcbsp) - 0x10;
+
+		ret = sysfs_create_group(&mcbsp->dev->kobj,
+					 &additional_attr_group);
+		if (ret) {
+			dev_err(mcbsp->dev,
+				"Unable to create additional controls\n");
+			goto err_thres;
+		}
+	} else {
+		mcbsp->max_tx_thres = -EINVAL;
+		mcbsp->max_rx_thres = -EINVAL;
+	}
+
 	/* Initialize mcbsp properties for OMAP34XX if needed / applicable */
 	omap34xx_device_init(mcbsp);
 
 	return 0;
 
+err_thres:
+	clk_put(mcbsp->fclk);
 err_res:
 	iounmap(mcbsp->io_base);
 err_ioremap:
@@ -1335,6 +1327,10 @@ static int __devexit omap_mcbsp_remove(struct platform_device *pdev)
 				mcbsp->pdata->ops->free)
 			mcbsp->pdata->ops->free(mcbsp->id);
 
+		if (mcbsp->pdata->buffer_size)
+			sysfs_remove_group(&mcbsp->dev->kobj,
+					   &additional_attr_group);
+
 		omap34xx_device_exit(mcbsp);
 
 		clk_put(mcbsp->fclk);
-- 
1.7.6.3

