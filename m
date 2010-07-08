From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/5] omap: Replace omap3_has_ macros with omap_has_feature
Date: Thu, 08 Jul 2010 12:37:58 +0300
Message-ID: <20100708093758.16352.93682.stgit@baageli.muru.com>
References: <20100708093405.16352.11814.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53441 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755628Ab0GHJiA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 05:38:00 -0400
In-Reply-To: <20100708093405.16352.11814.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com

Replace omap3_has_ macros with omap_has_feature

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c  |    2 +-
 arch/arm/mach-omap2/id.c              |   22 +++++++++++-----------
 arch/arm/mach-omap2/pm34xx.c          |    2 +-
 arch/arm/plat-omap/include/plat/cpu.h |   12 ++++++------
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index c226798..2d2248f 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3435,7 +3435,7 @@ int __init omap3xxx_clk_init(void)
 		cpu_clkflg |= CK_3505;
 	}
 
-	if (omap3_has_192mhz_clk())
+	if (omap_has_feature(OMAP3_HAS_192MHZ_CLK))
 		omap_96m_alwon_fck = omap_96m_alwon_fck_3630;
 
 	if (cpu_is_omap3630()) {
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index a2e5965..11184cf 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -336,7 +336,7 @@ static void __init omap4_check_revision(void)
 }
 
 #define OMAP3_SHOW_FEATURE(feat)		\
-	if (omap3_has_ ##feat())		\
+	if (omap_has_feature(feat))		\
 		printk(#feat" ");
 
 static void __init omap3_cpuinfo(void)
@@ -356,20 +356,20 @@ static void __init omap3_cpuinfo(void)
 		/*
 		 * AM35xx devices
 		 */
-		if (omap3_has_sgx()) {
+		if (omap_has_feature(OMAP3_HAS_SGX)) {
 			omap_revision = OMAP3517_REV(rev);
 			strcpy(cpu_name, "AM3517");
 		} else {
 			/* Already set in omap3_check_revision() */
 			strcpy(cpu_name, "AM3505");
 		}
-	} else if (omap3_has_iva() && omap3_has_sgx()) {
+	} else if (omap_has_feature(OMAP3_HAS_IVA | OMAP3_HAS_SGX)) {
 		/* OMAP3430, OMAP3525, OMAP3515, OMAP3503 devices */
 		strcpy(cpu_name, "OMAP3430/3530");
-	} else if (omap3_has_iva()) {
+	} else if (omap_has_feature(OMAP3_HAS_IVA)) {
 		omap_revision = OMAP3525_REV(rev);
 		strcpy(cpu_name, "OMAP3525");
-	} else if (omap3_has_sgx()) {
+	} else if (omap_has_feature(OMAP3_HAS_SGX)) {
 		omap_revision = OMAP3515_REV(rev);
 		strcpy(cpu_name, "OMAP3515");
 	} else {
@@ -400,12 +400,12 @@ static void __init omap3_cpuinfo(void)
 	/* Print verbose information */
 	pr_info("%s ES%s (", cpu_name, cpu_rev);
 
-	OMAP3_SHOW_FEATURE(l2cache);
-	OMAP3_SHOW_FEATURE(iva);
-	OMAP3_SHOW_FEATURE(sgx);
-	OMAP3_SHOW_FEATURE(neon);
-	OMAP3_SHOW_FEATURE(isp);
-	OMAP3_SHOW_FEATURE(192mhz_clk);
+	OMAP3_SHOW_FEATURE(OMAP3_HAS_L2CACHE);
+	OMAP3_SHOW_FEATURE(OMAP3_HAS_IVA);
+	OMAP3_SHOW_FEATURE(OMAP3_HAS_SGX);
+	OMAP3_SHOW_FEATURE(OMAP3_HAS_NEON);
+	OMAP3_SHOW_FEATURE(OMAP3_HAS_ISP);
+	OMAP3_SHOW_FEATURE(OMAP3_HAS_192MHZ_CLK);
 
 	printk(")\n");
 }
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fb4994a..32e1005 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -385,7 +385,7 @@ void omap_sram_idle(void)
 	/* Enable IO-PAD and IO-CHAIN wakeups */
 	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
 	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
-	if (omap3_has_io_wakeup() && \
+	if (omap_has_feature(OMAP3_HAS_IO_WAKEUP) &&		\
 			(per_next_state < PWRDM_POWER_ON ||
 			core_next_state < PWRDM_POWER_ON)) {
 		prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 127df06..efee323 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -334,14 +334,14 @@ IS_OMAP_TYPE(3517, 0x3517)
 # undef cpu_is_omap3517
 # define cpu_is_omap3430()		is_omap3430()
 # define cpu_is_omap3503()		(cpu_is_omap3430() &&		\
-						(!omap3_has_iva()) &&	\
-						(!omap3_has_sgx()))
+					 (!omap_has_feature(OMAP3_HAS_IVA) &&	\
+						(!omap_has_feature(OMAP3_HAS_SGX)))
 # define cpu_is_omap3515()		(cpu_is_omap3430() &&		\
-						(!omap3_has_iva()) &&	\
-						(omap3_has_sgx()))
+						(!omap_has_feature(OMAP3_HAS_IVA)) &&	\
+						(omap_has_feature(OMAP3_HAS_SGX)))
 # define cpu_is_omap3525()		(cpu_is_omap3430() &&		\
-						(!omap3_has_sgx()) &&	\
-						(omap3_has_iva()))
+						(!omap_has_feature(OMAP3_HAS_SGX)) &&	\
+						(omap_has_feature(OMAP3_HAS_IVA)))
 # define cpu_is_omap3530()		(cpu_is_omap3430())
 # define cpu_is_omap3505()		is_omap3505()
 # define cpu_is_omap3517()		is_omap3517()

