From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/3] ARM: OMAP: add corrected DSS regulator supplies
Date: Wed, 12 Jun 2013 13:38:29 +0300
Message-ID: <51B84FA5.80409@ti.com>
References: <1369985874-8571-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2LMWIWJJDVFPLUDBURQUJ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50670 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752343Ab3FLKiy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Jun 2013 06:38:54 -0400
In-Reply-To: <1369985874-8571-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

------enig2LMWIWJJDVFPLUDBURQUJ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 31/05/13 10:37, Tomi Valkeinen wrote:
> Hi Tony,
>=20
> Here are a few patches adding corrected DSS regulator supplies. The cur=
rent
> ones in the board files are not really correct, although the dss driver=
 works
> ok with them.
>=20
> So these patches add new regulator supply entries. When these are merge=
d, I'll
> change omapdss driver to use the new ones, instead of the old ones. Aft=
er that,
> we can remove the old ones from the board files.
>=20
> Note that these patches were also present in the big DSS series I sent
> yesterday. There's no reason for these patches to be there, so I'm send=
ing them
> separately, and will drop these from my DSS series.

Ping.

 Tomi



------enig2LMWIWJJDVFPLUDBURQUJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRuE+lAAoJEPo9qoy8lh71R0UQAIULuAWHjpXj/9Qhcj9e27f4
Gki7yJWsovcrE9IKczCnGoxw8fvgC31dYrygwnQ5B+NfLmDoC0t2YSHfMPPXn9Th
fQaBIwwh1Hvh2nBeKpplOXHTe0/jGoG+flhpm11/moGjWxxdesdHR6U8qOSCPAUz
scqWx3IBWJr00yV9dKw2SX2sMfRxEAlh7ilsXU5IpEukpEMv39z7tzDauq394AEn
YdRzSMb1SRZNF2CW4nucTyRxDwCOduZSqLytVPhHPGc7reph3rwtq+U3lCQUYYu4
0IXZ9eOScXv3o6XWHs0MQNJPRcDxwMC+tAgI4USmeHwhgv3GqwN2SMypDu9Ex3Pw
xffqCAjSkoZnOUPuMCp6/ZWoNnsVsZU46OgXflInlRNHgI5TwPNfypwwuj63Mmqn
zXgQmsFHTpCHZjSAIey8AEzgPdKZYHN9r2x+vXFtVCczM1t/jNmkgzUbr1/W1ahe
0qZGQlYbS/pWMN2WioQ6K9nqQ4Tzjdh9bS0uL+qeXSG4/ISo4wqU5+sQUux/0+YS
Gz0X6rcchCZwo+Fdv4Rmbrgl++rJBdD18I3Z/hM1DwYw6JQDEQZmOcNnsLjD7ock
Bw21qhKvtTTKxQUpIWdkS3+VIlYkM1r1j5/hrFeCgMsbzbSo99pa8hy19j2Bxdgo
J/UuiaHqew3gLeW9Lxxf
=HoBB
-----END PGP SIGNATURE-----

------enig2LMWIWJJDVFPLUDBURQUJ--
