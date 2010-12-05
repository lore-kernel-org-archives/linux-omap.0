From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 2/2] OMAP1: Amstrad Delta: reserve memory for camera
Date: Sun, 5 Dec 2010 19:34:22 +0100
Message-ID: <201012051934.24512.jkrzyszt@tis.icnet.pl>
References: <201012051929.07220.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:53941 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755545Ab0LESew (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 5 Dec 2010 13:34:52 -0500
In-Reply-To: <201012051929.07220.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Patch 1/2 from this set provides a possibility to reserve a block of memory 
for use as the OMAP1 camera dedicated dma coherent memory. Use this 
functionality to avoid the camera driver switching form videobuf_contig mode 
to less efficient videobuf_sg mode in case of dma coherent memory allocation 
failure after system memory gets fragmented.

Created and tested against linux-2.6.27-rc4 on top of patch 1/2.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 arch/arm/mach-omap1/board-ams-delta.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- linux-2.6.37-rc4/arch/arm/mach-omap1/board-ams-delta.c.orig	2010-12-04 18:05:25.000000000 +0100
+++ linux-2.6.37-rc4/arch/arm/mach-omap1/board-ams-delta.c	2010-12-04 22:19:39.000000000 +0100
@@ -262,6 +262,16 @@ static struct omap1_cam_platform_data am
 	.lclk_khz_max	= 1334,		/* results in 5fps CIF, 10fps QCIF */
 };
 
+void __init amsdelta_reserve(void)
+{
+#if defined(CONFIG_VIDEO_OMAP1) || defined(CONFIG_VIDEO_OMAP1_MODULE)
+	omap1_camera_reserve(PAGE_SIZE << get_order(352 * 288 * 2 *
+			OMAP1_CAMERA_MIN_BUF_COUNT(OMAP1_CAM_DMA_CONTIG)));
+#endif
+
+	omap_reserve();
+}
+
 static struct platform_device *ams_delta_devices[] __initdata = {
 	&ams_delta_kp_device,
 	&ams_delta_lcd_device,
@@ -366,7 +376,7 @@ MACHINE_START(AMS_DELTA, "Amstrad E3 (De
 	/* Maintainer: Jonathan McDowell <noodles@earth.li> */
 	.boot_params	= 0x10000100,
 	.map_io		= ams_delta_map_io,
-	.reserve	= omap_reserve,
+	.reserve	= amsdelta_reserve,
 	.init_irq	= ams_delta_init_irq,
 	.init_machine	= ams_delta_init,
 	.timer		= &omap_timer,
