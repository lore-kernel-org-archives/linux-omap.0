From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 07/11] ARM: OMAP3: CM/PM: add new API for checking IVA2 idle status
Date: Fri, 11 Oct 2013 19:15:37 +0300
Message-ID: <1381508141-15244-8-git-send-email-t-kristo@ti.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56925 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758558Ab3JKQQb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Oct 2013 12:16:31 -0400
In-Reply-To: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@linaro.org, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

OMAP3 PM code needs this functionality during the IVA2 reset, but is currently
using direct CM register accesses for this purpose. Implement a new API so
the PM code can use this instead.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm3xxx.c |    6 ++++++
 arch/arm/mach-omap2/cm3xxx.h |    1 +
 arch/arm/mach-omap2/pm34xx.c |    3 +--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index 55bf939..b0509b9 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -696,6 +696,12 @@ void omap3_cm_force_iva_clk(bool enable)
 	omap2_cm_write_mod_reg(val, OMAP3430_IVA2_MOD, CM_FCLKEN);
 }
 
+bool omap3_cm_is_iva_active(void)
+{
+	return omap2_cm_read_mod_reg(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSTST) &
+		OMAP3430_CLKACTIVITY_IVA2_MASK;
+}
+
 /*
  *
  */
diff --git a/arch/arm/mach-omap2/cm3xxx.h b/arch/arm/mach-omap2/cm3xxx.h
index 61fdfc7..a944b5f 100644
--- a/arch/arm/mach-omap2/cm3xxx.h
+++ b/arch/arm/mach-omap2/cm3xxx.h
@@ -87,6 +87,7 @@ extern void omap3_cm_save_scratchpad_contents(u32 *ptr);
 extern u32 omap3_cm_write_module_clken(s16 module, u8 regs, bool fck, u32 val);
 extern u32 omap3_cm_read_module_clken(s16 module, u8 regs, bool fck);
 extern void omap3_cm_force_iva_clk(bool enable);
+extern bool omap3_cm_is_iva_active(void);
 
 extern int __init omap3xxx_cm_init(void);
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ede058a..a73a012 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -415,8 +415,7 @@ static void __init omap3_iva_idle(void)
 	omap3_cm_force_iva_clk(false);
 
 	/* if no clock activity, nothing else to do */
-	if (!(omap2_cm_read_mod_reg(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSTST) &
-	      OMAP3430_CLKACTIVITY_IVA2_MASK))
+	if (!omap3_cm_is_iva_active())
 		return;
 
 	/* Reset IVA2 */
-- 
1.7.9.5

