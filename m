From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/13] OMAP3: AM3505/3517 do not have IO wakeup capability
Date: Thu, 08 Jul 2010 16:55:02 +0300
Message-ID: <20100708135502.26276.53341.stgit@baageli.muru.com>
References: <20100708135342.26276.80936.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56128 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757915Ab0GHNzG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 09:55:06 -0400
In-Reply-To: <20100708135342.26276.80936.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Stanley.Miao" <stanley.miao@windriver.com>, linux-omap@vger.kernel.org

From: stanley.miao <stanley.miao@windriver.com>

AM3505/3517 doesn't have IO wakeup capability, so we do not need to set
the bit OMAP3430_EN_IO and the bit OMAP3430_EN_IO_CHAIN in the register
PM_WKEN_WKUP when the system enters suspend state.

Tested on AM3517EVM and OMAP3530EVM.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/id.c              |    2 ++
 arch/arm/mach-omap2/pm34xx.c          |    7 ++++---
 arch/arm/plat-omap/include/plat/cpu.h |    2 ++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index c7bf0e1..ccaa1ed 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -179,6 +179,8 @@ static void __init omap3_check_features(void)
 	OMAP3_CHECK_FEATURE(status, ISP);
 	if (cpu_is_omap3630())
 		omap3_features |= OMAP3_HAS_192MHZ_CLK;
+	if (!cpu_is_omap3505() && !cpu_is_omap3517())
+		omap3_features |= OMAP3_HAS_IO_WAKEUP;
 
 	/*
 	 * TODO: Get additional info (where applicable)
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b88737f..fb4994a 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -385,8 +385,9 @@ void omap_sram_idle(void)
 	/* Enable IO-PAD and IO-CHAIN wakeups */
 	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
 	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
-	if (per_next_state < PWRDM_POWER_ON ||
-			core_next_state < PWRDM_POWER_ON) {
+	if (omap3_has_io_wakeup() && \
+			(per_next_state < PWRDM_POWER_ON ||
+			core_next_state < PWRDM_POWER_ON)) {
 		prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
 		omap3_enable_io_chain();
 	}
@@ -479,7 +480,7 @@ void omap_sram_idle(void)
 	}
 
 	/* Disable IO-PAD and IO-CHAIN wakeup */
-	if (core_next_state < PWRDM_POWER_ON) {
+	if (omap3_has_io_wakeup() && core_next_state < PWRDM_POWER_ON) {
 		prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
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

