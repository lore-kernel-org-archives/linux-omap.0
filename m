From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Display related board specific boot args
Date: Fri, 22 Mar 2013 10:26:01 +0200
Message-ID: <514C1599.7080803@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC4ADB67ADD67D27C6C037BFE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55841 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932853Ab3CVI0E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Mar 2013 04:26:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

--------------enigC4ADB67ADD67D27C6C037BFE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tony,

As you probably know, Overo is a very basic omap board to which you can
attach different add-on modules, like LCD module. In the current overo
board file we always add multiple LCD devices, of which the user should
only use one (the one on his module). This model of allowing multiple
LCD devices on the same video bus is causing headaches in the dss land,
and I'm removing support for it.

So what we should do is add only the LCD device that you actually have
attached. With DT this will probably be handled with separate dts files,
depending on the add-on module.

How should this be handled with board files? Is it ok to add a board
specific kernel boot argument, parsed in the board file, which tells the
add-on board?

We have similar situation in some other boards also.

 Tomi


--------------enigC4ADB67ADD67D27C6C037BFE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRTBWZAAoJEPo9qoy8lh71YuMQAKHs5bZFoDMm+wog8dsZICZn
3UgmC5BXmFTQSWjIycq1Q1Mw4R4CUOdauUdNEJBE88JlgfAKGTynmaCHtJC0MyBw
/MZDSIqv48scSrrK3OdRsAM9VFHbU2GZc5P9Hw+kmdYqaFLuw6KCiauYkSfY9/y4
3ArkKuR/NydQavTK4ENLKFeZLBv9YLSU8xSxAqD4WcbYAKLio5fsaBpuJsOZU/bL
YqmEZ/f7FSTBWPeRpgeORLLp3z9olXiGZR3BCVv232tBcdXhCVOQeR+rmzODLAix
IHjLRlebqmmQcajAe6OZQmjE8GmGkYG2tlSyzRVld8DA/muHkIYtPVpT0nkV+6Qo
EjhrnJUocrRkrTjkf4JkSRQzzPpmF46pelLpunGUL3/l6X2bP7Y7hJSrde8SzkXt
B9uX5IoYoajNN7G/WKhr1haS/tatyi2lFcYFSHs/3g2lD2YUTtcPcuECUf5q2Uz5
OCP1Ft+jq2fu/qma+dwKqJW/ry7mQA2nrTS7RdlUnprow+OfVaq+HORHZkDf1lnt
3Rw2XkTfuTdXzOR3UBw3RQHramZ8R45pU2p1wFaLFe+LdaRPOe45XyDQAqWzvHcN
JqhwWAyq2G7Q93ft8Kgbuc+zkzoDFVE7EO9uT66GAFUN6cDhRA9nrl8DyQoXSuvi
eO0aUiJR1KgCBwWhpZ/4
=xEwK
-----END PGP SIGNATURE-----

--------------enigC4ADB67ADD67D27C6C037BFE--
