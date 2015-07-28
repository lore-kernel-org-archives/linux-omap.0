From: Sebastian Reichel <sre@kernel.org>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Tue, 28 Jul 2015 14:26:13 +0200
Message-ID: <20150728122612.GA31794@earth>
References: <201507111405.06048@pali>
 <20150722001741.GA7950@deathstar>
 <20150722020306.GA8379@earth>
 <201507251055.51375@pali>
 <20150728083932.GD13765@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150728083932.GD13765@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Michael Welling <mwelling@ieee.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pali,

On Tue, Jul 28, 2015 at 10:39:32AM +0200, Pali Roh=E1r wrote:
> Sebastian or Michael: Can you add check for pm_runtime_get_sync()
> function and send patch for including in mainline kernel?

This actually already happened before your Tested-By.
I accidently did not CC you, sorry for that:

https://lkml.org/lkml/2015/7/22/581
https://git.kernel.org/cgit/linux/kernel/git/broonie/spi.git/commit/?h=3Dfo=
r-linus&id=3D5f74db105b1c0980c9863e7a7d1bc0525e0316e8

-- Sebastian

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVt3ThAAoJENju1/PIO/qaOwIP/35dmLPgBZlq/I+j1XOamc8S
m/8TtkjvORt6OanY5Gz7gJn9f9xwUp2VNuqjQL4L9ijntLQ0/I0YCe0Bz4o0tzf/
OK7YXhF3BzDYHO2yvtGMS98JHT9b/Lr44CzJnPC2cUo1cTpU3/oNOJpfsB/R9N0A
PFDmLLnWRZBRAlMNTSKni2DF6KT9dHs7ggt8nXXT06ZI2pKnUGTpKCL58ELPV24d
nxdTywJ8HTxXsQn/e0iWVashC4h0xyhAg7aRt2o3x2Gb8c3W3OoWlx7zT4iEhoYp
+xpRw2kjaCNLoyYSBlfPJoL9xU0F5G8shq/CAedRmQMzVbr/jF7ag0qUwsCD4icP
HVw1+9HkH5R3OAqsLUXJi+GMrI+jlClKawyDj7Yt58Bz6rOA/f6FZfNvJ9LdlZSc
fAbk/758wEkoKm5jF2mE107l2KH/hs+n/KrzkxlxH1RIJyAQQDufnqZn6qFbqhf/
KOcFeuElXO2uPzXWlv0Hcgtp3P0yfC42JS1nISvdvMIu0IHpu4OpAQ0NBegSVkYp
+SH7wUVomVZjrsRMkIC14rh73CWWNSFrcbZMLRVhtv7lCDB5xkio5SBMlpWS0GjS
dvLtIiT/XiQn6v4YBTMjYdBRMU54cAdw3N+qa/gSukc7oY1+QVKUp9P9GR2/hBrw
yKwQQ82rbfZO8BrvWr0u
=bOuZ
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
