From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/3] ASoC: omap-mcpdm: Replace legacy driver
Date: Thu, 7 Jul 2011 15:27:50 +0300
Message-ID: <1310041672-18634-2-git-send-email-peter.ujfalusi@ti.com>
References: <1310041672-18634-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35705 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755698Ab1GGM2I (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jul 2011 08:28:08 -0400
In-Reply-To: <1310041672-18634-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Sebastien Guiriec <s-guiriec@ti.com>, Benoit Coussoni <b-cousson@ti.com>

From: Misael Lopez Cruz <misael.lopez@ti.com>

The current McPDM driver design is not suitable to support both
the ABE and Legacy DMA operating modes. Therefore remove most
of the old driver (and mcpdm.c) and replace it with a re-designed
driver to support both Legacy and ABE modes of operation.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Liam Girdwood <lrg@ti.com>
Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/Makefile     |    2 +-
 sound/soc/omap/mcpdm.c      |  470 ------------------------
 sound/soc/omap/mcpdm.h      |  153 --------
 sound/soc/omap/omap-mcpdm.c |  828 +++++++++++++++++++++++++++++--------------
 sound/soc/omap/omap-mcpdm.h |  109 ++++++
 sound/soc/omap/sdp4430.c    |    4 +-
 6 files changed, 668 insertions(+), 898 deletions(-)
 delete mode 100644 sound/soc/omap/mcpdm.c
 delete mode 100644 sound/soc/omap/mcpdm.h
 rewrite sound/soc/omap/omap-mcpdm.c (42%)
 create mode 100644 sound/soc/omap/omap-mcpdm.h

diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 59e2c8d..052fd75 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -1,7 +1,7 @@
 # OMAP Platform Support
 snd-soc-omap-objs := omap-pcm.o
 snd-soc-omap-mcbsp-objs := omap-mcbsp.o
-snd-soc-omap-mcpdm-objs := omap-mcpdm.o mcpdm.o
+snd-soc-omap-mcpdm-objs := omap-mcpdm.o
 snd-soc-omap-hdmi-objs := omap-hdmi.o
 
 obj-$(CONFIG_SND_OMAP_SOC) += snd-soc-omap.o
diff --git a/sound/soc/omap/mcpdm.c b/sound/soc/omap/mcpdm.c
deleted file mode 100644
index 928f037..0000000
--- a/sound/soc/omap/mcpdm.c
+++ /dev/null
@@ -1,470 +0,0 @@
-/*
- * mcpdm.c  --	McPDM interface driver
- *
- * Author: Jorge Eduardo Candelaria <x0107209@ti.com>
- * Copyright (C) 2009 - Texas Instruments, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/device.h>
-#include <linux/platform_device.h>
-#include <linux/wait.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/delay.h>
-#include <linux/io.h>
-#include <linux/irq.h>
-
-#include "mcpdm.h"
-
-static struct omap_mcpdm *mcpdm;
-
-static inline void omap_mcpdm_write(u16 reg, u32 val)
-{
-	__raw_writel(val, mcpdm->io_base + reg);
-}
-
-static inline int omap_mcpdm_read(u16 reg)
-{
-	return __raw_readl(mcpdm->io_base + reg);
-}
-
-static void omap_mcpdm_reg_dump(void)
-{
-	dev_dbg(mcpdm->dev, "***********************\n");
-	dev_dbg(mcpdm->dev, "IRQSTATUS_RAW:  0x%04x\n",
-			omap_mcpdm_read(MCPDM_IRQSTATUS_RAW));
-	dev_dbg(mcpdm->dev, "IRQSTATUS:	0x%04x\n",
-			omap_mcpdm_read(MCPDM_IRQSTATUS));
-	dev_dbg(mcpdm->dev, "IRQENABLE_SET:  0x%04x\n",
-			omap_mcpdm_read(MCPDM_IRQENABLE_SET));
-	dev_dbg(mcpdm->dev, "IRQENABLE_CLR:  0x%04x\n",
-			omap_mcpdm_read(MCPDM_IRQENABLE_CLR));
-	dev_dbg(mcpdm->dev, "IRQWAKE_EN: 0x%04x\n",
-			omap_mcpdm_read(MCPDM_IRQWAKE_EN));
-	dev_dbg(mcpdm->dev, "DMAENABLE_SET: 0x%04x\n",
-			omap_mcpdm_read(MCPDM_DMAENABLE_SET));
-	dev_dbg(mcpdm->dev, "DMAENABLE_CLR:  0x%04x\n",
-			omap_mcpdm_read(MCPDM_DMAENABLE_CLR));
-	dev_dbg(mcpdm->dev, "DMAWAKEEN:	0x%04x\n",
-			omap_mcpdm_read(MCPDM_DMAWAKEEN));
-	dev_dbg(mcpdm->dev, "CTRL:	0x%04x\n",
-			omap_mcpdm_read(MCPDM_CTRL));
-	dev_dbg(mcpdm->dev, "DN_DATA:  0x%04x\n",
-			omap_mcpdm_read(MCPDM_DN_DATA));
-	dev_dbg(mcpdm->dev, "UP_DATA: 0x%04x\n",
-			omap_mcpdm_read(MCPDM_UP_DATA));
-	dev_dbg(mcpdm->dev, "FIFO_CTRL_DN: 0x%04x\n",
-			omap_mcpdm_read(MCPDM_FIFO_CTRL_DN));
-	dev_dbg(mcpdm->dev, "FIFO_CTRL_UP:  0x%04x\n",
-			omap_mcpdm_read(MCPDM_FIFO_CTRL_UP));
-	dev_dbg(mcpdm->dev, "DN_OFFSET:	0x%04x\n",
-			omap_mcpdm_read(MCPDM_DN_OFFSET));
-	dev_dbg(mcpdm->dev, "***********************\n");
-}
-
-/*
- * Takes the McPDM module in and out of reset state.
- * Uplink and downlink can be reset individually.
- */
-static void omap_mcpdm_reset_capture(int reset)
-{
-	int ctrl = omap_mcpdm_read(MCPDM_CTRL);
-
-	if (reset)
-		ctrl |= SW_UP_RST;
-	else
-		ctrl &= ~SW_UP_RST;
-
-	omap_mcpdm_write(MCPDM_CTRL, ctrl);
-}
-
-static void omap_mcpdm_reset_playback(int reset)
-{
-	int ctrl = omap_mcpdm_read(MCPDM_CTRL);
-
-	if (reset)
-		ctrl |= SW_DN_RST;
-	else
-		ctrl &= ~SW_DN_RST;
-
-	omap_mcpdm_write(MCPDM_CTRL, ctrl);
-}
-
-/*
- * Enables the transfer through the PDM interface to/from the Phoenix
- * codec by enabling the corresponding UP or DN channels.
- */
-void omap_mcpdm_start(int stream)
-{
-	int ctrl = omap_mcpdm_read(MCPDM_CTRL);
-
-	if (stream)
-		ctrl |= mcpdm->up_channels;
-	else
-		ctrl |= mcpdm->dn_channels;
-
-	omap_mcpdm_write(MCPDM_CTRL, ctrl);
-}
-
-/*
- * Disables the transfer through the PDM interface to/from the Phoenix
- * codec by disabling the corresponding UP or DN channels.
- */
-void omap_mcpdm_stop(int stream)
-{
-	int ctrl = omap_mcpdm_read(MCPDM_CTRL);
-
-	if (stream)
-		ctrl &= ~mcpdm->up_channels;
-	else
-		ctrl &= ~mcpdm->dn_channels;
-
-	omap_mcpdm_write(MCPDM_CTRL, ctrl);
-}
-
-/*
- * Configures McPDM uplink for audio recording.
- * This function should be called before omap_mcpdm_start.
- */
-int omap_mcpdm_capture_open(struct omap_mcpdm_link *uplink)
-{
-	int irq_mask = 0;
-	int ctrl;
-
-	if (!uplink)
-		return -EINVAL;
-
-	mcpdm->uplink = uplink;
-
-	/* Enable irq request generation */
-	irq_mask |= uplink->irq_mask & MCPDM_UPLINK_IRQ_MASK;
-	omap_mcpdm_write(MCPDM_IRQENABLE_SET, irq_mask);
-
-	/* Configure uplink threshold */
-	if (uplink->threshold > UP_THRES_MAX)
-		uplink->threshold = UP_THRES_MAX;
-
-	omap_mcpdm_write(MCPDM_FIFO_CTRL_UP, uplink->threshold);
-
-	/* Configure DMA controller */
-	omap_mcpdm_write(MCPDM_DMAENABLE_SET, DMA_UP_ENABLE);
-
-	/* Set pdm out format */
-	ctrl = omap_mcpdm_read(MCPDM_CTRL);
-	ctrl &= ~PDMOUTFORMAT;
-	ctrl |= uplink->format & PDMOUTFORMAT;
-
-	/* Uplink channels */
-	mcpdm->up_channels = uplink->channels & (PDM_UP_MASK | PDM_STATUS_MASK);
-
-	omap_mcpdm_write(MCPDM_CTRL, ctrl);
-
-	return 0;
-}
-
-/*
- * Configures McPDM downlink for audio playback.
- * This function should be called before omap_mcpdm_start.
- */
-int omap_mcpdm_playback_open(struct omap_mcpdm_link *downlink)
-{
-	int irq_mask = 0;
-	int ctrl;
-
-	if (!downlink)
-		return -EINVAL;
-
-	mcpdm->downlink = downlink;
-
-	/* Enable irq request generation */
-	irq_mask |= downlink->irq_mask & MCPDM_DOWNLINK_IRQ_MASK;
-	omap_mcpdm_write(MCPDM_IRQENABLE_SET, irq_mask);
-
-	/* Configure uplink threshold */
-	if (downlink->threshold > DN_THRES_MAX)
-		downlink->threshold = DN_THRES_MAX;
-
-	omap_mcpdm_write(MCPDM_FIFO_CTRL_DN, downlink->threshold);
-
-	/* Enable DMA request generation */
-	omap_mcpdm_write(MCPDM_DMAENABLE_SET, DMA_DN_ENABLE);
-
-	/* Set pdm out format */
-	ctrl = omap_mcpdm_read(MCPDM_CTRL);
-	ctrl &= ~PDMOUTFORMAT;
-	ctrl |= downlink->format & PDMOUTFORMAT;
-
-	/* Downlink channels */
-	mcpdm->dn_channels = downlink->channels & (PDM_DN_MASK | PDM_CMD_MASK);
-
-	omap_mcpdm_write(MCPDM_CTRL, ctrl);
-
-	return 0;
-}
-
-/*
- * Cleans McPDM uplink configuration.
- * This function should be called when the stream is closed.
- */
-int omap_mcpdm_capture_close(struct omap_mcpdm_link *uplink)
-{
-	int irq_mask = 0;
-
-	if (!uplink)
-		return -EINVAL;
-
-	/* Disable irq request generation */
-	irq_mask |= uplink->irq_mask & MCPDM_UPLINK_IRQ_MASK;
-	omap_mcpdm_write(MCPDM_IRQENABLE_CLR, irq_mask);
-
-	/* Disable DMA request generation */
-	omap_mcpdm_write(MCPDM_DMAENABLE_CLR, DMA_UP_ENABLE);
-
-	/* Clear Downlink channels */
-	mcpdm->up_channels = 0;
-
-	mcpdm->uplink = NULL;
-
-	return 0;
-}
-
-/*
- * Cleans McPDM downlink configuration.
- * This function should be called when the stream is closed.
- */
-int omap_mcpdm_playback_close(struct omap_mcpdm_link *downlink)
-{
-	int irq_mask = 0;
-
-	if (!downlink)
-		return -EINVAL;
-
-	/* Disable irq request generation */
-	irq_mask |= downlink->irq_mask & MCPDM_DOWNLINK_IRQ_MASK;
-	omap_mcpdm_write(MCPDM_IRQENABLE_CLR, irq_mask);
-
-	/* Disable DMA request generation */
-	omap_mcpdm_write(MCPDM_DMAENABLE_CLR, DMA_DN_ENABLE);
-
-	/* clear Downlink channels */
-	mcpdm->dn_channels = 0;
-
-	mcpdm->downlink = NULL;
-
-	return 0;
-}
-
-static irqreturn_t omap_mcpdm_irq_handler(int irq, void *dev_id)
-{
-	struct omap_mcpdm *mcpdm_irq = dev_id;
-	int irq_status;
-
-	irq_status = omap_mcpdm_read(MCPDM_IRQSTATUS);
-
-	/* Acknowledge irq event */
-	omap_mcpdm_write(MCPDM_IRQSTATUS, irq_status);
-
-	if (irq & MCPDM_DN_IRQ_FULL) {
-		dev_err(mcpdm_irq->dev, "DN FIFO error %x\n", irq_status);
-		omap_mcpdm_reset_playback(1);
-		omap_mcpdm_playback_open(mcpdm_irq->downlink);
-		omap_mcpdm_reset_playback(0);
-	}
-
-	if (irq & MCPDM_DN_IRQ_EMPTY) {
-		dev_err(mcpdm_irq->dev, "DN FIFO error %x\n", irq_status);
-		omap_mcpdm_reset_playback(1);
-		omap_mcpdm_playback_open(mcpdm_irq->downlink);
-		omap_mcpdm_reset_playback(0);
-	}
-
-	if (irq & MCPDM_DN_IRQ) {
-		dev_dbg(mcpdm_irq->dev, "DN write request\n");
-	}
-
-	if (irq & MCPDM_UP_IRQ_FULL) {
-		dev_err(mcpdm_irq->dev, "UP FIFO error %x\n", irq_status);
-		omap_mcpdm_reset_capture(1);
-		omap_mcpdm_capture_open(mcpdm_irq->uplink);
-		omap_mcpdm_reset_capture(0);
-	}
-
-	if (irq & MCPDM_UP_IRQ_EMPTY) {
-		dev_err(mcpdm_irq->dev, "UP FIFO error %x\n", irq_status);
-		omap_mcpdm_reset_capture(1);
-		omap_mcpdm_capture_open(mcpdm_irq->uplink);
-		omap_mcpdm_reset_capture(0);
-	}
-
-	if (irq & MCPDM_UP_IRQ) {
-		dev_dbg(mcpdm_irq->dev, "UP write request\n");
-	}
-
-	return IRQ_HANDLED;
-}
-
-int omap_mcpdm_request(void)
-{
-	int ret;
-
-	clk_enable(mcpdm->clk);
-
-	spin_lock(&mcpdm->lock);
-
-	if (!mcpdm->free) {
-		dev_err(mcpdm->dev, "McPDM interface is in use\n");
-		spin_unlock(&mcpdm->lock);
-		ret = -EBUSY;
-		goto err;
-	}
-	mcpdm->free = 0;
-
-	spin_unlock(&mcpdm->lock);
-
-	/* Disable lines while request is ongoing */
-	omap_mcpdm_write(MCPDM_CTRL, 0x00);
-
-	ret = request_irq(mcpdm->irq, omap_mcpdm_irq_handler,
-				0, "McPDM", (void *)mcpdm);
-	if (ret) {
-		dev_err(mcpdm->dev, "Request for McPDM IRQ failed\n");
-		goto err;
-	}
-
-	return 0;
-
-err:
-	clk_disable(mcpdm->clk);
-	return ret;
-}
-
-void omap_mcpdm_free(void)
-{
-	spin_lock(&mcpdm->lock);
-	if (mcpdm->free) {
-		dev_err(mcpdm->dev, "McPDM interface is already free\n");
-		spin_unlock(&mcpdm->lock);
-		return;
-	}
-	mcpdm->free = 1;
-	spin_unlock(&mcpdm->lock);
-
-	clk_disable(mcpdm->clk);
-
-	free_irq(mcpdm->irq, (void *)mcpdm);
-}
-
-/* Enable/disable DC offset cancelation for the analog
- * headset path (PDM channels 1 and 2).
- */
-int omap_mcpdm_set_offset(int offset1, int offset2)
-{
-	int offset;
-
-	if ((offset1 > DN_OFST_MAX) || (offset2 > DN_OFST_MAX))
-		return -EINVAL;
-
-	offset = (offset1 << DN_OFST_RX1) | (offset2 << DN_OFST_RX2);
-
-	/* offset cancellation for channel 1 */
-	if (offset1)
-		offset |= DN_OFST_RX1_EN;
-	else
-		offset &= ~DN_OFST_RX1_EN;
-
-	/* offset cancellation for channel 2 */
-	if (offset2)
-		offset |= DN_OFST_RX2_EN;
-	else
-		offset &= ~DN_OFST_RX2_EN;
-
-	omap_mcpdm_write(MCPDM_DN_OFFSET, offset);
-
-	return 0;
-}
-
-int __devinit omap_mcpdm_probe(struct platform_device *pdev)
-{
-	struct resource *res;
-	int ret = 0;
-
-	mcpdm = kzalloc(sizeof(struct omap_mcpdm), GFP_KERNEL);
-	if (!mcpdm) {
-		ret = -ENOMEM;
-		goto exit;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "no resource\n");
-		goto err_resource;
-	}
-
-	spin_lock_init(&mcpdm->lock);
-	mcpdm->free = 1;
-	mcpdm->io_base = ioremap(res->start, resource_size(res));
-	if (!mcpdm->io_base) {
-		ret = -ENOMEM;
-		goto err_resource;
-	}
-
-	mcpdm->irq = platform_get_irq(pdev, 0);
-
-	mcpdm->clk = clk_get(&pdev->dev, "pdm_ck");
-	if (IS_ERR(mcpdm->clk)) {
-		ret = PTR_ERR(mcpdm->clk);
-		dev_err(&pdev->dev, "unable to get pdm_ck: %d\n", ret);
-		goto err_clk;
-	}
-
-	mcpdm->dev = &pdev->dev;
-	platform_set_drvdata(pdev, mcpdm);
-
-	return 0;
-
-err_clk:
-	iounmap(mcpdm->io_base);
-err_resource:
-	kfree(mcpdm);
-exit:
-	return ret;
-}
-
-int __devexit omap_mcpdm_remove(struct platform_device *pdev)
-{
-	struct omap_mcpdm *mcpdm_ptr = platform_get_drvdata(pdev);
-
-	platform_set_drvdata(pdev, NULL);
-
-	clk_put(mcpdm_ptr->clk);
-
-	iounmap(mcpdm_ptr->io_base);
-
-	mcpdm_ptr->clk = NULL;
-	mcpdm_ptr->free = 0;
-	mcpdm_ptr->dev = NULL;
-
-	kfree(mcpdm_ptr);
-
-	return 0;
-}
-
diff --git a/sound/soc/omap/mcpdm.h b/sound/soc/omap/mcpdm.h
deleted file mode 100644
index df3e16f..0000000
--- a/sound/soc/omap/mcpdm.h
+++ /dev/null
@@ -1,153 +0,0 @@
-/*
- * mcpdm.h -- Defines for McPDM driver
- *
- * Author: Jorge Eduardo Candelaria <x0107209@ti.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-/* McPDM registers */
-
-#define MCPDM_REVISION         0x00
-#define MCPDM_SYSCONFIG                0x10
-#define MCPDM_IRQSTATUS_RAW    0x24
-#define MCPDM_IRQSTATUS                0x28
-#define MCPDM_IRQENABLE_SET    0x2C
-#define MCPDM_IRQENABLE_CLR    0x30
-#define MCPDM_IRQWAKE_EN       0x34
-#define MCPDM_DMAENABLE_SET    0x38
-#define MCPDM_DMAENABLE_CLR    0x3C
-#define MCPDM_DMAWAKEEN                0x40
-#define MCPDM_CTRL             0x44
-#define MCPDM_DN_DATA          0x48
-#define MCPDM_UP_DATA          0x4C
-#define MCPDM_FIFO_CTRL_DN     0x50
-#define MCPDM_FIFO_CTRL_UP     0x54
-#define MCPDM_DN_OFFSET                0x58
-
-/*
- * MCPDM_IRQ bit fields
- * IRQSTATUS_RAW, IRQSTATUS, IRQENABLE_SET, IRQENABLE_CLR
- */
-
-#define MCPDM_DN_IRQ                   (1 << 0)
-#define MCPDM_DN_IRQ_EMPTY             (1 << 1)
-#define MCPDM_DN_IRQ_ALMST_EMPTY       (1 << 2)
-#define MCPDM_DN_IRQ_FULL              (1 << 3)
-
-#define MCPDM_UP_IRQ                   (1 << 8)
-#define MCPDM_UP_IRQ_EMPTY             (1 << 9)
-#define MCPDM_UP_IRQ_ALMST_FULL                (1 << 10)
-#define MCPDM_UP_IRQ_FULL              (1 << 11)
-
-#define MCPDM_DOWNLINK_IRQ_MASK                0x00F
-#define MCPDM_UPLINK_IRQ_MASK          0xF00
-
-/*
- * MCPDM_DMAENABLE bit fields
- */
-
-#define DMA_DN_ENABLE          0x1
-#define DMA_UP_ENABLE          0x2
-
-/*
- * MCPDM_CTRL bit fields
- */
-
-#define PDM_UP1_EN             0x0001
-#define PDM_UP2_EN             0x0002
-#define PDM_UP3_EN             0x0004
-#define PDM_DN1_EN             0x0008
-#define PDM_DN2_EN             0x0010
-#define PDM_DN3_EN             0x0020
-#define PDM_DN4_EN             0x0040
-#define PDM_DN5_EN             0x0080
-#define PDMOUTFORMAT           0x0100
-#define CMD_INT                        0x0200
-#define STATUS_INT             0x0400
-#define SW_UP_RST              0x0800
-#define SW_DN_RST              0x1000
-#define PDM_UP_MASK            0x007
-#define PDM_DN_MASK            0x0F8
-#define PDM_CMD_MASK           0x200
-#define PDM_STATUS_MASK                0x400
-
-
-#define PDMOUTFORMAT_LJUST     (0 << 8)
-#define PDMOUTFORMAT_RJUST     (1 << 8)
-
-/*
- * MCPDM_FIFO_CTRL bit fields
- */
-
-#define UP_THRES_MAX           0xF
-#define DN_THRES_MAX           0xF
-
-/*
- * MCPDM_DN_OFFSET bit fields
- */
-
-#define DN_OFST_RX1_EN         0x0001
-#define DN_OFST_RX2_EN         0x0100
-
-#define DN_OFST_RX1            1
-#define DN_OFST_RX2            9
-#define DN_OFST_MAX            0x1F
-
-#define MCPDM_UPLINK           1
-#define MCPDM_DOWNLINK         2
-
-struct omap_mcpdm_link {
-       int irq_mask;
-       int threshold;
-       int format;
-       int channels;
-};
-
-struct omap_mcpdm_platform_data {
-       unsigned long phys_base;
-       u16 irq;
-};
-
-struct omap_mcpdm {
-       struct device *dev;
-       unsigned long phys_base;
-       void __iomem *io_base;
-       u8 free;
-       int irq;
-
-       spinlock_t lock;
-       struct omap_mcpdm_platform_data *pdata;
-       struct clk *clk;
-       struct omap_mcpdm_link *downlink;
-       struct omap_mcpdm_link *uplink;
-       struct completion irq_completion;
-
-       int dn_channels;
-       int up_channels;
-};
-
-extern void omap_mcpdm_start(int stream);
-extern void omap_mcpdm_stop(int stream);
-extern int omap_mcpdm_capture_open(struct omap_mcpdm_link *uplink);
-extern int omap_mcpdm_playback_open(struct omap_mcpdm_link *downlink);
-extern int omap_mcpdm_capture_close(struct omap_mcpdm_link *uplink);
-extern int omap_mcpdm_playback_close(struct omap_mcpdm_link *downlink);
-extern int omap_mcpdm_request(void);
-extern void omap_mcpdm_free(void);
-extern int omap_mcpdm_set_offset(int offset1, int offset2);
-int __devinit omap_mcpdm_probe(struct platform_device *pdev);
-int __devexit omap_mcpdm_remove(struct platform_device *pdev);
diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
dissimilarity index 42%
index bed09c2..5d3073f 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -1,272 +1,556 @@
-/*
- * omap-mcpdm.c  --  OMAP ALSA SoC DAI driver using McPDM port
- *
- * Copyright (C) 2009 Texas Instruments
- *
- * Author: Misael Lopez Cruz <x0052729@ti.com>
- * Contact: Jorge Eduardo Candelaria <x0107209@ti.com>
- *          Margarita Olaya <magi.olaya@ti.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/initval.h>
-#include <sound/soc.h>
-
-#include <plat/dma.h>
-#include <plat/mcbsp.h>
-#include "mcpdm.h"
-#include "omap-pcm.h"
-
-struct omap_mcpdm_data {
-	struct omap_mcpdm_link *links;
-	int active;
-};
-
-static struct omap_mcpdm_link omap_mcpdm_links[] = {
-	/* downlink */
-	{
-		.irq_mask = MCPDM_DN_IRQ_EMPTY | MCPDM_DN_IRQ_FULL,
-		.threshold = 1,
-		.format = PDMOUTFORMAT_LJUST,
-	},
-	/* uplink */
-	{
-		.irq_mask = MCPDM_UP_IRQ_EMPTY | MCPDM_UP_IRQ_FULL,
-		.threshold = 1,
-		.format = PDMOUTFORMAT_LJUST,
-	},
-};
-
-static struct omap_mcpdm_data mcpdm_data = {
-	.links = omap_mcpdm_links,
-	.active = 0,
-};
-
-/*
- * Stream DMA parameters
- */
-static struct omap_pcm_dma_data omap_mcpdm_dai_dma_params[] = {
-	{
-		.name = "Audio playback",
-		.dma_req = OMAP44XX_DMA_MCPDM_DL,
-		.data_type = OMAP_DMA_DATA_TYPE_S32,
-		.sync_mode = OMAP_DMA_SYNC_PACKET,
-		.packet_size = 16,
-		.port_addr = OMAP44XX_MCPDM_L3_BASE + MCPDM_DN_DATA,
-	},
-	{
-		.name = "Audio capture",
-		.dma_req = OMAP44XX_DMA_MCPDM_UP,
-		.data_type = OMAP_DMA_DATA_TYPE_S32,
-		.sync_mode = OMAP_DMA_SYNC_PACKET,
-		.packet_size = 16,
-		.port_addr = OMAP44XX_MCPDM_L3_BASE + MCPDM_UP_DATA,
-	},
-};
-
-static int omap_mcpdm_dai_startup(struct snd_pcm_substream *substream,
-				  struct snd_soc_dai *dai)
-{
-	int err = 0;
-
-	if (!dai->active)
-		err = omap_mcpdm_request();
-
-	return err;
-}
-
-static void omap_mcpdm_dai_shutdown(struct snd_pcm_substream *substream,
-				    struct snd_soc_dai *dai)
-{
-	if (!dai->active)
-		omap_mcpdm_free();
-}
-
-static int omap_mcpdm_dai_trigger(struct snd_pcm_substream *substream, int cmd,
-				  struct snd_soc_dai *dai)
-{
-	struct omap_mcpdm_data *mcpdm_priv = snd_soc_dai_get_drvdata(dai);
-	int stream = substream->stream;
-	int err = 0;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (!mcpdm_priv->active++)
-			omap_mcpdm_start(stream);
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		if (!--mcpdm_priv->active)
-			omap_mcpdm_stop(stream);
-		break;
-	default:
-		err = -EINVAL;
-	}
-
-	return err;
-}
-
-static int omap_mcpdm_dai_hw_params(struct snd_pcm_substream *substream,
-				    struct snd_pcm_hw_params *params,
-				    struct snd_soc_dai *dai)
-{
-	struct omap_mcpdm_data *mcpdm_priv = snd_soc_dai_get_drvdata(dai);
-	struct omap_mcpdm_link *mcpdm_links = mcpdm_priv->links;
-	int stream = substream->stream;
-	int channels, err, link_mask = 0;
-
-	snd_soc_dai_set_dma_data(dai, substream,
-				 &omap_mcpdm_dai_dma_params[stream]);
-
-	channels = params_channels(params);
-	switch (channels) {
-	case 4:
-		if (stream == SNDRV_PCM_STREAM_CAPTURE)
-			/* up to 2 channels for capture */
-			return -EINVAL;
-		link_mask |= 1 << 3;
-	case 3:
-		if (stream == SNDRV_PCM_STREAM_CAPTURE)
-			/* up to 2 channels for capture */
-			return -EINVAL;
-		link_mask |= 1 << 2;
-	case 2:
-		link_mask |= 1 << 1;
-	case 1:
-		link_mask |= 1 << 0;
-		break;
-	default:
-		/* unsupported number of channels */
-		return -EINVAL;
-	}
-
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		mcpdm_links[stream].channels = link_mask << 3;
-		err = omap_mcpdm_playback_open(&mcpdm_links[stream]);
-	} else {
-		mcpdm_links[stream].channels = link_mask << 0;
-		err = omap_mcpdm_capture_open(&mcpdm_links[stream]);
-	}
-
-	return err;
-}
-
-static int omap_mcpdm_dai_hw_free(struct snd_pcm_substream *substream,
-				  struct snd_soc_dai *dai)
-{
-	struct omap_mcpdm_data *mcpdm_priv = snd_soc_dai_get_drvdata(dai);
-	struct omap_mcpdm_link *mcpdm_links = mcpdm_priv->links;
-	int stream = substream->stream;
-	int err;
-
-	if (substream->stream ==  SNDRV_PCM_STREAM_PLAYBACK)
-		err = omap_mcpdm_playback_close(&mcpdm_links[stream]);
-	else
-		err = omap_mcpdm_capture_close(&mcpdm_links[stream]);
-
-	return err;
-}
-
-static struct snd_soc_dai_ops omap_mcpdm_dai_ops = {
-	.startup	= omap_mcpdm_dai_startup,
-	.shutdown	= omap_mcpdm_dai_shutdown,
-	.trigger	= omap_mcpdm_dai_trigger,
-	.hw_params	= omap_mcpdm_dai_hw_params,
-	.hw_free	= omap_mcpdm_dai_hw_free,
-};
-
-#define OMAP_MCPDM_RATES	(SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
-#define OMAP_MCPDM_FORMATS	(SNDRV_PCM_FMTBIT_S32_LE)
-
-static int omap_mcpdm_dai_probe(struct snd_soc_dai *dai)
-{
-	snd_soc_dai_set_drvdata(dai, &mcpdm_data);
-	return 0;
-}
-
-static struct snd_soc_dai_driver omap_mcpdm_dai = {
-	.probe = omap_mcpdm_dai_probe,
-	.playback = {
-		.channels_min = 1,
-		.channels_max = 4,
-		.rates = OMAP_MCPDM_RATES,
-		.formats = OMAP_MCPDM_FORMATS,
-	},
-	.capture = {
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = OMAP_MCPDM_RATES,
-		.formats = OMAP_MCPDM_FORMATS,
-	},
-	.ops = &omap_mcpdm_dai_ops,
-};
-
-static __devinit int asoc_mcpdm_probe(struct platform_device *pdev)
-{
-	int ret;
-
-	ret = omap_mcpdm_probe(pdev);
-	if (ret < 0)
-		return ret;
-	ret = snd_soc_register_dai(&pdev->dev, &omap_mcpdm_dai);
-	if (ret < 0)
-		omap_mcpdm_remove(pdev);
-	return ret;
-}
-
-static int __devexit asoc_mcpdm_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_dai(&pdev->dev);
-	omap_mcpdm_remove(pdev);
-	return 0;
-}
-
-static struct platform_driver asoc_mcpdm_driver = {
-	.driver = {
-			.name = "omap-mcpdm-dai",
-			.owner = THIS_MODULE,
-	},
-
-	.probe = asoc_mcpdm_probe,
-	.remove = __devexit_p(asoc_mcpdm_remove),
-};
-
-static int __init snd_omap_mcpdm_init(void)
-{
-	return platform_driver_register(&asoc_mcpdm_driver);
-}
-module_init(snd_omap_mcpdm_init);
-
-static void __exit snd_omap_mcpdm_exit(void)
-{
-	platform_driver_unregister(&asoc_mcpdm_driver);
-}
-module_exit(snd_omap_mcpdm_exit);
-
-MODULE_AUTHOR("Misael Lopez Cruz <x0052729@ti.com>");
-MODULE_DESCRIPTION("OMAP PDM SoC Interface");
-MODULE_LICENSE("GPL");
+/*
+ * omap-mcpdm.c  --  OMAP ALSA SoC DAI driver using McPDM port
+ *
+ * Copyright (C) 2009 - 2011 Texas Instruments
+ *
+ * Author: Misael Lopez Cruz <misael.lopez@ti.com>
+ * Contact: Jorge Eduardo Candelaria <x0107209@ti.com>
+ *          Margarita Olaya <magi.olaya@ti.com>
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
+#include <linux/wait.h>
+#include <linux/interrupt.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/slab.h>
+#include <linux/pm_runtime.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include <plat/dma.h>
+#include <plat/omap_hwmod.h>
+#include "omap-mcpdm.h"
+#include "omap-pcm.h"
+
+struct omap_mcpdm {
+	struct device *dev;
+	unsigned long phys_base;
+	void __iomem *io_base;
+	int irq;
+	struct delayed_work delayed_work;
+
+	struct mutex mutex;
+	struct completion irq_completion;
+
+	/* channel data */
+	u32 dn_channels;
+	u32 up_channels;
+	int active;
+};
+
+/*
+ * Stream DMA parameters
+ */
+static struct omap_pcm_dma_data omap_mcpdm_dai_dma_params[] = {
+	{
+		.name = "Audio playback",
+		.dma_req = OMAP44XX_DMA_MCPDM_DL,
+		.data_type = OMAP_DMA_DATA_TYPE_S32,
+		.sync_mode = OMAP_DMA_SYNC_PACKET,
+		.packet_size = 16,
+		.port_addr = OMAP44XX_MCPDM_L3_BASE + MCPDM_REG_DN_DATA,
+	},
+	{
+		.name = "Audio capture",
+		.dma_req = OMAP44XX_DMA_MCPDM_UP,
+		.data_type = OMAP_DMA_DATA_TYPE_S32,
+		.sync_mode = OMAP_DMA_SYNC_PACKET,
+		.packet_size = 16,
+		.port_addr = OMAP44XX_MCPDM_L3_BASE + MCPDM_REG_UP_DATA,
+	},
+};
+
+static inline void omap_mcpdm_write(struct omap_mcpdm *mcpdm,
+		u16 reg, u32 val)
+{
+	__raw_writel(val, mcpdm->io_base + reg);
+}
+
+static inline int omap_mcpdm_read(struct omap_mcpdm *mcpdm, u16 reg)
+{
+	return __raw_readl(mcpdm->io_base + reg);
+}
+
+#ifdef DEBUG
+static void omap_mcpdm_reg_dump(struct omap_mcpdm *mcpdm)
+{
+	dev_dbg(mcpdm->dev, "***********************\n");
+	dev_dbg(mcpdm->dev, "IRQSTATUS_RAW:  0x%04x\n",
+			omap_mcpdm_read(mcpdm, MCPDM_REG_IRQSTATUS_RAW));
+	dev_dbg(mcpdm->dev, "IRQSTATUS:  0x%04x\n",
+			omap_mcpdm_read(mcpdm, MCPDM_REG_IRQSTATUS));
+	dev_dbg(mcpdm->dev, "IRQENABLE_SET:  0x%04x\n",
+			omap_mcpdm_read(mcpdm, MCPDM_REG_IRQENABLE_SET));
+	dev_dbg(mcpdm->dev, "IRQENABLE_CLR:  0x%04x\n",
+			omap_mcpdm_read(mcpdm, MCPDM_REG_IRQENABLE_CLR));
+	dev_dbg(mcpdm->dev, "IRQWAKE_EN: 0x%04x\n",
+			omap_mcpdm_read(mcpdm, MCPDM_REG_IRQWAKE_EN));
+	dev_dbg(mcpdm->dev, "DMAENABLE_SET: 0x%04x\n",
+			omap_mcpdm_read(mcpdm, MCPDM_REG_DMAENABLE_SET));
+	dev_dbg(mcpdm->dev, "DMAENABLE_CLR:  0x%04x\n",
+			omap_mcpdm_read(mcpdm, MCPDM_REG_DMAENABLE_CLR));
+	dev_dbg(mcpdm->dev, "DMAWAKEEN:  0x%04x\n",
+			omap_mcpdm_read(mcpdm, MCPDM_REG_DMAWAKEEN));
+	dev_dbg(mcpdm->dev, "CTRL:  0x%04x\n",
+			omap_mcpdm_read(mcpdm, MCPDM_REG_CTRL));
+	dev_dbg(mcpdm->dev, "DN_DATA:  0x%04x\n",
+			omap_mcpdm_read(mcpdm, MCPDM_REG_DN_DATA));
+	dev_dbg(mcpdm->dev, "UP_DATA: 0x%04x\n",
+			omap_mcpdm_read(mcpdm, MCPDM_REG_UP_DATA));
+	dev_dbg(mcpdm->dev, "FIFO_CTRL_DN: 0x%04x\n",
+			omap_mcpdm_read(mcpdm, MCPDM_REG_FIFO_CTRL_DN));
+	dev_dbg(mcpdm->dev, "FIFO_CTRL_UP:  0x%04x\n",
+			omap_mcpdm_read(mcpdm, MCPDM_REG_FIFO_CTRL_UP));
+	dev_dbg(mcpdm->dev, "***********************\n");
+}
+#else
+static void omap_mcpdm_reg_dump(struct omap_mcpdm *mcpdm) {}
+#endif
+
+/*
+ * Enables the transfer through the PDM interface to/from the Phoenix
+ * codec by enabling the corresponding UP or DN channels.
+ */
+static void omap_mcpdm_start(struct omap_mcpdm *mcpdm)
+{
+	u32 ctrl = omap_mcpdm_read(mcpdm, MCPDM_REG_CTRL);
+
+	ctrl |= (MCPDM_SW_DN_RST | MCPDM_SW_UP_RST);
+	omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, ctrl);
+
+	ctrl |= mcpdm->dn_channels | mcpdm->up_channels;
+	omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, ctrl);
+
+	ctrl &= ~(MCPDM_SW_DN_RST | MCPDM_SW_UP_RST);
+	omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, ctrl);
+}
+
+/*
+ * Disables the transfer through the PDM interface to/from the Phoenix
+ * codec by disabling the corresponding UP or DN channels.
+ */
+static void omap_mcpdm_stop(struct omap_mcpdm *mcpdm)
+{
+	u32 ctrl = omap_mcpdm_read(mcpdm, MCPDM_REG_CTRL);
+
+	ctrl |= (MCPDM_SW_DN_RST | MCPDM_SW_UP_RST);
+	omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, ctrl);
+
+	ctrl &= ~(mcpdm->dn_channels | mcpdm->up_channels);
+	omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, ctrl);
+
+	ctrl &= ~(MCPDM_SW_DN_RST | MCPDM_SW_UP_RST);
+	omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, ctrl);
+
+}
+
+/*
+ * Is the physical McPDM interface active.
+ */
+static inline int omap_mcpdm_active(struct omap_mcpdm *mcpdm)
+{
+	return omap_mcpdm_read(mcpdm, MCPDM_REG_CTRL) &
+					(MCPDM_PDM_DN_MASK | MCPDM_PDM_UP_MASK);
+}
+
+/*
+ * Configures McPDM uplink or downlink for audio.
+ * This function should be called before omap_mcpdm_start.
+ */
+static void omap_mcpdm_open_stream(struct omap_mcpdm *mcpdm, int stream)
+{
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		/* Enable irq request generation */
+		omap_mcpdm_write(mcpdm, MCPDM_REG_IRQENABLE_SET,
+				MCPDM_DN_IRQ_EMPTY | MCPDM_DN_IRQ_FULL);
+
+		/* Configure uplink threshold */
+		omap_mcpdm_write(mcpdm, MCPDM_REG_FIFO_CTRL_DN, 2);
+
+		/* Enable DMA request generation */
+		omap_mcpdm_write(mcpdm, MCPDM_REG_DMAENABLE_SET,
+				 MCPDM_DMA_DN_ENABLE);
+	} else {
+		/* Enable irq request generation */
+		omap_mcpdm_write(mcpdm, MCPDM_REG_IRQENABLE_SET,
+				MCPDM_UP_IRQ_EMPTY | MCPDM_UP_IRQ_FULL);
+
+		/* Configure uplink threshold */
+		omap_mcpdm_write(mcpdm, MCPDM_REG_FIFO_CTRL_UP, 2);
+
+		/* Configure DMA controller */
+		omap_mcpdm_write(mcpdm, MCPDM_REG_DMAENABLE_SET,
+				 MCPDM_DMA_UP_ENABLE);
+	}
+}
+
+/*
+ * Cleans McPDM uplink and downlink configuration.
+ * This function should be called when the stream is closed.
+ */
+static void omap_mcpdm_close_streams(struct omap_mcpdm *mcpdm)
+{
+	/* Disable irq request generation for downlink */
+	omap_mcpdm_write(mcpdm, MCPDM_REG_IRQENABLE_CLR,
+			MCPDM_DN_IRQ_EMPTY | MCPDM_DN_IRQ_FULL);
+
+	/* Disable DMA request generation for downlink */
+	omap_mcpdm_write(mcpdm, MCPDM_REG_DMAENABLE_CLR, MCPDM_DMA_DN_ENABLE);
+
+	/* Disable irq request generation for uplink */
+	omap_mcpdm_write(mcpdm, MCPDM_REG_IRQENABLE_CLR,
+			MCPDM_UP_IRQ_EMPTY | MCPDM_UP_IRQ_FULL);
+
+	/* Disable DMA request generation for uplink */
+	omap_mcpdm_write(mcpdm, MCPDM_REG_DMAENABLE_CLR, MCPDM_DMA_UP_ENABLE);
+}
+
+static irqreturn_t omap_mcpdm_irq_handler(int irq, void *dev_id)
+{
+	struct omap_mcpdm *mcpdm = dev_id;
+	int irq_status;
+
+	irq_status = omap_mcpdm_read(mcpdm, MCPDM_REG_IRQSTATUS);
+
+	/* Acknowledge irq event */
+	omap_mcpdm_write(mcpdm, MCPDM_REG_IRQSTATUS, irq_status);
+
+	if (irq & MCPDM_DN_IRQ_FULL)
+		dev_err(mcpdm->dev, "DN FIFO error %x\n", irq_status);
+
+	if (irq & MCPDM_DN_IRQ_EMPTY)
+		dev_err(mcpdm->dev, "DN FIFO error %x\n", irq_status);
+
+	if (irq & MCPDM_DN_IRQ)
+		dev_dbg(mcpdm->dev, "DN write request\n");
+
+	if (irq & MCPDM_UP_IRQ_FULL)
+		dev_err(mcpdm->dev, "UP FIFO error %x\n", irq_status);
+
+	if (irq & MCPDM_UP_IRQ_EMPTY)
+		dev_err(mcpdm->dev, "UP FIFO error %x\n", irq_status);
+
+	if (irq & MCPDM_UP_IRQ)
+		dev_dbg(mcpdm->dev, "UP write request\n");
+
+	return IRQ_HANDLED;
+}
+
+static int omap_mcpdm_dai_startup(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *dai)
+{
+	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);
+	u32 ctrl;
+	int err = 0;
+
+	dev_dbg(dai->dev, "%s: active %d\n", __func__, dai->active);
+
+	/* make sure we stop any pre-existing shutdown */
+	cancel_delayed_work_sync(&mcpdm->delayed_work);
+
+	mutex_lock(&mcpdm->mutex);
+
+	if (!mcpdm->active++) {
+		pm_runtime_get_sync(mcpdm->dev);
+
+		/* Enable watch dog for ES above ES 1.0 to avoid saturation */
+		if (omap_rev() != OMAP4430_REV_ES1_0) {
+			ctrl = omap_mcpdm_read(mcpdm, MCPDM_REG_CTRL);
+			omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL,
+					 ctrl | MCPDM_WD_EN);
+		}
+	}
+
+	omap_mcpdm_open_stream(mcpdm, substream->stream);
+
+	mutex_unlock(&mcpdm->mutex);
+
+	return err;
+}
+
+/* work to delay McPDM shutdown */
+static void playback_work(struct work_struct *work)
+{
+	struct omap_mcpdm *mcpdm = container_of(work,
+					struct omap_mcpdm, delayed_work.work);
+
+	if (!mcpdm->active && omap_mcpdm_active(mcpdm)) {
+		omap_mcpdm_stop(mcpdm);
+		omap_mcpdm_close_streams(mcpdm);
+	}
+
+	if (!omap_mcpdm_active(mcpdm))
+		pm_runtime_put_sync(mcpdm->dev);
+}
+
+static void omap_mcpdm_dai_shutdown(struct snd_pcm_substream *substream,
+				    struct snd_soc_dai *dai)
+{
+	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);
+
+	dev_dbg(dai->dev, "%s: active %d\n", __func__, dai->active);
+
+	mutex_lock(&mcpdm->mutex);
+
+	if (!--mcpdm->active) {
+		cancel_delayed_work_sync(&mcpdm->delayed_work);
+		schedule_delayed_work(&mcpdm->delayed_work,
+					msecs_to_jiffies(1000));
+	}
+
+	mutex_unlock(&mcpdm->mutex);
+}
+
+static int omap_mcpdm_dai_hw_params(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *params,
+				    struct snd_soc_dai *dai)
+{
+	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);
+	int stream = substream->stream;
+	int link_mask = 0;
+
+	snd_soc_dai_set_dma_data(dai, substream,
+				 &omap_mcpdm_dai_dma_params[stream]);
+
+	switch (params_channels(params)) {
+	case 4:
+		if (stream == SNDRV_PCM_STREAM_CAPTURE)
+			/* up to 2 channels for capture */
+			return -EINVAL;
+		link_mask |= 1 << 3;
+	case 3:
+		if (stream == SNDRV_PCM_STREAM_CAPTURE)
+			/* up to 2 channels for capture */
+			return -EINVAL;
+		link_mask |= 1 << 2;
+	case 2:
+		link_mask |= 1 << 1;
+	case 1:
+		link_mask |= 1 << 0;
+		break;
+	default:
+		/* unsupported number of channels */
+		return -EINVAL;
+	}
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+		/* Downlink channels */
+		mcpdm->dn_channels = link_mask << 3;
+	else
+		/* Uplink channels */
+		mcpdm->up_channels = link_mask;
+
+	return 0;
+}
+
+static int omap_mcpdm_prepare(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *dai)
+{
+	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);
+
+	if (!omap_mcpdm_active(mcpdm))
+		omap_mcpdm_start(mcpdm);
+
+	omap_mcpdm_reg_dump(mcpdm);
+	return 0;
+}
+
+static struct snd_soc_dai_ops omap_mcpdm_dai_ops = {
+	.startup	= omap_mcpdm_dai_startup,
+	.shutdown	= omap_mcpdm_dai_shutdown,
+	.hw_params	= omap_mcpdm_dai_hw_params,
+	.prepare	= omap_mcpdm_prepare,
+};
+
+static int omap_mcpdm_probe(struct snd_soc_dai *dai)
+{
+	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);
+	int ret;
+
+	pm_runtime_enable(mcpdm->dev);
+
+	/* Disable lines while request is ongoing */
+	pm_runtime_get_sync(mcpdm->dev);
+	omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, 0x00);
+
+	ret = request_irq(mcpdm->irq, omap_mcpdm_irq_handler,
+				0, "McPDM", (void *)mcpdm);
+
+	pm_runtime_put_sync(mcpdm->dev);
+
+	if (ret) {
+		dev_err(mcpdm->dev, "Request for IRQ failed\n");
+		pm_runtime_disable(mcpdm->dev);
+	}
+
+	return ret;
+}
+
+static int omap_mcpdm_remove(struct snd_soc_dai *dai)
+{
+	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);
+
+	free_irq(mcpdm->irq, (void *)mcpdm);
+	pm_runtime_disable(mcpdm->dev);
+
+	return 0;
+}
+
+#define OMAP_MCPDM_RATES	(SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
+#define OMAP_MCPDM_FORMATS	SNDRV_PCM_FMTBIT_S32_LE
+
+static struct snd_soc_dai_driver omap_mcpdm_dai = {
+	.probe = omap_mcpdm_probe,
+	.remove = omap_mcpdm_remove,
+	.probe_order = SND_SOC_COMP_ORDER_LATE,
+	.remove_order = SND_SOC_COMP_ORDER_EARLY,
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 4,
+		.rates = OMAP_MCPDM_RATES,
+		.formats = OMAP_MCPDM_FORMATS,
+	},
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = OMAP_MCPDM_RATES,
+		.formats = OMAP_MCPDM_FORMATS,
+	},
+	.ops = &omap_mcpdm_dai_ops,
+};
+
+#if CONFIG_PM_SLEEP
+static int mcpdm_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_mcpdm *mcpdm = platform_get_drvdata(pdev);
+
+	flush_delayed_work_sync(&mcpdm->delayed_work);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(mcpdm_pm_ops, mcpdm_suspend, NULL);
+
+static __devinit int asoc_mcpdm_probe(struct platform_device *pdev)
+{
+	struct omap_mcpdm *mcpdm;
+	struct resource *res;
+	int ret = 0;
+
+	mcpdm = kzalloc(sizeof(struct omap_mcpdm), GFP_KERNEL);
+	if (!mcpdm)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, mcpdm);
+
+	mutex_init(&mcpdm->mutex);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "no resource\n");
+		goto err_res;
+	}
+
+	if (!request_mem_region(res->start, resource_size(res), "McPDM")) {
+		ret = -EBUSY;
+		goto err_res;
+	}
+
+	mcpdm->io_base = ioremap(res->start, resource_size(res));
+	if (!mcpdm->io_base) {
+		ret = -ENOMEM;
+		goto err_iomap;
+	}
+
+	mcpdm->irq = platform_get_irq(pdev, 0);
+	if (mcpdm->irq < 0) {
+		ret = mcpdm->irq;
+		goto err_irq;
+	}
+
+	mcpdm->dev = &pdev->dev;
+
+	INIT_DELAYED_WORK(&mcpdm->delayed_work, playback_work);
+
+	ret = snd_soc_register_dai(&pdev->dev, &omap_mcpdm_dai);
+	if (!ret)
+		return 0;
+
+err_irq:
+	iounmap(mcpdm->io_base);
+err_iomap:
+	release_mem_region(res->start, resource_size(res));
+err_res:
+	kfree(mcpdm);
+	return ret;
+}
+
+static int __devexit asoc_mcpdm_remove(struct platform_device *pdev)
+{
+	struct omap_mcpdm *mcpdm = platform_get_drvdata(pdev);
+	struct resource *res;
+
+	flush_delayed_work_sync(&mcpdm->delayed_work);
+
+	snd_soc_unregister_dai(&pdev->dev);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	iounmap(mcpdm->io_base);
+	release_mem_region(res->start, resource_size(res));
+
+	kfree(mcpdm);
+	return 0;
+}
+
+static struct platform_driver asoc_mcpdm_driver = {
+	.driver = {
+		.name	= "omap-mcpdm",
+		.owner	= THIS_MODULE,
+		.pm	= &mcpdm_pm_ops,
+	},
+
+	.probe	= asoc_mcpdm_probe,
+	.remove	= __devexit_p(asoc_mcpdm_remove),
+};
+
+static int __init snd_omap_mcpdm_init(void)
+{
+	return platform_driver_register(&asoc_mcpdm_driver);
+}
+module_init(snd_omap_mcpdm_init);
+
+static void __exit snd_omap_mcpdm_exit(void)
+{
+	platform_driver_unregister(&asoc_mcpdm_driver);
+}
+module_exit(snd_omap_mcpdm_exit);
+
+MODULE_AUTHOR("Misael Lopez Cruz <misael.lopez@ti.com>");
+MODULE_DESCRIPTION("OMAP PDM SoC Interface");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/omap/omap-mcpdm.h b/sound/soc/omap/omap-mcpdm.h
new file mode 100644
index 0000000..caaa992
--- /dev/null
+++ b/sound/soc/omap/omap-mcpdm.h
@@ -0,0 +1,109 @@
+/*
+ * omap-mcpdm.h
+ *
+ * Copyright (C) 2009 - 2011 Texas Instruments
+ *
+ * Contact: Misael Lopez Cruz <misael.lopez@ti.com>
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
+#ifndef __OMAP_MCPDM_H__
+#define __OMAP_MCPDM_H__
+
+#define MCPDM_REG_REVISION		0x00
+#define MCPDM_REG_SYSCONFIG		0x10
+#define MCPDM_REG_IRQSTATUS_RAW		0x24
+#define MCPDM_REG_IRQSTATUS		0x28
+#define MCPDM_REG_IRQENABLE_SET		0x2C
+#define MCPDM_REG_IRQENABLE_CLR		0x30
+#define MCPDM_REG_IRQWAKE_EN		0x34
+#define MCPDM_REG_DMAENABLE_SET		0x38
+#define MCPDM_REG_DMAENABLE_CLR		0x3C
+#define MCPDM_REG_DMAWAKEEN		0x40
+#define MCPDM_REG_CTRL			0x44
+#define MCPDM_REG_DN_DATA		0x48
+#define MCPDM_REG_UP_DATA		0x4C
+#define MCPDM_REG_FIFO_CTRL_DN		0x50
+#define MCPDM_REG_FIFO_CTRL_UP		0x54
+#define MCPDM_REG_DN_OFFSET		0x58
+
+/*
+ * MCPDM_IRQ bit fields
+ * IRQSTATUS_RAW, IRQSTATUS, IRQENABLE_SET, IRQENABLE_CLR
+ */
+
+#define MCPDM_DN_IRQ			(1 << 0)
+#define MCPDM_DN_IRQ_EMPTY		(1 << 1)
+#define MCPDM_DN_IRQ_ALMST_EMPTY	(1 << 2)
+#define MCPDM_DN_IRQ_FULL		(1 << 3)
+
+#define MCPDM_UP_IRQ			(1 << 8)
+#define MCPDM_UP_IRQ_EMPTY		(1 << 9)
+#define MCPDM_UP_IRQ_ALMST_FULL		(1 << 10)
+#define MCPDM_UP_IRQ_FULL		(1 << 11)
+
+#define MCPDM_DOWNLINK_IRQ_MASK		0x00F
+#define MCPDM_UPLINK_IRQ_MASK		0xF00
+
+/*
+ * MCPDM_DMAENABLE bit fields
+ */
+
+#define MCPDM_DMA_DN_ENABLE		(1 << 0)
+#define MCPDM_DMA_UP_ENABLE		(1 << 1)
+
+/*
+ * MCPDM_CTRL bit fields
+ */
+
+#define MCPDM_PDM_UPLINK_EN(x)		(1 << (x - 1)) /* ch1 is at bit 0 */
+#define MCPDM_PDM_DOWNLINK_EN(x)	(1 << (x + 2)) /* ch1 is at bit 3 */
+#define MCPDM_PDMOUTFORMAT		(1 << 8)
+#define MCPDM_CMD_INT			(1 << 9)
+#define MCPDM_STATUS_INT		(1 << 10)
+#define MCPDM_SW_UP_RST			(1 << 11)
+#define MCPDM_SW_DN_RST			(1 << 12)
+#define MCPDM_WD_EN			(1 << 14)
+#define MCPDM_PDM_UP_MASK		0x7
+#define MCPDM_PDM_DN_MASK		(0x1f << 3)
+
+
+#define MCPDM_PDMOUTFORMAT_LJUST	(0 << 8)
+#define MCPDM_PDMOUTFORMAT_RJUST	(1 << 8)
+
+/*
+ * MCPDM_FIFO_CTRL bit fields
+ */
+
+#define MCPDM_UP_THRES_MAX		0xF
+#define MCPDM_DN_THRES_MAX		0xF
+
+/*
+ * MCPDM_DN_OFFSET bit fields
+ */
+
+#define MCPDM_DN_OFST_RX1_EN		(1 << 0)
+#define MCPDM_DN_OFST_RX2_EN		(1 << 8)
+
+#define MCPDM_DN_OFST_RX1		1
+#define MCPDM_DN_OFST_RX2		9
+#define MCPDM_DN_OFST_MAX		0x1F
+
+#define MCPDM_UPLINK			1
+#define MCPDM_DOWNLINK			2
+
+#endif	/* End of __OMAP_MCPDM_H__ */
diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index 7b18ef8..d462f1a 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/sdp4430.c
@@ -32,7 +32,7 @@
 #include <plat/hardware.h>
 #include <plat/mux.h>
 
-#include "mcpdm.h"
+#include "omap-mcpdm.h"
 #include "omap-pcm.h"
 #include "../codecs/twl6040.h"
 
@@ -165,7 +165,7 @@ static int sdp4430_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 static struct snd_soc_dai_link sdp4430_dai = {
 	.name = "TWL6040",
 	.stream_name = "TWL6040",
-	.cpu_dai_name ="omap-mcpdm-dai",
+	.cpu_dai_name = "omap-mcpdm",
 	.codec_dai_name = "twl6040-hifi",
 	.platform_name = "omap-pcm-audio",
 	.codec_name = "twl6040-codec",
-- 
1.7.6

