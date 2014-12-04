From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap2: rx51-peripherals: fix build warning
Date: Thu, 4 Dec 2014 11:03:53 -0600
Message-ID: <20141204170353.GK18045@saruman>
References: <1417033655-32332-1-git-send-email-balbi@ti.com>
 <20141204152411.GF18045@saruman>
 <3261416.DL88JFJXUF@wuerfel>
 <20141204154835.GH18045@saruman>
 <20141204163930.GF2817@atomide.com>
 <20141204150012.2fb75907@recife.lan>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZG5hGh9V5E9QzVHS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36505 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932453AbaLDREW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Dec 2014 12:04:22 -0500
Content-Disposition: inline
In-Reply-To: <20141204150012.2fb75907@recife.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--ZG5hGh9V5E9QzVHS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 04, 2014 at 03:00:12PM -0200, Mauro Carvalho Chehab wrote:
> Em Thu, 04 Dec 2014 08:39:31 -0800
> Tony Lindgren <tony@atomide.com> escreveu:
>=20
> > * Felipe Balbi <balbi@ti.com> [141204 07:50]:
> > > Hi,
> > >=20
> > > On Thu, Dec 04, 2014 at 04:41:13PM +0100, Arnd Bergmann wrote:
> > > > On Thursday 04 December 2014 09:24:11 Felipe Balbi wrote:
> > > > > On Wed, Nov 26, 2014 at 02:27:35PM -0600, Felipe Balbi wrote:
> > > > > > commit 68a3c04 ([media] ARM: OMAP2: RX-51: update
> > > > > > si4713 platform data) updated board-rx51-peripherals.c
> > > > > > so that si4713 could be easily used on DT boot, but
> > > > > > it ended up introducing a build warning whenever
> > > > > > si4713 isn't enabled.
> > > > > >=20
> > > > > > This patches fixes that warning:
> > > > > >=20
> > > > > > arch/arm/mach-omap2/board-rx51-peripherals.c:1000:36: warning: \
> > > > > > 	=E2=80=98rx51_si4713_platform_data=E2=80=99 defined but not us=
ed [-Wunused-variable]
> > > > > >  static struct si4713_platform_data rx51_si4713_platform_data =
=3D {
> > > > > >=20
> > > > > > Cc: Sebastian Reichel <sre@kernel.org>
> > > > > > Cc: Tony Lindgren <tony@atomide.com>
> > > > > > Cc: Hans Verkuil <hans.verkuil@cisco.com>
> > > > > > Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> > > > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > > >=20
> > > > > a gentle reminder on this one.
> > > > >=20
> > > >=20
> > > > Let me add my
> > > >=20
> > > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > >=20
> > > > You didn't say who you expect to pick up the patch. I assume Mauro
> > >=20
> > > patch author now decides who takes the patch ? That's new :-)
>=20
> Well, for patches that cross subsystem boundaries, like this one,
> the best is to give a hint about whom you expect to pick it.
>=20
> In this specific case, as commit 68a3c04 is in my tree, the best is
> to merge the patch on it, as the patch may not even apply at Tony's
> tree.

pointing to the commit that caused the problem really isn't enough ? The
commit short description (which is also on my commit log) clearly
mentions "[media]".

Anyway, I'll do that next time.

> > > > should take it because he took the patch that caused the problem,
> > > > but he might not be aware that he should look at this now.
> > >=20
> > > He is in Cc, let's ask him :-)
> >=20
> > Best that this one goes in along with the other si4713 patches
> > to avoid dependencies between trees:
> >=20
> > Acked-by: Tony Lindgren <tony@atomide.com>
>=20
> Thanks! I'll merge it via my tree.

tks

--=20
balbi

--ZG5hGh9V5E9QzVHS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgJP5AAoJEIaOsuA1yqREDPEP+gIi4o+uo5uRQqmSCUSh+LCm
zImUUyhakT2lC3i6prYqMA/zGoEqURmU3CXOsvKhnTOJOs9DMv3VLG+O+/lOEWt5
+tgORK4CQExurjeyymvIIRc2jzIwwolpymu81CA4EOcMQZwb9UcibEiOXvv+MINK
+3XsUlsoxeLEIdk7v/1NrDxlgBl/Hmb3ImwOiY1u/4/bdwIp+gNSu8oQ37IxL88E
PkUs5o8ClbyAawCMV/yszCCSRUh6nroxXWDWrBEhXlkiLF0oEzHBvkiIGWWEwF3v
IYAilKiESzMelEeo8Psx3H0TM1ZLMpHhD3dD5tohyn9c7mRpWtvzmPhY90x1TAGQ
evIoPyFTQKnoz5tnKg38mamfMRLK16cRzN8MJC/0bDoipVxDHy3r8dvg/ctBRGXa
iAbIq0OswDOiaeH/bGI7B3uKWIRDhDVxzMO/T0hcmWjTsh2VQoYpBZ0QCUo+60UN
DmlvcE/ki4pvD8rr9oPqgOqy/NqdIk+BAKiHT0YSMFjt6jhJHx/FgmUxWh5nuvSC
06+Am8bgtCPUAeWb9beJqujPsCFrLfovEEZym1ULojvTgsditx92kY7dnkCkSt5V
Yky2iHxCuQjPJetpCHvYy3quB2H/2QLPvrGC7bcJTN4AW0zzJ2EnYDXhbGKsHXcJ
NjBlUOZkzyktEKgm90se
=4sIk
-----END PGP SIGNATURE-----

--ZG5hGh9V5E9QzVHS--
