From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
Date: Wed, 28 Mar 2018 18:45:07 -0700
Message-ID: <20180329014507.GM5700@atomide.com>
References: <20180322204804.GA26871@amd>
 <20180322234832.o24ut5ahon46mdu4@earth.universe>
 <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
 <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180328140219.f6667up5evrrafkv@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Dan Williams <dcbw@redhat.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [180328 14:03]:
> Hi,
> 
> On Wed, Mar 28, 2018 at 10:29:10AM +0800, Mark Brown wrote:
> > On Wed, Mar 28, 2018 at 12:22:37AM +0200, Sebastian Reichel wrote:
> > > On Tue, Mar 27, 2018 at 08:14:41PM +0800, Mark Brown wrote:
> > 
> > > > No, this is exactly the sort of use case with multiple DAIs that the
> > > > graph card is intended to enable over the old simple-card.
> > 
> > > +----------+         +-------------+
> > > | OMAP4    |         | CPCAP       |
> > > |          |         |             |
> > > | [McBSP2] | <-----> | [HiFi DAI]  |
> > > |          |         |             |
> > > | [McBSP3] | <--+--> | [Voice DAI] |
> > > |          |    |    |             |
> > > +----------+    |    +-------------+
> > >                 |
> > > +----------+    |    +-------------+
> > > | MDM6600  |    |    | WL1285      |
> > > |          |    |    |             |
> > > |    [DAI] | <--+--> | [DAI]       |
> > > |          |         |             |
> > > +----------+         +-------------+
> > 
> > > Legend:
> > >     OMAP4   = SoC running Linux
> > >     CPCAP   = Audio codec
> > >     MDM6600 = Baseband
> > >     WL1285  = Bluetooth
> > 
> > > Re-reading the audio-graph-card binding document I still don't see
> > > how the network (OMAP.McBSP3, CPCAP.Voice, MDM6600, WL1285) is
> > > supposed to look like. It seems to expect point-to-point DAI
> > > connections.
> > 
> > Ugh, a TDM mux?
> 
> Yes, at least that's how I understood Motorola's code.

Hmm is there some active component doing the muxing then?
Maybe the "AT+CMUT=0" part below?

> > That's really unusual and not particularly supported yet, you'd
> > need to extend the graph card to do it.  It's where things should
> > end up for a generic card though.
> 
> Motorola's driver provided the following modes:
> 
> OMAP4 <-> CPCAP      (voice recording)
> MDM6600 <-> CPCAP    (voice call, CPU not involved)
> OMAP4 <-> WL1285     (bluetooth HFP/HSP)
> MDM6600 <-> WL1285   (bluetooth voice call)
> 
> In case of the last two variants, the bus clock is provided by
> CPCAP, so it needs to be enabled for any audio stream. I suppose
> the codec <-> codec as part of TDM is out of scope for the graph
> card and we need a Droid 4 specific card driver?

Hmm well I got audio call hacked to work as a proof of concept hack,
see below. Maybe it can be used to verify some of the assumptions
above.

Then.. To split the work a bit, can you guys maybe try to decode
the cpcap register values and try to do a proper ASoC driver patch?

Meanwhile, I can try to make voice calls more reproducable with
qmi or MM for example instead of just n_gsm.. And then I'll try
to fix my n_gsm pile of hacks for posting..

Cheers,

Tony

8< --------------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 28 Mar 2018 08:29:38 -0700
Subject: [PATCH] NOT FOR MERGING: Quick hack for droid 4 mdm6600 voice
 call

Here's quick hack to allow making a voice call on mdm6600 based on
diffing the cpcap registers in Android. The patch just keeps overwriting
the cpcap values every second so it's nowhere near usable for merging,
just a test patch.

Looks like the cpcap register changes during a speaker phone audio call are:

@@ -510,17 +510,17 @@
 07f4: 0000
 07f8: 0000
 07fc: 0000
-0800: 0065
-0804: 0000
-0808: 0040
+0800: 0025     # CPCAP_REG_VAUDIOC     VAUDIO Control
+0804: 60cf     # CPCAP_REG_CC          Codec Control, moto cpcap.c:1337 sets 0x0093?
+0808: ae0a     # CPCAP_REG_CDI         Codec Digital Interface
 080c: 0000
 0810: 0004
-0814: 0804
-0818: 079c
-081c: 0000
-0820: 0924
-0824: 0000
-0828: 0000
+0814: 0cc0     # CPCAP_REG_TXI         TX Inputs, moto cpcap.c:1340 sets 0x0CC6?
+0818: 0610     # CPCAP_REG_TXMP        TX MIC PGA's, moto cpcap.c:1343 sets 0x0273?
+081c: 0006     # CPCAP_REG_RXOA        RX Output Amplifiers
+0820: 0b2c     # CPCAP_REG_RXVC        RX Volume Control
+0824: 0606     # CPCAP_REG_RXCOA       RX Codec to Output Amps
+0828: 0600     # CPCAP_REG_RXSDOA      RX Stereo DAC to Output Amps
 082c: 0400
 0830: 0000
 0834: 0030

