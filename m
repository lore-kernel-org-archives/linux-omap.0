From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 17/19] ARM: omap2plus_defconfig: Build DSS HDMI support for OMAP4 in kernel
Date: Mon, 12 May 2014 12:12:28 +0300
Message-ID: <f00063aa61ac2f7570dbd7e4cb922d742adfe942.1399884780.git.jsarha@ti.com>
References: <cover.1399884780.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45070 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754209AbaELJNF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 May 2014 05:13:05 -0400
In-Reply-To: <cover.1399884780.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

This patch is here only as an example on how to enable HDMI video for
Panda board. In addition to this patch omapdss.def_disp=hdmi parameter
should be added to kernel command line in order to enable HDMI video.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index a966795..35c42aa 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -187,14 +187,14 @@ CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_TILEBLITTING=y
-CONFIG_OMAP2_DSS=m
+CONFIG_OMAP2_DSS=y
 CONFIG_OMAP2_DSS_SDI=y
 CONFIG_OMAP2_DSS_DSI=y
-CONFIG_FB_OMAP2=m
+CONFIG_FB_OMAP2=y
 CONFIG_DISPLAY_ENCODER_TFP410=m
 CONFIG_DISPLAY_ENCODER_TPD12S015=m
-CONFIG_DISPLAY_CONNECTOR_DVI=m
-CONFIG_DISPLAY_CONNECTOR_HDMI=m
+CONFIG_DISPLAY_CONNECTOR_DVI=y
+CONFIG_DISPLAY_CONNECTOR_HDMI=y
 CONFIG_DISPLAY_PANEL_DPI=m
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
-- 
1.7.9.5

