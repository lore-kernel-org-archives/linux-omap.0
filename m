From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH/RFT] OMAP4: fix temporary hacks that break multi-omap PM
Date: Mon,  8 Mar 2010 10:26:40 -0800
Message-ID: <1268072800-11696-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:61794 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458Ab0CHS0v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 13:26:51 -0500
Received: by qw-out-2122.google.com with SMTP id 5so1185317qwd.37
        for <linux-omap@vger.kernel.org>; Mon, 08 Mar 2010 10:26:50 -0800 (PST)
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

Needs testing on OMAP4 since still no OMAP4 here

 arch/arm/mach-omap2/io.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 81312b4..5d06b2a 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -339,11 +339,10 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
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

