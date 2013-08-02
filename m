From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: Remove legacy DSS initialization for
 omap4
Date: Fri, 2 Aug 2013 16:04:28 +0300
Message-ID: <51FBAE5C.1060602@ti.com>
References: <1374570405-8301-1-git-send-email-tomi.valkeinen@ti.com> <1374570405-8301-3-git-send-email-tomi.valkeinen@ti.com> <51FBAC91.8040401@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="l2DMgXGXQoPXLXfVAuh1I5Xuga6KnctGP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59231 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904Ab3HBNE6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Aug 2013 09:04:58 -0400
In-Reply-To: <51FBAC91.8040401@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--l2DMgXGXQoPXLXfVAuh1I5Xuga6KnctGP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/08/13 15:56, Nishanth Menon wrote:
> On 07/23/2013 04:06 AM, Tomi Valkeinen wrote:
>> This is no longer needed as omap4 is now booted using device tree.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---

<snip>

>> diff --git a/arch/arm/mach-omap2/dss-common.h
>> b/arch/arm/mach-omap2/dss-common.h
>> index 915f6ff..c28fe3c 100644
>> --- a/arch/arm/mach-omap2/dss-common.h
>> +++ b/arch/arm/mach-omap2/dss-common.h
>> @@ -6,9 +6,7 @@
>>    * This file will be removed when DSS supports DT.
>>    */
>>
>> -void __init omap4_panda_display_init(void);
>>   void __init omap4_panda_display_init_of(void);
>> -void __init omap_4430sdp_display_init(void);
>>   void __init omap_4430sdp_display_init_of(void);
>>
>>   #endif
>>
>=20
> Am I missing some series which introduces dts entries for the pinctrl
> and gpios for omap4 support?

Umm... What? =3D).

In this dss-common.c file we have code to add the SDP and Panda DSS
related devices, for both board-file booting and for DT booting. Now the
board-file booting is no longer available, so we can remove the parts
that are purely for board-file booting.

 Tomi



--l2DMgXGXQoPXLXfVAuh1I5Xuga6KnctGP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR+65cAAoJEPo9qoy8lh71W9EP/0AX+YZiqa3simUpbWawJwxi
T7QQJj+/bF8nassTxVvqLa4FuPjpuHY37uG/yyHScBEhd8n6B5QgNbfXfc2yvqL3
2T5plLmnnufOdomkAc3Sf2QGe1T+9nu1UIH2NO3YVjM5CYDSNw8n+AjisRcNnPXn
+RjhXpnBIFpYUEf1bITe4az8n2wQbo1xcLdliZsnIFf7p5wArt7jpelnvgZwtQC6
iB36OjjJZlycm9hCPdzpGsNgBhdnVqSXfNOmRzR+PFE6osH2X5ShqBqseaeJ/Yd7
H0r+v3O7nVkYNl1ca1PTKiZjXhmCmjBFe/7VOcmt8Ti0ftTw36GGMeCl25juCu2t
lWKKpPQ6rLxzmblsbAriPn9sQWORPLkkjUtd2eOty1QdVAz3kmQF5zTRzMhuWXjh
WNvth9pNmJFRu5yiG10Sl276P/sYxiANyL56nH5SZdKmWN2inzOWtELetrJzV0Tf
7xEqPC7cBTSBulDaZVo25wwdOH6ZCMr+Ly3klTzddWPwDxYJkMbwNrofCRO6Mtcf
+zjmj2ulupDKZ0cOdO9v8wIK/BIftYvDeFogi3+zAb/cQjmXcMFrBqAfFWBeuoyV
MBC5Ay5a0eVBG5nzWEGXqn9o0l4kvoq+fY7BiB2dCw2vQsxG+s39VUec75OWa77K
WJE4ypSTYgflwpuRzbbD
=DR4f
-----END PGP SIGNATURE-----

--l2DMgXGXQoPXLXfVAuh1I5Xuga6KnctGP--
