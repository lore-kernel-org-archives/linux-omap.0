From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 13/14] OMAP2: Devkit8000: Remove unused omap_board_config
Date: Tue, 18 May 2010 14:05:34 +0200
Message-ID: <1274184335-29322-14-git-send-email-weber@corscience.de>
References: <1274184335-29322-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:53599 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757387Ab0ERMGE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:06:04 -0400
In-Reply-To: <1274184335-29322-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Thomas Weber <weber@corscience.de>

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index de7c28a..81000e4 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -126,8 +126,6 @@ static struct omap2_hsmmc_info mmc[] = {
 	},
 	{}	/* Terminator */
 };
-static struct omap_board_config_kernel devkit8000_config[] __initdata = {
-};
 
 static int devkit8000_panel_enable_lcd(struct omap_dss_device *dssdev)
 {
@@ -461,8 +459,6 @@ static struct platform_device keys_gpio = {
 
 static void __init devkit8000_init_irq(void)
 {
-	omap_board_config = devkit8000_config;
-	omap_board_config_size = ARRAY_SIZE(devkit8000_config);
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
@@ -794,8 +790,6 @@ static void __init devkit8000_init(void)
 	devkit8000_i2c_init();
 	platform_add_devices(devkit8000_devices,
 			ARRAY_SIZE(devkit8000_devices));
-	omap_board_config = devkit8000_config;
-	omap_board_config_size = ARRAY_SIZE(devkit8000_config);
 
 	spi_register_board_info(devkit8000_spi_board_info,
 	ARRAY_SIZE(devkit8000_spi_board_info));
-- 
1.6.4.4

