From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 11/11] ASoC: OMAP: HDMI: Rename sound card source file
Date: Fri, 18 May 2012 01:42:43 -0500
Message-ID: <1337323363-11449-12-git-send-email-ricardo.neri@ti.com>
References: <1337323363-11449-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51451 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754479Ab2ERGnX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 May 2012 02:43:23 -0400
In-Reply-To: <1337323363-11449-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: x0055901@ti.com, peter.ujfalusi@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

Rename sound card driver source file to encompass not only OMAP4 but future
OMAP versions that feature HDMI.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 sound/soc/omap/Makefile          |    4 +-
 sound/soc/omap/omap-hdmi-card.c  |   87 ++++++++++++++++++++++++++++++++++++++
 sound/soc/omap/omap4-hdmi-card.c |   87 --------------------------------------
 3 files changed, 89 insertions(+), 89 deletions(-)
 create mode 100644 sound/soc/omap/omap-hdmi-card.c
 delete mode 100644 sound/soc/omap/omap4-hdmi-card.c

diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index b4ef308..0e14dd3 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -25,7 +25,7 @@ snd-soc-omap3pandora-objs := omap3pandora.o
 snd-soc-omap3beagle-objs := omap3beagle.o
 snd-soc-zoom2-objs := zoom2.o
 snd-soc-igep0020-objs := igep0020.o
-snd-soc-omap4-hdmi-objs := omap4-hdmi-card.o
+snd-soc-omap-hdmi-card-objs := omap-hdmi-card.o
 
 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
 obj-$(CONFIG_SND_OMAP_SOC_RX51) += snd-soc-rx51.o
@@ -41,4 +41,4 @@ obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
 obj-$(CONFIG_SND_OMAP_SOC_ZOOM2) += snd-soc-zoom2.o
 obj-$(CONFIG_SND_OMAP_SOC_IGEP0020) += snd-soc-igep0020.o
-obj-$(CONFIG_SND_OMAP_SOC_OMAP_HDMI) += snd-soc-omap4-hdmi.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP_HDMI) += snd-soc-omap-hdmi-card.o
diff --git a/sound/soc/omap/omap-hdmi-card.c b/sound/soc/omap/omap-hdmi-card.c
new file mode 100644
index 0000000..eaa2ea0
--- /dev/null
+++ b/sound/soc/omap/omap-hdmi-card.c
@@ -0,0 +1,87 @@
+/*
+ * omap-hdmi-card.c
+ *
+ * OMAP ALSA SoC machine driver for TI OMAP HDMI
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Author: Ricardo Neri <ricardo.neri@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/module.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <asm/mach-types.h>
+#include <video/omapdss.h>
+
+#define DRV_NAME "omap-hdmi-audio"
+
+static struct snd_soc_dai_link omap_hdmi_dai = {
+	.name = "HDMI",
+	.stream_name = "HDMI",
+	.cpu_dai_name = "omap-hdmi-audio-dai",
+	.platform_name = "omap-pcm-audio",
+	.codec_name = "hdmi-audio-codec",
+	.codec_dai_name = "omap-hdmi-hifi",
+};
+
+static struct snd_soc_card snd_soc_omap_hdmi = {
+	.name = "OMAPHDMI",
+	.owner = THIS_MODULE,
+	.dai_link = &omap_hdmi_dai,
+	.num_links = 1,
+};
+
+static __devinit int omap_hdmi_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &snd_soc_omap_hdmi;
+	int ret;
+
+	card->dev = &pdev->dev;
+
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
+		card->dev = NULL;
+		return ret;
+	}
+	return 0;
+}
+
+static int __devexit omap_hdmi_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
+	card->dev = NULL;
+	return 0;
+}
+
+static struct platform_driver omap_hdmi_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+	},
+	.probe = omap_hdmi_probe,
+	.remove = __devexit_p(omap_hdmi_remove),
+};
+
+module_platform_driver(omap_hdmi_driver);
+
+MODULE_AUTHOR("Ricardo Neri <ricardo.neri@ti.com>");
+MODULE_DESCRIPTION("OMAP HDMI machine ASoC driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/sound/soc/omap/omap4-hdmi-card.c b/sound/soc/omap/omap4-hdmi-card.c
deleted file mode 100644
index eaa2ea0..0000000
--- a/sound/soc/omap/omap4-hdmi-card.c
+++ /dev/null
@@ -1,87 +0,0 @@
-/*
- * omap-hdmi-card.c
- *
- * OMAP ALSA SoC machine driver for TI OMAP HDMI
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
- * Author: Ricardo Neri <ricardo.neri@ti.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/module.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-#include <asm/mach-types.h>
-#include <video/omapdss.h>
-
-#define DRV_NAME "omap-hdmi-audio"
-
-static struct snd_soc_dai_link omap_hdmi_dai = {
-	.name = "HDMI",
-	.stream_name = "HDMI",
-	.cpu_dai_name = "omap-hdmi-audio-dai",
-	.platform_name = "omap-pcm-audio",
-	.codec_name = "hdmi-audio-codec",
-	.codec_dai_name = "omap-hdmi-hifi",
-};
-
-static struct snd_soc_card snd_soc_omap_hdmi = {
-	.name = "OMAPHDMI",
-	.owner = THIS_MODULE,
-	.dai_link = &omap_hdmi_dai,
-	.num_links = 1,
-};
-
-static __devinit int omap_hdmi_probe(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = &snd_soc_omap_hdmi;
-	int ret;
-
-	card->dev = &pdev->dev;
-
-	ret = snd_soc_register_card(card);
-	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
-		card->dev = NULL;
-		return ret;
-	}
-	return 0;
-}
-
-static int __devexit omap_hdmi_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-	card->dev = NULL;
-	return 0;
-}
-
-static struct platform_driver omap_hdmi_driver = {
-	.driver = {
-		.name = DRV_NAME,
-		.owner = THIS_MODULE,
-	},
-	.probe = omap_hdmi_probe,
-	.remove = __devexit_p(omap_hdmi_remove),
-};
-
-module_platform_driver(omap_hdmi_driver);
-
-MODULE_AUTHOR("Ricardo Neri <ricardo.neri@ti.com>");
-MODULE_DESCRIPTION("OMAP HDMI machine ASoC driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
1.7.5.4

