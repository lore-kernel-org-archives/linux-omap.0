From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] arm: omap2: rx51-peripherals: fix build warning
Date: Wed, 26 Nov 2014 22:56:48 +0100
Message-ID: <20141126215648.GA10126@earth.universe>
References: <1417033655-32332-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:45019 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107AbaKZV4y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Nov 2014 16:56:54 -0500
Content-Disposition: inline
In-Reply-To: <1417033655-32332-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2014 at 02:27:35PM -0600, Felipe Balbi wrote:
> commit 68a3c04 ([media] ARM: OMAP2: RX-51: update
> si4713 platform data) updated board-rx51-peripherals.c
> so that si4713 could be easily used on DT boot, but
> it ended up introducing a build warning whenever
> si4713 isn't enabled.
>=20
> This patches fixes that warning:
>=20
> arch/arm/mach-omap2/board-rx51-peripherals.c:1000:36: warning: \
> 	=E2=80=98rx51_si4713_platform_data=E2=80=99 defined but not used [-Wunus=
ed-variable]
>  static struct si4713_platform_data rx51_si4713_platform_data =3D {
>=20
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Hans Verkuil <hans.verkuil@cisco.com>
> Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUdkygAAoJENju1/PIO/qa8QwP/0fxhcV3LUM6lK4QQBr+6oHx
IAVlQULK4OEyMZCe2kHyRKYT3AoUIpfEOQPXgyMJqmn5eje8u4fcgnjCLc3mMokT
18FYH2QvVzEnm24dDmnopDjyvmPHwKNqdLTPGqolLLt6m+288Plr2KrUeU5sy9ko
AT2t9HSpfIym8RZh2Vtuz8Jji6iOFxNasDivwgfEFmK2b17QHQLsq3uuzZ99NA5e
iYLoo5IsSt2RNafPmTavosY3o72UygTiv33Qy7mL1m8v7czWDzmp6xtubk7Y4eMf
RJdMInnB/D6tL5rdU+tBJU8783Kct5XgOivMuQlwCF1lDqtrdrQGllSbfBMvUCsf
zCdHqHkj/LW5Rm4J3Wktu2jQlaw5Oqw9G0ghGhKGiaaF/Zu0PAzqzf7+EmmQo0pc
2TLKwT4qZbhn6pBhoD3+fxec9KhADxTWylW6FsmRHfkqQ/FfqXgpemTGm7X1d1k5
2ZFKzm0wlno7RvbilU5yxD3ZAahFPjdAwh4p78WBVnUajFT3Pqko9v3OF8mZV9qH
qr+D45AbHEUdskP6lA3H+EO7/2zzpGXVz6QmSzFMDjfuk75PhaV6aTdq8HDNRELA
K3TznqwAm0G/cE+86nWRObcz9wURwTT5XgzfkoylOPME6UzBwyt3tQlEdL50oVc4
CGswFt3bDE/11DUy9q1O
=0ByT
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
