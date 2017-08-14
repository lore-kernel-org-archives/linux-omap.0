From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/3] mfd: tps65010: move header file out of I2C realm
Date: Mon, 14 Aug 2017 18:29:41 +0200
Message-ID: <20170814162941.qns2k2u4t643kivy@ninjato>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-3-wsa@the-dreams.de>
 <20170523071819.4zpdef7ofzz3moil@dell>
 <20170813133445.vqbfelwshvrififp@ninjato>
 <20170814064355.foiilzr5cmwk65hr@dell>
 <20170814084412.dfbsqfwrgmy5bsu3@dell>
 <20170814162108.GW8569@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ya6n3qjf3z2qe7rn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170814162108.GW8569@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--ya6n3qjf3z2qe7rn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Even if it doesn't, it still requires Acks.
>=20
> As long as this has been compile tested with omap1_defconfig:
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>

Hah, just in time. I was about to send out the new version, thanks! :D

buildbot did test it and I did compile tests, too.


--ya6n3qjf3z2qe7rn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmRz/EACgkQFA3kzBSg
Kba1IQ//dkgmlc6CmdbxsBJlvUw7AkoD4MoyGFDuE5UHDB/xkZTyizhhLmI9iDJF
T2OQXXJknWGt502VSjr8oxdrneEAuPLAiREI5MB3NJwmf41KmqdyBwRE2VlSQ+aS
5kBpdCbREcYlvx+oWzUb6mU3yxJkrPGDbIVyaB8jEm+KRZqJuLuI86bQbTe1VKm0
w1t/w7w+Z4mnuAUllia/PQY72VbnKx39hPqsbsk8cw8X6effYsuYQ7ujn/54gmYy
sG+UKtCdFDncsmrLq4Bh/RyNwVhj4ixAVf5OI9FHXX3PjhBnqkyX1HgpWblOwPdH
ZTUaWnlayOWqs3XgTrWNQQfggtx6DubyQZqDmJU2QxNDPR+lbuvR4/vMKzoqPsqf
ZqShs9TBQckeOV2g5GetixO4Y7RDm3GChg/CF9eeHIOPV8xuDiaujZauXU87IqYL
HHmuR+ki1w9Ckn1rcaKM3J+Bs7uodVDXNGD+pvFY3ZZ72sJsQOEUdZ+2jkZd98Vs
rzheI/XZ+YeJbLp2frOyp9RZR6YYzgZcunjTN8nJiNHulhvGqq/2eHai7gaKUWBV
Pf8HjO3PcVXX8d8DEMpNA6r3atvPUFD43sNAFVjlMs04On9xXmSLlykcre/ZzLXa
dHZCGAMwkP+6TyMT+0KNsbBsi43xn/dESDOMH0QZHmZZmtzPA6A=
=ehu4
-----END PGP SIGNATURE-----

--ya6n3qjf3z2qe7rn--
