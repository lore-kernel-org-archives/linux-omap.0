From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 04/10] ASoC: omap-mcbsp: Create a single driver for McBSP
Date: Tue, 28 Feb 2012 09:40:14 +0200
Message-ID: <1330414820-4641-5-git-send-email-peter.ujfalusi@ti.com>
References: <1330414820-4641-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:52499 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756488Ab2B1Hko (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 02:40:44 -0500
Received: by lahc1 with SMTP id c1so118740lah.40
        for <linux-omap@vger.kernel.org>; Mon, 27 Feb 2012 23:40:41 -0800 (PST)
In-Reply-To: <1330414820-4641-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Grazvydas Ignotas <notasas@gmail.com>

The OMAP McBSP driver stack used to contain two different
drivers. One of them was used as kind low-level access to
the IP, while the other driver was the ASoC DAI driver.
There were global, shared structures, in different places,
the McBSP instances are reffered with id numbers (sometimes
0 based, in other cases 1 based id numbers).

Create one single driver for OMAP McBSP with name: omap-mcbsp.
Convert the old omap-mcbsp driver initially to be a library
for the omap-mcbsp DAI driver. With this change we can get rid
of all global variables, structures.

Further cleanup is coming...

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Grazvydas Ignotas <notasas@gmail.com>
Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 arch/arm/mach-omap1/mcbsp.c             |   12 --
 arch/arm/mach-omap2/mcbsp.c             |    6 -
 arch/arm/plat-omap/include/plat/mcbsp.h |   40 -----
 sound/soc/omap/am3517evm.c              |    2 +-
 sound/soc/omap/ams-delta.c              |    2 +-
 sound/soc/omap/igep0020.c               |    2 +-
 sound/soc/omap/mcbsp.c                  |  284 ++++--------------------------
 sound/soc/omap/mcbsp.h                  |  104 +++++++++---
 sound/soc/omap/n810.c                   |    2 +-
 sound/soc/omap/omap-mcbsp.c             |  201 +++++++++++------------
 sound/soc/omap/omap-mcbsp.h             |    2 +-
 sound/soc/omap/omap-pcm.h               |    2 +
 sound/soc/omap/omap3beagle.c            |    2 +-
 sound/soc/omap/omap3evm.c               |    2 +-
 sound/soc/omap/omap3pandora.c           |    4 +-
 sound/soc/omap/osk5912.c                |    2 +-
 sound/soc/omap/overo.c                  |    2 +-
 sound/soc/omap/rx51.c                   |    4 +-
 sound/soc/omap/sdp3430.c                |    4 +-
 sound/soc/omap/zoom2.c                  |    4 +-
 20 files changed, 234 insertions(+), 449 deletions(-)

diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index fe11e13..3e8410a 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -420,18 +420,6 @@ static int __init omap1_mcbsp_init(void)
 		return -ENODEV;
 
 	if (cpu_is_omap7xx())
-		omap_mcbsp_count = OMAP7XX_MCBSP_COUNT;
-	else if (cpu_is_omap15xx())
-		omap_mcbsp_count = OMAP15XX_MCBSP_COUNT;
-	else if (cpu_is_omap16xx())
-		omap_mcbsp_count = OMAP16XX_MCBSP_COUNT;
-
-	mcbsp_ptr = kzalloc(omap_mcbsp_count * sizeof(struct omap_mcbsp *),
-								GFP_KERNEL);
-	if (!mcbsp_ptr)
-		return -ENOMEM;
-
-	if (cpu_is_omap7xx())
 		omap_mcbsp_register_board_cfg(omap7xx_mcbsp_res_0,
 					OMAP7XX_MCBSP_RES_SZ,
 					omap7xx_mcbsp_pdata,
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index b36d443..49ff5b8 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -180,7 +180,6 @@ static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 					name, oh->name);
 		return PTR_ERR(pdev);
 	}
-	omap_mcbsp_count++;
 	return 0;
 }
 
@@ -188,11 +187,6 @@ static int __init omap2_mcbsp_init(void)
 {
 	omap_hwmod_for_each_by_class("mcbsp", omap_init_mcbsp, NULL);
 
-	mcbsp_ptr = kzalloc(omap_mcbsp_count * sizeof(struct omap_mcbsp *),
-								GFP_KERNEL);
-	if (!mcbsp_ptr)
-		return -ENOMEM;
-
 	return 0;
 }
 arch_initcall(omap2_mcbsp_init);
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 1a9e98f..437e375 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -70,43 +70,6 @@ struct omap_mcbsp_platform_data {
 	int (*mux_signal)(struct device *dev, const char *signal, const char *src);
 };
 
-struct omap_mcbsp_st_data {
-	void __iomem *io_base_st;
-	bool running;
-	bool enabled;
-	s16 taps[128];	/* Sidetone filter coefficients */
-	int nr_taps;	/* Number of filter coefficients in use */
-	s16 ch0gain;
-	s16 ch1gain;
-};
-
-struct omap_mcbsp {
-	struct device *dev;
-	unsigned long phys_base;
-	unsigned long phys_dma_base;
-	void __iomem *io_base;
-	u8 id;
-	u8 free;
-
-	int rx_irq;
-	int tx_irq;
-
-	/* DMA stuff */
-	u8 dma_rx_sync;
-	u8 dma_tx_sync;
-
-	/* Protect the field .free, while checking if the mcbsp is in use */
-	spinlock_t lock;
-	struct omap_mcbsp_platform_data *pdata;
-	struct clk *fclk;
-	struct omap_mcbsp_st_data *st_data;
-	int dma_op_mode;
-	u16 max_tx_thres;
-	u16 max_rx_thres;
-	void *reg_cache;
-	int reg_cache_size;
-};
-
 /**
  * omap_mcbsp_dev_attr - OMAP McBSP device attributes for omap_hwmod
  * @sidetone: name of the sidetone device
@@ -115,7 +78,4 @@ struct omap_mcbsp_dev_attr {
 	const char *sidetone;
 };
 
-extern struct omap_mcbsp **mcbsp_ptr;
-extern int omap_mcbsp_count;
-
 #endif
diff --git a/sound/soc/omap/am3517evm.c b/sound/soc/omap/am3517evm.c
index add4866..009533a 100644
--- a/sound/soc/omap/am3517evm.c
+++ b/sound/soc/omap/am3517evm.c
@@ -95,7 +95,7 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static struct snd_soc_dai_link am3517evm_dai = {
 	.name = "TLV320AIC23",
 	.stream_name = "AIC23",
-	.cpu_dai_name ="omap-mcbsp-dai.0",
+	.cpu_dai_name = "omap-mcbsp.1",
 	.codec_dai_name = "tlv320aic23-hifi",
 	.platform_name = "omap-pcm-audio",
 	.codec_name = "tlv320aic23-codec.2-001a",
diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index 78563bb..49fe63c 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -584,7 +584,7 @@ static int ams_delta_cx20442_init(struct snd_soc_pcm_runtime *rtd)
 static struct snd_soc_dai_link ams_delta_dai_link = {
 	.name = "CX20442",
 	.stream_name = "CX20442",
-	.cpu_dai_name ="omap-mcbsp-dai.0",
+	.cpu_dai_name = "omap-mcbsp.1",
 	.codec_dai_name = "cx20442-voice",
 	.init = ams_delta_cx20442_init,
 	.platform_name = "omap-pcm-audio",
diff --git a/sound/soc/omap/igep0020.c b/sound/soc/omap/igep0020.c
index ccae58a..e835781 100644
--- a/sound/soc/omap/igep0020.c
+++ b/sound/soc/omap/igep0020.c
@@ -60,7 +60,7 @@ static struct snd_soc_ops igep2_ops = {
 static struct snd_soc_dai_link igep2_dai = {
 	.name = "TWL4030",
 	.stream_name = "TWL4030",
-	.cpu_dai_name = "omap-mcbsp-dai.1",
+	.cpu_dai_name = "omap-mcbsp.2",
 	.codec_dai_name = "twl4030-hifi",
 	.platform_name = "omap-pcm-audio",
 	.codec_name = "twl4030-codec",
diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index 20d46bf..be92a28 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -30,12 +30,6 @@
 
 #include "mcbsp.h"
 
-struct omap_mcbsp **mcbsp_ptr;
-int omap_mcbsp_count;
-
-#define omap_mcbsp_check_valid_id(id)	(id < omap_mcbsp_count)
-#define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];
-
 static void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
 {
 	void __iomem *addr = mcbsp->io_base + reg * mcbsp->pdata->reg_step;
@@ -84,10 +78,8 @@ static int omap_mcbsp_st_read(struct omap_mcbsp *mcbsp, u16 reg)
 #define MCBSP_ST_WRITE(mcbsp, reg, val) \
 			omap_mcbsp_st_write(mcbsp, OMAP_ST_REG_##reg, val)
 
-static void omap_mcbsp_dump_reg(u8 id)
+static void omap_mcbsp_dump_reg(struct omap_mcbsp *mcbsp)
 {
-	struct omap_mcbsp *mcbsp = id_to_mcbsp_ptr(id);
-
 	dev_dbg(mcbsp->dev, "**** McBSP%d regs ****\n", mcbsp->id);
 	dev_dbg(mcbsp->dev, "DRR2:  0x%04x\n",
 			MCBSP_READ(mcbsp, DRR2));
@@ -160,16 +152,9 @@ static irqreturn_t omap_mcbsp_rx_irq_handler(int irq, void *dev_id)
  * You either call this function or set the McBSP registers
  * by yourself before calling omap_mcbsp_start().
  */
