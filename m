From: Sebastien Jan <s-jan@ti.com>
Subject: [RFC PATCH 1/9] HSI: Low Level Driver interface
Date: Fri, 30 Oct 2009 11:00:00 +0100
Message-ID: <1256896808-20152-2-git-send-email-s-jan@ti.com>
References: <1256896808-20152-1-git-send-email-s-jan@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55337 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756748AbZJ3J66 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Oct 2009 05:58:58 -0400
In-Reply-To: <1256896808-20152-1-git-send-email-s-jan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sebastien Jan <s-jan@ti.com>, Carlos Chinea <carlos.chinea@nokia.com>

Driver kernel interface headers and implementation
Driver Makefile and configuration integration

Signed-off-by: Sebastien Jan <s-jan@ti.com>
Signed-off-by: Carlos Chinea <carlos.chinea@nokia.com>
---
 drivers/Makefile              |    1 +
 drivers/hsi/Kconfig           |   44 +++
 drivers/hsi/Makefile          |   14 +
 drivers/hsi/hsi_driver_if.c   |  657 +++++++++++++++++++++++++++++++++++++++++
 include/linux/hsi_driver_if.h |  180 +++++++++++
 5 files changed, 896 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hsi/Kconfig
 create mode 100644 drivers/hsi/Makefile
 create mode 100644 drivers/hsi/hsi_driver_if.c
 create mode 100644 include/linux/hsi_driver_if.h

diff --git a/drivers/Makefile b/drivers/Makefile
index 086857c..05b4190 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -111,3 +111,4 @@ obj-$(CONFIG_VLYNQ)		+= vlynq/
 obj-$(CONFIG_STAGING)		+= staging/
 obj-y				+= platform/
 obj-y				+= ieee802154/
