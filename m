From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] OMAP3 ROM Random Number Generator support
Date: Sun, 31 Mar 2013 11:28:12 +0200
Message-ID: <201303311128.12698@pali>
References: <201302281905.48546@pali> <201303281854.02847@pali> <20130328214411.GZ10155@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4508047.TXkkfaCaca";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130328214411.GZ10155@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Juha Yrjola <juha.yrjola@solidboot.com>, Russell King <linux@arm.linux.org.uk>, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?q?=D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE?= =?utf-8?q?_=D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=80=D0=BE=D0=B2?= <freemangordon@abv.bg>
List-Id: linux-omap@vger.kernel.org

--nextPart4508047.TXkkfaCaca
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 28 March 2013 22:44:11 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [130328 10:58]:
> > Here is new version of patch:
> >=20
> > --- a/arch/arm/mach-omap2/devices.c
> > +++ b/arch/arm/mach-omap2/devices.c
> > @@ -486,6 +486,23 @@ static void omap_init_mcspi(void)
> >=20
> >  static inline void omap_init_mcspi(void) {}
> >  #endif
> >=20
> > +extern u32 *omap3_rom_rng_call(u32 id, u32 proc, u32 flags,
> > u32 va_ptr); +
> > +static struct platform_device omap3_rom_rng_device =3D {
> > +	.name		=3D "omap3-rom-rng",
> > +	.id		=3D -1,
> > +	.dev	=3D {
> > +		.platform_data	=3D omap3_rom_rng_call,
> > +	},
> > +};
> > +
> > +static void omap_init_rom_rng(void)
> > +{
> > +	if (!cpu_is_omap34xx() || omap_type() =3D=3D
> > OMAP2_DEVICE_TYPE_GP) +		return;
> > +	platform_device_register(&omap3_rom_rng_device);
> > +}
> > +
> >=20
> >  /**
> > =20
> >   * omap_init_rng - bind the RNG hwmod to the RNG
> >   omap_device *
>=20
> This driver probably only works on Nokia boards because of the
> different SMC call numbering. Until it's been verified on some
> other HS omap34xx, I'd probably register this only from the
> Nokia board-*.c file.
>=20

=46reemangordon, can you look at this smc and errara 430973 code if=20
they could be merged? Really omap3_rom_rng_call function looks=20
like n900 specific.

Link: https://lkml.org/lkml/2013/3/28/398

> > --- /dev/null
> > +++ b/drivers/char/hw_random/omap3-rom-rng.c
> > +static int omap3_rom_rng_probe(struct platform_device
> > *pdev) +{
> > +	printk(KERN_INFO "%s: initializing\n",
> > omap3_rom_rng_name); +
> > +	omap3_rom_rng_call =3D pdev->dev.platform_data;
> > +	if (!omap3_rom_rng_call) {
> > +		printk(KERN_ERR "%s: omap3_rom_rng_call is NULL\n",
> > +		       omap3_rom_rng_name);
> > +		return -EINVAL;
> > +	}
> > +
> > +	setup_timer(&idle_timer, omap3_rom_idle_rng, 0);
> > +	rng_clk =3D clk_get_sys("omap_rng", "ick");
> > +	if (IS_ERR(rng_clk)) {
> > +		printk(KERN_ERR "%s: unable to get RNG clock\n",
> > +		       omap3_rom_rng_name);
> > +		return IS_ERR(rng_clk);
> > +	}
>=20
> You can use regular clk_get if you add the alias to
> struct omap_clk omap3xxx_clks table.
>=20
> Regards,
>=20
> Tony

Tony, can you show me how?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4508047.TXkkfaCaca
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlFYAawACgkQi/DJPQPkQ1J4eACgj3BxpHuap4RtxayaL9La1C9y
8vkAn1WzN6qDwLLOlk4ZvwJTweq/KnOT
=2mr3
-----END PGP SIGNATURE-----

--nextPart4508047.TXkkfaCaca--