-void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
+void omap_mcbsp_config(struct omap_mcbsp *mcbsp,
+		       const struct omap_mcbsp_reg_cfg *config)
 {
-	struct omap_mcbsp *mcbsp;
-
-	if (!omap_mcbsp_check_valid_id(id)) {
-		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
-		return;
-	}
-	mcbsp = id_to_mcbsp_ptr(id);
-
 	dev_dbg(mcbsp->dev, "Configuring McBSP%d  phys_base: 0x%08lx\n",
 			mcbsp->id, mcbsp->phys_base);
 
@@ -190,7 +175,6 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
 		MCBSP_WRITE(mcbsp, RCCR, config->rccr);
 	}
 }
-EXPORT_SYMBOL(omap_mcbsp_config);
 
 /**
  * omap_mcbsp_dma_params - returns the dma channel number
@@ -200,22 +184,13 @@ EXPORT_SYMBOL(omap_mcbsp_config);
  * Returns the dma channel number for the rx channel or tx channel
  * based on the value of @stream for the requested mcbsp given by @id
  */
-int omap_mcbsp_dma_ch_params(unsigned int id, unsigned int stream)
+int omap_mcbsp_dma_ch_params(struct omap_mcbsp *mcbsp, unsigned int stream)
 {
-	struct omap_mcbsp *mcbsp;
-
-	if (!omap_mcbsp_check_valid_id(id)) {
-		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
-		return -ENODEV;
-	}
-	mcbsp = id_to_mcbsp_ptr(id);
-
 	if (stream)
 		return mcbsp->dma_rx_sync;
 	else
 		return mcbsp->dma_tx_sync;
 }
-EXPORT_SYMBOL(omap_mcbsp_dma_ch_params);
 
 /**
  * omap_mcbsp_dma_reg_params - returns the address of mcbsp data register
@@ -226,17 +201,10 @@ EXPORT_SYMBOL(omap_mcbsp_dma_ch_params);
  * to be used by DMA for transferring/receiving data based on the value of
  * @stream for the requested mcbsp given by @id
  */
-int omap_mcbsp_dma_reg_params(unsigned int id, unsigned int stream)
+int omap_mcbsp_dma_reg_params(struct omap_mcbsp *mcbsp, unsigned int stream)
 {
-	struct omap_mcbsp *mcbsp;
 	int data_reg;
 
-	if (!omap_mcbsp_check_valid_id(id)) {
-		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
-		return -ENODEV;
-	}
-	mcbsp = id_to_mcbsp_ptr(id);
-
 	if (mcbsp->pdata->reg_size == 2) {
 		if (stream)
 			data_reg = OMAP_MCBSP_REG_DRR1;
@@ -251,7 +219,6 @@ int omap_mcbsp_dma_reg_params(unsigned int id, unsigned int stream)
 
 	return mcbsp->phys_dma_base + data_reg * mcbsp->pdata->reg_step;
 }
-EXPORT_SYMBOL(omap_mcbsp_dma_reg_params);
 
 static void omap_st_on(struct omap_mcbsp *mcbsp)
 {
@@ -320,18 +287,11 @@ static void omap_st_chgain(struct omap_mcbsp *mcbsp)
 		      ST_CH1GAIN(st_data->ch1gain));
 }
 
-int omap_st_set_chgain(unsigned int id, int channel, s16 chgain)
+int omap_st_set_chgain(struct omap_mcbsp *mcbsp, int channel, s16 chgain)
 {
-	struct omap_mcbsp *mcbsp;
 	struct omap_mcbsp_st_data *st_data;
 	int ret = 0;
 
-	if (!omap_mcbsp_check_valid_id(id)) {
-		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
-		return -ENODEV;
-	}
-
-	mcbsp = id_to_mcbsp_ptr(id);
 	st_data = mcbsp->st_data;
 
 	if (!st_data)
@@ -351,20 +311,12 @@ int omap_st_set_chgain(unsigned int id, int channel, s16 chgain)
 
 	return ret;
 }
-EXPORT_SYMBOL(omap_st_set_chgain);
 
-int omap_st_get_chgain(unsigned int id, int channel, s16 *chgain)
+int omap_st_get_chgain(struct omap_mcbsp *mcbsp, int channel, s16 *chgain)
 {
-	struct omap_mcbsp *mcbsp;
 	struct omap_mcbsp_st_data *st_data;
 	int ret = 0;
 
-	if (!omap_mcbsp_check_valid_id(id)) {
-		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
-		return -ENODEV;
-	}
-
-	mcbsp = id_to_mcbsp_ptr(id);
 	st_data = mcbsp->st_data;
 
 	if (!st_data)
@@ -381,7 +333,6 @@ int omap_st_get_chgain(unsigned int id, int channel, s16 *chgain)
 
 	return ret;
 }
-EXPORT_SYMBOL(omap_st_get_chgain);
 
 static int omap_st_start(struct omap_mcbsp *mcbsp)
 {
@@ -400,17 +351,10 @@ static int omap_st_start(struct omap_mcbsp *mcbsp)
 	return 0;
 }
 
-int omap_st_enable(unsigned int id)
+int omap_st_enable(struct omap_mcbsp *mcbsp)
 {
-	struct omap_mcbsp *mcbsp;
 	struct omap_mcbsp_st_data *st_data;
 
-	if (!omap_mcbsp_check_valid_id(id)) {
-		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
-		return -ENODEV;
-	}
-
-	mcbsp = id_to_mcbsp_ptr(id);
 	st_data = mcbsp->st_data;
 
 	if (!st_data)
@@ -423,7 +367,6 @@ int omap_st_enable(unsigned int id)
 
 	return 0;
 }
-EXPORT_SYMBOL(omap_st_enable);
 
 static int omap_st_stop(struct omap_mcbsp *mcbsp)
 {
@@ -439,18 +382,11 @@ static int omap_st_stop(struct omap_mcbsp *mcbsp)
 	return 0;
 }
 
-int omap_st_disable(unsigned int id)
+int omap_st_disable(struct omap_mcbsp *mcbsp)
 {
-	struct omap_mcbsp *mcbsp;
 	struct omap_mcbsp_st_data *st_data;
 	int ret = 0;
 
-	if (!omap_mcbsp_check_valid_id(id)) {
-		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
-		return -ENODEV;
-	}
-
-	mcbsp = id_to_mcbsp_ptr(id);
 	st_data = mcbsp->st_data;
 
 	if (!st_data)
@@ -463,19 +399,11 @@ int omap_st_disable(unsigned int id)
 
 	return ret;
 }
-EXPORT_SYMBOL(omap_st_disable);
 
-int omap_st_is_enabled(unsigned int id)
+int omap_st_is_enabled(struct omap_mcbsp *mcbsp)
 {
-	struct omap_mcbsp *mcbsp;
 	struct omap_mcbsp_st_data *st_data;
 
-	if (!omap_mcbsp_check_valid_id(id)) {
-		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
-		return -ENODEV;
-	}
-
-	mcbsp = id_to_mcbsp_ptr(id);
 	st_data = mcbsp->st_data;
 
 	if (!st_data)
@@ -484,115 +412,65 @@ int omap_st_is_enabled(unsigned int id)
 
 	return st_data->enabled;
 }
-EXPORT_SYMBOL(omap_st_is_enabled);
 
 /*
  * omap_mcbsp_set_rx_threshold configures the transmit threshold in words.
  * The threshold parameter is 1 based, and it is converted (threshold - 1)
  * for the THRSH2 register.
  */
-void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
+void omap_mcbsp_set_tx_threshold(struct omap_mcbsp *mcbsp, u16 threshold)
 {
-	struct omap_mcbsp *mcbsp;
-
-	if (!omap_mcbsp_check_valid_id(id)) {
-		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
-		return;
-	}
-	mcbsp = id_to_mcbsp_ptr(id);
 	if (mcbsp->pdata->buffer_size == 0)
 		return;
 
 	if (threshold && threshold <= mcbsp->max_tx_thres)
 		MCBSP_WRITE(mcbsp, THRSH2, threshold - 1);
 }
