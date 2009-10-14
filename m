From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] ARM: OMAP4: Allow omap_serial_early_init() for OMAP4430 board
Date: Wed, 14 Oct 2009 11:44:21 +0530
Message-ID: <1255500862-29847-2-git-send-email-santosh.shilimkar@ti.com>
References: <1255500862-29847-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39338 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897AbZJNGPH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Oct 2009 02:15:07 -0400
In-Reply-To: <1255500862-29847-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch enables omap_serial_early_init() function for OMAP4430
SDP. Without this the bootup would throw oops in omap_serial_init().

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-By: Tony Lindgren <tony@atomide.com>
Reviewed-By: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    4 ++--
 arch/arm/mach-omap2/io.c            |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index eb37c40..609a5a4 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -58,6 +58,8 @@ static void __init gic_init_irq(void)
 
 static void __init omap_4430sdp_init_irq(void)
 {
+	omap_board_config = sdp4430_config;
+	omap_board_config_size = ARRAY_SIZE(sdp4430_config);
 	omap2_init_common_hw(NULL, NULL);
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(1);
@@ -70,8 +72,6 @@ static void __init omap_4430sdp_init_irq(void)
 static void __init omap_4430sdp_init(void)
 {
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
-	omap_board_config = sdp4430_config;
-	omap_board_config_size = ARRAY_SIZE(sdp4430_config);
 	omap_serial_init();
 }
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index e3a3bad..56be87d 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -302,7 +302,9 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 	omap2_clk_init();
+#endif
 	omap_serial_early_init();
+#ifndef CONFIG_ARCH_OMAP4
 	omap_hwmod_late_init();
 	omap_pm_if_init();
 	omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
-- 
1.5.4.7

