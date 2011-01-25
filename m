From: David Lambert <dlambert@ti.com>
Subject: [PATCH v3 1/4] ASoC: DMIC: Adding the OMAP DMIC driver
Date: Tue, 25 Jan 2011 16:00:59 -0600
Message-ID: <1295992862-6154-2-git-send-email-dlambert@ti.com>
References: <1295992862-6154-1-git-send-email-dlambert@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46843 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753815Ab1AYWBh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jan 2011 17:01:37 -0500
In-Reply-To: <1295992862-6154-1-git-send-email-dlambert@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, David Lambert <dlambert@ti.com>

This patch adds support for the OMAP4 digital microphone DAI.

This DAI can support support recording in 2, 4, or 6 channels

When provided with a 19.2Mhz functional clock, can encode at 96Khz or
192Khz (all channels must have the same sample rate).

Details of the hardware interface can be found in the OMAP4 TRM in Section 23.7

Signed-off-by: David Lambert <dlambert@ti.com>
---
 arch/arm/plat-omap/include/plat/dmic.h |   82 +++++
 sound/soc/omap/Kconfig                 |    3 +
 sound/soc/omap/Makefile                |    2 +
 sound/soc/omap/omap-dmic.c             |  534 ++++++++++++++++++++++++++++++++
 4 files changed, 621 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/dmic.h
 create mode 100644 sound/soc/omap/omap-dmic.c

diff --git a/arch/arm/plat-omap/include/plat/dmic.h b/arch/arm/plat-omap/include/plat/dmic.h
new file mode 100644
index 0000000..a72e080
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/dmic.h
@@ -0,0 +1,82 @@
+/*
+ * omap-dmic.h  --  OMAP Digital Microphone Controller
+ *
+ * Author: Liam Girdwood <lrg@slimlogic.co.uk>
+ *	   David Lambert <dlambert@ti.com>
+ *	   Misael Lopez Cruz <misael.lopez@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_ARCH_OMAP_DMIC_H
+#define __ASM_ARCH_OMAP_DMIC_H
+
+#define OMAP44XX_DMIC_L3_BASE	0x4902e000
+
+#define OMAP_DMIC_REVISION		0x00
+#define OMAP_DMIC_SYSCONFIG		0x10
+#define OMAP_DMIC_IRQSTATUS_RAW		0x24
+#define OMAP_DMIC_IRQSTATUS		0x28
+#define OMAP_DMIC_IRQENABLE_SET		0x2C
+#define OMAP_DMIC_IRQENABLE_CLR		0x30
+#define OMAP_DMIC_IRQWAKE_EN		0x34
+#define OMAP_DMIC_DMAENABLE_SET		0x38
+#define OMAP_DMIC_DMAENABLE_CLR		0x3C
+#define OMAP_DMIC_DMAWAKEEN		0x40
+#define OMAP_DMIC_CTRL			0x44
+#define OMAP_DMIC_DATA			0x48
+#define OMAP_DMIC_FIFO_CTRL		0x4C
+#define OMAP_DMIC_FIFO_DMIC1R_DATA	0x50
+#define OMAP_DMIC_FIFO_DMIC1L_DATA	0x54
+#define OMAP_DMIC_FIFO_DMIC2R_DATA	0x58
+#define OMAP_DMIC_FIFO_DMIC2L_DATA	0x5C
+#define OMAP_DMIC_FIFO_DMIC3R_DATA	0x60
+#define OMAP_DMIC_FIFO_DMIC3L_DATA	0x64
+
+/*
+ * DMIC_IRQ bit fields
+ * IRQSTATUS_RAW, IRQSTATUS, IRQENABLE_SET, IRQENABLE_CLR
+ */
+
+#define OMAP_DMIC_IRQ			(1 << 0)
+#define OMAP_DMIC_IRQ_FULL		(1 << 1)
+#define OMAP_DMIC_IRQ_ALMST_EMPTY	(1 << 2)
+#define OMAP_DMIC_IRQ_EMPTY		(1 << 3)
+#define OMAP_DMIC_IRQ_MASK		0x07
+
+/*
+ * DMIC_DMAENABLE bit fields
+ */
+
+#define OMAP_DMIC_DMA_ENABLE		0x1
+
+/*
+ * DMIC_CTRL bit fields
+ */
+
+#define OMAP_DMIC_UP1_ENABLE		0x0001
+#define OMAP_DMIC_UP2_ENABLE		0x0002
+#define OMAP_DMIC_UP3_ENABLE		0x0004
+#define OMAP_DMIC_FORMAT		0x0008
+#define OMAP_DMIC_POLAR1		0x0010
+#define OMAP_DMIC_POLAR2		0x0020
+#define OMAP_DMIC_POLAR3		0x0040
+#define OMAP_DMIC_POLAR_MASK		0x0070
+#define OMAP_DMIC_CLK_DIV_SHIFT		7
+#define OMAP_DMIC_CLK_DIV_MASK		0x0380
+#define	OMAP_DMIC_RESET			0x0400
+
+#define OMAP_DMIC_ENABLE_MASK		0x007
+
+#define OMAP_DMICOUTFORMAT_LJUST	(0 << 3)
+#define OMAP_DMICOUTFORMAT_RJUST	(1 << 3)
+
+/*
+ * DMIC_FIFO_CTRL bit fields
+ */
+
+#define OMAP_DMIC_THRES_MAX		0xF
+
+#endif
diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index a088db6..818ead3 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -9,6 +9,9 @@ config SND_OMAP_SOC_MCBSP
 config SND_OMAP_SOC_MCPDM
 	tristate
 
