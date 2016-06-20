From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] ARM: AM43XX: hwmod: Fix RSTST register offset for pruss
Date: Mon, 20 Jun 2016 09:22:25 +0530
Message-ID: <1466394745-983-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, afzal@ti.com, d-gerlach@ti.com, s-anna@ti.com, paul@pwsan.com, j-keerthy@ti.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

pruss hwmod RSTST register wrongly points to PWRSTCTRL register in case of
am43xx. Fix the RSTST register offset value.

This can lead to setting of wrong power state values for PER domain.

Fixes: 1c7e224d ("ARM: OMAP2+: hwmod: AM335x: runtime register update")
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 1 +
 arch/arm/mach-omap2/prcm43xx.h                          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index 6a73b6c..55c5878 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -1392,6 +1392,7 @@ static void omap_hwmod_am43xx_rst(void)
 {
 	RSTCTRL(am33xx_pruss_hwmod, AM43XX_RM_PER_RSTCTRL_OFFSET);
 	RSTCTRL(am33xx_gfx_hwmod, AM43XX_RM_GFX_RSTCTRL_OFFSET);
+	RSTST(am33xx_pruss_hwmod, AM43XX_RM_PER_RSTST_OFFSET);
 	RSTST(am33xx_gfx_hwmod, AM43XX_RM_GFX_RSTST_OFFSET);
 }
 
diff --git a/arch/arm/mach-omap2/prcm43xx.h b/arch/arm/mach-omap2/prcm43xx.h
index 7c34c44e..babb5db 100644
--- a/arch/arm/mach-omap2/prcm43xx.h
+++ b/arch/arm/mach-omap2/prcm43xx.h
@@ -39,6 +39,7 @@
 
 /* RM RSTST offsets */
 #define AM43XX_RM_GFX_RSTST_OFFSET			0x0014
+#define AM43XX_RM_PER_RSTST_OFFSET			0x0014
 #define AM43XX_RM_WKUP_RSTST_OFFSET			0x0014
 
 /* CM instances */
-- 
1.9.1
