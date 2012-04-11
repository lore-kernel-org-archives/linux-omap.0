From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH 09/12] arm: omap3: am35x: Add SDRC EMIF4 feature
Date: Wed, 11 Apr 2012 12:05:44 -0700
Message-ID: <1334171147-7517-10-git-send-email-mgreer@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:50124 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761129Ab2DKTsO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 15:48:14 -0400
In-Reply-To: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, paul@pwsan.com, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

The typical SDRAM Controller Subsystem module (SDRC)
on TI OMAP3 devices has two submodules: the SDRAM Memory
Scheduler (SMS) submodule, and the SDRC submodule--the
'SDRC' acronym/term is overloaded.  The am35x family of
devices is different in that it has an EMIF4 submodule
instead of an SDRC submodule.  The SMS submodules are
similar, though.

To allow code to determine whether the current device has an
SDRC submodule or and EMIF4 submodule, add the 'OMAP3_HAS_SDRC_EMIF4'
feature and set it when running on an am35x SoC.

So when:
- omap3_has_sdrc() returns true: the system has an SDRC module
	consisting of an SMS submodule and either an SDRC submodule
	or an EMIF4 submodule.
- omap3_has_sdrc_emif4() returns true: the system has an EMIF4
	submodule.  It is assumed that this feature will only be
	checked when there is an SDRC module present (i.e., when
	omap3_has_sdrc() would return true).

Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/id.c              |    5 ++++-
 arch/arm/plat-omap/include/plat/cpu.h |   12 +++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index b6508e5..abb5e51 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -256,10 +256,13 @@ void __init omap3xxx_check_features(void)
 	 *   the incorrectly set feature bits.
 	 * - Indicate that am35x SoCs don't support the PWRDM_POWER_RET
 	 *   and PWRDM_POWER_OFF states by clearing OMAP3_HAS_PWROFF.
+	 * - Indicate that am35x SoCs have an EMIF4 SDRC submodule.
 	 */
-	if (cpu_is_omap3505() || cpu_is_omap3517())
+	if (cpu_is_omap3505() || cpu_is_omap3517()) {
 		omap_features &= ~(OMAP3_HAS_IVA | OMAP3_HAS_ISP |
 			OMAP3_HAS_PWROFF);
+		omap_features |= OMAP3_HAS_SDRC_EMIF4;
+	}
 
 	/*
 	 * TODO: Get additional info (where applicable)
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index c3f1a42..207f21b 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -476,11 +476,12 @@ extern u32 omap_features;
 #define OMAP3_HAS_192MHZ_CLK		BIT(5)
 #define OMAP3_HAS_IO_WAKEUP		BIT(6)
 #define OMAP3_HAS_SDRC			BIT(7)
-#define OMAP3_HAS_IO_CHAIN_CTRL		BIT(8)
-#define OMAP3_HAS_PWROFF		BIT(9)
-#define OMAP4_HAS_MPU_1GHZ		BIT(10)
-#define OMAP4_HAS_MPU_1_2GHZ		BIT(11)
-#define OMAP4_HAS_MPU_1_5GHZ		BIT(12)
+#define OMAP3_HAS_SDRC_EMIF4		BIT(8)
+#define OMAP3_HAS_IO_CHAIN_CTRL		BIT(9)
+#define OMAP3_HAS_PWROFF		BIT(10)
+#define OMAP4_HAS_MPU_1GHZ		BIT(11)
+#define OMAP4_HAS_MPU_1_2GHZ		BIT(12)
+#define OMAP4_HAS_MPU_1_5GHZ		BIT(13)
 
 
 #define OMAP3_HAS_FEATURE(feat,flag)			\
@@ -497,6 +498,7 @@ OMAP3_HAS_FEATURE(isp, ISP)
 OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
 OMAP3_HAS_FEATURE(io_wakeup, IO_WAKEUP)
 OMAP3_HAS_FEATURE(sdrc, SDRC)
+OMAP3_HAS_FEATURE(sdrc_emif4, SDRC_EMIF4)
 OMAP3_HAS_FEATURE(io_chain_ctrl, IO_CHAIN_CTRL)
 OMAP3_HAS_FEATURE(pwroff, PWROFF)
 
-- 
1.7.9.4

