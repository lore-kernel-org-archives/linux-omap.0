From: Sebastien Jan <s-jan@ti.com>
Subject: [RFC PATCH 3/9] HSI: Low Level Driver device management
Date: Fri, 30 Oct 2009 11:00:02 +0100
Message-ID: <1256896808-20152-4-git-send-email-s-jan@ti.com>
References: <1256896808-20152-1-git-send-email-s-jan@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55346 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756758AbZJ3J7D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Oct 2009 05:59:03 -0400
In-Reply-To: <1256896808-20152-1-git-send-email-s-jan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sebastien Jan <s-jan@ti.com>, Carlos Chinea <carlos.chinea@nokia.com>

Low-level managment of interrupts, DMA, GPIO (SSI) and FIFO (HSI).

Signed-off-by: Sebastien Jan <s-jan@ti.com>
Signed-off-by: Carlos Chinea <carlos.chinea@nokia.com>
---
 drivers/hsi/hsi_driver_dma.c  |  469 +++++++++++++++++++++++++++++++++++++++++
 drivers/hsi/hsi_driver_fifo.c |  289 +++++++++++++++++++++++++
 drivers/hsi/hsi_driver_gpio.c |   79 +++++++
 drivers/hsi/hsi_driver_int.c  |  339 +++++++++++++++++++++++++++++
 4 files changed, 1176 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hsi/hsi_driver_dma.c
 create mode 100644 drivers/hsi/hsi_driver_fifo.c
 create mode 100644 drivers/hsi/hsi_driver_gpio.c
 create mode 100644 drivers/hsi/hsi_driver_int.c

