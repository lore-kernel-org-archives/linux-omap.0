From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/7] ARM: OMAP2+: WDT: move init; add read_reset_sources
 pdata function pointer (fwd)
Date: Thu, 18 Oct 2012 01:27:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210180125140.30902@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47636 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301Ab2JRB1l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Oct 2012 21:27:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org


Hi Wim,

When you have the opportunity, could you take a look at this patch, and 
the subsequent patch 6/7, and ack them if you're okay with them?

We'd like to merge thse as part of a larger cleanup series through the 
arm-soc tree.  They like cleanup patches to arrive at the beginning of the 
-rc series, which means that we need to have the pull request sent pretty 
soon.


thanks,

- Paul

---------- Forwarded message ----------
Date: Mon, 15 Oct 2012 19:32:33 -0600
From: Paul Walmsley <paul@pwsan.com>
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: [PATCH 5/7] ARM: OMAP2+: WDT: move init; add read_reset_sources pdata
    function pointer

The OMAP watchdog timer driver directly calls a function exported by
code in arch/arm/mach-omap2.  This is not good; it tightly couples
this driver to the mach-omap2 integration code.  Instead, add a
temporary platform_data function pointer to abstract this function
call.  A subsequent patch will convert the watchdog driver to use this
function pointer.

This patch also moves the device creation code out of
arch/arm/mach-omap2/devices.c and into arch/arm/mach-omap2/wd_timer.c.
This is another step towards the removal of
arch/arm/mach-omap2/devices.c.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
---
 arch/arm/mach-omap1/devices.c               |   21 +++++++++++++--
 arch/arm/mach-omap2/devices.c               |   26 ------------------
 arch/arm/mach-omap2/wd_timer.c              |   33 +++++++++++++++++++++++
 include/linux/platform_data/omap-wd-timer.h |   38 +++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 29 deletions(-)
 create mode 100644 include/linux/platform_data/omap-wd-timer.h

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index d3fec92..c3408e7 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -17,6 +17,8 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 
+#include <linux/platform_data/omap-wd-timer.h>
+
 #include <asm/mach/map.h>
 
 #include <plat/tc.h>
@@ -439,18 +441,31 @@ static struct resource wdt_resources[] = {
 };
 
 static struct platform_device omap_wdt_device = {
-	.name	   = "omap_wdt",
-	.id	     = -1,
+	.name		= "omap_wdt",
+	.id		= -1,
 	.num_resources	= ARRAY_SIZE(wdt_resources),
 	.resource	= wdt_resources,
 };
 
 static int __init omap_init_wdt(void)
 {
+	struct omap_wd_timer_platform_data pdata;
+	int ret;
+
 	if (!cpu_is_omap16xx())
 		return -ENODEV;
 
-	return platform_device_register(&omap_wdt_device);
+	pdata.read_reset_sources = omap1_read_reset_sources;
+
+	ret = platform_device_register(&omap_wdt_device);
+	if (!ret) {
+		ret = platform_device_add_data(&omap_wdt_device, &pdata,
+					       sizeof(pdata));
+		if (ret)
+			platform_device_del(&omap_wdt_device);
+	}
+
+	return ret;
 }
 subsys_initcall(omap_init_wdt);
 #endif
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index c8c2117..2ab2c99 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -644,29 +644,3 @@ static int __init omap2_init_devices(void)
 	return 0;
 }
 arch_initcall(omap2_init_devices);
-
-#if defined(CONFIG_OMAP_WATCHDOG) || defined(CONFIG_OMAP_WATCHDOG_MODULE)
-static int __init omap_init_wdt(void)
-{
-	int id = -1;
-	struct platform_device *pdev;
-	struct omap_hwmod *oh;
-	char *oh_name = "wd_timer2";
-	char *dev_name = "omap_wdt";
-
-	if (!cpu_class_is_omap2() || of_have_populated_dt())
-		return 0;
-
-	oh = omap_hwmod_lookup(oh_name);
-	if (!oh) {
-		pr_err("Could not look up wd_timer%d hwmod\n", id);
-		return -EINVAL;
-	}
-
-	pdev = omap_device_build(dev_name, id, oh, NULL, 0, NULL, 0, 0);
-	WARN(IS_ERR(pdev), "Can't build omap_device for %s:%s.\n",
-				dev_name, oh->name);
-	return 0;
-}
-subsys_initcall(omap_init_wdt);
-#endif
diff --git a/arch/arm/mach-omap2/wd_timer.c b/arch/arm/mach-omap2/wd_timer.c
index b2f1c67..00ef54c 100644
--- a/arch/arm/mach-omap2/wd_timer.c
+++ b/arch/arm/mach-omap2/wd_timer.c
@@ -11,10 +11,14 @@
 #include <linux/io.h>
 #include <linux/err.h>
 
+#include <linux/platform_data/omap-wd-timer.h>
+
 #include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 
 #include "wd_timer.h"
 #include "common.h"
+#include "prm.h"
 
 /*
  * In order to avoid any assumptions from bootloader regarding WDT
@@ -99,3 +103,32 @@ int omap2_wd_timer_reset(struct omap_hwmod *oh)
 	return (c == MAX_MODULE_SOFTRESET_WAIT) ? -ETIMEDOUT :
 		omap2_wd_timer_disable(oh);
 }
+
+static int __init omap_init_wdt(void)
+{
+	int id = -1;
+	struct platform_device *pdev;
+	struct omap_hwmod *oh;
+	char *oh_name = "wd_timer2";
+	char *dev_name = "omap_wdt";
+	struct omap_wd_timer_platform_data pdata;
+
+	if (!cpu_class_is_omap2())
+		return 0;
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("Could not look up wd_timer%d hwmod\n", id);
+		return -EINVAL;
+	}
+
+	pdata.read_reset_sources = prm_read_reset_sources;
+
+	pdev = omap_device_build(dev_name, id, oh, &pdata,
+				 sizeof(struct omap_wd_timer_platform_data),
+				 NULL, 0, 0);
+	WARN(IS_ERR(pdev), "Can't build omap_device for %s:%s.\n",
+	     dev_name, oh->name);
+	return 0;
+}
+subsys_initcall(omap_init_wdt);
diff --git a/include/linux/platform_data/omap-wd-timer.h b/include/linux/platform_data/omap-wd-timer.h
new file mode 100644
index 0000000..d75f5f8
--- /dev/null
+++ b/include/linux/platform_data/omap-wd-timer.h
@@ -0,0 +1,38 @@
+/*
+ * OMAP2+ WDTIMER-specific function prototypes
+ *
+ * Copyright (C) 2012 Texas Instruments, Inc.
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __LINUX_PLATFORM_DATA_OMAP_WD_TIMER_H
+#define __LINUX_PLATFORM_DATA_OMAP_WD_TIMER_H
+
+#include <linux/types.h>
+
+/*
+ * Standardized OMAP reset source bits
+ *
+ * This is a subset of the ones listed in arch/arm/mach-omap2/prm.h
+ * and are the only ones needed in the watchdog driver.
+ */
+#define OMAP_MPU_WD_RST_SRC_ID_SHIFT				3
+
+/**
+ * struct omap_wd_timer_platform_data - WDTIMER integration to the host SoC
+ * @read_reset_sources - fn ptr for the SoC to indicate the last reset cause
+ *
+ * The function pointed to by @read_reset_sources must return its data
+ * in a standard format - search for RST_SRC_ID_SHIFT in
+ * arch/arm/mach-omap2
+ */
+struct omap_wd_timer_platform_data {
+	u32 (*read_reset_sources)(void);
+};
+
+#endif


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
