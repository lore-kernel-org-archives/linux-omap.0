From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/5] mfd: tps65218: make INT[12] and STATUS registers
 volatile
Date: Mon, 12 Jan 2015 10:46:54 -0600
Message-ID: <20150112164654.GB6525@saruman>
References: <1419622104-25812-1-git-send-email-balbi@ti.com>
 <1419622104-25812-2-git-send-email-balbi@ti.com>
 <20150106173734.GL6502@saruman>
 <20150108162512.GC31926@saruman>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150108162512.GC31926@saruman>
Sender: linux-input-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, stable@vger.kernel.org, Keerthy <j-keerthy@ti.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 08, 2015 at 10:25:12AM -0600, Felipe Balbi wrote:
> On Tue, Jan 06, 2015 at 11:37:34AM -0600, Felipe Balbi wrote:
> > On Fri, Dec 26, 2014 at 01:28:20PM -0600, Felipe Balbi wrote:
> > > STATUS register can be modified by the HW, so we
> > > should bypass cache because of that.
> > >=20
> > > In the case of INT[12] registers, they are the ones
> > > that actually clear the IRQ source at the time they
> > > are read. If we rely on the cache for them, we will
> > > never be able to clear the interrupt, which will cause
> > > our IRQ line to be disabled due to IRQ throttling.
> > >=20
> > > Fixes: 44b4dc6 mfd: tps65218: Add driver for the TPS65218 PMIC
> > > Cc: <stable@vger.kernel.org> # v3.15+
> > > Cc: Keerthy <j-keerthy@ti.com>
> > > Cc: Lee Jones <lee.jones@linaro.org>
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> >=20
> > ping
>=20
> another ping. Without this and the following patch TPS65218 power button
> driver which was already applied by Dmitry, won't work.

Anybody ? -rc4 is out and tps65218 is still broken because nobody has
acted on these two patches. All other patches which are meant for 3.20
merge window are applied and because of these pending, those patches
won't work.

> > > ---
> > >  drivers/mfd/tps65218.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >=20
> > > diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> > > index 0d256cb..2243f75 100644
> > > --- a/drivers/mfd/tps65218.c
> > > +++ b/drivers/mfd/tps65218.c
> > > @@ -125,10 +125,21 @@ int tps65218_clear_bits(struct tps65218 *tps, u=
nsigned int reg,
> > >  }
> > >  EXPORT_SYMBOL_GPL(tps65218_clear_bits);
> > > =20
> > > +static const struct regmap_range tps65218_yes_ranges[] =3D {
> > > +	regmap_reg_range(TPS65218_REG_INT1, TPS65218_REG_INT2),
> > > +	regmap_reg_range(TPS65218_REG_STATUS, TPS65218_REG_STATUS),
> > > +};
> > > +
> > > +static const struct regmap_access_table tps65218_volatile_table =3D {
> > > +	.yes_ranges =3D tps65218_yes_ranges,
> > > +	.n_yes_ranges =3D ARRAY_SIZE(tps65218_yes_ranges),
> > > +};
> > > +
> > >  static struct regmap_config tps65218_regmap_config =3D {
> > >  	.reg_bits =3D 8,
> > >  	.val_bits =3D 8,
> > >  	.cache_type =3D REGCACHE_RBTREE,
> > > +	.volatile_table =3D &tps65218_volatile_table,
> > >  };
> > > =20
> > >  static const struct regmap_irq tps65218_irqs[] =3D {
> > > --=20
> > > 2.2.0
> > >=20
> >=20
> > --=20
> > balbi
>=20
>=20
>=20
> --=20
> balbi



--=20
balbi

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUs/p+AAoJEIaOsuA1yqREgwcP/2mtgstsUjTlygR4ldbWCDfo
+4qZK1VfgW4IUCz73WIgt0q5h9Py3A7sUtc0sFmWu3aDHlStrp/i0PPTeNBbFOqi
tKdKdAsm0cFXGZ8HpSiv0bWMrvp22x/AGg8a5kn8IkLvJ/J0vAHZtGKvwTbvIwVd
EbR+UiZ9m8fRnE/uZcD6XlKD3YAMie6TWfrFfRWQT4srzFfBxnGF92AGWLij0kS9
2bZcVPb4Ps1P7ZAIrDhY9qO7BwyeZKPt2NIBQ3eAzqF+J4hq4fRcdwETuV6we/m/
2SDDaaBRGuVsAqzzX0BGNUgPfZsHxpgkY2VpTSZXLFxnPn9DNURs0QB8IxW92BG1
lgeksR3lgmmc0X1rF+xj33Y8hIHG9ZgDn7RwXN9jHRNzHg2BXM/7pnK0YPMQWFMQ
b/8Yx7HDLSCDeiEf6qY3pTvl7NZWuFS8xkDZ6H+715g+7IpBPKkdl3MZPRKHfXzd
5kuXpW0zrcU44rHZkF1zu0fyIWtjDHiaVyfYAu9Oc7SMSKWValAXRiRsTUUwLo/4
eZJgLBPimjr13FS1zBkS5vfKkbwhfI8jG60ijC8L9L/6z6owjRpGCc/FkmlAdXOL
9zW5z+BkLcjccKorsXNsaBZEV0aJLUix+vv1wd4o5TisI810slTRFM+TmH6mkitA
fWMlYrwKtkLrlChsyKSu
=r7NH
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
