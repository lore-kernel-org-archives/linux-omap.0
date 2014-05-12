From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 02/19] OMAPDSS: hdmi-common: Add hdmi_dss_audio_from_hw_params()
Date: Mon, 12 May 2014 12:12:13 +0300
Message-ID: <6dbb6dbbf299609fa3f527bcd5e41d5648b764d3.1399884780.git.jsarha@ti.com>
References: <cover.1399884780.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37957 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872AbaELJMo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 May 2014 05:12:44 -0400
In-Reply-To: <cover.1399884780.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Add common function for struct omap_dss_audio initialization from
struct snd_pcm_hw_params.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h        |    5 ++
 drivers/video/fbdev/omap2/dss/hdmi_common.c |  117 ++++++++++++++++++++++++++-
 2 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index fbee078..65bf072 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -433,6 +433,11 @@ int hdmi_parse_lanes_of(struct platform_device *pdev, struct device_node *ep,
 
 #if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO) || defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
 int hdmi_compute_acr(u32 pclk, u32 sample_freq, u32 *n, u32 *cts);
+struct snd_pcm_hw_params;
+struct snd_soc_dai;
+int hdmi_dss_audio_from_hw_params(struct snd_pcm_hw_params *params,
+				  struct omap_dss_audio *dss_audio,
+				  struct snd_soc_dai *dai);
 int hdmi_wp_audio_enable(struct hdmi_wp_data *wp, bool enable);
 int hdmi_wp_audio_core_req_enable(struct hdmi_wp_data *wp, bool enable);
 void hdmi_wp_audio_config_format(struct hdmi_wp_data *wp,
diff --git a/drivers/video/fbdev/omap2/dss/hdmi_common.c b/drivers/video/fbdev/omap2/dss/hdmi_common.c
index 9a2c39c..85a2407 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_common.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_common.c
@@ -19,6 +19,12 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <video/omapdss.h>
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO) || defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
+#include <sound/asound.h>
+#include <sound/asoundef.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#endif
 
 #include "hdmi.h"
 
@@ -364,7 +370,7 @@ int hdmi_parse_lanes_of(struct platform_device *pdev, struct device_node *ep,
 	return 0;
 }
 
-#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO) || defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
 int hdmi_compute_acr(u32 pclk, u32 sample_freq, u32 *n, u32 *cts)
 {
 	u32 deep_color;
@@ -463,4 +469,113 @@ int hdmi_compute_acr(u32 pclk, u32 sample_freq, u32 *n, u32 *cts)
 
 	return 0;
 }
+
+int hdmi_dss_audio_from_hw_params(struct snd_pcm_hw_params *params,
+				  struct omap_dss_audio *dss_audio,
+				  struct snd_soc_dai *dai)
+{
+	struct snd_aes_iec958 *iec = dss_audio->iec;
+	struct snd_cea_861_aud_if *cea = dss_audio->cea;
+
+	/*
+	 * fill the IEC-60958 channel status word
+	 */
+	/* initialize the word bytes */
+	memset(iec->status, 0, sizeof(iec->status));
+
+	/* specify IEC-60958-3 (commercial use) */
+	iec->status[0] &= ~IEC958_AES0_PROFESSIONAL;
+
+	/* specify that the audio is LPCM*/
+	iec->status[0] &= ~IEC958_AES0_NONAUDIO;
+
+	iec->status[0] |= IEC958_AES0_CON_NOT_COPYRIGHT;
+
+	iec->status[0] |= IEC958_AES0_CON_EMPHASIS_NONE;
+
+	iec->status[0] |= IEC958_AES1_PRO_MODE_NOTID;
+
+	iec->status[1] = IEC958_AES1_CON_GENERAL;
+
+	iec->status[2] |= IEC958_AES2_CON_SOURCE_UNSPEC;
+
+	iec->status[2] |= IEC958_AES2_CON_CHANNEL_UNSPEC;
+
+	switch (params_rate(params)) {
+	case 32000:
+		iec->status[3] |= IEC958_AES3_CON_FS_32000;
+		break;
+	case 44100:
+		iec->status[3] |= IEC958_AES3_CON_FS_44100;
+		break;
+	case 48000:
+		iec->status[3] |= IEC958_AES3_CON_FS_48000;
+		break;
+	case 88200:
+		iec->status[3] |= IEC958_AES3_CON_FS_88200;
+		break;
+	case 96000:
+		iec->status[3] |= IEC958_AES3_CON_FS_96000;
+		break;
+	case 176400:
+		iec->status[3] |= IEC958_AES3_CON_FS_176400;
+		break;
+	case 192000:
+		iec->status[3] |= IEC958_AES3_CON_FS_192000;
+		break;
+	default:
+		dev_err(dai->dev, "rate not supported!\n");
+		return -EINVAL;
+	}
+
+	/* specify the clock accuracy */
+	iec->status[3] |= IEC958_AES3_CON_CLOCK_1000PPM;
+
+	/*
+	 * specify the word length. The same word length value can mean
+	 * two different lengths. Hence, we need to specify the maximum
+	 * word length as well.
+	 */
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		iec->status[4] |= IEC958_AES4_CON_WORDLEN_20_16;
+		iec->status[4] &= ~IEC958_AES4_CON_MAX_WORDLEN_24;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		iec->status[4] |= IEC958_AES4_CON_WORDLEN_24_20;
+		iec->status[4] |= IEC958_AES4_CON_MAX_WORDLEN_24;
+		break;
+	default:
+		dev_err(dai->dev, "format not supported!\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Fill the CEA-861 audio infoframe (see spec for details)
+	 */
+
+	cea->db1_ct_cc = (params_channels(params) - 1)
+		& CEA861_AUDIO_INFOFRAME_DB1CC;
+	cea->db1_ct_cc |= CEA861_AUDIO_INFOFRAME_DB1CT_FROM_STREAM;
+
+	cea->db2_sf_ss = CEA861_AUDIO_INFOFRAME_DB2SF_FROM_STREAM;
+	cea->db2_sf_ss |= CEA861_AUDIO_INFOFRAME_DB2SS_FROM_STREAM;
+
+	cea->db3 = 0; /* not used, all zeros */
+
+	/*
+	 * The OMAP HDMI IP requires to use the 8-channel channel code when
+	 * transmitting more than two channels.
+	 */
+	if (params_channels(params) == 2)
+		cea->db4_ca = 0x0;
+	else
+		cea->db4_ca = 0x13;
+
+	cea->db5_dminh_lsv = CEA861_AUDIO_INFOFRAME_DB5_DM_INH_PROHIBITED;
+	/* the expression is trivial but makes clear what we are doing */
+	cea->db5_dminh_lsv |= (0 & CEA861_AUDIO_INFOFRAME_DB5_LSV);
+
+	return 0;
+}
 #endif
-- 
1.7.9.5

