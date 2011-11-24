From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/5] ASoC: OMAP4: omap-dmic: Initial support for OMAP DMIC
Date: Thu, 24 Nov 2011 15:54:46 +0200
Message-ID: <1322142889-12017-3-git-send-email-peter.ujfalusi@ti.com>
References: <1322142889-12017-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:60261 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755427Ab1KXNzJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Nov 2011 08:55:09 -0500
Received: by mail-bw0-f41.google.com with SMTP id 17so2709774bke.28
        for <linux-omap@vger.kernel.org>; Thu, 24 Nov 2011 05:55:08 -0800 (PST)
In-Reply-To: <1322142889-12017-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Add support for OMAP4 Digital Microphone interface.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/Kconfig     |    3 +
 sound/soc/omap/Makefile    |    2 +
 sound/soc/omap/omap-dmic.c |  509 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/omap/omap-dmic.h |   73 +++++++
 4 files changed, 587 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/omap/omap-dmic.c
 create mode 100644 sound/soc/omap/omap-dmic.h

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index fe83d0d..052254a 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -2,6 +2,9 @@ config SND_OMAP_SOC
 	tristate "SoC Audio for the Texas Instruments OMAP chips"
 	depends on ARCH_OMAP
 
+config SND_OMAP_SOC_DMIC
+	tristate
+
 config SND_OMAP_SOC_MCBSP
 	tristate
 	select OMAP_MCBSP
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 052fd75..1fd723f 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -1,10 +1,12 @@
 # OMAP Platform Support
 snd-soc-omap-objs := omap-pcm.o
+snd-soc-omap-dmic-objs := omap-dmic.o
 snd-soc-omap-mcbsp-objs := omap-mcbsp.o
 snd-soc-omap-mcpdm-objs := omap-mcpdm.o
 snd-soc-omap-hdmi-objs := omap-hdmi.o
 
 obj-$(CONFIG_SND_OMAP_SOC) += snd-soc-omap.o
+obj-$(CONFIG_SND_OMAP_SOC_DMIC) += snd-soc-omap-dmic.o
 obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o
 obj-$(CONFIG_SND_OMAP_SOC_MCPDM) += snd-soc-omap-mcpdm.o
 obj-$(CONFIG_SND_OMAP_SOC_HDMI) += snd-soc-omap-hdmi.o
diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
new file mode 100644
index 0000000..3ba08a1
--- /dev/null
+++ b/sound/soc/omap/omap-dmic.c
@@ -0,0 +1,509 @@
+/*
+ * omap-dmic.c  --  OMAP ASoC DMIC DAI driver
+ *
+ * Copyright (C) 2010 - 2011 Texas Instruments
+ *
+ * Author: David Lambert <dlambert@ti.com>
+ *	   Misael Lopez Cruz <misael.lopez@ti.com>
+ *	   Liam Girdwood <lrg@ti.com>
+ *	   Peter Ujfalusi <peter.ujfalusi@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/pm_runtime.h>
+#include <plat/dma.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include "omap-pcm.h"
+#include "omap-dmic.h"
+
+struct omap_dmic {
+	struct device *dev;
+	void __iomem *io_base;
+	struct clk *fclk;
+	int fclk_freq;
+	int sysclk;
+	int threshold;
+	u32 ch_enabled;
+	u32 clk_div;
+	struct mutex mutex;
+};
+
+/*
+ * Stream DMA parameters
+ */
+static struct omap_pcm_dma_data omap_dmic_dai_dma_params = {
+	.name		= "DMIC capture",
+	.data_type	= OMAP_DMA_DATA_TYPE_S32,
+	.sync_mode	= OMAP_DMA_SYNC_PACKET,
+};
+
+static inline void omap_dmic_write(struct omap_dmic *dmic, u16 reg, u32 val)
+{
+	__raw_writel(val, dmic->io_base + reg);
+}
+
+static inline int omap_dmic_read(struct omap_dmic *dmic, u16 reg)
+{
+	return __raw_readl(dmic->io_base + reg);
+}
+
+static inline void omap_dmic_start(struct omap_dmic *dmic)
+{
+	u32 ctrl = omap_dmic_read(dmic, OMAP_DMIC_CTRL_REG);
+
+	/* Configure DMA controller */
+	omap_dmic_write(dmic, OMAP_DMIC_DMAENABLE_SET_REG,
+			OMAP_DMIC_DMA_ENABLE);
+
+	omap_dmic_write(dmic, OMAP_DMIC_CTRL_REG, ctrl | dmic->ch_enabled);
+}
+
+static inline void omap_dmic_stop(struct omap_dmic *dmic)
+{
+	u32 ctrl = omap_dmic_read(dmic, OMAP_DMIC_CTRL_REG);
+	omap_dmic_write(dmic, OMAP_DMIC_CTRL_REG,
+			ctrl & ~OMAP_DMIC_UP_ENABLE_MASK);
+
+	/* Disable DMA request generation */
+	omap_dmic_write(dmic, OMAP_DMIC_DMAENABLE_CLR_REG,
+			OMAP_DMIC_DMA_ENABLE);
+
+}
+
+static inline int dmic_is_enabled(struct omap_dmic *dmic)
+{
+	return omap_dmic_read(dmic, OMAP_DMIC_CTRL_REG) &
+						OMAP_DMIC_UP_ENABLE_MASK;
+}
+
+static int omap_dmic_dai_startup(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *dai)
+{
+	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
+	int ret = 0;
+
+	mutex_lock(&dmic->mutex);
+
+	if (!dai->active) {
+		pm_runtime_get_sync(dmic->dev);
+		snd_pcm_hw_constraint_msbits(substream->runtime, 0, 32, 24);
+	} else {
+		ret = -EBUSY;
+	}
+
+	mutex_unlock(&dmic->mutex);
+
+	return ret;
+}
+
+static void omap_dmic_dai_shutdown(struct snd_pcm_substream *substream,
+				    struct snd_soc_dai *dai)
+{
+	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
+
+	mutex_lock(&dmic->mutex);
+
+	if (!dai->active)
+		pm_runtime_put_sync(dmic->dev);
+
+	mutex_unlock(&dmic->mutex);
+}
+
+static int omap_dmic_dai_hw_params(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *params,
+				    struct snd_soc_dai *dai)
+{
+	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
+	int channels;
+
+	/*
+	 * 192KHz rate is only supported with 19.2MHz/3.84MHz clock
+	 * configuration. Fix the dmic clock divider for 192KHz
+	 */
+	if (params_rate(params) == 192000) {
+		if (dmic->fclk_freq == 19200000 && dmic->clk_div == 0x1) {
+			dmic->clk_div = 0x6;
+		} else {
+			dev_err(dmic->dev,
+				"invalid clock configuration for 192KHz\n");
+			return -EINVAL;
+		}
+	}
+
+	dmic->ch_enabled = 0;
+	channels = params_channels(params);
+	switch (channels) {
+	case 6:
+		dmic->ch_enabled |= OMAP_DMIC_UP3_ENABLE;
+	case 4:
+		dmic->ch_enabled |= OMAP_DMIC_UP2_ENABLE;
+	case 2:
+		dmic->ch_enabled |= OMAP_DMIC_UP1_ENABLE;
+		break;
+	default:
+		dev_err(dmic->dev, "invalid number of legacy channels\n");
+		return -EINVAL;
+	}
+
+	/* packet size is threshold * channels */
+	omap_dmic_dai_dma_params.packet_size = dmic->threshold * channels;
+	snd_soc_dai_set_dma_data(dai, substream, &omap_dmic_dai_dma_params);
+
+	return 0;
+}
+
+static int omap_dmic_dai_prepare(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *dai)
+{
+	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
+	u32 ctrl;
+
+	/* Configure uplink threshold */
+	omap_dmic_write(dmic, OMAP_DMIC_FIFO_CTRL_REG, dmic->threshold);
+
+	ctrl = omap_dmic_read(dmic, OMAP_DMIC_CTRL_REG);
+
+	/* Set dmic out format */
+	ctrl &= ~(OMAP_DMIC_FORMAT | OMAP_DMIC_POLAR_MASK);
+	ctrl |= (OMAP_DMICOUTFORMAT_LJUST | OMAP_DMIC_POLAR1 |
+		 OMAP_DMIC_POLAR2 | OMAP_DMIC_POLAR3);
+
+	/* Configure dmic clock divider */
+	ctrl &= ~OMAP_DMIC_CLK_DIV_MASK;
+	ctrl |= OMAP_DMIC_CLK_DIV(dmic->clk_div);
+
+	omap_dmic_write(dmic, OMAP_DMIC_CTRL_REG, ctrl);
+
+	omap_dmic_write(dmic, OMAP_DMIC_CTRL_REG,
+			ctrl | OMAP_DMICOUTFORMAT_LJUST |
+			OMAP_DMIC_POLAR1 | OMAP_DMIC_POLAR2 | OMAP_DMIC_POLAR3);
+
+	return 0;
+}
+
+static int omap_dmic_dai_trigger(struct snd_pcm_substream *substream,
+				  int cmd, struct snd_soc_dai *dai)
+{
+	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		omap_dmic_start(dmic);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		omap_dmic_stop(dmic);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int omap_dmic_select_fclk(struct omap_dmic *dmic, int clk_id,
+				 unsigned int freq)
+{
+	struct clk *parent_clk;
+	char *parent_clk_name;
+	int ret = 0;
+
+	switch (freq) {
+	case 12000000:
+	case 19200000:
+	case 24000000:
+	case 24576000:
+		break;
+	default:
+		dev_err(dmic->dev, "invalid input frequency: %dHz\n", freq);
+		return -EINVAL;
+	}
+
+	if (dmic->sysclk == clk_id) {
+		dmic->fclk_freq = freq;
+		return 0;
+	}
+
+	/* re-parent not allowed if a stream is ongoing */
+	if (dmic_is_enabled(dmic)) {
+		dev_err(dmic->dev, "can't re-parent when DMIC active\n");
+		return -EBUSY;
+	}
+
+	switch (clk_id) {
+	case OMAP_DMIC_SYSCLK_PAD_CLKS:
+		parent_clk_name = "pad_clks_ck";
+		break;
+	case OMAP_DMIC_SYSCLK_SLIMBLUS_CLKS:
+		parent_clk_name = "slimbus_clk";
+		break;
+	case OMAP_DMIC_SYSCLK_SYNC_MUX_CLKS:
+		parent_clk_name = "dmic_sync_mux_ck";
+		break;
+	default:
+		dev_err(dmic->dev, "clk_id not supported %d\n", clk_id);
+		return -EINVAL;
+	}
+
+	parent_clk = clk_get(dmic->dev, parent_clk_name);
+	if (IS_ERR(parent_clk)) {
+		dev_err(dmic->dev, "can't get %s\n", parent_clk_name);
+		return -ENODEV;
+	}
+
+	/* disable clock while reparenting */
+	pm_runtime_put_sync(dmic->dev);
+	ret = clk_set_parent(dmic->fclk, parent_clk);
+	pm_runtime_get_sync(dmic->dev);
+	if (ret < 0) {
+		dev_err(dmic->dev, "re-parent failed\n");
+		goto err_busy;
+	}
+
+	dmic->sysclk = clk_id;
+	dmic->fclk_freq = freq;
+
+err_busy:
+	clk_put(parent_clk);
+
+	return ret;
+}
+
+static int omap_dmic_select_divider(struct omap_dmic *dmic, unsigned int freq)
+{
+	dmic->clk_div = 0;
+	switch (freq) {
+	case 1536000:
+		if (dmic->fclk_freq != 24576000)
+			goto div_err;
+		dmic->clk_div = 0x4; /* Divider: 16 */
+		break;
+	case 2400000:
+		switch (dmic->fclk_freq) {
+		case 12000000:
+			dmic->clk_div = 0x5; /* Divider: 5 */
+			break;
+		case 19200000:
+			dmic->clk_div = 0x0; /* Divider: 8 */
+			break;
+		case 24000000:
+			dmic->clk_div = 0x2; /* Divider: 10 */
+			break;
+		default:
+			goto div_err;
+		}
+		break;
+	case 3072000:
+		if (dmic->fclk_freq != 24576000)
+			goto div_err;
+		dmic->clk_div = 0x3; /* Divider: 8 */
+		break;
+	case 3840000:
+		if (dmic->fclk_freq != 19200000)
+			goto div_err;
+		dmic->clk_div = 0x1; /* Divider: 5 */
+		break;
+	default:
+		dev_err(dmic->dev, "invalid out frequency: %dHz\n", freq);
+		return -EINVAL;
+	}
+
+	return 0;
+
+div_err:
+	dev_err(dmic->dev, "invalid out frequency %dHz for %dHz input\n", freq,
+		dmic->fclk_freq);
+	return -EINVAL;
+}
+
+static int omap_dmic_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
+				    unsigned int freq, int dir)
+{
+	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
+
+	if (dir == SND_SOC_CLOCK_IN)
+		return omap_dmic_select_fclk(dmic, clk_id, freq);
+	else if (dir == SND_SOC_CLOCK_OUT)
+		return omap_dmic_select_divider(dmic, freq);
+
+	dev_err(dmic->dev, "invalid clock direction (%d)\n", dir);
+	return -EINVAL;
+}
+
+static const struct snd_soc_dai_ops omap_dmic_dai_ops = {
+	.startup	= omap_dmic_dai_startup,
+	.shutdown	= omap_dmic_dai_shutdown,
+	.hw_params	= omap_dmic_dai_hw_params,
+	.prepare	= omap_dmic_dai_prepare,
+	.trigger	= omap_dmic_dai_trigger,
+	.set_sysclk	= omap_dmic_set_dai_sysclk,
+};
+
+static int omap_dmic_probe(struct snd_soc_dai *dai)
+{
+	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
+
+	pm_runtime_enable(dmic->dev);
+
+	/* Disable lines while request is ongoing */
+	pm_runtime_get_sync(dmic->dev);
+	omap_dmic_write(dmic, OMAP_DMIC_CTRL_REG, 0x00);
+	pm_runtime_put_sync(dmic->dev);
+
+	/* Configure DMIC threshold value */
+	dmic->threshold = OMAP_DMIC_THRES_MAX - 3;
+	return 0;
+}
+
+static int omap_dmic_remove(struct snd_soc_dai *dai)
+{
+	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
+
+	pm_runtime_disable(dmic->dev);
+
+	return 0;
+}
+
+static struct snd_soc_dai_driver omap_dmic_dai = {
+	.name = "omap-dmic",
+	.probe = omap_dmic_probe,
+	.remove = omap_dmic_remove,
+	.capture = {
+		.channels_min = 2,
+		.channels_max = 6,
+		.rates = SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000,
+		.formats = SNDRV_PCM_FMTBIT_S32_LE,
+	},
+	.ops = &omap_dmic_dai_ops,
+};
+
+static __devinit int asoc_dmic_probe(struct platform_device *pdev)
+{
+	struct omap_dmic *dmic;
+	struct resource *res;
+	int ret;
+
+	dmic = kzalloc(sizeof(struct omap_dmic), GFP_KERNEL);
+	if (!dmic)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, dmic);
+	dmic->dev = &pdev->dev;
+	dmic->sysclk = OMAP_DMIC_SYSCLK_SYNC_MUX_CLKS;
+
+	mutex_init(&dmic->mutex);
+
+	dmic->fclk = clk_get(dmic->dev, "dmic_fck");
+	if (IS_ERR(dmic->fclk)) {
+		dev_err(dmic->dev, "cant get dmic_fck\n");
+		ret = -ENODEV;
+		goto err_fclk;
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma");
+	if (!res) {
+		dev_err(dmic->dev, "invalid dma memory resource\n");
+		ret = -ENODEV;
+		goto err_res;
+	}
+	omap_dmic_dai_dma_params.port_addr = res->start + OMAP_DMIC_DATA_REG;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
+	if (!res) {
+		dev_err(dmic->dev, "invalid memory resource\n");
+		ret = -ENODEV;
+		goto err_res;
+	}
+
+	dmic->io_base = ioremap(res->start, resource_size(res));
+	if (!dmic->io_base) {
+		ret = -ENOMEM;
+		goto err_res;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!res) {
+		dev_err(dmic->dev, "invalid dma resource\n");
+		ret = -ENODEV;
+		goto err_dai;
+	}
+	omap_dmic_dai_dma_params.dma_req = res->start;
+
+	ret = snd_soc_register_dai(&pdev->dev, &omap_dmic_dai);
+	if (ret)
+		goto err_dai;
+
+	return 0;
+
+err_dai:
+	iounmap(dmic->io_base);
+err_res:
+	clk_put(dmic->fclk);
+err_fclk:
+	kfree(dmic);
+	return ret;
+}
+
+static int __devexit asoc_dmic_remove(struct platform_device *pdev)
+{
+	struct omap_dmic *dmic = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_dai(&pdev->dev);
+	iounmap(dmic->io_base);
+	clk_put(dmic->fclk);
+	kfree(dmic);
+
+	return 0;
+}
+
+static struct platform_driver asoc_dmic_driver = {
+	.driver = {
+		.name = "omap-dmic",
+		.owner = THIS_MODULE,
+	},
+	.probe = asoc_dmic_probe,
+	.remove = __devexit_p(asoc_dmic_remove),
+};
+
+static int __init snd_omap_dmic_init(void)
+{
+	return platform_driver_register(&asoc_dmic_driver);
+}
+module_init(snd_omap_dmic_init);
+
+static void __exit snd_omap_dmic_exit(void)
+{
+	platform_driver_unregister(&asoc_dmic_driver);
+}
+module_exit(snd_omap_dmic_exit);
+
+MODULE_ALIAS("platform:omap-dmic");
+MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
+MODULE_DESCRIPTION("OMAP DMIC ASoC Interface");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/omap/omap-dmic.h b/sound/soc/omap/omap-dmic.h
new file mode 100644
index 0000000..3f964d8
--- /dev/null
+++ b/sound/soc/omap/omap-dmic.h
@@ -0,0 +1,73 @@
+/*
+ * omap-dmic.h  --  OMAP Digital Microphone Controller
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _OMAP_DMIC_H
+#define _OMAP_DMIC_H
+
+#define OMAP_DMIC_REVISION_REG		0x00
+#define OMAP_DMIC_SYSCONFIG_REG		0x10
+#define OMAP_DMIC_IRQSTATUS_RAW_REG	0x24
+#define OMAP_DMIC_IRQSTATUS_REG		0x28
+#define OMAP_DMIC_IRQENABLE_SET_REG	0x2C
+#define OMAP_DMIC_IRQENABLE_CLR_REG	0x30
+#define OMAP_DMIC_IRQWAKE_EN_REG	0x34
+#define OMAP_DMIC_DMAENABLE_SET_REG	0x38
+#define OMAP_DMIC_DMAENABLE_CLR_REG	0x3C
+#define OMAP_DMIC_DMAWAKEEN_REG		0x40
+#define OMAP_DMIC_CTRL_REG		0x44
+#define OMAP_DMIC_DATA_REG		0x48
+#define OMAP_DMIC_FIFO_CTRL_REG		0x4C
+#define OMAP_DMIC_FIFO_DMIC1R_DATA_REG	0x50
+#define OMAP_DMIC_FIFO_DMIC1L_DATA_REG	0x54
+#define OMAP_DMIC_FIFO_DMIC2R_DATA_REG	0x58
+#define OMAP_DMIC_FIFO_DMIC2L_DATA_REG	0x5C
+#define OMAP_DMIC_FIFO_DMIC3R_DATA_REG	0x60
+#define OMAP_DMIC_FIFO_DMIC3L_DATA_REG	0x64
+
+/* IRQSTATUS_RAW, IRQSTATUS, IRQENABLE_SET, IRQENABLE_CLR bit fields */
+#define OMAP_DMIC_IRQ			(1 << 0)
+#define OMAP_DMIC_IRQ_FULL		(1 << 1)
+#define OMAP_DMIC_IRQ_ALMST_EMPTY	(1 << 2)
+#define OMAP_DMIC_IRQ_EMPTY		(1 << 3)
+#define OMAP_DMIC_IRQ_MASK		0x07
+
+/* DMIC_DMAENABLE bit fields */
+#define OMAP_DMIC_DMA_ENABLE		0x1
+
+/* DMIC_CTRL bit fields */
+#define OMAP_DMIC_UP1_ENABLE		(1 << 0)
+#define OMAP_DMIC_UP2_ENABLE		(1 << 1)
+#define OMAP_DMIC_UP3_ENABLE		(1 << 2)
+#define OMAP_DMIC_UP_ENABLE_MASK	0x7
+#define OMAP_DMIC_FORMAT		(1 << 3)
+#define OMAP_DMIC_POLAR1		(1 << 4)
+#define OMAP_DMIC_POLAR2		(1 << 5)
+#define OMAP_DMIC_POLAR3		(1 << 6)
+#define OMAP_DMIC_POLAR_MASK		(0x7 << 4)
+#define OMAP_DMIC_CLK_DIV(x)		(((x) & 0x7) << 7)
+#define OMAP_DMIC_CLK_DIV_MASK		(0x7 << 7)
+#define	OMAP_DMIC_RESET			(1 << 10)
+
+#define OMAP_DMICOUTFORMAT_LJUST	(0 << 3)
+#define OMAP_DMICOUTFORMAT_RJUST	(1 << 3)
+
+/* DMIC_FIFO_CTRL bit fields */
+#define OMAP_DMIC_THRES_MAX		0xF
+
+enum omap_dmic_clk {
+	OMAP_DMIC_SYSCLK_PAD_CLKS,		/* PAD_CLKS */
+	OMAP_DMIC_SYSCLK_SLIMBLUS_CLKS,		/* SLIMBUS_CLK */
+	OMAP_DMIC_SYSCLK_SYNC_MUX_CLKS,		/* DMIC_SYNC_MUX_CLK */
+};
+
+/* DMIC dividers */
+enum omap_dmic_div {
+	OMAP_DMIC_CLKDIV,
+};
+
+#endif
-- 
1.7.8.rc3

