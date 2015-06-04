From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING] HACK: add global/private timers for A9
Date: Thu, 4 Jun 2015 15:08:50 -0500
Message-ID: <20150604200850.GF5710@saruman.tx.rr.com>
References: <1433363565-17725-1-git-send-email-balbi@ti.com>
 <2466648.WjMxjIpAUG@wuerfel>
 <20150603210455.GD6042@saruman.tx.rr.com>
 <20150603212821.GH6042@saruman.tx.rr.com>
 <556F7493.2060602@codeaurora.org>
 <20150603215445.GK6042@saruman.tx.rr.com>
 <55701E93.60303@free.fr>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E69HUUNAyIJqGpVn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39099 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103AbbFDULo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Jun 2015 16:11:44 -0400
Content-Disposition: inline
In-Reply-To: <55701E93.60303@free.fr>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Felipe Balbi <balbi@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Linux OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

--E69HUUNAyIJqGpVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 04, 2015 at 11:46:59AM +0200, Mason wrote:
> Also, check /proc/timer_list for a "Broadcast device". If you don't
> define one, the TWD timers are set to periodic mode, with hrtimers
> disabled.

Did you manage to turn global timer into Broadcast device ?

--=20
balbi

--E69HUUNAyIJqGpVn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVcLBSAAoJEIaOsuA1yqREs1wP/3MumWfenN6+ccdGKMapG0/W
24p52EN3KZFSFYg1Ywgb5JtQpXv8UZ0U4/jUCpcGu/xd7MuxmSQohSoxGJzhRzJW
PGd1y51VzqtmAoFAIiSJlzXHx/HM7Nv86lTaWzPdUDHEf59O65wB2Ra0nIZLwWff
c/fK0mSpM0p5pf4/KIxpR1IQtbGXfDvfi1eG60lLkLb13zMBudXgw3XA8u0AlMiI
Q/Syc7M3q3vZ9Jbu4uMyhdiD2bo7pJUrU2jofurrM2xvrDsphT8ciLORmbfQIkh0
qRv9yhQqp5nECJi/sGVjSJBA0b9bok9mR9ghEg07lQGDBjD/iRMl7J2001FFMoOO
l9ehNSdeqgTvA6ngb7DR8ZBgycOm2Kai4ou68jQEL4ClJz47QEsFeond6hyv/PTF
WUT+Euc7bBjbsWHrd1H6hWKM3WV5/+ieOuJs1iCHQxtME/Lj/EGX2RIXck3UXJQC
vVbNmQu66nBXEc9aMDeI8hyEBJ8NmMkwHhDqJQB38nj88VIGfPRXdO3ryh3VXBLT
tQCktgKwsb2LGzH7jg0y7AJwhBEsHg+rJw97hc8FpqOpL0u7kgOMaBDe/d6nlULe
MX0AS+T1jJaUZFrUHrlOcrslDoGUSO+fm8S5GeBj2HuvLHI6fagRnZeTDSkWdoBJ
rEiQYfAzaa1CVSkbO41g
=ICcI
-----END PGP SIGNATURE-----

--E69HUUNAyIJqGpVn--
