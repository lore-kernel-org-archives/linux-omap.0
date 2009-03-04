From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/2] ASoC: Add headset jack detection for SDP3430
	machine driver
Date: Wed, 4 Mar 2009 19:07:17 +0000
Message-ID: <20090304190716.GB6420@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705ECD6E1B6@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:4564 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbZCDTHk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 14:07:40 -0500
Content-Disposition: inline
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705ECD6E1B6@dlee07.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Mar 04, 2009 at 11:39:12AM -0600, Lopez Cruz, Misael wrote:

> +/* Headset jack */
> +struct snd_soc_jack *hs_jack;

This (and all your other globals) should be declared static.

> +/* Headset jack DAPM pins */
> +struct snd_soc_jack_pin hs_jack_pins[] = {
> +	{
> +		.pin = "Headset Jack",
> +		.mask = SND_JACK_HEADSET,
> +		.invert = 0,
> +	},
> +};

No need to initialise things to zero, that's the default for static
variables.

> +	/* Headset jack detection */
> +	hs_jack = kzalloc(sizeof(struct snd_soc_jack), GFP_KERNEL);
> +	if (!hs_jack)
> +		return -ENOMEM;

If you declare hs_jack as a direct static variable you won't need to
kzalloc() it and save some error checking and cleanup code too :)

> +	ret = snd_soc_jack_new(&snd_soc_sdp3430, "SDP3430 headset jack",
> +				SND_JACK_HEADSET, hs_jack);
> +	if (ret)
> +		return ret;

This leaks the jack.
