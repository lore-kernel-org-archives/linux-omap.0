From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH v3 2/9] ARM: OMAP2+: AM33XX: CM/PRM: Use __ASSEMBLER__ macros in header files
Date: Tue, 29 Jan 2013 16:45:01 +0530
Message-ID: <1359458108-8489-3-git-send-email-vaibhav.bedia@ti.com>
References: <1359458108-8489-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34528 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755559Ab3A2LPu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Jan 2013 06:15:50 -0500
In-Reply-To: <1359458108-8489-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, b-cousson@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, khilman@deeprootsystems.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

This is necessary to ensure that macros declared here can
be reused from assembly files.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
---
v3: Add Peter's Acked-by
v2: No change

 arch/arm/mach-omap2/cm33xx.h  | 2 ++
 arch/arm/mach-omap2/prm33xx.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
index 8009e13..64f4baf 100644
--- a/arch/arm/mach-omap2/cm33xx.h
+++ b/arch/arm/mach-omap2/cm33xx.h
@@ -376,6 +376,7 @@
 #define AM33XX_CM_CEFUSE_CEFUSE_CLKCTRL			AM33XX_CM_REGADDR(AM33XX_CM_CEFUSE_MOD, 0x0020)
 
 
+#ifndef __ASSEMBLER__
 extern bool am33xx_cm_is_clkdm_in_hwsup(s16 inst, u16 cdoffs);
 extern void am33xx_cm_clkdm_enable_hwsup(s16 inst, u16 cdoffs);
 extern void am33xx_cm_clkdm_disable_hwsup(s16 inst, u16 cdoffs);
@@ -412,4 +413,5 @@ static inline int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs,
 }
 #endif
 
+#endif /* ASSEMBLER */
 #endif
diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
index 3f25c56..1c40373 100644
--- a/arch/arm/mach-omap2/prm33xx.h
+++ b/arch/arm/mach-omap2/prm33xx.h
@@ -117,6 +117,7 @@
 #define AM33XX_PM_CEFUSE_PWRSTST_OFFSET		0x0004
 #define AM33XX_PM_CEFUSE_PWRSTST		AM33XX_PRM_REGADDR(AM33XX_PRM_CEFUSE_MOD, 0x0004)
 
+#ifndef __ASSEMBLER__
 extern u32 am33xx_prm_read_reg(s16 inst, u16 idx);
 extern void am33xx_prm_write_reg(u32 val, s16 inst, u16 idx);
 extern u32 am33xx_prm_rmw_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx);
@@ -126,4 +127,5 @@ extern int am33xx_prm_is_hardreset_asserted(u8 shift, s16 inst,
 extern int am33xx_prm_assert_hardreset(u8 shift, s16 inst, u16 rstctrl_offs);
 extern int am33xx_prm_deassert_hardreset(u8 shift, s16 inst,
 		u16 rstctrl_offs, u16 rstst_offs);
+#endif /* ASSEMBLER */
 #endif
-- 
1.8.1

