From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv4 05/20] OMAP: McBSP: Create and export max_(r|t)x_thres property
Date: Mon, 17 Aug 2009 14:51:04 +0300
Message-ID: <1250509879-6703-6-git-send-email-eduardo.valentin@nokia.com>
References: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23296 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757921AbZHQMF1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 08:05:27 -0400
In-Reply-To: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

This patch export through sysfs two properties to configure
maximum threshold for transmission and reception on each
mcbsp instance. Also, it exports two helper functions to
allow mcbsp users to read this values.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/mach-omap2/mcbsp.c             |    5 +
 arch/arm/plat-omap/include/mach/mcbsp.h |   11 ++
 arch/arm/plat-omap/mcbsp.c              |  172 +++++++++++++++++++++++++++++++
 3 files changed, 188 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index a5c0f04..f837114 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -129,6 +129,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
+		.buffer_size	= 0x7F,
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP2_BASE,
@@ -137,6 +138,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
+		.buffer_size	= 0x3FF,
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP3_BASE,
@@ -145,6 +147,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP3_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
+		.buffer_size	= 0x7F,
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP4_BASE,
@@ -153,6 +156,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP4_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP4_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
+		.buffer_size	= 0x7F,
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP5_BASE,
@@ -161,6 +165,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP5_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP5_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
+		.buffer_size	= 0x7F,
 	},
 };
 #define OMAP34XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap34xx_mcbsp_pdata)
diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index 2544aa5..832330d 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -348,6 +348,9 @@ struct omap_mcbsp_platform_data {
 	u8 dma_rx_sync, dma_tx_sync;
 	u16 rx_irq, tx_irq;
 	struct omap_mcbsp_ops *ops;
+#ifdef CONFIG_ARCH_OMAP34XX
+	u16 buffer_size;
+#endif
 };
 
 struct omap_mcbsp {
@@ -381,6 +384,10 @@ struct omap_mcbsp {
 	struct omap_mcbsp_platform_data *pdata;
 	struct clk *iclk;
 	struct clk *fclk;
+#ifdef CONFIG_ARCH_OMAP34XX
+	u16 max_tx_thres;
+	u16 max_rx_thres;
+#endif
 };
 extern struct omap_mcbsp **mcbsp_ptr;
 extern int omap_mcbsp_count;
@@ -392,11 +399,15 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg * config
 #ifdef CONFIG_ARCH_OMAP34XX
 void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold);
 void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold);
+u16 omap_mcbsp_get_max_tx_threshold(unsigned int id);
+u16 omap_mcbsp_get_max_rx_threshold(unsigned int id);
 #else
 static inline void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
 { }
 static inline void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold)
 { }
+static inline u16 omap_mcbsp_get_max_tx_threshold(unsigned int id) { return 0; }
+static inline u16 omap_mcbsp_get_max_rx_threshold(unsigned int id) { return 0; }
 #endif
 int omap_mcbsp_request(unsigned int id);
 void omap_mcbsp_free(unsigned int id);
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index e9dd703..0bbc912 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -198,6 +198,92 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
 }
 EXPORT_SYMBOL(omap_mcbsp_config);
 
