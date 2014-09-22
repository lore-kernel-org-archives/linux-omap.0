From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v4 0/5] nand: OMAP collected fixes
Date: Mon, 22 Sep 2014 13:51:07 +0100
Message-ID: <54201B3B.50007@vanguardiasur.com.ar>
References: <1411231996-6387-1-git-send-email-ezequiel@vanguardiasur.com.ar> <541FDC2F.4020103@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="RQB3TlkrKJm0mOEELp6IvHeB2PPome04e"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:62525 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897AbaIVMwd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Sep 2014 08:52:33 -0400
Received: by mail-qg0-f44.google.com with SMTP id f51so2823065qge.31
        for <linux-omap@vger.kernel.org>; Mon, 22 Sep 2014 05:52:32 -0700 (PDT)
In-Reply-To: <541FDC2F.4020103@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Brian Norris <computersforpeace@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RQB3TlkrKJm0mOEELp6IvHeB2PPome04e
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 09/22/2014 09:22 AM, Roger Quadros wrote:
> Hi Ezequiel,
>=20
> On 09/20/2014 07:53 PM, Ezequiel Garcia wrote:
>> I've collected all the changes recently discussed in a whole patchset.=

>> If you are just reading this for the first time please take a look at:=

>>
>> [1] http://www.spinics.net/lists/linux-omap/msg110965.html
>> [2] http://www.spinics.net/lists/linux-omap/msg110958.html=20
>>
>> As requested by Roger, the omap_elm is a 'bool' driver now. The plan
>> is to merge it inside omap2_nand, but my queue is really filled, so
>> if anyone feels like doing, please be my guest.
>>
>> Although I'm hoping this to be the last round, feedback and testing
>> is welcome.
>=20
> Patches 3 and 4 still have checkpatch issues.
>=20

I think you didn't look at them in detail. Unless I'm missing something,
it's just warning about MAINTAINERS update:

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?=

#16:
 drivers/mtd/{devices/elm.c =3D> nand/omap_elm.c} | 0

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?=

#13:
 drivers/mtd/nand/{omap2.c =3D> omap2_nand.c} | 0

This driver is not in MAINTAINERS. If you want to start maintaining it,
it'd be good to add you to MAINTAINERS so people Cc you properly on patch=
es.

--=20
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar


--RQB3TlkrKJm0mOEELp6IvHeB2PPome04e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUIBtCAAoJEIOKbhOEIHKi1EgP+wc65+lRyux/x5pTq3ifT0MY
2rviakOvR93A0yMZmeD6O5csKL1Q5WECDwP4L8xgMPoSAHN0gFQ9yaiFZxX5hBr/
QEgaY4oDh6+VoYaxaQXcVVB0bDVCEU295oU3IKuOsJtQtbu+xh3OKck3XGiS+5ys
/q6BtXQkaUknac4ig8UfaLgFeIQ6QwdFNFJnLMOC+3YFkVMQZ5E0saD+JBBd6saF
lBjJxY4a5YrettrK81eD5QG5bA/s6rNvUabqMXYKKaTUEenNUGurwkrfsKfzaQYv
Y/5gycQI2XJ30whMJoHuxOoHWQbCKyH103dOeSoZn+3jJcI3C/mNLP1G+B8yv04U
v17hpndPprpgwrw/TU2lm1heN+rtCCgM39TTBy9V6a2zX/Ou2DijuiWyiLpTJQEq
HYFktN7f4cH1kQx83xLRrqD+gLX+I4eL7vGFt/cG3mmZPZWwgPDhxCnkyTsi6hnh
WREaZkOnnLdi6CnTChDIYSxQxXMDP11f+LwCojn1L0ssQsiaCkFDF3FP6xFwD33B
e0FqZKvFd2ONrlje91XsMGH3ax464ET9nrvBlxSOyDKhsUUhHLi+PbgoYQm2IpXT
nbucPm/Cl3Vcd8LLqCHfRU6W9d+paWw3wYx3xvgqwrVDjSMpu92xORwRtyxljJXv
2gJ+0e4fU2TyD9zv8xcN
=Vwvi
-----END PGP SIGNATURE-----

--RQB3TlkrKJm0mOEELp6IvHeB2PPome04e--
