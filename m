From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH] ARM: OMAP1: fix compilation issue in board-sx1.c
Date: Wed, 09 May 2012 10:57:18 +0300
Message-ID: <1336550238.27683.1.camel@sauron.fi.intel.com>
References: <1336485575-18352-1-git-send-email-dedekind1@gmail.com>
	 <20120509001734.GC5088@atomide.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-5xOXC8Gm7H1e6oAaNBia"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64127 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755706Ab2EIHyJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 03:54:09 -0400
In-Reply-To: <20120509001734.GC5088@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: OMAP Mailing List <linux-omap@vger.kernel.org>


--=-5xOXC8Gm7H1e6oAaNBia
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-05-08 at 17:17 -0700, Tony Lindgren wrote:
> * Artem Bityutskiy <dedekind1@gmail.com> [120508 07:02]:
> > From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> >=20
> > SX1 board requirese i2c, so select it in Kconfig, otherwise I have the
> > following build error:
>=20
> Thanks applying into fixes-non-critical as this seems to build
> with omap1_defconfig.

Right, because omap1_defconfig has i2c enabled. The build fails if I
disable it. But this is not critical to me at all.

--=20
Best Regards,
Artem Bityutskiy

--=-5xOXC8Gm7H1e6oAaNBia
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPqiNeAAoJECmIfjd9wqK0swgP/37TPRkeO6yAT95LNLq7ipiV
EUhWuxqEomyMAPDoXVvZJPRXDeBaODHu9r9XPIvAlVdgSSNw0LRkHF4x/TkdxC33
EY0aSsOaIZ3jH/Hzq9CfXVtdq3NqceD5j2WQwlsB5sC6imJ625qQ6OZWzA9dx7L/
jbL2AE09jQk9Mq/G2RRbm2u6nHfixSq3a3/H87zE+OV2s1gEvV5edKxf8iq5EpJ8
QnHcCZseovLaE/ABQN9VmgtWYSXMQwA5/V0MbXPqz7mGvE9fjz3BC5tgk5gX9nkm
EId6jruvLcPCvPnkC/XVFO89KfTipUxmg/XSJwFcwayw4isjuxLwJx1j7aabvAF2
4GD0LvoHcWc1zjzBiG1+w+H0nKQjzXF8a7cDAFmhCtm1+RzYM2NDglGXQR7QyojN
4rZneONhxWwQ3XDrTpDxkPfJD1KQn6dGtStjbqcF3Eq8viwzeaw0N0VOq7peqpNA
B9bgKorOOScVCrSVsG/Vi4D8l9iZ1VRAmsdd+SEGvD39VQhwzIfAALiN+b62xH/K
bLJIU0Qtv28zInv5Mm3ENwhhVb9kZ/fhQEBWPsuBrW693r4aqdahLHMZEp7kouej
R+PZAir1vYxECZm0hLUVlr7eIz6CAUc20kndnGmxVTE92HWdV4DOkFoakcaamGit
cQj5q+q6eT/vK7xIo+MX
=4IhG
-----END PGP SIGNATURE-----

--=-5xOXC8Gm7H1e6oAaNBia--

