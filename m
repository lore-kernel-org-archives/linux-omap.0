From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/4] ARM: OMAP2+: Add board-generic.c entry for ti81xx
Date: Mon, 19 Jan 2015 15:10:24 -0600
Message-ID: <20150119211024.GT20386@saruman>
References: <1421192272-20754-1-git-send-email-tony@atomide.com>
 <1421192272-20754-2-git-send-email-tony@atomide.com>
 <54B67461.9010402@cogentembedded.com>
 <20150115000713.GV2419@atomide.com>
 <20150119191833.GC18552@atomide.com>
 <20150119204201.GQ20386@saruman>
 <20150119210544.GG18552@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v15hXiddb3kq3Bam"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56853 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752096AbbASVLh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Jan 2015 16:11:37 -0500
Content-Disposition: inline
In-Reply-To: <20150119210544.GG18552@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org

--v15hXiddb3kq3Bam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2015 at 01:05:45PM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [150119 12:46]:
> > On Mon, Jan 19, 2015 at 11:18:34AM -0800, Tony Lindgren wrote:
> > > * Tony Lindgren <tony@atomide.com> [150114 16:14]:
> > > > * Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> [150114 05:5=
4]:
> > > > > Hello.
> > > > >=20
> > > > > On 1/14/2015 2:37 AM, Tony Lindgren wrote:
> > > > >=20
> > > > > >This allows booting ti81xx boards with with when a .dts
> > > > >=20
> > > > >    So, with, with or when? :-)
> > > >=20
> > > > Heh thanks will updated to:
> > > >=20
> > > > This allows booting ti81xx boards when a .dts file
> > > > is in place.
> > >=20
> > > This too needs to be in a separate ifdef CONFIG_SOC_TI81XX block
> > > to avoid make randconfig build errors. Updated patch below.
> > >=20
> > > Regards,
> > >=20
> > > Tony
> > >=20
> > > 8< -----------------
> > > From: Tony Lindgren <tony@atomide.com>
> > > Date: Mon, 19 Jan 2015 10:38:07 -0800
> > > Subject: [PATCH] ARM: OMAP2+: Add board-generic.c entry for ti81xx
> > >=20
> > > This allows booting ti81xx boards when a .dts file
> > > is in place.
> > >=20
> > > Cc: Brian Hutchinson <b.hutchman@gmail.com>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > >=20
> > > --- a/arch/arm/mach-omap2/board-generic.c
> > > +++ b/arch/arm/mach-omap2/board-generic.c
> > > @@ -142,6 +142,42 @@ DT_MACHINE_START(AM3517_DT, "Generic AM3517 (Fla=
ttened Device Tree)")
> > >  	.dt_compat	=3D am3517_boards_compat,
> > >  	.restart	=3D omap3xxx_restart,
> > >  MACHINE_END
> > > +
> > > +static const char *const ti814x_boards_compat[] __initconst =3D {
> >=20
> > should this definition be within that ifdef too ?
>=20
> Oops yes totally thanks for catching that. Updated patch below.
>=20
> Regards,
>=20
> Tony
>=20
> 8< -----------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Mon, 19 Jan 2015 10:38:07 -0800
> Subject: [PATCH] ARM: OMAP2+: Add board-generic.c entry for ti81xx
>=20
> This allows booting ti81xx boards when a .dts file
> is in place.
>=20
> Cc: Brian Hutchinson <b.hutchman@gmail.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -144,6 +144,42 @@ DT_MACHINE_START(AM3517_DT, "Generic AM3517 (Flatten=
ed Device Tree)")
>  MACHINE_END
>  #endif
> =20
> +#ifdef CONFIG_SOC_TI81XX
> +static const char *const ti814x_boards_compat[] __initconst =3D {
> +	"ti,dm8148",
> +	"ti,dm814",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(TI81XX_DT, "Generic ti814x (Flattened Device Tree)")
> +	.reserve	=3D omap_reserve,
> +	.map_io		=3D ti81xx_map_io,
> +	.init_early	=3D ti814x_init_early,
> +	.init_machine	=3D omap_generic_init,
> +	.init_late	=3D ti81xx_init_late,
> +	.init_time	=3D omap3_gptimer_timer_init,
> +	.dt_compat	=3D ti814x_boards_compat,
> +	.restart	=3D ti81xx_restart,
> +MACHINE_END
> +
> +static const char *const ti816x_boards_compat[] __initconst =3D {
> +	"ti,dm8168",
> +	"ti,dm816",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(TI816X_DT, "Generic ti816x (Flattened Device Tree)")
> +	.reserve	=3D omap_reserve,
> +	.map_io		=3D ti81xx_map_io,
> +	.init_early	=3D ti816x_init_early,
> +	.init_machine	=3D omap_generic_init,
> +	.init_late	=3D ti81xx_init_late,
> +	.init_time	=3D omap3_gptimer_timer_init,
> +	.dt_compat	=3D ti816x_boards_compat,
> +	.restart	=3D ti81xx_restart,
> +MACHINE_END
> +#endif
> +
>  #ifdef CONFIG_SOC_AM33XX
>  static const char *const am33xx_boards_compat[] __initconst =3D {
>  	"ti,am33xx",

--=20
balbi

--v15hXiddb3kq3Bam
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUvXLAAAoJEIaOsuA1yqREtmIQALT/yGS1409m8ZI0h0G3ciwo
XN1+oyLf8sgpzr9qLIitJvtW0V8vuisWAr9iKnHNJSQ8eOzaQlHZWE64Juh5S1nA
nJh4AemdccH5CO/1VqRggo8blvIYFVt2+95LehdKyczDRPNd0RqX3ESSIKYC78yy
QGgdkc7uQ2Yr2Ju0rjLr7hEAXmfSC42DvmIGKrCJF+kgRJEFcoULnPgifLmITm1/
NulZWP7b/MZIH2p3K6QGp7U4OPjkaYrKSK8792zSE0+qeeK/9Sv4GC2x42+eiwp3
Rn3UK+C1dWOj3tywy0csy1AsHruEO3VbP2SCxFA3mGlMthzGY9eiDzaaTk77WSk5
epLA7A9k4gqlr70n8OUZykRDsvYl6i2YK8ul+KxxCmfYIVlvuRDT6UD2w3O82mgv
WSNxhkBwXiJD2bqhmcMeuWR03WN0xn95QTZgbwKopBJlzyJiD+qOHYoFJP9uyLTQ
YBBUr0tB0kmZIgMRn8aUVaX2uern5wfIVBRhGNQcZwQfopJxdwEqoTYD9RESeUS/
RgssQD7TuIkE0o61bKAXSjN/w8ggHD1sFUjyJwaK8lUK7SUU48rEi/yEWHIN1rSO
KICR8lXtDVYjhmKIz6W1eZ5ateiZm20sqxpQ8+/ByvfpNUlRYQe8jJpdbhdeRSSQ
VHmjs0t7kCRY+IUyS33a
=Mrhc
-----END PGP SIGNATURE-----

--v15hXiddb3kq3Bam--
