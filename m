From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH RESEND 2/4] can: c_can: Add d_can raminit support
Date: Wed, 5 Sep 2012 16:42:42 +0530
Message-ID: <1346843564-25343-3-git-send-email-anilkumar@ti.com>
References: <1346843564-25343-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1346843564-25343-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de
Cc: tony@atomide.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, AnilKumar Ch <anilkumar@ti.com>
List-Id: linux-omap@vger.kernel.org

Add D_CAN raminit support to C_CAN driver to enable D_CAN RAM,
which holds all the message objects during transmission or
receiving of data. This initialization/de-initialization should
be done in synchronous with D_CAN clock.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 drivers/net/can/c_can/c_can.c          |   13 ++++++++++++
 drivers/net/can/c_can/c_can.h          |    2 ++
 drivers/net/can/c_can/c_can_platform.c |   10 +++++++++
 include/linux/can/platform/c_can.h     |   36 ++++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+)
 create mode 100644 include/linux/can/platform/c_can.h

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index aa6c5eb..c175410 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -214,6 +214,12 @@ static inline void c_can_pm_runtime_put_sync(const struct c_can_priv *priv)
 		pm_runtime_put_sync(priv->device);
 }
 
+static inline void c_can_reset_ram(const struct c_can_priv *priv, bool enable)
+{
+	if (priv->ram_init)
+		priv->ram_init(priv->instance, enable);
+}
+
 static inline int get_tx_next_msg_obj(const struct c_can_priv *priv)
 {
 	return (priv->tx_next & C_CAN_NEXT_MSG_OBJ_MASK) +
@@ -1071,6 +1077,8 @@ static int c_can_open(struct net_device *dev)
 	struct c_can_priv *priv = netdev_priv(dev);
 
 	c_can_pm_runtime_get_sync(priv);
+	/* Initialize DCAN RAM */
+	c_can_reset_ram(priv, true);
 
 	/* open the can device */
 	err = open_candev(dev);
@@ -1099,6 +1107,8 @@ static int c_can_open(struct net_device *dev)
 exit_irq_fail:
 	close_candev(dev);
 exit_open_fail:
+	/* De-Initialize DCAN RAM */
+	c_can_reset_ram(priv, false);
 	c_can_pm_runtime_put_sync(priv);
 	return err;
 }
@@ -1112,6 +1122,9 @@ static int c_can_close(struct net_device *dev)
 	c_can_stop(dev);
 	free_irq(dev->irq, dev);
 	close_candev(dev);
+
+	/* De-Initialize DCAN RAM */
+	c_can_reset_ram(priv, false);
 	c_can_pm_runtime_put_sync(priv);
 
 	return 0;
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 1437a6d..5f6339c 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -166,6 +166,8 @@ struct c_can_priv {
 	unsigned int tx_echo;
 	void *priv;		/* for board-specific data */
 	u16 irqstatus;
+	unsigned int instance;
+	void (*ram_init) (unsigned int instance, bool enable);
 };
 
 struct net_device *alloc_c_can_dev(void);
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index c351975..c6963b2 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -34,6 +34,7 @@
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/can/platform/c_can.h>
 
 #include <linux/can/dev.h>
 
@@ -98,6 +99,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 	struct net_device *dev;
 	struct c_can_priv *priv;
 	const struct of_device_id *match;
+	struct c_can_platform_data *pdata = NULL;
 	const struct platform_device_id *id;
 	struct pinctrl *pinctrl;
 	struct resource *mem;
@@ -179,6 +181,14 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
 		priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
 		priv->write_reg = c_can_plat_write_reg_aligned_to_16bit;
+		pdata = pdev->dev.platform_data;
+		if (!pdata) {
+			dev_err(&pdev->dev, "d_can platform data missing\n");
+			ret = -EINVAL;
+			goto exit_free_device;
+		}
+		priv->ram_init = pdata->ram_init;
+		priv->instance = pdata->instance;
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/include/linux/can/platform/c_can.h b/include/linux/can/platform/c_can.h
new file mode 100644
index 0000000..84b27d2
--- /dev/null
+++ b/include/linux/can/platform/c_can.h
@@ -0,0 +1,36 @@
+/*
+ * C_CAN controller driver platform header
+ *
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * Bosch C_CAN/D_CAN controller is compliant to CAN protocol version 2.0
+ * part A and B.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __CAN_PLATFORM_C_CAN_H__
+#define __CAN_PLATFORM_C_CAN_H__
+
+/**
+ * struct c_can_platform_data - C_CAN/D_CAN Platform Data
+ *
+ * @instance:		CAN instance, required for d_can raminit
+ * @ram_init:		CAN RAM initialization
+ *
+ * Platform data structure to get all platform specific settings.
+ * this structure also accounts the fact that the IP may have different
+ * RAM for different SOC's
+ */
+struct c_can_platform_data {
+	unsigned int instance;
+	void (*ram_init) (unsigned int instance, bool enable);
+};
+#endif
-- 
1.7.9.5

