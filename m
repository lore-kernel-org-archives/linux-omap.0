From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 - resend 06/13] ASoC: omap-abe-twl6040: Convert to platform deriver
Date: Tue, 24 Jan 2012 13:52:23 +0200
Message-ID: <1327405950-6676-7-git-send-email-peter.ujfalusi@ti.com>
References: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:38404 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756423Ab2AXLw5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 06:52:57 -0500
Received: by mail-lpp01m010-f42.google.com with SMTP id g1so1122808lah.29
        for <linux-omap@vger.kernel.org>; Tue, 24 Jan 2012 03:52:56 -0800 (PST)
In-Reply-To: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Convert the OMAP4 ABE/TWL6040 machine driver to platform
driver.
For the card name use the string provided via platform data.
The card's name for OMAP4 SDP4430 has been changed:
SDP4430 -> OMAP4-SDP4430

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/omap-abe-twl6040.c |   60 ++++++++++++++++++++++---------------
 1 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index 5598165..4ee0392 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -23,6 +23,7 @@
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/twl6040.h>
+#include <linux/platform_data/omap-abe-twl6040.h>
 #include <linux/module.h>
 
 #include <sound/core.h>
@@ -226,7 +227,6 @@ static struct snd_soc_dai_link sdp4430_dai[] = {
 
 /* Audio machine driver */
 static struct snd_soc_card omapabe_card = {
-	.name = "SDP4430",
 	.owner = THIS_MODULE,
 	.dai_link = sdp4430_dai,
 	.num_links = ARRAY_SIZE(sdp4430_dai),
@@ -237,44 +237,56 @@ static struct snd_soc_card omapabe_card = {
 	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
-static struct platform_device *omapabe_snd_device;
-
-static int __init omapabe_soc_init(void)
+static __devinit int omapabe_probe(struct platform_device *pdev)
 {
+	struct omap_abe_twl6040_data *pdata = dev_get_platdata(&pdev->dev);
+	struct snd_soc_card *card = &omapabe_card;
 	int ret;
 
-	if (!machine_is_omap_4430sdp())
-		return -ENODEV;
-	printk(KERN_INFO "SDP4430 SoC init\n");
+	card->dev = &pdev->dev;
 
-	omapabe_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!omapabe_snd_device) {
-		printk(KERN_ERR "Platform device allocation failed\n");
-		return -ENOMEM;
+	if (!pdata) {
+		dev_err(&pdev->dev, "Missing pdata\n");
+		return -ENODEV;
 	}
 
-	platform_set_drvdata(omapabe_snd_device, &omapabe_card);
+	if (pdata->card_name) {
+		card->name = pdata->card_name;
+	} else {
+		dev_err(&pdev->dev, "Card name is not provided\n");
+		return -ENODEV;
+	}
 
-	ret = platform_device_add(omapabe_snd_device);
+	ret = snd_soc_register_card(card);
 	if (ret)
-		goto err;
-
-	return 0;
+		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
+			ret);
 
-err:
-	printk(KERN_ERR "Unable to add platform device\n");
-	platform_device_put(omapabe_snd_device);
 	return ret;
 }
-module_init(omapabe_soc_init);
 
-static void __exit omapabe_soc_exit(void)
+static int __devexit omapabe_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(omapabe_snd_device);
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
+
+	return 0;
 }
-module_exit(omapabe_soc_exit);
+
+static struct platform_driver omapabe_driver = {
+	.driver = {
+		.name = "omap-abe-twl6040",
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = omapabe_probe,
+	.remove = __devexit_p(omapabe_remove),
+};
+
+module_platform_driver(omapabe_driver);
 
 MODULE_AUTHOR("Misael Lopez Cruz <misael.lopez@ti.com>");
 MODULE_DESCRIPTION("ALSA SoC for OMAP boards with ABE and twl6040 codec");
 MODULE_LICENSE("GPL");
-
+MODULE_ALIAS("platform:omap-abe-twl6040");
-- 
1.7.8.3

