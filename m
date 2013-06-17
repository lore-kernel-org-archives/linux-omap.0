From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Request for OMAPDSS testing
Date: Mon, 17 Jun 2013 10:08:13 +0300
Message-ID: <51BEB5DD.4000605@ti.com>
References: <51AD99F5.7060506@ti.com> <51B9EA7B.8070906@compulab.co.il> <51B9ECBE.3010401@ti.com> <51BDAF6A.1020102@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2ROQPMUTUOWNHNFSUNSXE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58617 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752833Ab3FQHIh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Jun 2013 03:08:37 -0400
In-Reply-To: <51BDAF6A.1020102@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Thomas Weber <weber@corscience.de>, Mike Rapoport <mike@compulab.co.il>, Steve Sakoman <steve@sakoman.com>, =?windows-1252?Q?Gra=9Evydas_Ignotas?= <notasas@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

------enig2ROQPMUTUOWNHNFSUNSXE
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 16/06/13 15:28, Igor Grinberg wrote:

>>> Although one thing is missing from the tfp410 driver is
>>> the PD GPIO polarity. I had to adjust it locally to get the DVI worki=
ng.
>>> The original polarity was high =3D disabled, low =3D enabled.
>=20
>> Hmm, but this is missing from the old driver also, isn't it? At least
>> with a quick glance the old and new tfp410 drivers do the same thing
>> with the PD gpio.
>=20
> Well, we were driving the PD GPIO from the board file...

Ah, I see. That was inverted PD handling was removed in 3.5, by accident
as far as I see. So DVI on cm-t35 has been broken since?

I wonder how that should be fixed... The tfp410 driver handles it
correctly, as the PD gpio is active low (i.e. high =3D=3D tfp410 enabled)=
,
so having it inverted is a board specific thing. Do you know what is the
reason to have it inverted?

There seems to be OF_GPIO_ACTIVE_LOW, but I'm not sure how it should be
used, as I don't see anyone setting that flag... And supporting that
would mean, in principle, that every driver should support inverting the
gpio with every gpio they have.

 Tomi


------enig2ROQPMUTUOWNHNFSUNSXE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRvrXhAAoJEPo9qoy8lh712M4P/iPLOdNI4E6M0BAuAnzkIIj4
FGVmZUMkCP0srHFiRe0okyvoIdk+o8dJi2SYc/beghO5CzNbgSO4WVj29DRznJdr
5Fu2XMI3deMK46Y5myhWHfloudAD/LgTp+GOerqZaVx+IzL7NHVivwYyNZwLjFEq
/DzOTbzWYq07FDmlVRw+TU+K+evleJrz1Kbp+jUAuPmDzXsoFZ3xKLG4fdkQeYp2
xkrcfQBnG2HWf+BXbzkqsU6U5Qza3NUdH0RePZG7PKgL7RObdCJ7MZO8NUiVZTzw
GHT4EyARfyxgxVNo6py6aJW6d0+7xT0G7wfpVOTZyl9wmerCR3ZKPMVuFOiYEFw9
lArfMPFsubSwVKVDWAn6piXoaxgKhuN5/Y0Dx6ije/fS0bYJlY9Q7ZaNNRmWEhmc
V0xvhSpSYAyqvqaEUDGtIYUZldVSEcjpcOCrSnB2qi6D2Wx0eMfBukSxf/hKBfrF
HfplOD4rFIIfQoSLdwWd4ApS5HUHe6iaWdPuXdEH8xSCFzs2WIgLy2/wRA/AocxU
3t5f7vn6nany4az+c+wIR9RrN18ch5k7207l+K1d7+EUNQUwQnD4YdQJAGwd6LUD
vUH22AzFqZKGE4J2VkIPItZQiAnzRuvIALvc014TBeSY0ZrSJoUB9T9Vv2yyuWTx
HZPyC2FClYfAZ2SFj4iv
=onip
-----END PGP SIGNATURE-----

------enig2ROQPMUTUOWNHNFSUNSXE--
