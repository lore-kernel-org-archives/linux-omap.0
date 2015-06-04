From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv4 10/10] arm/dts: am57xx-beagle-x15.dts: add HDMI
Date: Thu, 4 Jun 2015 09:13:58 +0300
Message-ID: <556FECA6.6060408@ti.com>
References: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com> <1433139798-23450-11-git-send-email-tomi.valkeinen@ti.com> <20150601215115.GH30984@atomide.com> <556EE463.6000502@ti.com> <20150603154438.GS30984@atomide.com> <556F24E6.7040003@ti.com> <20150603161008.GT30984@atomide.com> <20150603171627.GU30984@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uvjtiEalpFmgqKxljfWomKaSKJkfIPQUq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43765 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbbFDGOa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2015 02:14:30 -0400
In-Reply-To: <20150603171627.GU30984@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Mike Turquette <mturquette@linaro.org>

--uvjtiEalpFmgqKxljfWomKaSKJkfIPQUq
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 03/06/15 20:16, Tony Lindgren wrote:

>>>> OK, since there are no other merge conflicts that I'm aware of,
>>>> it's best that you merge the whole branch. I've acked the patches,
>>>> so for this one too:
>>>
>>> Ok, I can do that, but isn't this more linux-arm stuff? All the drive=
r
>>> side code is already in the mainline.
>>
>> Yes but we're getting so late into merge window that I'd rather not
>> take it for v4.2 at this point. And it's all DSS related.
>>
>> Please make sure you get an ack for the drivers/clk/omap change from
>> Mike or Stephen though.
>=20
> Naturally I mean "getting so close to the merge window" above :)

Thanks everyone. I've pushed this to fbdev for-next.

 Tomi


--uvjtiEalpFmgqKxljfWomKaSKJkfIPQUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVb+ymAAoJEPo9qoy8lh71YcsP/jx55PuXwI08Jr0Unsy3cARI
R3I1vSvzO6HLd5zWbIbfOSj4n/dAxyThiZa0oiANQj9WQR3ISgZ5J/OHs3jAcLEj
RqikkG81wamTXl9Fy3DJlbyamut6Jn7uwUzS2jzCWKKeiTUnyUoDbiDsU1ZFGOML
dzW+U1bX/djW92aYiGz6+Z7pI0pBT/qbpoFn1GxyPB454jVo/Scvb7Io2qBY5l81
/L4liMuYtQ3Ua74LagMGrgyFlWqW+Ndpc9hiXVgqsoTWqEEe+CdjvVGn7kpAeKvx
6Zc86XzggGNwmAZ6H9cx05dk3+HGWGKLmBXXz6I8odcULqw6DuSeNQ7lSN90n9Zy
kF+Hf9Civr6g1/1fCLUZCq77TcJM/zb1cAS30jWrY/zZHbEC5mpq1uOlaF0/hHBk
ZG0DC0+5D0OIFu4R4MWDdnoUIn/k5RlKf9BjvYM3SogjgmNZjdq06wOEdFSHNTYk
5n3hn4uBI6R9hXE5oDmNn1UtwJJkUuyvTTshH7+7miaWvYBE7tfLUXzxtTyvYvpv
WnZAE70JW5Q27kqToP2aLzeKw93bFJEOngh6Sd7X6oehNe16mPzDlmAjEkzMIbma
bsKknTGIbsKZfel4IB+ozaxf83XvWBWFvVOS3L4yY7YqYAyLbi4tt3JLE/W/EirH
YPzhiQKUTzZ7tPt1DheS
=wb1X
-----END PGP SIGNATURE-----

--uvjtiEalpFmgqKxljfWomKaSKJkfIPQUq--