-EXPORT_SYMBOL(omap_mcbsp_set_tx_threshold);
 
 /*
  * omap_mcbsp_set_rx_threshold configures the receive threshold in words.
  * The threshold parameter is 1 based, and it is converted (threshold - 1)
  * for the THRSH1 register.
  */
-void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold)
+void omap_mcbsp_set_rx_threshold(struct omap_mcbsp *mcbsp, u16 threshold)
 {
-	struct omap_mcbsp *mcbsp;
-
-	if (!omap_mcbsp_check_valid_id(id)) {
-		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
-		return;
-	}
-	mcbsp = id_to_mcbsp_ptr(id);
 	if (mcbsp->pdata->buffer_size == 0)
 		return;
 
 	if (threshold && threshold <= mcbsp->max_rx_thres)
 		MCBSP_WRITE(mcbsp, THRSH1, threshold - 1);
 }
-EXPORT_SYMBOL(omap_mcbsp_set_rx_threshold);
 
 /*
  * omap_mcbsp_get_max_tx_thres just return the current configured
  * maximum threshold for transmission
  */
-u16 omap_mcbsp_get_max_tx_threshold(unsigned int id)
+u16 omap_mcbsp_get_max_tx_threshold(struct omap_mcbsp *mcbsp)
 {
-	struct omap_mcbsp *mcbsp;
-
-	if (!omap_mcbsp_check_valid_id(id)) {
-		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
-		return -ENODEV;
-	}
-	mcbsp = id_to_mcbsp_ptr(id);
-
 	return mcbsp->max_tx_thres;
 }
-EXPORT_SYMBOL(omap_mcbsp_get_max_tx_threshold);
 
 /*
  * omap_mcbsp_get_max_rx_thres just return the current configured
  * maximum threshold for reception
  */
-u16 omap_mcbsp_get_max_rx_threshold(unsigned int id)
+u16 omap_mcbsp_get_max_rx_threshold(struct omap_mcbsp *mcbsp)
 {
-	struct omap_mcbsp *mcbsp;
-
-	if (!omap_mcbsp_check_valid_id(id)) {
-		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
-		return -ENODEV;
-	}
-	mcbsp = id_to_mcbsp_ptr(id);
-
 	return mcbsp->max_rx_thres;
 }
-EXPORT_SYMBOL(omap_mcbsp_get_max_rx_threshold);
 
-u16 omap_mcbsp_get_fifo_size(unsigned int id)
+u16 omap_mcbsp_get_fifo_size(struct omap_mcbsp *mcbsp)
 {
-	struct omap_mcbsp *mcbsp;
-
-	if (!omap_mcbsp_check_valid_id(id)) {
-		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
-		return -ENODEV;
-	}
-	mcbsp = id_to_mcbsp_ptr(id);
-
 	return mcbsp->pdata->buffer_size;
 }
-EXPORT_SYMBOL(omap_mcbsp_get_fifo_size);
 
 /*
  * omap_mcbsp_get_tx_delay returns the number of used slots in the McBSP FIFO
  */
-u16 omap_mcbsp_get_tx_delay(unsigned int id)
+u16 omap_mcbsp_get_tx_delay(struct omap_mcbsp *mcbsp)
 {
-	struct omap_mcbsp *mcbsp;
 	u16 buffstat;
 
-	if (!omap_mcbsp_check_valid_id(id)) {
-		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
-		return -ENODEV;
-	}
-	mcbsp = id_to_mcbsp_ptr(id);
 	if (mcbsp->pdata->buffer_size == 0)
 		return 0;
 
@@ -602,22 +480,15 @@ u16 omap_mcbsp_get_tx_delay(unsigned int id)
 	/* Number of slots are different in McBSP ports */
 	return mcbsp->pdata->buffer_size - buffstat;
 }
-EXPORT_SYMBOL(omap_mcbsp_get_tx_delay);
 
 /*
  * omap_mcbsp_get_rx_delay returns the number of free slots in the McBSP FIFO
  * to reach the threshold value (when the DMA will be triggered to read it)
  */
-u16 omap_mcbsp_get_rx_delay(unsigned int id)
+u16 omap_mcbsp_get_rx_delay(struct omap_mcbsp *mcbsp)
 {
-	struct omap_mcbsp *mcbsp;
 	u16 buffstat, threshold;
 
-	if (!omap_mcbsp_check_valid_id(id)) {
-		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
-		return -ENODEV;
-	}
-	mcbsp = id_to_mcbsp_ptr(id);
 	if (mcbsp->pdata->buffer_size == 0)
 		return 0;
 
@@ -632,41 +503,25 @@ u16 omap_mcbsp_get_rx_delay(unsigned int id)
 	else
 		return threshold - buffstat;
 }
-EXPORT_SYMBOL(omap_mcbsp_get_rx_delay);
 
 /*
  * omap_mcbsp_get_dma_op_mode just return the current configured
  * operating mode for the mcbsp channel
  */
-int omap_mcbsp_get_dma_op_mode(unsigned int id)
+int omap_mcbsp_get_dma_op_mode(struct omap_mcbsp *mcbsp)
 {
-	struct omap_mcbsp *mcbsp;
 	int dma_op_mode;
 
-	if (!omap_mcbsp_check_valid_id(id)) {
-		printk(KERN_ERR "%s: Invalid id (%u)\n", __func__, id + 1);
-		return -ENODEV;
-	}
-	mcbsp = id_to_mcbsp_ptr(id);
-
 	dma_op_mode = mcbsp->dma_op_mode;
 
 	return dma_op_mode;
 }
-EXPORT_SYMBOL(omap_mcbsp_get_dma_op_mode);
 
-int omap_mcbsp_request(unsigned int id)
+int omap_mcbsp_request(struct omap_mcbsp *mcbsp)
 {
-	struct omap_mcbsp *mcbsp;
 	void *reg_cache;
 	int err;
 
-	if (!omap_mcbsp_check_valid_id(id)) {
-		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
-		return -ENODEV;
-	}
-	mcbsp = id_to_mcbsp_ptr(id);
-
 	reg_cache = kzalloc(mcbsp->reg_cache_size, GFP_KERNEL);
 	if (!reg_cache) {
 		return -ENOMEM;
@@ -685,9 +540,7 @@ int omap_mcbsp_request(unsigned int id)
 	spin_unlock(&mcbsp->lock);
 
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->request)
-		mcbsp->pdata->ops->request(id);
-
-	pm_runtime_get_sync(mcbsp->dev);
+		mcbsp->pdata->ops->request(mcbsp->id - 1);
 
 	/* Enable wakeup behavior */
 	if (mcbsp->pdata->has_wakeup)
@@ -726,14 +579,12 @@ err_free_irq:
 	free_irq(mcbsp->tx_irq, (void *)mcbsp);
 err_clk_disable:
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
-		mcbsp->pdata->ops->free(id);
+		mcbsp->pdata->ops->free(mcbsp->id - 1);
 
 	/* Disable wakeup behavior */
 	if (mcbsp->pdata->has_wakeup)
 		MCBSP_WRITE(mcbsp, WAKEUPEN, 0);
 
-	pm_runtime_put_sync(mcbsp->dev);
-
 	spin_lock(&mcbsp->lock);
 	mcbsp->free = true;
 	mcbsp->reg_cache = NULL;
@@ -743,28 +594,18 @@ err_kfree:
 
 	return err;
 }
-EXPORT_SYMBOL(omap_mcbsp_request);
 
-void omap_mcbsp_free(unsigned int id)
+void omap_mcbsp_free(struct omap_mcbsp *mcbsp)
 {
-	struct omap_mcbsp *mcbsp;
 	void *reg_cache;
 
-	if (!omap_mcbsp_check_valid_id(id)) {
-		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
-		return;
-	}
-	mcbsp = id_to_mcbsp_ptr(id);
-
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
-		mcbsp->pdata->ops->free(id);
+		mcbsp->pdata->ops->free(mcbsp->id - 1);
 
 	/* Disable wakeup behavior */
 	if (mcbsp->pdata->has_wakeup)
 		MCBSP_WRITE(mcbsp, WAKEUPEN, 0);
 
-	pm_runtime_put_sync(mcbsp->dev);
-
 	if (mcbsp->rx_irq)
 		free_irq(mcbsp->rx_irq, (void *)mcbsp);
 	free_irq(mcbsp->tx_irq, (void *)mcbsp);
@@ -782,25 +623,17 @@ void omap_mcbsp_free(unsigned int id)
 	if (reg_cache)
 		kfree(reg_cache);
 }
