From: Dan Murphy <dmurphy@ti.com>
Subject: [RFC 05/11] drivers: reset: am43xx: Add reset data for am43xx
Date: Tue, 29 Apr 2014 15:19:44 -0500
Message-ID: <1398802790-29287-6-git-send-email-dmurphy@ti.com>
References: <1398802790-29287-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42628 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758429AbaD2UUg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Apr 2014 16:20:36 -0400
In-Reply-To: <1398802790-29287-1-git-send-email-dmurphy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, devicetree@vger.kernel.org
Cc: t-kristo@ti.com, s-anna@ti.com, p.zabel@pengutronix.de, Dan Murphy <dmurphy@ti.com>

Add the reset register data for the am43xx SoC.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/reset/ti/Makefile          |    1 +
 drivers/reset/ti/reset-ti-am43xx.c |   43 ++++++++++++++++++++++++++++++++++++
 drivers/reset/ti/reset-ti-data.h   |    1 +
 3 files changed, 45 insertions(+)
 create mode 100644 drivers/reset/ti/reset-ti-am43xx.c

diff --git a/drivers/reset/ti/Makefile b/drivers/reset/ti/Makefile
index f0dbd01..3d362c2 100644
--- a/drivers/reset/ti/Makefile
+++ b/drivers/reset/ti/Makefile
@@ -2,3 +2,4 @@ obj-$(CONFIG_RESET_TI) += reset-ti.o
 obj-$(CONFIG_SOC_DRA7XX) += reset-ti-dra7xx.o
 obj-$(CONFIG_SOC_OMAP5) += reset-ti-omap5.o
 obj-$(CONFIG_SOC_AM33XX) += reset-ti-am33xx.o
+obj-$(CONFIG_SOC_AM43XX) += reset-ti-am43xx.o
diff --git a/drivers/reset/ti/reset-ti-am43xx.c b/drivers/reset/ti/reset-ti-am43xx.c
new file mode 100644
index 0000000..cfb283b
--- /dev/null
+++ b/drivers/reset/ti/reset-ti-am43xx.c
@@ -0,0 +1,43 @@
+/*
+ * am43xx reset data for PRCM Module
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
+static struct ti_reset_reg_data am43x_reset_reg_data[] = {
+	{
+		.rstctrl_offs = 0x4000,
+		.rstctrl_bit = 0,
+		.rstst_offs	= 0x4004,
+		.rstst_bit	= 0,
+	},
+	{
+		.rstctrl_offs = 0x810,
+		.rstctrl_bit = 1,
+		.rstst_offs	= 0x814,
+		.rstst_bit	= 0,
+	},
+	{
+		.rstctrl_offs	= 0x410,
+		.rstst_offs	= 0x414,
+		.rstctrl_bit	= 0,
+		.rstst_bit	= 0,
+	},
+	{
+		.rstctrl_offs	= 0x2010,
+		.rstst_offs	= 0x2014,
+		.rstctrl_bit	= 3,
+		.rstst_bit	= 5,
+	},
+};
+
+struct ti_reset_data am43x_reset_data = {
+	.reg_data	= am43x_reset_reg_data,
+	.nr_resets	= ARRAY_SIZE(am43x_reset_reg_data),
+};
diff --git a/drivers/reset/ti/reset-ti-data.h b/drivers/reset/ti/reset-ti-data.h
index 48a1476..f56f1a5 100644
--- a/drivers/reset/ti/reset-ti-data.h
+++ b/drivers/reset/ti/reset-ti-data.h
@@ -58,5 +58,6 @@ struct ti_reset_data {
 extern struct ti_reset_data dra7_reset_data;
 extern struct ti_reset_data omap5_reset_data;
 extern struct ti_reset_data am335x_reset_data;
+extern struct ti_reset_data am43x_reset_data;
 
 #endif
-- 
1.7.9.5

