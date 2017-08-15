From: Sebastian Reichel <sre@kernel.org>
Subject: Re: device tree bindings for lp5523 leds on N950?
Date: Tue, 15 Aug 2017 09:15:28 -0400
Message-ID: <20170815131518.jt4xff6qv4whebul@earth>
References: <20170814133816.GA24493@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wqgk325cdppzxvaf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170814133816.GA24493@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--wqgk325cdppzxvaf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Mon, Aug 14, 2017 at 03:38:16PM +0200, Pavel Machek wrote:
> I'm (still) trying to debug "N950 not booting" situation. I'm stuck
> with black screen, so I thought it would be cool to use RGB led for
> debugging...
>=20
> Unfortunately, I don't see required dts bindings in the mainline.
>=20
> Does anyone have that working?

I have some N950 DTS patches lying around, I think RGB led was one
of them. I'm currently in Canda for a company event without my N950,
but I should be able to send something tested before the weekend.

-- Sebastian

--wqgk325cdppzxvaf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmS8/AACgkQ2O7X88g7
+prm8A//XzDiXDlVtrmBfgWzXB7aKt/XwBjEVbXifoMLqd5u6AGsbrDkqr8jqR/z
kfmC3z157wK5jxhOdveT/W0+oKg3Tw2R6LlWLKQ+h++wAIJcyyjar6QE+xP5FokY
jNoTM5JMuFidziakUfZHsrpd2xc1kjDCvvOpi+kOGp6U75+DS+P53MrFSb0vvH+C
8YtLS/JsPe8Fiuml2y4zY0dhMTPs00wUeVzGf4ll6rU5GprKIdMvErTJxpvEQkcO
Gnm2Y5/BwdoxvZ4Cv7zlKCANCct0T+M8ElrISQNsb7KFxLXPIBvm4eklSfsA3Ua5
zGMXqIVAdoo7i7GwLi4jHhwNVr38BWSWJwgRp4NagbV7XSmAl6/NTcFEAVnTWXuS
Kx9PRGxp1n/7KtkQyHXzL/pQNW5tevbNyfqkGaDkdBrdn2pFa48HG8vWZqCQ2X6a
gVV5hti/EJ0kldRWO6tw/qFGEnLaYMglnP4D7Cx+OkdncNM3kyKsqkeJ1fNGYboD
aUSew6WubRWwagWT2a70WOvai3sKRxdAKkvhL0eSV1pF71Qzg0QZQ2dDKesTOB3v
kFg+wVsxddVRrHHJEsM5J+H8SI8u4g/ZDXzXp3lqJC23iqOuviXp3tUcwEIfUkgg
VNVDsnfUmdY9gSTpctFY3NoQT2L5BEXeJ1TCgb6Dg4EYZ3KnQUk=
=Xxxb
-----END PGP SIGNATURE-----

--wqgk325cdppzxvaf--
