From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] MAINTAINERS: add omap2plus_defconfig under OMAP SUPPORT
Date: Mon, 19 Jan 2015 15:55:58 -0600
Message-ID: <20150119215558.GW20386@saruman>
References: <1421703901-28295-1-git-send-email-balbi@ti.com>
 <CABxcv=keBgUme5mrNKg_h_h1WZHsaz4QOOyEPLa3XJYaEPE0Jw@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7kW37LRKoI6fR2de"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60308 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbbASV5X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Jan 2015 16:57:23 -0500
Content-Disposition: inline
In-Reply-To: <CABxcv=keBgUme5mrNKg_h_h1WZHsaz4QOOyEPLa3XJYaEPE0Jw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>

--7kW37LRKoI6fR2de
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2015 at 10:52:56PM +0100, Javier Martinez Canillas wrote:
> Hello Felipe,
>=20
> On Mon, Jan 19, 2015 at 10:45 PM, Felipe Balbi <balbi@ti.com> wrote:
> > omap2plus_defconfig is also part of the OMAP Support
> > maintained, because of that it's best to list it
> > under OMAP SUPPORT on MAINTAINERS so people know
> > to Cc linux-omap when patching that file.
> >
> > Reported-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 97de006f38f0..abc6281892e7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6783,6 +6783,7 @@ Q:        http://patchwork.kernel.org/project/lin=
ux-omap/list/
> >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-=
omap.git
> >  S:     Maintained
> >  F:     arch/arm/*omap*/
> > +F:     arch/arm/configs/omap2plus_defconfig
>=20
> While been there, could you please also add omap1_defconfig?

Sure, Tony, is that ok ?

--=20
balbi

--7kW37LRKoI6fR2de
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUvX1uAAoJEIaOsuA1yqREiU4P/3PouirBlJA1No2GDTI77HXe
gTkbojaoLet/VkdICpGAmP9fHvcxXbGThRmF/HK1Dm0LlHYFfsyvjUMB29RhjdBr
eJXlXjSLIYnaDidybF7APL3Hua2DThgq8r1rYvfZdaP/v/SoZGM+jqbB4YdMxKwQ
jXl0+5dMghbE4Gypw01KifIAC0eqz5FTmuKKoAVx4NFlEtkZm7drtGD/JGi1D2v7
kOfqMfIOKivc+oOWwC/LjHVz5yvGmjamt8KUNMJIWC1yp3DIHQMU1wyvMCACNguc
Zc1KvQIxIhuHiJK1oxyRm+pd8rP7aZEupqqbrVQtqEOelwXQlbpuY1ho9JtjoOHN
/O1MDQQcsaMXoacvpq12vDiot3CnfM/Kc+nD4I965XAAQxHbDBY+hfd6FbzFloU4
4qlv+uK/UYlnPlQUbS4flTPBQRPVrAdGRmVRP1zIyyHHobQdv0A7BB0vN6PwQPm3
Sn5/XX8p0qTz/e8Ivw2hqpk+FwDCymDJ200pn1NE2sriOh5pSpNsEYu6DOh1RgBm
bRUCVW5saWenTfxzgVsHrqs8cJp7eMiKGkuUhubRUBJoKO30VOmDaJwzeuKyQGG4
VcUXdcp6DKLJwKLvgfdjhlNqlLtHR0ohliDLG6s0j2MnfFRLeyuB9nKkbGk2mW96
rWohd+26j0qH2xIUpC93
=izTI
-----END PGP SIGNATURE-----

--7kW37LRKoI6fR2de--