-EXPORT_SYMBOL(omap_mcbsp_free);
 
 /*
  * Here we start the McBSP, by enabling transmitter, receiver or both.
  * If no transmitter or receiver is active prior calling, then sample-rate
  * generator and frame sync are started.
  */
-void omap_mcbsp_start(unsigned int id, int tx, int rx)
+void omap_mcbsp_start(struct omap_mcbsp *mcbsp, int tx, int rx)
 {
-	struct omap_mcbsp *mcbsp;
 	int enable_srg = 0;
 	u16 w;
 
-	if (!omap_mcbsp_check_valid_id(id)) {
-		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
-		return;
-	}
-	mcbsp = id_to_mcbsp_ptr(id);
-
 	if (mcbsp->st_data)
 		omap_st_start(mcbsp);
 
@@ -850,23 +683,14 @@ void omap_mcbsp_start(unsigned int id, int tx, int rx)
 	}
 
 	/* Dump McBSP Regs */
-	omap_mcbsp_dump_reg(id);
+	omap_mcbsp_dump_reg(mcbsp);
 }
-EXPORT_SYMBOL(omap_mcbsp_start);
 
-void omap_mcbsp_stop(unsigned int id, int tx, int rx)
+void omap_mcbsp_stop(struct omap_mcbsp *mcbsp, int tx, int rx)
 {
-	struct omap_mcbsp *mcbsp;
 	int idle;
 	u16 w;
 
-	if (!omap_mcbsp_check_valid_id(id)) {
-		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
-		return;
-	}
-
-	mcbsp = id_to_mcbsp_ptr(id);
-
 	/* Reset transmitter */
 	tx &= 1;
 	if (mcbsp->pdata->has_ccr) {
@@ -899,19 +723,11 @@ void omap_mcbsp_stop(unsigned int id, int tx, int rx)
 	if (mcbsp->st_data)
 		omap_st_stop(mcbsp);
 }
-EXPORT_SYMBOL(omap_mcbsp_stop);
 
-int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id)
+int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id)
 {
-	struct omap_mcbsp *mcbsp;
 	const char *src;
 
-	if (!omap_mcbsp_check_valid_id(id)) {
-		pr_err("%s: Invalid id (%d)\n", __func__, id + 1);
-		return -EINVAL;
-	}
-	mcbsp = id_to_mcbsp_ptr(id);
-
 	if (fck_src_id == MCBSP_CLKS_PAD_SRC)
 		src = "clks_ext";
 	else if (fck_src_id == MCBSP_CLKS_PRCM_SRC)
@@ -924,13 +740,14 @@ int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id)
 	else
 		return -EINVAL;
 }
-EXPORT_SYMBOL(omap2_mcbsp_set_clks_src);
 
-void omap2_mcbsp1_mux_clkr_src(u8 mux)
+void omap2_mcbsp1_mux_clkr_src(struct omap_mcbsp *mcbsp, u8 mux)
 {
-	struct omap_mcbsp *mcbsp;
 	const char *src;
 
+	if (mcbsp->id != 1)
+		return;
+
 	if (mux == CLKR_SRC_CLKR)
 		src = "clkr";
 	else if (mux == CLKR_SRC_CLKX)
@@ -938,17 +755,17 @@ void omap2_mcbsp1_mux_clkr_src(u8 mux)
 	else
 		return;
 
-	mcbsp = id_to_mcbsp_ptr(0);
 	if (mcbsp->pdata->mux_signal)
 		mcbsp->pdata->mux_signal(mcbsp->dev, "clkr", src);
 }
-EXPORT_SYMBOL(omap2_mcbsp1_mux_clkr_src);
 
-void omap2_mcbsp1_mux_fsr_src(u8 mux)
+void omap2_mcbsp1_mux_fsr_src(struct omap_mcbsp *mcbsp, u8 mux)
 {
-	struct omap_mcbsp *mcbsp;
 	const char *src;
 
+	if (mcbsp->id != 1)
+		return;
+
 	if (mux == FSR_SRC_FSR)
 		src = "fsr";
 	else if (mux == FSR_SRC_FSX)
@@ -956,11 +773,9 @@ void omap2_mcbsp1_mux_fsr_src(u8 mux)
 	else
 		return;
 
-	mcbsp = id_to_mcbsp_ptr(0);
 	if (mcbsp->pdata->mux_signal)
 		mcbsp->pdata->mux_signal(mcbsp->dev, "fsr", src);
 }
-EXPORT_SYMBOL(omap2_mcbsp1_mux_fsr_src);
 
 #define max_thres(m)			(mcbsp->pdata->buffer_size)
 #define valid_threshold(m, val)		((val) <= max_thres(m))
@@ -1177,11 +992,10 @@ static void __devexit omap_st_remove(struct omap_mcbsp *mcbsp)
  * McBSP1 and McBSP3 are directly mapped on 1610 and 1510.
  * 730 has only 2 McBSP, and both of them are MPU peripherals.
  */
-static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
+int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 {
 	struct omap_mcbsp_platform_data *pdata = pdev->dev.platform_data;
 	struct omap_mcbsp *mcbsp;
-	int id = pdev->id - 1;
 	struct resource *res;
 	int ret = 0;
 
@@ -1194,12 +1008,6 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "Initializing OMAP McBSP (%d).\n", pdev->id);
 
-	if (id >= omap_mcbsp_count) {
-		dev_err(&pdev->dev, "Invalid McBSP device id (%d)\n", id);
-		ret = -EINVAL;
-		goto exit;
-	}
-
 	mcbsp = kzalloc(sizeof(struct omap_mcbsp), GFP_KERNEL);
 	if (!mcbsp) {
 		ret = -ENOMEM;
@@ -1207,7 +1015,7 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 	}
 
 	spin_lock_init(&mcbsp->lock);
-	mcbsp->id = id + 1;
+	mcbsp->id = pdev->id;
 	mcbsp->free = true;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
@@ -1268,7 +1076,6 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 
 	mcbsp->pdata = pdata;
 	mcbsp->dev = &pdev->dev;
-	mcbsp_ptr[id] = mcbsp;
 	platform_set_drvdata(pdev, mcbsp);
 	pm_runtime_enable(mcbsp->dev);
 
@@ -1323,7 +1130,7 @@ exit:
 	return ret;
 }
 
-static int __devexit omap_mcbsp_remove(struct platform_device *pdev)
+int __devexit omap_mcbsp_remove(struct platform_device *pdev)
 {
 	struct omap_mcbsp *mcbsp = platform_get_drvdata(pdev);
 
@@ -1349,18 +1156,3 @@ static int __devexit omap_mcbsp_remove(struct platform_device *pdev)
 
 	return 0;
 }
-
-static struct platform_driver omap_mcbsp_driver = {
-	.probe		= omap_mcbsp_probe,
-	.remove		= __devexit_p(omap_mcbsp_remove),
-	.driver		= {
-		.name	= "omap-mcbsp",
-	},
-};
-
-module_platform_driver(omap_mcbsp_driver);
-
-MODULE_AUTHOR("Samuel Ortiz <samuel.ortiz@nokia.com>");
-MODULE_DESCRIPTION("OMAP McBSP core driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:omap-mcbsp");
diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
index 5590ab2..6d57993 100644
--- a/sound/soc/omap/mcbsp.h
+++ b/sound/soc/omap/mcbsp.h
@@ -24,6 +24,8 @@
 #ifndef __ASOC_MCBSP_H
 #define __ASOC_MCBSP_H
 
