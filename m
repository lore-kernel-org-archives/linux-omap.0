From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 35/35] ARM: OMAP4+: control: add support for initializing control module via DT
Date: Wed, 25 Feb 2015 21:04:45 +0200
Message-ID: <1424891085-10392-36-git-send-email-t-kristo@ti.com>
References: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37521 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753619AbbBYTFs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Feb 2015 14:05:48 -0500
In-Reply-To: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

OMAP4, OMAP5 and DRA7 now parse DT entries for control module address spaces,
and set up syscon mappings appropriately. Low level IO init is updated to
remove the legacy control module mappings for these devices also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/control.c |    3 +++
 arch/arm/mach-omap2/io.c      |    6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 570bb07..b61af5e 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -649,6 +649,9 @@ static const struct of_device_id omap_scrm_dt_match_table[] = {
 	{ .compatible = "ti,am4-scrm", .data = &ctrl_data },
 	{ .compatible = "ti,omap2-scrm", .data = &omap2_ctrl_data },
 	{ .compatible = "ti,omap3-scrm", .data = &omap2_ctrl_data },
+	{ .compatible = "ti,omap4-ctrl", .data = &ctrl_data },
+	{ .compatible = "ti,omap5-ctrl", .data = &ctrl_data },
+	{ .compatible = "ti,dra7-ctrl", .data = &ctrl_data },
 	{ }
 };
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 6c39cc0..7743e367 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -631,8 +631,8 @@ void __init omap4430_init_early(void)
 {
 	omap2_set_globals_tap(OMAP443X_CLASS,
 			      OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE));
+	omap2_control_base_init();
 	omap4xxx_check_revision();
 	omap4xxx_check_features();
 	omap2_prcm_base_init();
@@ -659,8 +659,8 @@ void __init omap5_init_early(void)
 {
 	omap2_set_globals_tap(OMAP54XX_CLASS,
 			      OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
+	omap2_control_base_init();
 	omap4_pm_init_early();
 	omap2_prcm_base_init();
 	omap5xxx_check_revision();
@@ -684,8 +684,8 @@ void __init omap5_init_late(void)
 void __init dra7xx_init_early(void)
 {
 	omap2_set_globals_tap(-1, OMAP2_L4_IO_ADDRESS(DRA7XX_TAP_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
+	omap2_control_base_init();
 	omap4_pm_init_early();
 	omap2_prcm_base_init();
 	dra7xxx_check_revision();
-- 
1.7.9.5

