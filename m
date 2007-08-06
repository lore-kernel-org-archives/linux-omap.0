From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH] ARM: OMAP: Remove unnecessary N800 PM board specific file
Date: Mon, 06 Aug 2007 11:10:43 -0400
Message-ID: <46B739F3.6040403@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050307040704070907030902"
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
To: "lin >> Tony Lindgren" <tony@atomide.com>, ext Trilok Soni <soni.trilok@gmail.com>
Cc: "linu >> omap-linux" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------050307040704070907030902
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

From: Trilok Soni <soni.trilok@gmail.com>
From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Remove unnecessary N800 PM board specific file

- Remove unnecessary arch/arm/mach-omap2/board-n800-pm.c file, according with 
Trilok's early patch [1], that moves board-n800-pm.c code to board-n800.c

[1] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commitdiff;h=0d6d581ffec0296f429a777187945943f2127e8f

Signed-off-by: Trilok Soni <soni.trilok@gmail.com>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>



--------------050307040704070907030902
Content-Type: text/plain;
	name*0="0001-ARM-OMAP-Remove-unnecessary-N800-PM-board-specific-file.dif";
	name*1="f"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0001-ARM-OMAP-Remove-unnecessary-N800-PM-board-specific-file";
	filename*1=".diff"

Remove unnecessary N800 PM board specific file

Remove unnecessary arch/arm/mach-omap2/board-n800-pm.c file, according
with Trilok's early patch, that moves board-n800-pm.c code to board-n800.c

Signed-off-by: Trilok Soni <soni.trilok@gmail.com>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Index: linux-omap/arch/arm/mach-omap2/board-n800-pm.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/board-n800-pm.c	2007-06-26 16:04:20.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
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

--------------050307040704070907030902
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050307040704070907030902--
