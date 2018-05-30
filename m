From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] fb_omap: add gpiolib dependency
Date: Wed, 30 May 2018 23:49:22 +0200
Message-ID: <20180530214938.1073749-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Building the omap sub-drivers when CONFIG_GPIOLIB is disabled causes
lots of build failures, either from using gpiolib interfaces, or from
including the wrong headers:

drivers/video/fbdev/omap2/omapfb/displays/encoder-opa362.c: In function 'opa362_enable':
drivers/video/fbdev/omap2/omapfb/displays/encoder-opa362.c:101:3: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c: In function 'panel_dpi_enable':
drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c:86:2: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c: In function 'panel_dpi_probe_pdata':
drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c:189:23: error: implicit declaration of function 'gpio_to_desc'; did you mean 'irq_to_desc'? [-Werror=implicit-function-declaration]
drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c: In function 'panel_dpi_probe_of':
drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c:210:9: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_gpio_request_one'? [-Werror=implicit-function-declaration]
drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c: In function 'sharp_ls_enable':
drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c:120:3: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c: In function 'lb035q02_enable':
drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c:170:3: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c: In function 'hdmi_probe_of':
drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c:584:2: error: implicit declaration of function 'of_node_put'; did you mean 'node_set'? [-Werror=implicit-function-declaration]
drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c: In function 'hdmi_probe_of':
drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c:554:2: error: implicit declaration of function 'of_node_put'; did you mean 'node_set'? [-Werror=implicit-function-declaration]

Rather than fixing up each one individually, this just marks all of it
as depending on GPIOLIB.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/omap2/omapfb/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/omap2/omapfb/Kconfig b/drivers/video/fbdev/omap2/omapfb/Kconfig
index e6226aeed17e..3bf154e676d1 100644
--- a/drivers/video/fbdev/omap2/omapfb/Kconfig
+++ b/drivers/video/fbdev/omap2/omapfb/Kconfig
@@ -5,6 +5,7 @@ menuconfig FB_OMAP2
         tristate "OMAP2+ frame buffer support"
         depends on FB
         depends on DRM_OMAP = n
+	depends on GPIOLIB
 
         select FB_OMAP2_DSS
 	select OMAP2_VRFB if ARCH_OMAP2 || ARCH_OMAP3
-- 
2.9.0
