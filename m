From: Charulatha V <charu@ti.com>
Subject: [PATCH 5/8] OMAP2PLUS:GPIO:Add OMAP2PLUS specific gpio support
Date: Wed, 31 Mar 2010 17:53:56 +0530
Message-ID: <1270038239-1090-6-git-send-email-charu@ti.com>
References: <1270038239-1090-1-git-send-email-charu@ti.com>
 <1270038239-1090-2-git-send-email-charu@ti.com>
 <1270038239-1090-3-git-send-email-charu@ti.com>
 <1270038239-1090-4-git-send-email-charu@ti.com>
 <1270038239-1090-5-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53192 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932584Ab0CaMTb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Mar 2010 08:19:31 -0400
In-Reply-To: <1270038239-1090-5-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, paul@pwsan.com, tony@atomide.com, Charulatha V <charu@ti.com>

This patch adds support for handling code common to OMAP2PLUS
architecture.

OMAP2PLUS gpio is one of the early platform devices and this patch
adds support to implement the initialization of OMAP2PLUS architecture
GPIO as early platform device.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/gpio.c              |   36 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/gpio.h |    1 +
 2 files changed, 37 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/gpio.c

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
new file mode 100644
index 0000000..341cdd5
--- /dev/null
+++ b/arch/arm/mach-omap2/gpio.c
@@ -0,0 +1,36 @@
+/*
+ * gpio.c - OMAP2PLUS architecture specific common gpio code
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ *
+ * Author:
+ *	Charulatha V <charu@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <mach/gpio.h>
+
+void __init omap_gpio_early_init(void)
+{
+	struct platform_device **pdev;
+	int no_of_dev;
+
+	if (cpu_is_omap24xx()) {
+		omap2_gpio_init_data();
+		no_of_dev = omap2_early_init_gpio(&pdev);
+	} else if (cpu_is_omap34xx()) {
+		omap3_gpio_init_data();
+		no_of_dev = omap3_early_init_gpio(&pdev);
+	} else if (cpu_is_omap44xx()) {
+		omap4_gpio_init_data();
+		no_of_dev = omap4_early_init_gpio(&pdev);
+	} else
+		return;
+
+	early_platform_add_devices(pdev, no_of_dev);
+	early_platform_driver_register_all("earlygpio");
+	early_platform_driver_probe("earlygpio", no_of_dev, 0);
+}
diff --git a/arch/arm/mach-omap2/include/mach/gpio.h b/arch/arm/mach-omap2/include/mach/gpio.h
index d2d9d17..3a0fcb1 100644
--- a/arch/arm/mach-omap2/include/mach/gpio.h
+++ b/arch/arm/mach-omap2/include/mach/gpio.h
@@ -115,4 +115,5 @@ extern void omap4_gpio_init_data(void);
 extern int omap2_early_init_gpio(struct platform_device ***pdev);
 extern int omap3_early_init_gpio(struct platform_device ***pdev);
 extern int omap4_early_init_gpio(struct platform_device ***pdev);
+extern void __init omap_gpio_early_init(void);
 #endif
-- 
1.6.3.3

