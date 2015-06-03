From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING] HACK: add global/private timers for A9
Date: Wed, 3 Jun 2015 16:04:55 -0500
Message-ID: <20150603210455.GD6042@saruman.tx.rr.com>
References: <1433363565-17725-1-git-send-email-balbi@ti.com>
 <2466648.WjMxjIpAUG@wuerfel>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48798 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753AbbFCVHo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Jun 2015 17:07:44 -0400
Content-Disposition: inline
In-Reply-To: <2466648.WjMxjIpAUG@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2015 at 10:55:27PM +0200, Arnd Bergmann wrote:
> On Wednesday 03 June 2015 15:32:45 Felipe Balbi wrote:
> >=20
> > Hi Tony and Russell,
> >=20
> > AM43xx, even though it's a single processor A9, it still has TWD and gl=
obal
> > timer. I was doing some profiling with RT v4.0 and latency is 3.5x lowe=
r just
> > by switching from gptimer to twd/global.
> >=20
> > The only problem is that currently, is_smp() check prevents me from usi=
ng twd
> > with AM43xx (that's why it's commented below, for testing purposes).
> >=20
> > In the hopes that we can start a, hopefully, small thread around the su=
bject,
> > I'm sending this HACK which I used to get TWD and global timer enabled =
so I
> > could measure latencies with cyclictest.
> >=20
> > Is it so that TWD shouldn't be available on UP integrations of ARM's Co=
rtex-A
> > processors ?
> >=20
> >=20
>=20
> I wondered about this recently when looking at something unrelated
> and noticed that the check had been introduced as part of
> 904464b91eca8 ("ARM: 7655/1: smp_twd: make twd_local_timer_of_register()
> no-op for nosmp").
>=20
> I suspect this was just the wrong fix at the time, and that the
> real culprit is either alloc_percpu() or request_percpu_irq()
> getting called too early on a machine without SMP support.
>=20
> Possibly the problem is already resolved independently, if you
> didn't run into it.

no, no splats, nothing at all. See [1]

[1] http://hastebin.com/helekubutu

--=20
balbi

--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVb2v3AAoJEIaOsuA1yqREQdcQALRHC/6lQbZtb7xnjcU39MiC
HP/kQOgTRQzP9JKUnnykRkzD3kJN8/ucc9QbBjenyDS4CZmbEAq8rxq7WxRNzl/d
Tq3SPaLERQRc9NQlgXnHP9VNFKPREpF8p60n9nfag003xpZZ6eHmKLqRfT4+uQdw
huU5zh8XMa02MyXxDeL2Hbmy8H0XPM6aqIqaMpQAbHwP6uIkCF+HY4L6D4dev1IV
Hjo5/FmNs+bon0B8WyAY9icYeebYF7lgmqxSL2+Hp14RuAs4w6cDZqKDz5uCQQgx
TPQVkyUps+P4ciKXF270/rancwe00EvfM0xbJApZ5vOtk9qLxcKFD1ZI9UDGDyCb
+kO7E9aWNjuiZQQ22yVCKzZ4glYWZrCmNTM5Pqn8uDcxtlI2/FdZk8u7BrtrAiUL
ztkg6jsR+BrxW/qidu/iajBeRfCSfylcD2aLRe/ulkQQmhNebKYdQllWERyAGGll
IAg3Fi7PojhufXxlOSFDlL2tf4d5Py/W5jLSauZddkOnwDepGkscfKW8JSoDnaSV
kRk/V3li68kRQDf52Z3FWAvw8UpHOHssWLK+KZUvjXTVKhGiCfb7qpcDNH740tY0
XHsr1x/Tg/zAG9Zi2BVtoqrHJzILWg7D1K4EElebgSh/eQIRWX3NbdSuNlZWwGWk
FDEJHNSSoFhfFjS/1loU
=ee6V
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--
