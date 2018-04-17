From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: Fix return type of of_map_mode()
Date: Tue, 17 Apr 2018 18:22:29 +0100
Message-ID: <20180417172229.GK8973@sirena.org.uk>
References: <20180417171204.259146-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Tv3+oRj6D9L8lW+H"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180417171204.259146-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: David Collins <collinsd@codeaurora.org>, evgreen@chromium.org, swboyd@chromium.org, Javier Martinez Canillas <javier@dowhile0.org>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--Tv3+oRj6D9L8lW+H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2018 at 10:12:04AM -0700, Douglas Anderson wrote:
> In of_get_regulation_constraints() it can clearly be seen that the
> return value of of_map_mode() is assigned to a signed integer.  This
> is important because the first thing the regulator core does with this
> value is to compare it to -EINVAL.
>=20
> Let's fix the return type of all of the current of_map_mode()
> functions.  While we're at it, we'll remove one pointless "inline".

Ah, I see...  the thing here is that the mode is always an unsigned int
since it's a bitmask - this goes out beying the use in of_map_mode() and
into all the other APIs.  We only actually use 4 bits currently so I
think there's no problem switching to int but it seems we should
probably do that consistently throughout the API so that things don't
get missed later on.

--Tv3+oRj6D9L8lW+H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrWLVUACgkQJNaLcl1U
h9DXGQf/QzhN2XqWbzCdgrpHoUxRm4TGak27JiLbn2oDkDvblA5/wo/Ru2uuPp+i
E/xlzVxYxcOUuN8ZTTczubPNJDgODQLTkSD3bxfCBKqBrToyPj1+b/iKs25+HuNK
ieg5rrpljw6Kbgzd58AY01GwYsbcyX7QJzwY7E82xm7Tob5D/9nPdg9pFPLt4x8u
i8WK+hX+JBl1WgX6N5m7FhHRe26aQ2bT/mZW7hst73vlHL54PqvDd8YIx9/s2Xbq
6rvTobvga0rmLs3ZddyCHLlET3y3nY/I47s0eRguLeCnloAG1ez0AIJbNlL2E67H
kCawnUGCypTrxFA50z+8Rcg+M6TzRQ==
=Anei
-----END PGP SIGNATURE-----

--Tv3+oRj6D9L8lW+H--
