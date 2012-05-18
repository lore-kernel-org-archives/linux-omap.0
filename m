From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 04/11] ASoC: OMAP: HDMI: Create a structure for
	private data of the CPU DAI
Date: Fri, 18 May 2012 01:42:36 -0500
Message-ID: <1337323363-11449-5-git-send-email-ricardo.neri@ti.com>
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

Create a struct hdmi_priv to store the relevant data of the CPU DAI
driver. As more data is added to the driver, having all the data
in the same location eases its handling. At the moment, only the DMA
configuration parameters are included in the structure.

Also, the required memory is allocated using devm_kzalloc rather than
using a static global variable.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 sound/soc/omap/omap-hdmi.c |   28 +++++++++++++++++++---------
 1 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index b889f76..a6656b2 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -37,9 +37,8 @@
 
 #define DRV_NAME "omap-hdmi-audio-dai"
 
-static struct omap_pcm_dma_data omap_hdmi_dai_dma_params = {
-	.name = "HDMI playback",
-	.sync_mode = OMAP_DMA_SYNC_PACKET,
+struct hdmi_priv {
+	struct omap_pcm_dma_data dma_params;
 };
 
 static int omap_hdmi_dai_startup(struct snd_pcm_substream *substream,
@@ -62,23 +61,24 @@ static int omap_hdmi_dai_hw_params(struct snd_pcm_substream *substream,
 				    struct snd_pcm_hw_params *params,
 				    struct snd_soc_dai *dai)
 {
+	struct hdmi_priv *priv = snd_soc_dai_get_drvdata(dai);
 	int err = 0;
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
-		omap_hdmi_dai_dma_params.packet_size = 16;
+		priv->dma_params.packet_size = 16;
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
-		omap_hdmi_dai_dma_params.packet_size = 32;
+		priv->dma_params.packet_size = 32;
 		break;
 	default:
 		err = -EINVAL;
 	}
 
-	omap_hdmi_dai_dma_params.data_type = OMAP_DMA_DATA_TYPE_S32;
+	priv->dma_params.data_type = OMAP_DMA_DATA_TYPE_S32;
 
 	snd_soc_dai_set_dma_data(dai, substream,
-				 &omap_hdmi_dai_dma_params);
+				 &priv->dma_params);
 
 	return err;
 }
@@ -102,6 +102,13 @@ static __devinit int omap_hdmi_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct resource *hdmi_rsrc;
+	struct hdmi_priv *hdmi_data;
+
+	hdmi_data = devm_kzalloc(&pdev->dev, sizeof(*hdmi_data), GFP_KERNEL);
+	if (hdmi_data == NULL) {
+		dev_err(&pdev->dev, "Cannot allocate memory for HDMI data\n");
+		return -ENOMEM;
+	}
 
 	hdmi_rsrc = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!hdmi_rsrc) {
@@ -109,7 +116,7 @@ static __devinit int omap_hdmi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	omap_hdmi_dai_dma_params.port_addr =  hdmi_rsrc->start
+	hdmi_data->dma_params.port_addr =  hdmi_rsrc->start
 		+ OMAP_HDMI_AUDIO_DMA_PORT;
 
 	hdmi_rsrc = platform_get_resource(pdev, IORESOURCE_DMA, 0);
@@ -118,8 +125,11 @@ static __devinit int omap_hdmi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	omap_hdmi_dai_dma_params.dma_req =  hdmi_rsrc->start;
+	hdmi_data->dma_params.dma_req =  hdmi_rsrc->start;
+	hdmi_data->dma_params.name = "HDMI playback";
+	hdmi_data->dma_params.sync_mode = OMAP_DMA_SYNC_PACKET;
 
+	dev_set_drvdata(&pdev->dev, hdmi_data);
 	ret = snd_soc_register_dai(&pdev->dev, &omap_hdmi_dai);
 	return ret;
 }
-- 
1.7.5.4
