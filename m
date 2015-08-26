From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] of: device: fix NULL pointer dereference on driver
 removal
Date: Wed, 26 Aug 2015 09:12:21 -0500
Message-ID: <20150826141221.GB14625@saruman.tx.rr.com>
References: <1440531290-17526-1-git-send-email-balbi@ti.com>
 <CAL_JsqJYwQhFyZBFL2eC5mwO-o9xf3K5nn7vgfus_ySBR7NMWA@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqJYwQhFyZBFL2eC5mwO-o9xf3K5nn7vgfus_ySBR7NMWA@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2015 at 08:14:36AM -0500, Rob Herring wrote:
> On Tue, Aug 25, 2015 at 2:34 PM, Felipe Balbi <balbi@ti.com> wrote:
> > If we don't insert resources into the resource tree,
> > calls to of_platform_depopulate() will end up in NULL
> > pointer dereferences because the resource parent will
> > be set to NULL even though we still have more resources
> > to go through.
>=20
> Long standing problem. A fix is in -next now and will go into 4.3 (plus s=
table):
>=20
> commit 11c63e4718acad3d8f04601c80fddd4b3d1455b1
> Author: Grant Likely <grant.likely@linaro.org>
> Date:   Sun Jun 7 15:20:11 2015 +0100
>=20
>     drivercore: Fix unregistration path of platform devices

that commit works, but too late to add a Tested-by :-)

--=20
balbi

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV3clFAAoJEIaOsuA1yqREJTAQAJh6PBaRydjy1rX++w3e9JH6
Z2cYiFu2mowtr+Z28hOI2kMtwT0JrfSeXbZ0jMTMajsgSOKnjscm403yDsfEvI3v
27QEuTgVp59PHv2irIS1E1osmUV3dyZ6OoEqejNLSP5Mxx9rPuODzRPZYB7ezN+z
QPNQt8Hjy5HOc9Zb/DrbcCrqXWL/XJknfPut67jIQlkipICcBrOVbsmwORn+iHpg
eiVDCJTc3c5jvhQihTn4ks3AO2COUn4x48pDYUYkOzH9Epqi6KoYVV1+1lvlGfLy
xPApHQxQGb1aw9z6Jt65OCo+vxrxpWeXXRPw82jQyKm5MpvVszMly26FsescK88J
y7u7eX2k+x8goYahjO/KQfVHFpoNYQjebfX1QgIhDWWhWyVdkd/eKY8Hi5YG6s4E
07NduJFN9+hdZueBI8d7Xt+D6QWHrFlqfKqk/OpqYo1WVTZ/ArJjYmp/pEg8Htd1
5NoXLtJ/a+64cZsJmtSuNWgzNrQcETdkvpRewUWtgqXNXYaeAiEt0r9xzmV0+dUa
k+CQlHLUtW2FAsi1fADOGdvFJ1RLuYQFZgIgxujB5jMsNqAaagte4B04Ekc2badF
xkRiKY10CcKzEOHdWCv3DUCyCIVkBuaEe1Sa/sNqgHU2Q9EFI/S9l0CQxxIY3s6s
RE9PfkEn+vS8sZTkBlXD
=EfMe
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
