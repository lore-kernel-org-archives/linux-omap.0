From: David Lambert <dlambert@ti.com>
Subject: [PATCH 2/5] ASoC: DMIC codec: Adding a generic DMIC codec
Date: Mon, 27 Dec 2010 22:17:03 -0600
Message-ID: <1293509826-23253-3-git-send-email-dlambert@ti.com>
References: <1293509826-23253-1-git-send-email-dlambert@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37540 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244Ab0L1ERn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Dec 2010 23:17:43 -0500
In-Reply-To: <1293509826-23253-1-git-send-email-dlambert@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, David Lambert <dlambert@ti.com>

This codec is to be used by the DMIC driver to
control the DMIC codec.  This driver will be used on future implementations
of the DMIC driver to support codec specific features.

At this time, the codec driver just registers the codec DAI.

Signed-off-by: David Lambert <dlambert@ti.com>
---
 sound/soc/codecs/dmic.c |   79 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 79 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/dmic.c

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
new file mode 100644
index 0000000..6f54bc5
--- /dev/null
+++ b/sound/soc/codecs/dmic.c
@@ -0,0 +1,79 @@
+/*
+ * dmic.c  --  SoC audio for Generic Digital MICs
+ *
+ * Author: Liam Girdwood <lrg@slimlogic.co.uk>
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
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+static struct snd_soc_dai_driver dmic_dai = {
+	.name = "dmic-hifi",
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 8,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.formats = SNDRV_PCM_FMTBIT_S32_LE
+			| SNDRV_PCM_FMTBIT_S24_LE
+			| SNDRV_PCM_FMTBIT_S16_LE,
+	},
+};
+
+static struct snd_soc_codec_driver soc_dmic = {};
+
+static int __devinit dmic_dev_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev,
+			&soc_dmic, &dmic_dai, 1);
+}
+
+static int __devexit dmic_dev_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver dmic_driver = {
+	.driver = {
+		.name = "dmic-codec",
+		.owner = THIS_MODULE,
+	},
+	.probe = dmic_dev_probe,
+	.remove = __devexit_p(dmic_dev_remove),
+};
+
+static int __init dmic_init(void)
+{
+	return platform_driver_register(&dmic_driver);
+}
+module_init(dmic_init);
+
+static void __exit dmic_exit(void)
+{
+	platform_driver_unregister(&dmic_driver);
+}
+module_exit(dmic_exit);
+
+MODULE_DESCRIPTION("Generic DMIC driver");
+MODULE_AUTHOR("Liam Girdwood <lrg@slimlogic.co.uk>");
+MODULE_LICENSE("GPL");
-- 
1.7.0.4

