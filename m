From: Felipe Balbi <balbi@ti.com>
Subject: Re: v3.19: Nokia N900 - usb nokia gadget crash
Date: Mon, 2 Feb 2015 16:17:13 -0600
Message-ID: <20150202221713.GB30753@saruman.tx.rr.com>
References: <201501311006.11909@pali>
 <201501311025.09553@pali>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38308 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753850AbbBBWRa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Feb 2015 17:17:30 -0500
Content-Disposition: inline
In-Reply-To: <201501311025.09553@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 31, 2015 at 10:25:09AM +0100, Pali Roh=E1r wrote:
> On Saturday 31 January 2015 10:06:11 Pali Roh=E1r wrote:
> > Hello,
> >=20
> > when I try to modprobe g_nokia.ko gadget module on n900
> > device, it produce tons on lines to display and then crash
> > and reboot device. So its not working and I (without Nokia
> > (TM) serial console I cannot debug it).
>=20
> When I compile g_nokia into zImage (not as external module) then=20
> it kernel loads correctly and usb is working.
>=20
> Any idea why g_nokia as external kernel module cause problems,=20
> but compiled into zImage is working??

what I got here is a WARNING from f_phonet only, I'll look into it. Keep
in mind I don't have N900 available, testing with beagleboneblack and
AM437x SK.

--=20
balbi

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUz/dpAAoJEIaOsuA1yqREZYQP/RJk5xqbDk2FNzwAKAI355to
n5GSU6gGkmQk/ybbYXhBbEr8GLaMut5dED6bhmfQeOTcsc4RJ8jQlwV5Pzw2o/Sx
V177LW/KcdwgNxK1XWZ8pqsr7SKyasmXQ39MyMzlivXRYPGwwrtN7FtPuqL9ozE8
RBXXrMuV+XtKqXXzQ7fSrDobTW/7EBq4Uv/rDQy7dlgujeLFPDc/cmDtB8fbhXUC
aTA0X8ykiagUpHJd7KLSh9J6969doFGKgSZPJa2gWPYDH4xnGD/FLYWv9I3l2BAl
huuffR1DZUDlRgXZN/x+zcGQ7CbB/0lhaQiJo6TUdgjOPtjjuxNjust1TcXWW/0y
xdSP2DkuQmMp1GtAOIqigXthRDPLbR1umW2r9/4CzY2zL+sssfBdJqC2AlP/8aZ/
D2Jhn/WE6GU6F7RRt3KdWR2+SKY6fWFAZwNtXRZGWS/jjKXpCntmEHo+xvCFHIEX
uHEatn29BOevRMc96p2sFrY3gy6Urm+1ERk+BNMQDdO+il0yGMMgouLg5X5spEIT
npBgj78eUDyjbaQmGpPCo00XuKZ/Mi6Oitv/1y743jRvQgips+OgAJS2MYdi3fsc
CB+f+aNYDjYPl78bvU/ji0+ie9gfMzl8zW0mR1s2wGJipu3DXspQzpNAvFroybjA
jhyjGI+dRuORq8aMVkbj
=n51L
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
