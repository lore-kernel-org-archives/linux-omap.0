From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH/RFT v2] OMAP4: fix temporary hacks that break multi-omap PM
Date: Mon,  8 Mar 2010 10:32:31 -0800
Message-ID: <1268073151-12332-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f198.google.com ([209.85.221.198]:36341 "EHLO
	mail-qy0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab0CHSc6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 13:32:58 -0500
Received: by qyk36 with SMTP id 36so4519320qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 08 Mar 2010 10:32:57 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

When building for multi-omap, and OMAP4 is enabled, CONFIG_ARCH_OMAP4
will be true and prevent included code from building/running for
OMAP2/3 as well.

This problem exists in io.c where some hwmod/PM/SDRC init code is
prevented from running even on OMAP2/3 when OMAP4 is included in a
multi-OMAP build.

A quick glance suggests that this #ifndef is no longer needed.  The
called functions should work fine or fail gracefully in the OMAP4
case.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---

Needs testing on OMAP4 since still no OMAP4 hardware here.

Updates from v1:
- removed additional #ifdef block in init_common_hw()

 arch/arm/mach-omap2/io.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 81312b4..daefe79 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -309,7 +309,6 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 {
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_autodeps);
-#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is ready */
 #ifdef CONFIG_ARCH_OMAP2420
 	if (cpu_is_omap242x())
 		omap2420_hwmod_init();
@@ -325,7 +324,6 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 	omap2_mux_init();
 	/* The OPP tables have to be registered before a clk init */
 	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
-#endif
 
 	if (cpu_is_omap2420())
 		omap2420_clk_init();
@@ -339,11 +337,10 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 		pr_err("Could not init clock framework - unknown CPU\n");
 
 	omap_serial_early_init();
-#ifndef CONFIG_ARCH_OMAP4
 	omap_hwmod_late_init();
 	omap_pm_if_init();
 	omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
 	_omap2_init_reprogram_sdrc();
-#endif
+
 	gpmc_init();
 }
-- 
1.7.0.2

