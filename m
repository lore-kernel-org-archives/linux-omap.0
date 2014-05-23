From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 03/13] ARM: OMAP2+: Remove non working OMAP HDMI audio initialization
Date: Fri, 23 May 2014 22:07:52 +0300
Message-ID: <fd2186b6813e6b2daef1d54dca8ec1d59692ced8.1400871999.git.jsarha@ti.com>
References: <cover.1400871999.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1400871999.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: peter.ujfalusi-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This code is not working currently and it can be removed. There is a
conflict in sharing resources with the actual HDMI driver and with
the ASoC HDMI audio DAI driver.

Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/devices.c |   28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index e58609b..4bab682 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -330,33 +330,6 @@ static void omap_init_audio(void)
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
@@ -492,7 +465,6 @@ static int __init omap2_init_devices(void)
 	 */
 	omap_init_audio();
 	omap_init_camera();
-	omap_init_hdmi_audio();
 	omap_init_mbox();
 	/* If dtb is there, the devices will be created dynamically */
 	if (!of_have_populated_dt()) {
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
