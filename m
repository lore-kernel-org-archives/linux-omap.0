From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v8 0/2] More fixes for twl4030 charger
Date: Mon, 3 Jul 2017 19:18:35 +0200
Message-ID: <20170703171835.gidyf3fmg32rfptq@earth>
References: <cover.1499099830.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ez2c5yvealysbg5s"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1499099830.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, NeilBrown <neil@brown.name>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Marek Belisko <marek@goldelico.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, notasas@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--ez2c5yvealysbg5s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks, queued. I will send these in 2nd pull-request end of next
week, so that they get some time in linux-next.

-- Sebastian

On Mon, Jul 03, 2017 at 06:37:09PM +0200, H. Nikolaus Schaller wrote:
> Changes V78:
> * further fix for wrong notifier initialization sequence (suggested by Se=
bastian Reichel)
>=20
> 2017-06-19 10:41:47: Changes V7:
> * removed already merged patches from patch set
> * further fix for potentially wrong irq and notifier initialization seque=
nce (suggested by Sebastian Reichel)
> * NULLify transceiver pointer in case of errors (suggested by Sebastian R=
eichel)
>=20
> 2017-06-14 11:25:59: Changes V6:
> * split up -EPROBE_DEFER and irq allocation patch into small steps:
> 	* convert iio to devm allocation (by Sebsatian Reichel)
> 	* fix potentially wrong initialization sequence (by Grygorii Strashko)
> 	* add -EPROBE_DEFER
>=20
> 2017-05-21 12:38:24: Changes V5:
> * reworked max_current removal patch (comments by Sebastian Reichel)
> * resubmit missing madc connection for AC power detection
> * resubmit patch for irq allocation and -EPROBE_DEFER
> * rebased on 4.12-rc1
>=20
> Changes V4:
> * resent commit (original one did contain material not upstream)
>=20
> 2017-04-14 21:29:39: 2017-04-14 20:26:00: Changes V3:
> * worked in comments by Sebsatian Reichel
> * clarifications of some commit messages
> * rebased on v4.11rc-6
>=20
> It took a while (18 months) until we propose an updated patch for upstrea=
m...
>=20
> 2015-11-02 12:27:39: Changes V2:
> * worked in comments by Nishanth Menon <nm@ti.com>
> * added another patch which solves a probing/boot stall problem (irq allo=
cation vs. -EPROBE_DEFER)
>=20
> V1:
> 4.3-rc1 introduced a new charger driver for the twl4030. This patch set f=
ixes some
> issues.
>=20
> While making twl4030 changes from 4.3 operable we have found some issues
> during testing on GTA04 and OpenPandora.
>=20
> H. Nikolaus Schaller (2):
>   power: supply: twl4030-charger: move irq allocation to just before
>     irqs are enabled
>   power: supply: twl4030-charger: add deferred probing for phy and iio
>=20
>  drivers/power/supply/twl4030_charger.c | 43 ++++++++++++++++++++++------=
------
>  1 file changed, 28 insertions(+), 15 deletions(-)
>=20
> --=20
> 2.12.2
>=20

--ez2c5yvealysbg5s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllafGsACgkQ2O7X88g7
+prppw//TqiCJO9wMGm9lRJhkudKhobWsuFs/N+d1wt1N/5niBm8WsxWowut9vly
Aer4jSYKawTYXAu/O61Ev5lOT79caGu90b1otoPHyv1XBoqv4fUgHe++O+liR/Bd
0TQ8REdwZZhwOaiRgkuUJFzJjM6Ix2o56jaIQtFmvoFEwLl9C1pE4uTSgiaq6UeB
viTB2L1kEGl/0BcbmFMtkIE9tJaFh6ZFkDqaZx+vW6fM251bE1beCtQuBWdKoHz+
TrJ8fPPkIPbOVwFUxeCcq7jK3h2yaD4PwMRb3vY+6IIY7GrJMyJwuBBslYR4/kNB
rxgklmUwahetog0Wl5yAG8d2jfKbPj7zHPKPUo0k+cLB+PNVnhw4qautlG50l0eq
SG2Btb+OIYb9s60nl14qCxxCadaxEMDr7LNWRL4kpVH0YHHIr8YUqaZIEsbgLxAj
Ex9STaAIGHqTKbiVGcck72Hojka8yLYxOgwNXYzz4PRVjkfzuO2U5BjBPZebcHMN
KLrjYqXJ2OScGABZfnvBhhuU8AepK+eT6C1SZqSFXJFz1B2IixngV3hlxLPHV3e+
oL+OMZNAtZNWcu+BU5ijlZiRxJdwjC5EirJ0UmMG8EyoRHVxWmYySH0Nf0+Lg2OC
vXO/zM5iouE6WXpLBq6Xqeot3wMG5hW1eL2P5AcZaLcqn09xQA0=
=ic4V
-----END PGP SIGNATURE-----

--ez2c5yvealysbg5s--
