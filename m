From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 05/13] OMAPDSS: hdmi_audio: Add hdmi_audio.c for registering HDMI audio support
Date: Fri, 23 May 2014 22:07:54 +0300
Message-ID: <5a91475f9881468504927548d8273d757c2c6682.1400871999.git.jsarha@ti.com>
References: <cover.1400871999.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46919 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbaEWTIb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 May 2014 15:08:31 -0400
In-Reply-To: <cover.1400871999.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

HDMI audio is implemented using ASoC component drivers. The drivers
were earlier registered from under mach-omap2 but that code had
problems with sharing the HDMI resources. This commit adds functions
for registering the ASoC drivers needed for HDMI audio from HDMI
driver itself.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/Makefile     |    2 +-
 drivers/video/fbdev/omap2/dss/hdmi.h       |   12 ++++
 drivers/video/fbdev/omap2/dss/hdmi_audio.c |   92 ++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 drivers/video/fbdev/omap2/dss/hdmi_audio.c

diff --git a/drivers/video/fbdev/omap2/dss/Makefile b/drivers/video/fbdev/omap2/dss/Makefile
index 390ab74..7ea2d7c 100644
--- a/drivers/video/fbdev/omap2/dss/Makefile
+++ b/drivers/video/fbdev/omap2/dss/Makefile
@@ -11,7 +11,7 @@ omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o
 omapdss-$(CONFIG_OMAP2_DSS_SDI) += sdi.o
 omapdss-$(CONFIG_OMAP2_DSS_DSI) += dsi.o
 omapdss-$(CONFIG_OMAP2_DSS_HDMI_COMMON) += hdmi_common.o hdmi_wp.o hdmi_pll.o \
-	hdmi_phy.o
+	hdmi_phy.o hdmi_audio.o
 omapdss-$(CONFIG_OMAP4_DSS_HDMI) += hdmi4.o hdmi4_core.o
 omapdss-$(CONFIG_OMAP5_DSS_HDMI) += hdmi5.o hdmi5_core.o
 ccflags-$(CONFIG_OMAP2_DSS_DEBUG) += -DDEBUG
diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index f644bc8..3ddb5f8 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -434,6 +434,18 @@ int hdmi_parse_lanes_of(struct platform_device *pdev, struct device_node *ep,
 	struct hdmi_phy_data *phy);
 
 #if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO) || defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
+struct hdmi_audio_data {
+	struct platform_device *cpudai_pdev;
+	struct platform_device *codec_pdev;
+	struct platform_device *card_pdev;
+};
+
+int hdmi_audio_register(struct platform_device *pdev,
+			struct hdmi_audio_data *data,
+			struct omap_dss_device *hdmi,
+			struct hdmi_wp_data *wp);
+void hdmi_audio_unregister(struct hdmi_audio_data *data);
+
 int hdmi_compute_acr(u32 pclk, u32 sample_freq, u32 *n, u32 *cts);
 int hdmi_wp_audio_enable(struct hdmi_wp_data *wp, bool enable);
 int hdmi_wp_audio_core_req_enable(struct hdmi_wp_data *wp, bool enable);
diff --git a/drivers/video/fbdev/omap2/dss/hdmi_audio.c b/drivers/video/fbdev/omap2/dss/hdmi_audio.c
new file mode 100644
index 0000000..2a485f7
--- /dev/null
+++ b/drivers/video/fbdev/omap2/dss/hdmi_audio.c
@@ -0,0 +1,92 @@
+/*
+ * OMAP4+ HDMI audio
+ *
+ * Copyright (C) 2014 Texas Instruments Incorporated
+ *
+ * Authors: Jyri Sarha <jsarha@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+#include <linux/of_dma.h>
+#include <linux/dmaengine.h>
+#include <sound/omap-hdmi-dai-pdata.h>
+#include <sound/omap-hdmi-card-pdata.h>
+
+#include "hdmi.h"
+
+static struct asoc_omap_hdmi_dai_pdata dai_pdata;
+struct asoc_omap_hdmi_card_pdata card_pdata;
+
+int hdmi_audio_register(struct platform_device *pdev,
+			struct hdmi_audio_data *data,
+			struct omap_dss_device *hdmi,
+			struct hdmi_wp_data *wp)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct dma_chan *dma_ch;
+	struct resource *res;
+
+	dai_pdata.dssdev = hdmi;
+	dai_pdata.dma_addr = hdmi_wp_get_phys_addr(wp) + HDMI_WP_AUDIO_DATA;
+
+	dma_ch = of_dma_request_slave_channel(np, "audio_tx");
+	if (IS_ERR(dma_ch)) {
+		dev_info(dev, "Could not get dma request channel from dts.\n");
+		/* Revert to hard coding. The DMA req channel is the
+		   same on all supported hw. */
+		dai_pdata.dma_req = 76;
+	} else {
+		dai_pdata.dma_req = dma_ch->chan_id;
+		/* We only peeked the chan_id for pdata and let dai
+		   driver take the DMA channel. */
+		dma_release_channel(dma_ch);
+	}
+
+	data->cpudai_pdev =
+		platform_device_register_data(dev, "omap-hdmi-audio-dai", 0,
+					      &dai_pdata, sizeof(dai_pdata));
+	if (IS_ERR(data->cpudai_pdev))
+		return PTR_ERR(data->cpudai_pdev);
+
+	data->codec_pdev =
+		platform_device_register_data(dev, "hdmi-audio-codec",
+					      0, NULL, 0);
+	if (IS_ERR(data->codec_pdev)) {
+		platform_device_unregister(data->cpudai_pdev);
+		return PTR_ERR(data->codec_pdev);
+	}
+
+	card_pdata.cpudai_name = dev_name(&data->cpudai_pdev->dev);
+	card_pdata.codec_name = dev_name(&data->codec_pdev->dev);
+	data->card_pdev =
+		platform_device_register_data(dev, "omap-hdmi-audio", 0,
+					      &card_pdata, sizeof(card_pdata));
+	if (IS_ERR(data->card_pdev)) {
+		platform_device_unregister(data->cpudai_pdev);
+		platform_device_unregister(data->codec_pdev);
+		return PTR_ERR(data->card_pdev);
+	}
+	return 0;
+}
+
+void hdmi_audio_unregister(struct hdmi_audio_data *data)
+{
+	platform_device_unregister(data->cpudai_pdev);
+	platform_device_unregister(data->codec_pdev);
+	platform_device_unregister(data->card_pdev);
+}
-- 
1.7.9.5

