From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 03/10] ARM: DRA7: hwmod: set DSS submodule parent hwmods
Date: Tue, 7 Apr 2015 15:16:50 +0300
Message-ID: <5523CAB2.30807@ti.com>
References: <1427208910-17678-1-git-send-email-tomi.valkeinen@ti.com> <1427208910-17678-4-git-send-email-tomi.valkeinen@ti.com> <alpine.DEB.2.02.1504031902470.19540@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="v4EkQNKc8Ar5u2oHV9MGM0w75WSO8qG1B"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37734 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753415AbbDGMRS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Apr 2015 08:17:18 -0400
In-Reply-To: <alpine.DEB.2.02.1504031902470.19540@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>

--v4EkQNKc8Ar5u2oHV9MGM0w75WSO8qG1B
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 03/04/15 22:03, Paul Walmsley wrote:
> On Tue, 24 Mar 2015, Tomi Valkeinen wrote:
>=20
>> Set DSS core hwmod as the parent for all the DSS submodules.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>=20
> Thanks, queued.  Will send a pull request for this to Tony today, but i=
t =20
> may not make it for v4.1. =20
>=20
> Note that I cannot boot test this since I do not have a DRA7xx board.

As I mentioned in the reply to the pull request, we can't cherry pick
this patch, we need the HDCP clock.

This series should be changed so that the HDCP clock is handled in the
beginning of the series to keep bisect working. I'll do that for the
next version, which I probably would need to do in any case as Tero's
series is still under work.

Or if we want to get DRA7 DSS support in earlier, we could just use my
earlier simple patch which enables the HDCP clock.

 Tomi



--v4EkQNKc8Ar5u2oHV9MGM0w75WSO8qG1B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJVI8qyAAoJEPo9qoy8lh71TVAP+wUvf4U+tApJj5JHGh6RgMMk
r38p2ZRl4N0b83m3vEZZYJRl/2UyvyL/jwPh+KWlVvDdgjHjXLCmXyQPPHr4cA/B
7C1Sg/QH6aXAckq2ldw/RD0AmWufkP581uqrDlYMh9MVNV8kRwV0QwP1kNPQLb4P
dOZ1FQpr6urf4MPJECfD2CrB2rbE6gCLAwV1N3SSRWeupeS6eoz0+TjsJxFGyIKI
nj7/XtuSFUCs5+xoId0iBFXN5XiJLqUbUm0mSNDvqCvA9z7CA0DYhkEKSCi8vPSs
e53lzJIfY6Rx+K2P5wtavZXQz3otcNXJiHEZpjZ8KyQK74P1Y2wBJwwIMlkARg7g
oUIzcVWgEK1FktqacsB/fdJtYWIuOSl7yiSSFHMbH/NWLvyQG/8O4CR6zOOioAeR
9maaqja4bABgLpfqv9p9ReOQtIa2R/jjyXyIZIVKqURsMu4X/DqyZhtMipTO3Hfw
mTqI+A+YIqppWAtWTD81pv4ZJrY0Lz5cO2PjkCpTd95AWD3M5/qHu3r6T7eXaQ6Q
QKCdDCfUjymRXGZmyLPqTKZegPoPE8lnM9U2wW7KYTZm68mW1rQoLLQf50UD+qSC
pnLWfP1M0C3PwQYgOQyoovMNvMWfoV1Rg/Wq10lpuO83D5E1SpDLs0Fyhkeu/SDc
AKA15y1Z5L6B+KWi59ct
=1q/v
-----END PGP SIGNATURE-----

--v4EkQNKc8Ar5u2oHV9MGM0w75WSO8qG1B--
