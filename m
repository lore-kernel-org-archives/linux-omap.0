From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 9/9] OMAPDSS: DISPC: cleanup lcd/digit enable/disable
Date: Thu, 18 Oct 2012 13:09:40 +0300
Message-ID: <507FD564.6000806@ti.com>
References: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com> <1350472835-28727-10-git-send-email-tomi.valkeinen@ti.com> <507EC2EA.4000402@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig599D0C9D3C9B32EFC5178784"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52285 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752559Ab2JRKJq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 06:09:46 -0400
In-Reply-To: <507EC2EA.4000402@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enig599D0C9D3C9B32EFC5178784
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-10-17 17:38, Archit Taneja wrote:
> Hi,
>=20
> On Wednesday 17 October 2012 04:50 PM, Tomi Valkeinen wrote:

>> -        if (r)
>> -            DSSERR("failed to register FRAMEDONE isr\n");
>> +    /* if we couldn't register for framedone, just sleep and exit */
>> +    if (r) {
>> +        msleep(200);
>=20
> We sleep for 200 ms if we fail to register for framedone. But we just
> wait for 100ms for FRAMEDONE to occur. It seems a bit incorrect, both
> should be kept the same, shouldn't they?

They are just arbitrary numbers, but you're right, it makes more sense
to have same numbers for both.

>> -    r =3D omap_dispc_register_isr(dispc_disable_isr,
>> &frame_done_completion,
>> +    r =3D omap_dispc_register_isr(dispc_mgr_disable_isr, &framedone_c=
ompl,
>>               irq_mask);
>>       if (r)
>>           DSSERR("failed to register %x isr\n", irq_mask);
>=20
> We should probably sleep here too as we did for LCD above.

Yep, good point. I'll add that.

 Tomi




--------------enig599D0C9D3C9B32EFC5178784
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQf9VnAAoJEPo9qoy8lh71f2EQAJ6Fkxz0e5W3tsqtSPBs1Z+L
Lu6HlaUFx4ffs9RPPBzc2ZljxToDQ93pDrrCURiF+FLR7u1q1jY7XUo/mNpofvX0
ZVFRWvmHyiNwqVqlCPlznRbkEm+06xKEzoIo/DISa2i2xSQt67A5Ky+hqBIu8jYA
sjUCqO1HNfhiT5wM/mFNLhG3g1DOeI+VstSc5dXqkE404qdND661z/iP/j9munrA
B9GJDdKHdIl0u98ElpxXlzymfwRl/+a6U8YTFr4h9ftWdO6sPi2bEO8abowTMWB3
rDytUyY9UbJHQtWHaov865lHRUr8r6Cub/kwbaXMETaJrIGb0Q2jMl+rbOKd7/96
4d30kteFw8ih2gKddb2KrhL3laSdIfYUP3Bxf2GsYz5SpPj8cVbjyXIa1X11ZUyi
DfxvSFjkAayJIqQt5lETq6k2pJVH98ah4pTdLPAY1MvpIUIl/h9tG688NXEshgLB
naxl1JOv9/ZmbxCusOkeyg6vG4tKbSpNk6TblpEKnFOipWsqqAazM3agjqrQazQO
zgWbRtvzQ+Ws1K1ExEhmnhFPHp4HaGlKD013eGcLJSY2HzMAfcdd4AZ6jG7esT3d
UtHdVXKOrOSat+sJgkBeWazR+bQ8lcqbR5d9H2/SktMu2ab+ocwhTKwTJEekeb6L
9U6osxcbihPlntp9lAyi
=yK20
-----END PGP SIGNATURE-----

--------------enig599D0C9D3C9B32EFC5178784--
