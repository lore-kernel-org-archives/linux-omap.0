From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap2: rx51-peripherals: fix build warning
Date: Thu, 4 Dec 2014 09:48:35 -0600
Message-ID: <20141204154835.GH18045@saruman>
References: <1417033655-32332-1-git-send-email-balbi@ti.com>
 <20141204152411.GF18045@saruman>
 <3261416.DL88JFJXUF@wuerfel>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+G3HLlWI7eRTl+h"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32812 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751785AbaLDPtH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Dec 2014 10:49:07 -0500
Content-Disposition: inline
In-Reply-To: <3261416.DL88JFJXUF@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, balbi@ti.com, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--k+G3HLlWI7eRTl+h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 04, 2014 at 04:41:13PM +0100, Arnd Bergmann wrote:
> On Thursday 04 December 2014 09:24:11 Felipe Balbi wrote:
> > On Wed, Nov 26, 2014 at 02:27:35PM -0600, Felipe Balbi wrote:
> > > commit 68a3c04 ([media] ARM: OMAP2: RX-51: update
> > > si4713 platform data) updated board-rx51-peripherals.c
> > > so that si4713 could be easily used on DT boot, but
> > > it ended up introducing a build warning whenever
> > > si4713 isn't enabled.
> > >=20
> > > This patches fixes that warning:
> > >=20
> > > arch/arm/mach-omap2/board-rx51-peripherals.c:1000:36: warning: \
> > > 	=E2=80=98rx51_si4713_platform_data=E2=80=99 defined but not used [-W=
unused-variable]
> > >  static struct si4713_platform_data rx51_si4713_platform_data =3D {
> > >=20
> > > Cc: Sebastian Reichel <sre@kernel.org>
> > > Cc: Tony Lindgren <tony@atomide.com>
> > > Cc: Hans Verkuil <hans.verkuil@cisco.com>
> > > Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> >=20
> > a gentle reminder on this one.
> >=20
>=20
> Let me add my
>=20
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>=20
> You didn't say who you expect to pick up the patch. I assume Mauro

patch author now decides who takes the patch ? That's new :-)

> should take it because he took the patch that caused the problem,
> but he might not be aware that he should look at this now.

He is in Cc, let's ask him :-)

--=20
balbi

--k+G3HLlWI7eRTl+h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgIJTAAoJEIaOsuA1yqREmkgQAJbOaQVv2Ts4wCW6kZDFjcxh
56zbjudoCIFF8knez8ziGnRMfJrHjczm/RMSJ2JQjqWlknc+4infecXuFxfCOTv6
ko3EYyFf2NIH+PbN8aoGXDQymfy1yyLP4LOVAl5bCGx0lEvzh0Jj/d1jej1uBSds
j8QKsvjqPmARm9WDnl+PFC23i+/zzrMipZwyZD/pF+EgMcmI0C/TWJQi60nLqWkk
gW3U+poot5zNZD7uUrOOZf3n3vZFw2gUbmRjpbzXXXmgXa377u5029PXDSYIyRB8
4UMh7KqXpdGyuowhh2+q2YxR0Z60ivwsxWygWmwbZJFyoqPv1etu5r++/rCK0Nee
kzat1YPudDG0HwHCTA5uKz5pcPwEGFO/xZSZFmNGif1ghRKatWVNj7dWAnXvnAKG
T8iIultV8utc3LNGVD9RFyxvYQMqM202ZJhKDGpPAWxC0m28Kdlvj0MRdOBARgva
sgMPpo1t1vyqFyqHsVbXo59fx8rD4rj/ZryNT0H8TVei+TzxexYZsGcfjOCv5wOB
hbGAzaCRDxI3Vw9hVYlLcSJJAk1XDLIQhmH3KXDxA051RoeeUbSHNOAs5/7Lbegm
9BXdiSEKJE2IjgPP5O9laW2hO5FAsFxtbYfDnoC8X91KLqjiaaWwQgCT81qMgaZL
0klY0y/y8+wv9LRR4y+5
=WGaf
-----END PGP SIGNATURE-----

--k+G3HLlWI7eRTl+h--
