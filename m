From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Date: Mon, 10 Dec 2018 21:35:36 -0800
Message-ID: <20181211053536.GJ6707@atomide.com>
References: <20181211020557.61783-1-tony@atomide.com>
 <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
 <20181211045220.GI6707@atomide.com>
 <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

* Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [181211 05:16]:
> 
> Hi Tony
> 
> > > This looks a little bit strange for me.
> > > Can you show me your DT for it ?
> > 
> > Sure, adding also Sebastian to Cc. Here's what I currently have for droid 4
> > dts with two codecs on I2S. Please just ignore the GNSS parts there..
> > 
> > The TDM configuration is all done in the cpcap_audio_codec via set_tdm_slot().
> > The modem voice call codec is a serdev driver :) I'll need some more time to
> > be able to post patches but it's basically working for voice calls.
> 
> Hmm... it seems strange...
> I guess you are using "ti,omap4-mcbsp" driver (= linux/sound/soc/omap/omap-mcbsp.c)
> Is this correct ?

Yes.

> If so, your driver is registering component as
> 
> 	ret = devm_snd_soc_register_component(&pdev->dev,
> 					      &omap_mcbsp_component,
> 					      &omap_mcbsp_dai, 1);
> 
> Your driver has only 1 DAI.

Yes I have a patch for omap-mcbsp.c too :)

> >  	mcbsp3_port: port {
> > -		cpu_dai3: endpoint {
> > +		cpu_dai3: endpoint@0 {
> >  			dai-format = "dsp_a";
> >  			frame-master = <&cpcap_audio_codec1>;
> >  			bitclock-master = <&cpcap_audio_codec1>;
> >  			remote-endpoint = <&cpcap_audio_codec1>;
> >  		};
> > +		cpu_dai_mdm: endpoint@1 {
> > +			dai-format = "dsp_a";
> > +			frame-master = <&cpcap_audio_codec1>;
> > +			bitclock-master = <&cpcap_audio_codec1>;
> > +			remote-endpoint = <&mot_mdm6600_audio_codec0>;
> > +		};
> 
> And here, you have 1 port, 2 endpoint.
> Then, asoc_simple_card_get_dai_id() should return 1.
> 
> And, your [2/2] patch,
> I guess you are misunderstanding about "port" vs "endpoint",
> or omap-mcbsp driver side need to update ?

Yes omap-mcbsp driver needs to be updated for multiple endpoints.

Adding Jarkko and Peter also to Cc, below is the WIP patch that I'm
currently using for omap-mcbsp to add more DAIs.

So far nothing else to do in the omap-mcbsp as it's the cpcap hardware
that configures the TDM timeslots. And I'm currently assuming the
first instance is the master, I guess that should be parsed from the
the frame-master dts property instead.

Regards,

Tony

8< ----------------------
diff --git a/sound/soc/omap/omap-mcbsp-priv.h b/sound/soc/omap/omap-mcbsp-priv.h
--- a/sound/soc/omap/omap-mcbsp-priv.h
+++ b/sound/soc/omap/omap-mcbsp-priv.h
@@ -262,6 +262,8 @@ struct omap_mcbsp {
 	struct omap_mcbsp_platform_data *pdata;
 	struct omap_mcbsp_st_data *st_data;
 	struct omap_mcbsp_reg_cfg cfg_regs;
+	struct snd_soc_dai_driver *dais;
+	int dai_count;
 	struct snd_dmaengine_dai_dma_data dma_data[2];
 	unsigned int dma_req[2];
 	int dma_op_mode;
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -28,6 +28,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_graph.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -1318,23 +1319,53 @@ static int omap_mcbsp_remove(struct snd_soc_dai *dai)
 	return 0;
 }
 
-static struct snd_soc_dai_driver omap_mcbsp_dai = {
-	.probe = omap_mcbsp_probe,
-	.remove = omap_mcbsp_remove,
-	.playback = {
-		.channels_min = 1,
-		.channels_max = 16,
-		.rates = OMAP_MCBSP_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
-	},
-	.capture = {
-		.channels_min = 1,
-		.channels_max = 16,
-		.rates = OMAP_MCBSP_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
-	},
-	.ops = &mcbsp_dai_ops,
-};
+static int omap_mcbsp_init_dais(struct omap_mcbsp *mcbsp)
+{
+	struct device_node *np = mcbsp->dev->of_node;
+	int i;
+
+	if (np)
+		mcbsp->dai_count = of_graph_get_endpoint_count(np);
+
+	if (!mcbsp->dai_count)
+		mcbsp->dai_count = 1;
+
+	mcbsp->dais = devm_kcalloc(mcbsp->dev, mcbsp->dai_count,
+				   sizeof(*mcbsp->dais), GFP_KERNEL);
+	if (!mcbsp->dais)
+		return -ENOMEM;
+
+	for (i = 0; i < mcbsp->dai_count; i++) {
+		struct snd_soc_dai_driver *dai = &mcbsp->dais[i];
+
+		dai->name = devm_kasprintf(mcbsp->dev, GFP_KERNEL, "%s-dai%i",
+					   dev_name(mcbsp->dev), i);
+
+		if (i == 0) {
+			dai->probe = omap_mcbsp_probe;
+			dai->remove = omap_mcbsp_remove;
+			dai->ops = &mcbsp_dai_ops;
+		}
+		dai->playback.channels_min = 1;
+		dai->playback.channels_max = 16;
+		dai->playback.rates = OMAP_MCBSP_RATES;
+		if (mcbsp->pdata->reg_size == 2)
+			dai->playback.formats = SNDRV_PCM_FMTBIT_S16_LE;
+		else
+			dai->playback.formats = SNDRV_PCM_FMTBIT_S16_LE |
+						SNDRV_PCM_FMTBIT_S32_LE;
+		dai->capture.channels_min = 1;
+		dai->capture.channels_max = 16;
+		dai->capture.rates = OMAP_MCBSP_RATES;
+		if (mcbsp->pdata->reg_size == 2)
+			dai->capture.formats = SNDRV_PCM_FMTBIT_S16_LE;
+		else
+			dai->capture.formats = SNDRV_PCM_FMTBIT_S16_LE |
+					       SNDRV_PCM_FMTBIT_S32_LE;
+	}
+
+	return 0;
+}
 
 static const struct snd_soc_component_driver omap_mcbsp_component = {
 	.name		= "omap-mcbsp",
@@ -1423,18 +1454,17 @@ static int asoc_mcbsp_probe(struct platform_device *pdev)
 	mcbsp->dev = &pdev->dev;
 	platform_set_drvdata(pdev, mcbsp);
 
-	ret = omap_mcbsp_init(pdev);
+	ret = omap_mcbsp_init_dais(mcbsp);
 	if (ret)
 		return ret;
 
-	if (mcbsp->pdata->reg_size == 2) {
-		omap_mcbsp_dai.playback.formats = SNDRV_PCM_FMTBIT_S16_LE;
-		omap_mcbsp_dai.capture.formats = SNDRV_PCM_FMTBIT_S16_LE;
-	}
+	ret = omap_mcbsp_init(pdev);
+	if (ret)
+		return ret;
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &omap_mcbsp_component,
-					      &omap_mcbsp_dai, 1);
+					      mcbsp->dais, mcbsp->dai_count);
 	if (ret)
 		return ret;
 
