From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 23/62] ARM: omap1: fix building without 32K_TIMER
Date: Wed, 19 Mar 2014 15:01:00 -0500
Message-ID: <20140319200100.GB4271@saruman.home>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-24-git-send-email-arnd@arndb.de>
 <20140319195913.GA4271@saruman.home>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38063 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752716AbaCSUDQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Mar 2014 16:03:16 -0400
Content-Disposition: inline
In-Reply-To: <20140319195913.GA4271@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2014 at 02:59:13PM -0500, Felipe Balbi wrote:
> Hi,
>=20
> On Wed, Mar 19, 2014 at 08:29:20PM +0100, Arnd Bergmann wrote:
> > If we enable CONFIG_OMAP_MPU_TIMER and CONFIG_OMAP_DM_TIMER but
> > not CONFIG_OMAP_32K_TIMER on OMAP1, we currently get this build error:
> >=20
> > mach-omap1/pm.c: In function 'omap1_pm_idle':
> > mach-omap1/pm.c:123:9: error: 'enable_dyn_sleep' undeclared (first use =
in this function)
> >   while (enable_dyn_sleep) {
> >          ^
> > mach-omap1/pm.c:123:9: note: each undeclared identifier is reported onl=
y once for each function it appears in
> >=20
> > This attempts to fix the #ifdef logic to deal with all combinations
> > of timers.
> >=20
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: linux-omap@vger.kernel.org
> > Cc: Tony Lindgren <tony@atomide.com>
>=20
> I had sent a fix for months and months ago, what happened to it ?

Here

http://marc.info/?l=3Dlinux-omap&m=3D138963632408031&w=3D2

Tony, did you forget to send a pull request ?

--=20
balbi

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTKfd8AAoJEIaOsuA1yqRExhUQAKOdQHawljufSAhU4oXHmc90
ZNo5UpfJ/oUo19CerXy07xzYrEuZD798oVxtdYYuT+4VA1OxfruEqjUK2mDG3q8X
rUbCYNvnivhtvyCGPa+Nq2UcbB/vJs8eqICXodHGd2hycVLgsvRidJAaBsRVgxiV
FxubWt9E4ftDt81QMNjgMAanZsztt/cWuc+onHoR9FGt1U9ozuoX2P2MR8m7ygw8
d9uqX1j4b9QyE4EvIOteIEgzK6BYVN0XT/BJysFNvxNQgX40tXjcqyrgDn4i7GmR
IqKf1Q2+umYSrjm0RMv80ilsLxmZmUzveBIQESvgHmCeS/E8C+2KaaFWGW1wdtP9
oFQAirDii6UTGEdyQUvRok7FpZtLzm5W9FTpMMHERjFZ+w1pe7NlfoQyQJiaB1yR
ZHKg3LKBSX/eIpzWP/s1y2wTSsz34GX/7PMfBxGDWtNmzEVBP01L9wLKYf7fIMXe
SQX0FG/OxtOiOXMrwz+zJo531BDrGGUBdtM/zfhPlFrtjk0apwnTzQqYg75dk3wt
7iJEZuIec4XWLug6rX1rxQNZjlcYx6W9noYQMNrkRUYLIFhJX9QZzZBYUhR95zLH
FWpcqdjHpejYgbYCK/AtsuEkYC0v41EGBGQduQY5fX+mhcO7+GY6SS9pM/Zi1D8+
uhoqkE7Kl6KMVgkZ000n
=tayR
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
