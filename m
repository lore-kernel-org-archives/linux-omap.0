From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/26] OMAPDSS: DT support (Christmas edition)
Date: Fri, 13 Dec 2013 17:47:49 +0200
Message-ID: <52AB2C25.6000507@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <1703598.NbqXAMAFOI@avalon> <52AADBE0.3030203@ti.com> <3426377.keoaFgiZkl@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="k6imFEirtv9CVKcUsUjuG1E0jqToT7cSj"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33164 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653Ab3LMPsD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Dec 2013 10:48:03 -0500
In-Reply-To: <3426377.keoaFgiZkl@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>

--k6imFEirtv9CVKcUsUjuG1E0jqToT7cSj
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Laurent, Tony,

On 2013-12-13 16:37, Laurent Pinchart wrote:

>>> - dsi_enable_pads, dsi_disable_pads: Those don't seem to be used in
>>> mainline. What's their purpose, and how are they implemented on platf=
orms
>>> that make use of them ? Is the pinmux API an option ?
>>
>> They are used in mainline, grep again =3D).
>=20
> The only implementations I can find in arch/arm/mach-omap2/display.c ar=
e
>=20
> static int omap_dsi_enable_pads(int dsi_id, unsigned lane_mask)
> {
>         return 0;
> }
>=20
> static void omap_dsi_disable_pads(int dsi_id, unsigned lane_mask)
> {
> }

Yep. It seems Tony removed the muxing for -rc2 in
e30b06f4d5f000c31a7747a7e7ada78a5fd419a1 ARM: OMAP2+: Remove legacy mux
code for display.c

Tony, that patch removes DSI muxing, which is not done via DT. I can't
test right now, but I presume DSI displays don't work at all after -rc2.

 Tomi



--k6imFEirtv9CVKcUsUjuG1E0jqToT7cSj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSqywlAAoJEPo9qoy8lh71HvIQAKyzyIWDHV78evvz46ui0P98
JVEqVfMQLBRa/dOiUvsQQyAc7+A/3QNm6SIsBNgpu33iwEtr82DJ/lxC69IjA9Uh
P0OHdRbcBslI/X/qH8ZWRYZye5TKHrr8Gvo1fbeSaGH8hnTwz0ikwojv+AYR8wYa
1nvisQnHEEvQ4IvBTIX0X3nI9/h9fCUqHD1eYfK6uPGdPGbX3g3WB+noTRxRUaY0
3YbW/zrZw71hSRqcyEqhfdMv2niexm91u61/PgkdPxsAmOmjtMdQiYQ6aiddL6t2
PKpp+rlJZBAbUgNC36sKYQBZO7Ccl/7+oMMbhyDPT9v5uVJhaUR0dUwiQgWlIra6
+Aew30W9T/qaZ5504Vx6kPcVDfXVFKBfNkteOuzKj1qUPyOD33ihkC9TCXAGwC6S
HNYTw1N51iRNQ/B6s8cHiynqh/G+pyK4IfYpOXztHO+Ue0inaT4FpkmfgrmZeQLo
jOrYUS+F0pPq3hEpaNyokzxWGXiJSuFtuCSXmXrUmw8mJXTsfbe9qSTUukbiP3HH
DcqSgb4MdV46PSfmPPCg+FcCJIjFQrYQQAph0Nd3aF3aPSYP1CaUODYJcXTlS2MN
efaC4JaLR4Hk087f0Sv8JIhrEjenH0A4D6InFlrET0qV6AifiYe48KfX5/kjRYl2
FfQiBaaTXKQHEiMc2yVe
=7dfu
-----END PGP SIGNATURE-----

--k6imFEirtv9CVKcUsUjuG1E0jqToT7cSj--
