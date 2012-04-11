From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH 05/12] arm: omap3: am35x: Add PWROFF feature
Date: Wed, 11 Apr 2012 12:05:40 -0700
Message-ID: <1334171147-7517-6-git-send-email-mgreer@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:49919 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761084Ab2DKTsJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 15:48:09 -0400
In-Reply-To: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, paul@pwsan.com, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

Typical OMAP3 SoCs have four power domain states: ON,
INACTIVE, RETENTION, and OFF.  The am35x family of SoCs
has only two states: ON and INACTIVE.  To distinguish which
set of states the current device has, add the 'OMAP3_HAS_PWROFF'
feature.  When that feature/bit is set, the device supports the
RETENTION and OFF states; otherwise, it doesn't.

Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/id.c              |    7 +++++--
 arch/arm/plat-omap/include/plat/cpu.h |    8 +++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 9736049..b6508e5 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -245,7 +245,7 @@ void __init omap3xxx_check_features(void)
 	    omap_rev() == OMAP3430_REV_ES3_1_2)
 		omap_features |= OMAP3_HAS_IO_CHAIN_CTRL;
 
-	omap_features |= OMAP3_HAS_SDRC;
+	omap_features |= OMAP3_HAS_SDRC | OMAP3_HAS_PWROFF;
 
 	/*
 	 * am35x fixups:
@@ -254,9 +254,12 @@ void __init omap3xxx_check_features(void)
 	 *   OMAP3_CHECK_FEATURE() will interpret some of those zeroes to
 	 *   mean that a feature is present even though it isn't so clear
 	 *   the incorrectly set feature bits.
+	 * - Indicate that am35x SoCs don't support the PWRDM_POWER_RET
+	 *   and PWRDM_POWER_OFF states by clearing OMAP3_HAS_PWROFF.
 	 */
 	if (cpu_is_omap3505() || cpu_is_omap3517())
-		omap_features &= ~(OMAP3_HAS_IVA | OMAP3_HAS_ISP);
+		omap_features &= ~(OMAP3_HAS_IVA | OMAP3_HAS_ISP |
+			OMAP3_HAS_PWROFF);
 
 	/*
 	 * TODO: Get additional info (where applicable)
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index dc6a86b..c3f1a42 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -477,9 +477,10 @@ extern u32 omap_features;
 #define OMAP3_HAS_IO_WAKEUP		BIT(6)
 #define OMAP3_HAS_SDRC			BIT(7)
 #define OMAP3_HAS_IO_CHAIN_CTRL		BIT(8)
-#define OMAP4_HAS_MPU_1GHZ		BIT(9)
-#define OMAP4_HAS_MPU_1_2GHZ		BIT(10)
-#define OMAP4_HAS_MPU_1_5GHZ		BIT(11)
+#define OMAP3_HAS_PWROFF		BIT(9)
+#define OMAP4_HAS_MPU_1GHZ		BIT(10)
+#define OMAP4_HAS_MPU_1_2GHZ		BIT(11)
+#define OMAP4_HAS_MPU_1_5GHZ		BIT(12)
 
 
 #define OMAP3_HAS_FEATURE(feat,flag)			\
@@ -497,6 +498,7 @@ OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
 OMAP3_HAS_FEATURE(io_wakeup, IO_WAKEUP)
 OMAP3_HAS_FEATURE(sdrc, SDRC)
 OMAP3_HAS_FEATURE(io_chain_ctrl, IO_CHAIN_CTRL)
+OMAP3_HAS_FEATURE(pwroff, PWROFF)
 
 /*
  * Runtime detection of OMAP4 features
-- 
1.7.9.4

