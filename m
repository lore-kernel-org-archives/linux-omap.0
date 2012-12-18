From: Ricardo Neri <rneri@dextratech.com>
Subject: [PATCH v3 1/5] ARM: OMAP4+: HDMI: Rename platform devices for ASoC drivers
Date: Mon, 17 Dec 2012 19:30:39 -0600
Message-ID: <1355794243-32345-2-git-send-email-rneri@dextratech.com>
References: <1355794243-32345-1-git-send-email-rneri@dextratech.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from spamfilter.dextratech.com ([187.141.251.67]:50649 "EHLO
	mail.dextratech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002Ab2LRBhu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Dec 2012 20:37:50 -0500
In-Reply-To: <1355794243-32345-1-git-send-email-rneri@dextratech.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, tony@atomide.com
Cc: peter.ujfalusi@ti.com, dzuniga@dextratech.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <rneri@dextratech.com>

Assign more logical and meaningful names to the platform devices used
by ASoC OMAP HDMI drivers.

The previous omap-hdmi-audio device is renamed as omap-hdmi-audio-card
This is to better illustrate the fact that it describes the whole HDMI
audio in a given board.

The previous omap-hdmi-audio-dai is renamed as omap-hdmi-audio. The -dai
part is removed to not have references to ASoC concepts in the OMAPDSS
HDMI driver. Also, as it will be used by the ASoC HDMI CPU DAI driver,
the name refers only to OMAP HDMI audio functionality, irrespective of the
board.

The names of the ASoC drivers are also updated accordingly.

Signed-off-by: Ricardo Neri <rneri@dextratech.com>
---
 arch/arm/mach-omap2/devices.c   |    4 ++--
 sound/soc/omap/omap-hdmi-card.c |    4 ++--
 sound/soc/omap/omap-hdmi.c      |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index cba60e0..66518b2 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -356,7 +356,7 @@ static inline void omap_init_dmic(void) {}
 		defined(CONFIG_SND_OMAP_SOC_OMAP_HDMI_MODULE)
 
 static struct platform_device omap_hdmi_audio = {
-	.name	= "omap-hdmi-audio",
+	.name	= "omap-hdmi-audio-card",
 	.id	= -1,
 };
 
@@ -371,7 +371,7 @@ static void __init omap_init_hdmi_audio(void)
 		return;
 	}
 
-	pdev = omap_device_build("omap-hdmi-audio-dai",
+	pdev = omap_device_build("omap-hdmi-audio",
 		-1, oh, NULL, 0, NULL, 0, 0);
 	WARN(IS_ERR(pdev),
 	     "Can't build omap_device for omap-hdmi-audio-dai.\n");
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
index f59c69f..db08501 100644
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
1.7.10.4