diff --git a/drivers/hsi/hsi_driver_dma.c b/drivers/hsi/hsi_driver_dma.c
new file mode 100644
index 0000000..4514e98
--- /dev/null
+++ b/drivers/hsi/hsi_driver_dma.c
@@ -0,0 +1,469 @@
+/*
+ * hsi_driver_dma.c
+ *
+ * Implements HSI low level interface driver functionality with DMA support.
+ *
+ * Copyright (C) 2007-2008 Nokia Corporation. All rights reserved.
+ * Copyright (C) 2009 Texas Instruments, Inc.
+ *
+ * Author: Carlos Chinea <carlos.chinea@nokia.com>
+ * Author: Sebastien JAN <s-jan@ti.com>
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+#include <linux/dma-mapping.h>
+#include "hsi_driver.h"
+
+#define HSI_SYNC_WRITE	0
+#define HSI_SYNC_READ	1
+#define HSI_L3_TPUT	13428 /* 13428 KiB/s => ~110 Mbit/s*/
+
+static unsigned char hsi_sync_table[2][2][8] = {
+	{
+		{0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08},
+		{0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x00}
+	}, {
+		{0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17},
+		{0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f}
+	}
+};
+
+/**
+ * hsi_get_free_lch - Get a free GDD(DMA)logical channel
+ * @hsi_ctrl- HSI controller of the GDD.
+ *
+ * Needs to be called holding the hsi_controller lock
+ *
+ * Return a free logical channel number. If there is no free lch
+ * then returns an out of range value
+ */
+static unsigned int hsi_get_free_lch(struct hsi_dev *hsi_ctrl)
+{
+	unsigned int enable_reg;
+	unsigned int i;
+	unsigned int lch = hsi_ctrl->last_gdd_lch;
+
+	enable_reg = hsi_inl(hsi_ctrl->base, HSI_SYS_GDD_MPU_IRQ_ENABLE_REG);
+	for (i = 1; i <= hsi_ctrl->gdd_chan_count; i++) {
+		lch = (lch + i) & (hsi_ctrl->gdd_chan_count - 1);
+		if (!(enable_reg & HSI_GDD_LCH(lch))) {
+			hsi_ctrl->last_gdd_lch = lch;
+			return lch;
+		}
+	}
+
+	return lch;
+}
+
+/**
+ * hsi_driver_write_dma - Program GDD [DMA] to write data from memory to
+ * the hsi channel buffer.
+ * @hsi_channel - pointer to the hsi_channel to write data to.
+ * @data - 32-bit word pointer to the data.
+ * @size - Number of 32bit words to be transfered.
+ *
+ * hsi_controller lock must be held before calling this function.
+ *
+ * Return 0 on success and < 0 on error.
+ */
+int hsi_driver_write_dma(struct hsi_channel *hsi_channel, u32 *data,
+			 unsigned int size)
+{
+	struct hsi_dev *hsi_ctrl = hsi_channel->hsi_port->hsi_controller;
+	void __iomem *base = hsi_ctrl->base;
+	unsigned int port = hsi_channel->hsi_port->port_number;
+	unsigned int channel = hsi_channel->channel_number;
+	unsigned int sync;
+	long buff_offset;
+	int lch;
+	dma_addr_t dma_data;
+	dma_addr_t s_addr;
+	u16 tmp;
+
+	if ((size < 1) || (data == NULL))
+		return -EINVAL;
+
+	clk_enable(hsi_ctrl->hsi_clk);
+
+	lch = hsi_get_free_lch(hsi_ctrl);
+	if (lch >= hsi_ctrl->gdd_chan_count) {
+		dev_err(hsi_ctrl->dev, "No free GDD logical channels.\n");
+		clk_disable(hsi_ctrl->hsi_clk);
+		return -EBUSY;	/* No free GDD logical channels. */
+	}
+
+	/* NOTE: Getting a free gdd logical channel and
+	 * reserve it must be done atomicaly. */
+	hsi_channel->write_data.lch = lch;
+
+	/* Sync is required for SSI but not for HSI */
+	sync = hsi_sync_table[HSI_SYNC_WRITE][port - 1][channel];
+
+	dma_data = dma_map_single(hsi_ctrl->dev, data, size * 4,
+					DMA_TO_DEVICE);
+
+	tmp = HSI_SRC_SINGLE_ACCESS0 |
+		HSI_SRC_MEMORY_PORT |
+		HSI_DST_SINGLE_ACCESS0 |
+		HSI_DST_PERIPHERAL_PORT |
+		HSI_DATA_TYPE_S32;
+	hsi_outw(tmp, base, HSI_GDD_CSDP_REG(lch));
+
+	tmp = HSI_SRC_AMODE_POSTINC | HSI_DST_AMODE_CONST | sync;
+	hsi_outw(tmp, base, HSI_GDD_CCR_REG(lch));
+
+	hsi_outw((HSI_BLOCK_IE | HSI_TOUT_IE), base, HSI_GDD_CICR_REG(lch));
+
+	buff_offset = hsi_hst_buffer_reg(hsi_ctrl, port, channel);
+	if (buff_offset < 0)
+		return buff_offset;
+	s_addr = hsi_ctrl->phy_base + buff_offset;
+
+	hsi_outl(s_addr, base, HSI_GDD_CDSA_REG(lch));
+
+	hsi_outl(dma_data, base, HSI_GDD_CSSA_REG(lch));
+	hsi_outw(size, base, HSI_GDD_CEN_REG(lch));
+
+	hsi_outl_or(HSI_GDD_LCH(lch), base, HSI_SYS_GDD_MPU_IRQ_ENABLE_REG);
+	hsi_outw_or(HSI_CCR_ENABLE, base, HSI_GDD_CCR_REG(lch));
+
+	return 0;
+}
+
+/**
+ * hsi_driver_read_dma - Program GDD [DMA] to write data to memory from
+ * the hsi channel buffer.
+ * @hsi_channel - pointer to the hsi_channel to read data from.
+ * @data - 32-bit word pointer where to store the incoming data.
+ * @size - Number of 32bit words to be transfered to the buffer.
+ *
+ * hsi_controller lock must be held before calling this function.
+ *
+ * Return 0 on success and < 0 on error.
+ */
+int hsi_driver_read_dma(struct hsi_channel *hsi_channel, u32 *data,
+			unsigned int count)
+{
+	struct hsi_dev *hsi_ctrl = hsi_channel->hsi_port->hsi_controller;
+	void __iomem *base = hsi_ctrl->base;
+	unsigned int port = hsi_channel->hsi_port->port_number;
+	unsigned int channel = hsi_channel->channel_number;
+	unsigned int sync;
+	unsigned int lch;
+	long buff_offset;
+	dma_addr_t dma_data;
+	dma_addr_t d_addr;
+	u16 tmp;
+
+	clk_enable(hsi_ctrl->hsi_clk);
+	lch = hsi_get_free_lch(hsi_ctrl);
+	if (lch >= hsi_ctrl->gdd_chan_count) {
+		dev_err(hsi_ctrl->dev, "No free GDD logical channels.\n");
+		clk_disable(hsi_ctrl->hsi_clk);
+		return -EBUSY;	/* No free GDD logical channels. */
+	}
+
+	/* When DMA is used for Rx, disable the Rx Interrupt.
+	 * (else DATAAVAILLABLE event would get triggered on first
+	 * received data word)
+	 * (By default, Rx interrupt is active for polling feature)
+	 */
+	hsi_driver_disable_read_interrupt(hsi_channel);
+
+	/*
+	 * NOTE: Gettting a free gdd logical channel and
+	 * reserve it must be done atomicaly.
+	 */
+	hsi_channel->read_data.lch = lch;
+
+	/* Sync is required for SSI but not for HSI */
+	sync = hsi_sync_table[HSI_SYNC_READ][port - 1][channel];
+
+	dma_data = dma_map_single(hsi_ctrl->dev, data, count * 4,
+					DMA_FROM_DEVICE);
+
+	tmp = HSI_DST_SINGLE_ACCESS0 |
+		HSI_DST_MEMORY_PORT |
+		HSI_SRC_SINGLE_ACCESS0 |
+		HSI_SRC_PERIPHERAL_PORT |
+		HSI_DATA_TYPE_S32;
+	hsi_outw(tmp, base, HSI_GDD_CSDP_REG(lch));
+
+	tmp = HSI_DST_AMODE_POSTINC | HSI_SRC_AMODE_CONST | sync;
+	hsi_outw(tmp, base, HSI_GDD_CCR_REG(lch));
+
+	hsi_outw((HSI_BLOCK_IE | HSI_TOUT_IE), base, HSI_GDD_CICR_REG(lch));
+
+	buff_offset = hsi_hsr_buffer_reg(hsi_ctrl, port, channel);
+	if (buff_offset < 0)
+		return buff_offset;
+	d_addr = hsi_ctrl->phy_base + buff_offset;
+
+	hsi_outl(d_addr, base, HSI_GDD_CSSA_REG(lch));
+
+	hsi_outl(dma_data, base, HSI_GDD_CDSA_REG(lch));
+	hsi_outw(count, base, HSI_GDD_CEN_REG(lch));
+
+	hsi_outl_or(HSI_GDD_LCH(lch), base, HSI_SYS_GDD_MPU_IRQ_ENABLE_REG);
+	hsi_outw_or(HSI_CCR_ENABLE, base, HSI_GDD_CCR_REG(lch));
+
+	return 0;
+}
+
+void hsi_driver_cancel_write_dma(struct hsi_channel *hsi_ch)
+{
+	int lch = hsi_ch->write_data.lch;
+	unsigned int port = hsi_ch->hsi_port->port_number;
+	unsigned int channel = hsi_ch->channel_number;
+	struct hsi_dev *hsi_ctrl = hsi_ch->hsi_port->hsi_controller;
+	u32 ccr;
+	long buff_offset;
+
+	if (lch < 0)
+		return;
+
+	clk_enable(hsi_ctrl->hsi_clk);
+	ccr = hsi_inw(hsi_ctrl->base, HSI_GDD_CCR_REG(lch));
+	if (!(ccr & HSI_CCR_ENABLE)) {
+		dev_dbg(&hsi_ch->dev->device, LOG_NAME "Write cancel on not "
+		"enabled logical channel %d CCR REG 0x%08X\n", lch, ccr);
+		clk_disable(hsi_ctrl->hsi_clk);
+		return;
+	}
+
+	hsi_outw_and(~HSI_CCR_ENABLE, hsi_ctrl->base, HSI_GDD_CCR_REG(lch));
+	hsi_outl_and(~HSI_GDD_LCH(lch), hsi_ctrl->base,
+						HSI_SYS_GDD_MPU_IRQ_ENABLE_REG);
+	hsi_outl(HSI_GDD_LCH(lch), hsi_ctrl->base,
+						HSI_SYS_GDD_MPU_IRQ_STATUS_REG);
+
+	buff_offset = hsi_hst_bufstate_f_reg(hsi_ctrl, port, channel);
+	if (buff_offset >= 0)
+		hsi_outl_and(~HSI_BUFSTATE_CHANNEL(channel), hsi_ctrl->base,
+								buff_offset);
+
+	hsi_reset_ch_write(hsi_ch);
+	clk_disable(hsi_ctrl->hsi_clk);
+	clk_disable(hsi_ctrl->hsi_clk); /* FIXME - check if can be removed */
+}
+
+void hsi_driver_cancel_read_dma(struct hsi_channel *hsi_ch)
+{
+	int lch = hsi_ch->read_data.lch;
+	struct hsi_dev *hsi_ctrl = hsi_ch->hsi_port->hsi_controller;
+	unsigned int port = hsi_ch->hsi_port->port_number;
+	unsigned int channel = hsi_ch->channel_number;
+	u32 reg;
+	long buff_offset;
+
+	if (lch < 0)
+		return;
+
+	/* DMA transfer is over, re-enable default mode
+	 * (Interrupts for polling feature)
+	 */
+	hsi_driver_read_interrupt(hsi_ch, NULL);
+
+	clk_enable(hsi_ctrl->hsi_clk);
+	reg = hsi_inw(hsi_ctrl->base, HSI_GDD_CCR_REG(lch));
+	if (!(reg & HSI_CCR_ENABLE)) {
+		dev_dbg(&hsi_ch->dev->device, LOG_NAME "Read cancel on not "
+		"enable logical channel %d CCR REG 0x%08X\n", lch, reg);
+		clk_disable(hsi_ctrl->hsi_clk);
+		return;
+	}
+
+	hsi_outw_and(~HSI_CCR_ENABLE, hsi_ctrl->base, HSI_GDD_CCR_REG(lch));
+	hsi_outl_and(~HSI_GDD_LCH(lch), hsi_ctrl->base,
+						HSI_SYS_GDD_MPU_IRQ_ENABLE_REG);
+	hsi_outl(HSI_GDD_LCH(lch), hsi_ctrl->base,
+						HSI_SYS_GDD_MPU_IRQ_STATUS_REG);
+
+	buff_offset = hsi_hsr_bufstate_f_reg(hsi_ctrl, port, channel);
+	if (buff_offset >= 0)
+		hsi_outl_and(~HSI_BUFSTATE_CHANNEL(channel), hsi_ctrl->base,
+								buff_offset);
+
+	hsi_reset_ch_read(hsi_ch);
+	clk_disable(hsi_ctrl->hsi_clk);
+	clk_disable(hsi_ctrl->hsi_clk); /* FIXME - check if can be removed */
+}
+
+/**
+ * hsi_get_info_from_gdd_lch - Retrieve channels information from DMA channel
+ * @hsi_ctrl - HSI device control structure
+ * @lch - DMA logical channel
+ * @port - HSI port
+ * @channel - HSI channel
+ * @is_read_path - channel is used for reading
+ *
+ * Updates the port, channel and is_read_path parameters depending on the
+ * lch DMA channel status.
+ *
+ * Return 0 on success and < 0 on error.
+ */
+int hsi_get_info_from_gdd_lch(struct hsi_dev *hsi_ctrl, unsigned int lch,
+	unsigned int *port, unsigned int *channel, unsigned int *is_read_path)
+{
+	int i_ports;
+	int i_chans;
+	int err = -1;
+
+	for (i_ports = 0; i_ports < HSI_MAX_PORTS; i_ports++)
+		for (i_chans = 0; i_chans < HSI_PORT_MAX_CH; i_chans++)
+			if (hsi_ctrl->hsi_port[i_ports].
+				hsi_channel[i_chans].read_data.lch == lch) {
+				*is_read_path = 1;
+				*port = i_ports + 1;
+				*channel = i_chans;
+				err = 0;
+				goto get_info_bk;
+			} else if (hsi_ctrl->hsi_port[i_ports].
+				hsi_channel[i_chans].write_data.lch == lch) {
+				*is_read_path = 0;
+				*port = i_ports + 1;
+				*channel = i_chans;
+				err = 0;
+				goto get_info_bk;
+			}
+get_info_bk:
+	return err;
+}
+
+static void do_hsi_gdd_lch(struct hsi_dev *hsi_ctrl, unsigned int gdd_lch)
+{
+	void __iomem *base = hsi_ctrl->base;
+	struct hsi_channel *ch;
+	unsigned int port;
+	unsigned int channel;
+	unsigned int is_read_path;
+	u32 gdd_csr;
+	dma_addr_t dma_h;
+	size_t size;
+
+	if (hsi_get_info_from_gdd_lch(hsi_ctrl, gdd_lch, &port, &channel,
+							&is_read_path) < 0) {
+		dev_err(hsi_ctrl->dev, "Unable to match the DMA channel %d with"
+						" an HSI channel\n", gdd_lch);
+		return;
+	}
+/* FIXME: to remove when validated: */
+	else {
+		dev_dbg(hsi_ctrl->dev, "DMA event on gdd_lch=%d => port=%d, "
+			"channel=%d, read=%d\n", gdd_lch, port, channel,
+								is_read_path);
+	}
+
+	spin_lock(&hsi_ctrl->lock);
+
+	hsi_outl_and(~HSI_GDD_LCH(gdd_lch), base,
+						HSI_SYS_GDD_MPU_IRQ_ENABLE_REG);
+	gdd_csr = hsi_inw(base, HSI_GDD_CSR_REG(gdd_lch));
+
+	if (!(gdd_csr & HSI_CSR_TOUT)) {
+		if (is_read_path) { /* Read path */
+			dma_h = hsi_inl(base, HSI_GDD_CDSA_REG(gdd_lch));
+			size = hsi_inw(base, HSI_GDD_CEN_REG(gdd_lch)) * 4;
+			dma_sync_single_for_cpu(hsi_ctrl->dev, dma_h, size,
+							DMA_FROM_DEVICE);
+			dma_unmap_single(hsi_ctrl->dev, dma_h, size,
+						DMA_FROM_DEVICE);
+			ch = ctrl_get_ch(hsi_ctrl, port, channel);
+			hsi_reset_ch_read(ch);
+			/* DMA transfer is over, re-enable default mode
+			 * (interrupts for polling feature)
+			 */
+			hsi_driver_read_interrupt(ch, NULL);
+			spin_unlock(&hsi_ctrl->lock);
+			ch->read_done(ch->dev, size);
+		} else {
+			dma_h = hsi_inl(base, HSI_GDD_CSSA_REG(gdd_lch));
+			size = hsi_inw(base, HSI_GDD_CEN_REG(gdd_lch)) * 4;
+			dma_unmap_single(hsi_ctrl->dev, dma_h, size,
+						DMA_TO_DEVICE);
+			ch = ctrl_get_ch(hsi_ctrl, port, channel);
+			hsi_reset_ch_write(ch);
+			spin_unlock(&hsi_ctrl->lock);
+			ch->write_done(ch->dev, size);
+		}
+	} else {
+		dev_err(hsi_ctrl->dev, "Error  on GDD transfer "
+				"on gdd channel %d\n", gdd_lch);
+		spin_unlock(&hsi_ctrl->lock);
+		hsi_port_event_handler(&hsi_ctrl->hsi_port[port - 1],
+							HSI_EVENT_ERROR, NULL);
+	}
+
+	/* Decrease clk usecount which was increased in
+	 * hsi_driver_{read,write}_dma() */
+	clk_disable(hsi_ctrl->hsi_clk);
+}
+
+static void do_hsi_gdd_tasklet(unsigned long device)
+{
+	struct hsi_dev *hsi_ctrl = (struct hsi_dev *)device;
+	void __iomem *base = hsi_ctrl->base;
+	unsigned int gdd_lch = 0;
+	u32 status_reg = 0;
+	u32 lch_served = 0;
+	unsigned int gdd_max_count = hsi_ctrl->gdd_chan_count;
+
+	clk_enable(hsi_ctrl->hsi_clk);
+
+	status_reg = hsi_inl(base, HSI_SYS_GDD_MPU_IRQ_STATUS_REG);
+
+	for (gdd_lch = 0; gdd_lch < gdd_max_count; gdd_lch++) {
+		if (status_reg & HSI_GDD_LCH(gdd_lch)) {
+			do_hsi_gdd_lch(hsi_ctrl, gdd_lch);
+			lch_served |= HSI_GDD_LCH(gdd_lch);
+		}
+	}
+
+	hsi_outl(lch_served, base, HSI_SYS_GDD_MPU_IRQ_STATUS_REG);
+
+	status_reg = hsi_inl(base, HSI_SYS_GDD_MPU_IRQ_STATUS_REG);
+	status_reg &= hsi_inl(base, HSI_SYS_GDD_MPU_IRQ_ENABLE_REG);
+	clk_disable(hsi_ctrl->hsi_clk);
+
+	if (status_reg)
+		tasklet_hi_schedule(&hsi_ctrl->hsi_gdd_tasklet);
+	else
+		enable_irq(hsi_ctrl->gdd_irq);
+}
+
+static irqreturn_t hsi_gdd_mpu_handler(int irq, void *hsi_controller)
+{
+	struct hsi_dev *hsi_ctrl = hsi_controller;
+
+	tasklet_hi_schedule(&hsi_ctrl->hsi_gdd_tasklet);
+	disable_irq_nosync(hsi_ctrl->gdd_irq);
+
+	return IRQ_HANDLED;
+}
+
+int __init hsi_gdd_init(struct hsi_dev *hsi_ctrl, const char *irq_name)
+{
+	tasklet_init(&hsi_ctrl->hsi_gdd_tasklet, do_hsi_gdd_tasklet,
+						(unsigned long)hsi_ctrl);
+	if (request_irq(hsi_ctrl->gdd_irq, hsi_gdd_mpu_handler, IRQF_DISABLED,
+						irq_name, hsi_ctrl) < 0) {
+		dev_err(hsi_ctrl->dev, "FAILED to request GDD IRQ %d\n",
+							hsi_ctrl->gdd_irq);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+void hsi_gdd_exit(struct hsi_dev *hsi_ctrl)
+{
+	tasklet_disable(&hsi_ctrl->hsi_gdd_tasklet);
+	free_irq(hsi_ctrl->gdd_irq, hsi_ctrl);
+}
diff --git a/drivers/hsi/hsi_driver_fifo.c b/drivers/hsi/hsi_driver_fifo.c
new file mode 100644
index 0000000..33b0f7c
--- /dev/null
+++ b/drivers/hsi/hsi_driver_fifo.c
@@ -0,0 +1,289 @@
+/*
+ * hsi_driver_fifo.c
+ *
+ * Implements HSI module fifo management.
+ *
+ * Copyright (C) 2009 Texas Instruments, Inc.
+ *
+ * Author: Sebastien JAN <s-jan@ti.com>
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/list.h>
+#include <mach/clock.h>
+#include "hsi_driver.h"
+
+/**
+ * hsi_fifo_get_id - Get fifo index corresponding to (port, channel)
+ * @hsi_ctrl - HSI controler data
+ * @channel - channel used
+ * @port - HSI port used
+ *
+ * Returns the fifo index associated to the provided (port, channel).
+ * Notes: 1) The fifo <=> (port, channel) correspondance depends on the selected
+ * SW strategy for channels mapping (fifo management).
+ * 2) the mapping is identical for Read and Write path.
+ * This exclusively applies to HSI devices.
+ */
+int hsi_fifo_get_id(struct hsi_dev *hsi_ctrl, unsigned int channel,
+					unsigned int port)
+{
+	int fifo_index = 0;
+	int err = 0;
+
+	if (unlikely(channel >= HSI_CHANNELS_MAX || port < 1 || port > 2)) {
+		err = -EINVAL;
+		goto fifo_id_bk;
+	}
+
+	if (hsi_ctrl->fifo_mapping_strategy == HSI_FIFO_MAPPING_ALL_PORT1) {
+		if (unlikely(port != 1)) {
+			err = -EINVAL;
+			goto fifo_id_bk;
+		} else {
+			fifo_index = channel;
+		}
+	} else if (hsi_ctrl->fifo_mapping_strategy == HSI_FIFO_MAPPING_SSI) {
+		if (unlikely(channel >= 8)) {
+			err = -EINVAL;
+			goto fifo_id_bk;
+		} else {
+			fifo_index = channel + 8 * (port - 1);
+		}
+	} else {
+		err = -EPERM;
+		goto  fifo_id_bk;
+	}
+
+fifo_id_bk:
+	if (unlikely(err < 0)) {
+		dev_err(hsi_ctrl->dev, "Cannot map a fifo to the requested "
+			"params: channel:%d, port:%d; ERR=%d\n", channel, port,
+								fifo_index);
+		fifo_index = err;
+	}
+
+	return fifo_index;
+}
+
+/**
+ * hsi_fifo_get_chan - Get (port, channel) from a fifo index
+ * @hsi_ctrl - HSI controler data
+ * @fifo - HSI fifo used (0..HSI_HST_FIFO_COUNT)
+ * @channel - related channel if any (0..)
+ * @port - related port if any (1..2)
+ *
+ * Returns 0 in case of success, and errocode (< 0) else
+ * Notes: 1) The fifo <=> (port, channel) correspondance depends on the selected
+ * SW strategy for channels mapping (fifo management).
+ * 2) the mapping is identical for Read and Write path.
+ * This exclusively applies to HSI devices.
+ */
+int hsi_fifo_get_chan(struct hsi_dev *hsi_ctrl, unsigned int fifo,
+				unsigned int *channel, unsigned int *port)
+{
+	int err = 0;
+
+	if (unlikely(fifo >= HSI_HST_FIFO_COUNT)) {
+		err = -EINVAL;
+		goto fifo_id_bk;
+	}
+
+	if (hsi_ctrl->fifo_mapping_strategy == HSI_FIFO_MAPPING_ALL_PORT1) {
+		*channel = fifo;
+		*port = 1;
+	} else if (hsi_ctrl->fifo_mapping_strategy == HSI_FIFO_MAPPING_SSI) {
+		if (fifo < 8) {
+			*channel = fifo;
+			*port = 1;
+		} else {
+			*channel = fifo - 8;
+			*port = 2;
+		}
+	} else {
+		err = -EPERM;
+		goto fifo_id_bk;
+	}
+
+fifo_id_bk:
+	if (unlikely(err < 0))
+		dev_err(hsi_ctrl->dev, "Cannot map a channel / port to the "
+			"requested params: fifo:%d; ERR=%d\n", fifo, err);
+
+	return err;
+}
+
+/**
+ * hsi_fifo_mapping - Configures the HSI FIFO mapping registers.
+ * @hsi_ctrl - HSI controler data
+ * @mtype - mapping strategy
+ *
+ * Returns 0 in case of success, and errocode (< 0) else
+ * Configures the HSI FIFO mapping registers. Several mapping strategies are
+ * proposed.
+ * Note: The mapping is identical for Read and Write path.
+ * This exclusively applies to HSI devices.
+ */
+int __init hsi_fifo_mapping(struct hsi_dev *hsi_ctrl,
+							unsigned int mtype)
+{
+	int err = 0;
+	void __iomem *base = hsi_ctrl->base;
+	int i;
+	unsigned int channel, port;
+
+	if (mtype == HSI_FIFO_MAPPING_ALL_PORT1) {
+		channel = 0;
+		for (i = 0; i < HSI_HST_FIFO_COUNT; i++) {
+			hsi_outl(HSI_MAPPING_ENABLE |
+				(channel << HSI_MAPPING_CH_NUMBER_OFFSET) |
+				(0 << HSI_MAPPING_PORT_NUMBER_OFFSET) |
+				HSI_HST_MAPPING_THRESH_VALUE,
+				base, HSI_HST_MAPPING_FIFO_REG(i));
+			hsi_outl(HSI_MAPPING_ENABLE |
+				(channel << HSI_MAPPING_CH_NUMBER_OFFSET) |
+				(0 << HSI_MAPPING_PORT_NUMBER_OFFSET),
+				base, HSI_HSR_MAPPING_FIFO_REG(i));
+			channel++;
+		}
+		hsi_ctrl->fifo_mapping_strategy = HSI_FIFO_MAPPING_ALL_PORT1;
+	} else if (mtype == HSI_FIFO_MAPPING_SSI) {
+		channel = 0;
+		port = 0;
+		for (i = 0; i < HSI_HST_FIFO_COUNT; i++) {
+			hsi_outl(HSI_MAPPING_ENABLE |
+				(channel << HSI_MAPPING_CH_NUMBER_OFFSET) |
+				(port << HSI_MAPPING_PORT_NUMBER_OFFSET) |
+				HSI_HST_MAPPING_THRESH_VALUE,
+				base, HSI_HST_MAPPING_FIFO_REG(i));
+			hsi_outl(HSI_MAPPING_ENABLE |
+				(channel << HSI_MAPPING_CH_NUMBER_OFFSET) |
+				(port << HSI_MAPPING_PORT_NUMBER_OFFSET),
+				base, HSI_HSR_MAPPING_FIFO_REG(i));
+			channel++;
+			if (channel == 8) {
+				channel = 0;
+				port = 1;
+			}
+		}
+
+		hsi_ctrl->fifo_mapping_strategy = HSI_FIFO_MAPPING_DEFAULT;
+	} else {
+		hsi_ctrl->fifo_mapping_strategy = HSI_FIFO_MAPPING_UNDEF;
+		dev_err(hsi_ctrl->dev, "Bad Fifo strategy request\n");
+		err = -EINVAL;
+	}
+
+	return err;
+}
+
+/**
+ * hsi_hst_bufstate_f_reg - Return the proper HSI_HST_BUFSTATE register offset
+ * @hsi_ctrl - HSI controler data
+ * @port - HSI port used
+ * @channel - channel used
+ *
+ * Returns the HSI_HST_BUFSTATE register offset
+ * Note: indexing of BUFSTATE registers is different on SSI and HSI:
+ * On SSI: it is linked to the ports
+ * On HSI: it is linked to the FIFOs (and depend on the SW strategy)
+ */
+long hsi_hst_bufstate_f_reg(struct hsi_dev *hsi_ctrl,
+				unsigned int port, unsigned int channel) {
+	int fifo;
+	if (hsi_driver_device_is_hsi(to_platform_device(hsi_ctrl->dev))) {
+		fifo = hsi_fifo_get_id(hsi_ctrl, channel, port);
+		if (fifo < 0)
+			return fifo;
+		else
+			return HSI_HST_BUFSTATE_FIFO_REG(fifo);
+	} else {
+		return HSI_HST_BUFSTATE_REG(port);
+	}
+}
+
+/**
+ * hsi_hsr_bufstate_f_reg - Return the proper HSI_HSR_BUFSTATE register offset
+ * @hsi_ctrl - HSI controler data
+ * @port - HSI port used
+ * @channel - channel used
+ *
+ * Returns the HSI_HSR_BUFSTATE register offset
+ * Note: indexing of BUFSTATE registers is different on SSI and HSI:
+ * On SSI: it is linked to the ports
+ * On HSI: it is linked to the FIFOs (and depend on the SW strategy)
+ */
+long hsi_hsr_bufstate_f_reg(struct hsi_dev *hsi_ctrl,
+				unsigned int port, unsigned int channel) {
+	int fifo;
+	if (hsi_driver_device_is_hsi(to_platform_device(hsi_ctrl->dev))) {
+		fifo = hsi_fifo_get_id(hsi_ctrl, channel, port);
+		if (fifo < 0)
+			return fifo;
+		else
+			return HSI_HSR_BUFSTATE_FIFO_REG(fifo);
+	} else {
+		return HSI_HSR_BUFSTATE_REG(port);
+	}
+}
+
+/**
+ * hsi_hst_buffer_f_reg - Return the proper HSI_HST_BUFFER register offset
+ * @hsi_ctrl - HSI controler data
+ * @port - HSI port used
+ * @channel - channel used
+ *
+ * Returns the HSI_HST_BUFFER register offset
+ * Note: indexing of BUFFER registers is different on SSI and HSI:
+ * On SSI: it is linked to the ports
+ * On HSI: it is linked to the FIFOs (and depend on the SW strategy)
+ */
+long hsi_hst_buffer_reg(struct hsi_dev *hsi_ctrl,
+				unsigned int port, unsigned int channel) {
+	int fifo;
+	if (hsi_driver_device_is_hsi(to_platform_device(hsi_ctrl->dev))) {
+		fifo = hsi_fifo_get_id(hsi_ctrl, channel, port);
+		if (unlikely(fifo < 0))
+			return fifo;
+		else
+			return HSI_HST_BUFFER_FIFO_REG(fifo);
+	} else {
+		return HSI_HST_BUFFER_CH_REG(port, channel);
+	}
+}
+
+/**
+ * hsi_hsr_buffer_f_reg - Return the proper HSI_HSR_BUFFER register offset
+ * @hsi_ctrl - HSI controler data
+ * @port - HSI port used
+ * @channel - channel used
+ *
+ * Returns the HSI_HSR_BUFFER register offset
+ * Note: indexing of BUFFER registers is different on SSI and HSI:
+ * On SSI: it is linked to the ports
+ * On HSI: it is linked to the FIFOs (and depend on the SW strategy)
+ */
+long hsi_hsr_buffer_reg(struct hsi_dev *hsi_ctrl,
+				unsigned int port, unsigned int channel) {
+	int fifo;
+	if (hsi_driver_device_is_hsi(to_platform_device(hsi_ctrl->dev))) {
+		fifo = hsi_fifo_get_id(hsi_ctrl, channel, port);
+		if (fifo < 0)
+			return fifo;
+		else
+			return HSI_HSR_BUFFER_FIFO_REG(fifo);
+	} else {
+		return HSI_HSR_BUFFER_CH_REG(port, channel);
+	}
+}
+
diff --git a/drivers/hsi/hsi_driver_gpio.c b/drivers/hsi/hsi_driver_gpio.c
new file mode 100644
index 0000000..2410973
--- /dev/null
+++ b/drivers/hsi/hsi_driver_gpio.c
@@ -0,0 +1,79 @@
+/*
+ * hsi_driver_gpio.c
+ *
+ * Implements HSI GPIO related functionality. (i.e: wake lines management)
+ *
+ * Copyright (C) 2007-2008 Nokia Corporation. All rights reserved.
+ * Copyright (C) 2009 Texas Instruments, Inc.
+ *
+ * Author: Carlos Chinea <carlos.chinea@nokia.com>
+ * Author: Sebastien JAN <s-jan@ti.com>
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+#include <linux/gpio.h>
+#include "hsi_driver.h"
+
+static void do_hsi_cawake_tasklet(unsigned long hsi_p)
+{
+	struct hsi_port *port = (struct hsi_port *)hsi_p;
+	struct hsi_dev *hsi_ctrl = port->hsi_controller;
+
+	if (hsi_cawake(port)) {
+		if (!hsi_ctrl->cawake_clk_enable) {
+			hsi_ctrl->cawake_clk_enable = 1;
+			clk_enable(hsi_ctrl->hsi_clk);
+		}
+		hsi_port_event_handler(port, HSI_EVENT_CAWAKE_UP, NULL);
+	} else {
+		hsi_port_event_handler(port, HSI_EVENT_CAWAKE_DOWN, NULL);
+		if (hsi_ctrl->cawake_clk_enable) {
+			hsi_ctrl->cawake_clk_enable = 0;
+			clk_disable(hsi_ctrl->hsi_clk);
+		}
+	}
+}
+
+static irqreturn_t hsi_cawake_isr(int irq, void *hsi_p)
+{
+	struct hsi_port *port = hsi_p;
+
+	tasklet_hi_schedule(&port->cawake_tasklet);
+
+	return IRQ_HANDLED;
+}
+
+int __init hsi_cawake_init(struct hsi_port *port, const char *irq_name)
+{
+	tasklet_init(&port->cawake_tasklet, do_hsi_cawake_tasklet,
+							(unsigned long)port);
+
+	if (request_irq(port->cawake_gpio_irq, hsi_cawake_isr,
+		IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+							irq_name, port) < 0) {
+		dev_err(port->hsi_controller->dev,
+			"FAILED to request %s GPIO IRQ %d on port %d\n",
+			irq_name, port->cawake_gpio_irq, port->port_number);
+		return -EBUSY;
+	}
+	enable_irq_wake(port->cawake_gpio_irq);
+
+	return 0;
+}
+
+void hsi_cawake_exit(struct hsi_port *port)
+{
+	if (port->cawake_gpio < 0)
+		return;	/* Nothing to do */
+
+	disable_irq_wake(port->cawake_gpio_irq);
+	tasklet_kill(&port->cawake_tasklet);
+	free_irq(port->cawake_gpio_irq, port);
+}
diff --git a/drivers/hsi/hsi_driver_int.c b/drivers/hsi/hsi_driver_int.c
new file mode 100644
index 0000000..d04daf7
--- /dev/null
+++ b/drivers/hsi/hsi_driver_int.c
@@ -0,0 +1,339 @@
+/*
+ * hsi_driver_int.c
+ *
+ * Implements HSI interrupt functionality.
+ *
+ * Copyright (C) 2007-2008 Nokia Corporation. All rights reserved.
+ * Copyright (C) 2009 Texas Instruments, Inc.
+ *
+ * Author: Carlos Chinea <carlos.chinea@nokia.com>
+ * Author: Sebastien JAN <s-jan@ti.com>
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+#include "hsi_driver.h"
+
+void hsi_reset_ch_read(struct hsi_channel *ch)
+{
+	ch->read_data.addr = NULL;
+	ch->read_data.size = 0;
+	ch->read_data.lch = -1;
+}
+
+void hsi_reset_ch_write(struct hsi_channel *ch)
+{
+	ch->write_data.addr = NULL;
+	ch->write_data.size = 0;
+	ch->write_data.lch = -1;
+}
+
+int hsi_driver_write_interrupt(struct hsi_channel *ch, u32 *data)
+{
+	struct hsi_port *p = ch->hsi_port;
+	unsigned int port = p->port_number;
+	unsigned int channel = ch->channel_number;
+
+	clk_enable(p->hsi_controller->hsi_clk);
+
+	hsi_outl_or(HSI_HST_DATAACCEPT(channel), p->hsi_controller->base,
+			HSI_SYS_MPU_ENABLE_CH_REG(port, p->n_irq, channel));
+
+	return 0;
+}
+
+int hsi_driver_read_interrupt(struct hsi_channel *ch, u32 *data)
+{
+	struct hsi_port *p = ch->hsi_port;
+	unsigned int port = p->port_number;
+	unsigned int channel = ch->channel_number;
+
+	clk_enable(p->hsi_controller->hsi_clk);
+
+	hsi_outl_or(HSI_HSR_DATAAVAILABLE(channel), p->hsi_controller->base,
+			HSI_SYS_MPU_ENABLE_CH_REG(port, p->n_irq, channel));
+
+	clk_disable(p->hsi_controller->hsi_clk);
+
+	return 0;
+}
+
+void hsi_driver_cancel_write_interrupt(struct hsi_channel *ch)
+{
+	struct hsi_port *p = ch->hsi_port;
+	unsigned int port = p->port_number;
+	unsigned int channel = ch->channel_number;
+	void __iomem *base = p->hsi_controller->base;
+	u32 enable;
+	long buff_offset;
+
+	clk_enable(p->hsi_controller->hsi_clk);
+
+	enable = hsi_inl(base,
+			HSI_SYS_MPU_ENABLE_CH_REG(port, p->n_irq, channel));
+
+	if (!(enable & HSI_HST_DATAACCEPT(channel))) {
+		dev_dbg(&ch->dev->device, LOG_NAME "Write cancel on not "
+		"enabled channel %d ENABLE REG 0x%08X", channel, enable);
+		clk_disable(p->hsi_controller->hsi_clk);
+		return;
+	}
+
+	hsi_outl_and(~HSI_HST_DATAACCEPT(channel), base,
+			HSI_SYS_MPU_ENABLE_CH_REG(port, p->n_irq, channel));
+
+	buff_offset = hsi_hst_bufstate_f_reg(p->hsi_controller, port, channel);
+	if (buff_offset >= 0)
+		hsi_outl_and(~HSI_BUFSTATE_CHANNEL(channel), base,
+								buff_offset);
+
+	hsi_reset_ch_write(ch);
+
+	clk_disable(p->hsi_controller->hsi_clk);
+	clk_disable(p->hsi_controller->hsi_clk); /* FIXME - can be removed? */
+}
+
+void hsi_driver_disable_read_interrupt(struct hsi_channel *ch)
+{
+	struct hsi_port *p = ch->hsi_port;
+	unsigned int port = p->port_number;
+	unsigned int channel = ch->channel_number;
+	void __iomem *base = p->hsi_controller->base;
+
+	clk_enable(p->hsi_controller->hsi_clk);
+
+	hsi_outl_and(~HSI_HSR_DATAAVAILABLE(channel), base,
+			HSI_SYS_MPU_ENABLE_CH_REG(port, p->n_irq, channel));
+
+	clk_disable(p->hsi_controller->hsi_clk);
+}
+
+void hsi_driver_cancel_read_interrupt(struct hsi_channel *ch)
+{
+	struct hsi_port *p = ch->hsi_port;
+	unsigned int port = p->port_number;
+	unsigned int channel = ch->channel_number;
+	void __iomem *base = p->hsi_controller->base;
+
+	clk_enable(p->hsi_controller->hsi_clk);
+
+	hsi_outl_and(~HSI_HSR_DATAAVAILABLE(channel), base,
+			HSI_SYS_MPU_ENABLE_CH_REG(port, p->n_irq, channel));
+
+	hsi_reset_ch_read(ch);
+
+	clk_disable(p->hsi_controller->hsi_clk);
+}
+
+static void do_channel_tx(struct hsi_channel *ch)
+{
+	struct hsi_dev *hsi_ctrl = ch->hsi_port->hsi_controller;
+	void __iomem *base = hsi_ctrl->base;
+	unsigned int n_ch;
+	unsigned int n_p;
+	unsigned int irq;
+	long buff_offset;
+
+	n_ch = ch->channel_number;
+	n_p = ch->hsi_port->port_number;
+	irq = ch->hsi_port->n_irq;
+
+	spin_lock(&hsi_ctrl->lock);
+
+	if (ch->write_data.addr == NULL) {
+		hsi_outl_and(~HSI_HST_DATAACCEPT(n_ch), base,
+				HSI_SYS_MPU_ENABLE_CH_REG(n_p, irq, n_ch));
+		hsi_reset_ch_write(ch);
+		spin_unlock(&hsi_ctrl->lock);
+		clk_disable(hsi_ctrl->hsi_clk);
+		(*ch->write_done)(ch->dev, 4);
+	} else {
+		buff_offset = hsi_hst_buffer_reg(hsi_ctrl, n_p, n_ch);
+		if (buff_offset >= 0) {
+			hsi_outl(*(ch->write_data.addr), base, buff_offset);
+			ch->write_data.addr = NULL;
+		}
+		spin_unlock(&hsi_ctrl->lock);
+	}
+}
+
+static void do_channel_rx(struct hsi_channel *ch)
+{
+	struct hsi_dev *hsi_ctrl = ch->hsi_port->hsi_controller;
+	void __iomem *base = ch->hsi_port->hsi_controller->base;
+	unsigned int n_ch;
+	unsigned int n_p;
+	unsigned int irq;
+	long buff_offset;
+	int rx_poll = 0;
+	int data_read = 0;
+
+	n_ch = ch->channel_number;
+	n_p = ch->hsi_port->port_number;
+	irq = ch->hsi_port->n_irq;
+
+	spin_lock(&hsi_ctrl->lock);
+
+	if (ch->flags & HSI_CH_RX_POLL)
+		rx_poll = 1;
+
+	if (ch->read_data.addr) {
+		buff_offset = hsi_hsr_buffer_reg(hsi_ctrl, n_p, n_ch);
+		if (buff_offset >= 0) {
+			data_read = 1;
+			*(ch->read_data.addr) = hsi_inl(base, buff_offset);
+		}
+	}
+
+	hsi_outl_and(~HSI_HSR_DATAAVAILABLE(n_ch), base,
+				HSI_SYS_MPU_ENABLE_CH_REG(n_p, irq, n_ch));
+	hsi_reset_ch_read(ch);
+
+	spin_unlock(&hsi_ctrl->lock);
+
+	if (rx_poll)
+		hsi_port_event_handler(ch->hsi_port,
+				HSI_EVENT_HSR_DATAAVAILABLE, (void *)n_ch);
+
+	if (data_read)
+		(*ch->read_done)(ch->dev, 4);
+}
+
+/**
+ * hsi_driver_int_proc - check all channels / ports for interrupts events
+ * @hsi_ctrl - HSI controler data
+ * @status_offset: interrupt status register offset
+ * @enable_offset: interrupt enable regiser offset
+ * @start: interrupt index to start on
+ * @stop: interrupt index to stop on
+ *
+ * This function calls the related processing functions and triggered events
+*/
+static void hsi_driver_int_proc(struct hsi_port *pport,
+		unsigned long status_offset, unsigned long enable_offset,
+		unsigned int start, unsigned int stop)
+{
+	struct hsi_dev *hsi_ctrl = pport->hsi_controller;
+	void __iomem *base = hsi_ctrl->base;
+	unsigned int port = pport->port_number;
+	unsigned int channel;
+	u32 status_reg;
+	u32 hsr_err_reg;
+	u32 channels_served = 0;
+
+	status_reg = hsi_inl(base, status_offset);
+	status_reg &= hsi_inl(base, enable_offset);
+
+	for (channel = start; channel < stop; channel++) {
+		if (status_reg & HSI_HST_DATAACCEPT(channel)) {
+
+			do_channel_tx(&pport->hsi_channel[channel]);
+			channels_served |= HSI_HST_DATAACCEPT(channel);
+		}
+
+		if (status_reg & HSI_HSR_DATAAVAILABLE(channel)) {
+			do_channel_rx(&pport->hsi_channel[channel]);
+			channels_served |= HSI_HSR_DATAAVAILABLE(channel);
+		}
+	}
+
+	if (status_reg & HSI_BREAKDETECTED) {
+		dev_info(hsi_ctrl->dev, "Hardware BREAK on port %d\n", port);
+		hsi_outl(0, base, HSI_HSR_BREAK_REG(port));
+		hsi_port_event_handler(pport, HSI_EVENT_BREAK_DETECTED, NULL);
+		channels_served |= HSI_BREAKDETECTED;
+	}
+
+	if (status_reg & HSI_ERROROCCURED) {
+		hsr_err_reg = hsi_inl(base, HSI_HSR_ERROR_REG(port));
+		dev_err(hsi_ctrl->dev, "HSI ERROR Port %d: 0x%x\n",
+							port, hsr_err_reg);
+		hsi_outl(hsr_err_reg, base, HSI_HSR_ERRORACK_REG(port));
+		if (hsr_err_reg) /* ignore spurious errors */
+			hsi_port_event_handler(pport, HSI_EVENT_ERROR, NULL);
+		else
+			dev_dbg(hsi_ctrl->dev, "Spurious HSI error!\n");
+
+		channels_served |= HSI_ERROROCCURED;
+	}
+
+	hsi_outl(channels_served, base, status_offset);
+}
+
+static void do_hsi_tasklet(unsigned long hsi_port)
+{
+	struct hsi_port *pport = (struct hsi_port *)hsi_port;
+	struct hsi_dev *hsi_ctrl = pport->hsi_controller;
+	void __iomem *base = hsi_ctrl->base;
+	unsigned int port = pport->port_number;
+	unsigned int irq = pport->n_irq;
+	u32 status_reg;
+	struct platform_device *pd = to_platform_device(hsi_ctrl->dev);
+
+	clk_enable(hsi_ctrl->hsi_clk);
+
+	hsi_driver_int_proc(pport,
+			HSI_SYS_MPU_STATUS_REG(port, irq),
+			HSI_SYS_MPU_ENABLE_REG(port, irq),
+			0, min(pport->max_ch, (u8) HSI_SSI_CHANNELS_MAX));
+
+	if (pport->max_ch > HSI_SSI_CHANNELS_MAX)
+		hsi_driver_int_proc(pport,
+				HSI_SYS_MPU_U_STATUS_REG(port, irq),
+				HSI_SYS_MPU_U_ENABLE_REG(port, irq),
+				HSI_SSI_CHANNELS_MAX, pport->max_ch);
+
+	status_reg = hsi_inl(base, HSI_SYS_MPU_STATUS_REG(port, irq)) &
+			hsi_inl(base, HSI_SYS_MPU_ENABLE_REG(port, irq));
+
+	if (hsi_driver_device_is_hsi(pd))
+		status_reg |=
+			(hsi_inl(base, HSI_SYS_MPU_U_STATUS_REG(port, irq)) &
+			hsi_inl(base, HSI_SYS_MPU_U_ENABLE_REG(port, irq)));
+
+	clk_disable(hsi_ctrl->hsi_clk);
+
+	if (status_reg)
+		tasklet_hi_schedule(&pport->hsi_tasklet);
+	else
+		enable_irq(pport->irq);
+}
+
+static irqreturn_t hsi_mpu_handler(int irq, void *hsi_port)
+{
+	struct hsi_port *p = hsi_port;
+
+	tasklet_hi_schedule(&p->hsi_tasklet);
+	disable_irq_nosync(p->irq);
+
+	return IRQ_HANDLED;
+}
+
+int __init hsi_mpu_init(struct hsi_port *hsi_p, const char *irq_name)
+{
+	int err;
+
+	tasklet_init(&hsi_p->hsi_tasklet, do_hsi_tasklet,
+							(unsigned long)hsi_p);
+	err = request_irq(hsi_p->irq, hsi_mpu_handler, IRQF_DISABLED,
+							irq_name, hsi_p);
+	if (err < 0) {
+		dev_err(hsi_p->hsi_controller->dev, "FAILED to MPU request"
+			" IRQ (%d) on port %d", hsi_p->irq, hsi_p->port_number);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+void hsi_mpu_exit(struct hsi_port *hsi_p)
+{
+	tasklet_disable(&hsi_p->hsi_tasklet);
+	free_irq(hsi_p->irq, hsi_p);
+}
-- 
1.6.0.4

