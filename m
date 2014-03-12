From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/3] ARM: dts: overo: Add graphics output
Date: Wed, 12 Mar 2014 09:14:05 +0200
Message-ID: <5320093D.2010600@ti.com>
References: <1394541257-25605-1-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="hLEoaVrjlaFXr4CfCfOSlE6sggbxqxVMl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46405 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756469AbaCLHOf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Mar 2014 03:14:35 -0400
In-Reply-To: <1394541257-25605-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Ash Charles <ash@gumstix.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--hLEoaVrjlaFXr4CfCfOSlE6sggbxqxVMl
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/03/14 14:34, Florian Vaussard wrote:
> Hi,
>=20
> This series enables the DVI / LCD graphics present on some of
> the Overo expansion boards.
>=20
> DVI output:
> - Tobi
> - Summit
>=20
> LCD (3.5''):
> - Alto35
>=20
> LCD (4.3''):
> - Chestnut43
> - Palo43
> - Gallop43
>=20
> I tested on Tobi, Alto35 and Gallop43 using both OMAP35xx and OMAP36xx
> Overo boards.
>=20
> This series depends on Tomi's DSS patches [1] that are not yet merged.
> It also depends on previous Overo series [2] and [3] that are under
> review. A complete testing tree is available [4].

Looks good to me. Unfortunately the video bindings are still being
discussed (mainly the ports/endpoints), so there might be changes needed
when some kind of conclusion is reached.

 Tomi



--hLEoaVrjlaFXr4CfCfOSlE6sggbxqxVMl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTIAk9AAoJEPo9qoy8lh71hFIP/jxEwm58HBn9gDwLzMh1456L
y5oex8NAlm2NbEBUv7OclhAFAWXbQEg+dLovgvgrp60zvY3VXZROG5C9TeTmi9se
9Fpidq6QYK+deifUxIwSDocuWkywEPlbFoCIXxIAG5jpEbEH9gZ3kGaKoa/tpgK1
xVOvB2CnWgjdj5KIjUtgrFZyzKofczLAsGjI4bt+20xqeNCmDUxbhUboRxPLge33
gtI5VGciMfCo+mpIo6l6cFg/6XM97YqR/MUfT2xwN8/YgeRtfWZXmd/PbdVnMWs1
IaL702pa4nR0MHMe1kc4f73ZgG55skJpUd3XotS103seYLQwPyAq7E3ZRRx6cmZn
byBZpF6U1QLWJjxCMrFNJnfGJSw+r6TWfoZrlEOitSHAhe9Jwm7db/qzi/mEH+pV
mrxnEbAmPPx9iQadQNx3JFQsjWAed0DuK3Sf0Wqz1UHqcFIHk72Tch7g5iL78EsC
iEqUECb0k5HrbFPhvnaCfk1aOJu/eCW48jz36sBY18kBGltQBvkvBVkJF8ZIicDT
81XtKh/BjGjGVEsjq9n9DufIqV+BeLSKMV3yk4yEksrS7g58CgwZM4Klkzz5dnh4
x1Vg4GjD8YGdYD5qW2sEM4ria0iQJ5Ly3QA6Pz4qCHP17AAQoZ/4aM+drrNtl8jr
t4ja0YGUuQPElwzrWUZK
=mjng
-----END PGP SIGNATURE-----

--hLEoaVrjlaFXr4CfCfOSlE6sggbxqxVMl--
