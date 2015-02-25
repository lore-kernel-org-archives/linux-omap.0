From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 06/35] ARM: OMAP4+: CM: move omap_cm_base_init under OMAP4 CM driver
Date: Wed, 25 Feb 2015 21:04:16 +0200
Message-ID: <1424891085-10392-7-git-send-email-t-kristo@ti.com>
References: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49471 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753184AbbBYTEx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Feb 2015 14:04:53 -0500
In-Reply-To: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

There is no need to call this separately from io.c, rather this can be
done commonly under the CM driver. Also, this patch makes the API static,
as it is no longer used outside the driver file.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm44xx.h     |    1 -
 arch/arm/mach-omap2/cminst44xx.c |    4 +++-
 arch/arm/mach-omap2/io.c         |    4 ----
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/cm44xx.h b/arch/arm/mach-omap2/cm44xx.h
index 728d06a..ad6e263 100644
--- a/arch/arm/mach-omap2/cm44xx.h
+++ b/arch/arm/mach-omap2/cm44xx.h
@@ -23,7 +23,6 @@
 #define OMAP4_CM_CLKSTCTRL				0x0000
 #define OMAP4_CM_STATICDEP				0x0004
 
-void omap_cm_base_init(void);
 int omap4_cm_init(void);
 
 #endif
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 95a8cff..9319034 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -63,7 +63,7 @@ static void __iomem *_cm_bases[OMAP4_MAX_PRCM_PARTITIONS];
  * Populates the base addresses of the _cm_bases
  * array used for read/write of cm module registers.
  */
-void omap_cm_base_init(void)
+static void omap_cm_base_init(void)
 {
 	_cm_bases[OMAP4430_PRM_PARTITION] = prm_base;
 	_cm_bases[OMAP4430_CM1_PARTITION] = cm_base;
@@ -516,6 +516,8 @@ static struct cm_ll_data omap4xxx_cm_ll_data = {
 
 int __init omap4_cm_init(void)
 {
+	omap_cm_base_init();
+
 	return cm_register(&omap4xxx_cm_ll_data);
 }
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 5569c2f..364b530 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -623,7 +623,6 @@ void __init am43xx_init_early(void)
 				  NULL);
 	omap2_set_globals_prm(AM33XX_L4_WK_IO_ADDRESS(AM43XX_PRCM_BASE));
 	omap2_set_globals_cm(AM33XX_L4_WK_IO_ADDRESS(AM43XX_PRCM_BASE), NULL);
-	omap_cm_base_init();
 	omap3xxx_check_revision();
 	am33xx_check_features();
 	omap44xx_prm_init();
@@ -653,7 +652,6 @@ void __init omap4430_init_early(void)
 	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BASE),
 			     OMAP2_L4_IO_ADDRESS(OMAP4430_CM2_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE));
-	omap_cm_base_init();
 	omap4xxx_check_revision();
 	omap4xxx_check_features();
 	omap4_cm_init();
@@ -688,7 +686,6 @@ void __init omap5_init_early(void)
 			     OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap4_pm_init_early();
-	omap_cm_base_init();
 	omap44xx_prm_init();
 	omap5xxx_check_revision();
 	omap4_cm_init();
@@ -719,7 +716,6 @@ void __init dra7xx_init_early(void)
 			     OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap4_pm_init_early();
-	omap_cm_base_init();
 	omap44xx_prm_init();
 	dra7xxx_check_revision();
 	omap4_cm_init();
-- 
1.7.9.5

