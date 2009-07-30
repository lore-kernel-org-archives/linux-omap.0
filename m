From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 11/20] OMAP: McBSP: Add link DMA mode selection
Date: Thu, 30 Jul 2009 15:49:34 +0300
Message-ID: <1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-9-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-11-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:37365 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbZG3NBC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jul 2009 09:01:02 -0400
In-Reply-To: <1248958183-15015-11-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Peter Ujfalusi <peter.ujfalusi@nokia.com>

It adds a new sysfs file, where the user can configure the mcbsp mode to use.
If the mcbsp channel is in use, it does not allow the change.
Than in omap_pcm_open we can call the omap_mcbsp_get_opmode to get the mode,
store it, than use it to implement the different modes.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/include/mach/mcbsp.h |    8 +++
 arch/arm/plat-omap/mcbsp.c              |   73 +++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index b0fc675..61c55ec 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -275,6 +275,11 @@
 #define RSYNCERREN		0x0001
 #define WAKEUPEN_ALL		(XRDYEN | RRDYEN)
 
+/********************** McBSP DMA operating modes **************************/
+#define MCBSP_DMA_MODE_ELEMENT		0
+#define MCBSP_DMA_MODE_THRESHOLD	1
+#define MCBSP_DMA_MODE_FRAME		2
+
 /* we don't do multichannel for now */
 struct omap_mcbsp_reg_cfg {
 	u16 spcr2;
@@ -405,6 +410,7 @@ struct omap_mcbsp {
 	struct clk *iclk;
 	struct clk *fclk;
 #ifdef CONFIG_ARCH_OMAP34XX
+	int dma_op_mode;
 	u16 max_tx_thres;
 	u16 max_rx_thres;
 #endif
@@ -421,6 +427,7 @@ void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold);
 void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold);
 u16 omap_mcbsp_get_max_tx_threshold(unsigned int id);
 u16 omap_mcbsp_get_max_rx_threshold(unsigned int id);
+int omap_mcbsp_get_dma_op_mode(unsigned int id);
 #else
 static inline void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
 { }
@@ -428,6 +435,7 @@ static inline void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold)
 { }
 static inline u16 omap_mcbsp_get_max_tx_threshold(unsigned int id) { return 0; }
 static inline u16 omap_mcbsp_get_max_rx_threshold(unsigned int id) { return 0; }
+static inline int omap_mcbsp_get_dma_op_mode(unsigned int id) { return 0; }
 #endif
 int omap_mcbsp_request(unsigned int id);
 void omap_mcbsp_free(unsigned int id);
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 1b8ff9e..6c535b3 100644
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
@@ -1093,9 +1116,57 @@ static DEVICE_ATTR(prop, 0644, prop##_show, prop##_store);
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
+	return sprintf(buf, "%d\n", dma_op_mode);
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
 
@@ -1195,12 +1266,14 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 	if (cpu_is_omap34xx()) {
 		mcbsp->max_tx_thres = max_thres(mcbsp);
 		mcbsp->max_rx_thres = max_thres(mcbsp);
+		mcbsp->dma_op_mode = MCBSP_DMA_MODE_THRESHOLD;
 		if (omap_additional_add(pdev))
 			dev_warn(&pdev->dev,
 				"Unable to create threshold controls\n");
 	} else {
 		mcbsp->max_tx_thres = -EINVAL;
 		mcbsp->max_rx_thres = -EINVAL;
+		mcbsp->dma_op_mode = MCBSP_DMA_MODE_ELEMENT;
 	}
  #endif
 
-- 
1.6.2.GIT

