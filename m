From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: downscaling YUV fails
Date: Wed, 19 Dec 2012 15:10:04 +0200
Message-ID: <50D1BCAC.4080900@ti.com>
References: <alpine.DEB.2.01.1212191025480.16226@pmeerw.net> <50D193FD.4070401@ti.com> <alpine.DEB.2.01.1212191132250.16226@pmeerw.net> <50D1A2BC.4040605@ti.com> <50D1A34B.8030308@ti.com> <50D1AA85.1000207@ti.com> <50D1AC15.90407@ti.com> <50D1B0D1.6010703@ti.com> <50D1B50D.3080909@ti.com> <50D1BA65.2090806@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF475DEA89F1CB8F1F4073156"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51409 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab2LSNKI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 08:10:08 -0500
In-Reply-To: <50D1BA65.2090806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>, linux-omap@vger.kernel.org

--------------enigF475DEA89F1CB8F1F4073156
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-12-19 15:00, Archit Taneja wrote:
> On Wednesday 19 December 2012 06:07 PM, Tomi Valkeinen wrote:
>> On 2012-12-19 14:19, Archit Taneja wrote:
>>
>>>> The image I get is stable, and clearly something that happens when,
>>>> say,
>>>> row_inc is one pixel too much, or similar.
>>>
>>> Ok, about the width in this case. The original width is 400, and what=
 we
>>> finally want is 220. After pre-decimation, the width would become 200=
,
>>> and we would need our scalar to actually upscale to 220.
>>>
>>> I am wondering if the driver gets confused when such a scenario occur=
s,
>>> or the DSS HW is weird when we upscale some predecimated content. If =
you
>>> look at the hinc(1024  * width/out_width) value in the FIR register, =
in
>>> the "ok" regdumps, the value is 1861, which points to downscaling. An=
d
>>> in the fail case, it's 92, which is upscaling.
>>
>> I can reproduce this with a very simple case. 400x200 -> 200x200, and
>> forcing horizontal predecimation. So this will cause no scaling to be
>> used, only the pixel_inc is used to downscale.
>=20
> Ah okay. My guess was wrong then :)
>=20
>>
>> The VID1 registers are as follows. They look right to me...
>>
>> DISPC_OVL_BA0(VID1)                                8d900000
>> DISPC_OVL_BA1(VID1)                                8d900000
>> DISPC_OVL_POSITION(VID1)                           00000000
>> DISPC_OVL_SIZE(VID1)                               00c700c7
>> DISPC_OVL_ATTRIBUTES(VID1)                         00608011
>> DISPC_OVL_FIFO_THRESHOLD(VID1)                     03ff03c0
>> DISPC_OVL_FIFO_SIZE_STATUS(VID1)                   00000400
>> DISPC_OVL_ROW_INC(VID1)                            00000001
>> DISPC_OVL_PIXEL_INC(VID1)                          00000005
>> DISPC_OVL_PRELOAD(VID1)                            00000100
>> DISPC_OVL_FIR(VID1)                                04000400
>> DISPC_OVL_PICTURE_SIZE(VID1)                       00c700c7
>> DISPC_OVL_ACCU0(VID1)                              00000000
>> DISPC_OVL_ACCU1(VID1)                              00000000
>> DISPC_OVL_PRELOAD(VID1)                            00000100
>=20
> The only thing which seems not so nice is that vertical taps and vid
> line buffer split are enabled in OVL_ATTRIBUTES. These shouldn't be
> harmful though.

Yep, I've tested disabling five_taps also, but it doesn't have any effect=
=2E

I'm at loss here =3D). If I force pix inc to 1, I get what I expect: an
image without skew, but the height is doubled as the left and right
sides are shows on two lines. Then setting pix inc to 5 causes the skew.
Colors are still correct, so the byte alignment is right.

 Tomi



--------------enigF475DEA89F1CB8F1F4073156
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQ0bysAAoJEPo9qoy8lh71r8cQAKWlVCGyqCxqU4YIL8nOBEOf
gPLqV/hQD+IZmm4QBTPm+Jxt3dwE7mPLsdXY908iNRb4qnI60fAxpbLsK/7EhgsD
aIcp8R21btg/zpd+ldRbNkGw66EfFKvMNRGpe6bKPxcpbma0wtaMBTQMFlqCyxyW
Z14ZdxvuvUa+NsfsF5gA+krBMv0VOYyWavHuhGqLR+bJ1j5e3OBJAiijN1r9hk/i
UQbOT7eE2TS+4r5CNUD6P8giZRn95fZH6Ud6u6veDv6Hr7TGO0TKJnchHf23Po9O
F4SpsCfDV0uCDuTW5sJM1fXOIsoe9na0VOPrmlOVYGmi0+29/ydjDLeZiv4r2Tso
eIxGAxAclybkl8F9eZaEuFx0FBaFgwfHBCrA6WHP59hVuPanwruvuMzx1IoE7zdW
Fhg77Lv/fgnnrzZXTguooyKmyjMe33K+CPlwlnkaL6KvtfR4oLiV/SjcGWNLLAo2
vQnLuBItE9rvMIYmJwOMa4rfCr6nf1gL3bVTcUDluhsoz15cGq0RgugTZqtkJ6pd
TMJ3lYXFUXfY5a6ZKG+oSDvvcPF2LBQU4s1UBlY5eKSqbxaGBGlCZnkWUesiB6ZG
3Bz0E0Z5/gBYWdk+sDE4ds6AYGb4S0J3RAEi2keWhHiFXTFlXdfTQyhyMBFy5Si+
Qkx3TA7ZPZy0R52vsRVy
=pqHy
-----END PGP SIGNATURE-----

--------------enigF475DEA89F1CB8F1F4073156--
