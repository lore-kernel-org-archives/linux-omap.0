From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: [PATCH] ASoC: AM3517: Fix AIC23 suspend/resume hang
Date: Thu, 26 Nov 2009 08:31:11 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030AAC2F86@dbde02.ent.ti.com>
References: <1259154631-15251-1-git-send-email-anuj.aggarwal@ti.com>
	<4B0D9212.1060805@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4B0D9212.1060805@boundarydevices.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Troy Kisky' <troy.kisky@boundarydevices.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Arun KS <arunks@mistralsolutions.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Troy Kisky [mailto:troy.kisky@boundarydevices.com]
> Sent: Thursday, November 26, 2009 1:53 AM
> To: Aggarwal, Anuj
> Cc: alsa-devel@alsa-project.org; linux-omap@vger.kernel.org; Mark Brown;
> Arun KS
> Subject: Re: [alsa-devel] [PATCH] ASoC: AM3517: Fix AIC23 suspend/resume
> hang
> 
> Anuj Aggarwal wrote:
> > System hang is observed While trying to do suspend. It was because
> > of an infinite loop in the AIC23 resume path which was trying to
> > restore AIC23 register values from the register cache.
> >
> > This patch fixes the problem by correcting the resume path and
> > properly activating/deactivating the digital interface while
> > doing the suspend / off transitions.
> >
> > Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> > ---
> >  sound/soc/codecs/tlv320aic23.c |   16 +++-------------
> >  1 files changed, 3 insertions(+), 13 deletions(-)
> >
> > diff --git a/sound/soc/codecs/tlv320aic23.c
> b/sound/soc/codecs/tlv320aic23.c
> > index 6b24d8b..cabe60c 100644
> > --- a/sound/soc/codecs/tlv320aic23.c
> > +++ b/sound/soc/codecs/tlv320aic23.c
> > @@ -565,13 +565,12 @@ static int tlv320aic23_set_bias_level(struct
> snd_soc_codec *codec,
> >  	case SND_SOC_BIAS_PREPARE:
> >  		break;
> >  	case SND_SOC_BIAS_STANDBY:
> > -		/* everything off except vref/vmid, */
> > -		tlv320aic23_write(codec, TLV320AIC23_PWR, reg | 0x0040);
> > +		/* Activate the digital interface */
> > +		tlv320aic23_write(codec, TLV320AIC23_ACTIVE, 0x1);
> >  		break;
> >  	case SND_SOC_BIAS_OFF:
> > -		/* everything off, dac mute, inactive */
> > +		/* Deactivate the digital interface */
> >  		tlv320aic23_write(codec, TLV320AIC23_ACTIVE, 0x0);
> > -		tlv320aic23_write(codec, TLV320AIC23_PWR, 0xffff);
> >  		break;
> >  	}
> >  	codec->bias_level = level;
> > @@ -615,7 +614,6 @@ static int tlv320aic23_suspend(struct
> platform_device *pdev,
> >  	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> >  	struct snd_soc_codec *codec = socdev->card->codec;
> >
> > -	tlv320aic23_write(codec, TLV320AIC23_ACTIVE, 0x0);
> >  	tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_OFF);
> >
> >  	return 0;
> > @@ -625,14 +623,6 @@ static int tlv320aic23_resume(struct
> platform_device *pdev)
> >  {
> >  	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> >  	struct snd_soc_codec *codec = socdev->card->codec;
> > -	int i;
> > -	u16 reg;
> > -
> > -	/* Sync reg_cache with the hardware */
> > -	for (reg = 0; reg < ARRAY_SIZE(tlv320aic23_reg); i++) {
> > -		u16 val = tlv320aic23_read_reg_cache(codec, reg);
> > -		tlv320aic23_write(codec, reg, val);
> > -	}
> 
> Changing to
> 	for (reg = 0; reg < ARRAY_SIZE(tlv320aic23_reg); reg++) {
> 
> should be enough to fix the infinite loop.
> Could you try this without the rest of the patch?
I have already tried that but it doesn't fix the problem entirely.
Still, I was not able to playback properly because the bias settings
were not handled correctly and as you can see, it writes to some 
invalid registers too (all registers don't exist between 0 and ARRAY_SIZE).
> 
> >
> >  	tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> >  	tlv320aic23_set_bias_level(codec, codec->suspend_bias_level);
> 
> Adding Arun to cc list
