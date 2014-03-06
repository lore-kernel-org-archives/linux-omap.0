From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv3 00/41] OMAPDSS: DT support v3
Date: Thu, 6 Mar 2014 09:29:09 +0200
Message-ID: <531823C5.1020008@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Dbxd6EbcvnM0MOn461EejDT1ft227VROA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56889 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859AbaCFH3z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Mar 2014 02:29:55 -0500
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>

--Dbxd6EbcvnM0MOn461EejDT1ft227VROA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On 21/01/14 12:56, Tomi Valkeinen wrote:
> Hi,
>=20
> Here's version 3 of the DSS DT series.

Can you have a look at the arch/arm/ parts in the series and ack if
they're ok, i.e, patches 1, 2, 32.

Then there are the .dts patches, 22-30, for which I haven't been able to
get any acks. I'm not sure who I should get acks from for those, but I
don't mind adding yours if you want to give it.

The .dts patches have had minor changes compared to the ones posted
here, according to the DT bindings review comments, but nothing much has
changed.

 Tomi



--Dbxd6EbcvnM0MOn461EejDT1ft227VROA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTGCPFAAoJEPo9qoy8lh71z3sQAIR7V5THHSoohdaYCR67M6nq
pw4NXseCLvkBYF946pXkgEjvbDjOGPtZlKsW2gkYn4QGwoQIx2rzqQqyXLljE/rE
dsQ8M5lSer1am9r3lqQe59spQ3Wh6l8T2JZ7zRc2QhyUiQUBt2f5hvU9CaNvcE+/
T1MHb5UjXctc5ERz62RbKtVGLuaPoqpU2kURsj2ur1Akq16jVzp3sDrVrRPZIqyf
mskkAo9/3eQUxH+0aWdMbA8fI8uHEGI5/R3I4m4XadW0W61YZjJdFkU73Jp+XsXW
ogqsxRXhVvGYJjiIu4Li+ctm8JR1DaZRdaCZ9BbQOZslTX5CWyQ5V/sITseVw8cK
X9lc9e4E+NPijyWtLY+2Thr9mrKp8Rqe+FG6k4PDgrUhdCzI+Rbxd722QwqaXGoK
zi5rXr1Lm/32dk+lcy21YG52iM0DAUWsjx4uLRxoouqv7GwZeP46oXPahonv2K6+
i/PupoGh5vCt2mvo9HfwcTKhgFSzKiby6sjLbrhYOI3aHJk9/dxGCx+Shn16wZUj
BAyS5TWmLLze9V0EqAzH1lossOxKnmaVWtymsX4t4ziNfg2Ytt5K/tMHll41j+2W
uMS1ZpjLFDEAYV70asDOLJpb+cFu14LAdKf+I7o/xi2poq4wDp7bP3RU5s6R5GIo
C9m+x8F1oMXvEkIdenJZ
=Emwg
-----END PGP SIGNATURE-----

--Dbxd6EbcvnM0MOn461EejDT1ft227VROA--