+config SND_OMAP_SOC_DMIC
+	tristate
+
 config SND_OMAP_SOC_N810
 	tristate "SoC Audio support for Nokia N810"
 	depends on SND_OMAP_SOC && MACH_NOKIA_N810 && I2C
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index ba9fc65..6ff27f5 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -1,9 +1,11 @@
 # OMAP Platform Support
 snd-soc-omap-objs := omap-pcm.o
+snd-soc-omap-dmic-objs := omap-dmic.o
 snd-soc-omap-mcbsp-objs := omap-mcbsp.o
 snd-soc-omap-mcpdm-objs := omap-mcpdm.o mcpdm.o
 
 obj-$(CONFIG_SND_OMAP_SOC) += snd-soc-omap.o
+obj-$(CONFIG_SND_OMAP_SOC_DMIC) += snd-soc-omap-dmic.o
 obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o
 obj-$(CONFIG_SND_OMAP_SOC_MCPDM) += snd-soc-omap-mcpdm.o
 
diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
new file mode 100644
index 0000000..06dbb99
--- /dev/null
+++ b/sound/soc/omap/omap-dmic.c
@@ -0,0 +1,534 @@
+/*
+ * omap-dmic.c  --  OMAP ASoC DMIC DAI driver
+ *
+ * Copyright (C) 2010 Texas Instruments
+ *
+ * Author: Liam Girdwood <lrg@slimlogic.co.uk>
+ *	   David Lambert <dlambert@ti.com>
+ *	   Misael Lopez Cruz <misael.lopez@ti.com>
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
+#undef DEBUG
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/wait.h>
+#include <linux/interrupt.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/pm_runtime.h>
+
+#include <plat/control.h>
+#include <plat/dma.h>
+#include <plat/dmic.h>
+#include <plat/omap_hwmod.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include "omap-pcm.h"
+
+#define OMAP_DMIC_RATES		(SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000)
+#define OMAP_DMIC_FORMATS	SNDRV_PCM_FMTBIT_S32_LE
+
+struct omap_dmic {
+	struct device *dev;
+	void __iomem *io_base;
+	int clk_freq;
+	int sysclk;
+	int active;
+	spinlock_t lock;
+	struct omap_dmic_link *link;
+};
+
+struct omap_dmic_link {
+	int threshold;
+	int format;
+	int channels;
+	int polar;
+};
+
+static struct omap_dmic_link omap_dmic_link = {
+	.threshold	= 2,
+	.format		= OMAP_DMICOUTFORMAT_LJUST,
+	.polar		= OMAP_DMIC_POLAR1 | OMAP_DMIC_POLAR2
+				| OMAP_DMIC_POLAR3,
+};
+
+/*
+ * Stream DMA parameters
+ */
+static struct omap_pcm_dma_data omap_dmic_dai_dma_params = {
+	.name		= "DMIC capture",
+	.data_type	= OMAP_DMA_DATA_TYPE_S32,
+	.sync_mode	= OMAP_DMA_SYNC_PACKET,
+	.packet_size	= 2,
+	.port_addr	= OMAP44XX_DMIC_L3_BASE + OMAP_DMIC_DATA,
+};
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
+static inline void omap_dmic_write(struct omap_dmic *dmic,
+		u16 reg, u32 val)
+{
+	__raw_writel(val, dmic->io_base + reg);
+}
+
+static inline int omap_dmic_read(struct omap_dmic *dmic, u16 reg)
+{
+	return __raw_readl(dmic->io_base + reg);
+}
+
+/*
+ * Enables the transfer through the DMIC interface
+ */
+static void omap_dmic_start(struct omap_dmic *dmic, int channels)
+{
+	u32 ctrl = omap_dmic_read(dmic, OMAP_DMIC_CTRL);
+	omap_dmic_write(dmic, OMAP_DMIC_CTRL, ctrl | channels);
+
+}
+
+/*
+ * Disables the transfer through the DMIC interface
+ */
+static void omap_dmic_stop(struct omap_dmic *dmic, int channels)
+{
+	u32 ctrl = omap_dmic_read(dmic, OMAP_DMIC_CTRL);
+	omap_dmic_write(dmic, OMAP_DMIC_CTRL, ctrl & ~channels);
+}
+
+static int omap_dmic_set_clkdiv(struct snd_soc_dai *dai,
+				int div_id, int div)
+{
+	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
+	int ctrl, div_sel = -EINVAL;
+
+	if (div_id != OMAP_DMIC_CLKDIV)
+		return -ENODEV;
+
+	switch (dmic->clk_freq) {
+	case 19200000:
+		switch (div) {
+		case 5:
+			div_sel = 0x1;
+			break;
+		case 8:
+			div_sel = 0x0;
+			break;
+		default:
+			dev_err(dai->dev, "invalid div_sel (%d) for freq", div);
+			return -EINVAL;
+			}
+		break;
+	case 24000000:
+		switch (div) {
+		case 10:
+			div_sel = 0x2;
+			break;
+		default:
+			dev_err(dai->dev, "invalid div_sel (%d) for freq", div);
+			return -EINVAL;
+			}
+		break;
+	case 24576000:
+		switch (div) {
+		case 8:
+			div_sel = 0x3;
+			break;
+		case 16:
+			div_sel = 0x4;
+			break;
+		default:
+			dev_err(dai->dev, "invalid div_sel (%d) for freq", div);
+			return -EINVAL;
+			}
+		break;
+	case 12000000:
+		switch (div) {
+		case 5:
+			div_sel = 0x5;
+			break;
+		default:
+			dev_err(dai->dev, "invalid div_sel (%d) for freq", div);
+			return -EINVAL;
+			}
+		break;
+	default:
+		dev_err(dai->dev, "invalid freq %d\n", dmic->clk_freq);
+		return -EINVAL;
+	}
+
+	if (div_sel < 0) {
+		dev_err(dai->dev, "divider not supported %d\n", div);
+		return -EINVAL;
+	}
+
+	ctrl = omap_dmic_read(dmic, OMAP_DMIC_CTRL) & ~OMAP_DMIC_CLK_DIV_MASK;
+
+	omap_dmic_write(dmic, OMAP_DMIC_CTRL,
+			ctrl | (div_sel << OMAP_DMIC_CLK_DIV_SHIFT));
+
+	return 0;
+}
+
+/*
+ * Configures DMIC for audio recording.
+ * This function should be called before omap_dmic_start.
+ */
+static int omap_dmic_open(struct omap_dmic *dmic)
+{
+	struct omap_dmic_link *link = dmic->link;
+	u32 ctrl;
+
+	/* Configure uplink threshold */
+	if (link->threshold > OMAP_DMIC_THRES_MAX)
+		link->threshold = OMAP_DMIC_THRES_MAX;
+
+	omap_dmic_write(dmic, OMAP_DMIC_FIFO_CTRL, link->threshold);
+
+	/* Configure DMA controller */
+	omap_dmic_write(dmic, OMAP_DMIC_DMAENABLE_SET, OMAP_DMIC_DMA_ENABLE);
+
+	/* Set dmic out format */
+	ctrl = omap_dmic_read(dmic, OMAP_DMIC_CTRL)
+		& ~(OMAP_DMIC_FORMAT | OMAP_DMIC_POLAR_MASK);
+	omap_dmic_write(dmic, OMAP_DMIC_CTRL,
+			ctrl | link->format | link->polar);
+
+	return 0;
+}
+
+/*
+ * Cleans DMIC uplink configuration.
+ * This function should be called when the stream is closed.
+ */
+static int omap_dmic_close(struct omap_dmic *dmic)
+{
+
+	/* Disable DMA request generation */
+	omap_dmic_write(dmic, OMAP_DMIC_DMAENABLE_CLR, OMAP_DMIC_DMA_ENABLE);
+
+	return 0;
+}
+
+static int omap_dmic_dai_startup(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *dai)
+{
+	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
+
+	dmic->active++;
+	pm_runtime_get_sync(dmic->dev);
+
+	return 0;
+}
+
+static void omap_dmic_dai_shutdown(struct snd_pcm_substream *substream,
+				    struct snd_soc_dai *dai)
+{
+	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
+
+	dmic->active--;
+	pm_runtime_put_sync(dmic->dev);
+}
+
+static int omap_dmic_dai_hw_params(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *params,
+				    struct snd_soc_dai *dai)
+{
+	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
+	struct omap_dmic_link *link = dmic->link;
+	int channels, rate, div;
+	int ret = 0;
+
+	channels = params_channels(params);
+	switch (channels) {
+	case 6:
+		link->channels = OMAP_DMIC_UP1_ENABLE | OMAP_DMIC_UP2_ENABLE
+			 | OMAP_DMIC_UP3_ENABLE;
+		break;
+	case 4:
+		link->channels = OMAP_DMIC_UP1_ENABLE | OMAP_DMIC_UP2_ENABLE;
+		break;
+	case 2:
+		link->channels = OMAP_DMIC_UP1_ENABLE;
+		break;
+	default:
+		dev_err(dmic->dev, "invalid number of channels\n");
+		return -EINVAL;
+	}
+
+	rate = params_rate(params);
+	switch (rate) {
+	case 96000:
+		div = 8;
+		break;
+	case 192000:
+		div = 5;
+		break;
+	default:
+		dev_err(dmic->dev, "invalid frequency\n");
+		return -EINVAL;
+	}
+
+	omap_dmic_set_clkdiv(dai, OMAP_DMIC_CLKDIV, div);
+
+	omap_dmic_dai_dma_params.packet_size = link->threshold * channels;
+	snd_soc_dai_set_dma_data(dai, substream, &omap_dmic_dai_dma_params);
+
+	if (dmic->active == 1)
+		ret = omap_dmic_open(dmic);
+
+	return ret;
+}
+
+static int omap_dmic_dai_hw_free(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *dai)
+{
+	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
+	struct omap_dmic_link *link = dmic->link;
+	int ret = 0;
+
+	if (dmic->active == 1) {
+		ret = omap_dmic_close(dmic);
+		link->channels = 0;
+	}
+
+	return ret;
+}
+
+static int omap_dmic_dai_trigger(struct snd_pcm_substream *substream,
+				  int cmd, struct snd_soc_dai *dai)
+{
+	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
+	int dmic_id = dmic->link->channels;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		omap_dmic_start(dmic, dmic_id);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		omap_dmic_stop(dmic, dmic_id);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int omap_dmic_set_dai_sysclk(struct snd_soc_dai *dai,
+				    int clk_id, unsigned int freq,
+				    int dir)
+{
+	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
+	struct clk *dmic_clk, *parent_clk;
+	int ret = 0;
+
+	dmic_clk = clk_get(NULL, "dmic_fck");
+	if (IS_ERR(dmic_clk))
+		return -ENODEV;
+
+	switch (clk_id) {
+	case OMAP_DMIC_SYSCLK_PAD_CLKS:
+		parent_clk = clk_get(NULL, "pad_clks_ck");
+		if (IS_ERR(parent_clk)) {
+			ret = -ENODEV;
+			goto err_par;
+		}
+		break;
+	case OMAP_DMIC_SYSCLK_SLIMBLUS_CLKS:
+		parent_clk = clk_get(NULL, "slimbus_clk");
+		if (IS_ERR(parent_clk)) {
+			ret = -ENODEV;
+			goto err_par;
+		}
+		break;
+	case OMAP_DMIC_SYSCLK_SYNC_MUX_CLKS:
+		parent_clk = clk_get(NULL, "dmic_sync_mux_ck");
+		if (IS_ERR(parent_clk)) {
+			ret = -ENODEV;
+			goto err_par;
+		}
+		break;
+	default:
+		dev_err(dai->dev, "clk_id not supported %d\n", clk_id);
+		ret = -EINVAL;
+		goto err_par;
+	}
+
+	if (dmic->sysclk != clk_id) {
+		/* reparent not allowed if a stream is ongoing */
+		if (dmic->active > 1) {
+			ret = -EBUSY;
+			goto err_busy;
+		}
+
+		/* disable clock while reparenting */
+		if (dmic->active == 1)
+			pm_runtime_put_sync(dmic->dev);
+
+		ret = clk_set_parent(dmic_clk, parent_clk);
+
+		if (dmic->active == 1)
+			pm_runtime_get_sync(dmic->dev);
+
+		dmic->sysclk = clk_id;
+	}
+
+	dmic->clk_freq = clk_get_rate(dmic_clk);
+
+err_busy:
+	clk_put(parent_clk);
+err_par:
+	clk_put(dmic_clk);
+
+	return ret;
+}
+
+static struct snd_soc_dai_ops omap_dmic_dai_ops = {
+	.startup	= omap_dmic_dai_startup,
+	.shutdown	= omap_dmic_dai_shutdown,
+	.hw_params	= omap_dmic_dai_hw_params,
+	.trigger	= omap_dmic_dai_trigger,
+	.hw_free	= omap_dmic_dai_hw_free,
+	.set_sysclk	= omap_dmic_set_dai_sysclk,
+	.set_clkdiv	= omap_dmic_set_clkdiv,
+};
+
+static struct snd_soc_dai_driver omap_dmic_dai = {
+
+	.name = "omap-dmic-dai-0",
+	.capture = {
+		.channels_min = 2,
+		.channels_max = 6,
+		.rates = OMAP_DMIC_RATES,
+		.formats = OMAP_DMIC_FORMATS,
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
+	dmic->link = &omap_dmic_link;
+	dmic->sysclk = OMAP_DMIC_SYSCLK_SYNC_MUX_CLKS;
+
+	spin_lock_init(&dmic->lock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
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
+	pm_runtime_enable(dmic->dev);
+
+	/* Disable lines while request is ongoing */
+	omap_dmic_write(dmic, OMAP_DMIC_CTRL, 0x00);
+
+	ret = snd_soc_register_dais(&pdev->dev, &omap_dmic_dai, 1);
+	if (ret)
+		goto err_dai;
+
+	return 0;
+
+err_dai:
+	iounmap(dmic->io_base);
+err_res:
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
+	pm_runtime_disable(dmic->dev);
+	kfree(dmic);
+
+	return 0;
+}
+
+static struct platform_driver asoc_dmic_driver = {
+	.driver = {
+		.name = "omap-dmic-dai",
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
+MODULE_ALIAS("platform:omap-dmic-dai");
+MODULE_AUTHOR("David Lambert <dlambert@ti.com>");
+MODULE_DESCRIPTION("OMAP DMIC SoC Interface");
+MODULE_LICENSE("GPL");
-- 
1.7.0.4

