From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] ARM: OMAP2+: Move GPMC initcall to devices.c
Date: Thu, 20 Nov 2014 14:28:20 -0800
Message-ID: <1416522501-14999-3-git-send-email-tony@atomide.com>
References: <1416522501-14999-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48035 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756935AbaKTW3A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2014 17:29:00 -0500
In-Reply-To: <1416522501-14999-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Roger Quadros <rogerq@ti.com>

This will us allow to just move gpmc.c to live under drivers
in the next patch.

Note that we now also remove the omap specific check for the
initcall. That's OK as gpmc_probe() checks for the pdata
and bails out for other platforms compiled in.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c | 26 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/gpmc.c    | 31 +------------------------------
 2 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 324f02b..110256a 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -445,3 +445,29 @@ static int __init omap2_init_devices(void)
 	return 0;
 }
 omap_arch_initcall(omap2_init_devices);
+
+static int __init omap_gpmc_init(void)
+{
+	struct omap_hwmod *oh;
+	struct platform_device *pdev;
+	char *oh_name = "gpmc";
+
+	/*
+	 * if the board boots up with a populated DT, do not
+	 * manually add the device from this initcall
+	 */
+	if (of_have_populated_dt())
+		return -ENODEV;
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("Could not look up %s\n", oh_name);
+		return -ENODEV;
+	}
+
+	pdev = omap_device_build("omap-gpmc", -1, oh, NULL, 0);
+	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
+
+	return PTR_RET(pdev);
+}
+omap_postcore_initcall(omap_gpmc_init);
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index bc14f25..80dfb17 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -37,9 +37,6 @@
 #include <linux/platform_data/mtd-nand-omap2.h>
 #include <linux/platform_data/mtd-onenand-omap2.h>
 
-#include "soc.h"
-#include "omap_device.h"
-
 #include <asm/mach-types.h>
 
 #define	DEVICE_NAME		"omap-gpmc"
@@ -2010,35 +2007,9 @@ static __exit void gpmc_exit(void)
 
 }
 
-omap_postcore_initcall(gpmc_init);
+postcore_initcall(gpmc_init);
 module_exit(gpmc_exit);
 
-static int __init omap_gpmc_init(void)
-{
-	struct omap_hwmod *oh;
-	struct platform_device *pdev;
-	char *oh_name = "gpmc";
-
-	/*
-	 * if the board boots up with a populated DT, do not
-	 * manually add the device from this initcall
-	 */
-	if (of_have_populated_dt())
-		return -ENODEV;
-
-	oh = omap_hwmod_lookup(oh_name);
-	if (!oh) {
-		pr_err("Could not look up %s\n", oh_name);
-		return -ENODEV;
-	}
-
-	pdev = omap_device_build(DEVICE_NAME, -1, oh, NULL, 0);
-	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
-
-	return PTR_RET(pdev);
-}
-omap_postcore_initcall(omap_gpmc_init);
-
 static irqreturn_t gpmc_handle_irq(int irq, void *dev)
 {
 	int i;
-- 
2.1.3