I wonder if mdm6600 is the i2s master during the voice call?

Then using the n_gsm ts 27.010 uart mux, I dial:

./ngsm-rw 1 "AT+CFUN=1"		# connect to network
U0001+CFUN:OK
./ngsm-rw 2 "AT+CMUT=0"		# unmute speaker over ch2, do this over qmi?
U0001+CMUT:OK
./ngsm-rw 1 "ATD#123"		# dial number
U0001D:OK

And I do hear a voice talking over the speakerphone :) Sorry have not tested the
mic yet..

FYI, the ngsm-rw script I use is just:

#!/bin/sh

if [ "${1}" == "" ]; then
        echo "Usage: $0 port command"
        exit 1
fi

port=${1}
command=${2}

exec 3<>/dev/gsmtty${port}
printf "U0001%s\r\0" ${command} >&3
read result <&3
exec 3>&-
exec 3<&-

echo ${result}

My n_gsm patches are not quite ready yet sorry.. But meanwhile hopefully this
can be somehow also done using qmi. At least "AT+CMUT=0" fails over ttyUSB4.
---
 sound/soc/codecs/cpcap.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cpcap.c b/sound/soc/codecs/cpcap.c
--- a/sound/soc/codecs/cpcap.c
+++ b/sound/soc/codecs/cpcap.c
@@ -251,6 +251,8 @@ struct cpcap_audio {
 	int codec_clk_id;
 	int codec_freq;
 	int codec_format;
+
+	struct delayed_work work;
 };
 
 static int cpcap_st_workaround(struct snd_soc_dapm_widget *w,
@@ -1500,6 +1502,57 @@ static int cpcap_audio_reset(struct snd_soc_component *component,
 	return 0;
 }
 
+static void cpcap_soc_work(struct work_struct *work)
+{
+	struct cpcap_audio *cpcap = container_of(work,
+						 struct cpcap_audio,
+						 work.work);
+	struct device *dev = cpcap->component->dev;
+	int error;
+
+	dev_info(dev, "Somebody do a proper driver please %s\n", __func__);
+
+	error = regmap_update_bits(cpcap->regmap, CPCAP_REG_VAUDIOC,
+				   0xffff, 0x0025);
+	if (error)
+		goto out;
+	error = regmap_update_bits(cpcap->regmap, CPCAP_REG_CC,
+				   0xffff, 0x60cf);
+	if (error)
+		goto out;
+	error = regmap_update_bits(cpcap->regmap, CPCAP_REG_CDI,
+				   0xffff, 0xae0a);
+	if (error)
+		goto out;
+	error = regmap_update_bits(cpcap->regmap, CPCAP_REG_TXI,
+				   0xffff, 0x0cc0);
+	if (error)
+		goto out;
+	error = regmap_update_bits(cpcap->regmap, CPCAP_REG_TXMP,
+				   0xffff, 0x0610);
+	if (error)
+		goto out;
+	error = regmap_update_bits(cpcap->regmap, CPCAP_REG_RXOA,
+				   0xffff, 0x0006);
+	if (error)
+		goto out;
+	error = regmap_update_bits(cpcap->regmap, CPCAP_REG_RXVC,
+				   0xffff, 0x0b2c);
+	if (error)
+		goto out;
+	error = regmap_update_bits(cpcap->regmap, CPCAP_REG_RXCOA,
+				   0xffff, 0x0606);
+	if (error)
+		goto out;
+	error = regmap_update_bits(cpcap->regmap, CPCAP_REG_RXSDOA,
+				   0xffff, 0x0600);
+	if (error)
+		goto out;
+
+out:
+	schedule_delayed_work(&cpcap->work, msecs_to_jiffies(1000));
+}
+
 static int cpcap_soc_probe(struct snd_soc_component *component)
 {
 	struct cpcap_audio *cpcap;
@@ -1520,11 +1573,26 @@ static int cpcap_soc_probe(struct snd_soc_component *component)
 	if (err)
 		return err;
 
-	return cpcap_audio_reset(component, false);
+	err = cpcap_audio_reset(component, false);
+	if (err)
+		return err;
+
+	INIT_DELAYED_WORK(&cpcap->work, cpcap_soc_work);
+	schedule_delayed_work(&cpcap->work, msecs_to_jiffies(1000));
+
+	return 0;
+}
+
+static void cpcap_soc_remove(struct snd_soc_component *component)
+{
+	struct cpcap_audio *cpcap = snd_soc_component_get_drvdata(component);
+
+	cancel_delayed_work_sync(&cpcap->work);
 }
 
 static struct snd_soc_component_driver soc_codec_dev_cpcap = {
 	.probe			= cpcap_soc_probe,
+	.remove			= cpcap_soc_remove,
 	.controls		= cpcap_snd_controls,
 	.num_controls		= ARRAY_SIZE(cpcap_snd_controls),
 	.dapm_widgets		= cpcap_dapm_widgets,
-- 
2.16.3
