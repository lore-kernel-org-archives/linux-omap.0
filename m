From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 05/23] ARM: OMAP2: CM: remove unused PLL functions
Date: Thu, 27 Nov 2014 17:51:36 +0200
Message-ID: <1417103514-17027-6-git-send-email-t-kristo@ti.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46236 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbaK0Pvp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Nov 2014 10:51:45 -0500
In-Reply-To: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

omap2xxx_cm_get_pll_config and omap2xxx_cm_get_pll_status are not used
for anything, so remove these.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm2xxx.c |   10 ----------
 arch/arm/mach-omap2/cm2xxx.h |    2 --
 2 files changed, 12 deletions(-)

diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
index a96d901..ef62ac9 100644
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -370,16 +370,6 @@ u32 omap2xxx_cm_get_core_pll_config(void)
 	return omap2_cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
 }
 
-u32 omap2xxx_cm_get_pll_config(void)
-{
-	return omap2_cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
-}
-
-u32 omap2xxx_cm_get_pll_status(void)
-{
-	return omap2_cm_read_mod_reg(PLL_MOD, CM_CLKEN);
-}
-
 void omap2xxx_cm_set_mod_dividers(u32 mpu, u32 dsp, u32 gfx, u32 core, u32 mdm)
 {
 	u32 tmp;
diff --git a/arch/arm/mach-omap2/cm2xxx.h b/arch/arm/mach-omap2/cm2xxx.h
index c89502b..83b6c59 100644
--- a/arch/arm/mach-omap2/cm2xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx.h
@@ -60,8 +60,6 @@ extern int omap2xxx_cm_fclks_active(void);
 extern int omap2xxx_cm_mpu_retention_allowed(void);
 extern u32 omap2xxx_cm_get_core_clk_src(void);
 extern u32 omap2xxx_cm_get_core_pll_config(void);
-extern u32 omap2xxx_cm_get_pll_config(void);
-extern u32 omap2xxx_cm_get_pll_status(void);
 extern void omap2xxx_cm_set_mod_dividers(u32 mpu, u32 dsp, u32 gfx, u32 core,
 					 u32 mdm);
 
-- 
1.7.9.5

