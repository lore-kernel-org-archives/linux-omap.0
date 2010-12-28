From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/5] ASoC: DMIC: Adding the OMAP DMIC driver
Date: Tue, 28 Dec 2010 13:14:24 +0200
Message-ID: <20101228111424.GB2239@legolas.emea.dhcp.ti.com>
References: <1293509826-23253-1-git-send-email-dlambert@ti.com>
 <1293509826-23253-2-git-send-email-dlambert@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:46030 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753084Ab0L1LO3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Dec 2010 06:14:29 -0500
Received: by ewy23 with SMTP id 23so4950242ewy.39
        for <linux-omap@vger.kernel.org>; Tue, 28 Dec 2010 03:14:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1293509826-23253-2-git-send-email-dlambert@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Lambert <dlambert@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

Hi,

On Mon, Dec 27, 2010 at 10:17:02PM -0600, David Lambert wrote:
>This patch adds support for the OMAP4 digital microphone DAI.
>
>This DAI can support support recording in 2, 4, or 6 channels
>
>When provided with a 19.2Mhz functional clock, can encode at 96Khz or
>192Khz (all
>channels must have the same sample rate).
>
>Details of the hardware interface can be found in the OMAP4 TRM in Section 23.7
>
>Signed-off-by: David Lambert <dlambert@ti.com>
>---
> arch/arm/plat-omap/include/plat/dmic.h |   83 +++++
> sound/soc/omap/omap-dmic.c             |  596 ++++++++++++++++++++++++++++++++
> sound/soc/omap/omap-dmic.h             |   38 ++
> 3 files changed, 717 insertions(+), 0 deletions(-)
> create mode 100644 arch/arm/plat-omap/include/plat/dmic.h
> create mode 100644 sound/soc/omap/omap-dmic.c
> create mode 100644 sound/soc/omap/omap-dmic.h
>
>diff --git a/arch/arm/plat-omap/include/plat/dmic.h b/arch/arm/plat-omap/include/plat/dmic.h
>new file mode 100644
>index 0000000..8a988bf
>--- /dev/null
>+++ b/arch/arm/plat-omap/include/plat/dmic.h
>@@ -0,0 +1,83 @@
>+/*
>+ * omap-dmic.h  --  OMAP Digital Microphone Controller
>+ *
>+ * Author: Liam Girdwood <lrg@slimlogic.co.uk>
>+ *	   David Lambert <dlambert@ti.com>
>+ *	   Misael Lopez Cruz <misael.lopez@ti.com>
>+ *
>+ * This program is free software; you can redistribute it and/or modify
>+ * it under the terms of the GNU General Public License version 2 as
>+ * published by the Free Software Foundation.
>+ */
>+
>+#ifndef __ASM_ARCH_OMAP_DMIC_H
>+#define __ASM_ARCH_OMAP_DMIC_H
>+
>+#define OMAP44XX_DMIC_L3_BASE	0x4902e000
>+
>+#define OMAP_DMIC_REVISION		0x00
>+#define OMAP_DMIC_SYSCONFIG		0x10
>+#define OMAP_DMIC_IRQSTATUS_RAW		0x24
>+#define OMAP_DMIC_IRQSTATUS		0x28
>+#define OMAP_DMIC_IRQENABLE_SET		0x2C
>+#define OMAP_DMIC_IRQENABLE_CLR		0x30
>+#define OMAP_DMIC_IRQWAKE_EN		0x34
>+#define OMAP_DMIC_DMAENABLE_SET		0x38
>+#define OMAP_DMIC_DMAENABLE_CLR		0x3C
>+#define OMAP_DMIC_DMAWAKEEN		0x40
>+#define OMAP_DMIC_CTRL			0x44
>+#define OMAP_DMIC_DATA			0x48
>+#define OMAP_DMIC_FIFO_CTRL		0x4C
>+#define OMAP_DMIC_FIFO_DMIC1R_DATA	0x50
>+#define OMAP_DMIC_FIFO_DMIC1L_DATA	0x54
>+#define OMAP_DMIC_FIFO_DMIC2R_DATA	0x58
>+#define OMAP_DMIC_FIFO_DMIC2L_DATA	0x5C
>+#define OMAP_DMIC_FIFO_DMIC3R_DATA	0x60
>+#define OMAP_DMIC_FIFO_DMIC3L_DATA	0x64
>+
>+/*
>+ * DMIC_IRQ bit fields
>+ * IRQSTATUS_RAW, IRQSTATUS, IRQENABLE_SET, IRQENABLE_CLR
>+ */
>+
>+#define OMAP_DMIC_IRQ			(1 << 0)
>+#define OMAP_DMIC_IRQ_FULL		(1 << 1)
>+#define OMAP_DMIC_IRQ_ALMST_EMPTY	(1 << 2)
>+#define OMAP_DMIC_IRQ_EMPTY		(1 << 3)
>+#define OMAP_DMIC_IRQ_MASK		0x07
>+
>+/*
>+ * DMIC_DMAENABLE bit fields
>+ */
>+
>+#define OMAP_DMIC_DMA_ENABLE		0x1
>+
>+/*
>+ * DMIC_CTRL bit fields
>+ */
>+
>+#define OMAP_DMIC_UP1_ENABLE		0x0001
>+#define OMAP_DMIC_UP2_ENABLE		0x0002
>+#define OMAP_DMIC_UP3_ENABLE		0x0004
>+#define OMAP_DMIC_FORMAT		0x0008
>+#define OMAP_DMIC_POLAR1		0x0010
>+#define OMAP_DMIC_POLAR2		0x0020
>+#define OMAP_DMIC_POLAR3		0x0040
>+#define OMAP_DMIC_POLAR_MASK		0x0070
>+#define OMAP_DMIC_CLK_DIV_SHIFT		7
>+#define OMAP_DMIC_CLK_DIV_MASK		0x0380
>+#define	OMAP_DMIC_RESET			0x0400
>+
>+#define OMAP_DMIC_ENABLE_MASK		0x007
>+
>+#define OMAP_DMICOUTFORMAT_LJUST	(0 << 3)
>+#define OMAP_DMICOUTFORMAT_RJUST	(1 << 3)
>+
>+/*
>+ * DMIC_FIFO_CTRL bit fields
>+ */
>+
>+#define OMAP_DMIC_THRES_MAX		0xF
>+
>+

