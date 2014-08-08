From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v3 01/14] ARM: OMAP2+: Remove non working OMAP HDMI audio initialization
Date: Fri, 8 Aug 2014 16:23:42 +0300
Message-ID: <bfd2f4c197df151a80b489e174bf5c07a8298983.1407503813.git.jsarha@ti.com>
References: <cover.1407503813.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42269 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755593AbaHHNYR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Aug 2014 09:24:17 -0400
In-Reply-To: <cover.1407503813.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

This code is not working currently and it can be removed. There is a
conflict in sharing resources with the actual HDMI driver and with
the ASoC HDMI audio DAI driver.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/mach-omap2/devices.c |   28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 592ba0a..b6f8f34 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -297,33 +297,6 @@ static void omap_init_audio(void)
 static inline void omap_init_audio(void) {}
 #endif
 
-#if defined(CONFIG_SND_OMAP_SOC_OMAP_HDMI) || \
-		defined(CONFIG_SND_OMAP_SOC_OMAP_HDMI_MODULE)
-
-static struct platform_device omap_hdmi_audio = {
-	.name	= "omap-hdmi-audio",
-	.id	= -1,
-};
-
-static void __init omap_init_hdmi_audio(void)
-{
-	struct omap_hwmod *oh;
-	struct platform_device *pdev;
-
-	oh = omap_hwmod_lookup("dss_hdmi");
-	if (!oh)
-		return;
-
-	pdev = omap_device_build("omap-hdmi-audio-dai", -1, oh, NULL, 0);
-	WARN(IS_ERR(pdev),
-	     "Can't build omap_device for omap-hdmi-audio-dai.\n");
-
-	platform_device_register(&omap_hdmi_audio);
-}
-#else
-static inline void omap_init_hdmi_audio(void) {}
-#endif
-
 #if defined(CONFIG_SPI_OMAP24XX) || defined(CONFIG_SPI_OMAP24XX_MODULE)
 
 #include <linux/platform_data/spi-omap2-mcspi.h>
@@ -459,7 +432,6 @@ static int __init omap2_init_devices(void)
 	 */
 	omap_init_audio();
 	omap_init_camera();
-	omap_init_hdmi_audio();
 	omap_init_mbox();
 	/* If dtb is there, the devices will be created dynamically */
 	if (!of_have_populated_dt()) {
-- 
1.7.9.5

