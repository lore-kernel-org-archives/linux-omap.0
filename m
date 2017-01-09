From: Mark Brown <broonie@kernel.org>
Subject: Re: Nokia N900 headset detection & MIC Bias + TVOUT
Date: Mon, 9 Jan 2017 19:38:28 +0000
Message-ID: <20170109193828.rzpyzzl6g3v2nylk@sirena.org.uk>
References: <201701070007.49137@pali>
 <20170109131317.GD26301@pali>
 <20170109192201.l3mkro3epzf2ns27@sirena.org.uk>
 <201701092029.53939@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oroolv6kx3wegbyr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201701092029.53939@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, joerg Reisenweber <joerg@openmoko.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--oroolv6kx3wegbyr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2017 at 08:29:53PM +0100, Pali Roh=E1r wrote:
> On Monday 09 January 2017 20:22:01 Mark Brown wrote:

> > point where you need an actual change.  Note that if something holds
> > the microphone bias on (like something using the microphone)
> > separately then that'll take effect so if you really need things to
> > get turned off then that won't work but you probably have trouble
> > anyway in that situation.

> This is needed for cable/jack detection at time when jack is inserted.=20
> So before it there cannot be any user of (disconnected) microphone.

That's not going to stop userspace, consider what happens if the headset
gets removed and userspace is slow to stop a recording for example.

> What I need is to enable mic bias, measure ADC of some time period,=20
> check status of some GPIOs. Then disable mic bias, measure ADC again and=
=20
> check GPIOs. I in this detection procedure I need to ensure that nobody=
=20
> changes mic bias. So I though that locking the whole procedure could=20
> ensure that.

That sounds racy and a bit unusual - what's the actual procedure here?

--oroolv6kx3wegbyr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhz5rMACgkQJNaLcl1U
h9AxUAf6A7gtj7gxTk1+H+SAQi8lxH8kekXLvWdSaj3G/LqZGTe6DmSroEsqgAk0
vN/5Zg5riCJmpOrWoLE5DpWPh3IbvQGOaxrasRlzxQWPKp8TTnTfq/ZCWxXo16T8
FdMcQ1PFf/mQTDBb5pXKgVbVxYh3PZKl9FgNFziP30mZp1VeyWCadtMoOugylT3O
booY72niMFeWOsuLyzkX2k4z85gYW/G7tp56IVNCpyF93qCcNbUXcvnD6wFMGCQz
LY8uI9kCYBWupDtjC38fpnYTxwHCS8Seh01GfhXYssbL/lMR+eVZOU85KDKl9zte
V7RE5yjU3dARWBmpbbl0jEI/qtC3mg==
=LX9a
-----END PGP SIGNATURE-----

--oroolv6kx3wegbyr--
