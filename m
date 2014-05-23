From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 09/13] ASoC: omap-hdmi-card: Changes for registeing the driver from OMAPDSS
Date: Fri, 23 May 2014 22:07:58 +0300
Message-ID: <64844e293dd9dc918d1b26f5505fc52466f40203.1400871999.git.jsarha@ti.com>
References: <cover.1400871999.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46928 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbaEWTIg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 May 2014 15:08:36 -0400
In-Reply-To: <cover.1400871999.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

The old OMAP HDMI audio registering from arch/arm/mach-omap2/devices.c
was broken. The new approach is to register the drivers from OMAPDSS HDMI
driver. The commit does the necessary changes for this approach.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/omap/omap-hdmi-card.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/omap-hdmi-card.c b/sound/soc/omap/omap-hdmi-card.c
index f649fe8..56c0055 100644
--- a/sound/soc/omap/omap-hdmi-card.c
+++ b/sound/soc/omap/omap-hdmi-card.c
@@ -26,15 +26,13 @@
 #include <sound/soc.h>
 #include <asm/mach-types.h>
 #include <video/omapdss.h>
+#include <sound/omap-hdmi-card-pdata.h>
 
 #define DRV_NAME "omap-hdmi-audio"
 
 static struct snd_soc_dai_link omap_hdmi_dai = {
 	.name = "HDMI",
 	.stream_name = "HDMI",
-	.cpu_dai_name = "omap-hdmi-audio-dai",
-	.platform_name = "omap-hdmi-audio-dai",
-	.codec_name = "hdmi-audio-codec",
 	.codec_dai_name = "hdmi-hifi",
 };
 
@@ -47,14 +45,28 @@ static struct snd_soc_card snd_soc_omap_hdmi = {
 
 static int omap_hdmi_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct asoc_omap_hdmi_card_pdata *pdata = dev->platform_data;
 	struct snd_soc_card *card = &snd_soc_omap_hdmi;
 	int ret;
 
+	if (!pdata) {
+		dev_err(dev, "No platform data, bailing out\n");
+		return -ENODEV;
+	}
+
 	card->dev = &pdev->dev;
 
+	omap_hdmi_dai.cpu_dai_name =
+		devm_kstrdup(dev, pdata->cpudai_name, GFP_KERNEL);
+	omap_hdmi_dai.platform_name =
+		devm_kstrdup(dev, pdata->cpudai_name, GFP_KERNEL);
+	omap_hdmi_dai.codec_name =
+		devm_kstrdup(dev, pdata->codec_name, GFP_KERNEL);
+
 	ret = snd_soc_register_card(card);
 	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
+		dev_err(dev, "snd_soc_register_card failed (%d)\n", ret);
 		card->dev = NULL;
 		return ret;
 	}
-- 
1.7.9.5

