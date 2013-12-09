From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 18/26] ARM: omap3-beagle.dts: add display information
Date: Mon, 9 Dec 2013 14:06:32 +0200
Message-ID: <52A5B248.5050303@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>	<1386160133-24026-19-git-send-email-tomi.valkeinen@ti.com> <CABxcv=mgQM6oHf7=-EbryAcmgJm3vf+xXqHW6BCdW8ovS29O0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="TMLWorbCnFS0svMMRnRgDMTfaUdPJRtBD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42855 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932392Ab3LIMGg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Dec 2013 07:06:36 -0500
In-Reply-To: <CABxcv=mgQM6oHf7=-EbryAcmgJm3vf+xXqHW6BCdW8ovS29O0g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>

--TMLWorbCnFS0svMMRnRgDMTfaUdPJRtBD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2013-12-06 10:41, Javier Martinez Canillas wrote:
> Hi Tomi,
>=20
> On Wed, Dec 4, 2013 at 1:28 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>  arch/arm/boot/dts/omap3-beagle.dts | 67 +++++++++++++++++++++++++++++=
+++++++++
>>  1 file changed, 67 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/om=
ap3-beagle.dts
>> index fa532aaacc68..1ca1932d02aa 100644
>> --- a/arch/arm/boot/dts/omap3-beagle.dts
>> +++ b/arch/arm/boot/dts/omap3-beagle.dts
>> @@ -178,3 +178,70 @@
>>         mode =3D <3>;
>>         power =3D <50>;
>>  };
>> +
>> +&dpi {
>> +       vdds_dsi-supply =3D <&vpll2>;
>> +
>> +       dpi_out: endpoint {
>> +               remote-endpoint =3D <&tfp410_in>;
>> +               data-lines =3D <24>;
>> +       };
>> +};
>> +
>> +&venc {
>> +       vdda_dac-supply =3D <&vdac>;
>> +
>> +       venc_out: endpoint {
>> +               remote-endpoint =3D <&tv_connector_in>;
>> +       };
>> +};
>> +
>> +/ {
>> +       aliases {
>> +               display0 =3D &dvi0;
>> +               display1 =3D &tv0;
>> +       };
>> +
>> +       tfp410: encoder@0 {
>> +               compatible =3D "ti,tfp410";
>> +               gpios =3D <&gpio5 10 0>;  /* 170, power-down */
>> +
>=20
> Shouldn't this be gpio6 instead since OMAP GPIO banks start counting
> from 1 so gpio5 + 10 is GPIO 138.

Yes, you're right. Good catch.

>> +               ports {
>> +                       #address-cells =3D <1>;
>> +                       #size-cells =3D <0>;
>> +
>> +                       port@0 {
>> +                               reg =3D <0>;
>> +
>> +                               tfp410_in: endpoint@0 {
>> +                                       remote-endpoint =3D <&dpi_out>=
;
>> +                               };
>> +                       };
>> +
>> +                       port@1 {
>> +                               reg =3D <1>;
>> +
>> +                               tfp410_out: endpoint@1 {
>> +                                       remote-endpoint =3D <&dvi_conn=
ector_in>;
>> +                               };
>> +                       };
>> +               };
>> +       };
>> +
>> +       dvi0: connector@0 {
>> +               compatible =3D "ti,dvi_connector";
>> +               i2c-bus =3D <&i2c3>;
>> +
>> +               dvi_connector_in: endpoint {
>> +                       remote-endpoint =3D <&tfp410_out>;
>> +               };
>> +       };
>> +
>> +       tv0: connector@1 {
>> +               compatible =3D "ti,svideo_connector";
>> +
>> +               tv_connector_in: endpoint {
>> +                       remote-endpoint =3D <&venc_out>;
>> +               };
>> +       };
>> +};
>> --
>> 1.8.3.2
>>
>=20
> Also I don't see the DSS pinmux set for this board. I guess you need
> something like the following on top:
>=20
> 0x0a4 (PIN_OUTPUT | MUX_MODE0)   /* dss_pclk.dss_pclk */
> 0x0a6 (PIN_OUTPUT | MUX_MODE0)   /* dss_hsync.dss_hsync */
> 0x0a8 (PIN_OUTPUT | MUX_MODE0)   /* dss_vsync.dss_vsync */
> 0x0aa (PIN_OUTPUT | MUX_MODE0)   /* dss_acbias.dss_acbias */
> 0x0ac (PIN_OUTPUT | MUX_MODE0)   /* dss_data0.dss_data0 */
> 0x0ae (PIN_OUTPUT | MUX_MODE0)   /* dss_data1.dss_data1 */
> 0x0b0 (PIN_OUTPUT | MUX_MODE0)   /* dss_data2.dss_data2 */
> 0x0b2 (PIN_OUTPUT | MUX_MODE0)   /* dss_data3.dss_data3 */
> 0x0b4 (PIN_OUTPUT | MUX_MODE0)   /* dss_data4.dss_data4 */
> 0x0b6 (PIN_OUTPUT | MUX_MODE0)   /* dss_data5.dss_data5 */
> 0x0b8 (PIN_OUTPUT | MUX_MODE0)   /* dss_data6.dss_data6 */
> 0x0ba (PIN_OUTPUT | MUX_MODE0)   /* dss_data7.dss_data7 */
> 0x0bc (PIN_OUTPUT | MUX_MODE0)   /* dss_data8.dss_data8 */
> 0x0be (PIN_OUTPUT | MUX_MODE0)   /* dss_data9.dss_data9 */
> 0x0c0 (PIN_OUTPUT | MUX_MODE0)   /* dss_data10.dss_data10 */
> 0x0c2 (PIN_OUTPUT | MUX_MODE0)   /* dss_data11.dss_data11 */
> 0x0c4 (PIN_OUTPUT | MUX_MODE0)   /* dss_data12.dss_data12 */
> 0x0c6 (PIN_OUTPUT | MUX_MODE0)   /* dss_data13.dss_data13 */
> 0x0c8 (PIN_OUTPUT | MUX_MODE0)   /* dss_data14.dss_data14 */
> 0x0ca (PIN_OUTPUT | MUX_MODE0)   /* dss_data15.dss_data15 */
> 0x0cc (PIN_OUTPUT | MUX_MODE0)   /* dss_data16.dss_data16 */
> 0x0ce (PIN_OUTPUT | MUX_MODE0)   /* dss_data17.dss_data17 */
> 0x0d0 (PIN_OUTPUT | MUX_MODE0)   /* dss_data18.dss_data18 */
> 0x0d2 (PIN_OUTPUT | MUX_MODE0)   /* dss_data19.dss_data19 */
> 0x0d4 (PIN_OUTPUT | MUX_MODE0)   /* dss_data20.dss_data20 */
> 0x0d6 (PIN_OUTPUT | MUX_MODE0)   /* dss_data21.dss_data21 */
> 0x0d8 (PIN_OUTPUT | MUX_MODE0)   /* dss_data22.dss_data22 */
> 0x0da (PIN_OUTPUT | MUX_MODE0)   /* dss_data23.dss_data23 */

