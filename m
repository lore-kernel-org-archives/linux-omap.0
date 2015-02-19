From: Felipe Balbi <balbi@ti.com>
Subject: "advanced" LED controllers
Date: Thu, 19 Feb 2015 15:14:24 -0600
Message-ID: <20150219211424.GN13603@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JQ29orswtRjjfiJM"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-leds-owner@vger.kernel.org
To: cooloney@gmail.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--JQ29orswtRjjfiJM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Do we have support for LED controllers which can handle patterns of
different kinds ? I mean, currently, if we have an LED controller such
as TPIC2810 [1] which can control 8 different leds and each LED
corresponds to one bit on register 0x44, we could control leds by just
"playing" a wave file on the controller and create easy patterns with
that.

AFAICT, in linux today we would have to register each of the 8 LEDs as a
different LED and have driver magic to write the proper bits on register
0x44, that seems a bit overkill, specially when we want to make
patterns: instead of writing 0xff we would have to write 0x80, 0x40,
0x20, 0x10, 0x08, 0x04, 0x02, 0x01 separately and have the driver cache
the previous results so we don't end up switching off other LEDs.

IOW, what could be handled with a single write, currently needs 8.

I wonder if there's any work happening to support these slightly more
inteligent LED engines.

regards

[1] http://www.ti.com/product/tpic2810

ps: tpic2810 is probably the simplest example, lp551, lp5523 and others
have even more advanced pattern engines which can even handle RGB leds.

Currently the driver loads patterns as if it was a firmware blob and
registers each of R, G and B components as separate LEDs. Each component
also has its own brightness controls (something tpic2810 doesn't have,
it's either on or off).

--=20
balbi

--JQ29orswtRjjfiJM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU5lIwAAoJEIaOsuA1yqRErsQP/A3HDxA/MYW6vxuwP7h8v46c
j6Kinanz8MutZqx+6FcJLCq9DY4dRpDqyeRucI4TdLsyaSulAZQadAcxVjsFRPUk
6h7i4KwNofwhCXeXrG5fXNUOyjHtWWPGefU9S63+Z6umTc2xyKzxVi0IxFhPs9rd
w9GUgmNmd/f1JeJym4IwQGOw2IivPlTp+MYKUI+4Z9NI+MWYM3lPCKcVZ7qc2wA8
Tdcmn9nLUJ0/hMkm88lU9FattyRZ6qJfGvSLGZJGhh1v0dNNojbXz1PcUzCoJENY
rsF3N57wj5GNbd8pPGJyMSKiyw3U8TWu/6hV5JUerG4ZP1HoOip3H2K8iFiVjFkz
Jc76czwqj73vIOY8ZBM85qCtnIuX1evWDlqU5a3W2GNNiNckKhSrq5qygbwkneNB
Xg3TOxkFSWG8/0wZvFF+ziJjr4jQO6emRWYGESZpnzRMDobuLh9aS76uPtqvidr+
8tJeFqQf/6F/z7m4QkYxMZvmzE3S72aQlwMNkUX/5+aOXuDRzbJzgpN9BVYsoy9S
H9uJWF2P4HrSKUQowWHQnRjcJ9MxJ1ADbSYjNfqglUNoEX85BudTkv9jvGCUiRxR
HsMi4oe1U7NUU2AcCSfdbV+Rby+u2HXAiAamPtR7xKD0CYwbckw6gNknYj/k8SZl
+7BAnVQqzWbpaFzk2O9P
=+tXS
-----END PGP SIGNATURE-----

--JQ29orswtRjjfiJM--
