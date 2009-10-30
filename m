From: Sebastien Jan <s-jan@ti.com>
Subject: [RFC PATCH 2/9] HSI: Low Level Driver core
Date: Fri, 30 Oct 2009 11:00:01 +0100
Message-ID: <1256896808-20152-3-git-send-email-s-jan@ti.com>
References: <1256896808-20152-1-git-send-email-s-jan@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55340 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756759AbZJ3J7A (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Oct 2009 05:59:00 -0400
In-Reply-To: <1256896808-20152-1-git-send-email-s-jan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sebastien Jan <s-jan@ti.com>, Carlos Chinea <carlos.chinea@nokia.com>

Driver core implementation (driver registration, ...)
Driver types definitions
HSI bus implementation

Signed-off-by: Sebastien Jan <s-jan@ti.com>
Signed-off-by: Carlos Chinea <carlos.chinea@nokia.com>
---
 drivers/hsi/hsi_driver.c     |  644 ++++++++++++++++++++++++++++++++++++++++++
 drivers/hsi/hsi_driver.h     |  308 ++++++++++++++++++++
 drivers/hsi/hsi_driver_bus.c |  182 ++++++++++++
 3 files changed, 1134 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hsi/hsi_driver.c
 create mode 100644 drivers/hsi/hsi_driver.h
 create mode 100644 drivers/hsi/hsi_driver_bus.c

diff --git a/drivers/hsi/hsi_driver.c b/drivers/hsi/hsi_driver.c
new file mode 100644
index 0000000..4abaf08
--- /dev/null
+++ b/drivers/hsi/hsi_driver.c
@@ -0,0 +1,644 @@
+/*
+ * hsi_driver.c
+ *
+ * Implements HSI module interface, initialization, and PM related functions.
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
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/list.h>
+#include <mach/clock.h>
+#include "hsi_driver.h"
+
+#define	HSI_DRIVER_VERSION	"0.1"
+#define HSI_RESETDONE_TIMEOUT	10	/* 10 ms */
+#define HSI_RESETDONE_RETRIES	20	/* => max 200 ms waiting for reset */
+
+/* NOTE: Function called in interrupt context */
+int hsi_port_event_handler(struct hsi_port *p, unsigned int event, void *arg)
+{
+	struct hsi_channel *hsi_channel;
+	int ch;
+
+	if (event == HSI_EVENT_HSR_DATAAVAILABLE) {
+		/* The data-available event is channel-specific and must not be
+		 * broadcasted
+		 */
+		hsi_channel = p->hsi_channel + (int)arg;
+		read_lock(&hsi_channel->rw_lock);
+		if ((hsi_channel->dev) && (hsi_channel->port_event))
+			hsi_channel->port_event(hsi_channel->dev, event, arg);
+		read_unlock(&hsi_channel->rw_lock);
+	} else {
+		for (ch = 0; ch < p->max_ch; ch++) {
+			hsi_channel = p->hsi_channel + ch;
+			read_lock(&hsi_channel->rw_lock);
+			if ((hsi_channel->dev) && (hsi_channel->port_event))
+				hsi_channel->port_event(hsi_channel->dev,
+								event, arg);
+			read_unlock(&hsi_channel->rw_lock);
+		}
+	}
+	return 0;
+}
+
+static int hsi_clk_event(struct notifier_block *nb, unsigned long event,
+			 void *data)
+{
+/* TODO - implement support for clocks changes
+	switch (event) {
+	case CLK_PRE_RATE_CHANGE:
+		break;
+	case CLK_ABORT_RATE_CHANGE:
+		break;
+	case CLK_POST_RATE_CHANGE:
+		break;
+	default:
+		break;
+	}
+*/
+
+	/*
+	 * TODO: At this point we may emit a port event warning about the
+	 * clk frequency change to the upper layers.
+	 */
+	return NOTIFY_DONE;
+}
+
+static void hsi_dev_release(struct device *dev)
+{
+	/* struct device kfree is already made in unregister_hsi_devices().
+	 * Registering this function is necessary to avoid an error from
+	 * the device_release() function.
+	 */
+}
+
+static int __init reg_hsi_dev_ch(struct hsi_dev *hsi_ctrl, unsigned int p,
+				 unsigned int ch)
+{
+	struct hsi_device *dev;
+	struct hsi_port *port = &hsi_ctrl->hsi_port[p];
+	int err;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->n_ctrl = hsi_ctrl->id;
+	dev->n_p = p;
+	dev->n_ch = ch;
+	dev->ch = &port->hsi_channel[ch];
+	dev->device.bus = &hsi_bus_type;
+	dev->device.parent = hsi_ctrl->dev;
+	dev->device.release = hsi_dev_release;
+	if (dev->n_ctrl < 0)
+		dev_set_name(&dev->device, "omap_hsi-p%u.c%u", p, ch);
+	else
+		dev_set_name(&dev->device, "omap_hsi%d-p%u.c%u", dev->n_ctrl, p,
+			     ch);
+
+	err = device_register(&dev->device);
+	if (err >= 0) {
+		write_lock_bh(&port->hsi_channel[ch].rw_lock);
+		port->hsi_channel[ch].dev = dev;
+		write_unlock_bh(&port->hsi_channel[ch].rw_lock);
+	} else {
+		kfree(dev);
+	}
+	return err;
+}
+
+static int __init register_hsi_devices(struct hsi_dev *hsi_ctrl)
+{
+	int port;
+	int ch;
+	int err;
+
+	for (port = 0; port < hsi_ctrl->max_p; port++)
+		for (ch = 0; ch < hsi_ctrl->hsi_port[port].max_ch; ch++) {
+			err = reg_hsi_dev_ch(hsi_ctrl, port, ch);
+			if (err < 0)
+				return err;
+		}
+
+	return 0;
+}
+
+static int __init hsi_softreset(struct hsi_dev *hsi_ctrl)
+{
+	int ind = 0;
+	void __iomem *base = hsi_ctrl->base;
+	u32 status;
+
+	hsi_outl_or(HSI_SOFTRESET, base, HSI_SYS_SYSCONFIG_REG);
+
+	status = hsi_inl(base, HSI_SYS_SYSSTATUS_REG);
+	while ((!(status & HSI_RESETDONE)) && (ind < HSI_RESETDONE_RETRIES)) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(msecs_to_jiffies(HSI_RESETDONE_TIMEOUT));
+		status = hsi_inl(base, HSI_SYS_SYSSTATUS_REG);
+		ind++;
+	}
+
+	if (ind >= HSI_RESETDONE_RETRIES)
+		return -EIO;
+
+	/* Reseting GDD */
+	hsi_outl_or(HSI_SWRESET, base, HSI_GDD_GRST_REG);
+
+	return 0;
+}
+
+static void __init set_hsi_ports_default(struct hsi_dev *hsi_ctrl,
+					 struct platform_device *pd)
+{
+	struct port_ctx *cfg;
+	struct hsi_platform_data *pdata = pd->dev.platform_data;
+	unsigned int port = 0;
+	void __iomem *base = hsi_ctrl->base;
+	struct platform_device *pdev = to_platform_device(hsi_ctrl->dev);
+
+	for (port = 1; port <= pdata->num_ports; port++) {
+		cfg = &pdata->ctx.pctx[port - 1];
+		hsi_outl(cfg->hst.mode | cfg->hst.flow | HSI_MODE_WAKE_CTRL_SW,
+			 base, HSI_HST_MODE_REG(port));
+		if (!hsi_driver_device_is_hsi(pdev))
+			hsi_outl(cfg->hst.frame_size, base,
+						 HSI_HST_FRAMESIZE_REG(port));
+		hsi_outl(cfg->hst.divisor, base, HSI_HST_DIVISOR_REG(port));
+		hsi_outl(cfg->hst.channels, base, HSI_HST_CHANNELS_REG(port));
+		hsi_outl(cfg->hst.arb_mode, base, HSI_HST_ARBMODE_REG(port));
+
+		hsi_outl(cfg->hsr.mode | cfg->hsr.flow, base,
+			 HSI_HSR_MODE_REG(port));
+		hsi_outl(cfg->hsr.frame_size, base,
+			 HSI_HSR_FRAMESIZE_REG(port));
+		hsi_outl(cfg->hsr.channels, base, HSI_HSR_CHANNELS_REG(port));
+		if (hsi_driver_device_is_hsi(pdev))
+			hsi_outl(cfg->hsr.divisor, base,
+						HSI_HSR_DIVISOR_REG(port));
+		hsi_outl(cfg->hsr.timeout, base, HSI_HSR_COUNTERS_REG(port));
+	}
+
+	if (hsi_driver_device_is_hsi(pdev)) {
+		/* SW strategy for HSI fifo management can be changed here */
+		hsi_fifo_mapping(hsi_ctrl, HSI_FIFO_MAPPING_DEFAULT);
+	}
+}
+
+static int __init hsi_port_channels_init(struct hsi_port *port)
+{
+	struct hsi_channel *ch;
+	unsigned int ch_i;
+
+	for (ch_i = 0; ch_i < port->max_ch; ch_i++) {
+		ch = &port->hsi_channel[ch_i];
+		ch->channel_number = ch_i;
+		rwlock_init(&ch->rw_lock);
+		ch->flags = 0;
+		ch->hsi_port = port;
+		ch->read_data.addr = NULL;
+		ch->read_data.size = 0;
+		ch->read_data.lch = -1;
+		ch->write_data.addr = NULL;
+		ch->write_data.size = 0;
+		ch->write_data.lch = -1;
+		ch->dev = NULL;
+		ch->read_done = NULL;
+		ch->write_done = NULL;
+		ch->port_event = NULL;
+	}
+
+	return 0;
+}
+
+static void hsi_ports_exit(struct hsi_dev *hsi_ctrl, unsigned int max_ports)
+{
+	struct hsi_port *hsi_p;
+	unsigned int port;
+
+	for (port = 0; port < max_ports; port++) {
+		hsi_p = &hsi_ctrl->hsi_port[port];
+		hsi_mpu_exit(hsi_p);
+		hsi_cawake_exit(hsi_p);
+	}
+}
+
+static int __init hsi_request_mpu_irq(struct hsi_port *hsi_p)
+{
+	struct hsi_dev *hsi_ctrl = hsi_p->hsi_controller;
+	struct platform_device *pd = to_platform_device(hsi_ctrl->dev);
+	struct resource *mpu_irq;
+
+	if (hsi_driver_device_is_hsi(pd))
+		mpu_irq = platform_get_resource(pd, IORESOURCE_IRQ,
+					hsi_p->port_number - 1);
+	else /* SSI support 2 IRQs per port */
+		mpu_irq = platform_get_resource(pd, IORESOURCE_IRQ,
+					(hsi_p->port_number - 1) * 2);
+
+	if (!mpu_irq) {
+		dev_err(hsi_ctrl->dev, "HSI misses info for MPU IRQ on"
+			" port %d\n", hsi_p->port_number);
+		return -ENXIO;
+	}
+	hsi_p->n_irq = 0;	/* We only use one irq line */
+	hsi_p->irq = mpu_irq->start;
+	return hsi_mpu_init(hsi_p, mpu_irq->name);
+}
+
+static int __init hsi_request_cawake_irq(struct hsi_port *hsi_p)
+{
+	struct hsi_dev *hsi_ctrl = hsi_p->hsi_controller;
+	struct platform_device *pd = to_platform_device(hsi_ctrl->dev);
+	struct resource *cawake_irq;
+
+	if (hsi_driver_device_is_hsi(pd)) {
+		hsi_p->cawake_gpio = -1;
+		return 0;
+	} else {
+		cawake_irq = platform_get_resource(pd, IORESOURCE_IRQ,
+					   4 + hsi_p->port_number);
+	}
+
+	if (!cawake_irq) {
+		dev_err(hsi_ctrl->dev, "SSI device misses info for CAWAKE"
+			"IRQ on port %d\n", hsi_p->port_number);
+		return -ENXIO;
+	}
+
+	if (cawake_irq->flags & IORESOURCE_UNSET) {
+		dev_info(hsi_ctrl->dev, "No CAWAKE GPIO support\n");
+		hsi_p->cawake_gpio = -1;
+		return 0;
+	}
+
+	hsi_p->cawake_gpio_irq = cawake_irq->start;
+	hsi_p->cawake_gpio = irq_to_gpio(cawake_irq->start);
+	return hsi_cawake_init(hsi_p, cawake_irq->name);
+}
+
+static int __init hsi_ports_init(struct hsi_dev *hsi_ctrl)
+{
+	struct platform_device *pd = to_platform_device(hsi_ctrl->dev);
+	struct hsi_platform_data *pdata = pd->dev.platform_data;
+	struct hsi_port *hsi_p;
+	unsigned int port;
+	int err;
+
+	for (port = 0; port < hsi_ctrl->max_p; port++) {
+		hsi_p = &hsi_ctrl->hsi_port[port];
+		hsi_p->port_number = port + 1;
+		hsi_p->hsi_controller = hsi_ctrl;
+		hsi_p->max_ch = hsi_driver_device_is_hsi(pd) ?
+				HSI_CHANNELS_MAX : HSI_SSI_CHANNELS_MAX;
+		hsi_p->max_ch = min(hsi_p->max_ch, (u8) HSI_PORT_MAX_CH);
+		hsi_p->irq = 0;
+		hsi_p->counters_on = 1;
+		hsi_p->reg_counters = pdata->ctx.pctx[port].hsr.timeout;
+		spin_lock_init(&hsi_p->lock);
+		err = hsi_port_channels_init(&hsi_ctrl->hsi_port[port]);
+		if (err < 0)
+			goto rback1;
+		err = hsi_request_mpu_irq(hsi_p);
+		if (err < 0)
+			goto rback2;
+		err = hsi_request_cawake_irq(hsi_p);
+		if (err < 0)
+			goto rback3;
+	}
+	return 0;
+rback3:
+	hsi_mpu_exit(hsi_p);
+rback2:
+	hsi_ports_exit(hsi_ctrl, port + 1);
+rback1:
+	return err;
+}
+
+static int __init hsi_request_gdd_irq(struct hsi_dev *hsi_ctrl)
+{
+	struct platform_device *pd = to_platform_device(hsi_ctrl->dev);
+	struct resource *gdd_irq;
+
+	if (hsi_driver_device_is_hsi(pd))
+		gdd_irq = platform_get_resource(pd, IORESOURCE_IRQ, 2);
+	else
+		gdd_irq = platform_get_resource(pd, IORESOURCE_IRQ, 4);
+
+	if (!gdd_irq) {
+		dev_err(hsi_ctrl->dev, "HSI has no GDD IRQ resource\n");
+		return -ENXIO;
+	}
+
+	hsi_ctrl->gdd_irq = gdd_irq->start;
+	return hsi_gdd_init(hsi_ctrl, gdd_irq->name);
+}
+
+static void __init hsi_init_gdd_chan_count(struct hsi_dev *hsi_ctrl)
+{
+	struct platform_device *pd = to_platform_device(hsi_ctrl->dev);
+	struct resource *gdd_chan_count;
+	int i;
+
+	gdd_chan_count = platform_get_resource(pd, IORESOURCE_DMA, 0);
+
+	if (!gdd_chan_count) {
+		dev_warn(hsi_ctrl->dev, "HSI device has no GDD channel count "
+					"resource (use 8 as default)\n");
+		hsi_ctrl->gdd_chan_count = 8;
+	} else {
+		hsi_ctrl->gdd_chan_count = gdd_chan_count->start;
+		/* Check that the number of channels is power of 2 */
+		for (i = 0; i < 16; i++) {
+			if (hsi_ctrl->gdd_chan_count == (1 << i))
+				break;
+		}
+		if (i >= 16)
+			dev_err(hsi_ctrl->dev, "The Number of DMA channels "
+					"shall be a power of 2! (=%d)\n",
+					hsi_ctrl->gdd_chan_count);
+	}
+}
+
+static int __init hsi_controller_init(struct hsi_dev *hsi_ctrl,
+				      struct platform_device *pd)
+{
+	struct hsi_platform_data *pdata = pd->dev.platform_data;
+	struct resource *mem, *ioarea;
+	int err;
+
+	mem = platform_get_resource(pd, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(&pd->dev, "HSI device does not have "
+			"HSI IO memory region information\n");
+		return -ENXIO;
+	}
+
+	ioarea = devm_request_mem_region(&pd->dev, mem->start,
+					 (mem->end - mem->start) + 1,
+					 dev_name(&pd->dev));
+	if (!ioarea) {
+		dev_err(&pd->dev, "Unable to request HSI IO mem region\n");
+		return -EBUSY;
+	}
+
+	hsi_ctrl->phy_base = mem->start;
+	hsi_ctrl->base = devm_ioremap(&pd->dev, mem->start,
+				      (mem->end - mem->start) + 1);
+	if (!hsi_ctrl->base) {
+		dev_err(&pd->dev, "Unable to ioremap HSI base IO address\n");
+		return -ENXIO;
+	}
+
+	hsi_ctrl->id = pd->id;
+	if (pdata->num_ports > HSI_MAX_PORTS) {
+		dev_err(&pd->dev, "The HSI driver does not support enough "
+		"ports!\n");
+		return -ENXIO;
+	}
+	hsi_ctrl->max_p = pdata->num_ports;
+	hsi_ctrl->dev = &pd->dev;
+	spin_lock_init(&hsi_ctrl->lock);
+	hsi_ctrl->hsi_clk = clk_get(&pd->dev, "hsi_clk");
+	hsi_init_gdd_chan_count(hsi_ctrl);
+
+	if (IS_ERR(hsi_ctrl->hsi_clk)) {
+		dev_err(hsi_ctrl->dev, "Unable to get HSI clocks\n");
+		return PTR_ERR(hsi_ctrl->hsi_clk);
+	}
+
+	if (pdata->clk_notifier_register) {
+		hsi_ctrl->hsi_nb.notifier_call = hsi_clk_event;
+		hsi_ctrl->hsi_nb.priority = INT_MAX; /* Let's try to be first */
+		err = pdata->clk_notifier_register(hsi_ctrl->hsi_clk,
+						   &hsi_ctrl->hsi_nb);
+		if (err < 0)
+			goto rback1;
+	}
+
+	err = hsi_ports_init(hsi_ctrl);
+	if (err < 0)
+		goto rback2;
+
+	err = hsi_request_gdd_irq(hsi_ctrl);
+	if (err < 0)
+		goto rback3;
+
+	return 0;
+rback3:
+	hsi_ports_exit(hsi_ctrl, hsi_ctrl->max_p);
+rback2:
+	if (pdata->clk_notifier_unregister)
+		pdata->clk_notifier_unregister(hsi_ctrl->hsi_clk,
+					       &hsi_ctrl->hsi_nb);
+rback1:
+	clk_put(hsi_ctrl->hsi_clk);
+	dev_err(&pd->dev, "Error on hsi_controller initialization\n");
+	return err;
+}
+
+static void hsi_controller_exit(struct hsi_dev *hsi_ctrl)
+{
+	struct hsi_platform_data *pdata = hsi_ctrl->dev->platform_data;
+
+	hsi_gdd_exit(hsi_ctrl);
+	hsi_ports_exit(hsi_ctrl, hsi_ctrl->max_p);
+	if (pdata->clk_notifier_unregister)
+		pdata->clk_notifier_unregister(hsi_ctrl->hsi_clk,
+					       &hsi_ctrl->hsi_nb);
+	clk_put(hsi_ctrl->hsi_clk);
+}
+
+static int __init hsi_probe(struct platform_device *pd)
+{
+	struct hsi_platform_data *pdata = pd->dev.platform_data;
+	struct hsi_dev *hsi_ctrl;
+	u32 revision;
+	int err;
+
+	dev_dbg(&pd->dev, "The platform device probed is an %s\n",
+			hsi_driver_device_is_hsi(pd) ? "HSI" : "SSI");
+
+	if (!pdata) {
+		pr_err(LOG_NAME "No platform_data found on hsi device\n");
+		return -ENXIO;
+	}
+
+	hsi_ctrl = kzalloc(sizeof(*hsi_ctrl), GFP_KERNEL);
+	if (hsi_ctrl == NULL) {
+		dev_err(&pd->dev, "Could not allocate memory for"
+			" struct hsi_dev\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(pd, hsi_ctrl);
+	err = hsi_controller_init(hsi_ctrl, pd);
+	if (err < 0) {
+		dev_err(&pd->dev, "Could not initialize hsi controller:"
+			" %d\n", err);
+		goto rollback1;
+	}
+
+	clk_enable(hsi_ctrl->hsi_clk);
+
+	err = hsi_softreset(hsi_ctrl);
+	if (err < 0)
+		goto rollback2;
+
+	/* Set default PM settings */
+	hsi_outl((HSI_AUTOIDLE | HSI_SIDLEMODE_SMART | HSI_MIDLEMODE_SMART),
+		 hsi_ctrl->base, HSI_SYS_SYSCONFIG_REG);
+	hsi_outl(HSI_CLK_AUTOGATING_ON, hsi_ctrl->base, HSI_GDD_GCR_REG);
+
+	/* Configure HSI ports */
+	set_hsi_ports_default(hsi_ctrl, pd);
+
+	/* Gather info from registers for the driver.(REVISION) */
+	revision = hsi_inl(hsi_ctrl->base, HSI_SYS_REVISION_REG);
+	if (hsi_driver_device_is_hsi(pd))
+		dev_info(hsi_ctrl->dev, "HSI Hardware REVISION 0x%x\n",
+								revision);
+	else
+		dev_info(hsi_ctrl->dev, "SSI Hardware REVISION %d.%d\n",
+					(revision & HSI_SSI_REV_MAJOR) >> 4,
+					(revision & HSI_SSI_REV_MINOR));
+
+
+	err = hsi_debug_add_ctrl(hsi_ctrl);
+	if (err < 0)
+		goto rollback2;
+
+	err = register_hsi_devices(hsi_ctrl);
+	if (err < 0)
+		goto rollback3;
+
+	clk_disable(hsi_ctrl->hsi_clk);
+
+	return err;
+
+rollback3:
+	hsi_debug_remove_ctrl(hsi_ctrl);
+rollback2:
+	clk_disable(hsi_ctrl->hsi_clk);
+	hsi_controller_exit(hsi_ctrl);
+rollback1:
+	kfree(hsi_ctrl);
+	return err;
+}
+
+static void __exit unregister_hsi_devices(struct hsi_dev *hsi_ctrl)
+{
+	struct hsi_port *hsi_p;
+	struct hsi_device *device;
+	unsigned int port;
+	unsigned int ch;
+
+	for (port = 0; port < hsi_ctrl->max_p; port++) {
+		hsi_p = &hsi_ctrl->hsi_port[port];
+		for (ch = 0; ch < hsi_p->max_ch; ch++) {
+			device = hsi_p->hsi_channel[ch].dev;
+			hsi_close(device);
+			device_unregister(&device->device);
+			kfree(device);
+		}
+	}
+}
+
+static int __exit hsi_remove(struct platform_device *pd)
+{
+	struct hsi_dev *hsi_ctrl = platform_get_drvdata(pd);
+
+	if (!hsi_ctrl)
+		return 0;
+
+	unregister_hsi_devices(hsi_ctrl);
+	hsi_debug_remove_ctrl(hsi_ctrl);
+	hsi_controller_exit(hsi_ctrl);
+	kfree(hsi_ctrl);
+
+	return 0;
+}
+
+int hsi_driver_device_is_hsi(struct platform_device *dev)
+{
+	struct platform_device_id *id = platform_get_device_id(dev);
+	return (id->driver_data == HSI_DRV_DEVICE_HSI);
+}
+
+/* List of devices supported by this driver */
+static struct platform_device_id hsi_id_table[] = {
+	{ "omap_hsi",	HSI_DRV_DEVICE_HSI },
+	{ "omap_ssi",	HSI_DRV_DEVICE_SSI },
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, hsi_id_table);
+
+static struct platform_driver hsi_pdriver = {
+	.probe = hsi_probe,
+	.remove = __exit_p(hsi_remove),
+	.driver = {
+		   .name = "omap_hsi",
+		   .owner = THIS_MODULE,
+		   },
+	.id_table = hsi_id_table
+};
+
+static int __init hsi_driver_init(void)
+{
+	int err = 0;
+
+	pr_info("HSI DRIVER Version " HSI_DRIVER_VERSION "\n");
+
+	hsi_bus_init();
+	err = hsi_debug_init();
+	if (err < 0) {
+		pr_err(LOG_NAME "HSI Debugfs failed %d\n", err);
+		goto rback1;
+	}
+	err = platform_driver_probe(&hsi_pdriver, hsi_probe);
+	if (err < 0) {
+		pr_err(LOG_NAME "Platform DRIVER register FAILED: %d\n", err);
+		goto rback2;
+	}
+
+	return 0;
+rback2:
+	hsi_debug_exit();
+rback1:
+	hsi_bus_exit();
+	return err;
+}
+
+static void __exit hsi_driver_exit(void)
+{
+	platform_driver_unregister(&hsi_pdriver);
+	hsi_debug_exit();
+	hsi_bus_exit();
+
+	pr_info("HSI DRIVER removed\n");
+}
+
+module_init(hsi_driver_init);
+module_exit(hsi_driver_exit);
+
+MODULE_ALIAS("platform:omap_hsi");
+MODULE_AUTHOR("Carlos Chinea / Nokia");
+MODULE_AUTHOR("Sebastien JAN / Texas Instruments");
+MODULE_DESCRIPTION("MIPI High-speed Synchronous Serial Interface (HSI) Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hsi/hsi_driver.h b/drivers/hsi/hsi_driver.h
new file mode 100644
index 0000000..711297a
--- /dev/null
+++ b/drivers/hsi/hsi_driver.h
@@ -0,0 +1,308 @@
+/*
+ * hsi_driver.h
+ *
+ * Header file for the HSI driver low level interface.
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
+#ifndef __HSI_DRIVER_H__
+#define __HSI_DRIVER_H__
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/ioport.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/spinlock.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/notifier.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+#include <mach/hsi.h>
+#include <linux/hsi_driver_if.h>
+
+/* Channel states */
+#define	HSI_CH_OPEN		0x01
+#define HSI_CH_RX_POLL		0x10
+
+/*
+ * The number of channels handled by the driver in the ports, or the highest
+ * port channel number (+1) used. (MAX:8 for SSI; 16 for HSI)
+ * Reducing this value optimizes the driver memory footprint.
+ */
+#define HSI_PORT_MAX_CH		4
+
+#define LOG_NAME		"OMAP HSI: "
+
+/* SW strategies for FIFO mapping */
+enum {
+	HSI_FIFO_MAPPING_UNDEF = 0,
+	HSI_FIFO_MAPPING_SSI, /* 8 FIFOs per port (SSI compatible mode) */
+	HSI_FIFO_MAPPING_ALL_PORT1, /* ALL FIFOs mapped on 1st port */
+};
+#define HSI_FIFO_MAPPING_DEFAULT	HSI_FIFO_MAPPING_SSI
+
+/* Device identifying constants */
+enum {
+	HSI_DRV_DEVICE_HSI,
+	HSI_DRV_DEVICE_SSI
+};
+
+/**
+ * struct hsi_data - HSI buffer descriptor
+ * @addr: pointer to the buffer where to send or receive data
+ * @size: size in words (32 bits) of the buffer
+ * @lch: associated GDD (DMA) logical channel number, if any
+ */
+struct hsi_data {
+	u32 *addr;
+	unsigned int size;
+	int lch;
+};
+
+/**
+ * struct hsi_channel - HSI channel data
+ * @read_data: Incoming HSI buffer descriptor
+ * @write_data: Outgoing HSI buffer descriptor
+ * @hsi_port: Reference to port where the channel belongs to
+ * @flags: Tracks if channel has been open
+ * @channel_number: HSI channel number
+ * @rw_lock: Read/Write lock to serialize access to callback and hsi_device
+ * @dev: Reference to the associated hsi_device channel
+ * @write_done: Callback to signal TX completed.
+ * @read_done: Callback to signal RX completed.
+ * @port_event: Callback to signal port events (RX Error, HWBREAK, CAWAKE ...)
+ */
+struct hsi_channel {
+	struct hsi_data read_data;
+	struct hsi_data write_data;
+	struct hsi_port *hsi_port;
+	u8 flags;
+	u8 channel_number;
+	rwlock_t rw_lock;
+	struct hsi_device *dev;
+	void (*write_done)(struct hsi_device *dev, unsigned int size);
+	void (*read_done)(struct hsi_device *dev, unsigned int size);
+	void (*port_event)(struct hsi_device *dev, unsigned int event,
+								void *arg);
+};
+
+/**
+ * struct hsi_port - hsi port driver data
+ * @hsi_channel: Array of channels in the port
+ * @hsi_controller: Reference to the HSI controller
+ * @port_number: port number
+ * @max_ch: maximum number of channels supported on the port
+ * @n_irq: HSI irq line use to handle interrupts (0 or 1)
+ * @irq: IRQ number
+ * @cawake_gpio: GPIO number for cawake line (-1 if none)
+ * @cawake_gpio_irq: IRQ number for cawake gpio events
+ * @counters_on: indicates if the HSR counters are in use or not
+ * @reg_counters: stores the previous counters values when deactivated
+ * @lock: Serialize access to the port registers and internal data
+ * @hsi_tasklet: Bottom half for interrupts
+ * @cawake_tasklet: Bottom half for cawake events
+ */
+struct hsi_port {
+	struct hsi_channel hsi_channel[HSI_PORT_MAX_CH];
+	struct hsi_dev *hsi_controller;
+	u8 flags;
+	u8 port_number;
+	u8 max_ch;
+	u8 n_irq;
+	int irq;
+	int cawake_gpio;
+	int cawake_gpio_irq;
+	int counters_on;
+	unsigned long reg_counters;
+	spinlock_t lock; /* access to the port registers and internal data */
+	struct tasklet_struct hsi_tasklet;
+	struct tasklet_struct cawake_tasklet;
+};
+
+/**
+ * struct hsi_dev - hsi controller driver data
+ * @hsi_port: Array of hsi ports enabled in the controller
+ * @id: HSI controller platform id number
+ * @max_p: Number of ports enabled in the controller
+ * @hsi_clk: Reference to the HSI custom clock
+ * @base: HSI registers base virtual address
+ * @phy_base: HSI registers base physical address
+ * @lock: Serializes access to internal data and regs
+ * @cawake_clk_enable: Tracks if a cawake event has enable the clocks
+ * @gdd_irq: GDD (DMA) irq number
+ * @fifo_mapping_strategy: Selected strategy for fifo to ports/channels mapping
+ * @gdd_usecount: Holds the number of ongoning DMA transfers
+ * @last_gdd_lch: Last used GDD logical channel
+ * @gdd_chan-count: Number of available DMA channels on the device (must be ^2)
+ * @set_min_bus_tput: (PM) callback to set minimun bus throuput
+ * @clk_notifier_register: (PM) callabck for DVFS support
+ * @clk_notifier_unregister: (PM) callabck for DVFS support
+ * @hsi_nb: (PM) Notification block for DVFS notification chain
+ * @hsi_gdd_tasklet: Bottom half for DMA transfers
+ * @dir: debugfs base directory
+ * @dev: Reference to the HSI platform device
+ */
+struct hsi_dev {
+	struct hsi_port hsi_port[HSI_MAX_PORTS];
+	int id;
+	u8 max_p;
+	struct clk *hsi_clk;
+	void __iomem *base;
+	unsigned long phy_base;
+	spinlock_t lock; /* Serializes access to internal data and regs */
+	unsigned int cawake_clk_enable:1;
+	int gdd_irq;
+	unsigned int fifo_mapping_strategy;
+	unsigned int gdd_usecount;
+	unsigned int last_gdd_lch;
+	unsigned int gdd_chan_count;
+	void (*set_min_bus_tput)(struct device *dev, u8 agent_id,
+						unsigned long r);
+	int (*clk_notifier_register)(struct clk *clk,
+					struct notifier_block *nb);
+	int (*clk_notifier_unregister)(struct clk *clk,
+					struct notifier_block *nb);
+	struct notifier_block hsi_nb;
+	struct tasklet_struct hsi_gdd_tasklet;
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *dir;
+#endif
+	struct device *dev;
+};
+
+/* HSI Bus */
+extern struct bus_type hsi_bus_type;
+
+int hsi_port_event_handler(struct hsi_port *p, unsigned int event, void *arg);
+int hsi_bus_init(void);
+void hsi_bus_exit(void);
+/* End HSI Bus */
+
+void hsi_reset_ch_read(struct hsi_channel *ch);
+void hsi_reset_ch_write(struct hsi_channel *ch);
+
+int hsi_driver_read_interrupt(struct hsi_channel *hsi_channel, u32 *data);
+int hsi_driver_write_interrupt(struct hsi_channel *hsi_channel, u32 *data);
+int hsi_driver_read_dma(struct hsi_channel *hsi_channel, u32 *data,
+			unsigned int count);
+int hsi_driver_write_dma(struct hsi_channel *hsi_channel, u32 *data,
+			unsigned int count);
+
+void hsi_driver_cancel_write_interrupt(struct hsi_channel *ch);
+void hsi_driver_disable_read_interrupt(struct hsi_channel *ch);
+void hsi_driver_cancel_read_interrupt(struct hsi_channel *ch);
+void hsi_driver_cancel_write_dma(struct hsi_channel *ch);
+void hsi_driver_cancel_read_dma(struct hsi_channel *ch);
+
+int hsi_driver_device_is_hsi(struct platform_device *dev);
+
+int hsi_mpu_init(struct hsi_port *hsi_p, const char *irq_name);
+void hsi_mpu_exit(struct hsi_port *hsi_p);
+
+int hsi_gdd_init(struct hsi_dev *hsi_ctrl, const char *irq_name);
+void hsi_gdd_exit(struct hsi_dev *hsi_ctrl);
+
+int hsi_cawake_init(struct hsi_port *port, const char *irq_name);
+void hsi_cawake_exit(struct hsi_port *port);
+
+int hsi_fifo_get_id(struct hsi_dev *hsi_ctrl, unsigned int channel,
+							unsigned int port);
+int hsi_fifo_get_chan(struct hsi_dev *hsi_ctrl, unsigned int fifo,
+				unsigned int *channel, unsigned int *port);
+int __init hsi_fifo_mapping(struct hsi_dev *hsi_ctrl, unsigned int mtype);
+long hsi_hst_bufstate_f_reg(struct hsi_dev *hsi_ctrl,
+				unsigned int port, unsigned int channel);
+long hsi_hsr_bufstate_f_reg(struct hsi_dev *hsi_ctrl,
+				unsigned int port, unsigned int channel);
+long hsi_hst_buffer_reg(struct hsi_dev *hsi_ctrl,
+				unsigned int port, unsigned int channel);
+long hsi_hsr_buffer_reg(struct hsi_dev *hsi_ctrl,
+				unsigned int port, unsigned int channel);
+
+#ifdef CONFIG_DEBUG_FS
+int hsi_debug_init(void);
+void hsi_debug_exit(void);
+int hsi_debug_add_ctrl(struct hsi_dev *hsi_ctrl);
+void hsi_debug_remove_ctrl(struct hsi_dev *hsi_ctrl);
+#else
+#define	hsi_debug_add_ctrl(hsi_ctrl)	0
+#define	hsi_debug_remove_ctrl(hsi_ctrl)
+#define	hsi_debug_init()		0
+#define	hsi_debug_exit()
+#endif /* CONFIG_DEBUG_FS */
+
+static inline unsigned int hsi_cawake(struct hsi_port *port)
+{
+	return gpio_get_value(port->cawake_gpio);
+}
+
+static inline struct hsi_channel *ctrl_get_ch(struct hsi_dev *hsi_ctrl,
+					unsigned int port, unsigned int channel)
+{
+	return &hsi_ctrl->hsi_port[port - 1].hsi_channel[channel];
+}
+
+/* HSI IO access */
+static inline u32 hsi_inl(void __iomem *base, u32 offset)
+{
+	return inl((unsigned int) base + offset);
+}
+
+static inline void hsi_outl(u32 data, void __iomem *base, u32 offset)
+{
+	outl(data, (unsigned int) base + offset);
+}
+
+static inline void hsi_outl_or(u32 data, void __iomem *base, u32 offset)
+{
+	u32 tmp = hsi_inl(base, offset);
+	hsi_outl((tmp | data), base, offset);
+}
+
+static inline void hsi_outl_and(u32 data, void __iomem *base, u32 offset)
+{
+	u32 tmp = hsi_inl(base, offset);
+	hsi_outl((tmp & data), base, offset);
+}
+
+static inline u16 hsi_inw(void __iomem *base, u32 offset)
+{
+	return inw((unsigned int) base + offset);
+}
+
+static inline void hsi_outw(u16 data, void __iomem *base, u32 offset)
+{
+	outw(data, (unsigned int) base + offset);
+}
+
+static inline void hsi_outw_or(u16 data, void __iomem *base, u32 offset)
+{
+	u16 tmp = hsi_inw(base, offset);
+	hsi_outw((tmp | data), base, offset);
+}
+
+static inline void hsi_outw_and(u16 data, void __iomem *base, u32 offset)
+{
+	u16 tmp = hsi_inw(base, offset);
+	hsi_outw((tmp & data), base, offset);
+}
+
+#endif /* __HSI_DRIVER_H__ */
diff --git a/drivers/hsi/hsi_driver_bus.c b/drivers/hsi/hsi_driver_bus.c
new file mode 100644
index 0000000..3fb9d6e
--- /dev/null
+++ b/drivers/hsi/hsi_driver_bus.c
@@ -0,0 +1,182 @@
+/*
+ * hsi_driver_bus.c
+ *
+ * Implements an HSI bus, device and driver interface.
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
+#include <linux/device.h>
+#include "hsi_driver.h"
+
+#define HSI_PREFIX		"hsi:"
+
+struct bus_type hsi_bus_type;
+
+static ssize_t modalias_show(struct device *dev, struct device_attribute *a,
+								char *buf)
+{
+	return snprintf(buf, PAGE_SIZE + 1, "%s%s\n", HSI_PREFIX,
+								dev_name(dev));
+}
+
+static struct device_attribute hsi_dev_attrs[] = {
+	__ATTR_RO(modalias),
+	__ATTR_NULL,
+};
+
+static int hsi_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	add_uevent_var(env, "MODALIAS=%s%s", HSI_PREFIX, dev_name(dev));
+	return 0;
+}
+
+static int hsi_bus_match(struct device *device, struct device_driver *driver)
+{
+	struct hsi_device *dev = to_hsi_device(device);
+	struct hsi_device_driver *drv = to_hsi_device_driver(driver);
+
+	if (!test_bit(dev->n_ctrl, &drv->ctrl_mask))
+		return 0;
+
+	if (!test_bit(dev->n_ch, &drv->ch_mask[dev->n_p]))
+		return 0;
+
+	return 1;
+}
+
+int hsi_bus_unreg_dev(struct device *device, void *p)
+{
+	device->release(device);
+	device_unregister(device);
+
+	return 0;
+}
+
+int __init hsi_bus_init(void)
+{
+	return bus_register(&hsi_bus_type);
+}
+
+void hsi_bus_exit(void)
+{
+	bus_for_each_dev(&hsi_bus_type, NULL, NULL, hsi_bus_unreg_dev);
+	bus_unregister(&hsi_bus_type);
+}
+
+static int hsi_driver_probe(struct device *dev)
+{
+	struct hsi_device_driver *drv = to_hsi_device_driver(dev->driver);
+
+	if (!drv->probe)
+		return -ENODEV;
+
+	return drv->probe(to_hsi_device(dev));
+}
+
+static int hsi_driver_remove(struct device *dev)
+{
+	struct hsi_device_driver *drv;
+	int ret;
+
+	if (!dev->driver)
+		return 0;
+
+	drv = to_hsi_device_driver(dev->driver);
+	if (drv->remove) {
+		ret = drv->remove(to_hsi_device(dev));
+	} else {
+		dev->driver = NULL;
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static int hsi_driver_suspend(struct device *dev, pm_message_t mesg)
+{
+	struct hsi_device_driver *drv = to_hsi_device_driver(dev->driver);
+
+	if (!dev->driver)
+		return 0;
+
+	drv = to_hsi_device_driver(dev->driver);
+	if (!drv->suspend)
+		return 0;
+
+	return drv->suspend(to_hsi_device(dev), mesg);
+}
+
+static int hsi_driver_resume(struct device *dev)
+{
+	struct hsi_device_driver *drv;
+
+	if (!dev->driver)
+		return 0;
+
+	drv = to_hsi_device_driver(dev->driver);
+	if (!drv->resume)
+		return 0;
+
+	return drv->resume(to_hsi_device(dev));
+}
+
+struct bus_type hsi_bus_type = {
+	.name		= "hsi",
+	.dev_attrs	= hsi_dev_attrs,
+	.match		= hsi_bus_match,
+	.uevent		= hsi_bus_uevent,
+	.probe		= hsi_driver_probe,
+	.remove		= hsi_driver_remove,
+	.suspend	= hsi_driver_suspend,
+	.resume		= hsi_driver_resume,
+};
+
+/**
+ * hsi_register_driver - Register HSI device driver
+ * @driver - reference to the HSI device driver.
+ */
+int hsi_register_driver(struct hsi_device_driver *driver)
+{
+	int ret = 0;
+
+	if (driver == NULL)
+		return -EINVAL;
+
+	driver->driver.bus = &hsi_bus_type;
+
+	ret = driver_register(&driver->driver);
+
+	if (ret == 0)
+		pr_debug("hsi: driver %s registered\n", driver->driver.name);
+
+	return ret;
+}
+EXPORT_SYMBOL(hsi_register_driver);
+
+/**
+ * hsi_unregister_driver - Unregister HSI device driver
+ * @driver - reference to the HSI device driver.
+ */
+void hsi_unregister_driver(struct hsi_device_driver *driver)
+{
+	if (driver == NULL)
+		return;
+
+	driver_unregister(&driver->driver);
+
+	pr_debug("hsi: driver %s unregistered\n", driver->driver.name);
+}
+EXPORT_SYMBOL(hsi_unregister_driver);
-- 
1.6.0.4

