From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH v5 06/17] OMAP2,3: DSS2: Create new file display.c for central dss driver registration.
Date: Fri,  7 Jan 2011 16:55:40 +0530
Message-ID: <1294399551-10457-7-git-send-email-sumit.semwal@ti.com>
References: <1294399551-10457-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59118 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751421Ab1AGL0x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jan 2011 06:26:53 -0500
In-Reply-To: <1294399551-10457-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@deeprootsystems.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>

A new file display.c is introduced for display driver init, which adds a function
omap_display_init to do the DSS driver registration. This is the first step in moving
away registration of DSS from board files into a common place.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
---
 arch/arm/mach-omap2/Makefile              |    2 +
 arch/arm/mach-omap2/display.c             |   57 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/display.h |    4 ++
 3 files changed, 63 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/display.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4ab82f6..57b89e6 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -237,3 +237,5 @@ obj-y					+= $(smc91x-m) $(smc91x-y)
 
 smsc911x-$(CONFIG_SMSC911X)		:= gpmc-smsc911x.o
 obj-y					+= $(smsc911x-m) $(smsc911x-y)
+
+obj-y					+= display.o
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
new file mode 100644
index 0000000..26d3feb
--- /dev/null
+++ b/arch/arm/mach-omap2/display.c
@@ -0,0 +1,57 @@
+/*
+ * OMAP2plus display device setup / initialization.
+ *
+ * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
+ * 	Senthilvadivu Guruswamy
+ *      Sumit Semwal
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+
+#include <plat/display.h>
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
+
+#ifdef CONFIG_OMAP2_DSS
+
+static struct platform_device omap_display_device = {
+	.name          = "omap_display",
+	.id            = -1,
+	.dev            = {
+		.platform_data = NULL,
+	},
+};
+
+int __init omap_display_init(struct omap_dss_board_info
+					*board_data)
+{
+	int r = 0;
+	omap_display_device.dev.platform_data = board_data;
+
+	r = platform_device_register(&omap_display_device);
+	if (r < 0)
+		printk(KERN_ERR "Unable to register OMAP-Display device\n");
+
+	return r;
+}
+
+#else
+int __init omap_display_init(struct omap_dss_board_info *board_data)
+{
+	return 0;
+}
+#endif
diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index c915a66..871bbae 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -23,6 +23,7 @@
 #include <linux/list.h>
 #include <linux/kobject.h>
 #include <linux/device.h>
+#include <linux/platform_device.h>
 #include <asm/atomic.h>
 
 #define DISPC_IRQ_FRAMEDONE		(1 << 0)
@@ -220,6 +221,9 @@ struct omap_dss_board_info {
 	struct omap_dss_device *default_device;
 };
 
+/* Init with the board info */
+extern int omap_display_init(struct omap_dss_board_info *board_data);
+
 struct omap_video_timings {
 	/* Unit: pixels */
 	u16 x_res;
-- 
1.7.0.4

