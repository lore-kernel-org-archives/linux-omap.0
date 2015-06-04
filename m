From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING] HACK: add global/private timers for A9
Date: Thu, 4 Jun 2015 15:18:25 -0500
Message-ID: <20150604201825.GG5710@saruman.tx.rr.com>
References: <1433363565-17725-1-git-send-email-balbi@ti.com>
 <2466648.WjMxjIpAUG@wuerfel>
 <20150603210455.GD6042@saruman.tx.rr.com>
 <20150603212821.GH6042@saruman.tx.rr.com>
 <556F7493.2060602@codeaurora.org>
 <20150603215445.GK6042@saruman.tx.rr.com>
 <55701E93.60303@free.fr>
 <20150604200850.GF5710@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G44BJl3Aq1QbV/QL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39426 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753772AbbFDUVO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Jun 2015 16:21:14 -0400
Content-Disposition: inline
In-Reply-To: <20150604200850.GF5710@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Mason <slash.tmp@free.fr>, Stephen Boyd <sboyd@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Linux OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

--G44BJl3Aq1QbV/QL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2015 at 03:08:50PM -0500, Felipe Balbi wrote:
> Hi,
>=20
> On Thu, Jun 04, 2015 at 11:46:59AM +0200, Mason wrote:
> > Also, check /proc/timer_list for a "Broadcast device". If you don't
> > define one, the TWD timers are set to periodic mode, with hrtimers
> > disabled.
>=20
> Did you manage to turn global timer into Broadcast device ?

arm_global_timer is marked PERCPU, so it will never be chosen as
broadcast.

--=20
balbi

--G44BJl3Aq1QbV/QL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVcLKRAAoJEIaOsuA1yqREAtEP+wbYqbhdi4S62NfYRznDcuVi
4w0Nb7We4y36RFJzmqX13EF4XTPfdx0C0GqcVXGRn3XcuS6PMU3uuWg5lGvU8eOd
/zILy4Z0JoF2uFaoVxAz96FO4WAzqi4tVYbFDLnCvzRyW/NBMtW79wwND+oq0/ZU
ubs4Z2jHdvHqHLLiznmCg2+bIZ1U+JizNUh9UisXBuOvuSTsvq1p+VB2CKdG0ek6
PCytPuSuPKJBGh0PBHyMpr9Q58ZbMrAC5o3URYDJ4yW+3v7A55R2zJhdiHpAl+oh
gXw/PMQtuX3aqVAQXYS65EwzCjVjPsHBguC8/bPByqfVqiNs/OTgG0LFvRh/QRiR
z8Ly+ANditXJxUsh6t0cgvKXhMo6USjBYTMMXGz+OZBnH9pUfTI+imc9St5Aktjc
kBYmO1ikCXOv3kJPtiHXGcjOUQL+dbwiueeFH7OMgNVTaIE8vw8JqaU0i2HTgq4E
d36YAqmevW8GVmj5NdhW8RMSGGJnPfdrBBD1a6WY1pTXFUXpc/Rzw1kCjzerp0kF
5efYDq4yMORXaHVI4Bj2EOgY4E49J0/V/EPUrLkjr441gIOO/Y6CqFCnpgd2iEJD
Q2BGsYgiliSxTxFR+axgePeYz9RLhe9ywPQzxDwSSYU9k4V9lF4SLxg2Uw+U9o1s
yTxWhqDbhketlVC+VbPs
=dz3C
-----END PGP SIGNATURE-----

--G44BJl3Aq1QbV/QL--
