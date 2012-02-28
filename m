From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 09/10] ASoC: omap-mcbsp: Merge the omap_mcbsp_data into omap_mcbsp structure
Date: Tue, 28 Feb 2012 09:40:19 +0200
Message-ID: <1330414820-4641-10-git-send-email-peter.ujfalusi@ti.com>
References: <1330414820-4641-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:50018 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756522Ab2B1Hkx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 02:40:53 -0500
Received: by mail-lpp01m010-f42.google.com with SMTP id l5so5894457lah.1
        for <linux-omap@vger.kernel.org>; Mon, 27 Feb 2012 23:40:51 -0800 (PST)
In-Reply-To: <1330414820-4641-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Grazvydas Ignotas <notasas@gmail.com>

Since the drivers has been merged, merge the two structures together.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Grazvydas Ignotas <notasas@gmail.com>
Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 sound/soc/omap/mcbsp.h      |   33 ++++++++++++--------------
 sound/soc/omap/omap-mcbsp.c |   53 ++++++++++++++++++------------------------
 2 files changed, 38 insertions(+), 48 deletions(-)

diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
index ac90c1a..d250bcc 100644
--- a/sound/soc/omap/mcbsp.h
+++ b/sound/soc/omap/mcbsp.h
@@ -269,27 +269,20 @@ struct omap_mcbsp_st_data {
 	s16 ch1gain;
 };
 
