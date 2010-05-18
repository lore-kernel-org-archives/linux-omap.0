From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 3/4] ASoC: mcbsp - add machine threshold callback
Date: Tue, 18 May 2010 21:13:13 +0100
Message-ID: <1274213594-26554-4-git-send-email-lrg@slimlogic.co.uk>
References: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48480 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806Ab0ERUNx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 16:13:53 -0400
Received: by mail-wy0-f174.google.com with SMTP id 39so1699320wyb.19
        for <linux-omap@vger.kernel.org>; Tue, 18 May 2010 13:13:52 -0700 (PDT)
In-Reply-To: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>

Add a mechanism to register a machine specific callback
to calculate and set the McBSP Tx/Rx threshold.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/omap/omap-mcbsp.c |   22 +++++++++++++++++++++-
 sound/soc/omap/omap-mcbsp.h |    2 ++
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 6f44cb4..9a1583d 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -51,6 +51,9 @@ struct omap_mcbsp_data {
 	unsigned int			bus_id;
 	struct omap_mcbsp_reg_cfg	regs;
 	unsigned int			fmt;
+
+	/* optional machine set_threshold() sample value */
+	void (*mach_set_threshold)(struct snd_pcm_substream *substream);
 	/*
 	 * Flags indicating is the bus already activated and configured by
 	 * another substream
@@ -306,7 +309,11 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	} else if (cpu_is_omap343x()) {
 		dma = omap24xx_dma_reqs[bus_id][substream->stream];
 		port = omap34xx_mcbsp_port[bus_id][substream->stream];
-		omap_mcbsp_dai_dma_params[id][substream->stream].set_threshold =
+		if (mcbsp_data->mach_set_threshold)
+			omap_mcbsp_dai_dma_params[id][substream->stream].set_threshold =
+						mcbsp_data->mach_set_threshold;
+		else
+			omap_mcbsp_dai_dma_params[id][substream->stream].set_threshold =
 						omap_mcbsp_set_threshold;
 		/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
 		if (omap_mcbsp_get_dma_op_mode(bus_id) ==
@@ -835,6 +842,19 @@ int omap_mcbsp_st_add_controls(struct snd_soc_codec *codec, int mcbsp_id)
 }
 EXPORT_SYMBOL_GPL(omap_mcbsp_st_add_controls);
 
+int omap_bcbsp_set_threshold_func(struct snd_soc_dai *cpu_dai,
+		void (*mach_set_threshold)(struct snd_pcm_substream *substream))
+{
+	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
+
+	if (!cpu_is_omap34xx())
+		return -ENODEV;
+
+	mcbsp_data->mach_set_threshold = mach_set_threshold;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(omap_bcbsp_set_threshold_func);
+
 static int __init snd_omap_mcbsp_init(void)
 {
 	return snd_soc_register_dais(omap_mcbsp_dai,
diff --git a/sound/soc/omap/omap-mcbsp.h b/sound/soc/omap/omap-mcbsp.h
index 6c363e5..f8d8044 100644
--- a/sound/soc/omap/omap-mcbsp.h
+++ b/sound/soc/omap/omap-mcbsp.h
@@ -58,5 +58,7 @@ enum omap_mcbsp_div {
 extern struct snd_soc_dai omap_mcbsp_dai[NUM_LINKS];
 
 int omap_mcbsp_st_add_controls(struct snd_soc_codec *codec, int mcbsp_id);
+int omap_bcbsp_set_threshold_func(struct snd_soc_dai *cpu_dai,
+		void (*mach_set_threshold)(struct snd_pcm_substream *substream));
 
 #endif
-- 
1.7.0.4

