From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: [PATCH v4 1/3] ARM: OMAP2+: Move common part of late init into common function
Date: Thu, 14 Feb 2013 13:55:22 +0200
Message-ID: <1360842924-32429-2-git-send-email-ruslan.bilovol@ti.com>
References: <1360842924-32429-1-git-send-email-ruslan.bilovol@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360842924-32429-1-git-send-email-ruslan.bilovol@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
---
 arch/arm/mach-omap2/io.c |   33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 2c3fdd6..ace87c8 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -379,6 +379,12 @@ static void __init omap_hwmod_init_postsetup(void)
 	omap_pm_if_early_init();
 }
 
+static void __init omap_common_late_init(void)
+{
+	omap_mux_late_init();
+	omap2_common_pm_late_init();
+}
+
 #ifdef CONFIG_SOC_OMAP2420
 void __init omap2420_init_early(void)
 {
@@ -402,8 +408,7 @@ void __init omap2420_init_early(void)
 
 void __init omap2420_init_late(void)
 {
-	omap_mux_late_init();
-	omap2_common_pm_late_init();
+	omap_common_late_init();
 	omap2_pm_init();
 	omap2_clk_enable_autoidle_all();
 }
@@ -432,8 +437,7 @@ void __init omap2430_init_early(void)
 
 void __init omap2430_init_late(void)
 {
-	omap_mux_late_init();
-	omap2_common_pm_late_init();
+	omap_common_late_init();
 	omap2_pm_init();
 	omap2_clk_enable_autoidle_all();
 }
@@ -505,48 +509,42 @@ void __init ti81xx_init_early(void)
 
 void __init omap3_init_late(void)
 {
-	omap_mux_late_init();
-	omap2_common_pm_late_init();
+	omap_common_late_init();
 	omap3_pm_init();
 	omap2_clk_enable_autoidle_all();
 }
 
 void __init omap3430_init_late(void)
 {
-	omap_mux_late_init();
-	omap2_common_pm_late_init();
+	omap_common_late_init();
 	omap3_pm_init();
 	omap2_clk_enable_autoidle_all();
 }
 
 void __init omap35xx_init_late(void)
 {
-	omap_mux_late_init();
-	omap2_common_pm_late_init();
+	omap_common_late_init();
 	omap3_pm_init();
 	omap2_clk_enable_autoidle_all();
 }
 
 void __init omap3630_init_late(void)
 {
-	omap_mux_late_init();
-	omap2_common_pm_late_init();
+	omap_common_late_init();
 	omap3_pm_init();
 	omap2_clk_enable_autoidle_all();
 }
 
 void __init am35xx_init_late(void)
 {
-	omap_mux_late_init();
-	omap2_common_pm_late_init();
+	omap_common_late_init();
 	omap3_pm_init();
 	omap2_clk_enable_autoidle_all();
 }
 
 void __init ti81xx_init_late(void)
 {
-	omap_mux_late_init();
-	omap2_common_pm_late_init();
+	omap_common_late_init();
 	omap3_pm_init();
 	omap2_clk_enable_autoidle_all();
 }
@@ -598,8 +596,7 @@ void __init omap4430_init_early(void)
 
 void __init omap4430_init_late(void)
 {
-	omap_mux_late_init();
-	omap2_common_pm_late_init();
+	omap_common_late_init();
 	omap4_pm_init();
 	omap2_clk_enable_autoidle_all();
 }
-- 
1.7.9.5