one blank line only. BTW, are these used anywwhere outside the dmic.c
driver ? If not, it's better to move the definitions there.

>+#endif
>diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
>new file mode 100644
>index 0000000..6ba05bd
>--- /dev/null
>+++ b/sound/soc/omap/omap-dmic.c
>@@ -0,0 +1,596 @@
>+/*
>+ * omap-dmic.c  --  OMAP ASoC DMIC DAI driver
>+ *
>+ * Copyright (C) 2010 Texas Instruments
>+ *
>+ * Author: Liam Girdwood <lrg@slimlogic.co.uk>
>+ *	   David Lambert <dlambert@ti.com>
>+ *	   Misael Lopez Cruz <misael.lopez@ti.com>
>+ *
>+ * This program is free software; you can redistribute it and/or
>+ * modify it under the terms of the GNU General Public License
>+ * version 2 as published by the Free Software Foundation.
>+ *
>+ * This program is distributed in the hope that it will be useful, but
>+ * WITHOUT ANY WARRANTY; without even the implied warranty of
>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>+ * General Public License for more details.
>+ *
>+ * You should have received a copy of the GNU General Public License
>+ * along with this program; if not, write to the Free Software
>+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>+ * 02110-1301 USA
>+ *
>+ */
>+
>+#undef DEBUG
>+
>+#include <linux/init.h>
>+#include <linux/module.h>
>+#include <linux/platform_device.h>
>+#include <linux/wait.h>
>+#include <linux/interrupt.h>
>+#include <linux/err.h>
>+#include <linux/clk.h>
>+#include <linux/delay.h>
>+#include <linux/io.h>
>+#include <linux/irq.h>
>+#include <linux/slab.h>
>+#include <linux/pm_runtime.h>
>+
>+#include <plat/control.h>
>+#include <plat/dma.h>
>+#include <plat/dmic.h>
>+#include <plat/omap_hwmod.h>

I'm not sure drivers should be including these (besides dmic.h which you
added). plat/control.h doesn't even exist anymore and hwmod is supposed
to live under mach-omap*/ only.

>+#include <sound/core.h>
>+#include <sound/pcm.h>
>+#include <sound/pcm_params.h>
>+#include <sound/initval.h>
>+#include <sound/soc.h>
>+
>+#include "omap-dmic.h"
>+#include "omap-pcm.h"

These little guys here look rather small to deserve being split to
separate files. Also, it looks like they're only used by this driver
(??) so it's better to move the definitions to this C source file
instead.

