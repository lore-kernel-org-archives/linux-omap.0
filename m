From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv4 5/7] ASoC: TWL6030: Add restrictions for low-power
 playback mode
Date: Wed, 24 Feb 2010 13:53:38 +0000
Message-ID: <20100224135338.GQ18896@rakim.wolfsonmicro.main>
References: <1889FA7136B567478A67D4B0F85B0CCE65DD1B17@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:44709 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757104Ab0BXNxk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Feb 2010 08:53:40 -0500
Content-Disposition: inline
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCE65DD1B17@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

On Tue, Feb 23, 2010 at 06:10:42PM -0600, Olaya, Margarita wrote:

> Currently, handsfree DAC and driver are the only components that can
> prevent codec to enter to low-power playback mode. Other components
> like earphone driver, vibrator driver or loopback (which are not yet
> supported in the driver) can cause the same effect.

Hrm, this vibrator is raising a red flag for me with the MFD patch - it
sounds like we'll need to have an equivalent of the twl4030-codec MFD
for the TWL6030 to support the vibrator since that doesn't fit within
the audio subsystem.

> In order to detect conflicting paths, CODEC driver supervises
> non-low-power widgets powered by DAPM mechanism, just at the point
> pcm trigger callback gets called.

> +static int twl6030_power_mode_event(struct snd_soc_dapm_widget *w,
> +			struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = w->codec;
> +	struct twl6030_data *priv = codec->private_data;
> +
> +	if (SND_SOC_DAPM_EVENT_ON(event))
> +		priv->non_lp++;
> +	else
> +		priv->non_lp--;
> +
> +	return 0;
> +}

So what happens if we're already in low power mode and non_lp gets set
(or conversely but less seriously, if we get to the point where we can
enter low power mode)?

> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +		/*
> +		 * low-power playback mode is restricted
> +		 * for headset path only
> +		 */
> +		if ((priv->sysclk == 17640000) && priv->non_lp) {
> +			dev_err(codec->dev,
> +				"some enabled paths aren't supported at %dHz\n",
> +				priv->sysclk);
> +			return -EPERM;
> +		}
> +		break;

Should probably do this for all the startup trigger sources - _RESUME
for example.
