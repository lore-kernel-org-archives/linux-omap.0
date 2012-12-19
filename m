From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: downscaling YUV fails
Date: Wed, 19 Dec 2012 14:37:33 +0200
Message-ID: <50D1B50D.3080909@ti.com>
References: <alpine.DEB.2.01.1212191025480.16226@pmeerw.net> <50D193FD.4070401@ti.com> <alpine.DEB.2.01.1212191132250.16226@pmeerw.net> <50D1A2BC.4040605@ti.com> <50D1A34B.8030308@ti.com> <50D1AA85.1000207@ti.com> <50D1AC15.90407@ti.com> <50D1B0D1.6010703@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig005C317A6C331B3F5FE1C6F0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60422 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185Ab2LSMhh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Dec 2012 07:37:37 -0500
In-Reply-To: <50D1B0D1.6010703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>, linux-omap@vger.kernel.org

--------------enig005C317A6C331B3F5FE1C6F0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-12-19 14:19, Archit Taneja wrote:

>> The image I get is stable, and clearly something that happens when, sa=
y,
>> row_inc is one pixel too much, or similar.
>=20
> Ok, about the width in this case. The original width is 400, and what w=
e
> finally want is 220. After pre-decimation, the width would become 200,
> and we would need our scalar to actually upscale to 220.
>=20
> I am wondering if the driver gets confused when such a scenario occurs,=

> or the DSS HW is weird when we upscale some predecimated content. If yo=
u
> look at the hinc(1024  * width/out_width) value in the FIR register, in=

> the "ok" regdumps, the value is 1861, which points to downscaling. And
> in the fail case, it's 92, which is upscaling.

I can reproduce this with a very simple case. 400x200 -> 200x200, and
forcing horizontal predecimation. So this will cause no scaling to be
used, only the pixel_inc is used to downscale.

The VID1 registers are as follows. They look right to me...

DISPC_OVL_BA0(VID1)                                8d900000
DISPC_OVL_BA1(VID1)                                8d900000
DISPC_OVL_POSITION(VID1)                           00000000
DISPC_OVL_SIZE(VID1)                               00c700c7
DISPC_OVL_ATTRIBUTES(VID1)                         00608011
DISPC_OVL_FIFO_THRESHOLD(VID1)                     03ff03c0
DISPC_OVL_FIFO_SIZE_STATUS(VID1)                   00000400
DISPC_OVL_ROW_INC(VID1)                            00000001
DISPC_OVL_PIXEL_INC(VID1)                          00000005
DISPC_OVL_PRELOAD(VID1)                            00000100
DISPC_OVL_FIR(VID1)                                04000400
DISPC_OVL_PICTURE_SIZE(VID1)                       00c700c7
DISPC_OVL_ACCU0(VID1)                              00000000
DISPC_OVL_ACCU1(VID1)                              00000000
DISPC_OVL_PRELOAD(VID1)                            00000100

 Tomi



--------------enig005C317A6C331B3F5FE1C6F0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQ0bUNAAoJEPo9qoy8lh710OoP/3OZPpRr+w18NeLhLuR+ASvg
9J5M6ttDSCwWYV8IuTbnvvgwrMMDAUdqG5fC1BlVdBYSn9IVDQbf+1nHnY9QACtp
aw5dfAinLwe+qdoyvH9yuS+SHtcWGvy4+lITHwnoEdS+wp8gYNRCqA6nA8h8D5Mb
rMdt7NIQao6kp3/LyrcauxL3sz/ypgX4Ok0x7fS16hsf5FCelI7Zzg2DnNU3mjC7
uZ+ULjDM9vzfOLUzfAANkDJMhIn0NbY3wy9S3oD5tq8s50QnqFZtDCRQ5VCF8CIB
JbKOdn756VV270gg4rIgvILMeLqFC9xZOaVs2fCJBQwJqtYJEPVAcDR/g81Wv61I
RGQ3E66HxSXovCtwPssLABHRBTWzPx66mggw5zCSaBYFg5G45obCPhpHeae4C6Hk
451upOeZOwfo3BriXEYGstrLRVwmwakODSzJY369IgpOi8v4UeQfPWh5vuDI0t9m
5fARs1SV4fEOz0m/+mMYivghBjrtkJpU2LxgK7z5ZnXuhTmSHXYMvQ1t63oVnC77
0vujeof3BlsjBTBXpbFHmPn+IEpRDGmKiL9Y7V4RMrad0+dxhyhRF2QElRab3Fhv
x9YxVf0FEFkjkQCXKXIpS8gtkkZ72h6bG077rbIH97mqdksu9alRLkfHFJ4JamUG
7pt+Ug791iK53eUhGFMi
=H2jJ
-----END PGP SIGNATURE-----

--------------enig005C317A6C331B3F5FE1C6F0--
