From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 10/11] ASoC: OMAP: HDMI: Make sound card naming
	more generic
Date: Fri, 18 May 2012 01:42:42 -0500
Message-ID: <1337323363-11449-11-git-send-email-ricardo.neri@ti.com>
References: <1337323363-11449-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1337323363-11449-1-git-send-email-ricardo.neri@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: x0055901@ti.com, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>, peter.ujfalusi@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Rename all the relevant structures, variables and functions to not
make specific reference to OMAP4. This is to make the driver encompass
future OMAP versions that feature HDMI and not only OMAP4. These
changes are only in naming. There are not functional changes.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 sound/soc/omap/omap4-hdmi-card.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/omap/omap4-hdmi-card.c b/sound/soc/omap/omap4-hdmi-card.c
index 6c3255f..eaa2ea0 100644
--- a/sound/soc/omap/omap4-hdmi-card.c
+++ b/sound/soc/omap/omap4-hdmi-card.c
@@ -1,7 +1,7 @@
 /*
- * omap4-hdmi-card.c
+ * omap-hdmi-card.c
  *
- * OMAP ALSA SoC machine driver for TI OMAP4 HDMI
+ * OMAP ALSA SoC machine driver for TI OMAP HDMI
  * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
  * Author: Ricardo Neri <ricardo.neri@ti.com>
  *
@@ -29,7 +29,7 @@
 
 #define DRV_NAME "omap-hdmi-audio"
 
-static struct snd_soc_dai_link omap4_hdmi_dai = {
+static struct snd_soc_dai_link omap_hdmi_dai = {
 	.name = "HDMI",
 	.stream_name = "HDMI",
 	.cpu_dai_name = "omap-hdmi-audio-dai",
@@ -38,16 +38,16 @@ static struct snd_soc_dai_link omap4_hdmi_dai = {
 	.codec_dai_name = "omap-hdmi-hifi",
 };
 
-static struct snd_soc_card snd_soc_omap4_hdmi = {
-	.name = "OMAP4HDMI",
+static struct snd_soc_card snd_soc_omap_hdmi = {
+	.name = "OMAPHDMI",
 	.owner = THIS_MODULE,
-	.dai_link = &omap4_hdmi_dai,
+	.dai_link = &omap_hdmi_dai,
 	.num_links = 1,
 };
 
-static __devinit int omap4_hdmi_probe(struct platform_device *pdev)
+static __devinit int omap_hdmi_probe(struct platform_device *pdev)
 {
-	struct snd_soc_card *card = &snd_soc_omap4_hdmi;
+	struct snd_soc_card *card = &snd_soc_omap_hdmi;
 	int ret;
 
 	card->dev = &pdev->dev;
@@ -61,7 +61,7 @@ static __devinit int omap4_hdmi_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit omap4_hdmi_remove(struct platform_device *pdev)
+static int __devexit omap_hdmi_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
@@ -70,18 +70,18 @@ static int __devexit omap4_hdmi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver omap4_hdmi_driver = {
+static struct platform_driver omap_hdmi_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
 	},
-	.probe = omap4_hdmi_probe,
-	.remove = __devexit_p(omap4_hdmi_remove),
+	.probe = omap_hdmi_probe,
+	.remove = __devexit_p(omap_hdmi_remove),
 };
 
-module_platform_driver(omap4_hdmi_driver);
+module_platform_driver(omap_hdmi_driver);
 
 MODULE_AUTHOR("Ricardo Neri <ricardo.neri@ti.com>");
-MODULE_DESCRIPTION("OMAP4 HDMI machine ASoC driver");
+MODULE_DESCRIPTION("OMAP HDMI machine ASoC driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRV_NAME);
-- 
1.7.5.4
