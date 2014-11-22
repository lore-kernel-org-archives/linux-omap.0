From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: omap: fix i207 errata handling
Date: Sat, 22 Nov 2014 22:08:34 +0100
Message-ID: <20141122210833.GB1275@katana>
References: <1416529011-21803-1-git-send-email-al.kochet@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416529011-21803-1-git-send-email-al.kochet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Kochetkov <al.kochet@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2014 at 04:16:51AM +0400, Alexander Kochetkov wrote:
> commit 6d9939f651419a63e091105663821f9c7d3fec37 (i2c: omap: split out [XR=
]DR
> and [XR]RDY) changed the way how errata i207 (I2C: RDR Flag May Be Incorr=
ectly
> Set) get handled. 6d9939f6514 code doesn't correspond to workaround provi=
ded by
> errata.
>=20
> According to errata ISR must filter out spurious RDR before data read not=
 after.
> ISR must read RXSTAT to get number of bytes available to read. Because RDR
> could be set while there could no data in the receive FIFO.
>=20
> Restored pre 6d9939f6514 way of handling errata.
>=20
> Found by code review. Real impact haven't seen.
> Tested on Beagleboard XM C.
>=20
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> Fixes: 6d9939f651419a63e09110 i2c: omap: split out [XR]DR and [XR]RDY

Applied to for-current, thanks!


--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUcPtRAAoJEBQN5MwUoCm2j5wP/1Vyp1yfH8T2mvynrBl3xtrY
DHfVyjXROTQvdltpeywRozKaJs+Nkb3P6IdmjHuCT8AqxSrORvqymvRquTmVrLt9
P9Fzt+CVXzqp5l1IplGy0vFvOc1eIxtpR5cRX3r44yd0i2Z+BjWrkTMXPNWKtsXI
VFMzZibNwC0Jt+rMWrzkENNz3pvyP/vXXZnVb3S/Rm78k5h8ISuFOxSfqmXOi3HH
hbKUBYdmyPI0FVFZ2UtbWSMXsw3EY6HdEdnln3E9Xb47mv9wgP2eA0l5QOpfVH1F
cSZRG8ZuCGDHCi154L9mUfiIxxOg4lykIpXchC71Jf26l9+q54jMbW6BWD/1Wlhr
lHz6PRmGgqpvW7rm4JsFZkmlXU4McaudvDQcl/pQdpzOZZUVnmag4lsdcWeGoWKJ
F8qdZyHawwrq46eqkMTtuPkdSSQ5aGR5w+UYpEcUey88eQdmc/E5JNy1OJFAtz15
+2xrQvP4Rsd4HBlCQftAJTITt/VCrB+akWTVKxdO9W7T0Q+gUigtFqJ7HgdMfz3v
0l+VVeiwNChxhy+2nxFjEteZXMkeRd02HQ8E80K/QqZjl3737/5Q22OnU+lv65DR
zhOPYt7nzMV/o/F+9Ro982c7NN64Jivye1TPkBshq1+orpq53nzm1bFdiMb/4qxw
QiPjeO8dWIeM3z8DEvTM
=EuAx
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
