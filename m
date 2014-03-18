From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v2 3/5] net: cpsw: Add control-module macid driver
Date: Tue, 18 Mar 2014 09:06:41 +0100
Message-ID: <20140318080641.GI11360@pengutronix.de>
References: <1394888864-11007-1-git-send-email-mpa@pengutronix.de>
 <1394888864-11007-4-git-send-email-mpa@pengutronix.de>
 <20140317090508.GN15674@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HKEL+t8MFpg/ASTE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47477 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbaCRIGr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Mar 2014 04:06:47 -0400
Content-Disposition: inline
In-Reply-To: <20140317090508.GN15674@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de


--HKEL+t8MFpg/ASTE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Mon, Mar 17, 2014 at 10:05:08AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Markus,
>=20
> On Sat, Mar 15, 2014 at 02:07:42PM +0100, Markus Pargmann wrote:
> > This driver extracts the hardware macid from the control module of
> > am335x processors. It exports a function cpsw_ctrl_macid_read for cpsw
> > to get the macid from within the processor.
> >=20
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  .../devicetree/bindings/net/cpsw-ctrl-macid.txt    |  32 +++++
> >  drivers/net/ethernet/ti/Kconfig                    |   1 +
> >  drivers/net/ethernet/ti/Makefile                   |   2 +-
> >  drivers/net/ethernet/ti/cpsw-ctrl-macid.c          | 138 +++++++++++++=
++++++++
> >  4 files changed, 172 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/net/cpsw-ctrl-mac=
id.txt
> >  create mode 100644 drivers/net/ethernet/ti/cpsw-ctrl-macid.c
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/cpsw-ctrl-macid.txt =
b/Documentation/devicetree/bindings/net/cpsw-ctrl-macid.txt
> > new file mode 100644
> > index 0000000..4eb39f6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/cpsw-ctrl-macid.txt
> > @@ -0,0 +1,32 @@
> > +TI CPSW ctrl macid Devicetree bindings
> > +--------------------------------------
> > +
> > +Required properties:
> > + - compatible		: Should be "ti,am3352-cpsw-ctrl-macid"
> this is called am3352-..., still you add it (in patch 5) to am33xx.dtsi
> and in the commit log you wrote about am335x. Looks abstruse.

This is of course for the whole am335x series. But as the cpsw phy_sel
driver already uses "ti,am3352-cpsw-phy-sel" as compatible, I didn't
want to create more confusion about the bindings and stick with a
similar compatible pattern.

>=20
> > + - reg			: physical base address and size of the cpsw
> > +			  registers map
> > + - reg-names		: names of the register map given in "reg" node
> > + - #ti,mac-address-ctrl-cells	: Should be <1>
> Would be sensible to drop this property, or at least let it default to 1
> if missing?

I would actually prefer to have this property here. But I will implement
a default value for this in the driver.

Thanks,

Markus
--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--HKEL+t8MFpg/ASTE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTJ/6RAAoJEEpcgKtcEGQQsFcQAIQrkJ5ktLfPNvnEWl6Nug+Z
gZLWILA0qS251lA0STN3HJHnoJmpOI34Co1rlZe9Ed4gQJuCx21UZvtJv7TrdLas
emkVq5WPhzx+moYkMOVtuGSl2eD8IznC7jUCi2lHjGXS6q0qaDDg1flQ5CzYdtr+
pDtwXQFh/EfG7mEbBl0IR7L6asMbSX/kRxugqeJ8MEyT7gRuvPjLSyYjgjLv9zgZ
KMmDTeRI5tXtlWUEB+ZEJv7Kg1JrZf9cfdVe2pvKkJwE98KN4/TxiI8IwwY+qJp1
sZvmwjQs/EnfUCib7ZUP3YBSwzT/WRnIE5ZuS1igMec5v6eqyuol6/inkUnidpYV
3V6hPrmJny5lxtDeCWwJAFkIY32FNZzLoJuBiB+IgZ3O0Q7qNIU5Ip4Pe/7XnzbJ
FeDsbdvban0YBb14b8iXu0smLjURUUKFB0dwhHLFU5Xqgt2vsPUrR0smW1RBaO6g
hIMWEFATe44/aKyQ/t+vmEsg1YYW6s0Gqcq742SoCrXxTBrQlpPb/qLprVTTDuun
pKcwgKI9BN7l8vzSJy7T0aA7cz95Px2GdUljCJxcrjm9oGs5tozcApggJhi7DB47
7Mi9+qeMn+g7C2GSTRf4478SnpBdkJwpgSB5OXvfHjONdFa97hX0lRztU5iZtZ6m
8IlhPrQ2VPmPy3hklp3S
=GQDr
-----END PGP SIGNATURE-----

--HKEL+t8MFpg/ASTE--
