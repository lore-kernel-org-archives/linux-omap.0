From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv3 00/10] ARM: DRA7: add display support
Date: Mon, 1 Jun 2015 09:21:44 +0300
Message-ID: <556BF9F8.5070500@ti.com>
References: <1430906938-26128-1-git-send-email-tomi.valkeinen@ti.com> <alpine.DEB.2.02.1506010538330.14902@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="skV0Mti4fSbmNiqdcoOsPxaLSoj93Pohg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57541 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936AbbFAGWV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jun 2015 02:22:21 -0400
In-Reply-To: <alpine.DEB.2.02.1506010538330.14902@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>

--skV0Mti4fSbmNiqdcoOsPxaLSoj93Pohg
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 01/06/15 08:46, Paul Walmsley wrote:
> Hi Tomi
>=20
> On Wed, 6 May 2015, Tomi Valkeinen wrote:
>=20
>> This series adds the arch/arm/ side of the display support for DRA7 (D=
RA72x,
>> DRA74x, AM54xx) SoCs. Also support for HDMI output on x15 and DRA72 EV=
M boards
>> is added.
>>
>> This series is v3, and is based on v4.1-rc2. There are no differences =
to v2,
>> except rebased and tested.
>=20
> Are you still planning to move the DESHDCP clock enable to the beginnin=
g=20
> of the series to avoid the warnings, per:
>=20
> http://www.spinics.net/lists/arm-kernel/msg410968.html

Sorry, I totally forgot that. I will do that and send a v4.

> Also, not sure if you can arrange for someone at TI to send over a DRA7=
xx=20
> board for the testbed, but it would be nice to have a board to test the=
se=20
> patches with, to avoid issues like the one mentioned in your E-mails...=


I'll forward the request.

 Tomi


--skV0Mti4fSbmNiqdcoOsPxaLSoj93Pohg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVa/n7AAoJEPo9qoy8lh71M88P/0cdiY7qdxcIIHMHVamcwWnN
5AkuPUaFxDC/qqSkyfr922ZUVyblR2KRN+EpjHWZdbmqEk2qQbSB9nY2vKuYer1A
IWT/ZQZLT5yaScXkDhvmZCnF/QMf3pG7+HgWULogL7iYUc2hTKAVZ9LsYXYXU7jY
BLJ6bMY/rz1WYz2Nm6Z/H5Md9o7LfRW/u544Ui0zOPab4sI3SIDFd+ozP/yeRhYt
Xs8OelK7cSMhmfkj1VTG4V02qaTMdV1/jNwdb+nFORImsftG/MXgzHbs1++todFs
afUvrt6uiGF/+yfBnXnc//3JrTwzchx/+B+TY8nbM7wR6kMPI+c2S3mxLtsv2ESL
gq++UDglOkg4gjGAX/2zR00hNGjdE563SnXIfn5S/3i3KVJPaSj8B4rUJj4QB1cv
cwQisGF1cnjCfmIGTDN2OUSUCXDTXJTwIn6eTyaCEY+6duTxsyj9DBPRmY0vkEwM
lhspudxmPlRpfNku5dXslECAVp4iSYZIpaCd6Ej0Vyx2o1XaeI1JNDg414QdLWMv
u0DyMfCgMb+lNm0Ah4B2t9RKAIgE0xJijpYdsyqEXeQwpG2u06ToWEQFjo78Zj6q
zYLDz/S2FPbOMXerctiRMZaY+TwtB96s9OQF4qXdvMIrNNC88XbIkBFUFOF/Ihw2
3urre9SzzdCDQGqvBIj2
=lAtS
-----END PGP SIGNATURE-----

--skV0Mti4fSbmNiqdcoOsPxaLSoj93Pohg--
