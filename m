From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 5/8] ARM: DRA7: Reuse io tables and add a new .init_early
Date: Tue, 9 Jul 2013 12:57:50 +0530
Message-ID: <1373354873-12359-6-git-send-email-rnayak@ti.com>
References: <1373354873-12359-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51202 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752794Ab3GIH2m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Jul 2013 03:28:42 -0400
In-Reply-To: <1373354873-12359-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, Rajendra Nayak <rnayak@ti.com>

From: R Sricharan <r.sricharan@ti.com>

The IO descriptor tables for DRA7 are a complete reuse from OMAP5.
A new dra7xx_init_early() does the base address inits.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/common.h   |    1 +
 arch/arm/mach-omap2/io.c       |   22 ++++++++++++++++++++--
 arch/arm/mach-omap2/omap54xx.h |    4 ++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 72cab3f..d226661 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -109,6 +109,7 @@ void omap3630_init_late(void);
 void am35xx_init_late(void);
 void ti81xx_init_late(void);
 int omap2_common_pm_late_init(void);
+void dra7xx_init_early(void);
 
 #ifdef CONFIG_SOC_BUS
 void omap_soc_device_init(void);
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index fe3253a..542e6bd 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -251,7 +251,7 @@ static struct map_desc omap44xx_io_desc[] __initdata = {
 };
 #endif
 
-#ifdef	CONFIG_SOC_OMAP5
+#if defined(CONFIG_SOC_OMAP5) || defined(CONFIG_SOC_DRA7XX)
 static struct map_desc omap54xx_io_desc[] __initdata = {
 	{
 		.virtual	= L3_54XX_VIRT,
@@ -333,7 +333,7 @@ void __init omap4_map_io(void)
 }
 #endif
 
-#ifdef CONFIG_SOC_OMAP5
+#if defined(CONFIG_SOC_OMAP5) ||  defined(CONFIG_SOC_DRA7XX)
 void __init omap5_map_io(void)
 {
 	iotable_init(omap54xx_io_desc, ARRAY_SIZE(omap54xx_io_desc));
@@ -653,6 +653,24 @@ void __init omap5_init_early(void)
 }
 #endif
 
+#ifdef CONFIG_SOC_DRA7XX
+void __init dra7xx_init_early(void)
+{
+	omap2_set_globals_tap(DRA7XX_CLASS,
+			      OMAP2_L4_IO_ADDRESS(DRA7XX_TAP_BASE));
+	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
+				  OMAP2_L4_IO_ADDRESS(DRA7XX_CTRL_BASE));
+	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRM_BASE));
+	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(DRA7XX_CM_CORE_AON_BASE),
+			     OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_BASE));
+	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
+	omap_prm_base_init();
+	omap_cm_base_init();
+	dra7xx_check_revision();
+}
+#endif
+
+
 void __init omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1)
 {
diff --git a/arch/arm/mach-omap2/omap54xx.h b/arch/arm/mach-omap2/omap54xx.h
index a086ba1..2d35c57 100644
--- a/arch/arm/mach-omap2/omap54xx.h
+++ b/arch/arm/mach-omap2/omap54xx.h
@@ -30,4 +30,8 @@
 #define OMAP54XX_CTRL_BASE		0x4a002800
 #define OMAP54XX_SAR_RAM_BASE		0x4ae26000
 
+#define DRA7XX_CM_CORE_AON_BASE		0x4a005000
+#define DRA7XX_CTRL_BASE		0x4a003400
+#define DRA7XX_TAP_BASE			0x4ae0c000
+
 #endif /* __ASM_SOC_OMAP555554XX_H */
-- 
1.7.9.5

