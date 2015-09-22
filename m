From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 10/24] ARM: davinci: Add set dma_mask to eDMA devices
Date: Tue, 22 Sep 2015 12:54:21 +0300
Message-ID: <1442915675-7121-11-git-send-email-peter.ujfalusi@ti.com>
References: <1442915675-7121-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442915675-7121-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The upcoming change to merge the arch/arm/common/edma.c into
drivers/dma/edma.c will need this change when booting daVinci devices in
no DT mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/Kconfig                      |    1 -
 arch/arm/common/Kconfig               |    3 -
 arch/arm/common/Makefile              |    1 -
 arch/arm/common/edma.c                | 1431 --------------------------------
 arch/arm/mach-davinci/devices-da8xx.c |    2 +
 arch/arm/mach-davinci/dm355.c         |    1 +
 arch/arm/mach-davinci/dm644x.c        |    1 +
 arch/arm/mach-davinci/dm646x.c        |    1 +
 arch/arm/mach-omap2/Kconfig           |    1 -
 drivers/dma/Kconfig                   |    1 -
 drivers/dma/edma.c                    | 1447 +++++++++++++++++++++++++++++++--
 include/linux/platform_data/edma.h    |   74 --
 12 files changed, 1394 insertions(+), 1570 deletions(-)
 delete mode 100644 arch/arm/common/edma.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 471a3670cd3e..704e4ab6d552 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -714,7 +714,6 @@ config ARCH_DAVINCI
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
 	select HAVE_IDE
-	select TI_PRIV_EDMA
 	select USE_OF
 	select ZONE_DMA
 	help
diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index c3a4e9ceba34..9353184d730d 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -17,6 +17,3 @@ config SHARP_PARAM
 
 config SHARP_SCOOP
 	bool
-
-config TI_PRIV_EDMA
-	bool
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 6ee5959a813b..27f23b15b1ea 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -15,6 +15,5 @@ obj-$(CONFIG_MCPM)		+= mcpm_head.o mcpm_entry.o mcpm_platsmp.o vlock.o
 CFLAGS_REMOVE_mcpm_entry.o	= -pg
 AFLAGS_mcpm_head.o		:= -march=armv7-a
 AFLAGS_vlock.o			:= -march=armv7-a
-obj-$(CONFIG_TI_PRIV_EDMA)	+= edma.o
 obj-$(CONFIG_BL_SWITCHER)	+= bL_switcher.o
 obj-$(CONFIG_BL_SWITCHER_DUMMY_IF) += bL_switcher_dummy_if.o
diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
deleted file mode 100644
index 5b747f1bc8b5..000000000000
--- a/arch/arm/common/edma.c
+++ /dev/null
@@ -1,1431 +0,0 @@
-/*
- * EDMA3 support for DaVinci
- *
- * Copyright (C) 2006-2009 Texas Instruments.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#include <linux/err.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-#include <linux/edma.h>
-#include <linux/dma-mapping.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
-#include <linux/pm_runtime.h>
-
-#include <linux/platform_data/edma.h>
-
-/* Offsets matching "struct edmacc_param" */
-#define PARM_OPT		0x00
-#define PARM_SRC		0x04
-#define PARM_A_B_CNT		0x08
-#define PARM_DST		0x0c
-#define PARM_SRC_DST_BIDX	0x10
-#define PARM_LINK_BCNTRLD	0x14
-#define PARM_SRC_DST_CIDX	0x18
-#define PARM_CCNT		0x1c
-
-#define PARM_SIZE		0x20
-
-/* Offsets for EDMA CC global channel registers and their shadows */
-#define SH_ER		0x00	/* 64 bits */
-#define SH_ECR		0x08	/* 64 bits */
-#define SH_ESR		0x10	/* 64 bits */
-#define SH_CER		0x18	/* 64 bits */
-#define SH_EER		0x20	/* 64 bits */
-#define SH_EECR		0x28	/* 64 bits */
-#define SH_EESR		0x30	/* 64 bits */
-#define SH_SER		0x38	/* 64 bits */
-#define SH_SECR		0x40	/* 64 bits */
-#define SH_IER		0x50	/* 64 bits */
-#define SH_IECR		0x58	/* 64 bits */
-#define SH_IESR		0x60	/* 64 bits */
-#define SH_IPR		0x68	/* 64 bits */
-#define SH_ICR		0x70	/* 64 bits */
-#define SH_IEVAL	0x78
-#define SH_QER		0x80
-#define SH_QEER		0x84
-#define SH_QEECR	0x88
-#define SH_QEESR	0x8c
-#define SH_QSER		0x90
-#define SH_QSECR	0x94
-#define SH_SIZE		0x200
-
-/* Offsets for EDMA CC global registers */
-#define EDMA_REV	0x0000
-#define EDMA_CCCFG	0x0004
-#define EDMA_QCHMAP	0x0200	/* 8 registers */
-#define EDMA_DMAQNUM	0x0240	/* 8 registers (4 on OMAP-L1xx) */
-#define EDMA_QDMAQNUM	0x0260
-#define EDMA_QUETCMAP	0x0280
-#define EDMA_QUEPRI	0x0284
-#define EDMA_EMR	0x0300	/* 64 bits */
-#define EDMA_EMCR	0x0308	/* 64 bits */
-#define EDMA_QEMR	0x0310
-#define EDMA_QEMCR	0x0314
-#define EDMA_CCERR	0x0318
-#define EDMA_CCERRCLR	0x031c
-#define EDMA_EEVAL	0x0320
-#define EDMA_DRAE	0x0340	/* 4 x 64 bits*/
-#define EDMA_QRAE	0x0380	/* 4 registers */
-#define EDMA_QUEEVTENTRY	0x0400	/* 2 x 16 registers */
-#define EDMA_QSTAT	0x0600	/* 2 registers */
-#define EDMA_QWMTHRA	0x0620
-#define EDMA_QWMTHRB	0x0624
-#define EDMA_CCSTAT	0x0640
-
-#define EDMA_M		0x1000	/* global channel registers */
-#define EDMA_ECR	0x1008
-#define EDMA_ECRH	0x100C
-#define EDMA_SHADOW0	0x2000	/* 4 regions shadowing global channels */
-#define EDMA_PARM	0x4000	/* 128 param entries */
-
-#define PARM_OFFSET(param_no)	(EDMA_PARM + ((param_no) << 5))
-
-#define EDMA_DCHMAP	0x0100  /* 64 registers */
-
-/* CCCFG register */
-#define GET_NUM_DMACH(x)	(x & 0x7) /* bits 0-2 */
-#define GET_NUM_PAENTRY(x)	((x & 0x7000) >> 12) /* bits 12-14 */
-#define GET_NUM_EVQUE(x)	((x & 0x70000) >> 16) /* bits 16-18 */
-#define GET_NUM_REGN(x)		((x & 0x300000) >> 20) /* bits 20-21 */
-#define CHMAP_EXIST		BIT(24)
-
-#define EDMA_MAX_DMACH           64
-#define EDMA_MAX_PARAMENTRY     512
-
-/*****************************************************************************/
-struct edma {
-	struct device	*dev;
-	void __iomem *base;
-
-	/* how many dma resources of each type */
-	unsigned	num_channels;
-	unsigned	num_region;
-	unsigned	num_slots;
-	unsigned	num_tc;
-	enum dma_event_q 	default_queue;
-
-	/* list of channels with no even trigger; terminated by "-1" */
-	const s8	*noevent;
-
-	struct edma_soc_info *info;
-	int		id;
-	bool		unused_chan_list_done;
-	/* The edma_inuse bit for each PaRAM slot is clear unless the
-	 * channel is in use ... by ARM or DSP, for QDMA, or whatever.
-	 */
-	DECLARE_BITMAP(edma_inuse, EDMA_MAX_PARAMENTRY);
-
-	/* The edma_unused bit for each channel is clear unless
-	 * it is not being used on this platform. It uses a bit
-	 * of SOC-specific initialization code.
-	 */
-	DECLARE_BITMAP(edma_unused, EDMA_MAX_DMACH);
-
-	struct dma_interrupt_data {
-		void (*callback)(unsigned channel, unsigned short ch_status,
-				void *data);
-		void *data;
-	} intr_data[EDMA_MAX_DMACH];
-};
-/*****************************************************************************/
-
-static inline unsigned int edma_read(struct edma *cc, int offset)
-{
-	return (unsigned int)__raw_readl(cc->base + offset);
-}
-
-static inline void edma_write(struct edma *cc, int offset, int val)
-{
-	__raw_writel(val, cc->base + offset);
-}
-static inline void edma_modify(struct edma *cc, int offset, unsigned and,
-			       unsigned or)
-{
-	unsigned val = edma_read(cc, offset);
-	val &= and;
-	val |= or;
-	edma_write(cc, offset, val);
-}
-static inline void edma_and(struct edma *cc, int offset, unsigned and)
-{
-	unsigned val = edma_read(cc, offset);
-	val &= and;
-	edma_write(cc, offset, val);
-}
-static inline void edma_or(struct edma *cc, int offset, unsigned or)
-{
-	unsigned val = edma_read(cc, offset);
-	val |= or;
-	edma_write(cc, offset, val);
-}
-static inline unsigned int edma_read_array(struct edma *cc, int offset, int i)
-{
-	return edma_read(cc, offset + (i << 2));
-}
-static inline void edma_write_array(struct edma *cc, int offset, int i,
-		unsigned val)
-{
-	edma_write(cc, offset + (i << 2), val);
-}
-static inline void edma_modify_array(struct edma *cc, int offset, int i,
-		unsigned and, unsigned or)
-{
-	edma_modify(cc, offset + (i << 2), and, or);
-}
-static inline void edma_or_array(struct edma *cc, int offset, int i, unsigned or)
-{
-	edma_or(cc, offset + (i << 2), or);
-}
-static inline void edma_or_array2(struct edma *cc, int offset, int i, int j,
-		unsigned or)
-{
-	edma_or(cc, offset + ((i*2 + j) << 2), or);
-}
-static inline void edma_write_array2(struct edma *cc, int offset, int i, int j,
-		unsigned val)
-{
-	edma_write(cc, offset + ((i*2 + j) << 2), val);
-}
-static inline unsigned int edma_shadow0_read(struct edma *cc, int offset)
-{
-	return edma_read(cc, EDMA_SHADOW0 + offset);
-}
-static inline unsigned int edma_shadow0_read_array(struct edma *cc, int offset,
-		int i)
-{
-	return edma_read(cc, EDMA_SHADOW0 + offset + (i << 2));
-}
-static inline void edma_shadow0_write(struct edma *cc, int offset, unsigned val)
-{
-	edma_write(cc, EDMA_SHADOW0 + offset, val);
-}
-static inline void edma_shadow0_write_array(struct edma *cc, int offset, int i,
-		unsigned val)
-{
-	edma_write(cc, EDMA_SHADOW0 + offset + (i << 2), val);
-}
-static inline unsigned int edma_parm_read(struct edma *cc, int offset,
-		int param_no)
-{
-	return edma_read(cc, EDMA_PARM + offset + (param_no << 5));
-}
-static inline void edma_parm_write(struct edma *cc, int offset, int param_no,
-		unsigned val)
-{
-	edma_write(cc, EDMA_PARM + offset + (param_no << 5), val);
-}
-static inline void edma_parm_modify(struct edma *cc, int offset, int param_no,
-		unsigned and, unsigned or)
-{
-	edma_modify(cc, EDMA_PARM + offset + (param_no << 5), and, or);
-}
-static inline void edma_parm_and(struct edma *cc, int offset, int param_no,
-		unsigned and)
-{
-	edma_and(cc, EDMA_PARM + offset + (param_no << 5), and);
-}
-static inline void edma_parm_or(struct edma *cc, int offset, int param_no,
-		unsigned or)
-{
-	edma_or(cc, EDMA_PARM + offset + (param_no << 5), or);
-}
-
-static inline void set_bits(int offset, int len, unsigned long *p)
-{
-	for (; len > 0; len--)
-		set_bit(offset + (len - 1), p);
-}
-
-static inline void clear_bits(int offset, int len, unsigned long *p)
-{
-	for (; len > 0; len--)
-		clear_bit(offset + (len - 1), p);
-}
-
-/*****************************************************************************/
-static int arch_num_cc;
-
-/* dummy param set used to (re)initialize parameter RAM slots */
-static const struct edmacc_param dummy_paramset = {
-	.link_bcntrld = 0xffff,
-	.ccnt = 1,
-};
-
-static const struct of_device_id edma_of_ids[] = {
-	{ .compatible = "ti,edma3", },
-	{}
-};
-
-/*****************************************************************************/
-
-static void map_dmach_queue(struct edma *cc, unsigned ch_no,
-			    enum dma_event_q queue_no)
-{
-	int bit = (ch_no & 0x7) * 4;
-
-	/* default to low priority queue */
-	if (queue_no == EVENTQ_DEFAULT)
-		queue_no = cc->default_queue;
-
-	queue_no &= 7;
-	edma_modify_array(cc, EDMA_DMAQNUM, (ch_no >> 3),
-			  ~(0x7 << bit), queue_no << bit);
-}
-
-static void assign_priority_to_queue(struct edma *cc, int queue_no,
-				     int priority)
-{
-	int bit = queue_no * 4;
-	edma_modify(cc, EDMA_QUEPRI, ~(0x7 << bit), ((priority & 0x7) << bit));
-}
-
-/**
- * map_dmach_param - Maps channel number to param entry number
- *
- * This maps the dma channel number to param entry numberter. In
- * other words using the DMA channel mapping registers a param entry
- * can be mapped to any channel
- *
- * Callers are responsible for ensuring the channel mapping logic is
- * included in that particular EDMA variant (Eg : dm646x)
- *
- */
-static void map_dmach_param(struct edma *cc)
-{
-	int i;
-	for (i = 0; i < EDMA_MAX_DMACH; i++)
-		edma_write_array(cc, EDMA_DCHMAP , i , (i << 5));
-}
-
-static inline void setup_dma_interrupt(struct edma *cc, unsigned lch,
-	void (*callback)(unsigned channel, u16 ch_status, void *data),
-	void *data)
-{
-	lch = EDMA_CHAN_SLOT(lch);
-
-	if (!callback)
-		edma_shadow0_write_array(cc, SH_IECR, lch >> 5,
-					 BIT(lch & 0x1f));
-
-	cc->intr_data[lch].callback = callback;
-	cc->intr_data[lch].data = data;
-
-	if (callback) {
-		edma_shadow0_write_array(cc, SH_ICR, lch >> 5, BIT(lch & 0x1f));
-		edma_shadow0_write_array(cc, SH_IESR, lch >> 5,
-					 BIT(lch & 0x1f));
-	}
-}
-
-/******************************************************************************
- *
- * DMA interrupt handler
- *
- *****************************************************************************/
-static irqreturn_t dma_irq_handler(int irq, void *data)
-{
-	struct edma *cc = data;
-	int ctlr;
-	u32 sh_ier;
-	u32 sh_ipr;
-	u32 bank;
-
-	ctlr = cc->id;
-	if (ctlr < 0)
-		return IRQ_NONE;
-
-	dev_dbg(cc->dev, "dma_irq_handler\n");
-
-	sh_ipr = edma_shadow0_read_array(cc, SH_IPR, 0);
-	if (!sh_ipr) {
-		sh_ipr = edma_shadow0_read_array(cc, SH_IPR, 1);
-		if (!sh_ipr)
-			return IRQ_NONE;
-		sh_ier = edma_shadow0_read_array(cc, SH_IER, 1);
-		bank = 1;
-	} else {
-		sh_ier = edma_shadow0_read_array(cc, SH_IER, 0);
-		bank = 0;
-	}
-
-	do {
-		u32 slot;
-		u32 channel;
-
-		dev_dbg(cc->dev, "IPR%d %08x\n", bank, sh_ipr);
-
-		slot = __ffs(sh_ipr);
-		sh_ipr &= ~(BIT(slot));
-
-		if (sh_ier & BIT(slot)) {
-			channel = (bank << 5) | slot;
-			/* Clear the corresponding IPR bits */
-			edma_shadow0_write_array(cc, SH_ICR, bank, BIT(slot));
-			if (cc->intr_data[channel].callback)
-				cc->intr_data[channel].callback(
-					EDMA_CTLR_CHAN(ctlr, channel),
-					EDMA_DMA_COMPLETE,
-					cc->intr_data[channel].data);
-		}
-	} while (sh_ipr);
-
-	edma_shadow0_write(cc, SH_IEVAL, 1);
-	return IRQ_HANDLED;
-}
-
-/******************************************************************************
- *
- * DMA error interrupt handler
- *
- *****************************************************************************/
-static irqreturn_t dma_ccerr_handler(int irq, void *data)
-{
-	struct edma *cc = data;
-	int i;
-	int ctlr;
-	unsigned int cnt = 0;
-
-	ctlr = cc->id;
-	if (ctlr < 0)
-		return IRQ_NONE;
-
-	dev_dbg(cc->dev, "dma_ccerr_handler\n");
-
-	if ((edma_read_array(cc, EDMA_EMR, 0) == 0) &&
-	    (edma_read_array(cc, EDMA_EMR, 1) == 0) &&
-	    (edma_read(cc, EDMA_QEMR) == 0) &&
-	    (edma_read(cc, EDMA_CCERR) == 0))
-		return IRQ_NONE;
-
-	while (1) {
-		int j = -1;
-		if (edma_read_array(cc, EDMA_EMR, 0))
-			j = 0;
-		else if (edma_read_array(cc, EDMA_EMR, 1))
-			j = 1;
-		if (j >= 0) {
-			dev_dbg(cc->dev, "EMR%d %08x\n", j,
-				edma_read_array(cc, EDMA_EMR, j));
-			for (i = 0; i < 32; i++) {
-				int k = (j << 5) + i;
-				if (edma_read_array(cc, EDMA_EMR, j) &
-							BIT(i)) {
-					/* Clear the corresponding EMR bits */
-					edma_write_array(cc, EDMA_EMCR, j,
-							 BIT(i));
-					/* Clear any SER */
-					edma_shadow0_write_array(cc, SH_SECR,
-								j, BIT(i));
-					if (cc->intr_data[k].callback) {
-						cc->intr_data[k].callback(
-							EDMA_CTLR_CHAN(ctlr, k),
-							EDMA_DMA_CC_ERROR,
-							cc->intr_data[k].data);
-					}
-				}
-			}
-		} else if (edma_read(cc, EDMA_QEMR)) {
-			dev_dbg(cc->dev, "QEMR %02x\n",
-				edma_read(cc, EDMA_QEMR));
-			for (i = 0; i < 8; i++) {
-				if (edma_read(cc, EDMA_QEMR) & BIT(i)) {
-					/* Clear the corresponding IPR bits */
-					edma_write(cc, EDMA_QEMCR, BIT(i));
-					edma_shadow0_write(cc, SH_QSECR,
-							   BIT(i));
-
-					/* NOTE:  not reported!! */
-				}
-			}
-		} else if (edma_read(cc, EDMA_CCERR)) {
-			dev_dbg(cc->dev, "CCERR %08x\n",
-				edma_read(cc, EDMA_CCERR));
-			/* FIXME:  CCERR.BIT(16) ignored!  much better
-			 * to just write CCERRCLR with CCERR value...
-			 */
-			for (i = 0; i < 8; i++) {
-				if (edma_read(cc, EDMA_CCERR) & BIT(i)) {
-					/* Clear the corresponding IPR bits */
-					edma_write(cc, EDMA_CCERRCLR, BIT(i));
-
-					/* NOTE:  not reported!! */
-				}
-			}
-		}
-		if ((edma_read_array(cc, EDMA_EMR, 0) == 0) &&
-		    (edma_read_array(cc, EDMA_EMR, 1) == 0) &&
-		    (edma_read(cc, EDMA_QEMR) == 0) &&
-		    (edma_read(cc, EDMA_CCERR) == 0))
-			break;
-		cnt++;
-		if (cnt > 10)
-			break;
-	}
-	edma_write(cc, EDMA_EEVAL, 1);
-	return IRQ_HANDLED;
-}
-
-static int prepare_unused_channel_list(struct device *dev, void *data)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct edma *cc = data;
-	int i, count;
-	struct of_phandle_args  dma_spec;
-
-	if (dev->of_node) {
-		struct platform_device *dma_pdev;
-
-		count = of_property_count_strings(dev->of_node, "dma-names");
-		if (count < 0)
-			return 0;
-		for (i = 0; i < count; i++) {
-
-			if (of_parse_phandle_with_args(dev->of_node, "dmas",
-						       "#dma-cells", i,
-						       &dma_spec))
-				continue;
-
-			if (!of_match_node(edma_of_ids, dma_spec.np)) {
-				of_node_put(dma_spec.np);
-				continue;
-			}
-
-			dma_pdev = of_find_device_by_node(dma_spec.np);
-			if (&dma_pdev->dev != cc->dev)
-				continue;
-
-			clear_bit(EDMA_CHAN_SLOT(dma_spec.args[0]),
-				  cc->edma_unused);
-			of_node_put(dma_spec.np);
-		}
-		return 0;
-	}
-
-	/* For non-OF case */
-	for (i = 0; i < pdev->num_resources; i++) {
-		struct resource	*res = &pdev->resource[i];
-
-		if ((res->flags & IORESOURCE_DMA) && (int)res->start >= 0) {
-			clear_bit(EDMA_CHAN_SLOT(pdev->resource[i].start),
-				  cc->edma_unused);
-		}
-	}
-
-	return 0;
-}
-
-/*-----------------------------------------------------------------------*/
-
-/* Resource alloc/free:  dma channels, parameter RAM slots */
-
-/**
- * edma_alloc_channel - allocate DMA channel and paired parameter RAM
- * @channel: specific channel to allocate; negative for "any unmapped channel"
- * @callback: optional; to be issued on DMA completion or errors
- * @data: passed to callback
- * @eventq_no: an EVENTQ_* constant, used to choose which Transfer
- *	Controller (TC) executes requests using this channel.  Use
- *	EVENTQ_DEFAULT unless you really need a high priority queue.
- *
- * This allocates a DMA channel and its associated parameter RAM slot.
- * The parameter RAM is initialized to hold a dummy transfer.
- *
- * Normal use is to pass a specific channel number as @channel, to make
- * use of hardware events mapped to that channel.  When the channel will
- * be used only for software triggering or event chaining, channels not
- * mapped to hardware events (or mapped to unused events) are preferable.
- *
- * DMA transfers start from a channel using edma_start(), or by
- * chaining.  When the transfer described in that channel's parameter RAM
- * slot completes, that slot's data may be reloaded through a link.
- *
- * DMA errors are only reported to the @callback associated with the
- * channel driving that transfer, but transfer completion callbacks can
- * be sent to another channel under control of the TCC field in
- * the option word of the transfer's parameter RAM set.  Drivers must not
- * use DMA transfer completion callbacks for channels they did not allocate.
- * (The same applies to TCC codes used in transfer chaining.)
- *
- * Returns the number of the channel, else negative errno.
- */
-int edma_alloc_channel(struct edma *cc, int channel,
-		void (*callback)(unsigned channel, u16 ch_status, void *data),
-		void *data,
-		enum dma_event_q eventq_no)
-{
-	unsigned done = 0;
-	int ret = 0;
-
-	if (!cc->unused_chan_list_done) {
-		/*
-		 * Scan all the platform devices to find out the EDMA channels
-		 * used and clear them in the unused list, making the rest
-		 * available for ARM usage.
-		 */
-		ret = bus_for_each_dev(&platform_bus_type, NULL, cc,
-				       prepare_unused_channel_list);
-		if (ret < 0)
-			return ret;
-
-		cc->unused_chan_list_done = true;
-	}
-
-	if (channel >= 0) {
-		if (cc->id != EDMA_CTLR(channel)) {
-			dev_err(cc->dev, "%s: ID mismatch for eDMA%d: %d\n",
-				__func__, cc->id, EDMA_CTLR(channel));
-			return -EINVAL;
-		}
-		channel = EDMA_CHAN_SLOT(channel);
-	}
-
-	if (channel < 0) {
-		channel = 0;
-		for (;;) {
-			channel = find_next_bit(cc->edma_unused,
-						cc->num_channels, channel);
-			if (channel == cc->num_channels)
-				break;
-			if (!test_and_set_bit(channel, cc->edma_inuse)) {
-				done = 1;
-				break;
-			}
-			channel++;
-		}
-		if (!done)
-			return -ENOMEM;
-	} else if (channel >= cc->num_channels) {
-		return -EINVAL;
-	} else if (test_and_set_bit(channel, cc->edma_inuse)) {
-		return -EBUSY;
-	}
-
-	/* ensure access through shadow region 0 */
-	edma_or_array2(cc, EDMA_DRAE, 0, channel >> 5, BIT(channel & 0x1f));
-
-	/* ensure no events are pending */
-	edma_stop(cc, EDMA_CTLR_CHAN(cc->id, channel));
-	memcpy_toio(cc->base + PARM_OFFSET(channel), &dummy_paramset,
-		    PARM_SIZE);
-
-	if (callback)
-		setup_dma_interrupt(cc, EDMA_CTLR_CHAN(cc->id, channel),
-				    callback, data);
-
-	map_dmach_queue(cc, channel, eventq_no);
-
-	return EDMA_CTLR_CHAN(cc->id, channel);
-}
-EXPORT_SYMBOL(edma_alloc_channel);
-
-
-/**
- * edma_free_channel - deallocate DMA channel
- * @channel: dma channel returned from edma_alloc_channel()
- *
- * This deallocates the DMA channel and associated parameter RAM slot
- * allocated by edma_alloc_channel().
- *
- * Callers are responsible for ensuring the channel is inactive, and
- * will not be reactivated by linking, chaining, or software calls to
- * edma_start().
- */
-void edma_free_channel(struct edma *cc, unsigned channel)
-{
-
-	if (cc->id != EDMA_CTLR(channel)) {
-		dev_err(cc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
-			cc->id, EDMA_CTLR(channel));
-		return;
-	}
-	channel = EDMA_CHAN_SLOT(channel);
-
-	if (channel >= cc->num_channels)
-		return;
-
-	setup_dma_interrupt(cc, channel, NULL, NULL);
-	/* REVISIT should probably take out of shadow region 0 */
-
-	memcpy_toio(cc->base + PARM_OFFSET(channel), &dummy_paramset,
-		    PARM_SIZE);
-	clear_bit(channel, cc->edma_inuse);
-}
-EXPORT_SYMBOL(edma_free_channel);
-
-/**
- * edma_alloc_slot - allocate DMA parameter RAM
- * @slot: specific slot to allocate; negative for "any unused slot"
- *
- * This allocates a parameter RAM slot, initializing it to hold a
- * dummy transfer.  Slots allocated using this routine have not been
- * mapped to a hardware DMA channel, and will normally be used by
- * linking to them from a slot associated with a DMA channel.
- *
- * Normal use is to pass EDMA_SLOT_ANY as the @slot, but specific
- * slots may be allocated on behalf of DSP firmware.
- *
- * Returns the number of the slot, else negative errno.
- */
-int edma_alloc_slot(struct edma *cc, int slot)
-{
-	if (slot > 0)
-		slot = EDMA_CHAN_SLOT(slot);
-	if (slot < 0) {
-		slot = cc->num_channels;
-		for (;;) {
-			slot = find_next_zero_bit(cc->edma_inuse, cc->num_slots,
-						  slot);
-			if (slot == cc->num_slots)
-				return -ENOMEM;
-			if (!test_and_set_bit(slot, cc->edma_inuse))
-				break;
-		}
-	} else if (slot < cc->num_channels || slot >= cc->num_slots) {
-		return -EINVAL;
-	} else if (test_and_set_bit(slot, cc->edma_inuse)) {
-		return -EBUSY;
-	}
-
-	memcpy_toio(cc->base + PARM_OFFSET(slot), &dummy_paramset, PARM_SIZE);
-
-	return slot;
-}
-EXPORT_SYMBOL(edma_alloc_slot);
-
-/**
- * edma_free_slot - deallocate DMA parameter RAM
- * @slot: parameter RAM slot returned from edma_alloc_slot()
- *
- * This deallocates the parameter RAM slot allocated by edma_alloc_slot().
- * Callers are responsible for ensuring the slot is inactive, and will
- * not be activated.
- */
-void edma_free_slot(struct edma *cc, unsigned slot)
-{
-
-	slot = EDMA_CHAN_SLOT(slot);
-	if (slot < cc->num_channels || slot >= cc->num_slots)
-		return;
-
-	memcpy_toio(cc->base + PARM_OFFSET(slot), &dummy_paramset, PARM_SIZE);
-	clear_bit(slot, cc->edma_inuse);
-}
-EXPORT_SYMBOL(edma_free_slot);
-
-/*-----------------------------------------------------------------------*/
-
-/* Parameter RAM operations (i) -- read/write partial slots */
-
-/**
- * edma_get_position - returns the current transfer point
- * @slot: parameter RAM slot being examined
- * @dst:  true selects the dest position, false the source
- *
- * Returns the position of the current active slot
- */
-dma_addr_t edma_get_position(struct edma *cc, unsigned slot, bool dst)
-{
-	u32 offs;
-
-	slot = EDMA_CHAN_SLOT(slot);
-	offs = PARM_OFFSET(slot);
-	offs += dst ? PARM_DST : PARM_SRC;
-
-	return edma_read(cc, offs);
-}
-
-/**
- * edma_link - link one parameter RAM slot to another
- * @from: parameter RAM slot originating the link
- * @to: parameter RAM slot which is the link target
- *
- * The originating slot should not be part of any active DMA transfer.
- */
-void edma_link(struct edma *cc, unsigned from, unsigned to)
-{
-	from = EDMA_CHAN_SLOT(from);
-	to = EDMA_CHAN_SLOT(to);
-	if (from >= cc->num_slots || to >= cc->num_slots)
-		return;
-
-	edma_parm_modify(cc, PARM_LINK_BCNTRLD, from, 0xffff0000,
-			 PARM_OFFSET(to));
-}
-EXPORT_SYMBOL(edma_link);
-
-/*-----------------------------------------------------------------------*/
-
-/* Parameter RAM operations (ii) -- read/write whole parameter sets */
-
-/**
- * edma_write_slot - write parameter RAM data for slot
- * @slot: number of parameter RAM slot being modified
- * @param: data to be written into parameter RAM slot
- *
- * Use this to assign all parameters of a transfer at once.  This
- * allows more efficient setup of transfers than issuing multiple
- * calls to set up those parameters in small pieces, and provides
- * complete control over all transfer options.
- */
-void edma_write_slot(struct edma *cc, unsigned slot,
-		     const struct edmacc_param *param)
-{
-	slot = EDMA_CHAN_SLOT(slot);
-	if (slot >= cc->num_slots)
-		return;
-	memcpy_toio(cc->base + PARM_OFFSET(slot), param, PARM_SIZE);
-}
-EXPORT_SYMBOL(edma_write_slot);
-
-/**
- * edma_read_slot - read parameter RAM data from slot
- * @slot: number of parameter RAM slot being copied
- * @param: where to store copy of parameter RAM data
- *
- * Use this to read data from a parameter RAM slot, perhaps to
- * save them as a template for later reuse.
- */
-void edma_read_slot(struct edma *cc, unsigned slot, struct edmacc_param *param)
-{
-	slot = EDMA_CHAN_SLOT(slot);
-	if (slot >= cc->num_slots)
-		return;
-	memcpy_fromio(param, cc->base + PARM_OFFSET(slot), PARM_SIZE);
-}
-EXPORT_SYMBOL(edma_read_slot);
-
-/*-----------------------------------------------------------------------*/
-
-/* Various EDMA channel control operations */
-
-/**
- * edma_pause - pause dma on a channel
- * @channel: on which edma_start() has been called
- *
- * This temporarily disables EDMA hardware events on the specified channel,
- * preventing them from triggering new transfers on its behalf
- */
-void edma_pause(struct edma *cc, unsigned channel)
-{
-	if (cc->id != EDMA_CTLR(channel)) {
-		dev_err(cc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
-			cc->id, EDMA_CTLR(channel));
-		return;
-	}
-	channel = EDMA_CHAN_SLOT(channel);
-
-	if (channel < cc->num_channels) {
-		unsigned int mask = BIT(channel & 0x1f);
-
-		edma_shadow0_write_array(cc, SH_EECR, channel >> 5, mask);
-	}
-}
-EXPORT_SYMBOL(edma_pause);
-
-/**
- * edma_resume - resumes dma on a paused channel
- * @channel: on which edma_pause() has been called
- *
- * This re-enables EDMA hardware events on the specified channel.
- */
-void edma_resume(struct edma *cc, unsigned channel)
-{
-	if (cc->id != EDMA_CTLR(channel)) {
-		dev_err(cc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
-			cc->id, EDMA_CTLR(channel));
-		return;
-	}
-	channel = EDMA_CHAN_SLOT(channel);
-
-	if (channel < cc->num_channels) {
-		unsigned int mask = BIT(channel & 0x1f);
-
-		edma_shadow0_write_array(cc, SH_EESR, channel >> 5, mask);
-	}
-}
-EXPORT_SYMBOL(edma_resume);
-
-int edma_trigger_channel(struct edma *cc, unsigned channel)
-{
-	unsigned int mask;
-
-	if (cc->id != EDMA_CTLR(channel)) {
-		dev_err(cc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
-			cc->id, EDMA_CTLR(channel));
-		return -EINVAL;
-	}
-	channel = EDMA_CHAN_SLOT(channel);
-	mask = BIT(channel & 0x1f);
-
-	edma_shadow0_write_array(cc, SH_ESR, (channel >> 5), mask);
-
-	pr_debug("EDMA: ESR%d %08x\n", (channel >> 5),
-		 edma_shadow0_read_array(cc, SH_ESR, (channel >> 5)));
-	return 0;
-}
-EXPORT_SYMBOL(edma_trigger_channel);
-
-/**
- * edma_start - start dma on a channel
- * @channel: channel being activated
- *
- * Channels with event associations will be triggered by their hardware
- * events, and channels without such associations will be triggered by
- * software.  (At this writing there is no interface for using software
- * triggers except with channels that don't support hardware triggers.)
- *
- * Returns zero on success, else negative errno.
- */
-int edma_start(struct edma *cc, unsigned channel)
-{
-	if (cc->id != EDMA_CTLR(channel)) {
-		dev_err(cc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
-			cc->id, EDMA_CTLR(channel));
-		return -EINVAL;
-	}
-	channel = EDMA_CHAN_SLOT(channel);
-
-	if (channel < cc->num_channels) {
-		int j = channel >> 5;
-		unsigned int mask = BIT(channel & 0x1f);
-
-		/* EDMA channels without event association */
-		if (test_bit(channel, cc->edma_unused)) {
-			pr_debug("EDMA: ESR%d %08x\n", j,
-				 edma_shadow0_read_array(cc, SH_ESR, j));
-			edma_shadow0_write_array(cc, SH_ESR, j, mask);
-			return 0;
-		}
-
-		/* EDMA channel with event association */
-		pr_debug("EDMA: ER%d %08x\n", j,
-			edma_shadow0_read_array(cc, SH_ER, j));
-		/* Clear any pending event or error */
-		edma_write_array(cc, EDMA_ECR, j, mask);
-		edma_write_array(cc, EDMA_EMCR, j, mask);
-		/* Clear any SER */
-		edma_shadow0_write_array(cc, SH_SECR, j, mask);
-		edma_shadow0_write_array(cc, SH_EESR, j, mask);
-		pr_debug("EDMA: EER%d %08x\n", j,
-			 edma_shadow0_read_array(cc, SH_EER, j));
-		return 0;
-	}
-
-	return -EINVAL;
-}
-EXPORT_SYMBOL(edma_start);
-
-/**
- * edma_stop - stops dma on the channel passed
- * @channel: channel being deactivated
- *
- * When @lch is a channel, any active transfer is paused and
- * all pending hardware events are cleared.  The current transfer
- * may not be resumed, and the channel's Parameter RAM should be
- * reinitialized before being reused.
- */
-void edma_stop(struct edma *cc, unsigned channel)
-{
-	if (cc->id != EDMA_CTLR(channel)) {
-		dev_err(cc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
-			cc->id, EDMA_CTLR(channel));
-		return;
-	}
-	channel = EDMA_CHAN_SLOT(channel);
-
-	if (channel < cc->num_channels) {
-		int j = channel >> 5;
-		unsigned int mask = BIT(channel & 0x1f);
-
-		edma_shadow0_write_array(cc, SH_EECR, j, mask);
-		edma_shadow0_write_array(cc, SH_ECR, j, mask);
-		edma_shadow0_write_array(cc, SH_SECR, j, mask);
-		edma_write_array(cc, EDMA_EMCR, j, mask);
-
-		/* clear possibly pending completion interrupt */
-		edma_shadow0_write_array(cc, SH_ICR, j, mask);
-
-		pr_debug("EDMA: EER%d %08x\n", j,
-			 edma_shadow0_read_array(cc, SH_EER, j));
-
-		/* REVISIT:  consider guarding against inappropriate event
-		 * chaining by overwriting with dummy_paramset.
-		 */
-	}
-}
-EXPORT_SYMBOL(edma_stop);
-
-/******************************************************************************
- *
- * It cleans ParamEntry qand bring back EDMA to initial state if media has
- * been removed before EDMA has finished.It is usedful for removable media.
- * Arguments:
- *      ch_no     - channel no
- *
- * Return: zero on success, or corresponding error no on failure
- *
- * FIXME this should not be needed ... edma_stop() should suffice.
- *
- *****************************************************************************/
-
-void edma_clean_channel(struct edma *cc, unsigned channel)
-{
-	if (cc->id != EDMA_CTLR(channel)) {
-		dev_err(cc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
-			cc->id, EDMA_CTLR(channel));
-		return;
-	}
-	channel = EDMA_CHAN_SLOT(channel);
-
-	if (channel < cc->num_channels) {
-		int j = (channel >> 5);
-		unsigned int mask = BIT(channel & 0x1f);
-
-		pr_debug("EDMA: EMR%d %08x\n", j,
-			 edma_read_array(cc, EDMA_EMR, j));
-		edma_shadow0_write_array(cc, SH_ECR, j, mask);
-		/* Clear the corresponding EMR bits */
-		edma_write_array(cc, EDMA_EMCR, j, mask);
-		/* Clear any SER */
-		edma_shadow0_write_array(cc, SH_SECR, j, mask);
-		edma_write(cc, EDMA_CCERRCLR, BIT(16) | BIT(1) | BIT(0));
-	}
-}
-EXPORT_SYMBOL(edma_clean_channel);
-
-/*
- * edma_assign_channel_eventq - move given channel to desired eventq
- * Arguments:
- *	channel - channel number
- *	eventq_no - queue to move the channel
- *
- * Can be used to move a channel to a selected event queue.
- */
-void edma_assign_channel_eventq(struct edma *cc, unsigned channel,
-				enum dma_event_q eventq_no)
-{
-	if (cc->id != EDMA_CTLR(channel)) {
-		dev_err(cc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
-			cc->id, EDMA_CTLR(channel));
-		return;
-	}
-	channel = EDMA_CHAN_SLOT(channel);
-
-	if (channel >= cc->num_channels)
-		return;
-
-	/* default to low priority queue */
-	if (eventq_no == EVENTQ_DEFAULT)
-		eventq_no = cc->default_queue;
-	if (eventq_no >= cc->num_tc)
-		return;
-
-	map_dmach_queue(cc, channel, eventq_no);
-}
-EXPORT_SYMBOL(edma_assign_channel_eventq);
-
-struct edma *edma_get_data(struct device *edma_dev)
-{
-	return dev_get_drvdata(edma_dev);
-}
-
-
-static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
-			      struct edma *edma_cc, int cc_id)
-{
-	int i;
-	u32 value, cccfg;
-	s8 (*queue_priority_map)[2];
-
-	/* Decode the eDMA3 configuration from CCCFG register */
-	cccfg = edma_read(edma_cc, EDMA_CCCFG);
-
-	value = GET_NUM_REGN(cccfg);
-	edma_cc->num_region = BIT(value);
-
-	value = GET_NUM_DMACH(cccfg);
-	edma_cc->num_channels = BIT(value + 1);
-
-	value = GET_NUM_PAENTRY(cccfg);
-	edma_cc->num_slots = BIT(value + 4);
-
-	value = GET_NUM_EVQUE(cccfg);
-	edma_cc->num_tc = value + 1;
-
-	dev_dbg(dev, "eDMA3 CC%d HW configuration (cccfg: 0x%08x):\n", cc_id,
-		cccfg);
-	dev_dbg(dev, "num_region: %u\n", edma_cc->num_region);
-	dev_dbg(dev, "num_channel: %u\n", edma_cc->num_channels);
-	dev_dbg(dev, "num_slot: %u\n", edma_cc->num_slots);
-	dev_dbg(dev, "num_tc: %u\n", edma_cc->num_tc);
-
-	/* Nothing need to be done if queue priority is provided */
-	if (pdata->queue_priority_mapping)
-		return 0;
-
-	/*
-	 * Configure TC/queue priority as follows:
-	 * Q0 - priority 0
-	 * Q1 - priority 1
-	 * Q2 - priority 2
-	 * ...
-	 * The meaning of priority numbers: 0 highest priority, 7 lowest
-	 * priority. So Q0 is the highest priority queue and the last queue has
-	 * the lowest priority.
-	 */
-	queue_priority_map = devm_kzalloc(dev,
-					  (edma_cc->num_tc + 1) * sizeof(s8),
-					  GFP_KERNEL);
-	if (!queue_priority_map)
-		return -ENOMEM;
-
-	for (i = 0; i < edma_cc->num_tc; i++) {
-		queue_priority_map[i][0] = i;
-		queue_priority_map[i][1] = i;
-	}
-	queue_priority_map[i][0] = -1;
-	queue_priority_map[i][1] = -1;
-
-	pdata->queue_priority_mapping = queue_priority_map;
-	/* Default queue has the lowest priority */
-	pdata->default_queue = i - 1;
-
-	return 0;
-}
-
-#if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_DMADEVICES)
-
-static int edma_xbar_event_map(struct device *dev, struct device_node *node,
-			       struct edma_soc_info *pdata, size_t sz)
-{
-	const char pname[] = "ti,edma-xbar-event-map";
-	struct resource res;
-	void __iomem *xbar;
-	s16 (*xbar_chans)[2];
-	size_t nelm = sz / sizeof(s16);
-	u32 shift, offset, mux;
-	int ret, i;
-
-	xbar_chans = devm_kzalloc(dev, (nelm + 2) * sizeof(s16), GFP_KERNEL);
-	if (!xbar_chans)
-		return -ENOMEM;
-
-	ret = of_address_to_resource(node, 1, &res);
-	if (ret)
-		return -ENOMEM;
-
-	xbar = devm_ioremap(dev, res.start, resource_size(&res));
-	if (!xbar)
-		return -ENOMEM;
-
-	ret = of_property_read_u16_array(node, pname, (u16 *)xbar_chans, nelm);
-	if (ret)
-		return -EIO;
-
-	/* Invalidate last entry for the other user of this mess */
-	nelm >>= 1;
-	xbar_chans[nelm][0] = xbar_chans[nelm][1] = -1;
-
-	for (i = 0; i < nelm; i++) {
-		shift = (xbar_chans[i][1] & 0x03) << 3;
-		offset = xbar_chans[i][1] & 0xfffffffc;
-		mux = readl(xbar + offset);
-		mux &= ~(0xff << shift);
-		mux |= xbar_chans[i][0] << shift;
-		writel(mux, (xbar + offset));
-	}
-
-	pdata->xbar_chans = (const s16 (*)[2]) xbar_chans;
-	return 0;
-}
-
-static int edma_of_parse_dt(struct device *dev,
-			    struct device_node *node,
-			    struct edma_soc_info *pdata)
-{
-	int ret = 0;
-	struct property *prop;
-	size_t sz;
-	struct edma_rsv_info *rsv_info;
-
-	rsv_info = devm_kzalloc(dev, sizeof(struct edma_rsv_info), GFP_KERNEL);
-	if (!rsv_info)
-		return -ENOMEM;
-	pdata->rsv = rsv_info;
-
-	prop = of_find_property(node, "ti,edma-xbar-event-map", &sz);
-	if (prop)
-		ret = edma_xbar_event_map(dev, node, pdata, sz);
-
-	return ret;
-}
-
-static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev,
-						      struct device_node *node)
-{
-	struct edma_soc_info *info;
-	int ret;
-
-	info = devm_kzalloc(dev, sizeof(struct edma_soc_info), GFP_KERNEL);
-	if (!info)
-		return ERR_PTR(-ENOMEM);
-
-	ret = edma_of_parse_dt(dev, node, info);
-	if (ret)
-		return ERR_PTR(ret);
-
-	return info;
-}
-#else
-static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev,
-						      struct device_node *node)
-{
-	return ERR_PTR(-ENOSYS);
-}
-#endif
-
-static int edma_probe(struct platform_device *pdev)
-{
-	struct edma_soc_info	*info = pdev->dev.platform_data;
-	s8		(*queue_priority_mapping)[2];
-	int			i, off, ln;
-	const s16		(*rsv_chans)[2];
-	const s16		(*rsv_slots)[2];
-	const s16		(*xbar_chans)[2];
-	int			irq;
-	char			*irq_name;
-	struct resource		*mem;
-	struct device_node	*node = pdev->dev.of_node;
-	struct device		*dev = &pdev->dev;
-	int			dev_id = pdev->id;
-	struct edma		*cc;
-	int			ret;
-	struct platform_device_info edma_dev_info = {
-		.name = "edma-dma-engine",
-		.dma_mask = DMA_BIT_MASK(32),
-		.parent = &pdev->dev,
-	};
-
-	if (node) {
-		info = edma_setup_info_from_dt(dev, node);
-		if (IS_ERR(info)) {
-			dev_err(dev, "failed to get DT data\n");
-			return PTR_ERR(info);
-		}
-	}
-
-	if (!info)
-		return -ENODEV;
-
-	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0) {
-		dev_err(dev, "pm_runtime_get_sync() failed\n");
-		return ret;
-	}
-
-	mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "edma3_cc");
-	if (!mem) {
-		dev_dbg(dev, "mem resource not found, using index 0\n");
-		mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		if (!mem) {
-			dev_err(dev, "no mem resource?\n");
-			return -ENODEV;
-		}
-	}
-
-	cc = devm_kzalloc(dev, sizeof(struct edma), GFP_KERNEL);
-	if (!cc)
-		return -ENOMEM;
-
-	cc->dev = dev;
-	cc->id = dev_id;
-	/* When booting with DT the pdev->id is -1 */
-	if (dev_id < 0) {
-		cc->id = 0;
-		dev_id = arch_num_cc;
-	}
-	dev_set_drvdata(dev, cc);
-
-	cc->base = devm_ioremap_resource(dev, mem);
-	if (IS_ERR(cc->base))
-		return PTR_ERR(cc->base);
-
-	/* Get eDMA3 configuration from IP */
-	ret = edma_setup_from_hw(dev, info, cc, dev_id);
-	if (ret)
-		return ret;
-
-	cc->default_queue = info->default_queue;
-
-	for (i = 0; i < cc->num_slots; i++)
-		memcpy_toio(cc->base + PARM_OFFSET(i), &dummy_paramset,
-			    PARM_SIZE);
-
-	/* Mark all channels as unused */
-	memset(cc->edma_unused, 0xff, sizeof(cc->edma_unused));
-
-	if (info->rsv) {
-
-		/* Clear the reserved channels in unused list */
-		rsv_chans = info->rsv->rsv_chans;
-		if (rsv_chans) {
-			for (i = 0; rsv_chans[i][0] != -1; i++) {
-				off = rsv_chans[i][0];
-				ln = rsv_chans[i][1];
-				clear_bits(off, ln, cc->edma_unused);
-			}
-		}
-
-		/* Set the reserved slots in inuse list */
-		rsv_slots = info->rsv->rsv_slots;
-		if (rsv_slots) {
-			for (i = 0; rsv_slots[i][0] != -1; i++) {
-				off = rsv_slots[i][0];
-				ln = rsv_slots[i][1];
-				set_bits(off, ln, cc->edma_inuse);
-			}
-		}
-	}
-
-	/* Clear the xbar mapped channels in unused list */
-	xbar_chans = info->xbar_chans;
-	if (xbar_chans) {
-		for (i = 0; xbar_chans[i][1] != -1; i++) {
-			off = xbar_chans[i][1];
-			clear_bits(off, 1, cc->edma_unused);
-		}
-	}
-
-	irq = platform_get_irq_byname(pdev, "edma3_ccint");
-	if (irq < 0 && node)
-		irq = irq_of_parse_and_map(node, 0);
-
-	if (irq >= 0) {
-		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccint",
-					  dev_name(dev));
-		ret = devm_request_irq(dev, irq, dma_irq_handler, 0, irq_name,
-				       cc);
-		if (ret) {
-			dev_err(dev, "CCINT (%d) failed --> %d\n", irq, ret);
-			return ret;
-		}
-	}
-
-	irq = platform_get_irq_byname(pdev, "edma3_ccerrint");
-	if (irq < 0 && node)
-		irq = irq_of_parse_and_map(node, 2);
-
-	if (irq >= 0) {
-		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccerrint",
-					  dev_name(dev));
-		ret = devm_request_irq(dev, irq, dma_ccerr_handler, 0, irq_name,
-				       cc);
-		if (ret) {
-			dev_err(dev, "CCERRINT (%d) failed --> %d\n", irq, ret);
-			return ret;
-		}
-	}
-
-	for (i = 0; i < cc->num_channels; i++)
-		map_dmach_queue(cc, i, info->default_queue);
-
-	queue_priority_mapping = info->queue_priority_mapping;
-
-	/* Event queue priority mapping */
-	for (i = 0; queue_priority_mapping[i][0] != -1; i++)
-		assign_priority_to_queue(cc, queue_priority_mapping[i][0],
-					 queue_priority_mapping[i][1]);
-
-	/* Map the channel to param entry if channel mapping logic exist */
-	if (edma_read(cc, EDMA_CCCFG) & CHMAP_EXIST)
-		map_dmach_param(cc);
-
-	for (i = 0; i < cc->num_region; i++) {
-		edma_write_array2(cc, EDMA_DRAE, i, 0, 0x0);
-		edma_write_array2(cc, EDMA_DRAE, i, 1, 0x0);
-		edma_write_array(cc, EDMA_QRAE, i, 0x0);
-	}
-	cc->info = info;
-	arch_num_cc++;
-
-	edma_dev_info.id = dev_id;
-
-	platform_device_register_full(&edma_dev_info);
-
-	return 0;
-}
-
-#ifdef CONFIG_PM_SLEEP
-static int edma_pm_resume(struct device *dev)
-{
-	struct edma *cc = dev_get_drvdata(dev);
-	int i;
-	s8 (*queue_priority_mapping)[2];
-
-	queue_priority_mapping = cc->info->queue_priority_mapping;
-
-	/* Event queue priority mapping */
-	for (i = 0; queue_priority_mapping[i][0] != -1; i++)
-		assign_priority_to_queue(cc, queue_priority_mapping[i][0],
-					 queue_priority_mapping[i][1]);
-
-	/* Map the channel to param entry if channel mapping logic */
-	if (edma_read(cc, EDMA_CCCFG) & CHMAP_EXIST)
-		map_dmach_param(cc);
-
-	for (i = 0; i < cc->num_channels; i++) {
-		if (test_bit(i, cc->edma_inuse)) {
-			/* ensure access through shadow region 0 */
-			edma_or_array2(cc, EDMA_DRAE, 0, i >> 5, BIT(i & 0x1f));
-
-			setup_dma_interrupt(cc, EDMA_CTLR_CHAN(cc->id, i),
-					    cc->intr_data[i].callback,
-					    cc->intr_data[i].data);
-		}
-	}
-
-	return 0;
-}
-#endif
-
-static const struct dev_pm_ops edma_pm_ops = {
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(NULL, edma_pm_resume)
-};
-
-static struct platform_driver edma_driver = {
-	.driver = {
-		.name	= "edma",
-		.pm	= &edma_pm_ops,
-		.of_match_table = edma_of_ids,
-	},
-	.probe = edma_probe,
-};
-
-static int __init edma_init(void)
-{
-	return platform_driver_probe(&edma_driver, edma_probe);
-}
-arch_initcall(edma_init);
-
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 9f7d266faa0c..28c90bc372bd 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -216,6 +216,7 @@ static struct resource da850_edma1_resources[] = {
 static const struct platform_device_info da8xx_edma0_device __initconst = {
 	.name		= "edma",
 	.id		= 0,
+	.dma_mask	= DMA_BIT_MASK(32),
 	.res		= da8xx_edma0_resources,
 	.num_res	= ARRAY_SIZE(da8xx_edma0_resources),
 	.data		= &da8xx_edma0_pdata,
@@ -225,6 +226,7 @@ static const struct platform_device_info da8xx_edma0_device __initconst = {
 static const struct platform_device_info da850_edma1_device __initconst = {
 	.name		= "edma",
 	.id		= 1,
+	.dma_mask	= DMA_BIT_MASK(32),
 	.res		= da850_edma1_resources,
 	.num_res	= ARRAY_SIZE(da850_edma1_resources),
 	.data		= &da850_edma1_pdata,
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 5f10c6695e31..609950b8c191 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -616,6 +616,7 @@ static struct resource edma_resources[] = {
 static const struct platform_device_info dm355_edma_device __initconst = {
 	.name		= "edma",
 	.id		= 0,
+	.dma_mask	= DMA_BIT_MASK(32),
 	.res		= edma_resources,
 	.num_res	= ARRAY_SIZE(edma_resources),
 	.data		= &dm355_edma_pdata,
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index aa3453b40d5f..d38f5049d56e 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -545,6 +545,7 @@ static struct resource edma_resources[] = {
 static const struct platform_device_info dm644x_edma_device __initconst = {
 	.name		= "edma",
 	.id		= 0,
+	.dma_mask	= DMA_BIT_MASK(32),
 	.res		= edma_resources,
 	.num_res	= ARRAY_SIZE(edma_resources),
 	.data		= &dm644x_edma_pdata,
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 79c1d8917dd3..70eb42725eec 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -592,6 +592,7 @@ static struct resource edma_resources[] = {
 static const struct platform_device_info dm646x_edma_device __initconst = {
 	.name		= "edma",
 	.id		= 0,
+	.dma_mask	= DMA_BIT_MASK(32),
 	.res		= edma_resources,
 	.num_res	= ARRAY_SIZE(edma_resources),
 	.data		= &dm646x_edma_pdata,
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b3a0dff67e3f..4bef66b4325b 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -94,7 +94,6 @@ config ARCH_OMAP2PLUS
 	select OMAP_GPMC
 	select PINCTRL
 	select SOC_BUS
-	select TI_PRIV_EDMA
 	select OMAP_IRQCHIP
 	help
 	  Systems based on OMAP2, OMAP3, OMAP4 or OMAP5
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index b4584757dae0..992efc8e465e 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -486,7 +486,6 @@ config TI_EDMA
 	depends on ARCH_DAVINCI || ARCH_OMAP || ARCH_KEYSTONE
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
-	select TI_PRIV_EDMA
 	default n
 	help
 	  Enable support for the TI EDMA controller. This DMA
diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index fc91ab9dd1bb..f31c463f94bd 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -26,12 +26,92 @@
 #include <linux/spinlock.h>
 #include <linux/of.h>
 #include <linux/of_dma.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/platform_data/edma.h>
 
 #include "dmaengine.h"
 #include "virt-dma.h"
 
+/* Offsets matching "struct edmacc_param" */
+#define PARM_OPT		0x00
+#define PARM_SRC		0x04
+#define PARM_A_B_CNT		0x08
+#define PARM_DST		0x0c
+#define PARM_SRC_DST_BIDX	0x10
+#define PARM_LINK_BCNTRLD	0x14
+#define PARM_SRC_DST_CIDX	0x18
+#define PARM_CCNT		0x1c
+
+#define PARM_SIZE		0x20
+
+/* Offsets for EDMA CC global channel registers and their shadows */
+#define SH_ER			0x00	/* 64 bits */
+#define SH_ECR			0x08	/* 64 bits */
+#define SH_ESR			0x10	/* 64 bits */
+#define SH_CER			0x18	/* 64 bits */
+#define SH_EER			0x20	/* 64 bits */
+#define SH_EECR			0x28	/* 64 bits */
+#define SH_EESR			0x30	/* 64 bits */
+#define SH_SER			0x38	/* 64 bits */
+#define SH_SECR			0x40	/* 64 bits */
+#define SH_IER			0x50	/* 64 bits */
+#define SH_IECR			0x58	/* 64 bits */
+#define SH_IESR			0x60	/* 64 bits */
+#define SH_IPR			0x68	/* 64 bits */
+#define SH_ICR			0x70	/* 64 bits */
+#define SH_IEVAL		0x78
+#define SH_QER			0x80
+#define SH_QEER			0x84
+#define SH_QEECR		0x88
+#define SH_QEESR		0x8c
+#define SH_QSER			0x90
+#define SH_QSECR		0x94
+#define SH_SIZE			0x200
+
+/* Offsets for EDMA CC global registers */
+#define EDMA_REV		0x0000
+#define EDMA_CCCFG		0x0004
+#define EDMA_QCHMAP		0x0200	/* 8 registers */
+#define EDMA_DMAQNUM		0x0240	/* 8 registers (4 on OMAP-L1xx) */
+#define EDMA_QDMAQNUM		0x0260
+#define EDMA_QUETCMAP		0x0280
+#define EDMA_QUEPRI		0x0284
+#define EDMA_EMR		0x0300	/* 64 bits */
+#define EDMA_EMCR		0x0308	/* 64 bits */
+#define EDMA_QEMR		0x0310
+#define EDMA_QEMCR		0x0314
+#define EDMA_CCERR		0x0318
+#define EDMA_CCERRCLR		0x031c
+#define EDMA_EEVAL		0x0320
+#define EDMA_DRAE		0x0340	/* 4 x 64 bits*/
+#define EDMA_QRAE		0x0380	/* 4 registers */
+#define EDMA_QUEEVTENTRY	0x0400	/* 2 x 16 registers */
+#define EDMA_QSTAT		0x0600	/* 2 registers */
+#define EDMA_QWMTHRA		0x0620
+#define EDMA_QWMTHRB		0x0624
+#define EDMA_CCSTAT		0x0640
+
+#define EDMA_M			0x1000	/* global channel registers */
+#define EDMA_ECR		0x1008
+#define EDMA_ECRH		0x100C
+#define EDMA_SHADOW0		0x2000	/* 4 regions shadowing global channels */
+#define EDMA_PARM		0x4000	/* 128 param entries */
+
+#define PARM_OFFSET(param_no)	(EDMA_PARM + ((param_no) << 5))
+
+#define EDMA_DCHMAP		0x0100  /* 64 registers */
+
+/* CCCFG register */
+#define GET_NUM_DMACH(x)	(x & 0x7) /* bits 0-2 */
+#define GET_NUM_PAENTRY(x)	((x & 0x7000) >> 12) /* bits 12-14 */
+#define GET_NUM_EVQUE(x)	((x & 0x70000) >> 16) /* bits 16-18 */
+#define GET_NUM_REGN(x)		((x & 0x300000) >> 20) /* bits 20-21 */
+#define CHMAP_EXIST		BIT(24)
+
 /*
  * This will go away when the private EDMA API is folded
  * into this driver and the platform device(s) are
@@ -60,6 +140,47 @@
 #define EDMA_MAX_SLOTS		MAX_NR_SG
 #define EDMA_DESCRIPTORS	16
 
+#define EDMA_MAX_PARAMENTRY     512
+
+#define EDMA_CHANNEL_ANY		-1	/* for edma_alloc_channel() */
+#define EDMA_SLOT_ANY			-1	/* for edma_alloc_slot() */
+#define EDMA_CONT_PARAMS_ANY		 1001
+#define EDMA_CONT_PARAMS_FIXED_EXACT	 1002
+#define EDMA_CONT_PARAMS_FIXED_NOT_EXACT 1003
+
+#define EDMA_MAX_CC               2
+
+/* PaRAM slots are laid out like this */
+struct edmacc_param {
+	u32 opt;
+	u32 src;
+	u32 a_b_cnt;
+	u32 dst;
+	u32 src_dst_bidx;
+	u32 link_bcntrld;
+	u32 src_dst_cidx;
+	u32 ccnt;
+} __packed;
+
+/* fields in edmacc_param.opt */
+#define SAM		BIT(0)
+#define DAM		BIT(1)
+#define SYNCDIM		BIT(2)
+#define STATIC		BIT(3)
+#define EDMA_FWID	(0x07 << 8)
+#define TCCMODE		BIT(11)
+#define EDMA_TCC(t)	((t) << 12)
+#define TCINTEN		BIT(20)
+#define ITCINTEN	BIT(21)
+#define TCCHEN		BIT(22)
+#define ITCCHEN		BIT(23)
+
+/*ch_status paramater of callback function possible values*/
+#define EDMA_DMA_COMPLETE 1
+#define EDMA_DMA_CC_ERROR 2
+#define EDMA_DMA_TC1_ERROR 3
+#define EDMA_DMA_TC2_ERROR 4
+
 struct edma_pset {
 	u32				len;
 	dma_addr_t			addr;
@@ -119,14 +240,905 @@ struct edma_chan {
 };
 
 struct edma_cc {
-	struct edma			*cc;
-	int				ctlr;
+	struct device			*dev;
+	struct edma_soc_info 		*info;
+	void __iomem			*base;
+	int				id;
+
+	/* eDMA3 resource information */
+	unsigned			num_channels;
+	unsigned			num_region;
+	unsigned			num_slots;
+	unsigned			num_tc;
+	enum dma_event_q 		default_queue;
+
+	bool				unused_chan_list_done;
+	/* The edma_inuse bit for each PaRAM slot is clear unless the
+	 * channel is in use ... by ARM or DSP, for QDMA, or whatever.
+	 */
+	DECLARE_BITMAP(edma_inuse, EDMA_MAX_PARAMENTRY);
+
+	/* The edma_unused bit for each channel is clear unless
+	 * it is not being used on this platform. It uses a bit
+	 * of SOC-specific initialization code.
+	 */
+	DECLARE_BITMAP(edma_unused, EDMA_CHANS);
+
+	struct dma_interrupt_data {
+		void (*callback)(unsigned channel, unsigned short ch_status,
+				void *data);
+		void *data;
+	} intr_data[EDMA_CHANS];
+
 	struct dma_device		dma_slave;
 	struct edma_chan		slave_chans[EDMA_CHANS];
-	int				num_slave_chans;
 	int				dummy_slot;
 };
 
+/* dummy param set used to (re)initialize parameter RAM slots */
+static const struct edmacc_param dummy_paramset = {
+	.link_bcntrld = 0xffff,
+	.ccnt = 1,
+};
+
+static const struct of_device_id edma_of_ids[] = {
+	{ .compatible = "ti,edma3", },
+	{}
+};
+
+static inline unsigned int edma_read(struct edma_cc *ecc, int offset)
+{
+	return (unsigned int)__raw_readl(ecc->base + offset);
+}
+
+static inline void edma_write(struct edma_cc *ecc, int offset, int val)
+{
+	__raw_writel(val, ecc->base + offset);
+}
+static inline void edma_modify(struct edma_cc *ecc, int offset, unsigned and,
+			       unsigned or)
+{
+	unsigned val = edma_read(ecc, offset);
+	val &= and;
+	val |= or;
+	edma_write(ecc, offset, val);
+}
+static inline void edma_and(struct edma_cc *ecc, int offset, unsigned and)
+{
+	unsigned val = edma_read(ecc, offset);
+	val &= and;
+	edma_write(ecc, offset, val);
+}
+static inline void edma_or(struct edma_cc *ecc, int offset, unsigned or)
+{
+	unsigned val = edma_read(ecc, offset);
+	val |= or;
+	edma_write(ecc, offset, val);
+}
+static inline unsigned int edma_read_array(struct edma_cc *ecc, int offset, int i)
+{
+	return edma_read(ecc, offset + (i << 2));
+}
+static inline void edma_write_array(struct edma_cc *ecc, int offset, int i,
+		unsigned val)
+{
+	edma_write(ecc, offset + (i << 2), val);
+}
+static inline void edma_modify_array(struct edma_cc *ecc, int offset, int i,
+		unsigned and, unsigned or)
+{
+	edma_modify(ecc, offset + (i << 2), and, or);
+}
+static inline void edma_or_array(struct edma_cc *ecc, int offset, int i, unsigned or)
+{
+	edma_or(ecc, offset + (i << 2), or);
+}
+static inline void edma_or_array2(struct edma_cc *ecc, int offset, int i, int j,
+		unsigned or)
+{
+	edma_or(ecc, offset + ((i*2 + j) << 2), or);
+}
+static inline void edma_write_array2(struct edma_cc *ecc, int offset, int i, int j,
+		unsigned val)
+{
+	edma_write(ecc, offset + ((i*2 + j) << 2), val);
+}
+static inline unsigned int edma_shadow0_read(struct edma_cc *ecc, int offset)
+{
+	return edma_read(ecc, EDMA_SHADOW0 + offset);
+}
+static inline unsigned int edma_shadow0_read_array(struct edma_cc *ecc, int offset,
+		int i)
+{
+	return edma_read(ecc, EDMA_SHADOW0 + offset + (i << 2));
+}
+static inline void edma_shadow0_write(struct edma_cc *ecc, int offset, unsigned val)
+{
+	edma_write(ecc, EDMA_SHADOW0 + offset, val);
+}
+static inline void edma_shadow0_write_array(struct edma_cc *ecc, int offset, int i,
+		unsigned val)
+{
+	edma_write(ecc, EDMA_SHADOW0 + offset + (i << 2), val);
+}
+static inline unsigned int edma_parm_read(struct edma_cc *ecc, int offset,
+		int param_no)
+{
+	return edma_read(ecc, EDMA_PARM + offset + (param_no << 5));
+}
+static inline void edma_parm_write(struct edma_cc *ecc, int offset, int param_no,
+		unsigned val)
+{
+	edma_write(ecc, EDMA_PARM + offset + (param_no << 5), val);
+}
+static inline void edma_parm_modify(struct edma_cc *ecc, int offset, int param_no,
+		unsigned and, unsigned or)
+{
+	edma_modify(ecc, EDMA_PARM + offset + (param_no << 5), and, or);
+}
+static inline void edma_parm_and(struct edma_cc *ecc, int offset, int param_no,
+		unsigned and)
+{
+	edma_and(ecc, EDMA_PARM + offset + (param_no << 5), and);
+}
+static inline void edma_parm_or(struct edma_cc *ecc, int offset, int param_no,
+		unsigned or)
+{
+	edma_or(ecc, EDMA_PARM + offset + (param_no << 5), or);
+}
+
+static inline void set_bits(int offset, int len, unsigned long *p)
+{
+	for (; len > 0; len--)
+		set_bit(offset + (len - 1), p);
+}
+
+static inline void clear_bits(int offset, int len, unsigned long *p)
+{
+	for (; len > 0; len--)
+		clear_bit(offset + (len - 1), p);
+}
+
+static void edma_map_dmach_to_queue(struct edma_cc *ecc, unsigned ch_no,
+				    enum dma_event_q queue_no)
+{
+	int bit = (ch_no & 0x7) * 4;
+
+	/* default to low priority queue */
+	if (queue_no == EVENTQ_DEFAULT)
+		queue_no = ecc->default_queue;
+
+	queue_no &= 7;
+	edma_modify_array(ecc, EDMA_DMAQNUM, (ch_no >> 3),
+			  ~(0x7 << bit), queue_no << bit);
+}
+
+static void edma_assign_priority_to_queue(struct edma_cc *ecc, int queue_no,
+					  int priority)
+{
+	int bit = queue_no * 4;
+	edma_modify(ecc, EDMA_QUEPRI, ~(0x7 << bit), ((priority & 0x7) << bit));
+}
+
+static void edma_direct_dmach_to_param_mapping(struct edma_cc *ecc)
+{
+	int i;
+	for (i = 0; i < ecc->num_channels; i++)
+		edma_write_array(ecc, EDMA_DCHMAP , i , (i << 5));
+}
+
+static int prepare_unused_channel_list(struct device *dev, void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct edma_cc *ecc = data;
+	int i, count;
+	struct of_phandle_args  dma_spec;
+
+	if (dev->of_node) {
+		struct platform_device *dma_pdev;
+
+		count = of_property_count_strings(dev->of_node, "dma-names");
+		if (count < 0)
+			return 0;
+		for (i = 0; i < count; i++) {
+
+			if (of_parse_phandle_with_args(dev->of_node, "dmas",
+						       "#dma-cells", i,
+						       &dma_spec))
+				continue;
+
+			if (!of_match_node(edma_of_ids, dma_spec.np)) {
+				of_node_put(dma_spec.np);
+				continue;
+			}
+
+			dma_pdev = of_find_device_by_node(dma_spec.np);
+			if (&dma_pdev->dev != ecc->dev)
+				continue;
+
+			clear_bit(EDMA_CHAN_SLOT(dma_spec.args[0]),
+				  ecc->edma_unused);
+			of_node_put(dma_spec.np);
+		}
+		return 0;
+	}
+
+	/* For non-OF case */
+	for (i = 0; i < pdev->num_resources; i++) {
+		struct resource	*res = &pdev->resource[i];
+
+		if ((res->flags & IORESOURCE_DMA) && (int)res->start >= 0) {
+			clear_bit(EDMA_CHAN_SLOT(pdev->resource[i].start),
+				  ecc->edma_unused);
+		}
+	}
+
+	return 0;
+}
+
+static void edma_setup_interrupt(struct edma_cc *ecc, unsigned lch,
+	void (*callback)(unsigned channel, u16 ch_status, void *data),
+	void *data)
+{
+	lch = EDMA_CHAN_SLOT(lch);
+
+	if (!callback)
+		edma_shadow0_write_array(ecc, SH_IECR, lch >> 5,
+					 BIT(lch & 0x1f));
+
+	ecc->intr_data[lch].callback = callback;
+	ecc->intr_data[lch].data = data;
+
+	if (callback) {
+		edma_shadow0_write_array(ecc, SH_ICR, lch >> 5,
+					 BIT(lch & 0x1f));
+		edma_shadow0_write_array(ecc, SH_IESR, lch >> 5,
+					 BIT(lch & 0x1f));
+	}
+}
+
+/*
+ * paRAM management functions
+ */
+
+/**
+ * edma_write_slot - write parameter RAM data for slot
+ * @ecc: pointer to edma_cc struct
+ * @slot: number of parameter RAM slot being modified
+ * @param: data to be written into parameter RAM slot
+ *
+ * Use this to assign all parameters of a transfer at once.  This
+ * allows more efficient setup of transfers than issuing multiple
+ * calls to set up those parameters in small pieces, and provides
+ * complete control over all transfer options.
+ */
+static void edma_write_slot(struct edma_cc *ecc, unsigned slot,
+			    const struct edmacc_param *param)
+{
+	slot = EDMA_CHAN_SLOT(slot);
+	if (slot >= ecc->num_slots)
+		return;
+	memcpy_toio(ecc->base + PARM_OFFSET(slot), param, PARM_SIZE);
+}
+
+/**
+ * edma_read_slot - read parameter RAM data from slot
+ * @ecc: pointer to edma_cc struct
+ * @slot: number of parameter RAM slot being copied
+ * @param: where to store copy of parameter RAM data
+ *
+ * Use this to read data from a parameter RAM slot, perhaps to
+ * save them as a template for later reuse.
+ */
+static void edma_read_slot(struct edma_cc *ecc, unsigned slot,
+			   struct edmacc_param *param)
+{
+	slot = EDMA_CHAN_SLOT(slot);
+	if (slot >= ecc->num_slots)
+		return;
+	memcpy_fromio(param, ecc->base + PARM_OFFSET(slot), PARM_SIZE);
+}
+
+/**
+ * edma_alloc_slot - allocate DMA parameter RAM
+ * @ecc: pointer to edma_cc struct
+ * @slot: specific slot to allocate; negative for "any unused slot"
+ *
+ * This allocates a parameter RAM slot, initializing it to hold a
+ * dummy transfer.  Slots allocated using this routine have not been
+ * mapped to a hardware DMA channel, and will normally be used by
+ * linking to them from a slot associated with a DMA channel.
+ *
+ * Normal use is to pass EDMA_SLOT_ANY as the @slot, but specific
+ * slots may be allocated on behalf of DSP firmware.
+ *
+ * Returns the number of the slot, else negative errno.
+ */
+static int edma_alloc_slot(struct edma_cc *ecc, int slot)
+{
+	if (slot > 0)
+		slot = EDMA_CHAN_SLOT(slot);
+	if (slot < 0) {
+		slot = ecc->num_channels;
+		for (;;) {
+			slot = find_next_zero_bit(ecc->edma_inuse,
+						  ecc->num_slots,
+						  slot);
+			if (slot == ecc->num_slots)
+				return -ENOMEM;
+			if (!test_and_set_bit(slot, ecc->edma_inuse))
+				break;
+		}
+	} else if (slot < ecc->num_channels || slot >= ecc->num_slots) {
+		return -EINVAL;
+	} else if (test_and_set_bit(slot, ecc->edma_inuse)) {
+		return -EBUSY;
+	}
+
+	edma_write_slot(ecc, slot, &dummy_paramset);
+
+	return EDMA_CTLR_CHAN(ecc->id, slot);
+}
+
+/**
+ * edma_free_slot - deallocate DMA parameter RAM
+ * @ecc: pointer to edma_cc struct
+ * @slot: parameter RAM slot returned from edma_alloc_slot()
+ *
+ * This deallocates the parameter RAM slot allocated by edma_alloc_slot().
+ * Callers are responsible for ensuring the slot is inactive, and will
+ * not be activated.
+ */
+static void edma_free_slot(struct edma_cc *ecc, unsigned slot)
+{
+
+	slot = EDMA_CHAN_SLOT(slot);
+	if (slot < ecc->num_channels || slot >= ecc->num_slots)
+		return;
+
+	edma_write_slot(ecc, slot, &dummy_paramset);
+	clear_bit(slot, ecc->edma_inuse);
+}
+
+/**
+ * edma_link - link one parameter RAM slot to another
+ * @ecc: pointer to edma_cc struct
+ * @from: parameter RAM slot originating the link
+ * @to: parameter RAM slot which is the link target
+ *
+ * The originating slot should not be part of any active DMA transfer.
+ */
+static void edma_link(struct edma_cc *ecc, unsigned from, unsigned to)
+{
+	from = EDMA_CHAN_SLOT(from);
+	to = EDMA_CHAN_SLOT(to);
+	if (from >= ecc->num_slots || to >= ecc->num_slots)
+		return;
+
+	edma_parm_modify(ecc, PARM_LINK_BCNTRLD, from, 0xffff0000,
+			 PARM_OFFSET(to));
+}
+
+/**
+ * edma_get_position - returns the current transfer point
+ * @ecc: pointer to edma_cc struct
+ * @slot: parameter RAM slot being examined
+ * @dst:  true selects the dest position, false the source
+ *
+ * Returns the position of the current active slot
+ */
+static dma_addr_t edma_get_position(struct edma_cc *ecc, unsigned slot,
+				    bool dst)
+{
+	u32 offs;
+
+	slot = EDMA_CHAN_SLOT(slot);
+	offs = PARM_OFFSET(slot);
+	offs += dst ? PARM_DST : PARM_SRC;
+
+	return edma_read(ecc, offs);
+}
+
+/*-----------------------------------------------------------------------*/
+/**
+ * edma_start - start dma on a channel
+ * @ecc: pointer to edma_cc struct
+ * @channel: channel being activated
+ *
+ * Channels with event associations will be triggered by their hardware
+ * events, and channels without such associations will be triggered by
+ * software.  (At this writing there is no interface for using software
+ * triggers except with channels that don't support hardware triggers.)
+ *
+ * Returns zero on success, else negative errno.
+ */
+static int edma_start(struct edma_cc *ecc, unsigned channel)
+{
+	if (ecc->id != EDMA_CTLR(channel)) {
+		dev_err(ecc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
+			ecc->id, EDMA_CTLR(channel));
+		return -EINVAL;
+	}
+	channel = EDMA_CHAN_SLOT(channel);
+
+	if (channel < ecc->num_channels) {
+		int j = channel >> 5;
+		unsigned int mask = BIT(channel & 0x1f);
+
+		/* EDMA channels without event association */
+		if (test_bit(channel, ecc->edma_unused)) {
+			pr_debug("EDMA: ESR%d %08x\n", j,
+				 edma_shadow0_read_array(ecc, SH_ESR, j));
+			edma_shadow0_write_array(ecc, SH_ESR, j, mask);
+			return 0;
+		}
+
+		/* EDMA channel with event association */
+		pr_debug("EDMA: ER%d %08x\n", j,
+			edma_shadow0_read_array(ecc, SH_ER, j));
+		/* Clear any pending event or error */
+		edma_write_array(ecc, EDMA_ECR, j, mask);
+		edma_write_array(ecc, EDMA_EMCR, j, mask);
+		/* Clear any SER */
+		edma_shadow0_write_array(ecc, SH_SECR, j, mask);
+		edma_shadow0_write_array(ecc, SH_EESR, j, mask);
+		pr_debug("EDMA: EER%d %08x\n", j,
+			 edma_shadow0_read_array(ecc, SH_EER, j));
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * edma_stop - stops dma on the channel passed
+ * @ecc: pointer to edma_cc struct
+ * @channel: channel being deactivated
+ *
+ * When @lch is a channel, any active transfer is paused and
+ * all pending hardware events are cleared.  The current transfer
+ * may not be resumed, and the channel's Parameter RAM should be
+ * reinitialized before being reused.
+ */
+static void edma_stop(struct edma_cc *ecc, unsigned channel)
+{
+	if (ecc->id != EDMA_CTLR(channel)) {
+		dev_err(ecc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
+			ecc->id, EDMA_CTLR(channel));
+		return;
+	}
+	channel = EDMA_CHAN_SLOT(channel);
+
+	if (channel < ecc->num_channels) {
+		int j = channel >> 5;
+		unsigned int mask = BIT(channel & 0x1f);
+
+		edma_shadow0_write_array(ecc, SH_EECR, j, mask);
+		edma_shadow0_write_array(ecc, SH_ECR, j, mask);
+		edma_shadow0_write_array(ecc, SH_SECR, j, mask);
+		edma_write_array(ecc, EDMA_EMCR, j, mask);
+
+		/* clear possibly pending completion interrupt */
+		edma_shadow0_write_array(ecc, SH_ICR, j, mask);
+
+		pr_debug("EDMA: EER%d %08x\n", j,
+			 edma_shadow0_read_array(ecc, SH_EER, j));
+
+		/* REVISIT:  consider guarding against inappropriate event
+		 * chaining by overwriting with dummy_paramset.
+		 */
+	}
+}
+
+/**
+ * edma_pause - pause dma on a channel
+ * @ecc: pointer to edma_cc struct
+ * @channel: on which edma_start() has been called
+ *
+ * This temporarily disables EDMA hardware events on the specified channel,
+ * preventing them from triggering new transfers on its behalf
+ */
+static void edma_pause(struct edma_cc *ecc, unsigned channel)
+{
+	if (ecc->id != EDMA_CTLR(channel)) {
+		dev_err(ecc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
+			ecc->id, EDMA_CTLR(channel));
+		return;
+	}
+	channel = EDMA_CHAN_SLOT(channel);
+
+	if (channel < ecc->num_channels) {
+		unsigned int mask = BIT(channel & 0x1f);
+
+		edma_shadow0_write_array(ecc, SH_EECR, channel >> 5, mask);
+	}
+}
+
+/**
+ * edma_resume - resumes dma on a paused channel
+ * @ecc: pointer to edma_cc struct
+ * @channel: on which edma_pause() has been called
+ *
+ * This re-enables EDMA hardware events on the specified channel.
+ */
+static void edma_resume(struct edma_cc *ecc, unsigned channel)
+{
+	if (ecc->id != EDMA_CTLR(channel)) {
+		dev_err(ecc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
+			ecc->id, EDMA_CTLR(channel));
+		return;
+	}
+	channel = EDMA_CHAN_SLOT(channel);
+
+	if (channel < ecc->num_channels) {
+		unsigned int mask = BIT(channel & 0x1f);
+
+		edma_shadow0_write_array(ecc, SH_EESR, channel >> 5, mask);
+	}
+}
+
+static int edma_trigger_channel(struct edma_cc *ecc, unsigned channel)
+{
+	unsigned int mask;
+
+	if (ecc->id != EDMA_CTLR(channel)) {
+		dev_err(ecc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
+			ecc->id, EDMA_CTLR(channel));
+		return -EINVAL;
+	}
+	channel = EDMA_CHAN_SLOT(channel);
+	mask = BIT(channel & 0x1f);
+
+	edma_shadow0_write_array(ecc, SH_ESR, (channel >> 5), mask);
+
+	pr_debug("EDMA: ESR%d %08x\n", (channel >> 5),
+		 edma_shadow0_read_array(ecc, SH_ESR, (channel >> 5)));
+	return 0;
+}
+
+/******************************************************************************
+ *
+ * It cleans ParamEntry qand bring back EDMA to initial state if media has
+ * been removed before EDMA has finished.It is usedful for removable media.
+ * Arguments:
+ *      ch_no     - channel no
+ *
+ * Return: zero on success, or corresponding error no on failure
+ *
+ * FIXME this should not be needed ... edma_stop() should suffice.
+ *
+ *****************************************************************************/
+
+static void edma_clean_channel(struct edma_cc *ecc, unsigned channel)
+{
+	if (ecc->id != EDMA_CTLR(channel)) {
+		dev_err(ecc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
+			ecc->id, EDMA_CTLR(channel));
+		return;
+	}
+	channel = EDMA_CHAN_SLOT(channel);
+
+	if (channel < ecc->num_channels) {
+		int j = (channel >> 5);
+		unsigned int mask = BIT(channel & 0x1f);
+
+		pr_debug("EDMA: EMR%d %08x\n", j,
+			 edma_read_array(ecc, EDMA_EMR, j));
+		edma_shadow0_write_array(ecc, SH_ECR, j, mask);
+		/* Clear the corresponding EMR bits */
+		edma_write_array(ecc, EDMA_EMCR, j, mask);
+		/* Clear any SER */
+		edma_shadow0_write_array(ecc, SH_SECR, j, mask);
+		edma_write(ecc, EDMA_CCERRCLR, BIT(16) | BIT(1) | BIT(0));
+	}
+}
+
+/**
+ * edma_alloc_channel - allocate DMA channel and paired parameter RAM
+ * @ecc: pointer to edma_cc struct
+ * @channel: specific channel to allocate; negative for "any unmapped channel"
+ * @callback: optional; to be issued on DMA completion or errors
+ * @data: passed to callback
+ * @eventq_no: an EVENTQ_* constant, used to choose which Transfer
+ *	Controller (TC) executes requests using this channel.  Use
+ *	EVENTQ_DEFAULT unless you really need a high priority queue.
+ *
+ * This allocates a DMA channel and its associated parameter RAM slot.
+ * The parameter RAM is initialized to hold a dummy transfer.
+ *
+ * Normal use is to pass a specific channel number as @channel, to make
+ * use of hardware events mapped to that channel.  When the channel will
+ * be used only for software triggering or event chaining, channels not
+ * mapped to hardware events (or mapped to unused events) are preferable.
+ *
+ * DMA transfers start from a channel using edma_start(), or by
+ * chaining.  When the transfer described in that channel's parameter RAM
+ * slot completes, that slot's data may be reloaded through a link.
+ *
+ * DMA errors are only reported to the @callback associated with the
+ * channel driving that transfer, but transfer completion callbacks can
+ * be sent to another channel under control of the TCC field in
+ * the option word of the transfer's parameter RAM set.  Drivers must not
+ * use DMA transfer completion callbacks for channels they did not allocate.
+ * (The same applies to TCC codes used in transfer chaining.)
+ *
+ * Returns the number of the channel, else negative errno.
+ */
+static int edma_alloc_channel(struct edma_cc *ecc, int channel,
+		void (*callback)(unsigned channel, u16 ch_status, void *data),
+		void *data,
+		enum dma_event_q eventq_no)
+{
+	unsigned done = 0;
+	int ret = 0;
+
+	if (!ecc->unused_chan_list_done) {
+		/*
+		 * Scan all the platform devices to find out the EDMA channels
+		 * used and clear them in the unused list, making the rest
+		 * available for ARM usage.
+		 */
+		ret = bus_for_each_dev(&platform_bus_type, NULL, ecc,
+				       prepare_unused_channel_list);
+		if (ret < 0)
+			return ret;
+
+		ecc->unused_chan_list_done = true;
+	}
+
+	if (channel >= 0) {
+		if (ecc->id != EDMA_CTLR(channel)) {
+			dev_err(ecc->dev, "%s: ID mismatch for eDMA%d: %d\n",
+				__func__, ecc->id, EDMA_CTLR(channel));
+			return -EINVAL;
+		}
+		channel = EDMA_CHAN_SLOT(channel);
+	}
+
+	if (channel < 0) {
+		channel = 0;
+		for (;;) {
+			channel = find_next_bit(ecc->edma_unused,
+						ecc->num_channels, channel);
+			if (channel == ecc->num_channels)
+				break;
+			if (!test_and_set_bit(channel, ecc->edma_inuse)) {
+				done = 1;
+				break;
+			}
+			channel++;
+		}
+		if (!done)
+			return -ENOMEM;
+	} else if (channel >= ecc->num_channels) {
+		return -EINVAL;
+	} else if (test_and_set_bit(channel, ecc->edma_inuse)) {
+		return -EBUSY;
+	}
+
+	/* ensure access through shadow region 0 */
+	edma_or_array2(ecc, EDMA_DRAE, 0, channel >> 5, BIT(channel & 0x1f));
+
+	/* ensure no events are pending */
+	edma_stop(ecc, EDMA_CTLR_CHAN(ecc->id, channel));
+	edma_write_slot(ecc, channel, &dummy_paramset);
+
+	if (callback)
+		edma_setup_interrupt(ecc, EDMA_CTLR_CHAN(ecc->id, channel),
+				     callback, data);
+
+	edma_map_dmach_to_queue(ecc, channel, eventq_no);
+
+	return EDMA_CTLR_CHAN(ecc->id, channel);
+}
+
+
+/**
+ * edma_free_channel - deallocate DMA channel
+ * @ecc: pointer to edma_cc struct
+ * @channel: dma channel returned from edma_alloc_channel()
+ *
+ * This deallocates the DMA channel and associated parameter RAM slot
+ * allocated by edma_alloc_channel().
+ *
+ * Callers are responsible for ensuring the channel is inactive, and
+ * will not be reactivated by linking, chaining, or software calls to
+ * edma_start().
+ */
+static void edma_free_channel(struct edma_cc *ecc, unsigned channel)
+{
+
+	if (ecc->id != EDMA_CTLR(channel)) {
+		dev_err(ecc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
+			ecc->id, EDMA_CTLR(channel));
+		return;
+	}
+	channel = EDMA_CHAN_SLOT(channel);
+
+	if (channel >= ecc->num_channels)
+		return;
+
+	edma_setup_interrupt(ecc, channel, NULL, NULL);
+	/* REVISIT should probably take out of shadow region 0 */
+
+	memcpy_toio(ecc->base + PARM_OFFSET(channel), &dummy_paramset,
+		    PARM_SIZE);
+	clear_bit(channel, ecc->edma_inuse);
+}
+
+/*
+ * edma_assign_channel_eventq - move given channel to desired eventq
+ * Arguments:
+ *	channel - channel number
+ *	eventq_no - queue to move the channel
+ *
+ * Can be used to move a channel to a selected event queue.
+ */
+static void edma_assign_channel_eventq(struct edma_cc *ecc, unsigned channel,
+				       enum dma_event_q eventq_no)
+{
+	if (ecc->id != EDMA_CTLR(channel)) {
+		dev_err(ecc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
+			ecc->id, EDMA_CTLR(channel));
+		return;
+	}
+	channel = EDMA_CHAN_SLOT(channel);
+
+	if (channel >= ecc->num_channels)
+		return;
+
+	/* default to low priority queue */
+	if (eventq_no == EVENTQ_DEFAULT)
+		eventq_no = ecc->default_queue;
+	if (eventq_no >= ecc->num_tc)
+		return;
+
+	edma_map_dmach_to_queue(ecc, channel, eventq_no);
+}
+
+static irqreturn_t dma_irq_handler(int irq, void *data)
+{
+	struct edma_cc *ecc = data;
+	int ctlr;
+	u32 sh_ier;
+	u32 sh_ipr;
+	u32 bank;
+
+	ctlr = ecc->id;
+	if (ctlr < 0)
+		return IRQ_NONE;
+
+	dev_dbg(ecc->dev, "dma_irq_handler\n");
+
+	sh_ipr = edma_shadow0_read_array(ecc, SH_IPR, 0);
+	if (!sh_ipr) {
+		sh_ipr = edma_shadow0_read_array(ecc, SH_IPR, 1);
+		if (!sh_ipr)
+			return IRQ_NONE;
+		sh_ier = edma_shadow0_read_array(ecc, SH_IER, 1);
+		bank = 1;
+	} else {
+		sh_ier = edma_shadow0_read_array(ecc, SH_IER, 0);
+		bank = 0;
+	}
+
+	do {
+		u32 slot;
+		u32 channel;
+
+		dev_dbg(ecc->dev, "IPR%d %08x\n", bank, sh_ipr);
+
+		slot = __ffs(sh_ipr);
+		sh_ipr &= ~(BIT(slot));
+
+		if (sh_ier & BIT(slot)) {
+			channel = (bank << 5) | slot;
+			/* Clear the corresponding IPR bits */
+			edma_shadow0_write_array(ecc, SH_ICR, bank, BIT(slot));
+			if (ecc->intr_data[channel].callback)
+				ecc->intr_data[channel].callback(
+						EDMA_CTLR_CHAN(ctlr, channel),
+						EDMA_DMA_COMPLETE,
+						ecc->intr_data[channel].data);
+		}
+	} while (sh_ipr);
+
+	edma_shadow0_write(ecc, SH_IEVAL, 1);
+	return IRQ_HANDLED;
+}
+
+/******************************************************************************
+ *
+ * DMA error interrupt handler
+ *
+ *****************************************************************************/
+static irqreturn_t dma_ccerr_handler(int irq, void *data)
+{
+	struct edma_cc *ecc = data;
+	int i;
+	int ctlr;
+	unsigned int cnt = 0;
+
+	ctlr = ecc->id;
+	if (ctlr < 0)
+		return IRQ_NONE;
+
+	dev_dbg(ecc->dev, "dma_ccerr_handler\n");
+
+	if ((edma_read_array(ecc, EDMA_EMR, 0) == 0) &&
+	    (edma_read_array(ecc, EDMA_EMR, 1) == 0) &&
+	    (edma_read(ecc, EDMA_QEMR) == 0) &&
+	    (edma_read(ecc, EDMA_CCERR) == 0))
+		return IRQ_NONE;
+
+	while (1) {
+		int j = -1;
+		if (edma_read_array(ecc, EDMA_EMR, 0))
+			j = 0;
+		else if (edma_read_array(ecc, EDMA_EMR, 1))
+			j = 1;
+		if (j >= 0) {
+			dev_dbg(ecc->dev, "EMR%d %08x\n", j,
+				edma_read_array(ecc, EDMA_EMR, j));
+			for (i = 0; i < 32; i++) {
+				int k = (j << 5) + i;
+				if (edma_read_array(ecc, EDMA_EMR, j) &
+							BIT(i)) {
+					/* Clear the corresponding EMR bits */
+					edma_write_array(ecc, EDMA_EMCR, j,
+							 BIT(i));
+					/* Clear any SER */
+					edma_shadow0_write_array(ecc, SH_SECR,
+								j, BIT(i));
+					if (ecc->intr_data[k].callback) {
+						ecc->intr_data[k].callback(
+							EDMA_CTLR_CHAN(ctlr, k),
+							EDMA_DMA_CC_ERROR,
+							ecc->intr_data[k].data);
+					}
+				}
+			}
+		} else if (edma_read(ecc, EDMA_QEMR)) {
+			dev_dbg(ecc->dev, "QEMR %02x\n",
+				edma_read(ecc, EDMA_QEMR));
+			for (i = 0; i < 8; i++) {
+				if (edma_read(ecc, EDMA_QEMR) & BIT(i)) {
+					/* Clear the corresponding IPR bits */
+					edma_write(ecc, EDMA_QEMCR, BIT(i));
+					edma_shadow0_write(ecc, SH_QSECR,
+							   BIT(i));
+
+					/* NOTE:  not reported!! */
+				}
+			}
+		} else if (edma_read(ecc, EDMA_CCERR)) {
+			dev_dbg(ecc->dev, "CCERR %08x\n",
+				edma_read(ecc, EDMA_CCERR));
+			/* FIXME:  CCERR.BIT(16) ignored!  much better
+			 * to just write CCERRCLR with CCERR value...
+			 */
+			for (i = 0; i < 8; i++) {
+				if (edma_read(ecc, EDMA_CCERR) & BIT(i)) {
+					/* Clear the corresponding IPR bits */
+					edma_write(ecc, EDMA_CCERRCLR, BIT(i));
+
+					/* NOTE:  not reported!! */
+				}
+			}
+		}
+		if ((edma_read_array(ecc, EDMA_EMR, 0) == 0) &&
+		    (edma_read_array(ecc, EDMA_EMR, 1) == 0) &&
+		    (edma_read(ecc, EDMA_QEMR) == 0) &&
+		    (edma_read(ecc, EDMA_CCERR) == 0))
+			break;
+		cnt++;
+		if (cnt > 10)
+			break;
+	}
+	edma_write(ecc, EDMA_EEVAL, 1);
+	return IRQ_HANDLED;
+}
+
 static inline struct edma_cc *to_edma_cc(struct dma_device *d)
 {
 	return container_of(d, struct edma_cc, dma_slave);
@@ -151,7 +1163,7 @@ static void edma_desc_free(struct virt_dma_desc *vdesc)
 /* Dispatch a queued descriptor to the controller (caller holds lock) */
 static void edma_execute(struct edma_chan *echan)
 {
-	struct edma *cc = echan->ecc->cc;
+	struct edma_cc *ecc = echan->ecc;
 	struct virt_dma_desc *vdesc;
 	struct edma_desc *edesc;
 	struct device *dev = echan->vchan.chan.device->dev;
@@ -176,7 +1188,7 @@ static void edma_execute(struct edma_chan *echan)
 	/* Write descriptor PaRAM set(s) */
 	for (i = 0; i < nslots; i++) {
 		j = i + edesc->processed;
-		edma_write_slot(cc, echan->slot[i], &edesc->pset[j].param);
+		edma_write_slot(ecc, echan->slot[i], &edesc->pset[j].param);
 		edesc->sg_len += edesc->pset[j].len;
 		dev_vdbg(echan->vchan.chan.device->dev,
 			"\n pset[%d]:\n"
@@ -201,7 +1213,7 @@ static void edma_execute(struct edma_chan *echan)
 			edesc->pset[j].param.link_bcntrld);
 		/* Link to the previous slot if not the last set */
 		if (i != (nslots - 1))
-			edma_link(cc, echan->slot[i], echan->slot[i+1]);
+			edma_link(ecc, echan->slot[i], echan->slot[i+1]);
 	}
 
 	edesc->processed += nslots;
@@ -213,9 +1225,9 @@ static void edma_execute(struct edma_chan *echan)
 	 */
 	if (edesc->processed == edesc->pset_nr) {
 		if (edesc->cyclic)
-			edma_link(cc, echan->slot[nslots-1], echan->slot[1]);
+			edma_link(ecc, echan->slot[nslots-1], echan->slot[1]);
 		else
-			edma_link(cc, echan->slot[nslots-1],
+			edma_link(ecc, echan->slot[nslots-1],
 				  echan->ecc->dummy_slot);
 	}
 
@@ -226,19 +1238,19 @@ static void edma_execute(struct edma_chan *echan)
 		 * transfers of MAX_NR_SG
 		 */
 		dev_dbg(dev, "missed event on channel %d\n", echan->ch_num);
-		edma_clean_channel(cc, echan->ch_num);
-		edma_stop(cc, echan->ch_num);
-		edma_start(cc, echan->ch_num);
-		edma_trigger_channel(cc, echan->ch_num);
+		edma_clean_channel(ecc, echan->ch_num);
+		edma_stop(ecc, echan->ch_num);
+		edma_start(ecc, echan->ch_num);
+		edma_trigger_channel(ecc, echan->ch_num);
 		echan->missed = 0;
 	} else if (edesc->processed <= MAX_NR_SG) {
 		dev_dbg(dev, "first transfer starting on channel %d\n",
 			echan->ch_num);
-		edma_start(cc, echan->ch_num);
+		edma_start(ecc, echan->ch_num);
 	} else {
 		dev_dbg(dev, "chan: %d: completed %d elements, resuming\n",
 			echan->ch_num, edesc->processed);
-		edma_resume(cc, echan->ch_num);
+		edma_resume(ecc, echan->ch_num);
 	}
 }
 
@@ -256,10 +1268,10 @@ static int edma_terminate_all(struct dma_chan *chan)
 	 * echan->edesc is NULL and exit.)
 	 */
 	if (echan->edesc) {
-		edma_stop(echan->ecc->cc, echan->ch_num);
+		edma_stop(echan->ecc, echan->ch_num);
 		/* Move the cyclic channel back to default queue */
 		if (echan->edesc->cyclic)
-			edma_assign_channel_eventq(echan->ecc->cc,
+			edma_assign_channel_eventq(echan->ecc,
 						   echan->ch_num,
 						   EVENTQ_DEFAULT);
 		/*
@@ -298,7 +1310,7 @@ static int edma_dma_pause(struct dma_chan *chan)
 	if (!echan->edesc)
 		return -EINVAL;
 
-	edma_pause(echan->ecc->cc, echan->ch_num);
+	edma_pause(echan->ecc, echan->ch_num);
 	return 0;
 }
 
@@ -306,7 +1318,7 @@ static int edma_dma_resume(struct dma_chan *chan)
 {
 	struct edma_chan *echan = to_edma_chan(chan);
 
-	edma_resume(echan->ecc->cc, echan->ch_num);
+	edma_resume(echan->ecc, echan->ch_num);
 	return 0;
 }
 
@@ -488,7 +1500,7 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 	for (i = 0; i < nslots; i++) {
 		if (echan->slot[i] < 0) {
 			echan->slot[i] =
-				edma_alloc_slot(echan->ecc->cc, EDMA_SLOT_ANY);
+				edma_alloc_slot(echan->ecc, EDMA_SLOT_ANY);
 			if (echan->slot[i] < 0) {
 				kfree(edesc);
 				dev_err(dev, "%s: Failed to allocate slot\n",
@@ -643,7 +1655,7 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 		/* Allocate a PaRAM slot, if needed */
 		if (echan->slot[i] < 0) {
 			echan->slot[i] =
-				edma_alloc_slot(echan->ecc->cc, EDMA_SLOT_ANY);
+				edma_alloc_slot(echan->ecc, EDMA_SLOT_ANY);
 			if (echan->slot[i] < 0) {
 				kfree(edesc);
 				dev_err(dev, "%s: Failed to allocate slot\n",
@@ -704,7 +1716,7 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 	}
 
 	/* Place the cyclic channel to highest priority queue */
-	edma_assign_channel_eventq(echan->ecc->cc, echan->ch_num, EVENTQ_0);
+	edma_assign_channel_eventq(echan->ecc, echan->ch_num, EVENTQ_0);
 
 	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
 }
@@ -712,7 +1724,7 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 static void edma_callback(unsigned ch_num, u16 ch_status, void *data)
 {
 	struct edma_chan *echan = data;
-	struct edma *cc = echan->ecc->cc;
+	struct edma_cc *ecc = echan->ecc;
 	struct device *dev = echan->vchan.chan.device->dev;
 	struct edma_desc *edesc;
 	struct edmacc_param p;
@@ -729,13 +1741,13 @@ static void edma_callback(unsigned ch_num, u16 ch_status, void *data)
 			} else if (edesc->processed == edesc->pset_nr) {
 				dev_dbg(dev, "Transfer complete, stopping channel %d\n", ch_num);
 				edesc->residue = 0;
-				edma_stop(cc, echan->ch_num);
+				edma_stop(ecc, echan->ch_num);
 				vchan_cookie_complete(&edesc->vdesc);
 				echan->edesc = NULL;
 			} else {
 				dev_dbg(dev, "Intermediate transfer complete on channel %d\n", ch_num);
 
-				edma_pause(cc, echan->ch_num);
+				edma_pause(ecc, echan->ch_num);
 
 				/* Update statistics for tx_status */
 				edesc->residue -= edesc->sg_len;
@@ -746,7 +1758,7 @@ static void edma_callback(unsigned ch_num, u16 ch_status, void *data)
 		}
 		break;
 	case EDMA_DMA_CC_ERROR:
-		edma_read_slot(cc, echan->slot[0], &p);
+		edma_read_slot(ecc, echan->slot[0], &p);
 
 		/*
 		 * Issue later based on missed flag which will be sure
@@ -769,10 +1781,10 @@ static void edma_callback(unsigned ch_num, u16 ch_status, void *data)
 			 * missed, so its safe to issue it here.
 			 */
 			dev_dbg(dev, "Error occurred but slot is non-null, TRIGGERING\n");
-			edma_clean_channel(cc, echan->ch_num);
-			edma_stop(cc, echan->ch_num);
-			edma_start(cc, echan->ch_num);
-			edma_trigger_channel(cc, echan->ch_num);
+			edma_clean_channel(ecc, echan->ch_num);
+			edma_stop(ecc, echan->ch_num);
+			edma_start(ecc, echan->ch_num);
+			edma_trigger_channel(ecc, echan->ch_num);
 		}
 		break;
 	default:
@@ -791,7 +1803,7 @@ static int edma_alloc_chan_resources(struct dma_chan *chan)
 	int a_ch_num;
 	LIST_HEAD(descs);
 
-	a_ch_num = edma_alloc_channel(echan->ecc->cc, echan->ch_num,
+	a_ch_num = edma_alloc_channel(echan->ecc, echan->ch_num,
 				      edma_callback, echan, EVENTQ_DEFAULT);
 
 	if (a_ch_num < 0) {
@@ -816,7 +1828,7 @@ static int edma_alloc_chan_resources(struct dma_chan *chan)
 	return 0;
 
 err_wrong_chan:
-	edma_free_channel(echan->ecc->cc, a_ch_num);
+	edma_free_channel(echan->ecc, a_ch_num);
 err_no_chan:
 	return ret;
 }
@@ -829,21 +1841,21 @@ static void edma_free_chan_resources(struct dma_chan *chan)
 	int i;
 
 	/* Terminate transfers */
-	edma_stop(echan->ecc->cc, echan->ch_num);
+	edma_stop(echan->ecc, echan->ch_num);
 
 	vchan_free_chan_resources(&echan->vchan);
 
 	/* Free EDMA PaRAM slots */
 	for (i = 1; i < EDMA_MAX_SLOTS; i++) {
 		if (echan->slot[i] >= 0) {
-			edma_free_slot(echan->ecc->cc, echan->slot[i]);
+			edma_free_slot(echan->ecc, echan->slot[i]);
 			echan->slot[i] = -1;
 		}
 	}
 
 	/* Free EDMA channel */
 	if (echan->alloced) {
-		edma_free_channel(echan->ecc->cc, echan->ch_num);
+		edma_free_channel(echan->ecc, echan->ch_num);
 		echan->alloced = false;
 	}
 
@@ -873,7 +1885,7 @@ static u32 edma_residue(struct edma_desc *edesc)
 	 * We always read the dst/src position from the first RamPar
 	 * pset. That's the one which is active now.
 	 */
-	pos = edma_get_position(edesc->echan->ecc->cc, edesc->echan->slot[0],
+	pos = edma_get_position(edesc->echan->ecc, edesc->echan->slot[0],
 				dst);
 
 	/*
@@ -943,7 +1955,7 @@ static void __init edma_chan_init(struct edma_cc *ecc,
 
 	for (i = 0; i < EDMA_CHANS; i++) {
 		struct edma_chan *echan = &echans[i];
-		echan->ch_num = EDMA_CTLR_CHAN(ecc->ctlr, i);
+		echan->ch_num = EDMA_CTLR_CHAN(ecc->id, i);
 		echan->ecc = ecc;
 		echan->vchan.desc_free = edma_desc_free;
 
@@ -991,14 +2003,188 @@ static void edma_dma_init(struct edma_cc *ecc, struct dma_device *dma,
 	INIT_LIST_HEAD(&dma->channels);
 }
 
+static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
+			      struct edma_cc *ecc)
+{
+	int i;
+	u32 value, cccfg;
+	s8 (*queue_priority_map)[2];
+
+	/* Decode the eDMA3 configuration from CCCFG register */
+	cccfg = edma_read(ecc, EDMA_CCCFG);
+
+	value = GET_NUM_REGN(cccfg);
+	ecc->num_region = BIT(value);
+
+	value = GET_NUM_DMACH(cccfg);
+	ecc->num_channels = BIT(value + 1);
+
+	value = GET_NUM_PAENTRY(cccfg);
+	ecc->num_slots = BIT(value + 4);
+
+	value = GET_NUM_EVQUE(cccfg);
+	ecc->num_tc = value + 1;
+
+	dev_dbg(dev, "eDMA3 CC HW configuration (cccfg: 0x%08x):\n", cccfg);
+	dev_dbg(dev, "num_region: %u\n", ecc->num_region);
+	dev_dbg(dev, "num_channels: %u\n", ecc->num_channels);
+	dev_dbg(dev, "num_slots: %u\n", ecc->num_slots);
+	dev_dbg(dev, "num_tc: %u\n", ecc->num_tc);
+
+	/* Nothing need to be done if queue priority is provided */
+	if (pdata->queue_priority_mapping)
+		return 0;
+
+	/*
+	 * Configure TC/queue priority as follows:
+	 * Q0 - priority 0
+	 * Q1 - priority 1
+	 * Q2 - priority 2
+	 * ...
+	 * The meaning of priority numbers: 0 highest priority, 7 lowest
+	 * priority. So Q0 is the highest priority queue and the last queue has
+	 * the lowest priority.
+	 */
+	queue_priority_map = devm_kzalloc(dev, (ecc->num_tc + 1) * sizeof(s8),
+					  GFP_KERNEL);
+	if (!queue_priority_map)
+		return -ENOMEM;
+
+	for (i = 0; i < ecc->num_tc; i++) {
+		queue_priority_map[i][0] = i;
+		queue_priority_map[i][1] = i;
+	}
+	queue_priority_map[i][0] = -1;
+	queue_priority_map[i][1] = -1;
+
+	pdata->queue_priority_mapping = queue_priority_map;
+	/* Default queue has the lowest priority */
+	pdata->default_queue = i - 1;
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_OF)
+static int edma_xbar_event_map(struct device *dev, struct edma_soc_info *pdata,
+			       size_t sz)
+{
+	const char pname[] = "ti,edma-xbar-event-map";
+	struct resource res;
+	void __iomem *xbar;
+	s16 (*xbar_chans)[2];
+	size_t nelm = sz / sizeof(s16);
+	u32 shift, offset, mux;
+	int ret, i;
+
+	xbar_chans = devm_kzalloc(dev, (nelm + 2) * sizeof(s16), GFP_KERNEL);
+	if (!xbar_chans)
+		return -ENOMEM;
+
+	ret = of_address_to_resource(dev->of_node, 1, &res);
+	if (ret)
+		return -ENOMEM;
+
+	xbar = devm_ioremap(dev, res.start, resource_size(&res));
+	if (!xbar)
+		return -ENOMEM;
+
+	ret = of_property_read_u16_array(dev->of_node, pname, (u16 *)xbar_chans,
+					 nelm);
+	if (ret)
+		return -EIO;
+
+	/* Invalidate last entry for the other user of this mess */
+	nelm >>= 1;
+	xbar_chans[nelm][0] = xbar_chans[nelm][1] = -1;
+
+	for (i = 0; i < nelm; i++) {
+		shift = (xbar_chans[i][1] & 0x03) << 3;
+		offset = xbar_chans[i][1] & 0xfffffffc;
+		mux = readl(xbar + offset);
+		mux &= ~(0xff << shift);
+		mux |= xbar_chans[i][0] << shift;
+		writel(mux, (xbar + offset));
+	}
+
+	pdata->xbar_chans = (const s16 (*)[2]) xbar_chans;
+	return 0;
+}
+
+static int edma_of_parse_dt(struct device *dev, struct edma_soc_info *pdata)
+{
+	int ret = 0;
+	struct property *prop;
+	size_t sz;
+	struct edma_rsv_info *rsv_info;
+
+	rsv_info = devm_kzalloc(dev, sizeof(struct edma_rsv_info), GFP_KERNEL);
+	if (!rsv_info)
+		return -ENOMEM;
+	pdata->rsv = rsv_info;
+
+	prop = of_find_property(dev->of_node, "ti,edma-xbar-event-map", &sz);
+	if (prop)
+		ret = edma_xbar_event_map(dev, pdata, sz);
+
+	return ret;
+}
+
+static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev)
+{
+	struct edma_soc_info *info;
+	int ret;
+
+	info = devm_kzalloc(dev, sizeof(struct edma_soc_info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	ret = edma_of_parse_dt(dev, info);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return info;
+}
+#else
+static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev)
+{
+	return ERR_PTR(-ENOSYS);
+}
+#endif
+
 static int edma_probe(struct platform_device *pdev)
 {
-	struct edma_cc *ecc;
-	struct device_node *parent_node = pdev->dev.parent->of_node;
-	struct platform_device *parent_pdev =
-					to_platform_device(pdev->dev.parent);
+	struct edma_soc_info	*info = pdev->dev.platform_data;
+	s8			(*queue_priority_mapping)[2];
+	int			i, off, ln;
+	const s16		(*rsv_chans)[2];
+	const s16		(*rsv_slots)[2];
+	const s16		(*xbar_chans)[2];
+	int			irq;
+	char			*irq_name;
+	struct resource		*mem;
+	struct device_node	*node = pdev->dev.of_node;
+	struct device		*dev = &pdev->dev;
+	struct edma_cc		*ecc;
 	int ret;
 
+	if (node) {
+		info = edma_setup_info_from_dt(dev);
+		if (IS_ERR(info)) {
+			dev_err(dev, "failed to get DT data\n");
+			return PTR_ERR(info);
+		}
+	}
+
+	if (!info)
+		return -ENODEV;
+
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "pm_runtime_get_sync() failed\n");
+		return ret;
+	}
+
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
@@ -1009,15 +2195,124 @@ static int edma_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	ecc->cc = edma_get_data(pdev->dev.parent);
-	if (!ecc->cc)
-		return -ENODEV;
+	ecc->dev = dev;
+	ecc->id = pdev->id;
+	/* When booting with DT the pdev->id is -1 */
+	if (ecc->id < 0)
+		ecc->id = 0;
+
 
-	ecc->ctlr = parent_pdev->id;
-	if (ecc->ctlr < 0)
-		ecc->ctlr = 0;
+	mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "edma3_cc");
+	if (!mem) {
+		dev_dbg(dev, "mem resource not found, using index 0\n");
+		mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!mem) {
+			dev_err(dev, "no mem resource?\n");
+			return -ENODEV;
+		}
+	}
+	ecc->base = devm_ioremap_resource(dev, mem);
+	if (IS_ERR(ecc->base))
+		return PTR_ERR(ecc->base);
 
-	ecc->dummy_slot = edma_alloc_slot(ecc->cc, EDMA_SLOT_ANY);
+	platform_set_drvdata(pdev, ecc);
+
+	/* Get eDMA3 configuration from IP */
+	ret = edma_setup_from_hw(dev, info, ecc);
+	if (ret)
+		return ret;
+
+	ecc->default_queue = info->default_queue;
+
+	for (i = 0; i < ecc->num_slots; i++)
+		edma_write_slot(ecc, i, &dummy_paramset);
+
+	/* Mark all channels as unused */
+	memset(ecc->edma_unused, 0xff, sizeof(ecc->edma_unused));
+
+	if (info->rsv) {
+		/* Clear the reserved channels in unused list */
+		rsv_chans = info->rsv->rsv_chans;
+		if (rsv_chans) {
+			for (i = 0; rsv_chans[i][0] != -1; i++) {
+				off = rsv_chans[i][0];
+				ln = rsv_chans[i][1];
+				clear_bits(off, ln, ecc->edma_unused);
+			}
+		}
+
+		/* Set the reserved slots in inuse list */
+		rsv_slots = info->rsv->rsv_slots;
+		if (rsv_slots) {
+			for (i = 0; rsv_slots[i][0] != -1; i++) {
+				off = rsv_slots[i][0];
+				ln = rsv_slots[i][1];
+				set_bits(off, ln, ecc->edma_inuse);
+			}
+		}
+	}
+
+	/* Clear the xbar mapped channels in unused list */
+	xbar_chans = info->xbar_chans;
+	if (xbar_chans) {
+		for (i = 0; xbar_chans[i][1] != -1; i++) {
+			off = xbar_chans[i][1];
+			clear_bits(off, 1, ecc->edma_unused);
+		}
+	}
+
+	irq = platform_get_irq_byname(pdev, "edma3_ccint");
+	if (irq < 0 && node)
+		irq = irq_of_parse_and_map(node, 0);
+
+	if (irq >= 0) {
+		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccint",
+					  dev_name(dev));
+		ret = devm_request_irq(dev, irq, dma_irq_handler, 0, irq_name,
+				       ecc);
+		if (ret) {
+			dev_err(dev, "CCINT (%d) failed --> %d\n", irq, ret);
+			return ret;
+		}
+	}
+
+	irq = platform_get_irq_byname(pdev, "edma3_ccerrint");
+	if (irq < 0 && node)
+		irq = irq_of_parse_and_map(node, 2);
+
+	if (irq >= 0) {
+		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccerrint",
+					  dev_name(dev));
+		ret = devm_request_irq(dev, irq, dma_ccerr_handler, 0, irq_name,
+				       ecc);
+		if (ret) {
+			dev_err(dev, "CCERRINT (%d) failed --> %d\n", irq, ret);
+			return ret;
+		}
+	}
+
+	for (i = 0; i < ecc->num_channels; i++)
+		edma_map_dmach_to_queue(ecc, i, info->default_queue);
+
+	queue_priority_mapping = info->queue_priority_mapping;
+
+	/* Event queue priority mapping */
+	for (i = 0; queue_priority_mapping[i][0] != -1; i++)
+		edma_assign_priority_to_queue(ecc, queue_priority_mapping[i][0],
+					      queue_priority_mapping[i][1]);
+
+	/* Map the channel to param entry if channel mapping logic exist */
+	if (edma_read(ecc, EDMA_CCCFG) & CHMAP_EXIST)
+		edma_direct_dmach_to_param_mapping(ecc);
+
+	for (i = 0; i < ecc->num_region; i++) {
+		edma_write_array2(ecc, EDMA_DRAE, i, 0, 0x0);
+		edma_write_array2(ecc, EDMA_DRAE, i, 1, 0x0);
+		edma_write_array(ecc, EDMA_QRAE, i, 0x0);
+	}
+	ecc->info = info;
+
+	ecc->dummy_slot = edma_alloc_slot(ecc, EDMA_SLOT_ANY);
 	if (ecc->dummy_slot < 0) {
 		dev_err(&pdev->dev, "Can't allocate PaRAM dummy slot\n");
 		return ecc->dummy_slot;
@@ -1036,19 +2331,16 @@ static int edma_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_reg1;
 
-	platform_set_drvdata(pdev, ecc);
-
-	if (parent_node) {
-		of_dma_controller_register(parent_node, of_dma_xlate_by_chan_id,
+	if (node)
+		of_dma_controller_register(node, of_dma_xlate_by_chan_id,
 					   &ecc->dma_slave);
-	}
 
 	dev_info(&pdev->dev, "TI EDMA DMA engine driver\n");
 
 	return 0;
 
 err_reg1:
-	edma_free_slot(ecc->cc, ecc->dummy_slot);
+	edma_free_slot(ecc, ecc->dummy_slot);
 	return ret;
 }
 
@@ -1056,21 +2348,60 @@ static int edma_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct edma_cc *ecc = dev_get_drvdata(dev);
-	struct device_node *parent_node = pdev->dev.parent->of_node;
 
-	if (parent_node)
-		of_dma_controller_free(parent_node);
+	if (pdev->dev.of_node)
+		of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&ecc->dma_slave);
-	edma_free_slot(ecc->cc, ecc->dummy_slot);
+	edma_free_slot(ecc, ecc->dummy_slot);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int edma_pm_resume(struct device *dev)
+{
+	struct edma_cc *ecc = dev_get_drvdata(dev);
+	int i;
+	s8 (*queue_priority_mapping)[2];
+
+	queue_priority_mapping = ecc->info->queue_priority_mapping;
+
+	/* Event queue priority mapping */
+	for (i = 0; queue_priority_mapping[i][0] != -1; i++)
+		edma_assign_priority_to_queue(ecc, queue_priority_mapping[i][0],
+					      queue_priority_mapping[i][1]);
+
+	/* Map the channel to param entry if channel mapping logic */
+	if (edma_read(ecc, EDMA_CCCFG) & CHMAP_EXIST)
+		edma_direct_dmach_to_param_mapping(ecc);
+
+	for (i = 0; i < ecc->num_channels; i++) {
+		if (test_bit(i, ecc->edma_inuse)) {
+			/* ensure access through shadow region 0 */
+			edma_or_array2(ecc, EDMA_DRAE, 0, i >> 5,
+				       BIT(i & 0x1f));
+
+			edma_setup_interrupt(ecc, EDMA_CTLR_CHAN(ecc->id, i),
+					     ecc->intr_data[i].callback,
+					     ecc->intr_data[i].data);
+		}
+	}
 
 	return 0;
 }
+#endif
+
+static const struct dev_pm_ops edma_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(NULL, edma_pm_resume)
+};
 
 static struct platform_driver edma_driver = {
 	.probe		= edma_probe,
 	.remove		= edma_remove,
 	.driver = {
-		.name = "edma-dma-engine",
+		.name	= "edma",
+		.pm	= &edma_pm_ops,
+		.of_match_table = edma_of_ids,
 	},
 };
 
diff --git a/include/linux/platform_data/edma.h b/include/linux/platform_data/edma.h
index 466021c03169..6b9d500956e4 100644
--- a/include/linux/platform_data/edma.h
+++ b/include/linux/platform_data/edma.h
@@ -41,37 +41,6 @@
 #ifndef EDMA_H_
 #define EDMA_H_
 
-/* PaRAM slots are laid out like this */
-struct edmacc_param {
-	u32 opt;
-	u32 src;
-	u32 a_b_cnt;
-	u32 dst;
-	u32 src_dst_bidx;
-	u32 link_bcntrld;
-	u32 src_dst_cidx;
-	u32 ccnt;
-} __packed;
-
-/* fields in edmacc_param.opt */
-#define SAM		BIT(0)
-#define DAM		BIT(1)
-#define SYNCDIM		BIT(2)
-#define STATIC		BIT(3)
-#define EDMA_FWID	(0x07 << 8)
-#define TCCMODE		BIT(11)
-#define EDMA_TCC(t)	((t) << 12)
-#define TCINTEN		BIT(20)
-#define ITCINTEN	BIT(21)
-#define TCCHEN		BIT(22)
-#define ITCCHEN		BIT(23)
-
-/*ch_status paramater of callback function possible values*/
-#define EDMA_DMA_COMPLETE 1
-#define EDMA_DMA_CC_ERROR 2
-#define EDMA_DMA_TC1_ERROR 3
-#define EDMA_DMA_TC2_ERROR 4
-
 enum dma_event_q {
 	EVENTQ_0 = 0,
 	EVENTQ_1 = 1,
@@ -84,49 +53,6 @@ enum dma_event_q {
 #define EDMA_CTLR(i)			((i) >> 16)
 #define EDMA_CHAN_SLOT(i)		((i) & 0xffff)
 
-#define EDMA_CHANNEL_ANY		-1	/* for edma_alloc_channel() */
-#define EDMA_SLOT_ANY			-1	/* for edma_alloc_slot() */
-#define EDMA_CONT_PARAMS_ANY		 1001
-#define EDMA_CONT_PARAMS_FIXED_EXACT	 1002
-#define EDMA_CONT_PARAMS_FIXED_NOT_EXACT 1003
-
-#define EDMA_MAX_CC               2
-
-struct edma;
-
-struct edma *edma_get_data(struct device *edma_dev);
-
-/* alloc/free DMA channels and their dedicated parameter RAM slots */
-int edma_alloc_channel(struct edma *cc, int channel,
-	void (*callback)(unsigned channel, u16 ch_status, void *data),
-	void *data, enum dma_event_q);
-void edma_free_channel(struct edma *cc, unsigned channel);
-
-/* alloc/free parameter RAM slots */
-int edma_alloc_slot(struct edma *cc, int slot);
-void edma_free_slot(struct edma *cc, unsigned slot);
-
-/* calls that operate on part of a parameter RAM slot */
-dma_addr_t edma_get_position(struct edma *cc, unsigned slot, bool dst);
-void edma_link(struct edma *cc, unsigned from, unsigned to);
-
-/* calls that operate on an entire parameter RAM slot */
-void edma_write_slot(struct edma *cc, unsigned slot,
-		     const struct edmacc_param *params);
-void edma_read_slot(struct edma *cc, unsigned slot,
-		    struct edmacc_param *params);
-
-/* channel control operations */
-int edma_start(struct edma *cc, unsigned channel);
-void edma_stop(struct edma *cc, unsigned channel);
-void edma_clean_channel(struct edma *cc, unsigned channel);
-void edma_pause(struct edma *cc, unsigned channel);
-void edma_resume(struct edma *cc, unsigned channel);
-int edma_trigger_channel(struct edma *cc, unsigned channel);
-
-void edma_assign_channel_eventq(struct edma *cc, unsigned channel,
-				enum dma_event_q eventq_no);
-
 struct edma_rsv_info {
 
 	const s16	(*rsv_chans)[2];
-- 
2.5.2