+#include "omap-pcm.h"
+
 /* McBSP register numbers. Register address offset = num * reg_step */
 enum {
 	/* Common registers */
@@ -257,36 +259,92 @@ struct omap_mcbsp_reg_cfg {
 	u16 rccr;
 };
 
-void omap_mcbsp_config(unsigned int id,
+struct omap_mcbsp_st_data {
+	void __iomem *io_base_st;
+	bool running;
+	bool enabled;
+	s16 taps[128];	/* Sidetone filter coefficients */
+	int nr_taps;	/* Number of filter coefficients in use */
+	s16 ch0gain;
+	s16 ch1gain;
+};
+
+struct omap_mcbsp_data {
+	struct omap_mcbsp_reg_cfg	regs;
+	struct omap_pcm_dma_data	dma_data[2];
+	unsigned int			fmt;
+	/*
+	 * Flags indicating is the bus already activated and configured by
+	 * another substream
+	 */
+	int				active;
+	int				configured;
+	unsigned int			in_freq;
+	int				clk_div;
+	int				wlen;
+};
+
+struct omap_mcbsp {
+	struct device *dev;
+	unsigned long phys_base;
+	unsigned long phys_dma_base;
+	void __iomem *io_base;
+	u8 id;
+	u8 free;
+
+	int rx_irq;
+	int tx_irq;
+
+	/* DMA stuff */
+	u8 dma_rx_sync;
+	u8 dma_tx_sync;
+
+	/* Protect the field .free, while checking if the mcbsp is in use */
+	spinlock_t lock;
+	struct omap_mcbsp_platform_data *pdata;
+	struct clk *fclk;
+	struct omap_mcbsp_st_data *st_data;
+	struct omap_mcbsp_data mcbsp_data;
+	int dma_op_mode;
+	u16 max_tx_thres;
+	u16 max_rx_thres;
+	void *reg_cache;
+	int reg_cache_size;
+};
+
+void omap_mcbsp_config(struct omap_mcbsp *mcbsp,
 		       const struct omap_mcbsp_reg_cfg *config);
-void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold);
-void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold);
-u16 omap_mcbsp_get_max_tx_threshold(unsigned int id);
-u16 omap_mcbsp_get_max_rx_threshold(unsigned int id);
-u16 omap_mcbsp_get_fifo_size(unsigned int id);
-u16 omap_mcbsp_get_tx_delay(unsigned int id);
-u16 omap_mcbsp_get_rx_delay(unsigned int id);
-int omap_mcbsp_get_dma_op_mode(unsigned int id);
-int omap_mcbsp_request(unsigned int id);
-void omap_mcbsp_free(unsigned int id);
-void omap_mcbsp_start(unsigned int id, int tx, int rx);
-void omap_mcbsp_stop(unsigned int id, int tx, int rx);
+void omap_mcbsp_set_tx_threshold(struct omap_mcbsp *mcbsp, u16 threshold);
+void omap_mcbsp_set_rx_threshold(struct omap_mcbsp *mcbsp, u16 threshold);
+u16 omap_mcbsp_get_max_tx_threshold(struct omap_mcbsp *mcbsp);
+u16 omap_mcbsp_get_max_rx_threshold(struct omap_mcbsp *mcbsp);
+u16 omap_mcbsp_get_fifo_size(struct omap_mcbsp *mcbsp);
+u16 omap_mcbsp_get_tx_delay(struct omap_mcbsp *mcbsp);
+u16 omap_mcbsp_get_rx_delay(struct omap_mcbsp *mcbsp);
+int omap_mcbsp_get_dma_op_mode(struct omap_mcbsp *mcbsp);
+int omap_mcbsp_request(struct omap_mcbsp *mcbsp);
+void omap_mcbsp_free(struct omap_mcbsp *mcbsp);
+void omap_mcbsp_start(struct omap_mcbsp *mcbsp, int tx, int rx);
+void omap_mcbsp_stop(struct omap_mcbsp *mcbsp, int tx, int rx);
 
 /* McBSP functional clock source changing function */
-int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id);
+int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id);
 
 /* McBSP signal muxing API */
-void omap2_mcbsp1_mux_clkr_src(u8 mux);
-void omap2_mcbsp1_mux_fsr_src(u8 mux);
+void omap2_mcbsp1_mux_clkr_src(struct omap_mcbsp *mcbsp, u8 mux);
+void omap2_mcbsp1_mux_fsr_src(struct omap_mcbsp *mcbsp, u8 mux);
 
-int omap_mcbsp_dma_ch_params(unsigned int id, unsigned int stream);
-int omap_mcbsp_dma_reg_params(unsigned int id, unsigned int stream);
+int omap_mcbsp_dma_ch_params(struct omap_mcbsp *mcbsp, unsigned int stream);
+int omap_mcbsp_dma_reg_params(struct omap_mcbsp *mcbsp, unsigned int stream);
 
 /* Sidetone specific API */
-int omap_st_set_chgain(unsigned int id, int channel, s16 chgain);
-int omap_st_get_chgain(unsigned int id, int channel, s16 *chgain);
-int omap_st_enable(unsigned int id);
-int omap_st_disable(unsigned int id);
-int omap_st_is_enabled(unsigned int id);
+int omap_st_set_chgain(struct omap_mcbsp *mcbsp, int channel, s16 chgain);
+int omap_st_get_chgain(struct omap_mcbsp *mcbsp, int channel, s16 *chgain);
+int omap_st_enable(struct omap_mcbsp *mcbsp);
+int omap_st_disable(struct omap_mcbsp *mcbsp);
+int omap_st_is_enabled(struct omap_mcbsp *mcbsp);
+
+int __devinit omap_mcbsp_probe(struct platform_device *pdev);
+int __devexit omap_mcbsp_remove(struct platform_device *pdev);
 
 #endif /* __ASOC_MCBSP_H */
diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index c292bf0..abac4b6 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -275,7 +275,7 @@ static int n810_aic33_init(struct snd_soc_pcm_runtime *rtd)
 static struct snd_soc_dai_link n810_dai = {
 	.name = "TLV320AIC33",
 	.stream_name = "AIC33",
-	.cpu_dai_name = "omap-mcbsp-dai.1",
+	.cpu_dai_name = "omap-mcbsp.2",
 	.platform_name = "omap-pcm-audio",
 	.codec_name = "tlv320aic3x-codec.2-0018",
 	.codec_dai_name = "tlv320aic3x-hifi",
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index f1318c1..8924002 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -56,36 +56,18 @@ enum {
 	OMAP_MCBSP_WORD_32,
 };
 
-struct omap_mcbsp_data {
-	unsigned int			bus_id;
-	struct omap_mcbsp_reg_cfg	regs;
-	unsigned int			fmt;
-	/*
-	 * Flags indicating is the bus already activated and configured by
-	 * another substream
-	 */
-	int				active;
-	int				configured;
-	unsigned int			in_freq;
-	int				clk_div;
-	int				wlen;
-};
-
-static struct omap_mcbsp_data mcbsp_data[NUM_LINKS];
-
 /*
  * Stream DMA parameters. DMA request line and port address are set runtime
  * since they are different between OMAP1 and later OMAPs
  */
-static struct omap_pcm_dma_data omap_mcbsp_dai_dma_params[NUM_LINKS][2];
-
 static void omap_mcbsp_set_threshold(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct omap_mcbsp_data *mcbsp_data = snd_soc_dai_get_drvdata(cpu_dai);
+	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
+	struct omap_mcbsp_data *mcbsp_data = &mcbsp->mcbsp_data;
 	struct omap_pcm_dma_data *dma_data;
-	int dma_op_mode = omap_mcbsp_get_dma_op_mode(mcbsp_data->bus_id);
+	int dma_op_mode = omap_mcbsp_get_dma_op_mode(mcbsp);
 	int words;
 
 	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
@@ -107,9 +89,9 @@ static void omap_mcbsp_set_threshold(struct snd_pcm_substream *substream)
 
 	/* Configure McBSP internal buffer usage */
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		omap_mcbsp_set_tx_threshold(mcbsp_data->bus_id, words);
+		omap_mcbsp_set_tx_threshold(mcbsp, words);
 	else
-		omap_mcbsp_set_rx_threshold(mcbsp_data->bus_id, words);
+		omap_mcbsp_set_rx_threshold(mcbsp, words);
 }
 
 static int omap_mcbsp_hwrule_min_buffersize(struct snd_pcm_hw_params *params,
@@ -119,12 +101,12 @@ static int omap_mcbsp_hwrule_min_buffersize(struct snd_pcm_hw_params *params,
 					SNDRV_PCM_HW_PARAM_BUFFER_SIZE);
 	struct snd_interval *channels = hw_param_interval(params,
 					SNDRV_PCM_HW_PARAM_CHANNELS);
-	struct omap_mcbsp_data *mcbsp_data = rule->private;
+	struct omap_mcbsp *mcbsp = rule->private;
 	struct snd_interval frames;
 	int size;
 
 	snd_interval_any(&frames);
-	size = omap_mcbsp_get_fifo_size(mcbsp_data->bus_id);
+	size = omap_mcbsp_get_fifo_size(mcbsp);
 
 	frames.min = size / channels->min;
 	frames.integer = 1;
@@ -134,12 +116,11 @@ static int omap_mcbsp_hwrule_min_buffersize(struct snd_pcm_hw_params *params,
 static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *cpu_dai)
 {
-	struct omap_mcbsp_data *mcbsp_data = snd_soc_dai_get_drvdata(cpu_dai);
-	int bus_id = mcbsp_data->bus_id;
+	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
 	int err = 0;
 
 	if (!cpu_dai->active)
-		err = omap_mcbsp_request(bus_id);
+		err = omap_mcbsp_request(mcbsp);
 
 	/*
 	 * OMAP3 McBSP FIFO is word structured.
@@ -156,7 +137,7 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 	 * 2 channels (stereo): size is 128 / 2 = 64 frames (2 * 64 words)
 	 * 4 channels: size is 128 / 4 = 32 frames (4 * 32 words)
 	 */
-	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	if (mcbsp->pdata->buffer_size) {
 		/*
 		* Rule for the buffer size. We should not allow
 		* smaller buffer than the FIFO size to avoid underruns
@@ -164,7 +145,7 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 		snd_pcm_hw_rule_add(substream->runtime, 0,
 				    SNDRV_PCM_HW_PARAM_CHANNELS,
 				    omap_mcbsp_hwrule_min_buffersize,
-				    mcbsp_data,
+				    mcbsp,
 				    SNDRV_PCM_HW_PARAM_BUFFER_SIZE, -1);
 
 		/* Make sure, that the period size is always even */
@@ -178,10 +159,11 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 static void omap_mcbsp_dai_shutdown(struct snd_pcm_substream *substream,
 				    struct snd_soc_dai *cpu_dai)
 {
-	struct omap_mcbsp_data *mcbsp_data = snd_soc_dai_get_drvdata(cpu_dai);
+	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
+	struct omap_mcbsp_data *mcbsp_data = &mcbsp->mcbsp_data;
 
 	if (!cpu_dai->active) {
-		omap_mcbsp_free(mcbsp_data->bus_id);
+		omap_mcbsp_free(mcbsp);
 		mcbsp_data->configured = 0;
 	}
 }
@@ -189,7 +171,8 @@ static void omap_mcbsp_dai_shutdown(struct snd_pcm_substream *substream,
 static int omap_mcbsp_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 				  struct snd_soc_dai *cpu_dai)
 {
-	struct omap_mcbsp_data *mcbsp_data = snd_soc_dai_get_drvdata(cpu_dai);
+	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
+	struct omap_mcbsp_data *mcbsp_data = &mcbsp->mcbsp_data;
 	int err = 0, play = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 
 	switch (cmd) {
@@ -197,13 +180,13 @@ static int omap_mcbsp_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		mcbsp_data->active++;
-		omap_mcbsp_start(mcbsp_data->bus_id, play, !play);
+		omap_mcbsp_start(mcbsp, play, !play);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		omap_mcbsp_stop(mcbsp_data->bus_id, play, !play);
+		omap_mcbsp_stop(mcbsp, play, !play);
 		mcbsp_data->active--;
 		break;
 	default:
@@ -219,14 +202,14 @@ static snd_pcm_sframes_t omap_mcbsp_dai_delay(
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct omap_mcbsp_data *mcbsp_data = snd_soc_dai_get_drvdata(cpu_dai);
+	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
 	u16 fifo_use;
 	snd_pcm_sframes_t delay;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		fifo_use = omap_mcbsp_get_tx_delay(mcbsp_data->bus_id);
+		fifo_use = omap_mcbsp_get_tx_delay(mcbsp);
 	else
-		fifo_use = omap_mcbsp_get_rx_delay(mcbsp_data->bus_id);
+		fifo_use = omap_mcbsp_get_rx_delay(mcbsp);
 
 	/*
 	 * Divide the used locations with the channel count to get the
@@ -242,19 +225,20 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 				    struct snd_pcm_hw_params *params,
 				    struct snd_soc_dai *cpu_dai)
 {
-	struct omap_mcbsp_data *mcbsp_data = snd_soc_dai_get_drvdata(cpu_dai);
+	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
+	struct omap_mcbsp_data *mcbsp_data = &mcbsp->mcbsp_data;
 	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
 	struct omap_pcm_dma_data *dma_data;
-	int dma, bus_id = mcbsp_data->bus_id;
+	int dma;
 	int wlen, channels, wpf, sync_mode = OMAP_DMA_SYNC_ELEMENT;
 	int pkt_size = 0;
 	unsigned long port;
 	unsigned int format, div, framesize, master;
 
-	dma_data = &omap_mcbsp_dai_dma_params[cpu_dai->id][substream->stream];
+	dma_data = &mcbsp_data->dma_data[substream->stream];
 
-	dma = omap_mcbsp_dma_ch_params(bus_id, substream->stream);
-	port = omap_mcbsp_dma_reg_params(bus_id, substream->stream);
+	dma = omap_mcbsp_dma_ch_params(mcbsp, substream->stream);
+	port = omap_mcbsp_dma_reg_params(mcbsp, substream->stream);
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
@@ -268,20 +252,20 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	default:
 		return -EINVAL;
 	}
-	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	if (mcbsp->pdata->buffer_size) {
 		dma_data->set_threshold = omap_mcbsp_set_threshold;
 		/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
-		if (omap_mcbsp_get_dma_op_mode(bus_id) ==
+		if (omap_mcbsp_get_dma_op_mode(mcbsp) ==
 						MCBSP_DMA_MODE_THRESHOLD) {
 			int period_words, max_thrsh;
 
 			period_words = params_period_bytes(params) / (wlen / 8);
 			if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 				max_thrsh = omap_mcbsp_get_max_tx_threshold(
-							    mcbsp_data->bus_id);
+							    mcbsp);
 			else
 				max_thrsh = omap_mcbsp_get_max_rx_threshold(
-							    mcbsp_data->bus_id);
+							    mcbsp);
 			/*
 			 * If the period contains less or equal number of words,
 			 * we are using the original threshold mode setup:
@@ -398,7 +382,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	omap_mcbsp_config(bus_id, &mcbsp_data->regs);
+	omap_mcbsp_config(mcbsp, &mcbsp_data->regs);
 	mcbsp_data->wlen = wlen;
 	mcbsp_data->configured = 1;
 
@@ -412,7 +396,8 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 				      unsigned int fmt)
 {
-	struct omap_mcbsp_data *mcbsp_data = snd_soc_dai_get_drvdata(cpu_dai);
+	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
+	struct omap_mcbsp_data *mcbsp_data = &mcbsp->mcbsp_data;
 	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
 	bool inv_fs = false;
 
@@ -514,7 +499,8 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 static int omap_mcbsp_dai_set_clkdiv(struct snd_soc_dai *cpu_dai,
 				     int div_id, int div)
 {
-	struct omap_mcbsp_data *mcbsp_data = snd_soc_dai_get_drvdata(cpu_dai);
+	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
+	struct omap_mcbsp_data *mcbsp_data = &mcbsp->mcbsp_data;
 	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
 
 	if (div_id != OMAP_MCBSP_CLKGDV)
@@ -531,7 +517,8 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 					 int clk_id, unsigned int freq,
 					 int dir)
 {
-	struct omap_mcbsp_data *mcbsp_data = snd_soc_dai_get_drvdata(cpu_dai);
+	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
+	struct omap_mcbsp_data *mcbsp_data = &mcbsp->mcbsp_data;
 	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
 	int err = 0;
 
@@ -547,7 +534,7 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	    clk_id == OMAP_MCBSP_CLKR_SRC_CLKX ||
 	    clk_id == OMAP_MCBSP_FSR_SRC_FSR ||
 	    clk_id == OMAP_MCBSP_FSR_SRC_FSX)
-		if (cpu_class_is_omap1() || mcbsp_data->bus_id != 0)
+		if (cpu_class_is_omap1() || cpu_dai->id != 1)
 			return -EINVAL;
 
 	mcbsp_data->in_freq = freq;
@@ -563,7 +550,7 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 			err = -EINVAL;
 			break;
 		}
-		err = omap2_mcbsp_set_clks_src(mcbsp_data->bus_id,
+		err = omap2_mcbsp_set_clks_src(mcbsp,
 					       MCBSP_CLKS_PRCM_SRC);
 		break;
 	case OMAP_MCBSP_SYSCLK_CLKS_EXT:
@@ -571,7 +558,7 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 			err = 0;
 			break;
 		}
-		err = omap2_mcbsp_set_clks_src(mcbsp_data->bus_id,
+		err = omap2_mcbsp_set_clks_src(mcbsp,
 					       MCBSP_CLKS_PAD_SRC);
 		break;
 
@@ -585,22 +572,22 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	case OMAP_MCBSP_CLKR_SRC_CLKR:
 		if (cpu_class_is_omap1())
 			break;
-		omap2_mcbsp1_mux_clkr_src(CLKR_SRC_CLKR);
+		omap2_mcbsp1_mux_clkr_src(mcbsp, CLKR_SRC_CLKR);
 		break;
 	case OMAP_MCBSP_CLKR_SRC_CLKX:
 		if (cpu_class_is_omap1())
 			break;
-		omap2_mcbsp1_mux_clkr_src(CLKR_SRC_CLKX);
+		omap2_mcbsp1_mux_clkr_src(mcbsp, CLKR_SRC_CLKX);
 		break;
 	case OMAP_MCBSP_FSR_SRC_FSR:
 		if (cpu_class_is_omap1())
 			break;
-		omap2_mcbsp1_mux_fsr_src(FSR_SRC_FSR);
+		omap2_mcbsp1_mux_fsr_src(mcbsp, FSR_SRC_FSR);
 		break;
 	case OMAP_MCBSP_FSR_SRC_FSX:
 		if (cpu_class_is_omap1())
 			break;
-		omap2_mcbsp1_mux_fsr_src(FSR_SRC_FSX);
+		omap2_mcbsp1_mux_fsr_src(mcbsp, FSR_SRC_FSX);
 		break;
 	default:
 		err = -ENODEV;
@@ -620,15 +607,7 @@ static const struct snd_soc_dai_ops mcbsp_dai_ops = {
 	.set_sysclk	= omap_mcbsp_dai_set_dai_sysclk,
 };
 
-static int mcbsp_dai_probe(struct snd_soc_dai *dai)
-{
-	mcbsp_data[dai->id].bus_id = dai->id;
-	snd_soc_dai_set_drvdata(dai, &mcbsp_data[dai->id].bus_id);
-	return 0;
-}
-
 static struct snd_soc_dai_driver omap_mcbsp_dai = {
-	.probe = mcbsp_dai_probe,
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 16,
@@ -659,11 +638,13 @@ static int omap_mcbsp_st_info_volsw(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-#define OMAP_MCBSP_ST_SET_CHANNEL_VOLUME(id, channel)			\
+#define OMAP_MCBSP_ST_SET_CHANNEL_VOLUME(channel)			\
 static int								\
-omap_mcbsp##id##_set_st_ch##channel##_volume(struct snd_kcontrol *kc,	\
+omap_mcbsp_set_st_ch##channel##_volume(struct snd_kcontrol *kc,	\
 					struct snd_ctl_elem_value *uc)	\
 {									\
+	struct snd_soc_dai *cpu_dai = snd_kcontrol_chip(kc);		\
+	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);	\
 	struct soc_mixer_control *mc =					\
 		(struct soc_mixer_control *)kc->private_value;		\
 	int max = mc->max;						\
@@ -674,46 +655,44 @@ omap_mcbsp##id##_set_st_ch##channel##_volume(struct snd_kcontrol *kc,	\
 		return -EINVAL;						\
 									\
 	/* OMAP McBSP implementation uses index values 0..4 */		\
-	return omap_st_set_chgain((id)-1, channel, val);		\
+	return omap_st_set_chgain(mcbsp, channel, val);			\
 }
 
-#define OMAP_MCBSP_ST_GET_CHANNEL_VOLUME(id, channel)			\
+#define OMAP_MCBSP_ST_GET_CHANNEL_VOLUME(channel)			\
 static int								\
-omap_mcbsp##id##_get_st_ch##channel##_volume(struct snd_kcontrol *kc,	\
+omap_mcbsp_get_st_ch##channel##_volume(struct snd_kcontrol *kc,	\
 					struct snd_ctl_elem_value *uc)	\
 {									\
+	struct snd_soc_dai *cpu_dai = snd_kcontrol_chip(kc);		\
+	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);	\
 	s16 chgain;							\
 									\
-	if (omap_st_get_chgain((id)-1, channel, &chgain))		\
+	if (omap_st_get_chgain(mcbsp, channel, &chgain))		\
 		return -EAGAIN;						\
 									\
 	uc->value.integer.value[0] = chgain;				\
 	return 0;							\
 }
 
-OMAP_MCBSP_ST_SET_CHANNEL_VOLUME(2, 0)
-OMAP_MCBSP_ST_SET_CHANNEL_VOLUME(2, 1)
-OMAP_MCBSP_ST_SET_CHANNEL_VOLUME(3, 0)
-OMAP_MCBSP_ST_SET_CHANNEL_VOLUME(3, 1)
-OMAP_MCBSP_ST_GET_CHANNEL_VOLUME(2, 0)
-OMAP_MCBSP_ST_GET_CHANNEL_VOLUME(2, 1)
-OMAP_MCBSP_ST_GET_CHANNEL_VOLUME(3, 0)
-OMAP_MCBSP_ST_GET_CHANNEL_VOLUME(3, 1)
+OMAP_MCBSP_ST_SET_CHANNEL_VOLUME(0)
+OMAP_MCBSP_ST_SET_CHANNEL_VOLUME(1)
+OMAP_MCBSP_ST_GET_CHANNEL_VOLUME(0)
+OMAP_MCBSP_ST_GET_CHANNEL_VOLUME(1)
 
 static int omap_mcbsp_st_put_mode(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_dai *cpu_dai = snd_kcontrol_chip(kcontrol);
+	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
 	u8 value = ucontrol->value.integer.value[0];
 
-	if (value == omap_st_is_enabled(mc->reg))
+	if (value == omap_st_is_enabled(mcbsp))
 		return 0;
 
 	if (value)
-		omap_st_enable(mc->reg);
+		omap_st_enable(mcbsp);
 	else
-		omap_st_disable(mc->reg);
+		omap_st_disable(mcbsp);
 
 	return 1;
 }
@@ -721,10 +700,10 @@ static int omap_mcbsp_st_put_mode(struct snd_kcontrol *kcontrol,
 static int omap_mcbsp_st_get_mode(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_dai *cpu_dai = snd_kcontrol_chip(kcontrol);
+	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
 
-	ucontrol->value.integer.value[0] = omap_st_is_enabled(mc->reg);
+	ucontrol->value.integer.value[0] = omap_st_is_enabled(mcbsp);
 	return 0;
 }
 
@@ -733,12 +712,12 @@ static const struct snd_kcontrol_new omap_mcbsp2_st_controls[] = {
 			omap_mcbsp_st_get_mode, omap_mcbsp_st_put_mode),
 	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP2 Sidetone Channel 0 Volume",
 				      -32768, 32767,
-				      omap_mcbsp2_get_st_ch0_volume,
-				      omap_mcbsp2_set_st_ch0_volume),
+				      omap_mcbsp_get_st_ch0_volume,
+				      omap_mcbsp_set_st_ch0_volume),
 	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP2 Sidetone Channel 1 Volume",
 				      -32768, 32767,
-				      omap_mcbsp2_get_st_ch1_volume,
-				      omap_mcbsp2_set_st_ch1_volume),
+				      omap_mcbsp_get_st_ch1_volume,
+				      omap_mcbsp_set_st_ch1_volume),
 };
 
 static const struct snd_kcontrol_new omap_mcbsp3_st_controls[] = {
@@ -746,25 +725,30 @@ static const struct snd_kcontrol_new omap_mcbsp3_st_controls[] = {
 			omap_mcbsp_st_get_mode, omap_mcbsp_st_put_mode),
 	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP3 Sidetone Channel 0 Volume",
 				      -32768, 32767,
-				      omap_mcbsp3_get_st_ch0_volume,
-				      omap_mcbsp3_set_st_ch0_volume),
+				      omap_mcbsp_get_st_ch0_volume,
+				      omap_mcbsp_set_st_ch0_volume),
 	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP3 Sidetone Channel 1 Volume",
 				      -32768, 32767,
