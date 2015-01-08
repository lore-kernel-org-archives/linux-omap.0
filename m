From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/5] mfd: tps65218: make INT[12] and STATUS registers
 volatile
Date: Thu, 8 Jan 2015 10:25:12 -0600
Message-ID: <20150108162512.GC31926@saruman>
References: <1419622104-25812-1-git-send-email-balbi@ti.com>
 <1419622104-25812-2-git-send-email-balbi@ti.com>
 <20150106173734.GL6502@saruman>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49214 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756507AbbAHQ0T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Jan 2015 11:26:19 -0500
Content-Disposition: inline
In-Reply-To: <20150106173734.GL6502@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, stable@vger.kernel.org, Keerthy <j-keerthy@ti.com>

--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 11:37:34AM -0600, Felipe Balbi wrote:
> On Fri, Dec 26, 2014 at 01:28:20PM -0600, Felipe Balbi wrote:
> > STATUS register can be modified by the HW, so we
> > should bypass cache because of that.
> >=20
> > In the case of INT[12] registers, they are the ones
> > that actually clear the IRQ source at the time they
> > are read. If we rely on the cache for them, we will
> > never be able to clear the interrupt, which will cause
> > our IRQ line to be disabled due to IRQ throttling.
> >=20
> > Fixes: 44b4dc6 mfd: tps65218: Add driver for the TPS65218 PMIC
> > Cc: <stable@vger.kernel.org> # v3.15+
> > Cc: Keerthy <j-keerthy@ti.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
>=20
> ping

another ping. Without this and the following patch TPS65218 power button
driver which was already applied by Dmitry, won't work.

> > ---
> >  drivers/mfd/tps65218.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >=20
> > diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> > index 0d256cb..2243f75 100644
> > --- a/drivers/mfd/tps65218.c
> > +++ b/drivers/mfd/tps65218.c
> > @@ -125,10 +125,21 @@ int tps65218_clear_bits(struct tps65218 *tps, uns=
igned int reg,
> >  }
> >  EXPORT_SYMBOL_GPL(tps65218_clear_bits);
> > =20
> > +static const struct regmap_range tps65218_yes_ranges[] =3D {
> > +	regmap_reg_range(TPS65218_REG_INT1, TPS65218_REG_INT2),
> > +	regmap_reg_range(TPS65218_REG_STATUS, TPS65218_REG_STATUS),
> > +};
> > +
> > +static const struct regmap_access_table tps65218_volatile_table =3D {
> > +	.yes_ranges =3D tps65218_yes_ranges,
> > +	.n_yes_ranges =3D ARRAY_SIZE(tps65218_yes_ranges),
> > +};
> > +
> >  static struct regmap_config tps65218_regmap_config =3D {
> >  	.reg_bits =3D 8,
> >  	.val_bits =3D 8,
> >  	.cache_type =3D REGCACHE_RBTREE,
> > +	.volatile_table =3D &tps65218_volatile_table,
> >  };
> > =20
> >  static const struct regmap_irq tps65218_irqs[] =3D {
> > --=20
> > 2.2.0
> >=20
>=20
> --=20
> balbi



--=20
balbi

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrq9oAAoJEIaOsuA1yqREmdAQALGlZ6yhVNQt4o3Vwb7qjwkM
0Ipz4/196hi0q0gkoQQCh7hyR5p8oATFPbDPfOjuTEQ1Bg5csdxm6Ow1NtOWZK1f
NZqi3qBugqd052ntBd0795gPHiUTe4ARntVgdh8cHEWiKVRWdq6nFYkKBpAC6p3n
byGFZOtwQkE1x9t+wWtxWzXmk2+Yh11NH8jGk0YBTdPZFMpZeWle6aeOxpMvAES3
taEpz/wmuWJj2z/cUck51Ha+k1fv5Nd73jRS1Dre45XGMoCIDCJqZwEw7lL5kZho
3X4fbX6kthTUSMn++WwNf0pab5drDP/zcrf2fNpR4t16E3wW7YGJk+e961uV2lKB
V9X86X879stnsWm5lCMf6cSXWcrNamFxZX8yvaufxLX+qHurD5JFG7g2lMVdq8Jq
COoaObnc8n7be5fdSxcn9e0m+4fQkFPfAKxdBMr9vxZFxOyta7YAabarYBiKKkJm
uF/2VPE5DcXAkn6F6MEN023wusmjEqRAQ+BwBMZ359XLJfaCRZI8Kg8+I2/nnNg0
/pJKOXql2ky6Euxsgwej5yGZWBEAbT5c68hvr00qWRq2NAQ8SeAWuah8kGPeF55j
bOsOpg1V2F9mlVg3oU7QCEfiL5YOVGaleSqGFjEvwi8m1IFD1KUON/4ln4jGRJeW
CI8YH00hYkgAR7aTdVJl
=/k33
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
