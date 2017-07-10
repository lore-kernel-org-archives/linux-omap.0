From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] regulator: cpcap: Fix standby mode
Date: Mon, 10 Jul 2017 13:23:45 +0100
Message-ID: <20170710122345.i7q2z7sbjhsthn5g@sirena.org.uk>
References: <20170707200813.20371-1-sebastian.reichel@collabora.co.uk>
 <20170707200813.20371-2-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wvlmgvojcjj5o6al"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170707200813.20371-2-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--wvlmgvojcjj5o6al
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 07, 2017 at 10:08:12PM +0200, Sebastian Reichel wrote:

> While working on the audio-codec I noticed, that the
> low power mode of the regulators are not properly
> supported. This fixes the issue for vaudio.

In what way is it not properly supported and how does this change ensure
that it is properly supported?

> +static unsigned int cpcap_map_mode(unsigned int mode)
> +{
> +	switch (mode) {
> +	case CPCAP_BIT_AUDIO_LOW_PWR:
> +		return REGULATOR_MODE_STANDBY;
> +	default:
> +		return REGULATOR_MODE_NORMAL;
> +	}
> +}

This function is being added but is never referenced AFAICT, it should
either be removed or used.  If it is being used it should be changed so
that it doesn't accept the default case but instead accepts only
specific values so that the mapping of modes to regulator modes stays
1:1, unknown modes should error out.

--wvlmgvojcjj5o6al
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlljcdAACgkQJNaLcl1U
h9D0FAf/QLC0bhdPH3U3IwQ+Lpcq9wzOsQQCOEeQkWS5n/XuXGiN5mKF1Xh/alM7
rBc2xseHZN52QXFWiRZBdKE0Tcq/zgwYxPuYp9B/15Foq3JHQn3EGahAMm0/aKjF
fu0AEqpJc2wtBrqTlCWY3ofdCBmD2lIZ/O0EbjODacfBewl6NHQIvr5i5YgG/0Ur
eYTV+BZplJUODlAZAwwmSycDHNO4K67SsLoZen16jC7k/vTncB+l766AKkjxLXfm
RICrSO3FJIFpY4UogLTdWNfJrbwTMVqiMeSP/vD2Ap+a4qx166Qvk3dXieToCOyg
xFz+5nsdKNzHbgPbq8N/qlyuElhibQ==
=SfJB
-----END PGP SIGNATURE-----

--wvlmgvojcjj5o6al--
