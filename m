From: Thomas Weber <weber@corscience.de>
Subject: [RFC/PATCH] ARM: OMAP: Fix build for OMAP3 only builds
Date: Wed, 12 Oct 2011 14:03:56 +0200
Message-ID: <1318421036-1498-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:50798 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906Ab1JLMEq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Oct 2011 08:04:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>

When building for OMAP3 only I get the
following errors:

In function `omap2420_init_early':
undefined reference to `omap2_set_globals_242x'
undefined reference to `omap2xxx_voltagedomains_init'
undefined reference to `omap242x_powerdomains_init'
undefined reference to `omap242x_clockdomains_init'
undefined reference to `omap2420_hwmod_init'

In function `omap2430_init_early':
undefined reference to `omap2_set_globals_243x'
undefined reference to `omap2xxx_voltagedomains_init'
undefined reference to `omap243x_powerdomains_init'
undefined reference to `omap243x_clockdomains_init'
undefined reference to `omap2430_hwmod_init'

In function `omap4430_init_early':
undefined reference to `omap2_set_globals_443x'
undefined reference to `omap44xx_voltagedomains_init'
undefined reference to `omap44xx_powerdomains_init'
undefined reference to `omap44xx_clockdomains_init'
undefined reference to `omap44xx_hwmod_init'
undefined reference to `omap4xxx_clk_init'

With this patch the omapXXXX_init_early will be compiled only
when their SOC's are selected.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/io.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index aa96538..f8b9cfa 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -359,6 +359,7 @@ static void __init omap_hwmod_init_postsetup(void)
 	omap_pm_if_early_init();
 }
 
+#ifdef CONFIG_SOC_OMAP2420
 void __init omap2420_init_early(void)
 {
 	omap2_set_globals_242x();
@@ -370,7 +371,9 @@ void __init omap2420_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap2420_clk_init();
 }
+#endif
 
+#ifdef CONFIG_SOC_OMAP2430
 void __init omap2430_init_early(void)
 {
 	omap2_set_globals_243x();
@@ -382,7 +385,9 @@ void __init omap2430_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap2430_clk_init();
 }
+#endif
 
+#ifdef CONFIG_ARCH_OMAP3
 /*
  * Currently only board-omap3beagle.c should call this because of the
  * same machine_id for 34xx and 36xx beagle.. Will get fixed with DT.
@@ -430,7 +435,9 @@ void __init ti816x_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap3xxx_clk_init();
 }
+#endif
 
+#ifdef CONFIG_ARCH_OMAP4
 void __init omap4430_init_early(void)
 {
 	omap2_set_globals_443x();
@@ -442,6 +449,7 @@ void __init omap4430_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap4xxx_clk_init();
 }
+#endif
 
 void __init omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1)
-- 
1.7.7

