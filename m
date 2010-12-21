From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] omap: rx51: Remove tvout code that plays with gpio 40
Date: Tue, 21 Dec 2010 19:46:01 +0200
Message-ID: <1292953561-22979-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f45.google.com ([209.85.214.45]:35477 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab0LURqW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 12:46:22 -0500
Received: by bwz16 with SMTP id 16so4845789bwz.4
        for <linux-omap@vger.kernel.org>; Tue, 21 Dec 2010 09:46:20 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Srikar <ext-srikar.1.bhavanarayana@nokia.com>

Commit 60d24ee "Added video data to support tvout on rx51" added code that
tries to assign gpio 40 as OMAP DSS reset_gpio for tvout. This is wrong
since this gpio has nothing to do with OMAP DSS but it is used to control
one switch that selects is the audio jack connected to tvout or audio
circuitry.

This switch is already supported by the RX51 ASoC driver so there is no need
to control it elsewhere. Switch is contolled with ALSA control
'Jack Function' and tvout can be selected with following example:

	amixer -D hw:0 set 'Jack Function' 'TV-OUT'

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Srikar <ext-srikar.1.bhavanarayana@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-video.c |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
index 9919581..acd6700 100644
--- a/arch/arm/mach-omap2/board-rx51-video.c
+++ b/arch/arm/mach-omap2/board-rx51-video.c
@@ -24,9 +24,6 @@
 #include "mux.h"
 
 #define RX51_LCD_RESET_GPIO	90
-/* REVISIT  to verify with rx51.c at sound/soc/omap */
-#define RX51_TVOUT_SEL_GPIO	40
-
 
 #if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
 
@@ -41,17 +38,6 @@ static void rx51_lcd_disable(struct omap_dss_device *dssdev)
 	gpio_set_value(dssdev->reset_gpio, 0);
 }
 
-static int rx51_tvout_enable(struct omap_dss_device *dssdev)
-{
-	gpio_set_value(dssdev->reset_gpio, 1);
-	return 0;
-}
-
-static void rx51_tvout_disable(struct omap_dss_device *dssdev)
-{
-	gpio_set_value(dssdev->reset_gpio, 0);
-}
-
 static struct omap_dss_device rx51_lcd_device = {
 	.name			= "lcd",
 	.driver_name		= "panel-acx565akm",
@@ -67,9 +53,6 @@ static struct omap_dss_device  rx51_tv_device = {
 	.type			= OMAP_DISPLAY_TYPE_VENC,
 	.driver_name		= "venc",
 	.phy.venc.type	        = OMAP_DSS_VENC_TYPE_COMPOSITE,
-	.reset_gpio	        = RX51_TVOUT_SEL_GPIO,
-	.platform_enable        = rx51_tvout_enable,
-	.platform_disable       = rx51_tvout_disable,
 };
 
 static struct omap_dss_device *rx51_dss_devices[] = {
@@ -112,9 +95,6 @@ static int __init rx51_video_init(void)
 
 	gpio_direction_output(RX51_LCD_RESET_GPIO, 1);
 
-	/* REVISIT  to verify with rx51.c at sound/soc/omap */
-	gpio_direction_output(RX51_TVOUT_SEL_GPIO, 1);
-
 	platform_add_devices(rx51_video_devices,
 				ARRAY_SIZE(rx51_video_devices));
 	return 0;
-- 
1.7.2.3

