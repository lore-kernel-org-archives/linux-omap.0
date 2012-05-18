From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 06/11] ASoC: OMAP: HDMI: Expand configuration
	of hw_params
Date: Fri, 18 May 2012 01:42:38 -0500
Message-ID: <1337323363-11449-7-git-send-email-ricardo.neri@ti.com>
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

Expand the configuration of the hw_params to include the IEC-60958
channel status word and the CEA-861 audio infoframe. The configuration
of such structures depends on the snd_pcm_hw_params received. A
omap_dss_audio is used to pass the configuration parameters to DSS.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 sound/soc/omap/omap-hdmi.c |  116 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 115 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index ff6132a..fc4815a 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -30,6 +30,8 @@
 #include <sound/pcm_params.h>
 #include <sound/initval.h>
 #include <sound/soc.h>
+#include <sound/asound.h>
+#include <sound/asoundef.h>
 #include <video/omapdss.h>
 
 #include <plat/dma.h>
@@ -40,6 +42,9 @@
 
 struct hdmi_priv {
 	struct omap_pcm_dma_data dma_params;
+	struct omap_dss_audio dss_audio;
+	struct snd_aes_iec958 iec;
+	struct snd_cea_861_aud_if cea;
 	struct omap_dss_device *dssdev;
 };
 
@@ -72,6 +77,8 @@ static int omap_hdmi_dai_hw_params(struct snd_pcm_substream *substream,
 				    struct snd_soc_dai *dai)
 {
 	struct hdmi_priv *priv = snd_soc_dai_get_drvdata(dai);
+	struct snd_aes_iec958 *iec = &priv->iec;
+	struct snd_cea_861_aud_if *cea = &priv->cea;
 	int err = 0;
 
 	switch (params_format(params)) {
@@ -82,7 +89,8 @@ static int omap_hdmi_dai_hw_params(struct snd_pcm_substream *substream,
 		priv->dma_params.packet_size = 32;
 		break;
 	default:
-		err = -EINVAL;
+		dev_err(dai->dev, "format not supported!\n");
+		return -EINVAL;
 	}
 
 	priv->dma_params.data_type = OMAP_DMA_DATA_TYPE_S32;
@@ -90,6 +98,109 @@ static int omap_hdmi_dai_hw_params(struct snd_pcm_substream *substream,
 	snd_soc_dai_set_dma_data(dai, substream,
 				 &priv->dma_params);
 
+	/*
+	 * fill the IEC-60958 channel status word
+	 */
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
+	priv->dss_audio.iec = iec;
+	priv->dss_audio.cea = cea;
+
+	err = priv->dssdev->driver->audio_config(priv->dssdev,
+						 &priv->dss_audio);
+
 	return err;
 }
 
@@ -127,6 +238,9 @@ static void omap_hdmi_dai_shutdown(struct snd_pcm_substream *substream,
 static const struct snd_soc_dai_ops omap_hdmi_dai_ops = {
 	.startup	= omap_hdmi_dai_startup,
 	.hw_params	= omap_hdmi_dai_hw_params,
+	.prepare	= omap_hdmi_dai_prepare,
+	.trigger	= omap_hdmi_dai_trigger,
+	.shutdown	= omap_hdmi_dai_shutdown,
 };
 
 static struct snd_soc_dai_driver omap_hdmi_dai = {
-- 
1.7.5.4