-struct omap_mcbsp_data {
-	struct omap_mcbsp_reg_cfg	regs;
-	struct omap_pcm_dma_data	dma_data[2];
-	unsigned int			fmt;
-	/*
-	 * Flags indicating is the bus already activated and configured by
-	 * another substream
-	 */
-	int				active;
-	int				configured;
-	unsigned int			in_freq;
-	int				clk_div;
-	int				wlen;
-};
-
 struct omap_mcbsp {
 	struct device *dev;
+	struct clk *fclk;
+	spinlock_t lock;
 	unsigned long phys_base;
 	unsigned long phys_dma_base;
 	void __iomem *io_base;
 	u8 id;
+	/*
+	 * Flags indicating is the bus already activated and configured by
+	 * another substream
+	 */
+	int active;
+	int configured;
 	u8 free;
 
 	int rx_irq;
@@ -300,16 +293,20 @@ struct omap_mcbsp {
 	u8 dma_tx_sync;
 
 	/* Protect the field .free, while checking if the mcbsp is in use */
-	spinlock_t lock;
 	struct omap_mcbsp_platform_data *pdata;
-	struct clk *fclk;
 	struct omap_mcbsp_st_data *st_data;
-	struct omap_mcbsp_data mcbsp_data;
+	struct omap_mcbsp_reg_cfg cfg_regs;
+	struct omap_pcm_dma_data dma_data[2];
 	int dma_op_mode;
 	u16 max_tx_thres;
 	u16 max_rx_thres;
 	void *reg_cache;
 	int reg_cache_size;
+
+	unsigned int fmt;
+	unsigned int in_freq;
+	int clk_div;
+	int wlen;
 };
 
 void omap_mcbsp_config(struct omap_mcbsp *mcbsp,
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 69a44aa..4cd7af8 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -66,7 +66,6 @@ static void omap_mcbsp_set_threshold(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
-	struct omap_mcbsp_data *mcbsp_data = &mcbsp->mcbsp_data;
 	struct omap_pcm_dma_data *dma_data;
 	int words;
 
@@ -83,7 +82,7 @@ static void omap_mcbsp_set_threshold(struct snd_pcm_substream *substream)
 			words = dma_data->packet_size;
 		else
 			words = snd_pcm_lib_period_bytes(substream) /
-							(mcbsp_data->wlen / 8);
+							(mcbsp->wlen / 8);
 	else
 		words = 1;
 
@@ -160,11 +159,10 @@ static void omap_mcbsp_dai_shutdown(struct snd_pcm_substream *substream,
 				    struct snd_soc_dai *cpu_dai)
 {
 	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
-	struct omap_mcbsp_data *mcbsp_data = &mcbsp->mcbsp_data;
 
 	if (!cpu_dai->active) {
 		omap_mcbsp_free(mcbsp);
-		mcbsp_data->configured = 0;
+		mcbsp->configured = 0;
 	}
 }
 
@@ -172,14 +170,13 @@ static int omap_mcbsp_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 				  struct snd_soc_dai *cpu_dai)
 {
 	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
-	struct omap_mcbsp_data *mcbsp_data = &mcbsp->mcbsp_data;
 	int err = 0, play = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		mcbsp_data->active++;
+		mcbsp->active++;
 		omap_mcbsp_start(mcbsp, play, !play);
 		break;
 
@@ -187,7 +184,7 @@ static int omap_mcbsp_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		omap_mcbsp_stop(mcbsp, play, !play);
-		mcbsp_data->active--;
+		mcbsp->active--;
 		break;
 	default:
 		err = -EINVAL;
@@ -226,8 +223,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 				    struct snd_soc_dai *cpu_dai)
 {
 	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
-	struct omap_mcbsp_data *mcbsp_data = &mcbsp->mcbsp_data;
-	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
+	struct omap_mcbsp_reg_cfg *regs = &mcbsp->cfg_regs;
 	struct omap_pcm_dma_data *dma_data;
 	int dma;
 	int wlen, channels, wpf, sync_mode = OMAP_DMA_SYNC_ELEMENT;
@@ -235,7 +231,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	unsigned long port;
 	unsigned int format, div, framesize, master;
 
-	dma_data = &mcbsp_data->dma_data[substream->stream];
+	dma_data = &mcbsp->dma_data[substream->stream];
 
 	dma = omap_mcbsp_dma_ch_params(mcbsp, substream->stream);
 	port = omap_mcbsp_dma_reg_params(mcbsp, substream->stream);
@@ -303,7 +299,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 
 	snd_soc_dai_set_dma_data(cpu_dai, substream, dma_data);
 
-	if (mcbsp_data->configured) {
+	if (mcbsp->configured) {
 		/* McBSP already configured by another stream */
 		return 0;
 	}
@@ -312,7 +308,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	regs->xcr2	&= ~(RPHASE | XFRLEN2(0x7f) | XWDLEN2(7));
 	regs->rcr1	&= ~(RFRLEN1(0x7f) | RWDLEN1(7));
 	regs->xcr1	&= ~(XFRLEN1(0x7f) | XWDLEN1(7));
-	format = mcbsp_data->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
+	format = mcbsp->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
 	wpf = channels = params_channels(params);
 	if (channels == 2 && (format == SND_SOC_DAIFMT_I2S ||
 			      format == SND_SOC_DAIFMT_LEFT_J)) {
@@ -350,10 +346,10 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 
 	/* In McBSP master modes, FRAME (i.e. sample rate) is generated
 	 * by _counting_ BCLKs. Calculate frame size in BCLKs */
-	master = mcbsp_data->fmt & SND_SOC_DAIFMT_MASTER_MASK;
+	master = mcbsp->fmt & SND_SOC_DAIFMT_MASTER_MASK;
 	if (master ==	SND_SOC_DAIFMT_CBS_CFS) {
-		div = mcbsp_data->clk_div ? mcbsp_data->clk_div : 1;
-		framesize = (mcbsp_data->in_freq / div) / params_rate(params);
+		div = mcbsp->clk_div ? mcbsp->clk_div : 1;
+		framesize = (mcbsp->in_freq / div) / params_rate(params);
 
 		if (framesize < wlen * channels) {
 			printk(KERN_ERR "%s: not enough bandwidth for desired rate and "
@@ -379,9 +375,9 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	omap_mcbsp_config(mcbsp, &mcbsp_data->regs);
-	mcbsp_data->wlen = wlen;
-	mcbsp_data->configured = 1;
+	omap_mcbsp_config(mcbsp, &mcbsp->cfg_regs);
+	mcbsp->wlen = wlen;
+	mcbsp->configured = 1;
 
 	return 0;
 }
@@ -394,14 +390,13 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 				      unsigned int fmt)
 {
 	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
-	struct omap_mcbsp_data *mcbsp_data = &mcbsp->mcbsp_data;
-	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
+	struct omap_mcbsp_reg_cfg *regs = &mcbsp->cfg_regs;
 	bool inv_fs = false;
 
-	if (mcbsp_data->configured)
+	if (mcbsp->configured)
 		return 0;
 
-	mcbsp_data->fmt = fmt;
+	mcbsp->fmt = fmt;
 	memset(regs, 0, sizeof(*regs));
 	/* Generic McBSP register settings */
 	regs->spcr2	|= XINTM(3) | FREE;
@@ -497,13 +492,12 @@ static int omap_mcbsp_dai_set_clkdiv(struct snd_soc_dai *cpu_dai,
 				     int div_id, int div)
 {
 	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
-	struct omap_mcbsp_data *mcbsp_data = &mcbsp->mcbsp_data;
-	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
+	struct omap_mcbsp_reg_cfg *regs = &mcbsp->cfg_regs;
 
 	if (div_id != OMAP_MCBSP_CLKGDV)
 		return -ENODEV;
 
-	mcbsp_data->clk_div = div;
+	mcbsp->clk_div = div;
 	regs->srgr1	&= ~CLKGDV(0xff);
 	regs->srgr1	|= CLKGDV(div - 1);
 
@@ -515,12 +509,11 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 					 int dir)
 {
 	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
-	struct omap_mcbsp_data *mcbsp_data = &mcbsp->mcbsp_data;
-	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
+	struct omap_mcbsp_reg_cfg *regs = &mcbsp->cfg_regs;
 	int err = 0;
 
-	if (mcbsp_data->active) {
-		if (freq == mcbsp_data->in_freq)
+	if (mcbsp->active) {
+		if (freq == mcbsp->in_freq)
 			return 0;
 		else
 			return -EBUSY;
@@ -534,7 +527,7 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 		if (cpu_class_is_omap1() || cpu_dai->id != 1)
 			return -EINVAL;
 
-	mcbsp_data->in_freq = freq;
+	mcbsp->in_freq = freq;
 	regs->srgr2	&= ~CLKSM;
 	regs->pcr0	&= ~SCLKME;
 
-- 
1.7.8.4