>+static struct omap_dmic_link omap_dmic_link = {

const ?

>+	.irq_mask	= OMAP_DMIC_IRQ_EMPTY | OMAP_DMIC_IRQ_FULL,
>+	.threshold	= 2,
>+	.format		= OMAP_DMICOUTFORMAT_LJUST,
>+	.polar		= OMAP_DMIC_POLAR1 | OMAP_DMIC_POLAR2
>+				| OMAP_DMIC_POLAR3,
>+};
>+
>+/*
>+ * Stream DMA parameters
>+ */
>+static struct omap_pcm_dma_data omap_dmic_dai_dma_params = {

const ?

>+	.name		= "DMIC capture",
>+	.data_type	= OMAP_DMA_DATA_TYPE_S32,
>+	.sync_mode	= OMAP_DMA_SYNC_PACKET,
>+	.packet_size	= 2,
>+	.port_addr	= OMAP44XX_DMIC_L3_BASE + OMAP_DMIC_DATA,
>+};
>+
>+

one blank line only.

>+#ifdef DEBUG
>+static void omap_dmic_reg_dump(struct omap_dmic *dmic)
>+{
>+	dev_dbg(dmic->dev, "***********************\n");
>+	dev_dbg(dmic->dev, "OMAP_DMIC_IRQSTATUS_RAW:  0x%04x\n",
>+		omap_dmic_read(dmic, OMAP_DMIC_IRQSTATUS_RAW));
>+	dev_dbg(dmic->dev, "OMAP_DMIC_IRQSTATUS:  0x%04x\n",
>+		omap_dmic_read(dmic, OMAP_DMIC_IRQSTATUS));
>+	dev_dbg(dmic->dev, "OMAP_DMIC_IRQENABLE_SET:  0x%04x\n",
>+		omap_dmic_read(dmic, OMAP_DMIC_IRQENABLE_SET));
>+	dev_dbg(dmic->dev, "OMAP_DMIC_IRQENABLE_CLR:  0x%04x\n",
>+		omap_dmic_read(dmic, OMAP_DMIC_IRQENABLE_CLR));
>+	dev_dbg(dmic->dev, "OMAP_DMIC_IRQWAKE_EN:  0x%04x\n",
>+		omap_dmic_read(dmic, OMAP_DMIC_IRQWAKE_EN));
>+	dev_dbg(dmic->dev, "OMAP_DMIC_DMAENABLE_SET:  0x%04x\n",
>+		omap_dmic_read(dmic, OMAP_DMIC_DMAENABLE_SET));
>+	dev_dbg(dmic->dev, "OMAP_DMIC_DMAENABLE_CLR:  0x%04x\n",
>+		omap_dmic_read(dmic, OMAP_DMIC_DMAENABLE_CLR));
>+	dev_dbg(dmic->dev, "OMAP_DMIC_DMAWAKEEN:  0x%04x\n",
>+		omap_dmic_read(dmic, OMAP_DMIC_DMAWAKEEN));
>+	dev_dbg(dmic->dev, "OMAP_DMIC_CTRL:  0x%04x\n",
>+		omap_dmic_read(dmic, OMAP_DMIC_CTRL));
>+	dev_dbg(dmic->dev, "OMAP_DMIC_DATA:  0x%04x\n",
>+		omap_dmic_read(dmic, OMAP_DMIC_DATA));
>+	dev_dbg(dmic->dev, "OMAP_DMIC_FIFO_CTRL:  0x%04x\n",
>+		omap_dmic_read(dmic, OMAP_DMIC_FIFO_CTRL));
>+	dev_dbg(dmic->dev, "OMAP_DMIC_FIFO_DMIC1R_DATA:  0x%08x\n",
>+		omap_dmic_read(dmic, OMAP_DMIC_FIFO_DMIC1R_DATA));
>+	dev_dbg(dmic->dev, "OMAP_DMIC_FIFO_DMIC1L_DATA:  0x%08x\n",
>+		omap_dmic_read(dmic, OMAP_DMIC_FIFO_DMIC1L_DATA));
>+	dev_dbg(dmic->dev, "OMAP_DMIC_FIFO_DMIC2R_DATA:  0x%08x\n",
>+		omap_dmic_read(dmic, OMAP_DMIC_FIFO_DMIC2R_DATA));
>+	dev_dbg(dmic->dev, "OMAP_DMIC_FIFO_DMIC2L_DATA:  0x%08x\n",
>+		omap_dmic_read(dmic, OMAP_DMIC_FIFO_DMIC2L_DATA));
>+	dev_dbg(dmic->dev, "OMAP_DMIC_FIFO_DMIC3R_DATA:  0x%08x\n",
>+		omap_dmic_read(dmic, OMAP_DMIC_FIFO_DMIC3R_DATA));
>+	dev_dbg(dmic->dev, "OMAP_DMIC_FIFO_DMIC3L_DATA:  0x%08x\n",
>+		omap_dmic_read(dmic, OMAP_DMIC_FIFO_DMIC3L_DATA));
>+	dev_dbg(dmic->dev, "***********************\n");
>+}
>+#else
>+static void omap_dmic_reg_dump(struct omap_dmic *dmic) {}
>+#endif

