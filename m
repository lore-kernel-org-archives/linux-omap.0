From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCHv2] OMAP3: AM3505/3517 do not have IO wakeup capability
Date: Thu, 24 Jun 2010 18:20:11 +0800
Message-ID: <1277374811-7075-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:55023 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754462Ab0FXKHn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 06:07:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com

AM3505/3517 don't have IO wakeup capability, so we don not need to set
the bit OMAP3430_EN_IO and the bit OMAP3430_EN_IO_CHAIN in the register
PM_WKEN_WKUP when the system enters retention.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/mach-omap2/id.c              |    2 ++
 arch/arm/mach-omap2/pm34xx.c          |   10 ++++++----
 arch/arm/plat-omap/include/plat/cpu.h |    2 ++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 37b8a1a..67bd971 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -179,6 +179,8 @@ void __init omap3_check_features(void)
 	OMAP3_CHECK_FEATURE(status, ISP);
 	if (cpu_is_omap3630())
 		omap3_features |= OMAP3_HAS_192MHZ_CLK;
+	if (!cpu_is_omap3505() && !cpu_is_omap3517())
+		omap3_features |= OMAP3_HAS_IO_WAKEUP;
 
 	/*
 	 * TODO: Get additional info (where applicable)
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 86a2240..7cc8fce 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -416,9 +416,11 @@ void omap_sram_idle(void)
 			omap3_core_save_context();
 			omap3_prcm_save_context();
 		}
-		/* Enable IO-PAD and IO-CHAIN wakeups */
-		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
-		omap3_enable_io_chain();
+		if (omap3_has_io_wakeup()) {
+			/* Enable IO-PAD and IO-CHAIN wakeups */
+			prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
+			omap3_enable_io_chain();
+		}
 	}
 	omap3_intc_prepare_idle();
 
@@ -494,7 +496,7 @@ void omap_sram_idle(void)
 	}
 
 	/* Disable IO-PAD and IO-CHAIN wakeup */
-	if (core_next_state < PWRDM_POWER_ON) {
+	if (core_next_state < PWRDM_POWER_ON && omap3_has_io_wakeup()) {
 		prm_clear_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
 		omap3_disable_io_chain();
 	}
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 7514174..aa2f4f0 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -444,6 +444,7 @@ extern u32 omap3_features;
 #define OMAP3_HAS_NEON			BIT(3)
 #define OMAP3_HAS_ISP			BIT(4)
 #define OMAP3_HAS_192MHZ_CLK		BIT(5)
+#define OMAP3_HAS_IO_WAKEUP		BIT(6)
 
 #define OMAP3_HAS_FEATURE(feat,flag)			\
 static inline unsigned int omap3_has_ ##feat(void)	\
@@ -457,5 +458,6 @@ OMAP3_HAS_FEATURE(iva, IVA)
 OMAP3_HAS_FEATURE(neon, NEON)
 OMAP3_HAS_FEATURE(isp, ISP)
 OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
+OMAP3_HAS_FEATURE(io_wakeup, IO_WAKEUP)
 
 #endif
-- 
1.5.4.3

