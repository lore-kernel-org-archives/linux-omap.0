From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 13/22] input: omap: void using mach/*.h headers
Date: Fri, 9 Aug 2019 01:39:41 +0200
Message-ID: <20190808233941.v6elo2mdji5awylu@earth.universe>
References: <20190808212234.2213262-1-arnd@arndb.de>
 <20190808212234.2213262-14-arnd@arndb.de>
 <20190808214257.GF178933@dtor-ws>
 <CAK8P3a2TOcjxwCBGkZAhMAf9HuTL=FAB1e0=FAg+oHB0U1nJ0A@mail.gmail.com>
 <20190808221950.GG178933@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4tjmcfjvugwwn6md"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190808221950.GG178933@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--4tjmcfjvugwwn6md
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 08, 2019 at 03:19:50PM -0700, Dmitry Torokhov wrote:
> On Thu, Aug 08, 2019 at 11:46:45PM +0200, Arnd Bergmann wrote:
> > On Thu, Aug 8, 2019 at 11:43 PM Dmitry Torokhov wrote:
> > > On Thu, Aug 08, 2019 at 11:22:22PM +0200, Arnd Bergmann wrote:
> > > > By using the new linux/soc/ti/omap1-io.h header instead,
> > > > compile-testing can be enabled, and a CONFIG_ARCH_MULTIPLATFORM
> > > > conversion of omap1 may eventually be possible.
> > > >
> > > > The warning in the header file gets removed in order to
> > > > allow CONFIG_COMPILE_TEST.
> > >
> > > Given that we want to migrate people off this driver everywhere but
> > > OMAP1 I wonder why we would want to improve compile coverage of it.
> >=20
> > Mainly for consistency: I'm converting all omap1 drivers in this series=
 to
> > not rely on mach/* headers and to let them be compiled standalone.
> > The other drivers don't have a replacement, so I could treat this diffe=
rent
> > from the rest and skip the Kconfig and platform_data changes if you
> > prefer.
>=20
> Yes, because at least with the version you posted we are losing the
> #warning telling people to move to matrix_keypad. We could do:
>=20
> #ifndef CONFIG_COMPILE_TEST
> #warning ...
> #endif
>=20
> if you really want to allow compiling standalone for testing.

FWIW the driver depends on ARCH_OMAP1 and the warning is
only printed for !ARCH_OMAP1. In other words: The warning
is never printed at the moment. All OMAP2+ boards moved to
matrix-keypad long time ago and the driver does not support
OMAP2+ anymore since f799a3d8fe170 from 2012.

-- Sebastian

--4tjmcfjvugwwn6md
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1MsroACgkQ2O7X88g7
+poQJBAAnjfNcZ21PrPoH/EmfeeRe4fGSZaNSCLXNqf+HuY+WIUD72F8q4ywHwvn
Fkm85facQO3vu6RCVoapSh5nZVHkL/WyM6fqDhJDuBZvqleHE68sgmBY9KIgg7ur
qeYMF4ul4BhvC218JY0dM/xwV0uwp61g3T+4vgUPvT3YsnB5uoYa7wT2D71lilr8
Q+S/Az/rTrrn7uI1vKXZjfUKsm/cWuWyAHbzgH7Ax8f/gxcLUoHS1IUTiwyCFzKJ
BxAGPsZziw7Un8d3LPwcSzqB9VslryGs4hiuiaSAYaYN6+NrjjlCI7wka+HFfKGO
0OumM77eQCkVNgCSafoTxJWZZo9HsTAeKkJy1iDGWVeiSWqHKPUj/YDj6ityxuba
5LKhZan4Gx1JoihDEw69N/a0ZxNvYJzHPBffqHbSLOc7QkWeveoSUMGgJjLLNl/f
UD7U1rC1ugAz3jqmgS5it+35pCA17glrVtIPzDsTPx90lGK0lxe+krbPClVkeckP
IIkuf4xyJtsep5fQQDGxtCape8V52GtQYre1BjBxQU/k7KUGR+08gkiRmc3x8qvK
v05wmqSeIyGXox8WrvB/hARab8/2nTA6hf+LedV+ofvNzRGBKM8hrgdpfveXlwhF
HEJ74R2g3SOIxtXz/CuFWgUwsHEEF1NlaBOAaNa+1H9tFMMRgIo=
=sia4
-----END PGP SIGNATURE-----

--4tjmcfjvugwwn6md--