Would be better to make a debugfs layer ??

>+static irqreturn_t omap_dmic_irq_handler(int irq, void *dev_id)
>+{
>+	struct omap_dmic *dmic = dev_id;
>+	u32 irq_status;
>+
>+	irq_status = omap_dmic_read(dmic, OMAP_DMIC_IRQSTATUS);
>+
>+	/* Acknowledge irq event */
>+	omap_dmic_write(dmic, OMAP_DMIC_IRQSTATUS, irq_status);
>+	if (irq_status & OMAP_DMIC_IRQ_FULL)
>+		dev_dbg(dmic->dev, "DMIC FIFO error %x\n", irq_status);
>+
>+	if (irq_status & OMAP_DMIC_IRQ_EMPTY)
>+		dev_dbg(dmic->dev, "DMIC FIFO error %x\n", irq_status);
>+
>+	if (irq_status & OMAP_DMIC_IRQ)
>+		dev_dbg(dmic->dev, "DMIC write request\n");

no locking needed ??

>+static int omap_dmic_dai_startup(struct snd_pcm_substream *substream,
>+				  struct snd_soc_dai *dai)
>+{
>+	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
>+
>+	if (!dmic->active++)
>+		pm_runtime_get_sync(dmic->dev);
>+
>+	return 0;
>+}
>+
>+static void omap_dmic_dai_shutdown(struct snd_pcm_substream *substream,
>+				    struct snd_soc_dai *dai)
>+{
>+	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
>+
>+	if (!--dmic->active)
>+		pm_runtime_put_sync(dmic->dev);

I could be wrong but I believe pm_runtime implementation on OMAP has
its own refcounting, so you could drop the need for dmic->active.

>+static struct snd_soc_dai_ops omap_dmic_dai_ops = {

should this be const ?

>+static struct snd_soc_dai_driver omap_dmic_dai = {

this too ??

>+static __devinit int asoc_dmic_probe(struct platform_device *pdev)
>+{
>+	struct omap_dmic *dmic;
>+	struct resource *res;
>+	int ret;
>+
>+	dmic = kzalloc(sizeof(struct omap_dmic), GFP_KERNEL);
>+	if (!dmic)
>+		return -ENOMEM;
>+
>+	platform_set_drvdata(pdev, dmic);
>+	dmic->dev = &pdev->dev;
>+	dmic->link = &omap_dmic_link;
>+	dmic->sysclk = OMAP_DMIC_SYSCLK_SYNC_MUX_CLKS;
>+
>+	spin_lock_init(&dmic->lock);
>+
>+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>+	if (!res) {
>+		dev_err(dmic->dev, "invalid memory resource\n");
>+		ret = -ENODEV;
>+		goto err_res;
>+	}
>+
>+	dmic->io_base = ioremap(res->start, resource_size(res));
>+	if (!dmic->io_base) {
>+		ret = -ENOMEM;
>+		goto err_res;
>+	}
>+
>+	dmic->irq = platform_get_irq(pdev, 0);
>+	if (dmic->irq < 0) {
>+		ret = dmic->irq;
>+		goto err_irq;
>+	}
>+
>+	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
>+	if (!res) {
>+		dev_err(dmic->dev, "invalid dma resource\n");
>+		ret = -ENODEV;
>+		goto err_irq;
>+	}
>+	omap_dmic_dai_dma_params.dma_req = res->start;
>+
>+	pm_runtime_enable(dmic->dev);
>+
>+	/* Disable lines while request is ongoing */
>+	omap_dmic_write(dmic, OMAP_DMIC_CTRL, 0x00);
>+
>+	ret = request_threaded_irq(dmic->irq, NULL, omap_dmic_irq_handler,
>+				   IRQF_ONESHOT, "DMIC", (void *)dmic);

Does this need to be threaded ? Doesn't look like. Also, you don't need
the (void *) cast.

>+static int __devexit asoc_dmic_remove(struct platform_device *pdev)
>+{
>+	struct omap_dmic *dmic = platform_get_drvdata(pdev);
>+
>+	snd_soc_unregister_dai(&pdev->dev);
>+	free_irq(dmic->irq, dmic);
>+	iounmap(dmic->io_base);
>+	kfree(dmic);

pm_runtime_disable() ??

-- 
balbi
