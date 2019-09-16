From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv2 0/7] Non-urgent fixes and improvments for omap3-rom-rng
Date: Mon, 16 Sep 2019 21:08:22 +0200
Message-ID: <20190916190822.uo6b6nkzgu45yw4b@earth.universe>
References: <20190914210300.15836-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="24nbsg2ye5tfefja"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190914210300.15836-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-crypto@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Adam Ford <aford173@gmail.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--24nbsg2ye5tfefja
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Sep 14, 2019 at 02:02:53PM -0700, Tony Lindgren wrote:
> Hi all,
>=20
> Here are fixes and improvments for omap3-rom-rng that's been broken for
> a while.
>=20
> The first four patches get it working, and then the last two patches add
> support for runtime PM.
>=20
> I did not add Sebastian's acks from v1 set as many of the patches
> changed. Please review again :)
>=20
> Regards,
>=20
> Tony
>=20
> Changes since v1:
> - Use clk_prepare_enable() as pointed out by Sebastian
> - Simplify runtime PM changes patch
> - Add a new patch for devm changes as suggested by Sebastian
>=20
>=20
> Tony Lindgren (7):
>   ARM: OMAP2+: Check omap3-rom-rng for GP device instead of HS device
>   hwrng: omap3-rom - Fix missing clock by probing with device tree
>   hwrng: omap3-rom - Call clk_disable_unprepare() on exit only if not
>     idled
>   hwrng: omap3-rom - Initialize default quality to get data
>   hwrng: omap3-rom - Update to use standard driver data
>   hwrng: omap3-rom - Use runtime PM instead of custom functions
>   hwrng: omap3-rom - Use devm hwrng and runtime PM
>=20
>  .../devicetree/bindings/rng/omap3_rom_rng.txt |  27 +++
>  arch/arm/boot/dts/omap3-n900.dts              |   6 +
>  arch/arm/mach-omap2/pdata-quirks.c            |  14 +-
>  drivers/char/hw_random/omap3-rom-rng.c        | 168 +++++++++++-------
>  4 files changed, 139 insertions(+), 76 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rng/omap3_rom_rng.t=
xt

For the series:

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian


--24nbsg2ye5tfefja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1/3aIACgkQ2O7X88g7
+pqmhRAAmRHBNqefO5fYTQqIOQ3AK22ocj2LZk96U4Hs1GkjGTj6+RugmGULKZUu
72dN1Q+TlxTyJxtFAkgE8MWxXdMIe5ZI6TKFGN5Vm55+oW86iMgEvtYWDxHVHDVX
HVlHneWvXso1xg2rVbJtoVvqvp/VZRSObUGGUW2vfjYNP2CcTCbbMeI5iXrJIC7b
X0oYsgK+4yVx1n/wIWu5Bv7BBcCjjN83iKE/W6z69NUSJXjcV4q+uo4TEn8wtCsq
JMNjwe3LHuoalcjgoZo7wx/4xpkxcXzdbEpdSBATxJLTTletpv7D72m/yUrV7+GI
FFYPcz5gaF0f3hTvf6u5BVhPZls4gqF9/wp305elOl10Rc8Ne8H9dG1ijOpdw4Yu
TeDfBPJjN5oyk/h75qeCaYldgPelS6gYXQ0DR5ioUsMhAJ0MxAdiYhm10AiezxY5
dYpscBjfaEFb3vGwrIhItvhKq7o3Gm+gMvuJbXoUIjb92D1L1ZnnMiugOOtAxMPK
i0DBknSag5pz6Eg9aKyxa4tMtJbl8mcX7aRAa4B+AJ4cVFBfYLNXOh6dc+USaK/I
e5awYHgbUJu+FDdiOMqeJBoBmyCigyCYQZ1MY4iJblLMr4EqIncbZp47WbxKqVHD
IzPPduLPSxJlBKEcS4UZrdVSI1KCZGnCLreCRfsnPl3zrPTrZDk=
=lqm0
-----END PGP SIGNATURE-----

--24nbsg2ye5tfefja--
