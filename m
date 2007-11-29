From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 1/1] ARM: OMAP: Remove unnecessary N800 PM board specific
 file
Date: Thu, 29 Nov 2007 15:01:53 -0400
Message-ID: <474F0CA1.8070601@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Removes unnecessary arch/arm/mach-omap2/board-n800-pm.c file, according with
Trilok's early patch, that moves board-n800-pm.c code to board-n800.c file.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: Trilok Soni <soni.trilok@gmail.com>
---
 arch/arm/mach-omap2/board-n800-pm.c |   79 -----------------------------------
 1 files changed, 0 insertions(+), 79 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-n800-pm.c

diff --git a/arch/arm/mach-omap2/board-n800-pm.c b/arch/arm/mach-omap2/board-n800-pm.c
deleted file mode 100644
index 33f3e4d..0000000
--- a/arch/arm/mach-omap2/board-n800-pm.c
+++ /dev/null
@@ -1,79 +0,0 @@
-/*
- * Nokia N800 PM code
- *
- * Copyright (C) 2006 Nokia Corporation
- * Author: Amit Kucheria <amit.kucheria@nokia.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <asm/arch/menelaus.h>
-
-#ifdef CONFIG_MENELAUS
-
-static int n800_auto_sleep_regulators(void)
-{
-	u32 val;
-	int ret;
-
-	val = EN_VPLL_SLEEP | EN_VMMC_SLEEP    \
-		| EN_VAUX_SLEEP | EN_VIO_SLEEP \
-		| EN_VMEM_SLEEP | EN_DC3_SLEEP \
-		| EN_VC_SLEEP | EN_DC2_SLEEP;
-
-	ret = menelaus_set_regulator_sleep(1, val);
-	if (ret < 0) {
-		printk(KERN_ERR "Could not set regulators to sleep on "
-			"menelaus: %u\n", ret);
-		return ret;
-	}
-	return 0;
-}
-
-static int n800_auto_voltage_scale(void)
-{
-	int ret;
-
-	ret = menelaus_set_vcore_hw(1400, 1050);
-	if (ret < 0) {
-		printk(KERN_ERR "Could not set VCORE voltage on "
-			"menelaus: %u\n", ret);
-		return ret;
-	}
-	return 0;
-}
-
-static int n800_menelaus_init(struct device *dev)
-{
-	int ret;
-
-	ret = n800_auto_voltage_scale();
-	if (ret < 0)
-		return ret;
-	ret = n800_auto_sleep_regulators();
-	if (ret < 0)
-		return ret;
-	return 0;
-}
-
-static struct menelaus_platform_data n800_menelaus_platform_data = {
-	.late_init = n800_menelaus_init,
-};
-
-void __init n800_pm_init(void)
-{
-	menelaus_set_platform_data(&n800_menelaus_platform_data);
-}
-
-#else
-
-void __init n800_pm_init(void)
-{
-}
-
-#endif
-
-- 1.5.3.GIT
