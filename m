From: Felipe Balbi <balbi@ti.com>
Subject: AM33xx's PWM Time Base Clock Enable signals
Date: Wed, 20 Feb 2013 14:36:24 +0200
Message-ID: <20130220123624.GA16652@arwen.pp.htv.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46491 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932390Ab3BTMg3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 07:36:29 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul, Tony,

how do you guys want to handle PWM's Time Base clocks which are enabled
via control module ?

They're controlled via offset 0x664 (pwmss_ctrl). Page 793 of AM33xx's
TRM has more information:

"
Table 9-42. pwmss_ctrl Register Field Descriptions

Bit	Field		Type	Reset	Description
31-3	Reserved	R	0h
2	pwmss2_tbclken	R/W	0h	Timebase clock enable for PWMSS2
1	pwmss1_tbclken	R/W	0h	Timebase clock enable for PWMSS1
0	pwmss0_tbclken	R/W	0h	Timebase clock enable for PWMSS0
"

We don't have clock nodes for those, but they're needed to have
functioning pwm drivers.

cheers

--=20
balbi

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRJMNHAAoJEIaOsuA1yqRELWsP/i5WUwsFmrmGw2XCC2HRYsIW
QBIwCRtdL2TYAN6e1k3We9AFyZqitiG4N4eyc4MHM3oBbDJxMSn9JKF5Jei8BR/j
pHqNtidz+EO/0v0iAgadcIiDDkIvgK3ejeWAOPXSmBrq+gYMnvoA5qSJQii02jQt
GgiyU4+IWCXwnBDC8/iO+CdJxHlstY/pQomYDWQD1/jSw6Yd2FK+SXwetY8VyyaD
sXpJZ7z/7bonBFjfpCkmxArICFGBJZtzT1BZQFxFpKydM65MHWkRoLeqfD1ndzTG
s6jtS+D/nc2CBa72BQUuATdaeSNgOY0OtrZynz/UY+PzpcUEe/PAB06Yxm6+D5Zr
Y1uuL2oTvFmw3Dd2HdPevz5Kqhku2hK+iruVLDuHtpdXld/86zBzoZR7EobvKlbi
vg8KsI/RCR5Jkz1FXpmZ7aqk1XRIW5Z7A8vUexc//HB2Ql/qW5krHxbHqorx5X+8
/Vft9WEUF+5U9S4kbDwzHfSkunux0Fleg1kt4uF0u8Fgw4EHwCTqvlAXMoCPNN97
d+piLCxaNrIIyt4pDsFiIAgT+f4C1hVT6nfKWd7HH5sKy5XC6ftnhAbheVf6GBu+
oAhemUtECUBnOE3Bb3tjtZnQlJmJ9sY2rYIUYYuOEd7gt/eulWCQYw8crWFp4niD
eRb7EwdiHUdqbakgjtxo
=5QNa
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
