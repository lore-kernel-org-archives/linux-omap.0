From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCHv2]omap:dmtimer:no null check for kzalloc
Date: Mon, 12 Jul 2010 22:00:05 +0530
Message-ID: <1278952205-2580-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43783 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab0GLFcc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jul 2010 01:32:32 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o6C5WSwb001285
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 12 Jul 2010 00:32:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti Debbarma <tarun.kanti@ti.com>

This patch incorporates null pointer check associated with memory allocation
for omap_dm_timer_plat_info using kzalloc()

version 2 change list:
(i) removed concatenate ("\") in pr_err()
(ii) changed return type of omap2_dm_timer_early_init() from void to int
in order to support return -ENOMEM
(iii) made other related changes with regard to return type.

Tested on OMAP4430 SDP.

Signed-off-by: Tarun Kanti Debbarma <tarun.kanti@ti.com>
---
 arch/arm/mach-omap2/dmtimers.c |   26 +++++++++++++++++++++-----
 arch/arm/mach-omap2/dmtimers.h |    2 +-
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/dmtimers.c b/arch/arm/mach-omap2/dmtimers.c
index 772be63..1540627 100644
--- a/arch/arm/mach-omap2/dmtimers.c
+++ b/arch/arm/mach-omap2/dmtimers.c
@@ -192,7 +192,7 @@ void __init omap2_dm_timer_setup_clksrc(void)
 	is_initialized = 1;
 }
 
-void __init omap2_dm_timer_early_init(void)
+int __init omap2_dm_timer_early_init(void)
 {
 	int i = 0;
 
@@ -219,7 +219,7 @@ void __init omap2_dm_timer_early_init(void)
 				break;
 			default:
 				/* Error should never enter here */
-				return;
+				return -EINVAL;
 			}
 
 			pdata->io_base = ioremap(base, SZ_8K);
@@ -248,7 +248,12 @@ void __init omap2_dm_timer_early_init(void)
 
 			pdata = kzalloc(sizeof(struct omap_dm_timer_plat_info),
 					GFP_KERNEL);
-
+			if (!pdata) {
+				pr_err("%s:"
+				"No memory for omap_dm_timer_plat_info\n",
+				__func__);
+				return -ENOMEM;
+			}
 			pdata->omap_dm_clk_enable = omap2_dm_timer_enable;
 			pdata->omap_dm_clk_disable = omap2_dm_timer_disable;
 			pdata->omap_dm_set_source_clk = omap2_dm_timer_set_clk;
@@ -271,7 +276,7 @@ void __init omap2_dm_timer_early_init(void)
 	omap2_dm_timer_setup_clksrc();
 	early_platform_driver_register_all("earlytimer");
 	early_platform_driver_probe("earlytimer", NO_EARLY_TIMERS, 0);
-	return;
+	return 0;
 }
 
 int __init omap2_dm_timer_init(void)
@@ -346,6 +351,12 @@ int __init omap2_dm_timer_init(void)
 
 			pdata = kzalloc(sizeof(struct omap_dm_timer_plat_info),
 					GFP_KERNEL);
+			if (!pdata) {
+				pr_err("%s:"
+				"No memory for omap_dm_timer_plat_info\n",
+				__func__);
+				return -ENOMEM;
+			}
 			pdata->omap_dm_clk_enable = omap2_dm_timer_enable;
 			pdata->omap_dm_clk_disable = omap2_dm_timer_disable;
 			pdata->omap_dm_set_source_clk = omap2_dm_timer_set_clk;
@@ -397,7 +408,12 @@ fail:
 				break;
 			pdata = kzalloc(sizeof(struct omap_dm_timer_plat_info),
 					GFP_KERNEL);
-
+			if (!pdata) {
+				pr_err("%s:"
+				"No memory for omap_dm_timer_plat_info\n",
+				__func__);
+				return -ENOMEM;
+			}
 			pdata->omap_dm_clk_enable = omap2_dm_timer_enable;
 			pdata->omap_dm_clk_disable = omap2_dm_timer_disable;
 			pdata->omap_dm_set_source_clk = omap2_dm_timer_set_clk;
diff --git a/arch/arm/mach-omap2/dmtimers.h b/arch/arm/mach-omap2/dmtimers.h
index 2309e4a..afb2d36 100644
--- a/arch/arm/mach-omap2/dmtimers.h
+++ b/arch/arm/mach-omap2/dmtimers.h
@@ -52,6 +52,6 @@
 #define OMAP44XX_GPTIMER11_BASE         0x48088000
 #define OMAP44XX_GPTIMER12_BASE         0x4a320000
 
-void __init omap2_dm_timer_early_init(void);
+int __init omap2_dm_timer_early_init(void);
 
 #endif
