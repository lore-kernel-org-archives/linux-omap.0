From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2 1/3] omap2: Change clk dev id for rng to omap3-rom-rng
Date: Fri, 20 Sep 2013 20:24:50 +0200
Message-ID: <201309202024.50755@pali>
References: <1379534757-20870-1-git-send-email-pali.rohar@gmail.com> <201309201841.16197@pali> <20130920174640.GA2684@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1969082.1HyIFDAd4T";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:39985 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775Ab3ITSYz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Sep 2013 14:24:55 -0400
In-Reply-To: <20130920174640.GA2684@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Russell King <linux@arm.linux.org.uk>, Joe Perches <joe@perches.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart1969082.1HyIFDAd4T
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 20 September 2013 19:46:41 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [130920 09:49]:
> > On Friday 20 September 2013 18:23:43 Tony Lindgren wrote:
> > > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [130920 06:33]:
> > > > Name omap_rng is already used by omap_rng driver which
> > > > is for omap2 and omap4. For omap3 HS devices there is
> > > > new driver omap3-rom-rng which needs that clk. And
> > > > because there cannot be two drivers with same name,
> > > > rename omap3 clk dev id.
> > > >=20
> > > > Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > > > ---
> > > >=20
> > > >  arch/arm/mach-omap2/cclock3xxx_data.c |    2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c
> > > > b/arch/arm/mach-omap2/cclock3xxx_data.c index
> > > > 334b767..5059338 100644
> > > > --- a/arch/arm/mach-omap2/cclock3xxx_data.c
> > > > +++ b/arch/arm/mach-omap2/cclock3xxx_data.c
> > > > @@ -3274,7 +3274,7 @@ static struct omap_clk
> > > > omap36xx_clks[] =3D {
> > > >=20
> > > >   */
> > > > =20
> > > >  static struct omap_clk omap34xx_omap36xx_clks[] =3D {
> > > > =20
> > > >  	CLK(NULL,	"aes1_ick",	&aes1_ick),
> > > >=20
> > > > -	CLK("omap_rng",	"ick",		&rng_ick),
> > > > +	CLK("omap3-rom-rng",	"ick",		&rng_ick),
> > > >=20
> > > >  	CLK(NULL,	"sha11_ick",	&sha11_ick),
> > > >  	CLK(NULL,	"des1_ick",	&des1_ick),
> > > >  	CLK(NULL,	"cam_mclk",	&cam_mclk),
> > >=20
> > > Hmm are you sure the omap_rng is not available on
> > > any of the omap3 GP versions? If so, the omap_rng
> > > alias should be kept as well.
> > >=20
> > > Regards,
> > >=20
> > > Tony
> >=20
> > I really do not know, but driver char/hw_random/omap-rng.c
> > support only omap2 and omap4 platforms. So "omap_rng" dev id
> > for omap3 is not used.
> >=20
> > In email [1] you suggested to use clk_get instead
> > clk_get_sys. If I understand correctly clk_get calling
> > clk_get_sys with driver name. So dev in in CLK macro must
> > be same as driver name. And because in cclock3xxx_data.c is
> > dev id "omap_rng" and there is already driver with name
> > "omap_rng", I need to rename dev in cclock3xxx_data.c to
> > get new omap3-rom-rng driver working.
> >=20
> > Or if you know better way how to do it, let me know.
>=20
> I think it's safest to keep the existing alias also, and
> add a comment saying that it may not be available on omap3
> processors.
>=20
> Regards,
>=20
> Tony
>=20
> > [1] - https://lkml.org/lkml/2013/4/1/278

Ok, then there is new patch which only adding omap3-rom-rng and not removin=
g omap_rng.
It is OK to have same CLK data but with different names?

diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap2/cc=
lock3xxx_data.c
index 334b767..03a2829 100644
=2D-- a/arch/arm/mach-omap2/cclock3xxx_data.c
+++ b/arch/arm/mach-omap2/cclock3xxx_data.c
@@ -3275,6 +3275,7 @@ static struct omap_clk omap36xx_clks[] =3D {
 static struct omap_clk omap34xx_omap36xx_clks[] =3D {
 	CLK(NULL,	"aes1_ick",	&aes1_ick),
 	CLK("omap_rng",	"ick",		&rng_ick),
+	CLK("omap3-rom-rng",	"ick",	&rng_ick),
 	CLK(NULL,	"sha11_ick",	&sha11_ick),
 	CLK(NULL,	"des1_ick",	&des1_ick),
 	CLK(NULL,	"cam_mclk",	&cam_mclk),


=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1969082.1HyIFDAd4T
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlI8kvIACgkQi/DJPQPkQ1I2wwCfWpyqveQAhKTFTB/dhlx+b9rJ
hYgAn3ChXf3Szz/FE4V32kNjlfku0ObI
=RCyt
-----END PGP SIGNATURE-----

--nextPart1969082.1HyIFDAd4T--
