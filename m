From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900 headset detection & MIC Bias + TVOUT
Date: Mon, 9 Jan 2017 20:29:53 +0100
Message-ID: <201701092029.53939@pali>
References: <201701070007.49137@pali> <20170109131317.GD26301@pali> <20170109192201.l3mkro3epzf2ns27@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1563104.WODxihMdno";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170109192201.l3mkro3epzf2ns27@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, joerg Reisenweber <joerg@openmoko.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart1563104.WODxihMdno
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 09 January 2017 20:22:01 Mark Brown wrote:
> On Mon, Jan 09, 2017 at 02:13:17PM +0100, Pali Roh=C3=A1r wrote:
> > So... can I call snd_soc_dapm_mutex_lock(dapm) at function startup,
> > start doing cable detection and when needed call this?
> >=20
> > snd_soc_dapm_enable_pin_unlocked(dapm, "HS Mic");
> > snd_soc_dapm_sync_unlocked(dapm);
> >=20
> > And at the end of function revert back "HS Mic" pin status and call
> > snd_soc_dapm_mutex_unlock(dapm)?
>=20
> You shouldn't need to lock I'd expect, and you'll want to sync at any
> point where you need an actual change.  Note that if something holds
> the microphone bias on (like something using the microphone)
> separately then that'll take effect so if you really need things to
> get turned off then that won't work but you probably have trouble
> anyway in that situation.

This is needed for cable/jack detection at time when jack is inserted.=20
So before it there cannot be any user of (disconnected) microphone.

What I need is to enable mic bias, measure ADC of some time period,=20
check status of some GPIOs. Then disable mic bias, measure ADC again and=20
check GPIOs. I in this detection procedure I need to ensure that nobody=20
changes mic bias. So I though that locking the whole procedure could=20
ensure that.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1563104.WODxihMdno
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlhz5LEACgkQi/DJPQPkQ1J69ACgh6oUmL/M99wHg9bsuorhxlTP
kNUAn2qUkO7OqhqtT+1uYJvQMYy7t64+
=tJF5
-----END PGP SIGNATURE-----

--nextPart1563104.WODxihMdno--
