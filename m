From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 16/19] OMAP4: fix temporary hacks that break multi-omap PM
Date: Thu, 11 Mar 2010 15:48:44 -0800
Message-ID: <20100311234844.4500.30209.stgit@baageli.muru.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53878 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917Ab0CKXrV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 18:47:21 -0500
In-Reply-To: <20100311234404.4500.82861.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Kevin Hilman <khilman@deeprootsystems.com>

When building for multi-omap, and OMAP4 is enabled, CONFIG_ARCH_OMAP4
will be true and prevent included code from building/running for
OMAP2/3 as well.

This problem exists in io.c where some hwmod/PM/SDRC init code is
prevented from running even on OMAP2/3 when OMAP4 is included in a
multi-OMAP build.

A quick glance suggests that this #ifndef is no longer needed in most
of the cases.  In the remaining cases, the function is wrapped with
"if (cpu_is_omap24xx() || cpu_is_omap34xx())" which will be optimized
out for OMAP4-only builds.

Note that this is only a short-term fix.  Longer-term, OMAP4
needs to create init functions for SDRC and hwmod late-init.

Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/io.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index ae89d55..87f676a 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -309,7 +309,6 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 {
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_autodeps);
-#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is ready */
 	if (cpu_is_omap242x())
 		omap2420_hwmod_init();
 	else if (cpu_is_omap243x())
@@ -319,7 +318,6 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 	omap2_mux_init();
 	/* The OPP tables have to be registered before a clk init */
 	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
-#endif
 
 	if (cpu_is_omap2420())
 		omap2420_clk_init();
@@ -333,11 +331,12 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 		pr_err("Could not init clock framework - unknown CPU\n");
 
 	omap_serial_early_init();
-#ifndef CONFIG_ARCH_OMAP4
-	omap_hwmod_late_init();
+	if (cpu_is_omap24xx() || cpu_is_omap34xx())   /* FIXME: OMAP4 */
+		omap_hwmod_late_init();
 	omap_pm_if_init();
-	omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
-	_omap2_init_reprogram_sdrc();
-#endif
+	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+		omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
+		_omap2_init_reprogram_sdrc();
+	}
 	gpmc_init();
 }

