From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 11/23] ARM: dts: omap5-uevm.dts: add tca6424a
Date: Thu, 24 Apr 2014 17:33:03 +0300
Message-ID: <5359209F.7000308@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com> <1398334639-14172-12-git-send-email-tomi.valkeinen@ti.com> <53591669.7060502@cogentembedded.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="OaNegstrUp0IMkpXkdUnbMjfdWxxosrXN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43898 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755990AbaDXOda (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2014 10:33:30 -0400
In-Reply-To: <53591669.7060502@cogentembedded.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

--OaNegstrUp0IMkpXkdUnbMjfdWxxosrXN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 24/04/14 16:49, Sergei Shtylyov wrote:
> Hello.
>=20
> On 24-04-2014 14:17, Tomi Valkeinen wrote:
>=20
>> omap5-uevm has a tca6424a I/O expander. Add it to the .dts file.
>=20
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> ---
>>   arch/arm/boot/dts/omap5-uevm.dts | 7 +++++++
>>   1 file changed, 7 insertions(+)
>=20
>> diff --git a/arch/arm/boot/dts/omap5-uevm.dts
>> b/arch/arm/boot/dts/omap5-uevm.dts
>> index 3b99ec25b748..9e7581eaeb23 100644
>> --- a/arch/arm/boot/dts/omap5-uevm.dts
>> +++ b/arch/arm/boot/dts/omap5-uevm.dts
>> @@ -434,6 +434,13 @@
>>       pinctrl-0 =3D <&i2c5_pins>;
>>
>>       clock-frequency =3D <400000>;
>> +
>> +    tca6424a: tca6424a@22 {
>=20
>    The ePAPR standard [1] says: "The name of a node should be somewhat
> generic,
> reflecting the function of the device and not its precise programming
> model.
> If appropriate, the name should be one of the following choices:
> [...]
>    - gpio;"

Right. I wonder what the name should be... "gpio" is out, as the name
should be more specific. We already have gpio1-8, which are the gpio
banks from the SoC. It could be 'gpio9', but that makes it sound it's
just one more SoC gpio bank. 'gpio-expander1'?

 Tomi



--OaNegstrUp0IMkpXkdUnbMjfdWxxosrXN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTWSCfAAoJEPo9qoy8lh715sAP/j2FkKE1tWbsDl47WvBt/OR7
J0iCFHWGmrnMvlE0I9/nG5RGUcKyOa5QoJ54vA7dEC/7yAB0I0ESifDQJH/Ahgb0
AoP/zqVVaWJzb5uIqKTnhzKZJMJ/Rd7BRaPe48hQicPZr+ywvSKdtH6HyLMBCidp
nt+o7sgED/PUMk5WfmGzNJPGv590uNis89dM0Jpzk8VNpqWSZIgZf/yQAYApFrsv
bYLPrgwKy3oGWxWiwWLjSUxI9tMkLgytrvTDrsGJvpoFp4L6XB8BaAFmGpD6D+92
Mkb2iNE0Z8/hahxPb7hSwF4D7ri+XClycQtzyDB6YEHTbVFTqGLqSBpvJn7jjMKJ
9isSJ20OZSnHsPKW29Uwz9Xwb88kB1dJv5NvZ8nzej3+Pgssj4pnhMFoUwAdvXQF
ChIIBlFZNcVpDqoGByNH57cXazMSOiduS7Dov66h7wrkOW87Z3K5m+L9E8sVRgfP
jbuf5EANDLeuZ/eiWzq5GqDaeJoMsyZxJdH+9j+/fZWU3SBl1+3428omoaXRf9eu
02yAyJjnbBeD2F2Obj4LblryfdzfXGe3t+0IMlzti54vqsVXSb+0YzBYgIj38hrj
XTNVKMZXKsiwjOjT0iXCdw/lnmF1QwGXKUDFub42n0/IBKwOM09cv4/sCzqbbeEb
cBD5qPHMCzdhzkpnXtYP
=Yfux
-----END PGP SIGNATURE-----

--OaNegstrUp0IMkpXkdUnbMjfdWxxosrXN--
