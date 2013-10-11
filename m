From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v7 1/6] mtd: nand: omap: combine different flavours of
 1-bit hamming ecc schemes
Date: Fri, 11 Oct 2013 06:53:27 -0500
Message-ID: <20131011115327.GA25706@radagast>
References: <1380916188-24206-1-git-send-email-pekon@ti.com>
 <1380916188-24206-2-git-send-email-pekon@ti.com>
 <20131007112728.GA15365@e106331-lin.cambridge.arm.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA1F3DC@DBDE04.ent.ti.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA2122E@DBDE04.ent.ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39447 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246Ab3JKLyU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Oct 2013 07:54:20 -0400
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA2122E@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: "computersforpeace@gmail.com" <computersforpeace@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, Pawel Moll <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "tony@atomide.com" <tony@atomide.com>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "olof@lixom.net" <olof@lixom.net>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pekon,

On Fri, Oct 11, 2013 at 05:17:48AM -0500, Gupta, Pekon wrote:
> > > If I have my NAND formatted with one of the existing ECC schemes (e.g.
> > > OMAP_ECC_HAMMING_CODE_DEFAULT) will it work with the new
> > > OMAP_ECC_HAM1_CODE_HW scheme?
> > >
> > > Are they all compatible?
> > >
> > Yes, they all are 1-bit hamming code, the only difference between
> > xx_Default and xx_HW was who was doing the ECC calculation.
> > For xx_DEFAULT: ECC calculation was done on CPU via s/w library
> > For xx_HW: ECC calculation was done by in-build h/w engine.
> > So, all HAMMING_xx can be replaced by HAM1_HW.
> >=20
> > [snip]
> >=20
> > > > @@ -1342,9 +1342,7 @@ static void __maybe_unused
> > > gpmc_read_timings_dt(struct device_node *np,
> > > >  #ifdef CONFIG_MTD_NAND
> > > >
> > > >  static const char * const nand_ecc_opts[] =3D {
> > > > -	[OMAP_ECC_HAMMING_CODE_DEFAULT]		=3D "sw",
> > > > -	[OMAP_ECC_HAMMING_CODE_HW]		=3D "hw",
> > > > -	[OMAP_ECC_HAMMING_CODE_HW_ROMCODE]	=3D "hw-
> > > romcode",
> > > > +	[OMAP_ECC_HAM1_CODE_HW]			=3D "ham1",
> > > >  	[OMAP_ECC_BCH4_CODE_HW]			=3D "bch4",
> > > >  	[OMAP_ECC_BCH8_CODE_HW]			=3D "bch8",
> > >
> > > Won't this break existing dts which have "sw", "hw", or "hw-romcode"?
> > >
> > > Someone may try to use a new kernel with an old dt, and we marked them
> > > as deprecated, not removed.
> > >
> > HAMMING_xx ECC scheme was used only on legacy platforms, when
> > BCH8 was not available, I have not seen anyone using this scheme
> > *from mainline kernel* from quite a long time. So, it's safe to remove =
them.
> >=20
> > This is what was concluded as per below email.
> > http://lists.infradead.org/pipermail/linux-mtd/2013-September/048876.ht=
ml
> >=20
>=20
> This patch-series and its follow-on series has already missed many merge
> windows, And the above discussion has reached a stalled state (infinite l=
oop)
> where, I cannot revert some DT binding updates to and fro to keep all leg=
acy
> DT bindings backward compatible forever.
> However, I can assure that these DT updates make binding stable for long-=
term.
>=20
> So now it's your discretion to whether to accept or leave following 2 ser=
ies:
>=20
> http://lists.infradead.org/pipermail/linux-mtd/2013-October/048983.html
>=20
> http://lists.infradead.org/pipermail/linux-mtd/2013-October/049008.html
>=20
>=20
> AFAIK no-one is using Hamming based ecc-scheme on OMAP platforms
> *from mainline kernel*. So this DT update actually does not affect users
> I know of. Rather these patch series was intended for long term scalabili=
ty
> and clean-up so that more OMAP users migrate to mainline kernel easily.

wouldn't something like below maintain backwards compatibility ?

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 579697a..f33ffe0 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1383,6 +1383,10 @@ static int gpmc_probe_nand_child(struct platform_dev=
ice *pdev,
 			if (!strcasecmp(s, nand_ecc_opts[val])) {
 				gpmc_nand_data->ecc_opt =3D val;
 				break;
+			} else if (!strcasecmp(s, "sw") ||
+					!strcasecmp(s, "hw") ||
+					!strcasecmp(s, "hw-romcode")) {
+				gpmc_nand_data->ecc_opt =3D OMAP_ECC_HAM1_CODE_HW;
 			}
=20
 	if (!of_property_read_string(child, "ti,nand-xfer-type", &s))

--=20
balbi

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSV+a3AAoJEIaOsuA1yqREgnwP/ipebUtU4npH+0rFz/wdd9xq
nmg53KpYV5Y4tfi61OkOg7YHhmQcKuw+y4KjNfMfQbwQtd9WD4lQGLc+/g7Kzd1T
9Zi2FgNdtGnU3O4qkkYIHYDSPtHS3PpP3/lkLoSEV/+SCTEqHMXUhyBsZb72apqx
pN9YQ982MILXTXRrC+7g1+N+S3qx+POrpEiN1d7vrh8WOjDgQkam2VY8fchwJVHk
Lq4yoBP9j9U1kAbiZxFuhMM9LR+IkFO8AtWCNWyeYn57oue/GoY52UZM8bVFSVvK
P0JeT4J8RBl8jWp9D2aoTl5T0YrsWdR28BgGZHkboFqlgRTG4xfi/HEZPZuZkio4
DDZH1q/bpVqh+VqtmTEyjZXoedkpJ4BdwlJsndswluiJxlMz7Y7NRyJixrsPcYcN
7cKKlzU8rWuNPN0Gj06Kt+HIqiWyVEwd1qvQ0/u48ykJCfMRIysUIJh9seCJeg35
3uAr0Gq9FJtmdz9N4IZZtQ5Lya7O5hQayzb1XrPoDEl+NhmYUP5NMSyqywJ3ntvW
VKFzds+xcRg2xbhPLn5xX7C9oYoWrEWNjOFm0xXv+d8/fhhhMP01T3oGszgxShkw
RJJKE4X7Ann5dfmJVNfIlaWVOjEfP5GOVQmPmoI+YkL/kPGGHBnYN6RWq2UVs+1i
489OFwZjAFD0f+Ds3Ft2
=MAQO
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
