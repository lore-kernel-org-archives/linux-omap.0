From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/4] ARM: OMAP2+: Add board-generic.c entry for ti81xx
Date: Mon, 19 Jan 2015 14:42:01 -0600
Message-ID: <20150119204201.GQ20386@saruman>
References: <1421192272-20754-1-git-send-email-tony@atomide.com>
 <1421192272-20754-2-git-send-email-tony@atomide.com>
 <54B67461.9010402@cogentembedded.com>
 <20150115000713.GV2419@atomide.com>
 <20150119191833.GC18552@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QVgWX4+QEldMe/r9"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55749 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317AbbASUn3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Jan 2015 15:43:29 -0500
Content-Disposition: inline
In-Reply-To: <20150119191833.GC18552@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org

--QVgWX4+QEldMe/r9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2015 at 11:18:34AM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [150114 16:14]:
> > * Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> [150114 05:54]:
> > > Hello.
> > >=20
> > > On 1/14/2015 2:37 AM, Tony Lindgren wrote:
> > >=20
> > > >This allows booting ti81xx boards with with when a .dts
> > >=20
> > >    So, with, with or when? :-)
> >=20
> > Heh thanks will updated to:
> >=20
> > This allows booting ti81xx boards when a .dts file
> > is in place.
>=20
> This too needs to be in a separate ifdef CONFIG_SOC_TI81XX block
> to avoid make randconfig build errors. Updated patch below.
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
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -142,6 +142,42 @@ DT_MACHINE_START(AM3517_DT, "Generic AM3517 (Flatten=
ed Device Tree)")
>  	.dt_compat	=3D am3517_boards_compat,
>  	.restart	=3D omap3xxx_restart,
>  MACHINE_END
> +
> +static const char *const ti814x_boards_compat[] __initconst =3D {

should this definition be within that ifdef too ?

--=20
balbi

--QVgWX4+QEldMe/r9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUvWwZAAoJEIaOsuA1yqREaaIP/itQCRkuRBEEMvs6f2PmokWX
3+bA5lm3kUYKAczOeHNZ4lAS0sl4nhTIiSv5oLkbtGxdHPvjNqWicIkaq57r+VfH
nVN437/3Dw2Caqy6sme1TK1sHfyZJ9CSAhORhyAmqQlqwIBTM7B6qtiLjqSrsXy1
RxuVVxubskR1f19ew291j2mm2uhLWvtTXqHUWHICZ96GitsHnYezQh7pg4eFzrTI
j329bpdni1IX8JP6PDLM82Higo3Fen2uHYPFtuoAjrJ7MiP4bbASDqz3WuFa4JWI
5AgckQDiwrp2TbrnQpvn+wHq13nXzya8k2VOjYAhzjXu0IFAg9DoB8Z57FnzflN5
2M0A9ksVkH6iSoXLboNK9Ylurao6R4OP05pAjMXmVX8wav1RqpOIZs7QTHveiChv
52JCuB0vWnNKH3z+NQ5vI1wrNrHSNbC9eCGc/3OFkSw0Q5eiXHueDfRcw91yPPAI
k9NAkIYhWL3iIsZxfPmQ07bD7E3hSptvhImpf5kxdHfR/ufoVE0xm3K897gR67mm
bnZarkFnceNSHaKHkYGGVi0JbqcTJ0yKpQqimegQmdQ/NjPeghOzhOQMx2O6cFll
Ewffuk87RozXLavj7qpPlCcvOPPtKV5u8ZyEd0e1ZkHZtyrf9UXO8ucf7bhvtYG/
IgR45i2QJuT8O53kSrWx
=Absb
-----END PGP SIGNATURE-----

--QVgWX4+QEldMe/r9--
