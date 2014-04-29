From: Dan Murphy <dmurphy@ti.com>
Subject: [RFC 04/11] drivers: reset: am335: Add reset data for am335
Date: Tue, 29 Apr 2014 15:19:43 -0500
Message-ID: <1398802790-29287-5-git-send-email-dmurphy@ti.com>
References: <1398802790-29287-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44802 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758386AbaD2UUd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2014 16:20:33 -0400
In-Reply-To: <1398802790-29287-1-git-send-email-dmurphy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, devicetree@vger.kernel.org
Cc: t-kristo@ti.com, s-anna@ti.com, p.zabel@pengutronix.de, Dan Murphy <dmurphy@ti.com>

Add the reset register data for the am335 SoC.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/reset/ti/Makefile          |    1 +
 drivers/reset/ti/reset-ti-am33xx.c |   37 ++++++++++++++++++++++++++++++++++++
 drivers/reset/ti/reset-ti-data.h   |    1 +
 drivers/reset/ti/reset-ti.c        |    3 +++
 4 files changed, 42 insertions(+)
 create mode 100644 drivers/reset/ti/reset-ti-am33xx.c

diff --git a/drivers/reset/ti/Makefile b/drivers/reset/ti/Makefile
index 4d2d06c..f0dbd01 100644
--- a/drivers/reset/ti/Makefile
+++ b/drivers/reset/ti/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_RESET_TI) += reset-ti.o
 obj-$(CONFIG_SOC_DRA7XX) += reset-ti-dra7xx.o
 obj-$(CONFIG_SOC_OMAP5) += reset-ti-omap5.o
+obj-$(CONFIG_SOC_AM33XX) += reset-ti-am33xx.o
diff --git a/drivers/reset/ti/reset-ti-am33xx.c b/drivers/reset/ti/reset-ti-am33xx.c
new file mode 100644
index 0000000..d28f41b
--- /dev/null
+++ b/drivers/reset/ti/reset-ti-am33xx.c
@@ -0,0 +1,37 @@
+/*
+ * am33xx reset data for PRCM Module
+ *
+ * Copyright 2014 Texas Instruments Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "reset-ti-data.h"
+
+static struct ti_reset_reg_data am335x_reset_reg_data[] = {
+	{
+		.rstctrl_offs = 0xf00,
+		.rstctrl_bit = 0,
+		.rstst_offs	= 0xf08,
+		.rstst_bit	= 0,
+	},
+	{
+		.rstctrl_offs = 0x1104,
+		.rstctrl_bit = 0,
+		.rstst_offs	= 0x1114,
+		.rstst_bit	= 0,
+	},
+	{
+		.rstctrl_offs = 0x0D00,
+		.rstctrl_bit = 3,
+		.rstst_offs	= 0x0D0C,
+		.rstst_bit	= 5,
+	},
+};
+
+struct ti_reset_data am335x_reset_data = {
+	.reg_data	= am335x_reset_reg_data,
+	.nr_resets	= ARRAY_SIZE(am335x_reset_reg_data),
+};
diff --git a/drivers/reset/ti/reset-ti-data.h b/drivers/reset/ti/reset-ti-data.h
index d3c6d42..48a1476 100644
--- a/drivers/reset/ti/reset-ti-data.h
+++ b/drivers/reset/ti/reset-ti-data.h
@@ -57,5 +57,6 @@ struct ti_reset_data {
 
 extern struct ti_reset_data dra7_reset_data;
 extern struct ti_reset_data omap5_reset_data;
+extern struct ti_reset_data am335x_reset_data;
 
 #endif
diff --git a/drivers/reset/ti/reset-ti.c b/drivers/reset/ti/reset-ti.c
index 7310827..146353f 100644
--- a/drivers/reset/ti/reset-ti.c
+++ b/drivers/reset/ti/reset-ti.c
@@ -138,6 +138,9 @@ static const struct of_device_id ti_reset_of_match[] = {
 #ifdef CONFIG_SOC_OMAP5
 	{ .compatible = "ti,omap5-resets", .data = &omap5_reset_data,},
 #endif
+#ifdef CONFIG_SOC_AM33XX
+	{ .compatible = "ti,am335x-resets", .data = &am335x_reset_data,},
+#endif
 	{},
 };
 
-- 
1.7.9.5

