From: Felipe Balbi <balbi@ti.com>
Subject: Re: reset handling in am335x hwmod data
Date: Fri, 17 May 2013 16:50:22 +0300
Message-ID: <20130517135022.GH14133@arwen.pp.htv.fi>
References: <87ehij8lpb.fsf@dell.be.48ers.dk>
 <alpine.DEB.2.00.1212232033030.8937@utopia.booyaka.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tcC6YSqBgqqkz7Sb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36101 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756030Ab3EQNu5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 09:50:57 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1212232033030.8937@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

--tcC6YSqBgqqkz7Sb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Dec 23, 2012 at 08:58:13PM +0000, Paul Walmsley wrote:
> > In this specific case the pin is connected to nCONFIG of a FPGA. The
> > FPGA is commanded to start configuration from a SPI flash in the
> > bootloader, so it can happen in parallel with kernel
> > load/uncompress/startup, but as the kernel resets the gpio during
> > initialization this doesn't work.
> >=20
> > Digging a bit into it, I see the hwmod of the gpio controller is
> > configured to reset at startup, and it works correctly (E.G. the pin is
> > left asserted) if I change it to HWMOD_INIT_NO_RESET:
> >=20
> > --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> > @@ -992,7 +992,7 @@ static struct omap_hwmod am33xx_gpio1_hwmod =3D {
> >         .name           =3D "gpio2",
> >         .class          =3D &am33xx_gpio_hwmod_class,
> >         .clkdm_name     =3D "l4ls_clkdm",
> > -       .flags          =3D HWMOD_CONTROL_OPT_CLKS_IN_RESET,
> > +       .flags          =3D (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
> >         .mpu_irqs       =3D am33xx_gpio1_irqs,
> >         .main_clk       =3D "l4ls_gclk",
> >         .prcm           =3D {
> >=20
> > Now the question is why is this configured like this?
>=20
> This behavior is intended to decouple the kernel from the bootloader, or=
=20
> previously-booted operating system (e.g., the kexec case).  The original=
=20
> goal was to place the system in an known safe state as soon as possible=
=20
> after the kernel starts.  This is to prevent misconfigured or=20

there is one "issue" with this. At least on AM335x starter kit, GPIO0_7
is used as DDR power pin. If we reset that GPIO bank, DDR looses power
and "for obscure reasons" (:-)) the board doesn't boot.

In this case, we cannot reset that bank, otherwise Starter Kit will
never boot in mainline. Bad PCB design, I know, but it's not something
we can change now :-)

cheers

--=20
balbi

--tcC6YSqBgqqkz7Sb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRljWeAAoJEIaOsuA1yqREA2oP/1+qZrYXdKpXVnZqh3CKJj4e
31CS9qSAbIlsF/yErQwPR6XQdRyvczkGZJUekCWftoM/MPZdBMct3xSvtNqR8sI8
EmSc1ON3i/GS3/1PVB6a3d+9Qcci1iLcjFwGOVtbIfd9OpeFuFjPClIltnR/JDih
LCnv59Lz77ZDG/Ln2trtTY5+LKZcRtxwrR9Aws50B171gln/7LcALsTrQmqA1czV
LFTnvoGlqRBWemjtIlZbYgddRExvsD0hNLPSoF7xGSG1kowH/QMwIwUVj6Xlbd0i
yByOyQL4q4s4Qv4FwSIglhkcrimz443uMokUwNXbaZ7Q5V4zdOIAl4xtj8peWhTQ
EqJDlM5QmE0c0zzjgOOU2/2Hlf7MQLJkfo2pMsSdSXciFINTNUpVJvqbGYFDTFPZ
YL9n3OREBxDZgXo+gDiNHgR6mYYil6GMu8dGwuhPu/8WehfvR+kiOvH3tq4RkK4v
YF8LhfUaxdwD39GB2JuI3XFvdSape/SIxmOlAWvvxCiIl2QO3i3huPBL1b/9/w7F
YE0DpWhE0Bixzch3GdFnTXYbFNooaD1IUd4hEnrHHvBO4SZ3TwlOJwu7t7Pi5mIo
CvhQxSlBQz+U+2fbhR3DTd6g0JL9Zvo5aFVOrQUL1MewEkWZ7PRh0ArzezudgGsW
8EH4LjQ/mPn0iBsq7b6g
=SM9I
-----END PGP SIGNATURE-----

--tcC6YSqBgqqkz7Sb--