True. I need to add something like this to all the dts files.

You didn't have muxing in the omap3-igep0020 patch you gave. Is the
muxing already set in some other patch?

 Tomi



--TMLWorbCnFS0svMMRnRgDMTfaUdPJRtBD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSpbJIAAoJEPo9qoy8lh71jbgP/202AqtG4v6jpY0ocMmNTep1
1yKesysZq72yojw8AgeExWgCg7R7OwMvA0JuKNKX4iOvQe/BiWPbwKf4x1gPAwYd
QyklCqrFNZ0qt5eQ6uyxYzNn2KcwXb7ScpZcIuRsYuWxh+KGolzdWDrCmpFIUVyB
su32003WGwGoVkIpnB3PNCi/IaFeHN3amBVswCr2Lv3lmYaPEPc0qmV0cGi+IOLq
Zi9VQsS8vk3kXYTQO1JAkIGrELj9sbKaxYYyvHzl/OkFKC3XuOZVuchCFjnaou63
fHd3QVwE1MmwECisJj1C7U64Vs+JMT0loGw7f82BZUmi+KPU5lwI1DJeoY65pJgW
5LIAC+3zwy0aKVFaJRf77H/fOAduQJJG4t8cBMSivN4pg6LESzFM9QK9SKo7Dngh
tvWyiGzu6d6mL+Dczu0LW8N76anKgWK69KQpN7RQ+/n3A8W1iVYUeZRstlDtBz/n
me9JAswYtIRNCh4wNVUcCmBblfrsGtWogKxOZmniXxG3T+kaNJ6AVNqek0wVmAHs
wa+NqJ3dr++lzTofFdmUiI6sN7fZEOWof2srG869HzF9DM7WKHX1/zvVUog33/hb
oPJ/AsNrKcl8upC6xkaz5R+FN429vTYQBmZ8I10yffcmmGmDADdjSmmwatrMQcbl
vF/RyqduopGgquIS+Di1
=24rd
-----END PGP SIGNATURE-----

--TMLWorbCnFS0svMMRnRgDMTfaUdPJRtBD--
