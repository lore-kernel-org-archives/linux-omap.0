From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 02/23] ARM: dts: n950: add display support
Date: Thu, 17 Mar 2016 18:49:01 +0100
Message-ID: <20160317174901.GB3864@earth>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <1457455195-1938-3-git-send-email-sre@kernel.org>
 <21766689.NesyW3QHk4@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <21766689.NesyW3QHk4@avalon>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Thu, Mar 17, 2016 at 02:14:26PM +0200, Laurent Pinchart wrote:
> [...]
> > +
> > +		/* panel is 480x464 with top and bottom 5 lines not visible */
>=20
> I assume you mean 480x864 ?

Yes, nice catch. Basically the screen is 480x864, but only
480x854 are visible.

> > +		/* physical dimensions: 48960=B5m x 88128=B5m */
> > +		resolution-x =3D <480>;
> > +		resolution-y =3D <854>;
> > +		offset-x =3D <0>;
> > +		offset-y =3D <5>;
> [...]

-- Sebastian

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW6u4NAAoJENju1/PIO/qailMP/0R/kDi9KYAG0pA1IL0Dn1pn
LigzoKxT0097hRdlQAOS9Pp6/2MRs/mJJfSFpMTMeXHKFgrSw2e3k/7SLksfsFaA
y+PDB437L4rLq7uitlgBrReJ0nTOdnpnoW7raQ6BHt9fyjZgMoRx6bDeeoxCkgY1
MTW8p/CHs0RBSBFnwBd7fRLIZDXrrx6JO5NQr2pSUdShRFmCA25Dbu6y40MK91Ae
Ygmv8lyKHPjCmMwwR+DsQ2GnsuBAMBF8eZLyuwWR4SVpryspr5tRGY2rz+aqm16M
JVNRVgADiJUvBB6XwyVDDXlyxswJkuN7e5ncmGz4J3pEJK75e+V4CV30g//vgOts
Frf1QDfd6n41zIfzpxkFfsB5oRwaGLI/mgrk/tQ66lYa9aDV45hE566+Y4WiPIvZ
L8AriNw+oU+vebgSL2+/Eox2AiEFK6V/VS22k3zTwb5029LzzV98FLktJtqZqQZ7
NsJ6vSVCuubYt0leFZpQrmqG5O75jhhivQ/T+5EvG9hMnute4WI9MP6xHdAuw2vD
q1AmzRgtiOXSjms6RVIWMSXPAqFDkgZrJCiuYS98T+xZlYejFLgYDXchB9fgcSz3
1FtX8bzKQ4IGWSatPtEiApYeHKA+oxcArkW8ru5j5gLzS+keotr0IsNIXhtZZE4t
xKzAguUGJCgZ7iRPR8rm
=Ywfw
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--
