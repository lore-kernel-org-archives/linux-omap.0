From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v4-alt 4/6] ARM: OMAP2+: gpmc: driver migration hack
Date: Wed, 2 May 2012 14:16:25 +0530
Message-ID: <7c79c607c4ce8946f67fff385d725bfe322849da.1335941444.git.afzal@ti.com>
References: <cover.1335941443.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47731 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755715Ab2EBJDK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 May 2012 05:03:10 -0400
In-Reply-To: <cover.1335941443.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Afzal Mohammed <afzal@ti.com>

This has been made for migrating boards one by one so that
old & new interface can coexist. As a board is migrated to
new interface, return from gpmc_driver_migration w/o doing
anything; add a machine_is_ check for that board to return

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |   27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index c8d07bb..4dcc141 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -868,6 +868,18 @@ static __devinit void gpmc_mem_init(void)
 	}
 }
 
+static void gpmc_driver_migration(void)
+{
+	static struct gpmc_device_pdata *gpmc_device_data[1];
+	static struct gpmc_pdata gpmc_data = {
+		.device_pdata	= gpmc_device_data,
+	};
+
+	omap_init_gpmc(&gpmc_data);
+}
+
+static int gpmc_module_init(void);
+
 static int __init gpmc_init(void)
 {
 	char *oh_name = "gpmc";
@@ -887,7 +899,9 @@ static int __init gpmc_init(void)
 
 	clk_enable(gpmc_l3_clk);
 
-	return 0;
+	gpmc_driver_migration();
+
+	return gpmc_module_init();
 }
 postcore_initcall(gpmc_init);
 
@@ -1484,7 +1498,16 @@ static struct platform_driver gpmc_driver = {
 	},
 };
 
-module_platform_driver(gpmc_driver);
+static __init int gpmc_module_init(void)
+{
+	return platform_driver_register(&gpmc_driver);
+}
+
+static __exit void gpmc_tmp_exit(void)
+{
+	platform_driver_unregister(&gpmc_driver);
+}
+module_exit(gpmc_tmp_exit);
 
 #ifdef CONFIG_ARCH_OMAP3
 static struct omap3_gpmc_regs gpmc_context;
-- 
1.7.10

