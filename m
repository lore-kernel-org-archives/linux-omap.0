From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 2/2] ARM: OMAP4+: HDMI: Rearrange platform devices for ASoC drivers
Date: Thu, 15 Nov 2012 19:36:59 -0600
Message-ID: <1353029819-21809-3-git-send-email-ricardo.neri@ti.com>
References: <1353029819-21809-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51893 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212Ab2KPBiX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 20:38:23 -0500
In-Reply-To: <1353029819-21809-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, tomi.valkeinen@ti.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

This relocates and renames the platform devices for ASoC HDMI drivers
to give them a more logical structure.

The previous omap-hdmi-audio device is renamed as omap-hdmi-audio-card
and is relocated to the SDP4430 and Pandaboard board files. This is to
better illustrate the fact that it describes the whole HDMI audio
functionality on such boards, including the companion chip.

The previous omap-hdmi-audio-dai is renamed as omap-hdmi-audio. The -dai
part is removed to not have references to ASoC concepts in the OMAPDSS
HDMI driver. Also, as it will be used by the ASoC HDMI CPU DAI driver,
the name refers only to OMAP HDMI audio functionality, irrespective of the
board.

The names of the ASoC drivers are also updated accordingly.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |    6 ++++++
 arch/arm/mach-omap2/board-omap4panda.c |    6 ++++++
 arch/arm/mach-omap2/devices.c          |   17 -----------------
 drivers/video/omap2/dss/hdmi.c         |    2 +-
 sound/soc/omap/omap-hdmi-card.c        |    4 ++--
 sound/soc/omap/omap-hdmi.c             |    2 +-
 6 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 3669c12..97bdff3 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -388,6 +388,11 @@ static struct platform_device sdp4430_hdmi_audio_codec = {
 	.id	= -1,
 };
 
+static struct platform_device sdp4430_hdmi_audio_card = {
+	.name	= "omap-hdmi-audio-card",
+	.id	= -1,
+};
+
 static struct omap_abe_twl6040_data sdp4430_abe_audio_data = {
 	.card_name = "SDP4430",
 	.has_hs		= ABE_TWL6040_LEFT | ABE_TWL6040_RIGHT,
@@ -423,6 +428,7 @@ static struct platform_device *sdp4430_devices[] __initdata = {
 	&sdp4430_dmic_codec,
 	&sdp4430_abe_audio,
 	&sdp4430_hdmi_audio_codec,
+	&sdp4430_hdmi_audio_card,
 };
 
 static struct omap_musb_board_data musb_board_data = {
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index bfcd397..e03eae1 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -131,6 +131,11 @@ static struct platform_device panda_hdmi_audio_codec = {
 	.id	= -1,
 };
 
+static struct platform_device panda_hdmi_audio_card = {
+	.name	= "omap-hdmi-audio-card",
+	.id	= -1,
+};
+
 static struct platform_device btwilink_device = {
 	.name	= "btwilink",
 	.id	= -1,
@@ -141,6 +146,7 @@ static struct platform_device *panda_devices[] __initdata = {
 	&wl1271_device,
 	&panda_abe_audio,
 	&panda_hdmi_audio_codec,
+	&panda_hdmi_audio_card,
 	&btwilink_device,
 };
 
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 417a87d..bea0b40 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -352,22 +352,6 @@ static void __init omap_init_dmic(void)
 static inline void omap_init_dmic(void) {}
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
-	platform_device_register(&omap_hdmi_audio);
-}
-#else
-static inline void omap_init_hdmi_audio(void) {}
-#endif
-
 #if defined(CONFIG_SPI_OMAP24XX) || defined(CONFIG_SPI_OMAP24XX_MODULE)
 
 #include <linux/platform_data/spi-omap2-mcspi.h>
@@ -613,7 +597,6 @@ static int __init omap2_init_devices(void)
 	 */
 	omap_init_audio();
 	omap_init_camera();
-	omap_init_hdmi_audio();
 	omap_init_mbox();
 	/* If dtb is there, the devices will be created dynamically */
 	if (!of_have_populated_dt()) {
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 6d48026..c5743e1 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -860,7 +860,7 @@ static int hdmi_probe_audio(struct platform_device *pdev)
 	aud_res[1].start = res->start;
 
 	/* create platform device for HDMI audio driver */
-	aud_pdev = platform_device_register_simple("omap-hdmi-audio-dai",
+	aud_pdev = platform_device_register_simple("omap-hdmi-audio",
 						   pdev->id, aud_res,
 						   ARRAY_SIZE(aud_res));
 	if (IS_ERR(aud_pdev)) {
diff --git a/sound/soc/omap/omap-hdmi-card.c b/sound/soc/omap/omap-hdmi-card.c
index eaa2ea0..07b9959 100644
--- a/sound/soc/omap/omap-hdmi-card.c
+++ b/sound/soc/omap/omap-hdmi-card.c
@@ -27,12 +27,12 @@
 #include <asm/mach-types.h>
 #include <video/omapdss.h>
 
-#define DRV_NAME "omap-hdmi-audio"
+#define DRV_NAME "omap-hdmi-audio-card"
 
 static struct snd_soc_dai_link omap_hdmi_dai = {
 	.name = "HDMI",
 	.stream_name = "HDMI",
-	.cpu_dai_name = "omap-hdmi-audio-dai",
+	.cpu_dai_name = "omap-hdmi-audio",
 	.platform_name = "omap-pcm-audio",
 	.codec_name = "hdmi-audio-codec",
 	.codec_dai_name = "omap-hdmi-hifi",
diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index 8034cf7..33418fc 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -37,7 +37,7 @@
 #include "omap-pcm.h"
 #include "omap-hdmi.h"
 
-#define DRV_NAME "omap-hdmi-audio-dai"
+#define DRV_NAME "omap-hdmi-audio"
 
 struct hdmi_priv {
 	struct omap_pcm_dma_data dma_params;
-- 
1.7.5.4

