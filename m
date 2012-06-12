From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)
Date: Tue, 12 Jun 2012 14:05:14 +0300
Message-ID: <1339499114.2392.35.camel@deskari>
References: <1336982138.2532.32.camel@lappyti>
	 <alpine.DEB.2.00.1205151148440.16649@utopia.booyaka.com>
	 <1337159300.7692.22.camel@deskari>
	 <alpine.DEB.2.00.1205241022180.2572@utopia.booyaka.com>
	 <1337934288.2842.19.camel@deskari>
	 <CAORVsuWrWXFR7cnBGD+R4omKRjCCvkhHhOVhR_tj=gjA0tUyVA@mail.gmail.com>
	 <WC20120612101510.1001B1@terrafix.co.uk> <1339497424.2392.22.camel@deskari>
	 <WC20120612105024.5601BD@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-ALNKd+3diEJ4dbErs9nA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:40581 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750918Ab2FLLFT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 07:05:19 -0400
Received: by lbon10 with SMTP id n10so501622lbo.27
        for <linux-omap@vger.kernel.org>; Tue, 12 Jun 2012 04:05:17 -0700 (PDT)
In-Reply-To: <WC20120612105024.5601BD@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Paul Walmsley <paul@pwsan.com>, khilman@ti.com, Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org


--=-ALNKd+3diEJ4dbErs9nA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-06-12 at 11:50 +0100, Joe Woodward wrote:
> -----Original Message-----
> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> To: Joe Woodward <jw@terrafix.co.uk>
> Cc: Jean Pihet <jean.pihet@newoldbits.com>, Paul Walmsley <paul@pwsan.com=
>, khilman@ti.com, Archit Taneja <a0393947@ti.com>, linux-
> omap@vger.kernel.org
> Date: Tue, 12 Jun 2012 13:37:04 +0300
> Subject: Re: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)
>=20
> > On Tue, 2012-06-12 at 11:15 +0100, Joe Woodward wrote:
> > > Was there ever a conclussion to this discussion?
> > >=20
> > > I'm assuming this is unlikely to be fixed in 3.5?
> >=20
> > If by conclusion you mean full understanding and a proper fix, then no.
> >=20
> > But the patch 3568f2a46f2a73bab18c914df06afd98a97e0e0e (OMAPDSS: use
> > DSI_FIFO_BUG workaround only for manual update displays) has been
> > merged, and that should circumvent the problem.
> >=20
> > Are you still seeing problems?
>=20
> I haven't tested any kernels since 3.4, I normally wait till a later rc a=
nd had missed that patch...
>=20
> If I have any problems I'll report them, but assume it's fixed otherwise.

If the problem is visible on plain 3.4 series (i.e. without any extras,
like PM patch series or such), and the commit fixes the problem, perhaps
I should the patch for 3.4 stable series? The commit applies cleanly to
v3.4.2.=20

 Tomi


--=-ALNKd+3diEJ4dbErs9nA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP1yJqAAoJEPo9qoy8lh71Gt0P/RcuHuezG7EqBk0cUhxjJnl0
Twhiwq/RH0bxxIylRGvtJrf1AJgVk8HFIT4q8CIWv27A7oT9is4y5mXQN7eXLeg7
dvGz/VCBvEac1UafWk+XJEtFfdZM51tIEeZ3DZH0xm/UHzwhVF/ReGDkZkbqrZtJ
fm6vIFfDALqo0PmC3M7SAD9N20rFrfPiwLKQWYOPf3ObpoX0vnJEtcj7wEpu3ioJ
3Rly0UG9brZefdkbi8OY+LgrbUVkwyFMvB0230QMxip8RaB4vA6EhV2A8U+gwGwC
zqp3fkso0+lTeZwEkZYXxCEnVXov/B4Y6TMPgxMcvZ1UXQPUM0/DlCdCTMWgEck1
EOCI95y+FSLLWOVN/KLn+n7lfoAeVdiRXem+kt5MIQ4VvdY8SfVbAliJjlaYGKcB
f6A9UwHMH7NnHcBzkZUiBHMOtpF8UQJ9n8bfHcATlZ6//9nuVbKy5UqjO6SVqWza
X7NghtVaLRcUjotQifXCCTVga7ZTSwvK9oSoULlBF0x4TzlFEtqu3lUI0RaJ4NBY
K8/zJtbvrALqCwczILbytnVGee3qUJEC//9MgSFLU8jrG+gN55dCtOpV32Ki74XC
dhg//M9Wew6jJYMpD1kLz0QMhRPSeAvJSOmIYiKS5ivesUOLThMEhn6ca+UAFllL
xFxS7pdG/m02Jmzn7HSz
=Osv7
-----END PGP SIGNATURE-----

--=-ALNKd+3diEJ4dbErs9nA--

