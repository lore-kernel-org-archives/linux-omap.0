From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC] [PATCH] ASoC: OMAP: full duplex mode fix
Date: Wed, 5 Aug 2009 11:42:54 +0300
Message-ID: <20090805114254.02e3d0e2.jhnikula@gmail.com>
References: <200908030332.06727.jkrzyszt@tis.icnet.pl>
	<4A76ED80.6040001@tis.icnet.pl>
	<20090803181405.6249b843.jhnikula@gmail.com>
	<200908042246.09919.jkrzyszt@tis.icnet.pl>
	<20090805102149.bfcafa35.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:54191 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933485AbZHEIlo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 04:41:44 -0400
Received: by ewy10 with SMTP id 10so948600ewy.37
        for <linux-omap@vger.kernel.org>; Wed, 05 Aug 2009 01:41:44 -0700 (PDT)
In-Reply-To: <20090805102149.bfcafa35.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Arun K S <arunks@mistralsolutions.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Wed, 5 Aug 2009 10:21:49 +0300
Jarkko Nikula <jhnikula@gmail.com> wrote:

> > If my analysis is correct, the best solution I can see would be starting McBSP 
> > transfer for one direction only, not both, so the opposite direction can be 
> > started when needed. That requires deeper and wider OMAP knowledge and a 
> > change in omap_mcbsp_start() API though. I am not in a position to deal with 
> > this myself, I'm afraid.
> > 
> I favor this change. Actually I remember I was thinking shortly to
> change API of omap_mcbsp_start and _stop more than year back or so but
> didn't find it necessary back then.
> 
> I think change will be trivial. Basically two new arguments indicating
> are the TX/RX active and let the first/last caller to deal with
> sample-rate generator and frame sync activation/de-activation.
> 
I hacked a patch below. Can you test does it help?

-- 
Jarkko

--- 
diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index bb154ea..57249bb 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -387,8 +387,8 @@ void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
 void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg * config);
 int omap_mcbsp_request(unsigned int id);
 void omap_mcbsp_free(unsigned int id);
-void omap_mcbsp_start(unsigned int id);
-void omap_mcbsp_stop(unsigned int id);
+void omap_mcbsp_start(unsigned int id, int tx, int rx);
+void omap_mcbsp_stop(unsigned int id, int tx, int rx);
 void omap_mcbsp_xmit_word(unsigned int id, u32 word);
 u32 omap_mcbsp_recv_word(unsigned int id);
 
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index efa0e01..d7645b3 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -328,14 +328,15 @@ void omap_mcbsp_free(unsigned int id)
 EXPORT_SYMBOL(omap_mcbsp_free);
 
 /*
- * Here we start the McBSP, by enabling the sample
- * generator, both transmitter and receivers,
- * and the frame sync.
+ * Here we start the McBSP, by enabling transmitter, receiver or both.
+ * If no transmitter or receiver is active prior calling, then sample-rate
+ * generator and frame sync are started.
  */
-void omap_mcbsp_start(unsigned int id)
+void omap_mcbsp_start(unsigned int id, int tx, int rx)
 {
 	struct omap_mcbsp *mcbsp;
 	void __iomem *io_base;
+	int idle;
 	u16 w;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
@@ -348,32 +349,40 @@ void omap_mcbsp_start(unsigned int id)
 	mcbsp->rx_word_length = (OMAP_MCBSP_READ(io_base, RCR1) >> 5) & 0x7;
 	mcbsp->tx_word_length = (OMAP_MCBSP_READ(io_base, XCR1) >> 5) & 0x7;
 
-	/* Start the sample generator */
-	w = OMAP_MCBSP_READ(io_base, SPCR2);
-	OMAP_MCBSP_WRITE(io_base, SPCR2, w | (1 << 6));
+	idle = !((OMAP_MCBSP_READ(io_base, SPCR2) |
+		OMAP_MCBSP_READ(io_base, SPCR1)) & 1);
+
+	if (idle) {
+		/* Start the sample generator */
+		w = OMAP_MCBSP_READ(io_base, SPCR2);
+		OMAP_MCBSP_WRITE(io_base, SPCR2, w | (1 << 6));
+	}
 
 	/* Enable transmitter and receiver */
 	w = OMAP_MCBSP_READ(io_base, SPCR2);
-	OMAP_MCBSP_WRITE(io_base, SPCR2, w | 1);
+	OMAP_MCBSP_WRITE(io_base, SPCR2, w | (tx & 1));
 
 	w = OMAP_MCBSP_READ(io_base, SPCR1);
-	OMAP_MCBSP_WRITE(io_base, SPCR1, w | 1);
+	OMAP_MCBSP_WRITE(io_base, SPCR1, w | (rx & 1));
 
 	udelay(100);
 
-	/* Start frame sync */
-	w = OMAP_MCBSP_READ(io_base, SPCR2);
-	OMAP_MCBSP_WRITE(io_base, SPCR2, w | (1 << 7));
+	if (idle) {
+		/* Start frame sync */
+		w = OMAP_MCBSP_READ(io_base, SPCR2);
+		OMAP_MCBSP_WRITE(io_base, SPCR2, w | (1 << 7));
+	}
 
 	/* Dump McBSP Regs */
 	omap_mcbsp_dump_reg(id);
 }
 EXPORT_SYMBOL(omap_mcbsp_start);
 
-void omap_mcbsp_stop(unsigned int id)
+void omap_mcbsp_stop(unsigned int id, int tx, int rx)
 {
 	struct omap_mcbsp *mcbsp;
 	void __iomem *io_base;
+	int idle;
 	u16 w;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
@@ -386,15 +395,20 @@ void omap_mcbsp_stop(unsigned int id)
 
 	/* Reset transmitter */
 	w = OMAP_MCBSP_READ(io_base, SPCR2);
-	OMAP_MCBSP_WRITE(io_base, SPCR2, w & ~(1));
+	OMAP_MCBSP_WRITE(io_base, SPCR2, w & ~(tx & 1));
 
 	/* Reset receiver */
 	w = OMAP_MCBSP_READ(io_base, SPCR1);
-	OMAP_MCBSP_WRITE(io_base, SPCR1, w & ~(1));
+	OMAP_MCBSP_WRITE(io_base, SPCR1, w & ~(rx & 1));
 
-	/* Reset the sample rate generator */
-	w = OMAP_MCBSP_READ(io_base, SPCR2);
-	OMAP_MCBSP_WRITE(io_base, SPCR2, w & ~(1 << 6));
+	idle = !((OMAP_MCBSP_READ(io_base, SPCR2) |
+		OMAP_MCBSP_READ(io_base, SPCR1)) & 1);
+
+	if (idle) {
+		/* Reset the sample rate generator */
+		w = OMAP_MCBSP_READ(io_base, SPCR2);
+		OMAP_MCBSP_WRITE(io_base, SPCR2, w & ~(1 << 6));
+	}
 }
 EXPORT_SYMBOL(omap_mcbsp_stop);
 
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index a5d46a7..9368bca 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -183,21 +183,21 @@ static int omap_mcbsp_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
-	int err = 0;
+	int err = 0, play = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (!mcbsp_data->active++)
-			omap_mcbsp_start(mcbsp_data->bus_id);
+		mcbsp_data->active++;
+		omap_mcbsp_start(mcbsp_data->bus_id, play, !play);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		if (!--mcbsp_data->active)
-			omap_mcbsp_stop(mcbsp_data->bus_id);
+		mcbsp_data->active--;
+		omap_mcbsp_stop(mcbsp_data->bus_id, play, !play);
 		break;
 	default:
 		err = -EINVAL;
