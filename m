From: Mark Brown <broonie@kernel.org>
Subject: Re: Nokia N900 headset detection & MIC Bias + TVOUT
Date: Mon, 9 Jan 2017 19:22:01 +0000
Message-ID: <20170109192201.l3mkro3epzf2ns27@sirena.org.uk>
References: <201701070007.49137@pali>
 <20170109112749.6gmtytxuqzfai57e@sirena.org.uk>
 <20170109131317.GD26301@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="emyiifijhgft25zt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170109131317.GD26301@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, joerg Reisenweber <joerg@openmoko.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--emyiifijhgft25zt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2017 at 02:13:17PM +0100, Pali Roh=E1r wrote:

> So... can I call snd_soc_dapm_mutex_lock(dapm) at function startup,
> start doing cable detection and when needed call this?

> snd_soc_dapm_enable_pin_unlocked(dapm, "HS Mic");
> snd_soc_dapm_sync_unlocked(dapm);

> And at the end of function revert back "HS Mic" pin status and call
> snd_soc_dapm_mutex_unlock(dapm)?

You shouldn't need to lock I'd expect, and you'll want to sync at any
point where you need an actual change.  Note that if something holds the
microphone bias on (like something using the microphone) separately then
that'll take effect so if you really need things to get turned off then
that won't work but you probably have trouble anyway in that situation.

--emyiifijhgft25zt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhz4tgACgkQJNaLcl1U
h9BSOwf/Ukidb2eIhXNWGynPahNpH1S2VTygGKq1VkqnTXdcPK0e6ly7vVkgSmJV
NYaKm5WHeZL3btkZgnq+X+q/Osu24JQVnZ10lwZcLQpld78ee5gog+fxs7Q7jIrl
wBHICCMDH/ouhpJPsucBCN0/ddq5nYkXf5Tsdq5/EKOYkixqbe2Vb7/HQ269HFeM
LcLkfyKpVjz70Lxqhi1xsEtMmSt7Fhm8+8eKDjhkq05SvcrK0YJbh4L6sVbdFUze
A0LqxR3IyddaDsFbXa5b64cLTVBklQhWwVUpfR743z/iC80A7QGXaB1MahdBvgQ8
Gyqa02v6obM+po42dsm2GAcJjetTvw==
=Bq9V
-----END PGP SIGNATURE-----

--emyiifijhgft25zt--
