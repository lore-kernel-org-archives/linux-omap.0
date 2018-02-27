From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv5 2/5] ASoC: codec: cpcap: new codec
Date: Tue, 27 Feb 2018 11:03:15 +0000
Message-ID: <20180227110315.GB11822@sirena.org.uk>
References: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
 <20180223200254.25685-3-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180223200254.25685-3-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 23, 2018 at 09:02:51PM +0100, Sebastian Reichel wrote:

> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +		val |= BIT(CPCAP_BIT_ST_DIG_AUD_FS0);
> +		val |= BIT(CPCAP_BIT_ST_DIG_AUD_FS1);
> +		break;
> +	default:
> +		/* 01 - 4 slots network mode */
> +		val |= BIT(CPCAP_BIT_ST_DIG_AUD_FS0);
> +		val &= ~BIT(CPCAP_BIT_ST_DIG_AUD_FS1);
> +		/* L on slot 1 */
> +		val |= BIT(CPCAP_BIT_ST_L_TIMESLOT0);
> +		break;
> +	}

The default case here is really one specific mode, it looks like it's
either DSP_A or DSP_B.  Most likely DSP_A but you should check.
Otherwise this looks good so I'll apply it, please send a followup patch
fixing this to match only the specific mode that's actually supported.

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqVOvIACgkQJNaLcl1U
h9DYbwf7BcnQly6YhUxqDK9VVhh77y0p1LW+LHXuIKaGjAzvy7b2LIvkkgSwOvEM
zvKR7VU+wC22mEBj8WVBeGv4/tVTziH8N4/8q5n2vrg+TKSkvsGdniiifw2080hA
IV2fkLXQRyoZLuACBXSQzapwsFdI+UoRDERJ9HDuENitog1sddFMGgV+spzT/gZO
LSkEpODQBp5MRvgFZY+kdplq+z1Mi1tDiZ2ZYFRsEtcStVr5zgwCE4gDw5tJxIxT
01NWyKtlvDq6+OHdstA5qGuxTtFEY7Xccjezbyg4Yn1LWrrdsXXM7mLjTjnX7g04
k3RpsBb5rjLLTJ0QSj4WxOFzrsdATQ==
=YQU8
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