-				      omap_mcbsp3_get_st_ch1_volume,
-				      omap_mcbsp3_set_st_ch1_volume),
+				      omap_mcbsp_get_st_ch1_volume,
+				      omap_mcbsp_set_st_ch1_volume),
 };
 
-int omap_mcbsp_st_add_controls(struct snd_soc_dai *dai)
+int omap_mcbsp_st_add_controls(struct snd_soc_pcm_runtime *rtd)
 {
-	if (!cpu_is_omap34xx())
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
+
+	if (!mcbsp->st_data)
 		return -ENODEV;
 
-	switch (dai->id) {
-	case 1: /* McBSP 2 */
-		return snd_soc_add_dai_controls(dai, omap_mcbsp2_st_controls,
+	switch (cpu_dai->id) {
+	case 2: /* McBSP 2 */
+		return snd_soc_add_dai_controls(cpu_dai,
+					omap_mcbsp2_st_controls,
 					ARRAY_SIZE(omap_mcbsp2_st_controls));
-	case 2: /* McBSP 3 */
-		return snd_soc_add_dai_controls(dai, omap_mcbsp3_st_controls,
+	case 3: /* McBSP 3 */
+		return snd_soc_add_dai_controls(cpu_dai,
+					omap_mcbsp3_st_controls,
 					ARRAY_SIZE(omap_mcbsp3_st_controls));
 	default:
 		break;
@@ -776,18 +760,25 @@ EXPORT_SYMBOL_GPL(omap_mcbsp_st_add_controls);
 
 static __devinit int asoc_mcbsp_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_dai(&pdev->dev, &omap_mcbsp_dai);
+	int ret;
+
+	ret = omap_mcbsp_probe(pdev);
+	if (!ret)
+		return snd_soc_register_dai(&pdev->dev, &omap_mcbsp_dai);
+
+	return ret;
 }
 
 static int __devexit asoc_mcbsp_remove(struct platform_device *pdev)
 {
+	omap_mcbsp_remove(pdev);
 	snd_soc_unregister_dai(&pdev->dev);
 	return 0;
 }
 
 static struct platform_driver asoc_mcbsp_driver = {
 	.driver = {
-			.name = "omap-mcbsp-dai",
+			.name = "omap-mcbsp",
 			.owner = THIS_MODULE,
 	},
 
diff --git a/sound/soc/omap/omap-mcbsp.h b/sound/soc/omap/omap-mcbsp.h
index 476fe2a..f877b16 100644
--- a/sound/soc/omap/omap-mcbsp.h
+++ b/sound/soc/omap/omap-mcbsp.h
@@ -59,6 +59,6 @@ enum omap_mcbsp_div {
 #define NUM_LINKS	5
 #endif
 
-int omap_mcbsp_st_add_controls(struct snd_soc_dai *dai);
+int omap_mcbsp_st_add_controls(struct snd_soc_pcm_runtime *rtd);
 
 #endif
diff --git a/sound/soc/omap/omap-pcm.h b/sound/soc/omap/omap-pcm.h
index f95fe30..b92248c 100644
--- a/sound/soc/omap/omap-pcm.h
+++ b/sound/soc/omap/omap-pcm.h
@@ -25,6 +25,8 @@
 #ifndef __OMAP_PCM_H__
 #define __OMAP_PCM_H__
 
+struct snd_pcm_substream;
+
 struct omap_pcm_dma_data {
 	char		*name;		/* stream identifier */
 	int		dma_req;	/* DMA request line */
diff --git a/sound/soc/omap/omap3beagle.c b/sound/soc/omap/omap3beagle.c
index 3357dcc..2830dfd 100644
--- a/sound/soc/omap/omap3beagle.c
+++ b/sound/soc/omap/omap3beagle.c
@@ -91,7 +91,7 @@ static struct snd_soc_ops omap3beagle_ops = {
 static struct snd_soc_dai_link omap3beagle_dai = {
 	.name = "TWL4030",
 	.stream_name = "TWL4030",
-	.cpu_dai_name = "omap-mcbsp-dai.1",
+	.cpu_dai_name = "omap-mcbsp.2",
 	.platform_name = "omap-pcm-audio",
 	.codec_dai_name = "twl4030-hifi",
 	.codec_name = "twl4030-codec",
diff --git a/sound/soc/omap/omap3evm.c b/sound/soc/omap/omap3evm.c
index 071fcb0..3d468c9 100644
--- a/sound/soc/omap/omap3evm.c
+++ b/sound/soc/omap/omap3evm.c
@@ -58,7 +58,7 @@ static struct snd_soc_ops omap3evm_ops = {
 static struct snd_soc_dai_link omap3evm_dai = {
 	.name 		= "TWL4030",
 	.stream_name 	= "TWL4030",
-	.cpu_dai_name = "omap-mcbsp-dai.1",
+	.cpu_dai_name = "omap-mcbsp.2",
 	.codec_dai_name = "twl4030-hifi",
 	.platform_name = "omap-pcm-audio",
 	.codec_name = "twl4030-codec",
diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
index 07794bd..4c3a097 100644
--- a/sound/soc/omap/omap3pandora.c
+++ b/sound/soc/omap/omap3pandora.c
@@ -208,7 +208,7 @@ static struct snd_soc_dai_link omap3pandora_dai[] = {
 	{
 		.name = "PCM1773",
 		.stream_name = "HiFi Out",
-		.cpu_dai_name = "omap-mcbsp-dai.1",
+		.cpu_dai_name = "omap-mcbsp.2",
 		.codec_dai_name = "twl4030-hifi",
 		.platform_name = "omap-pcm-audio",
 		.codec_name = "twl4030-codec",
@@ -219,7 +219,7 @@ static struct snd_soc_dai_link omap3pandora_dai[] = {
 	}, {
 		.name = "TWL4030",
 		.stream_name = "Line/Mic In",
-		.cpu_dai_name = "omap-mcbsp-dai.3",
+		.cpu_dai_name = "omap-mcbsp.4",
 		.codec_dai_name = "twl4030-hifi",
 		.platform_name = "omap-pcm-audio",
 		.codec_name = "twl4030-codec",
diff --git a/sound/soc/omap/osk5912.c b/sound/soc/omap/osk5912.c
index d859b59..b1a9d64 100644
--- a/sound/soc/omap/osk5912.c
+++ b/sound/soc/omap/osk5912.c
@@ -96,7 +96,7 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static struct snd_soc_dai_link osk_dai = {
 	.name = "TLV320AIC23",
 	.stream_name = "AIC23",
-	.cpu_dai_name = "omap-mcbsp-dai.0",
+	.cpu_dai_name = "omap-mcbsp.1",
 	.codec_dai_name = "tlv320aic23-hifi",
 	.platform_name = "omap-pcm-audio",
 	.codec_name = "tlv320aic23-codec",
diff --git a/sound/soc/omap/overo.c b/sound/soc/omap/overo.c
index 2ee889c..6ac3e0c 100644
--- a/sound/soc/omap/overo.c
+++ b/sound/soc/omap/overo.c
@@ -60,7 +60,7 @@ static struct snd_soc_ops overo_ops = {
 static struct snd_soc_dai_link overo_dai = {
 	.name = "TWL4030",
 	.stream_name = "TWL4030",
-	.cpu_dai_name = "omap-mcbsp-dai.1",
+	.cpu_dai_name = "omap-mcbsp.2",
 	.codec_dai_name = "twl4030-hifi",
 	.platform_name = "omap-pcm-audio",
 	.codec_name = "twl4030-codec",
diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 58936c7..2712dd2 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -313,7 +313,7 @@ static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
 		return err;
 	snd_soc_limit_volume(codec, "TPA6130A2 Headphone Playback Volume", 42);
 
-	err = omap_mcbsp_st_add_controls(rtd->cpu_dai);
+	err = omap_mcbsp_st_add_controls(rtd);
 	if (err < 0)
 		return err;
 
@@ -353,7 +353,7 @@ static struct snd_soc_dai_link rx51_dai[] = {
 	{
 		.name = "TLV320AIC34",
 		.stream_name = "AIC34",
-		.cpu_dai_name = "omap-mcbsp-dai.1",
+		.cpu_dai_name = "omap-mcbsp.2",
 		.codec_dai_name = "tlv320aic3x-hifi",
 		.platform_name = "omap-pcm-audio",
 		.codec_name = "tlv320aic3x-codec.2-0018",
diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index 2c85066..0e28322 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -187,7 +187,7 @@ static struct snd_soc_dai_link sdp3430_dai[] = {
 	{
 		.name = "TWL4030 I2S",
 		.stream_name = "TWL4030 Audio",
-		.cpu_dai_name = "omap-mcbsp-dai.1",
+		.cpu_dai_name = "omap-mcbsp.2",
 		.codec_dai_name = "twl4030-hifi",
 		.platform_name = "omap-pcm-audio",
 		.codec_name = "twl4030-codec",
@@ -199,7 +199,7 @@ static struct snd_soc_dai_link sdp3430_dai[] = {
 	{
 		.name = "TWL4030 PCM",
 		.stream_name = "TWL4030 Voice",
-		.cpu_dai_name = "omap-mcbsp-dai.2",
+		.cpu_dai_name = "omap-mcbsp.3",
 		.codec_dai_name = "twl4030-voice",
 		.platform_name = "omap-pcm-audio",
 		.codec_name = "twl4030-codec",
diff --git a/sound/soc/omap/zoom2.c b/sound/soc/omap/zoom2.c
index 981616d..920e0d9 100644
--- a/sound/soc/omap/zoom2.c
+++ b/sound/soc/omap/zoom2.c
@@ -131,7 +131,7 @@ static struct snd_soc_dai_link zoom2_dai[] = {
 	{
 		.name = "TWL4030 I2S",
 		.stream_name = "TWL4030 Audio",
-		.cpu_dai_name = "omap-mcbsp-dai.1",
+		.cpu_dai_name = "omap-mcbsp.2",
 		.codec_dai_name = "twl4030-hifi",
 		.platform_name = "omap-pcm-audio",
 		.codec_name = "twl4030-codec",
@@ -143,7 +143,7 @@ static struct snd_soc_dai_link zoom2_dai[] = {
 	{
 		.name = "TWL4030 PCM",
 		.stream_name = "TWL4030 Voice",
-		.cpu_dai_name = "omap-mcbsp-dai.2",
+		.cpu_dai_name = "omap-mcbsp.3",
 		.codec_dai_name = "twl4030-voice",
 		.platform_name = "omap-pcm-audio",
 		.codec_name = "twl4030-codec",
-- 
1.7.8.4

