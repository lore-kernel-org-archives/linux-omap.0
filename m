From: Carlos Chinea <carlos.chinea@nokia.com>
Subject: [PATCH 2/5] OMAP SSI driver interface
Date: Tue, 16 Sep 2008 17:41:05 +0300
Message-ID: <1221576068-16206-2-git-send-email-carlos.chinea@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49315 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbYIPOla (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 10:41:30 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8GEfG5b004260
	for <linux-omap@vger.kernel.org>; Tue, 16 Sep 2008 17:41:28 +0300
In-Reply-To: 1221575400.6315.227.camel@groo.research.nokia.com
References: 1221575400.6315.227.camel@groo.research.nokia.com
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Carlos Chinea <carlos.chinea@nokia.com>
---
 include/linux/ssi_driver_if.h |  137 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 137 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/ssi_driver_if.h

diff --git a/include/linux/ssi_driver_if.h b/include/linux/ssi_driver_if.h
new file mode 100644
index 0000000..bad8f22
--- /dev/null
+++ b/include/linux/ssi_driver_if.h
@@ -0,0 +1,137 @@
+/*
+ * ssi_driver_if.h
+ *
+ * Header for the SSI driver low level interface.
+ *
+ * Copyright (C) 2007-2008 Nokia Corporation. All rights reserved.
+ *
+ * Contact: Carlos Chinea <carlos.chinea@nokia.com>
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
+ */
+#ifndef __SSI_DRIVER_IF_H__
+#define __SSI_DRIVER_IF_H__
+
+#include <linux/device.h>
+
+#define SSI_IOMEM_NAME		"SSI_IO_MEM"
+#define SSI_P1_MPU_IRQ0_NAME	"SSI_P1_MPU_IRQ0"
+#define SSI_P2_MPU_IRQ0_NAME	"SSI_P2_MPU_IRQ0"
+#define SSI_P1_MPU_IRQ1_NAME	"SSI_P1_MPU_IRQ1"
+#define SSI_P2_MPU_IRQ1_NAME	"SSI_P2_MPU_IRQ1"
+#define SSI_GDD_MPU_IRQ_NAME	"GDD_MPU_IRQ"
+
+/* IRQ values */
+#define SSI_P1_MPU_IRQ0		67
+#define SSI_P2_MPU_IRQ0		68
+#define SSI_P1_MPU_IRQ1		69
+#define SSI_P2_MPU_IRQ1		70
+#define SSI_GDD_MPU_IRQ		71
+
+/* The number of ports handled by the driver. (MAX:2) */
+#define SSI_MAX_PORTS		1
+
+/*
+ * Masks used to enable or disable the reception of certain hardware events
+ * for the ssi_device_drivers
+ */
+#define SSI_EVENT_CLEAR			0x00
+#define SSI_EVENT_MASK			0xFF
+#define SSI_EVENT_BREAK_DETECTED_MASK	0x01
+#define SSI_EVENT_ERROR_MASK		0x02
+
+#define ANY_SSI_CONTROLLER	-1
+#define ANY_CHANNEL		-1
+#define CHANNEL(channel)	(1<<channel)
+
+enum {
+	SSI_EVENT_BREAK_DETECTED = 0,
+	SSI_EVENT_ERROR,
+};
+
+enum {
+	SSI_IOCTL_WAKE_UP,
+	SSI_IOCTL_WAKE_DOWN,
+	SSI_IOCTL_SEND_BREAK,
+	GET_WAKE,
+};
+
+/* Forward references */
+struct ssi_device;
+struct ssi_dev;
+struct ssi_port;
+struct ssi_channel;
+
+struct ssi_port_pd {
+	u32 tx_mode;
+	u32 tx_frame_size;
+	u32 divisor;
+	u32 tx_ch;
+	u32 arb_mode;
+	u32 rx_mode;
+	u32 rx_frame_size;
+	u32 rx_ch;
+	u32 timeout;
+	u8 n_irq;
+};
+
+struct ssi_platform_data {
+	unsigned char *clk_name;
+	struct ssi_dev *ssi_ctrl;
+	struct ssi_port_pd *ports;
+	u8 num_ports;
+};
+
+struct ssi_device {
+	int n_ctrl;
+	unsigned int n_p;
+	unsigned int n_ch;
+	char modalias[BUS_ID_SIZE];
+	struct ssi_channel *ch;
+	struct device device;
+};
+
+#define to_ssi_device(dev)	container_of(dev, struct ssi_device, device)
+
+struct ssi_device_driver {
+	unsigned long		ctrl_mask;
+	unsigned long		ch_mask[SSI_MAX_PORTS];
+	unsigned long		event_mask;
+	void 			(*port_event) (int c_id, unsigned int port,
+						unsigned int event, void *arg);
+	int			(*probe)(struct ssi_device *dev);
+	int			(*remove)(struct ssi_device *dev);
+	int			(*suspend)(struct ssi_device *dev,
+						pm_message_t mesg);
+	int			(*resume)(struct ssi_device *dev);
+	struct device_driver 	driver;
+};
+
+#define to_ssi_device_driver(drv) container_of(drv, \
+						struct ssi_device_driver, \
+						driver)
+
+int register_ssi_driver(struct ssi_device_driver *driver);
+void unregister_ssi_driver(struct ssi_device_driver *driver);
+int ssi_open(struct ssi_device *dev);
+int ssi_write(struct ssi_device *dev, u32 *data, unsigned int count);
+void ssi_write_cancel(struct ssi_device *dev);
+int ssi_read(struct ssi_device *dev, u32 *data, unsigned int w_count);
+void ssi_read_cancel(struct ssi_device *dev);
+int ssi_ioctl(struct ssi_device *dev, unsigned int command, void *arg);
+void ssi_close(struct ssi_device *dev);
+void ssi_dev_set_cb(struct ssi_device *dev, void (*r_cb)(struct ssi_device *dev)
+					, void (*w_cb)(struct ssi_device *dev));
+#endif
-- 
1.5.3.6