+#ifdef CONFIG_ARCH_OMAP34XX
+/*
+ * omap_mcbsp_set_tx_threshold configures how to deal
+ * with transmit threshold. the threshold value and handler can be
+ * configure in here.
+ */
+void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
+{
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base;
+
+	if (!cpu_is_omap34xx())
+		return;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return;
+	}
+	mcbsp = id_to_mcbsp_ptr(id);
+	io_base = mcbsp->io_base;
+
+	OMAP_MCBSP_WRITE(io_base, THRSH2, threshold);
+}
+EXPORT_SYMBOL(omap_mcbsp_set_tx_threshold);
+
+/*
+ * omap_mcbsp_set_rx_threshold configures how to deal
+ * with receive threshold. the threshold value and handler can be
+ * configure in here.
+ */
+void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold)
+{
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base;
+
+	if (!cpu_is_omap34xx())
+		return;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return;
+	}
+	mcbsp = id_to_mcbsp_ptr(id);
+	io_base = mcbsp->io_base;
+
+	OMAP_MCBSP_WRITE(io_base, THRSH1, threshold);
+}
+EXPORT_SYMBOL(omap_mcbsp_set_rx_threshold);
+
+/*
+ * omap_mcbsp_get_max_tx_thres just return the current configured
+ * maximum threshold for transmission
+ */
+u16 omap_mcbsp_get_max_tx_threshold(unsigned int id)
+{
+	struct omap_mcbsp *mcbsp;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return -ENODEV;
+	}
+	mcbsp = id_to_mcbsp_ptr(id);
+
+	return mcbsp->max_tx_thres;
+}
+EXPORT_SYMBOL(omap_mcbsp_get_max_tx_threshold);
+
+/*
+ * omap_mcbsp_get_max_rx_thres just return the current configured
+ * maximum threshold for reception
+ */
+u16 omap_mcbsp_get_max_rx_threshold(unsigned int id)
+{
+	struct omap_mcbsp *mcbsp;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return -ENODEV;
+	}
+	mcbsp = id_to_mcbsp_ptr(id);
+
+	return mcbsp->max_rx_thres;
+}
+EXPORT_SYMBOL(omap_mcbsp_get_max_rx_threshold);
+#endif
+
 /*
  * We can choose between IRQ based or polled IO.
  * This needs to be called before omap_mcbsp_request().
@@ -955,6 +1041,86 @@ void omap_mcbsp_set_spi_mode(unsigned int id,
 }
 EXPORT_SYMBOL(omap_mcbsp_set_spi_mode);
 
+#ifdef CONFIG_ARCH_OMAP34XX
+#define max_thres(m)			(mcbsp->pdata->buffer_size)
+#define valid_threshold(m, val)		((val) <= max_thres(m))
+#define THRESHOLD_PROP_BUILDER(prop)					\
+static ssize_t prop##_show(struct device *dev,				\
+			struct device_attribute *attr, char *buf)	\
+{									\
+	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);		\
+									\
+	return sprintf(buf, "%u\n", mcbsp->prop);			\
+}									\
+									\
+static ssize_t prop##_store(struct device *dev,				\
+				struct device_attribute *attr,		\
+				const char *buf, size_t size)		\
+{									\
+	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);		\
+	unsigned long val;						\
+	int status;							\
+									\
+	status = strict_strtoul(buf, 0, &val);				\
+	if (status)							\
+		return status;						\
+									\
+	if (!valid_threshold(mcbsp, val))				\
+		return -EDOM;						\
+									\
+	mcbsp->prop = val;						\
+	return size;							\
+}									\
+									\
+static DEVICE_ATTR(prop, 0644, prop##_show, prop##_store);
+
+THRESHOLD_PROP_BUILDER(max_tx_thres);
+THRESHOLD_PROP_BUILDER(max_rx_thres);
+
+static const struct attribute *threshold_attrs[] = {
+	&dev_attr_max_tx_thres.attr,
+	&dev_attr_max_rx_thres.attr,
+	NULL,
+};
+
+static const struct attribute_group threshold_attr_group = {
+	.attrs = (struct attribute **)threshold_attrs,
+};
+
+static inline int __devinit omap_thres_add(struct device *dev)
+{
+	return sysfs_create_group(&dev->kobj, &threshold_attr_group);
+}
+
+static inline void __devexit omap_thres_remove(struct device *dev)
+{
+	sysfs_remove_group(&dev->kobj, &threshold_attr_group);
+}
+
+static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp)
+{
+	if (cpu_is_omap34xx()) {
+		mcbsp->max_tx_thres = max_thres(mcbsp);
+		mcbsp->max_rx_thres = max_thres(mcbsp);
+		if (omap_thres_add(mcbsp->dev))
+			dev_warn(mcbsp->dev,
+				"Unable to create threshold controls\n");
+	} else {
+		mcbsp->max_tx_thres = -EINVAL;
+		mcbsp->max_rx_thres = -EINVAL;
+	}
+}
+
+static inline void __devexit omap34xx_device_exit(struct omap_mcbsp *mcbsp)
+{
+	if (cpu_is_omap34xx())
+		omap_thres_remove(mcbsp->dev);
+}
+#else
+static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp) {}
+static inline void __devexit omap34xx_device_exit(struct omap_mcbsp *mcbsp) {}
+#endif /* CONFIG_ARCH_OMAP34XX */
+
 /*
  * McBSP1 and McBSP3 are directly mapped on 1610 and 1510.
  * 730 has only 2 McBSP, and both of them are MPU peripherals.
@@ -1025,6 +1191,10 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 	mcbsp->dev = &pdev->dev;
 	mcbsp_ptr[id] = mcbsp;
 	platform_set_drvdata(pdev, mcbsp);
+
+	/* Initialize mcbsp properties for OMAP34XX if needed / applicable */
+	omap34xx_device_init(mcbsp);
+
 	return 0;
 
 err_fclk:
@@ -1048,6 +1218,8 @@ static int __devexit omap_mcbsp_remove(struct platform_device *pdev)
 				mcbsp->pdata->ops->free)
 			mcbsp->pdata->ops->free(mcbsp->id);
 
+		omap34xx_device_exit(mcbsp);
+
 		clk_disable(mcbsp->fclk);
 		clk_disable(mcbsp->iclk);
 		clk_put(mcbsp->fclk);
-- 
1.6.2.GIT

