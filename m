From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/6] OMAP: RX51: Remove unused old omapfb stuff
Date: Mon,  9 May 2011 10:36:02 +0300
Message-ID: <1304926567-26814-2-git-send-email-tomi.valkeinen@ti.com>
References: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:36860 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752000Ab1EIHgX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 May 2011 03:36:23 -0400
Received: by eye13 with SMTP id 13so1788652eye.31
        for <linux-omap@vger.kernel.org>; Mon, 09 May 2011 00:36:20 -0700 (PDT)
In-Reply-To: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

RX51 uses the new DSS2 display driver, but the board file still
contained some code for the old omapfb driver. The old code can be
removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-rx51.c |   25 -------------------------
 1 files changed, 0 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index e964895..116e19b 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -75,29 +75,6 @@ static struct cpuidle_params rx51_cpuidle_params[] = {
 	{1, 7505, 15274, 484329},
 };
 
-static struct omap_lcd_config rx51_lcd_config = {
-	.ctrl_name	= "internal",
-};
-
-static struct omap_fbmem_config rx51_fbmem0_config = {
-	.size = 752 * 1024,
-};
-
-static struct omap_fbmem_config rx51_fbmem1_config = {
-	.size = 752 * 1024,
-};
-
-static struct omap_fbmem_config rx51_fbmem2_config = {
-	.size = 752 * 1024,
-};
-
-static struct omap_board_config_kernel rx51_config[] = {
-	{ OMAP_TAG_FBMEM,	&rx51_fbmem0_config },
-	{ OMAP_TAG_FBMEM,	&rx51_fbmem1_config },
-	{ OMAP_TAG_FBMEM,	&rx51_fbmem2_config },
-	{ OMAP_TAG_LCD,		&rx51_lcd_config },
-};
-
 static void __init rx51_init_early(void)
 {
 	struct omap_sdrc_params *sdrc_params;
@@ -124,8 +101,6 @@ static struct omap_musb_board_data musb_board_data = {
 static void __init rx51_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
-	omap_board_config = rx51_config;
-	omap_board_config_size = ARRAY_SIZE(rx51_config);
 	omap3_pm_init_cpuidle(rx51_cpuidle_params);
 	omap_serial_init();
 	usb_musb_init(&musb_board_data);
-- 
1.7.4.1

