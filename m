From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] ARM: dts: duovero-parlor: Add HDMI output
Date: Wed, 21 May 2014 15:03:59 +0300
Message-ID: <537C962F.6050104@ti.com>
References: <1400663706-24104-1-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="GBMOpaQWTQSbNecKVx7UtUo4Kijbc7sEH"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48262 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827AbaEUME2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 May 2014 08:04:28 -0400
In-Reply-To: <1400663706-24104-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

--GBMOpaQWTQSbNecKVx7UtUo4Kijbc7sEH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 21/05/14 12:15, Florian Vaussard wrote:
> Add the necessary DTS nodes to enable the micro-HDMI output on Parlor
> board.
>=20
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
> v1->v2:
> - Rebased on Tony's omap-for-v3.16/dt-v2
> - Use OMAP4_IOPAD macro
> - Use hpd pin as GPIO with hdmi-connector
>=20
>  arch/arm/boot/dts/omap4-duovero-parlor.dts | 44 ++++++++++++++++++++++=
++++++++
>  1 file changed, 44 insertions(+)

Looks good to me.

 Tomi



--GBMOpaQWTQSbNecKVx7UtUo4Kijbc7sEH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTfJYvAAoJEPo9qoy8lh71c40P/2+5NgA9MKzjhM6h48ol+H5X
NP2S9GONO/ovh05UEOlLh6y/lRuR8bQYpi5WVSqFZWp4It1GSYJM5r3YZMXz+UEA
2Vr+yns1o1yMcJ/fHybLlXgGxl32TZb+Rc51TVjqa7YVjQxzhgK82Vf6IBsKg75E
LqZdiBCmDfz+j6f1e8+HGvC0np0LjfNXntUog0uhQ/8ppitscMfxIutWRIYr3NT5
8ENMJmMDgQ+CEYWNZc+9abL9KEBFQGNV1XApSwUTq1154odA7zOr4QswoWQQcgcu
NVQZz1Er3d+90uH3f+DXLt1ku0FSu+GQg92wN+yOriVxPP2TLF4PRH/IbzfaQetI
lXd4NL9n4Cz0lA89Z5v2PxYOH41pqWKVCQ0/wea0iFCl8bbteqMlZAxMZcXlxSA9
cTCKFO2Zov/ujrPKJhPQGuQgDOa94U2xC4Ma6pBZgclRUF4YPhaaloUMEiHgwV3g
NyUkLQ0msyLs2Afddl+jqMYD5IPwEzjtnM8W4OxgI5+NWvuIWBLoswlDG053+HFW
N7cdM1eWxhM/V5+q5ow5Nj6snGrjNKugsOz6tC//nTrJT4ZaqkojnYsvip4/COFA
nH8P30Jd/gov5j5EUmuu9oX/gGfIdo7u5BiDHtc4T+D1aXoH4dKWbZ17vVX73AmN
eW4S2BdBoYOHbu/wgBKa
=bfhk
-----END PGP SIGNATURE-----

--GBMOpaQWTQSbNecKVx7UtUo4Kijbc7sEH--
