From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC PATCH 4/4] USB: OMAP: Tahvo USB transceiver driver
Date: Thu, 7 Mar 2013 16:54:50 +0200
Message-ID: <20130307145450.GF16577@arwen.pp.htv.fi>
References: <1362667221-30659-1-git-send-email-aaro.koskinen@iki.fi>
 <1362667221-30659-5-git-send-email-aaro.koskinen@iki.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Y7d0dPL928TPQbc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58183 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932269Ab3CGOzF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Mar 2013 09:55:05 -0500
Content-Disposition: inline
In-Reply-To: <1362667221-30659-5-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

--1Y7d0dPL928TPQbc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2013 at 04:40:21PM +0200, Aaro Koskinen wrote:
> Add Tahvo USB transceiver driver.
>=20
> Based on old code from linux-omap tree. The original driver was written
> by Juha Yrj=F6l=E4, Tony Lindgren, and Timo Ter=E4s.
>=20
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  drivers/usb/otg/Kconfig     |   16 ++
>  drivers/usb/otg/Makefile    |    1 +
>  drivers/usb/otg/tahvo-usb.c |  643 +++++++++++++++++++++++++++++++++++++=
++++++

let's call this:

drivers/usb/phy/phy-tahvo.c

I'll rename all phy drivers in a bit.

--=20
balbi

--1Y7d0dPL928TPQbc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJROKo6AAoJEIaOsuA1yqREuNMP/iwlc6aZQ85s3AJhjHEVPzjq
Qv7FJF+4DzkEPPw2QM3l/Z4heWbTRXCPvlrYXcMFczwVXTxhqCM8FhXqquokCR+s
IqBG6Bjb/CbJxOKV3LojodDerIaZSSdshxWypJqQv1d40AKIdYC+KMuRbD/4cZCk
dITgovgoGoVxM5RRRzlhnh6MYyoOFx4Mbaai9Czvoz/QIPrara+WV6sDhcshNrOn
NCivWM6R4rDXzAHNDr62fxa+MFQD/Ka7vUknr3L+UMk22Vq9D88K+IPLvOD72eGZ
ruM11WrvDsjznHlIbu4ePI1gQlnisbFrq9ggvkglxroxwBhtr55n6YIb+II/CsdK
iHq67kM6MUJ0N4w6xRi+KRxFnXX1+UHCi4OLV2yc/JoBhjwq4J8omRiJCYz3yViN
L3tvIpVPuCRx6F+3vlWuOIq5Ipmams1mLZtJA0ivr18noCT3TkHI07meOhNthRoJ
X3VMI+G6ajf1NJBrsswr8MRSZSEK6WJTS+YtWvzl6vpZ64bo1bB4D5FLJy2bybiv
u0vomuzZj8qhspJURlS/imbpujwDUazYQvpBSXRJ3qCky0wcH0eRtv2Zf4jDEml3
IdDrG5eZ8wV0sCUMY2ZtKH8wn427Tluwc+XSX56Um+bnfIdH259MNS78GWjGpAMl
cisF8MctK8nNMdp/1QP/
=L9k7
-----END PGP SIGNATURE-----

--1Y7d0dPL928TPQbc--