+obj-$(CONFIG_OMAP_HSI)		+= hsi/
diff --git a/drivers/hsi/Kconfig b/drivers/hsi/Kconfig
new file mode 100644
index 0000000..e10b522
--- /dev/null
+++ b/drivers/hsi/Kconfig
@@ -0,0 +1,44 @@
+#
+# OMAP HSI driver configuration
+#
+menuconfig HSI
+	bool "HSI support"
+	default n
+	help
+	  The MIPI HSI is a High Speed Synchronous Serial Interface and is
+	  defined for communication between two Integrated Circuits (the
+	  typical scenario is an application IC and cellular modem IC
+	  communication). Data transaction model is peer-to-peer. MIPI HSI
+	  physical layer provides logical channeling and several modes of
+	  operation.
+
+if HSI
+
+config OMAP_HSI
+	tristate "OMAP HSI hardware driver"
+	depends on (ARCH_OMAP34XX || ARCH_OMAP4)
+	default n
+	---help---
+	  If you say Y here, you will enable the OMAP HSI hardware driver.
+
+	  If unsure, say N.
+
+	  Note that the HSI driver supports either:
+	    - the OMAP MIPI HSI device
+	    - the OMAP SSI device
+
+choice
+	prompt "Selected device support file"
+	depends on OMAP_HSI && y
+	default OMAP_HSI_DEVICE
+	---help---
+	  Adds the device support for one of the devices handled by the HSI
+	  driver.
+
+config OMAP_HSI_DEVICE
+	bool "HSI (OMAP MIPI HSI)"
+
+config OMAP_SSI_DEVICE
+	bool "SSI (OMAP SSI)"
+
+endchoice
diff --git a/drivers/hsi/Makefile b/drivers/hsi/Makefile
new file mode 100644
index 0000000..a7f579b
--- /dev/null
+++ b/drivers/hsi/Makefile
@@ -0,0 +1,14 @@
+#
+# Makefile for HSI drivers
+#
+EXTRA_CFLAGS :=
+
+omap_hsi-objs	:=	hsi_driver.o hsi_driver_dma.o hsi_driver_int.o \
+			hsi_driver_if.o hsi_driver_bus.o hsi_driver_gpio.o \
+			hsi_driver_fifo.o
+
+ifeq ($(CONFIG_DEBUG_FS), y)
+	omap_hsi-objs += hsi_driver_debugfs.o
+endif
+
+obj-$(CONFIG_OMAP_HSI)	+= omap_hsi.o
diff --git a/drivers/hsi/hsi_driver_if.c b/drivers/hsi/hsi_driver_if.c
new file mode 100644
index 0000000..fb0035d
--- /dev/null
+++ b/drivers/hsi/hsi_driver_if.c
@@ -0,0 +1,657 @@
+/*
+ * hsi_driver_if.c
+ *
+ * Implements HSI hardware driver interfaces for the upper layers.
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
+#define NOT_SET		(-1)
+
+/* Manage HSR divisor update
+ * A special divisor value allows switching to auto-divisor mode in Rx
+ * (but with error counters deactivated). This function implements the
+ * the transitions to/from this mode.
+ */
+int hsi_set_rx_divisor(struct hsi_port *sport, u32 divisor)
+{
+	struct hsi_dev *hsi_ctrl = sport->hsi_controller;
+	void __iomem *base = hsi_ctrl->base;
+	int port = sport->port_number;
+	struct platform_device *pdev = to_platform_device(hsi_ctrl->dev);
+
+	if (divisor == NOT_SET)
+		return 0;
+
+	if (hsi_driver_device_is_hsi(pdev)) {
+		if (divisor == HSI_HSR_DIVISOR_AUTO && sport->counters_on) {
+			/* auto mode: deactivate counters + set divisor = 0 */
+			sport->reg_counters = hsi_inl(base,
+						HSI_HSR_COUNTERS_REG(port));
+			sport->counters_on = 0;
+			hsi_outl(0, base, HSI_HSR_COUNTERS_REG(port));
+			hsi_outl(0, base, HSI_HSR_DIVISOR_REG(port));
+			dev_dbg(hsi_ctrl->dev, "Switched to HSR auto mode\n");
+		} else if (divisor != HSI_HSR_DIVISOR_AUTO) {
+			/* Divisor set mode: use counters */
+			if (!sport->counters_on) {
+				/* Leave auto mode: restore counters */
+				hsi_outl(sport->reg_counters, base,
+						HSI_HSR_COUNTERS_REG(port));
+				sport->counters_on = 1;
+				dev_dbg(hsi_ctrl->dev, "Left HSR auto mode. "
+				"Counters=0x%lx\n", sport->reg_counters);
+			}
+			hsi_outl(divisor, base, HSI_HSR_DIVISOR_REG(port));
+		}
+	} else {
+		if (divisor == HSI_HSR_DIVISOR_AUTO && sport->counters_on) {
+			/* auto mode: deactivate timeout */
+			sport->reg_counters = hsi_inl(base,
+						HSI_HSR_COUNTERS_REG(port));
+			sport->counters_on = 0;
+			hsi_outl(0, base, HSI_HSR_COUNTERS_REG(port));
+			dev_dbg(hsi_ctrl->dev, "Deactivated SSR timeout\n");
+		} else if (divisor == HSI_SSR_DIVISOR_USE_TIMEOUT &&
+							!sport->counters_on){
+			/* Leave auto mode: restore timeout */
+			hsi_outl(sport->reg_counters, base,
+					HSI_HSR_COUNTERS_REG(port));
+			sport->counters_on = 1;
+			dev_dbg(hsi_ctrl->dev, "Re-activated SSR timeout; "
+					"timeout=0x%lx\n", sport->reg_counters);
+		}
+	}
+
+	return 0;
+}
+
+int hsi_set_rx(struct hsi_port *sport, struct hsr_ctx *cfg)
+{
+	struct hsi_dev *hsi_ctrl = sport->hsi_controller;
+	void __iomem *base = hsi_ctrl->base;
+	int port = sport->port_number;
+	struct platform_device *pdev = to_platform_device(hsi_ctrl->dev);
+
+	if (((cfg->mode & HSI_MODE_VAL_MASK) != HSI_MODE_STREAM) &&
+		((cfg->mode & HSI_MODE_VAL_MASK) != HSI_MODE_FRAME) &&
+		((cfg->mode & HSI_MODE_VAL_MASK) != HSI_MODE_SLEEP) &&
+		(cfg->mode != NOT_SET))
+		return -EINVAL;
+
+	if (hsi_driver_device_is_hsi(pdev)) {
+		if (
+		((cfg->flow & HSI_FLOW_VAL_MASK) != HSI_FLOW_SYNCHRONIZED) &&
+		((cfg->flow & HSI_FLOW_VAL_MASK) != HSI_FLOW_PIPELINED) &&
+			(cfg->flow != NOT_SET))
+			return -EINVAL;
+	} else {
+		if (
+		((cfg->flow & HSI_FLOW_VAL_MASK) != HSI_FLOW_SYNCHRONIZED) &&
+			(cfg->flow != NOT_SET))
+			return -EINVAL;
+	}
+
+	if ((cfg->frame_size > HSI_FRAMESIZE_MAX) &&
+		(cfg->frame_size != NOT_SET))
+		return -EINVAL;
+
+	if ((cfg->channels == 0) ||
+		((cfg->channels > sport->max_ch) &&
+			(cfg->channels != NOT_SET)))
+		return -EINVAL;
+
+	if (hsi_driver_device_is_hsi(pdev)) {
+		if ((cfg->divisor > HSI_MAX_RX_DIVISOR) &&
+			(cfg->divisor != HSI_HSR_DIVISOR_AUTO) &&
+			(cfg->divisor != NOT_SET))
+			return -EINVAL;
+	}
+
+	if ((cfg->mode != NOT_SET) &&
+		(cfg->flow != NOT_SET))
+		hsi_outl(cfg->mode | cfg->flow, base, HSI_HSR_MODE_REG(port));
+
+	if (cfg->frame_size != NOT_SET)
+		hsi_outl(cfg->frame_size, base, HSI_HSR_FRAMESIZE_REG(port));
+
+	if (cfg->channels != NOT_SET) {
+		if ((cfg->channels & (-cfg->channels)) ^ cfg->channels)
+			return -EINVAL;
+		else
+			hsi_outl(cfg->channels, base,
+						HSI_HSR_CHANNELS_REG(port));
+	}
+
+	return hsi_set_rx_divisor(sport, cfg->divisor);
+}
+
+void hsi_get_rx(struct hsi_port *sport, struct hsr_ctx *cfg)
+{
+	struct hsi_dev *hsi_ctrl = sport->hsi_controller;
+	void __iomem *base = hsi_ctrl->base;
+	int port = sport->port_number;
+	struct platform_device *pdev = to_platform_device(hsi_ctrl->dev);
+
+	cfg->mode = hsi_inl(base, HSI_HSR_MODE_REG(port)) & HSI_MODE_VAL_MASK;
+	cfg->flow = hsi_inl(base, HSI_HSR_MODE_REG(port)) & HSI_FLOW_VAL_MASK;
+	cfg->frame_size = hsi_inl(base, HSI_HSR_FRAMESIZE_REG(port));
+	cfg->channels = hsi_inl(base, HSI_HSR_CHANNELS_REG(port));
+	if (hsi_driver_device_is_hsi(pdev))
+		cfg->divisor = hsi_inl(base, HSI_HSR_DIVISOR_REG(port));
+}
+
+int hsi_set_tx(struct hsi_port *sport, struct hst_ctx *cfg)
+{
+	struct hsi_dev *hsi_ctrl = sport->hsi_controller;
+	void __iomem *base = hsi_ctrl->base;
+	int port = sport->port_number;
+	struct platform_device *pdev = to_platform_device(hsi_ctrl->dev);
+	unsigned int max_divisor = hsi_driver_device_is_hsi(pdev) ?
+				HSI_MAX_TX_DIVISOR : HSI_SSI_MAX_TX_DIVISOR;
+
+	if (((cfg->mode & HSI_MODE_VAL_MASK) != HSI_MODE_STREAM) &&
+		((cfg->mode & HSI_MODE_VAL_MASK) != HSI_MODE_FRAME) &&
+		(cfg->mode != NOT_SET))
+		return -EINVAL;
+
+	if (hsi_driver_device_is_hsi(pdev)) {
+		if (
+		((cfg->flow & HSI_FLOW_VAL_MASK) != HSI_FLOW_SYNCHRONIZED) &&
+		((cfg->flow & HSI_FLOW_VAL_MASK) != HSI_FLOW_PIPELINED) &&
+			(cfg->flow != NOT_SET))
+			return -EINVAL;
+	} else {
+		if (
+		((cfg->flow & HSI_FLOW_VAL_MASK) != HSI_FLOW_SYNCHRONIZED) &&
+			(cfg->flow != NOT_SET))
+			return -EINVAL;
+	}
+
+	if ((cfg->frame_size > HSI_FRAMESIZE_MAX) &&
+		(cfg->frame_size != NOT_SET))
+		return -EINVAL;
+
+	if ((cfg->channels == 0) ||
+		((cfg->channels > sport->max_ch) &&
+			(cfg->channels != NOT_SET)))
+		return -EINVAL;
+
+	if ((cfg->divisor > max_divisor) && (cfg->divisor != NOT_SET))
+		return -EINVAL;
+
+	if ((cfg->arb_mode != HSI_ARBMODE_ROUNDROBIN) &&
+		(cfg->arb_mode != HSI_ARBMODE_PRIORITY) &&
+		(cfg->mode != NOT_SET))
+		return -EINVAL;
+
+	if ((cfg->mode != NOT_SET) &&
+		(cfg->flow != NOT_SET))
+		hsi_outl(cfg->mode | cfg->flow | HSI_MODE_WAKE_CTRL_SW,
+				base, HSI_HST_MODE_REG(port));
+
+	if (cfg->frame_size != NOT_SET)
+		hsi_outl(cfg->frame_size, base, HSI_HST_FRAMESIZE_REG(port));
+
+	if (cfg->channels != NOT_SET) {
+		if ((cfg->channels & (-cfg->channels)) ^ cfg->channels)
+			return -EINVAL;
+		else
+			hsi_outl(cfg->channels, base,
+						HSI_HST_CHANNELS_REG(port));
+	}
+
+	if (cfg->divisor != NOT_SET)
+		hsi_outl(cfg->divisor, base, HSI_HST_DIVISOR_REG(port));
+
+	if (cfg->arb_mode != NOT_SET)
+		hsi_outl(cfg->arb_mode, base, HSI_HST_ARBMODE_REG(port));
+
+	return 0;
+}
+
+void hsi_get_tx(struct hsi_port *sport, struct hst_ctx *cfg)
+{
+    struct hsi_dev *hsi_ctrl = sport->hsi_controller;
+    void __iomem *base = hsi_ctrl->base;
+    int port = sport->port_number;
+
+    cfg->mode = hsi_inl(base, HSI_HST_MODE_REG(port)) & HSI_MODE_VAL_MASK;
+    cfg->flow = hsi_inl(base, HSI_HST_MODE_REG(port)) & HSI_FLOW_VAL_MASK;
+    cfg->frame_size = hsi_inl(base, HSI_HST_FRAMESIZE_REG(port));
+    cfg->channels = hsi_inl(base, HSI_HST_CHANNELS_REG(port));
+    cfg->divisor = hsi_inl(base, HSI_HST_DIVISOR_REG(port));
+    cfg->arb_mode = hsi_inl(base, HSI_HST_ARBMODE_REG(port));
+}
+
+/**
+ * hsi_open - open a hsi device channel.
+ * @dev - Reference to the hsi device channel to be openned.
+ *
+ * Returns 0 on success, -EINVAL on bad parameters, -EBUSY if is already opened.
+ */
+int hsi_open(struct hsi_device *dev)
+{
+	struct hsi_channel *ch;
+	struct hsi_port *port;
+	struct hsi_dev *hsi_ctrl;
+
+	if (!dev || !dev->ch) {
+		pr_err(LOG_NAME "Wrong HSI device %p\n", dev);
+		return -EINVAL;
+	}
+
+	ch = dev->ch;
+	if (!ch->read_done || !ch->write_done) {
+		dev_err(&dev->device, "Trying to open with no (read/write) "
+						"callbacks registered\n");
+		return -EINVAL;
+	}
+	port = ch->hsi_port;
+	hsi_ctrl = port->hsi_controller;
+	spin_lock_bh(&hsi_ctrl->lock);
+	if (ch->flags & HSI_CH_OPEN) {
+		dev_err(&dev->device, "Port %d Channel %d already OPENED\n",
+							dev->n_p, dev->n_ch);
+		spin_unlock_bh(&hsi_ctrl->lock);
+		return -EBUSY;
+	}
+	clk_enable(hsi_ctrl->hsi_clk);
+	ch->flags |= HSI_CH_OPEN;
+
+	hsi_outl_or(HSI_ERROROCCURED | HSI_BREAKDETECTED, hsi_ctrl->base,
+		HSI_SYS_MPU_ENABLE_REG(port->port_number, port->n_irq));
+	/* NOTE: error and break are port events and do not need to be
+	 * enabled for HSI extended enable register */
+
+	clk_disable(hsi_ctrl->hsi_clk);
+	spin_unlock_bh(&hsi_ctrl->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(hsi_open);
+
+/**
+ * hsi_write - write data into the hsi device channel
+ * @dev - reference to the hsi device channel to write into.
+ * @addr - pointer to a 32-bit word data to be written.
+ * @size - number of 32-bit word to be written.
+ *
+ * Return 0 on sucess, a negative value on failure.
+ * A success value only indicates that the request has been accepted.
+ * Transfer is only completed when the write_done callback is called.
+ *
+ */
+int hsi_write(struct hsi_device *dev, u32 *addr, unsigned int size)
+{
+	struct hsi_channel *ch;
+	int err;
+
+	if (unlikely(!dev || !dev->ch || !addr || (size <= 0))) {
+		dev_err(&dev->device, "Wrong paramenters "
+			"hsi_device %p data %p count %d", dev, addr, size);
+		return -EINVAL;
+	}
+	if (unlikely(!(dev->ch->flags & HSI_CH_OPEN))) {
+		dev_err(&dev->device, "HSI device NOT open\n");
+		return -EINVAL;
+	}
+
+	ch = dev->ch;
+	spin_lock_bh(&ch->hsi_port->hsi_controller->lock);
+	ch->write_data.addr = addr;
+	ch->write_data.size = size;
+
+	if (size == 1)
+		err = hsi_driver_write_interrupt(ch, addr);
+	else
+		err = hsi_driver_write_dma(ch, addr, size);
+
+	if (unlikely(err < 0)) {
+		ch->write_data.addr = NULL;
+		ch->write_data.size = 0;
+	}
+	spin_unlock_bh(&ch->hsi_port->hsi_controller->lock);
+
+	return err;
+
+}
+EXPORT_SYMBOL(hsi_write);
+
+/**
+ * hsi_read - read data from the hsi device channel
+ * @dev - hsi device channel reference to read data from.
+ * @addr - pointer to a 32-bit word data to store the data.
+ * @size - number of 32-bit word to be stored.
+ *
+ * Return 0 on sucess, a negative value on failure.
+ * A success value only indicates that the request has been accepted.
+ * Data is only available in the buffer when the read_done callback is called.
+ *
+ */
+int hsi_read(struct hsi_device *dev, u32 *addr, unsigned int size)
+{
+	struct hsi_channel *ch;
+	int err;
+
+	if (unlikely(!dev || !dev->ch || !addr || (size <= 0))) {
+		dev_err(&dev->device, "Wrong paramenters "
+			"hsi_device %p data %p count %d", dev, addr, size);
+		return -EINVAL;
+	}
+	if (unlikely(!(dev->ch->flags & HSI_CH_OPEN))) {
+		dev_err(&dev->device, "HSI device NOT open\n");
+		return -EINVAL;
+	}
+
+	ch = dev->ch;
+	spin_lock_bh(&ch->hsi_port->hsi_controller->lock);
+	ch->read_data.addr = addr;
+	ch->read_data.size = size;
+
+	if (size == 1)
+		err = hsi_driver_read_interrupt(ch, addr);
+	else
+		err = hsi_driver_read_dma(ch, addr, size);
+
+	if (unlikely(err < 0)) {
+		ch->read_data.addr = NULL;
+		ch->read_data.size = 0;
+	}
+	spin_unlock_bh(&ch->hsi_port->hsi_controller->lock);
+
+	return err;
+}
+EXPORT_SYMBOL(hsi_read);
+
+void __hsi_write_cancel(struct hsi_channel *ch)
+{
+	if (ch->write_data.size == 1)
+		hsi_driver_cancel_write_interrupt(ch);
+	else if (ch->write_data.size > 1)
+		hsi_driver_cancel_write_dma(ch);
+
+}
+/**
+ * hsi_write_cancel - Cancel pending write request.
+ * @dev - hsi device channel where to cancel the pending write.
+ *
+ * write_done() callback will not be called after sucess of this function.
+ */
+void hsi_write_cancel(struct hsi_device *dev)
+{
+	if (unlikely(!dev || !dev->ch)) {
+		pr_err(LOG_NAME "Wrong HSI device %p\n", dev);
+		return;
+	}
+	if (unlikely(!(dev->ch->flags & HSI_CH_OPEN))) {
+		dev_err(&dev->device, "HSI device NOT open\n");
+		return;
+	}
+
+	spin_lock_bh(&dev->ch->hsi_port->hsi_controller->lock);
+	__hsi_write_cancel(dev->ch);
+	spin_unlock_bh(&dev->ch->hsi_port->hsi_controller->lock);
+}
+EXPORT_SYMBOL(hsi_write_cancel);
+
+void __hsi_read_cancel(struct hsi_channel *ch)
+{
+	if (ch->read_data.size == 1)
+		hsi_driver_cancel_read_interrupt(ch);
+	else if (ch->read_data.size > 1)
+		hsi_driver_cancel_read_dma(ch);
+}
+
+/**
+ * hsi_read_cancel - Cancel pending read request.
+ * @dev - hsi device channel where to cancel the pending read.
+ *
+ * read_done() callback will not be called after sucess of this function.
+ */
+void hsi_read_cancel(struct hsi_device *dev)
+{
+	if (unlikely(!dev || !dev->ch)) {
+		pr_err(LOG_NAME "Wrong HSI device %p\n", dev);
+		return;
+	}
+
+	if (unlikely(!(dev->ch->flags & HSI_CH_OPEN))) {
+		dev_err(&dev->device, "HSI device NOT open\n");
+		return;
+	}
+
+	spin_lock_bh(&dev->ch->hsi_port->hsi_controller->lock);
+	__hsi_read_cancel(dev->ch);
+	spin_unlock_bh(&dev->ch->hsi_port->hsi_controller->lock);
+
+}
+EXPORT_SYMBOL(hsi_read_cancel);
+
+/**
+ * hsi_poll - HSI poll
+ * @dev - hsi device channel reference to apply the I/O control
+ * 						(or port associated to it)
+ *
+ * Return 0 on sucess, a negative value on failure.
+ *
+ */
+int hsi_poll(struct hsi_device *dev)
+{
+	struct hsi_channel *ch;
+	int err;
+
+	if (unlikely(!dev || !dev->ch))
+		return -EINVAL;
+
+	if (unlikely(!(dev->ch->flags & HSI_CH_OPEN))) {
+		dev_err(&dev->device, "HSI device NOT open\n");
+		return -EINVAL;
+	}
+
+	ch = dev->ch;
+	spin_lock_bh(&ch->hsi_port->hsi_controller->lock);
+	ch->flags |= HSI_CH_RX_POLL;
+	err = hsi_driver_read_interrupt(ch, NULL);
+	spin_unlock_bh(&ch->hsi_port->hsi_controller->lock);
+
+	return err;
+}
+EXPORT_SYMBOL(hsi_poll);
+
+
+/**
+ * hsi_ioctl - HSI I/O control
+ * @dev - hsi device channel reference to apply the I/O control
+ * 						(or port associated to it)
+ * @command - HSI I/O control command
+ * @arg - parameter associated to the control command. NULL, if no parameter.
+ *
+ * Return 0 on sucess, a negative value on failure.
+ *
+ */
+int hsi_ioctl(struct hsi_device *dev, unsigned int command, void *arg)
+{
+	struct hsi_channel *ch;
+	struct hsi_dev *hsi_ctrl;
+	void __iomem *base;
+	unsigned int port, channel;
+	u32 wake;
+	int err = 0;
+
+	if (unlikely((!dev) ||
+		(!dev->ch) ||
+		(!dev->ch->hsi_port) ||
+		(!dev->ch->hsi_port->hsi_controller)) ||
+		(!(dev->ch->flags & HSI_CH_OPEN))) {
+		pr_err(LOG_NAME "HSI IOCTL Invalid parameter\n");
+		return -EINVAL;
+	}
+
+	ch = dev->ch;
+	hsi_ctrl = ch->hsi_port->hsi_controller;
+	port = ch->hsi_port->port_number;
+	channel = ch->channel_number;
+	base = hsi_ctrl->base;
+	clk_enable(hsi_ctrl->hsi_clk);
+
+	switch (command) {
+	case HSI_IOCTL_WAKE_UP:
+		/* We only claim once the wake line per channel */
+		wake = hsi_inl(base, HSI_SYS_WAKE_REG(port));
+		if (!(wake & HSI_WAKE(channel))) {
+			clk_enable(hsi_ctrl->hsi_clk);
+			hsi_outl(HSI_WAKE(channel), base,
+					HSI_SYS_SET_WAKE_REG(port));
+		}
+		break;
+	case HSI_IOCTL_WAKE_DOWN:
+		wake = hsi_inl(base, HSI_SYS_WAKE_REG(port));
+		if ((wake & HSI_WAKE(channel))) {
+			hsi_outl(HSI_WAKE(channel), base,
+						HSI_SYS_CLEAR_WAKE_REG(port));
+			clk_disable(hsi_ctrl->hsi_clk);
+		}
+		break;
+	case HSI_IOCTL_SEND_BREAK:
+		hsi_outl(1, base, HSI_HST_BREAK_REG(port));
+		break;
+	case HSI_IOCTL_WAKE:
+		if (arg == NULL)
+			err = -EINVAL;
+		else
+			*(u32 *)arg = hsi_inl(base, HSI_SYS_WAKE_REG(port));
+		break;
+	case HSI_IOCTL_FLUSH_RX:
+		hsi_outl(0, base, HSI_HSR_RXSTATE_REG(port));
+		break;
+	case HSI_IOCTL_FLUSH_TX:
+		hsi_outl(0, base, HSI_HST_TXSTATE_REG(port));
+		break;
+	case HSI_IOCTL_CAWAKE:
+		if (!arg) {
+			err = -EINVAL;
+			goto out;
+		}
+		if (dev->ch->hsi_port->cawake_gpio < 0) {
+			err = -ENODEV;
+			goto out;
+		}
+		*(unsigned int *)arg = hsi_cawake(dev->ch->hsi_port);
+		break;
+	case HSI_IOCTL_SET_RX:
+		if (!arg) {
+			err = -EINVAL;
+			goto out;
+		}
+		err = hsi_set_rx(dev->ch->hsi_port, (struct hsr_ctx *)arg);
+		break;
+	case HSI_IOCTL_GET_RX:
+		if (!arg) {
+			err = -EINVAL;
+			goto out;
+		}
+		hsi_get_rx(dev->ch->hsi_port, (struct hsr_ctx *)arg);
+		break;
+	case HSI_IOCTL_SET_TX:
+		if (!arg) {
+			err = -EINVAL;
+			goto out;
+		}
+		err = hsi_set_tx(dev->ch->hsi_port, (struct hst_ctx *)arg);
+		break;
+	case HSI_IOCTL_GET_TX:
+		if (!arg) {
+			err = -EINVAL;
+			goto out;
+		}
+		hsi_get_tx(dev->ch->hsi_port, (struct hst_ctx *)arg);
+		break;
+	default:
+		err = -ENOIOCTLCMD;
+		break;
+	}
+out:
+	clk_disable(hsi_ctrl->hsi_clk);
+
+	return err;
+}
+EXPORT_SYMBOL(hsi_ioctl);
+
+/**
+ * hsi_close - close given hsi device channel
+ * @dev - reference to hsi device channel.
+ */
+void hsi_close(struct hsi_device *dev)
+{
+	if (!dev || !dev->ch) {
+		pr_err(LOG_NAME "Trying to close wrong HSI device %p\n", dev);
+		return;
+	}
+
+	spin_lock_bh(&dev->ch->hsi_port->hsi_controller->lock);
+	if (dev->ch->flags & HSI_CH_OPEN) {
+		dev->ch->flags &= ~HSI_CH_OPEN;
+		__hsi_write_cancel(dev->ch);
+		__hsi_read_cancel(dev->ch);
+	}
+	spin_unlock_bh(&dev->ch->hsi_port->hsi_controller->lock);
+}
+EXPORT_SYMBOL(hsi_close);
+
+/**
+ * hsi_set_read_cb - register read_done() callback.
+ * @dev - reference to hsi device channel where the callback is associated to.
+ * @read_cb - callback to signal read transfer completed.
+ *
+ * NOTE: Write callback must be only set when channel is not open !
+ */
+void hsi_set_read_cb(struct hsi_device *dev,
+		void (*read_cb)(struct hsi_device *dev, unsigned int size))
+{
+	dev->ch->read_done = read_cb;
+}
+EXPORT_SYMBOL(hsi_set_read_cb);
+
+/**
+ * hsi_set_read_cb - register write_done() callback.
+ * @dev - reference to hsi device channel where the callback is associated to.
+ * @write_cb - callback to signal read transfer completed.
+ *
+ * NOTE: Read callback must be only set when channel is not open !
+ */
+void hsi_set_write_cb(struct hsi_device *dev,
+		void (*write_cb)(struct hsi_device *dev, unsigned int size))
+{
+	dev->ch->write_done = write_cb;
+}
+EXPORT_SYMBOL(hsi_set_write_cb);
+
+/**
+ * hsi_set_port_event_cb - register port_event callback.
+ * @dev - reference to hsi device channel where the callback is associated to.
+ * @port_event_cb - callback to signal events from the channel port.
+ */
+void hsi_set_port_event_cb(struct hsi_device *dev,
+				void (*port_event_cb)(struct hsi_device *dev,
+						unsigned int event, void *arg))
+{
+	write_lock_bh(&dev->ch->rw_lock);
+	dev->ch->port_event = port_event_cb;
+	write_unlock_bh(&dev->ch->rw_lock);
+}
+EXPORT_SYMBOL(hsi_set_port_event_cb);
diff --git a/include/linux/hsi_driver_if.h b/include/linux/hsi_driver_if.h
new file mode 100644
index 0000000..9d9ae69
--- /dev/null
+++ b/include/linux/hsi_driver_if.h
@@ -0,0 +1,180 @@
+/*
+ * hsi_driver_if.h
+ *
+ * Header for the HSI driver low level interface.
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
+#ifndef __HSI_DRIVER_IF_H__
+#define __HSI_DRIVER_IF_H__
+
+#include <linux/device.h>
+#include <linux/clk.h>
+#include <linux/notifier.h>
+
+/* The number of ports handled by the driver (MAX:2). Reducing this value
+ * optimizes the driver memory footprint.
+ */
+#define HSI_MAX_PORTS		1
+
+/* bit-field definition for allowed controller IDs and channels */
+#define ANY_HSI_CONTROLLER	-1
+
+/* HSR special divisor values set to control the auto-divisor Rx mode */
+#define HSI_HSR_DIVISOR_AUTO		0x1000 /* Activate auto Rx */
+#define HSI_SSR_DIVISOR_USE_TIMEOUT	0x1001 /* De-activate auto-Rx for SSI */
+
+enum {
+	HSI_EVENT_BREAK_DETECTED = 0,
+	HSI_EVENT_ERROR,
+	HSI_EVENT_PRE_SPEED_CHANGE,
+	HSI_EVENT_POST_SPEED_CHANGE,
+	HSI_EVENT_CAWAKE_UP,
+	HSI_EVENT_CAWAKE_DOWN,
+	HSI_EVENT_HSR_DATAAVAILABLE,
+};
+
+enum {
+	HSI_IOCTL_WAKE_UP,
+	HSI_IOCTL_WAKE_DOWN,
+	HSI_IOCTL_SEND_BREAK,
+	HSI_IOCTL_WAKE,
+	HSI_IOCTL_FLUSH_RX,
+	HSI_IOCTL_FLUSH_TX,
+	HSI_IOCTL_CAWAKE,
+	HSI_IOCTL_SET_RX,
+	HSI_IOCTL_GET_RX,
+	HSI_IOCTL_SET_TX,
+	HSI_IOCTL_GET_TX,
+};
+
+/* Forward references */
+struct hsi_device;
+struct hsi_channel;
+
+/* DPS */
+struct hst_ctx {
+	u32 mode;
+	u32 flow;
+	u32 frame_size;
+	u32 divisor;
+	u32 arb_mode;
+	u32 channels;
+};
+
+struct hsr_ctx {
+	u32 mode;
+	u32 flow;
+	u32 frame_size;
+	u32 divisor;
+	u32 timeout;
+	u32 channels;
+};
+
+struct port_ctx {
+	u32 sys_mpu_enable[2];
+	struct hst_ctx hst;
+	struct hsr_ctx hsr;
+};
+
+/**
+ * struct ctrl_ctx - hsi controller regs context
+ * @loss_count: hsi last loss count
+ * @sysconfig: keeps sysconfig reg state
+ * @gdd_gcr: keeps gcr reg state
+ * @pctx: array of port context
+ */
+struct ctrl_ctx {
+	int loss_count;
+	u32 sysconfig;
+	u32 gdd_gcr;
+	struct port_ctx *pctx;
+};
+/* END DPS */
+
+struct hsi_platform_data {
+	void (*set_min_bus_tput)(struct device *dev, u8 agent_id,
+							unsigned long r);
+	int (*clk_notifier_register)(struct clk *clk,
+						struct notifier_block *nb);
+	int (*clk_notifier_unregister)(struct clk *clk,
+						struct notifier_block *nb);
+	u8 num_ports;
+	struct ctrl_ctx ctx;
+};
+
+/**
+ * struct hsi_device - HSI device object
+ * @n_ctrl: associated HSI controller platform id number
+ * @n_p: port number
+ * @n_ch: channel number
+ * @modalias: [to be removed]
+ * @ch: channel descriptor
+ * @device: associated device
+*/
+struct hsi_device {
+	int n_ctrl;
+	unsigned int n_p;
+	unsigned int n_ch;
+	struct hsi_channel *ch;
+	struct device device;
+};
+
+#define to_hsi_device(dev)	container_of(dev, struct hsi_device, device)
+
+/**
+ * struct hsi_device_driver - HSI driver instance container
+ * @ctrl_mask: bit-field indicating the supported HSI device ids
+ * @ch_mask: bit-field indicating enabled channels for this port
+ * @probe: probe callback (driver registering)
+ * @remove: remove callback (driver un-registering)
+ * @suspend: suspend callback
+ * @resume: resume callback
+ * @driver: associated device_driver object
+*/
+struct hsi_device_driver {
+	unsigned long		ctrl_mask;
+	unsigned long		ch_mask[HSI_MAX_PORTS];
+	int			(*probe)(struct hsi_device *dev);
+	int			(*remove)(struct hsi_device *dev);
+	int			(*suspend)(struct hsi_device *dev,
+						pm_message_t mesg);
+	int			(*resume)(struct hsi_device *dev);
+	struct device_driver	driver;
+};
+
+#define to_hsi_device_driver(drv) container_of(drv, \
+						struct hsi_device_driver, \
+						driver)
+
+int hsi_register_driver(struct hsi_device_driver *driver);
+void hsi_unregister_driver(struct hsi_device_driver *driver);
+int hsi_open(struct hsi_device *dev);
+int hsi_write(struct hsi_device *dev, u32 *addr, unsigned int size);
+void hsi_write_cancel(struct hsi_device *dev);
+int hsi_read(struct hsi_device *dev, u32 *addr, unsigned int size);
+void hsi_read_cancel(struct hsi_device *dev);
+int hsi_poll(struct hsi_device *dev);
+int hsi_ioctl(struct hsi_device *dev, unsigned int command, void *arg);
+void hsi_close(struct hsi_device *dev);
+void hsi_set_read_cb(struct hsi_device *dev,
+		void (*read_cb)(struct hsi_device *dev, unsigned int size));
+void hsi_set_write_cb(struct hsi_device *dev,
+		void (*write_cb)(struct hsi_device *dev, unsigned int size));
+void hsi_set_port_event_cb(struct hsi_device *dev,
+				void (*port_event_cb)(struct hsi_device *dev,
+					unsigned int event, void *arg));
+#endif /* __HSI_DRIVER_IF_H__ */
-- 
1.6.0.4

