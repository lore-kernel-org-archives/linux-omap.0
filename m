From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] ARM: AM43xx: hwmod: add DSS hwmod data
Date: Wed, 30 Jul 2014 15:09:42 +0300
Message-ID: <53D8E086.9070206@ti.com>
References: <1402994233-22599-1-git-send-email-tomi.valkeinen@ti.com> <alpine.DEB.2.02.1407222110260.25593@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="lAPfB130qu8K0V4oGFnmLPwXkh6dq2qj9"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60895 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982AbaG3MKK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Jul 2014 08:10:10 -0400
In-Reply-To: <alpine.DEB.2.02.1407222110260.25593@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org

--lAPfB130qu8K0V4oGFnmLPwXkh6dq2qj9
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 23/07/14 00:14, Paul Walmsley wrote:
> On Tue, 17 Jun 2014, Tomi Valkeinen wrote:
>=20
>> From: Sathya Prakash M R <sathyap@ti.com>
>>
>> Add DSS hwmod data for AM43xx.
>>
>> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
>> [tomi.valkeinen@ti.com: added missing dispc flags]
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Acked-by: Rajendra Nayak <rnayak@ti.com>
>=20
> This one didn't compile on an AM43xx-only build:
>=20
> ----
> arch/arm/mach-omap2/built-in.o:(.data+0x3f2c): undefined reference to `=
omap2_dss_hwmod_class'
> arch/arm/mach-omap2/built-in.o:(.data+0x405c): undefined reference to `=
omap2_rfbi_hwmod_class'
> make: *** [vmlinux] Error 1
> test_build: Tue Jul 22 13:48:50 MDT 2014: FAILED on omap2plus_defconfig=
_am43xx_only hwmod-a-v3.17
> ----
>=20
> Have queued the following patch instead.

Thanks. Tested on AM437x GP EVM with today's linux-next. Works fine for m=
e.

 Tomi



--lAPfB130qu8K0V4oGFnmLPwXkh6dq2qj9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT2OCGAAoJEPo9qoy8lh71IyUP/3NSy8qcC25XlJa8iSIU2ayt
aglUcSqFBJWkwKE4hwZkeW1woCGAtGiNN/YeyRngpYTv4ta5eB8PS+YVgRrzCol2
tzfWga16GjVeZpkHiLHmXw/mS/zAlLl2pT7TKGK9hcsmTIrS9NW1Yrzc50FbHkEN
hu1/rqCU1zre7JqljJjNXtBwooPd0NMFiZCzGWbozKJS5p0zsx2ADwfmqH1cEygZ
EQ2k7KH1NV4CkB55+xyFmIfx31oXctvXMIVn0ghmt+YWGU7CY0vVlbYZTVccG6AX
/ENXJ/9zNRJCLAE2ZY+AlPu7GIRIhe3RxYLvI7rCnf129jWfiJW5X/Bml4Zv/y24
iq67xd/Kwy937+Drb1LudHVZQpfBL2DQE0vWx/PlAAwLjVgTKcBAUL9C4xhOmIiH
ieh4CuEp0Pirfth/SYtPyws/LfpTppoBgF0naFNvIp1LiSMTEqNZVjbDYRXnfB9H
c9eukeZQVs5sPQv+Z5Vxx7DPkTBr8CMjhkYKlsCVbgkKwWa6BlYZOM+Qv6EEUMz2
kiIKOi4GsZqih0+LvRSepXb94DfU7CVM5Uhh58cbPO+H95qK2gAB9IRB1vFCTn20
oKyGD9BrLD4hWBbPNy1hwTre4qqqSQPJyAhHY+7NLaYbT4girNF6M19NQSo3tY1k
FBqSDMoqvfXMLzLCNCLg
=6RiB
-----END PGP SIGNATURE-----

--lAPfB130qu8K0V4oGFnmLPwXkh6dq2qj9--
