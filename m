From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/8] ASoC: TPA6130A2 amplifier driver
Date: Thu, 8 Oct 2009 13:52:13 +0100
Message-ID: <20091008125213.GA29176@rakim.wolfsonmicro.main>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
 <1255003137-1034-2-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:55781 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757853AbZJHMwv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 08:52:51 -0400
Content-Disposition: inline
In-Reply-To: <1255003137-1034-2-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>

On Thu, Oct 08, 2009 at 02:58:50PM +0300, Eduardo Valentin wrote:

> +struct tpa6130a2_platform_data {
> +	int (*set_power)(int state);
> +};

Why is this a callback and not just a GPIO number?  That'd seem simpler
for users.

> +int tpa6130a2_add_controls(struct snd_soc_codec *codec)
> +{
> +	snd_soc_dapm_new_controls(codec, tpa6130a2_dapm_widgets,
> +				ARRAY_SIZE(tpa6130a2_dapm_widgets));
> +
> +	return snd_soc_add_controls(codec, tpa6130a2_controls,
> +				ARRAY_SIZE(tpa6130a2_controls));
> +
> +}
> +EXPORT_SYMBOL(tpa6130a2_add_controls);

All the ASoC APIs are EXPORT_SYMBOL_GPL().

> +	pdata = (struct tpa6130a2_platform_data *)client->dev.platform_data;
> +	/* Set default register values */
> +	data->regs[TPA6130A2_REG_CONTROL] = TPA6130A2_SWS |
> +					    TPA6130A2_HP_EN_R |
> +					    TPA6130A2_HP_EN_L;

This looks like you could implement stereo paths with individual power
control?

> +	data->regs[TPA6130A2_REG_VOL_MUTE] = TPA6130A2_VOLUME(20);

The standard thing is to use hardware defaults and leave decisions like
this up to user space.

> +	data->set_power = pdata->set_power;
> +	if (!pdata->set_power) {
> +		data->power_state = 1;
> +		tpa6130a2_initialize();
> +	}
> +	tpa6130a2_power(1);
> +
> +	/* Read version */
> +	err = tpa6130a2_i2c_read(TPA6130A2_REG_VERSION) &
> +				 TPA6130A2_VERSION_MASK;
> +	if ((err != 1) && (err != 2)) {
> +		dev_err(dev, "Unexpected headphone amplifier chip version "
> +		       "of 0x%02x, was expecting 0x01 or 0x02\n", err);
> +		err = -ENODEV;

This seems a bit excessive - is it really likely that the register map
would be changed incompatibly in a future version?
