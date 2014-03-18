From: Felipe Balbi <balbi@ti.com>
Subject: rts-gpio DT binding
Date: Tue, 18 Mar 2014 11:55:36 -0500
Message-ID: <20140318165536.GH14373@saruman.home>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPDwMsyfds7q4mrK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51353 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753933AbaCRQ5Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Mar 2014 12:57:24 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@newflow.co.uk>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--ZPDwMsyfds7q4mrK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

I'm looking at the omap-serial driver and saw that you added rts-gpio
binding in commit 4a0ac0f55b18dc297a87a85417fcf068658bf103 (OMAP: add
RS485 support) but, as it turns out, gpio0_13 and gpio2_15 are both
actual RTS signals.

Instead of adding that extra GPIO handling, why didn't you just mux
those signals as RTS and enable auto-RTS/auto-CTS feature ?

It looks to me like that's highly unnecessary binding.

--=20
balbi

--ZPDwMsyfds7q4mrK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTKHqIAAoJEIaOsuA1yqREfUYP/0oWAaeCXMe268zPEB9mQ3Th
mOYV99aNDRvfiSkERkWaljFrgXCRMtSxw8cNLeTBXtwrRU8np01kLvfetONC8YXO
fusdduQknM0f1bHh82qwAs/meQL5IsJbqkOfp3UgQur8PP47bGrL03rk8pixgQps
GhYn2nzBMkuwL5cGCAqdHq0H0ORF1DGEsBDcStL1DViOj9IX6XD0P1WUTrA8HK7Z
mxQRbZ2FeIUYOTqHmElcbyuX2FwMIGq+n8zdXY8xlVHCYG8gu/D8pU9KAVuX5ksM
evfUTPIdHQ29D/ko5+z3xkMynPsQStlXeEatMLdIdclqh9ujNyzI+b/bFvkFXKdz
70Ra1gv7Scaath9SdRvE45WPGJuYSZO0wsNIfLtYQk7wCVUK3GLIJvVlILGyGLu4
1na44+qdS7LZyLdVgpN6QkRGYqJFFrR1qvOt+wwfosyG8a4EzIJ7bTQmReRoM+4Z
38aGXSTpUrGQiAWc31kzQjy55qWLpy18HJcMd9DcqzMxaaIlZ2vNXgDFn0Djf2sT
1wakXFEhm7xhcAghC/xZkFmqIt1i0w1926PFJ3TYUfhl0eP8goHp7z+m7UOSGAGe
cMMQZctljobqUuAyXgELgfXjFQpbC5G7bw+2OKWljrqRzqaX7z2PVTeQy9YAd3Tr
kHE5nsbhcW5Jel/wlExB
=rZRi
-----END PGP SIGNATURE-----

--ZPDwMsyfds7q4mrK--
