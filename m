From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/9] ARM: DRA7: add display support
Date: Mon, 16 Feb 2015 10:30:52 +0200
Message-ID: <54E1AABC.5010907@ti.com>
References: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com> <54DE1FD9.6030801@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="s41I9Xhhlqh4n7GCgfQ5KLarmuTUGWMcJ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32828 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbbBPIbV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Feb 2015 03:31:21 -0500
In-Reply-To: <54DE1FD9.6030801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Felipe Balbi <balbi@ti.com>, Tero Kristo <t-kristo@ti.com>

--s41I9Xhhlqh4n7GCgfQ5KLarmuTUGWMcJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13/02/15 18:01, Nishanth Menon wrote:
> On 02/13/2015 09:11 AM, Tomi Valkeinen wrote:
>> Hi,
>>
>> This series adds the arch/arm/ side of the display support for DRA7 (D=
RA72x,
>> DRA74x, AM54xx) SoCs. Also support for HDMI output on x15 and DRA72 EV=
M boards
>> is added.
>>
>> The series is based on OMAPDSS driver patches in fbdev changes for 3.2=
0, which
>> have been merged to Linus' tree.
>>
>> The changes are very similar to OMAP5 DSS. All the other patches look =
fine to
>> me except the "RFC: ARM: DRA7: enable DSS_DESHDCP_CLKEN". That's been =
discussed
>> earlier with Paul and Tero, but I don't think we have any good solutio=
n for it
>> yet.
>=20
> Is there some specific tag I can test this on (some next perhaps?), I

Linus's master or linux-next should work. This series is based on the
fbdev changes for 3.20. So if Linus' master or linux-next doesn't work,
v3.19 + fbdev-3.20 + this series should work.

> Further are you proposing this for 3.20 or 3.21 window? 3.20, we seem
> to have already missed.

3.21.

 Tomi



--s41I9Xhhlqh4n7GCgfQ5KLarmuTUGWMcJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU4aq8AAoJEPo9qoy8lh712IQP/09/mfV3G/f5IoWi6d8ZUMft
kLa1ddWSyGJeWf2Uysc9+7Z0+NOSq+QeR/6I6gN86xIwwfhmDngbip6kgM9Q4prL
/zc1fUEuSKtKnGJ1Tp9xjhgnbkFO5nIv9pc5xC9SqU/ypQRJUF/Sb8gRuAtX5zPR
DF15pLXp5ukH8LfAxP4Z3A5n+O4jmyd1hVEtVN8hRI1EAvxdTBf7xnZWjm7yfo5/
AzSEqkr84DwiT0dN2XRgKh5KH1fJda2gdZxBPXdagBcTtPhg2IJglBhrKeylKz3R
FKI7UeTTeUev7WA1zlze3II/WWAQz1v9840/M54JlzTDirXqEMDPQhzsqcQhHUgJ
cOX7QyKfvNcx/1BUDn40L/hLNiOlUTgimzgxhPmOBjHsAcUn+8Chjdo4gZc6AVTH
r8a8Pgq0G9rH12Q7avGhhx7oUL6F5V3i9vCX51ywzKEbsmc4v9UPFRmimQwx6ahD
PX2JkSwcGD+oqUI9SRQcD31d9ZnmROFkrU2cICe2eSMoVLKd0Oq8QzxVxWZAOmff
4PyeCpZ9WpTg4Z5hZZ2sk0OCSNgvvXpqzGByO3qte3vFPgaTGp85h8TR8gIzwNKa
6cJoku5NUxb/mRhig1kj+wGoUOI8Fo1FDdj56bUDnM+TAR8VdyMjFLadbtexf46V
vtrEPeNWsEavey9j+jyx
=7Eic
-----END PGP SIGNATURE-----

--s41I9Xhhlqh4n7GCgfQ5KLarmuTUGWMcJ--
