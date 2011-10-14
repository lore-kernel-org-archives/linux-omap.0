From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: [PATCH 1/1] ARM: OMAP: Add conditional compilation for board specific init functions
Date: Sat, 15 Oct 2011 00:00:18 +0200
Message-ID: <1318629618-5313-1-git-send-email-martinez.javier@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59112 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051Ab1JNWAl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Oct 2011 18:00:41 -0400
Received: by wyg36 with SMTP id 36so530707wyg.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Oct 2011 15:00:39 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Javier Martinez Canillas <martinez.javier@gmail.com>

The definition for board specific initialization functions:
- omap2_set_globals_xxxx
- omapxxxx_powerdomains_init
- omapxxxx_clockdomains_init
- omapxxxx_hwmod_init

is conditionally compiled. So we also have to conditionally compile
the call to these functions or the linker will find undefined symbols.

Signed-off-by: Javier Martinez Canillas <martinez.javier@gmail.com>
---
 arch/arm/mach-omap2/io.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index aa96538..d2d045b 100644
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
@@ -382,6 +385,7 @@ void __init omap2430_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap2430_clk_init();
 }
+#endif
 
 /*
  * Currently only board-omap3beagle.c should call this because of the
@@ -431,6 +435,7 @@ void __init ti816x_init_early(void)
 	omap3xxx_clk_init();
 }
 
+#ifdef CONFIG_ARCH_OMAP4
 void __init omap4430_init_early(void)
 {
 	omap2_set_globals_443x();
@@ -442,6 +447,7 @@ void __init omap4430_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap4xxx_clk_init();
 }
+#endif
 
 void __init omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1)
-- 
1.7.4.1

