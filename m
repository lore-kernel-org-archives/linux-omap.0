From: Yanick Saugy <yanick.saugy@heig-vd.ch>
Subject: [PATCH] OMAP: ZOOM2: Change GPIO to enable LCD NEC NL8048HL11-01B
 on OMAP34x-II MDP
Date: Tue, 21 Sep 2010 14:21:30 +0200
Message-ID: <1285071690.1783.34.camel@A05BPC17>
References: <1284381807.1801.38.camel@A05BPC17>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.infomaniak.ch ([84.16.68.89]:45388 "EHLO
	smtp1.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514Ab0IUMVo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 08:21:44 -0400
In-Reply-To: <1284381807.1801.38.camel@A05BPC17>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, Rajkumar N <rajkumar.nagarajan@ti.com>

The PIN which controls LCD's reset signal (VGA_nRESET/h_GPIO_96) was not
configured as a GPIO. We had to modify the OMAP MUX, and select this PIN
(CAM_XCLKA) as an output GPIO (OMAP_MUX_MODE4). (kernel 2.6.35)

Be aware of changing this PIN will probably disable the camera, because
it was previously configured as a camera clock.


Signed-off-by: Yanick Saugy <yanick.saugy@heig-vd.ch>

--- a/arch/arm/mach-omap2/board-zoom2.c 2010-09-15 15:27:05.148399721 +0200
+++ b/arch/arm/mach-omap2/board-zoom2.c 2010-09-15 14:46:09.792900019 +0200
@@ -71,6 +71,7 @@ static struct twl4030_platform_data zoom
 
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
+   OMAP3_MUX(CAM_XCLKA, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
    { .reg_offset = OMAP_MUX_TERMINATOR },
 };
 #else
@@ -82,6 +83,7 @@ static void __init omap_zoom2_init(void)
    omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
    zoom_peripherals_init();
    zoom_debugboard_init();
+    zoom_display_init(OMAP_DSS_VENC_TYPE_COMPOSITE);
 }
 
 static void __init omap_zoom2_map_io(void)



