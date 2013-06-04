From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Request for OMAPDSS testing
Date: Tue, 4 Jun 2013 10:40:37 +0300
Message-ID: <51AD99F5.7060506@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2IPOQQUHCLGVUFCONTFCV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40170 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759981Ab3FDHkx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Jun 2013 03:40:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Igor Grinberg <grinberg@compulab.co.il>, Thomas Weber <weber@corscience.de>, Mike Rapoport <mike@compulab.co.il>, Steve Sakoman <steve@sakoman.com>, =?windows-1252?Q?Gra=9Evydas_Ignotas?= <notasas@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

------enig2IPOQQUHCLGVUFCONTFCV
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi guys,

I've made some big changes on the omapdss device model, which involves
converting all the panel drivers. I've got only a bunch of boards, so I
hope some of you can perhaps do some minimal tests on some other boards.

I've got: Beagle (old one), Panda, 4430SDP, Overo with LCD43.

The code can be found from the below git branch. It's based on 3.10-rc1.

git://gitorious.org/linux-omap-dss2/linux.git work/dss-dev-model

All you need to do to get things working is to enable the new panel
drivers from kernel config, under Device drivers/Graphics support/OMAP2+
Display Subsystem support/OMAP Display Device Drivers/

Thanks in advance!

 Tomi


------enig2IPOQQUHCLGVUFCONTFCV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRrZn1AAoJEPo9qoy8lh71jisP/3Kg2fW0NSq55rBZic7/aPAj
JI51zY/v2xGZzXeBzuYEbnXUz7hiNpH610iVH9IfEjxM+bvGuzdpze+MrCj+yC2f
EqkK4TXhj9FQn2BOoEcQB6Iifyth21JdbPV86mBuGrvtaifvgr1FVSuTqWj4s6uz
6t3hye7G4V+fowlMW0CeTJ6RUVfW61HVoY08Jg6T3kikb1MkwEvx1/stdQ/wUEEz
ArkJ/K1sVtBgKkATU4Bwl4N3O80K07pFRpvUd/LKzbJXIc1v7rukESyITH2kkSDD
PeoeUNuB5cztPujaDBAvRcwppOvTmLC73pZEfuiyoIBmkpcOzExWUQDT89H6sw7n
EP4xij3tQYpqL7jomJHS2rNEFqseHBLzJ5OEVObc3RPzfAJ0alCIOoA2MYTC/s5x
BL5QNQrO3NpbX+UB/+TB5fFB2wXA1WG1/tfdVgvFAGn5ysb56HhZcZM1wKIJoVAE
0muuO3P22kF/6rufYAyEuMTMARAaZOGsZEXAzn9voEYhY9IANyaxMpqfpOv/LX94
W/UYuWCk+z0vPD+z1ySWq6ulxwR6Ql8flZP+sO+Y4cWbTeavScEXs91doY1HONUF
9uF+/o4mq897+3/h7CtgYl9K4pvtytYSwG0DLANySKq8ejjJNf4/a/cud3SzUbJJ
Pn2XnHXY398VJureUjUT
=brM0
-----END PGP SIGNATURE-----

------enig2IPOQQUHCLGVUFCONTFCV--
