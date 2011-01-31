From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 11/13] OMAP: McBSP: APIs to pass DMA params from McBSP driver to client drivers
Date: Mon, 31 Jan 2011 20:20:35 +0530
Message-ID: <1296485437-12806-12-git-send-email-kishon@ti.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44048 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755908Ab1AaO4a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Jan 2011 09:56:30 -0500
In-Reply-To: <1296485437-12806-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, paul@pwsan.com, charu@ti.com, shubhrajyoti@ti.com, b-cousson@ti.com, khilman@deeprootsystems.com, p-basak2@ti.com, Kishon Vijay Abraham I <kishon@ti.com>

After McBSP driver is hwmod adapted, the information about the hw would be
obtained from the hwmod database by the mcbsp driver. Since DMA programming is
handled by the client driver, APIs are provided to pass the DMA channel number
and base address of data register required by the client driver for DMA
programming.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c             |    2 +
 arch/arm/plat-omap/include/plat/mcbsp.h |    7 +++
 arch/arm/plat-omap/mcbsp.c              |   64 +++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index e232a49..3e87527 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -125,6 +125,8 @@ static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 		return -ENOMEM;
 	}
 
+	pdata->mcbsp_config_type = oh->class->rev;
+
 	if (oh->class->rev == MCBSP_CONFIG_TYPE3) {
 		if (id == 2)
 			pdata->buffer_size = 0x500; /*FIFO size is 1024 + 256*/
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 75c176c..54058a3 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -81,6 +81,8 @@ static struct platform_device omap_mcbsp##port_nr = {	\
 #define OMAP_MCBSP_REG_DRR1	0x02
 #define OMAP_MCBSP_REG_DXR2	0x04
 #define OMAP_MCBSP_REG_DXR1	0x06
+#define OMAP_MCBSP_REG_DRR	0x02
+#define OMAP_MCBSP_REG_DXR	0x06
 #define OMAP_MCBSP_REG_SPCR2	0x08
 #define OMAP_MCBSP_REG_SPCR1	0x0a
 #define OMAP_MCBSP_REG_RCR2	0x0c
@@ -437,6 +439,7 @@ struct omap_mcbsp_platform_data {
 	unsigned long phys_base_st;
 	u16 buffer_size;
 #endif
+	unsigned int mcbsp_config_type;
 };
 
 struct omap_mcbsp_st_data {
@@ -487,6 +490,7 @@ struct omap_mcbsp {
 	u16 max_rx_thres;
 #endif
 	void *reg_cache;
+	unsigned int mcbsp_config_type;
 };
 
 /**
@@ -555,6 +559,9 @@ int omap_mcbsp_set_io_type(unsigned int id, omap_mcbsp_io_type_t io_type);
 void omap2_mcbsp1_mux_clkr_src(u8 mux);
 void omap2_mcbsp1_mux_fsr_src(u8 mux);
 
+int omap_mcbsp_dma_ch_params(unsigned int id, unsigned int stream);
+int omap_mcbsp_dma_reg_params(unsigned int id, unsigned int stream);
+
 #ifdef CONFIG_ARCH_OMAP3
 /* Sidetone specific API */
 int omap_st_set_chgain(unsigned int id, int channel, s16 chgain);
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 63938a2..1626e02 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -229,6 +229,69 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
 }
 EXPORT_SYMBOL(omap_mcbsp_config);
 
+/**
+ * omap_mcbsp_dma_params - returns the dma channel number
+ * @id - mcbsp id
+ * @stream - indicates the direction of data flow (rx or tx)
+ *
+ * Returns the dma channel number for the rx channel or tx channel
+ * based on the value of @stream for the requested mcbsp given by @id
+ */
+int omap_mcbsp_dma_ch_params(unsigned int id, unsigned int stream)
+{
+	struct omap_mcbsp *mcbsp;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return -ENODEV;
+	}
+	mcbsp = id_to_mcbsp_ptr(id);
+
+	if (stream)
+		return mcbsp->dma_rx_sync;
+	else
+		return mcbsp->dma_tx_sync;
+}
+EXPORT_SYMBOL(omap_mcbsp_dma_ch_params);
+
+/**
+ * omap_mcbsp_dma_reg_params - returns the address of mcbsp data register
+ * @id - mcbsp id
+ * @stream - indicates the direction of data flow (rx or tx)
+ *
+ * Returns the address of mcbsp data transmit register or data receive register
+ * to be used by DMA for transferring/receiving data based on the value of
+ * @stream for the requested mcbsp given by @id
+ */
+int omap_mcbsp_dma_reg_params(unsigned int id, unsigned int stream)
+{
+	struct omap_mcbsp *mcbsp;
+	int data_reg;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return -ENODEV;
+	}
+	mcbsp = id_to_mcbsp_ptr(id);
+
+	data_reg = mcbsp->phys_dma_base;
+
+	if (mcbsp->mcbsp_config_type < MCBSP_CONFIG_TYPE2) {
+		if (stream)
+			data_reg += OMAP_MCBSP_REG_DRR1;
+		else
+			data_reg += OMAP_MCBSP_REG_DXR1;
+	} else {
+		if (stream)
+			data_reg += OMAP_MCBSP_REG_DRR;
+		else
+			data_reg += OMAP_MCBSP_REG_DXR;
+	}
+
+	return data_reg;
+}
+EXPORT_SYMBOL(omap_mcbsp_dma_reg_params);
+
 #ifdef CONFIG_ARCH_OMAP3
 static struct omap_device *find_omap_device_by_dev(struct device *dev)
 {
@@ -1870,6 +1933,7 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 	mcbsp->pdata = pdata;
 	mcbsp->dev = &pdev->dev;
 	mcbsp_ptr[id] = mcbsp;
+	mcbsp->mcbsp_config_type = pdata->mcbsp_config_type;
 	platform_set_drvdata(pdev, mcbsp);
 	pm_runtime_enable(mcbsp->dev);
 
-- 
1.7.0.4

