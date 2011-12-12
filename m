From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH] ARM: OMAP: McSPI: Remove unused flag from struct omap2_mcspi_device_config
Date: Mon, 12 Dec 2011 11:15:17 +0200
Message-ID: <1323681317-8447-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [213.157.87.50] ([213.157.87.50]:57715 "EHLO bitmer.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750748Ab1LLJRX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 04:17:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Jarkko Nikula <jarkko.nikula@bitmer.com>

Flag single_channel in struct omap2_mcspi_device_config is not used
by drivers/spi/spi-omap2-mcspi.c so we may remove it from include/plat/mcspi.h
and affected board files.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 arch/arm/mach-omap2/board-cm-t35.c           |    1 -
 arch/arm/mach-omap2/board-n8x0.c             |    1 -
 arch/arm/mach-omap2/board-rx51-peripherals.c |    3 ---
 arch/arm/mach-omap2/board-zoom-display.c     |    1 -
 arch/arm/mach-omap2/common-board-devices.c   |    1 -
 arch/arm/plat-omap/include/plat/mcspi.h      |    3 ---
 6 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index b38cd7b..4cc2f04 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -280,7 +280,6 @@ static struct omap_dss_board_info cm_t35_dss_data = {
 
 static struct omap2_mcspi_device_config tdo24m_mcspi_config = {
 	.turbo_mode	= 0,
-	.single_channel	= 1,	/* 0: slave, 1: master */
 };
 
 static struct tdo24m_platform_data tdo24m_config = {
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 05107d8..74065e6 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -140,7 +140,6 @@ static void __init n8x0_usb_init(void) {}
 
 static struct omap2_mcspi_device_config p54spi_mcspi_config = {
 	.turbo_mode	= 0,
-	.single_channel = 1,
 };
 
 static struct spi_board_info n800_spi_board_info[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index e9eff00..c01c175 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -138,17 +138,14 @@ static struct lp5523_platform_data rx51_lp5523_platform_data = {
 
 static struct omap2_mcspi_device_config wl1251_mcspi_config = {
 	.turbo_mode	= 0,
-	.single_channel	= 1,
 };
 
 static struct omap2_mcspi_device_config mipid_mcspi_config = {
 	.turbo_mode	= 0,
-	.single_channel	= 1,
 };
 
 static struct omap2_mcspi_device_config tsc2005_mcspi_config = {
 	.turbo_mode	= 0,
-	.single_channel	= 1,
 };
 
 static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
index d4683ba..2818290 100644
--- a/arch/arm/mach-omap2/board-zoom-display.c
+++ b/arch/arm/mach-omap2/board-zoom-display.c
@@ -117,7 +117,6 @@ static struct omap_dss_board_info zoom_dss_data = {
 
 static struct omap2_mcspi_device_config dss_lcd_mcspi_config = {
 	.turbo_mode		= 1,
-	.single_channel	= 1,  /* 0: slave, 1: master */
 };
 
 static struct spi_board_info nec_8048_spi_board_info[] __initdata = {
diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
index bcb0c58..2d1d775 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -33,7 +33,6 @@
 	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
 static struct omap2_mcspi_device_config ads7846_mcspi_config = {
 	.turbo_mode	= 0,
-	.single_channel	= 1,	/* 0: slave, 1: master */
 };
 
 static struct ads7846_platform_data ads7846_config = {
diff --git a/arch/arm/plat-omap/include/plat/mcspi.h b/arch/arm/plat-omap/include/plat/mcspi.h
index 3d51b18..a357eb2 100644
--- a/arch/arm/plat-omap/include/plat/mcspi.h
+++ b/arch/arm/plat-omap/include/plat/mcspi.h
@@ -18,9 +18,6 @@ struct omap2_mcspi_dev_attr {
 
 struct omap2_mcspi_device_config {
 	unsigned turbo_mode:1;
-
-	/* Do we want one channel enabled at the same time? */
-	unsigned single_channel:1;
 };
 
 #endif
-- 
1.7.7.3

