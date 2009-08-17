From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv4 08/20] OMAP: McBSP: Add link DMA mode selection
Date: Mon, 17 Aug 2009 14:51:07 +0300
Message-ID: <1250509879-6703-9-git-send-email-eduardo.valentin@nokia.com>
References: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23333 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757928AbZHQMFa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 08:05:30 -0400
In-Reply-To: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Peter Ujfalusi <peter.ujfalusi@nokia.com>

It adds a new sysfs file, where the user can configure the mcbsp mode to use.
If the mcbsp channel is in use, it does not allow the change.
Than in omap_pcm_open we can call the omap_mcbsp_get_opmode to get the mode,
store it, than use it to implement the different modes.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/include/mach/mcbsp.h |    8 +++
 arch/arm/plat-omap/mcbsp.c              |   84 +++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index 832330d..bd5b759 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -255,6 +255,11 @@
 /********************** McBSP SYSCONFIG bit definitions ********************/
 #define SOFTRST			0x0002
 
+/********************** McBSP DMA operating modes **************************/
+#define MCBSP_DMA_MODE_ELEMENT		0
+#define MCBSP_DMA_MODE_THRESHOLD	1
+#define MCBSP_DMA_MODE_FRAME		2
+
 /* we don't do multichannel for now */
 struct omap_mcbsp_reg_cfg {
 	u16 spcr2;
@@ -385,6 +390,7 @@ struct omap_mcbsp {
 	struct clk *iclk;
 	struct clk *fclk;
 #ifdef CONFIG_ARCH_OMAP34XX
+	int dma_op_mode;
 	u16 max_tx_thres;
 	u16 max_rx_thres;
 #endif
@@ -401,6 +407,7 @@ void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold);
 void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold);
 u16 omap_mcbsp_get_max_tx_threshold(unsigned int id);
 u16 omap_mcbsp_get_max_rx_threshold(unsigned int id);
+int omap_mcbsp_get_dma_op_mode(unsigned int id);
 #else
 static inline void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
 { }
@@ -408,6 +415,7 @@ static inline void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold)
 { }
 static inline u16 omap_mcbsp_get_max_tx_threshold(unsigned int id) { return 0; }
 static inline u16 omap_mcbsp_get_max_rx_threshold(unsigned int id) { return 0; }
+static inline int omap_mcbsp_get_dma_op_mode(unsigned int id) { return 0; }
 #endif
 int omap_mcbsp_request(unsigned int id);
 void omap_mcbsp_free(unsigned int id);
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index ccaa9ae..9e69994 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -282,6 +282,29 @@ u16 omap_mcbsp_get_max_rx_threshold(unsigned int id)
 	return mcbsp->max_rx_thres;
 }
 EXPORT_SYMBOL(omap_mcbsp_get_max_rx_threshold);
+
+/*
+ * omap_mcbsp_get_dma_op_mode just return the current configured
+ * operating mode for the mcbsp channel
+ */
+int omap_mcbsp_get_dma_op_mode(unsigned int id)
+{
+	struct omap_mcbsp *mcbsp;
+	int dma_op_mode;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%u)\n", __func__, id + 1);
+		return -ENODEV;
+	}
+	mcbsp = id_to_mcbsp_ptr(id);
+
+	spin_lock_irq(&mcbsp->lock);
+	dma_op_mode = mcbsp->dma_op_mode;
+	spin_unlock_irq(&mcbsp->lock);
+
+	return dma_op_mode;
+}
+EXPORT_SYMBOL(omap_mcbsp_get_dma_op_mode);
 #endif
 
 /*
@@ -1077,9 +1100,65 @@ static DEVICE_ATTR(prop, 0644, prop##_show, prop##_store);
 THRESHOLD_PROP_BUILDER(max_tx_thres);
 THRESHOLD_PROP_BUILDER(max_rx_thres);
 
+static ssize_t dma_op_mode_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);
+	int dma_op_mode;
+
+	spin_lock_irq(&mcbsp->lock);
+	dma_op_mode = mcbsp->dma_op_mode;
+	spin_unlock_irq(&mcbsp->lock);
+
+	return sprintf(buf, "current mode: %d\n"
+			"possible mode values are:\n"
+			"%d - %s\n"
+			"%d - %s\n"
+			"%d - %s\n",
+			dma_op_mode,
+			MCBSP_DMA_MODE_ELEMENT, "element mode",
+			MCBSP_DMA_MODE_THRESHOLD, "threshold mode",
+			MCBSP_DMA_MODE_FRAME, "frame mode");
+}
+
+static ssize_t dma_op_mode_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t size)
+{
+	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);
+	unsigned long val;
+	int status;
+
+	status = strict_strtoul(buf, 0, &val);
+	if (status)
+		return status;
+
+	spin_lock_irq(&mcbsp->lock);
+
+	if (!mcbsp->free) {
+		size = -EBUSY;
+		goto unlock;
+	}
+
+	if (val > MCBSP_DMA_MODE_FRAME || val < MCBSP_DMA_MODE_ELEMENT) {
+		size = -EINVAL;
+		goto unlock;
+	}
+
+	mcbsp->dma_op_mode = val;
+
+unlock:
+	spin_unlock_irq(&mcbsp->lock);
+
+	return size;
+}
+
+static DEVICE_ATTR(dma_op_mode, 0644, dma_op_mode_show, dma_op_mode_store);
+
 static const struct attribute *additional_attrs[] = {
 	&dev_attr_max_tx_thres.attr,
 	&dev_attr_max_rx_thres.attr,
+	&dev_attr_dma_op_mode.attr,
 	NULL,
 };
 
@@ -1099,9 +1178,14 @@ static inline void __devexit omap_additional_remove(struct device *dev)
 
 static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp)
 {
+	mcbsp->dma_op_mode = MCBSP_DMA_MODE_ELEMENT;
 	if (cpu_is_omap34xx()) {
 		mcbsp->max_tx_thres = max_thres(mcbsp);
 		mcbsp->max_rx_thres = max_thres(mcbsp);
+		/*
+		 * REVISIT: Set dmap_op_mode to THRESHOLD as default
+		 * for mcbsp2 instances.
+		 */
 		if (omap_additional_add(mcbsp->dev))
 			dev_warn(mcbsp->dev,
 				"Unable to create additional controls\n");
-- 
1.6.2.GIT

