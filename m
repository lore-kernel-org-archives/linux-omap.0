From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] OMAP4: 4430sdp: OTG: increase max allowed output current
Date: Wed, 15 Aug 2012 09:05:27 +0300
Message-ID: <20120815060525.GF23637@arwen.pp.htv.fi>
References: <1342099542-13862-1-git-send-email-ruslan.bilovol@ti.com>
 <CAAe_U6Kza7Zc2SF-ve761Kb2_0Q-9K19qkAZ2eahh-AHrsfh8w@mail.gmail.com>
 <CAEa47Nqu_b_KGou30u64gsQC_Qwz-X=P9_a5YRTTCCE0mwS2mg@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w2JjAQZceEVGylhD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:49787 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751204Ab2HOGJQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Aug 2012 02:09:16 -0400
Received: by lahm15 with SMTP id m15so817500lah.17
        for <linux-omap@vger.kernel.org>; Tue, 14 Aug 2012 23:09:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAEa47Nqu_b_KGou30u64gsQC_Qwz-X=P9_a5YRTTCCE0mwS2mg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, balbi@ti.com, tony@atomide.com, linux-omap@vger.kernel.org


--w2JjAQZceEVGylhD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 18, 2012 at 12:43:22PM +0300, Ruslan Bilovol wrote:
> Hi,
>=20
> On Fri, Jul 13, 2012 at 8:53 AM, ABRAHAM, KISHON VIJAY <kishon@ti.com>
> wrote:
> >
> > Hi,
> >
> > On Thu, Jul 12, 2012 at 6:55 PM, Ruslan Bilovol <ruslan.bilovol@ti.com>
> > wrote:
> > > TWL6030/32 that is used on 4430sdp board can deliver up to 200mA
> > > for OTG port power supply in the HOST mode.
> > >
> > > Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
> > > ---
> > >  arch/arm/mach-omap2/board-4430sdp.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/board-4430sdp.c
> > > b/arch/arm/mach-omap2/board-4430sdp.c
> > > index 8e17284..10223f5 100644
> > > --- a/arch/arm/mach-omap2/board-4430sdp.c
> > > +++ b/arch/arm/mach-omap2/board-4430sdp.c
> > > @@ -429,7 +429,7 @@ static struct platform_device *sdp4430_devices[]
> > > __initdata =3D {
> > >  static struct omap_musb_board_data musb_board_data =3D {
> > >         .interface_type         =3D MUSB_INTERFACE_UTMI,
> > >         .mode                   =3D MUSB_OTG,
> > > -       .power                  =3D 100,
> > > +       .power                  =3D 200,
> > >  };
> >
> > Shouldn't this change be made for omap4 panda as well.
>=20
> Yes, omap4 panda uses same TWL IC. Should I fix this patch or send
> separate for panda?

Fix this patch would be nicer.

--=20
balbi

--w2JjAQZceEVGylhD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQKzwlAAoJEIaOsuA1yqREZuQQAKwVJYfca9ROh+hgYuyitp0/
Cwv6bXw37II5o1B6EG4m78ss1cutgHpdzcxgS2ray8x9tQjF554GJ2N7ba+3ru9v
Yp1NYYr8yFN5CWZfvbTthtiTwumJA1FuqNOhAhEfUlbCLsfFgofQXOQ/RgsCBspo
hUWytl8hdee34ShkT9UTF1jRN6VTj5yvsbz3aDd0gcZGMBVpeL+EVlJ857XixhC4
8grRh4qsIrUifKLwowqrxf/qpyUVe+z6xM3A+xQ0HlsaL9UhlxF6oF7XpmGV9yij
gjh9Q74zYIBgOPvHohkORK4IGnpbyOnRphi9EGpgg+LrzHk2XnwXpx9HOX0njl6D
5Ky2o9OYXofm+5i+gcJ7eVzYD86erM3f4QfUQSFR8ov6TEszclB8omRX8UIrEZ6v
gQNqrrn6fqHI+Tv1Vk4BBU6ec9fQNpr18wHe0Gd0JYXug2Jr2sNy58FpnOMXdE9z
GuruQLvSeKl7UlTpjErLXAKLHVq6Wgt7+V+riYIGcr0he7JWA4ZSH5Blz9A32qO2
tMMvYyxxo8lZ0bq9SGvTxmJj3RfnpHzLc5zEonb2sERGO4e/Y5v7nVQEz94t3DGj
uh5nszcMKtVdp+2JbTrABRYmRFAf7dPYmi6TOtQjlY5zrvKvLv0X7pVYB+LG+2jH
Jh7Jy321cNkEKzTK5ISO
=ESXj
-----END PGP SIGNATURE-----

--w2JjAQZceEVGylhD--
