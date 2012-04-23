From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH] OMAP4: panda: add statics to remove warnings
Date: Mon, 23 Apr 2012 10:39:40 +0300
Message-ID: <1335166780-5899-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:54316 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751769Ab2DWHj4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 03:39:56 -0400
Received: by lahe6 with SMTP id e6so10264489lah.32
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 00:39:54 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add statics to board-omap4-panda.c's internal functions and data
structures to remove warnings.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 1b782ba..8216e5f 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -231,7 +231,7 @@ static struct platform_device omap_vwlan_device = {
 	},
 };
 
-struct wl12xx_platform_data omap_panda_wlan_data  __initdata = {
+static struct wl12xx_platform_data omap_panda_wlan_data  __initdata = {
 	/* PANDA ref clock is 38.4 MHz */
 	.board_ref_clock = 2,
 };
@@ -438,7 +438,7 @@ static struct panel_dvi_platform_data omap4_dvi_panel = {
 	.i2c_bus_num = 3,
 };
 
-struct omap_dss_device omap4_panda_dvi_device = {
+static struct omap_dss_device omap4_panda_dvi_device = {
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.name			= "dvi",
 	.driver_name		= "dvi",
@@ -448,7 +448,7 @@ struct omap_dss_device omap4_panda_dvi_device = {
 	.channel		= OMAP_DSS_CHANNEL_LCD2,
 };
 
-int __init omap4_panda_dvi_init(void)
+static int __init omap4_panda_dvi_init(void)
 {
 	int r;
 
@@ -509,7 +509,7 @@ static struct omap_dss_board_info omap4_panda_dss_data = {
 	.default_device	= &omap4_panda_dvi_device,
 };
 
-void __init omap4_panda_display_init(void)
+static void __init omap4_panda_display_init(void)
 {
 	int r;
 
-- 
1.7.4.1

