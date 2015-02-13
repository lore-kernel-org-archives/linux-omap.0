From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 10/33] ARM: OMAP4+: PRM: move omap_prm_base_init under OMAP4 PRM driver
Date: Fri, 13 Feb 2015 18:12:29 +0200
Message-ID: <1423843973-6050-8-git-send-email-t-kristo@ti.com>
References: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54262 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753510AbbBMQNy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 11:13:54 -0500
In-Reply-To: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, tomi.valkeinen@ti.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

There is no need to call this separately from io.c, rather this can be
done commonly under the PRM driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/io.c      |    4 ----
 arch/arm/mach-omap2/prm44xx.c |    2 ++
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index bfca825..e6aa099 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -591,7 +591,6 @@ void __init am43xx_init_early(void)
 				  NULL);
 	omap2_set_globals_prm(AM33XX_L4_WK_IO_ADDRESS(AM43XX_PRCM_BASE));
 	omap2_set_globals_cm(AM33XX_L4_WK_IO_ADDRESS(AM43XX_PRCM_BASE), NULL);
-	omap_prm_base_init();
 	omap_cm_base_init();
 	omap3xxx_check_revision();
 	am33xx_check_features();
@@ -622,7 +621,6 @@ void __init omap4430_init_early(void)
 	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BASE),
 			     OMAP2_L4_IO_ADDRESS(OMAP4430_CM2_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE));
-	omap_prm_base_init();
 	omap_cm_base_init();
 	omap4xxx_check_revision();
 	omap4xxx_check_features();
@@ -658,7 +656,6 @@ void __init omap5_init_early(void)
 			     OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap4_pm_init_early();
-	omap_prm_base_init();
 	omap_cm_base_init();
 	omap44xx_prm_init();
 	omap5xxx_check_revision();
@@ -690,7 +687,6 @@ void __init dra7xx_init_early(void)
 			     OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap4_pm_init_early();
-	omap_prm_base_init();
 	omap_cm_base_init();
 	omap44xx_prm_init();
 	dra7xxx_check_revision();
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 0f0e49f..2692339 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -704,6 +704,8 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
 
 int __init omap44xx_prm_init(void)
 {
+	omap_prm_base_init();
+
 	if (cpu_is_omap44xx() || soc_is_omap54xx() || soc_is_dra7xx())
 		prm_features |= PRM_HAS_IO_WAKEUP;
 
-- 
1.7.9.5

