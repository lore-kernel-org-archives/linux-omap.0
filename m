From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 11/11] ASoC: omap-mcbsp: Simplify DMA configuration
Date: Wed, 15 Feb 2012 17:38:00 +0200
Message-ID: <1329320280-1621-12-git-send-email-peter.ujfalusi@ti.com>
References: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:44807 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751779Ab2BOPi0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 10:38:26 -0500
Received: by lagw12 with SMTP id w12so1611507lag.21
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 07:38:23 -0800 (PST)
In-Reply-To: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>

Configure the DMA request line, port address, and stream name at
probe time instead of every time we start a stream.
These settings are static in the system.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/mcbsp.c      |   29 ++++++++++-------------------
 sound/soc/omap/mcbsp.h      |    7 -------
 sound/soc/omap/omap-mcbsp.c |    8 --------
 3 files changed, 10 insertions(+), 34 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index 98f1c9f..a941a3c 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -177,22 +177,6 @@ void omap_mcbsp_config(struct omap_mcbsp *mcbsp,
 }
 
 /**
- * omap_mcbsp_dma_params - returns the dma channel number
- * @id - mcbsp id
- * @stream - indicates the direction of data flow (rx or tx)
- *
- * Returns the dma channel number for the rx channel or tx channel
- * based on the value of @stream for the requested mcbsp given by @id
- */
-int omap_mcbsp_dma_ch_params(struct omap_mcbsp *mcbsp, unsigned int stream)
-{
-	if (stream)
-		return mcbsp->dma_rx_sync;
-	else
-		return mcbsp->dma_tx_sync;
-}
-
-/**
  * omap_mcbsp_dma_reg_params - returns the address of mcbsp data register
  * @id - mcbsp id
  * @stream - indicates the direction of data flow (rx or tx)
@@ -201,7 +185,8 @@ int omap_mcbsp_dma_ch_params(struct omap_mcbsp *mcbsp, unsigned int stream)
  * to be used by DMA for transferring/receiving data based on the value of
  * @stream for the requested mcbsp given by @id
  */
-int omap_mcbsp_dma_reg_params(struct omap_mcbsp *mcbsp, unsigned int stream)
+static int omap_mcbsp_dma_reg_params(struct omap_mcbsp *mcbsp,
+				     unsigned int stream)
 {
 	int data_reg;
 
@@ -990,14 +975,20 @@ int __devinit omap_mcbsp_init(struct platform_device *pdev)
 		dev_err(&pdev->dev, "invalid rx DMA channel\n");
 		return -ENODEV;
 	}
-	mcbsp->dma_rx_sync = res->start;
+	/* RX DMA request number, and port address configuration */
+	mcbsp->dma_data[1].name = "Audio Capture";
+	mcbsp->dma_data[1].dma_req = res->start;
+	mcbsp->dma_data[1].port_addr = omap_mcbsp_dma_reg_params(mcbsp, 1);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
 	if (!res) {
 		dev_err(&pdev->dev, "invalid tx DMA channel\n");
 		return -ENODEV;
 	}
-	mcbsp->dma_tx_sync = res->start;
+	/* TX DMA request number, and port address configuration */
+	mcbsp->dma_data[0].name = "Audio Playback";
+	mcbsp->dma_data[0].dma_req = res->start;
+	mcbsp->dma_data[0].port_addr = omap_mcbsp_dma_reg_params(mcbsp, 0);
 
 	mcbsp->fclk = clk_get(&pdev->dev, "fck");
 	if (IS_ERR(mcbsp->fclk)) {
diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
index d250bcc..a5518d7 100644
--- a/sound/soc/omap/mcbsp.h
+++ b/sound/soc/omap/mcbsp.h
@@ -288,10 +288,6 @@ struct omap_mcbsp {
 	int rx_irq;
 	int tx_irq;
 
-	/* DMA stuff */
-	u8 dma_rx_sync;
-	u8 dma_tx_sync;
-
 	/* Protect the field .free, while checking if the mcbsp is in use */
 	struct omap_mcbsp_platform_data *pdata;
 	struct omap_mcbsp_st_data *st_data;
@@ -328,9 +324,6 @@ int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id);
 void omap2_mcbsp1_mux_clkr_src(struct omap_mcbsp *mcbsp, u8 mux);
 void omap2_mcbsp1_mux_fsr_src(struct omap_mcbsp *mcbsp, u8 mux);
 
-int omap_mcbsp_dma_ch_params(struct omap_mcbsp *mcbsp, unsigned int stream);
-int omap_mcbsp_dma_reg_params(struct omap_mcbsp *mcbsp, unsigned int stream);
-
 /* Sidetone specific API */
 int omap_st_set_chgain(struct omap_mcbsp *mcbsp, int channel, s16 chgain);
 int omap_st_get_chgain(struct omap_mcbsp *mcbsp, int channel, s16 *chgain);
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 4cd7af8..10eb645 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -225,17 +225,12 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
 	struct omap_mcbsp_reg_cfg *regs = &mcbsp->cfg_regs;
 	struct omap_pcm_dma_data *dma_data;
-	int dma;
 	int wlen, channels, wpf, sync_mode = OMAP_DMA_SYNC_ELEMENT;
 	int pkt_size = 0;
-	unsigned long port;
 	unsigned int format, div, framesize, master;
 
 	dma_data = &mcbsp->dma_data[substream->stream];
 
-	dma = omap_mcbsp_dma_ch_params(mcbsp, substream->stream);
-	port = omap_mcbsp_dma_reg_params(mcbsp, substream->stream);
-
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 		dma_data->data_type = OMAP_DMA_DATA_TYPE_S16;
@@ -291,9 +286,6 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-	dma_data->name = substream->stream ? "Audio Capture" : "Audio Playback";
-	dma_data->dma_req = dma;
-	dma_data->port_addr = port;
 	dma_data->sync_mode = sync_mode;
 	dma_data->packet_size = pkt_size;
 
-- 
1.7.8.4

