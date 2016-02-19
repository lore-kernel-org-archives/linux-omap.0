From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 01/26] ARM: OMAP2+: gpmc: Add platform data
Date: Fri, 19 Feb 2016 23:15:23 +0200
Message-ID: <1455916548-3441-2-git-send-email-rogerq@ti.com>
References: <1455916548-3441-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1455916548-3441-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: tony@atomide.com, computersforpeace@gmail.com
Cc: devicetree@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, linux-omap@vger.kernel.org, dwmw2@infradead.org, fcooper@ti.com, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Add a platform data structure for GPMC. It contains all the necessary
platform information that needs to be passed from platform init code
to GPMC driver.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 include/linux/omap-gpmc.h               |  3 +--
 include/linux/platform_data/gpmc-omap.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/platform_data/gpmc-omap.h

diff --git a/include/linux/omap-gpmc.h b/include/linux/omap-gpmc.h
index 7dee0014..5c79190 100644
--- a/include/linux/omap-gpmc.h
+++ b/include/linux/omap-gpmc.h
@@ -7,8 +7,7 @@
  *  option) any later version.
  */
 
-/* Maximum Number of Chip Selects */
-#define GPMC_CS_NUM		8
+#include <linux/platform_data/gpmc-omap.h>
 
 #define GPMC_CONFIG_WP		0x00000005
 
diff --git a/include/linux/platform_data/gpmc-omap.h b/include/linux/platform_data/gpmc-omap.h
new file mode 100644
index 0000000..d32d9de
--- /dev/null
+++ b/include/linux/platform_data/gpmc-omap.h
@@ -0,0 +1,30 @@
+/*
+ * OMAP GPMC Platform data
+ *
+ * Copyright (C) 2014 Texas Instruments, Inc. - http://www.ti.com
+ *	Roger Quadros <rogerq@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#ifndef _GPMC_OMAP_H_
+#define _GPMC_OMAP_H_
+
+/* Maximum Number of Chip Selects */
+#define GPMC_CS_NUM		8
+
+/* Data for each chip select */
+struct gpmc_omap_cs_data {
+	bool valid;			/* data is valid */
+	bool is_nand;			/* device within this CS is NAND */
+	struct platform_device *pdev;	/* device within this CS region */
+	unsigned pdata_size;
+};
+
+struct gpmc_omap_platform_data {
+	struct gpmc_omap_cs_data cs[GPMC_CS_NUM];
+};
+
+#endif /* _GPMC_OMAP_H */
-- 
2.1.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
