From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4 06/10] ARM: dts: am4372: Add DCAN nodes
Date: Thu, 13 Nov 2014 15:44:01 +0100
Message-ID: <5464C3B1.2030908@pengutronix.de>
References: <1415881371-4982-1-git-send-email-rogerq@ti.com> <1415881371-4982-7-git-send-email-rogerq@ti.com> <5464BB38.7020402@pengutronix.de> <5464C2C4.2070907@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HQxguQWWOcse30UM1PMuFgoOIvP1puu9q"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <5464C2C4.2070907@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: wg@grandegger.com, wsa@the-dreams.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HQxguQWWOcse30UM1PMuFgoOIvP1puu9q
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/13/2014 03:40 PM, Roger Quadros wrote:
> On 11/13/2014 04:07 PM, Marc Kleine-Budde wrote:
>> On 11/13/2014 01:22 PM, Roger Quadros wrote:
>>> The SoC contains 2 DCAN modules. Add them.
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> ---
>>>  arch/arm/boot/dts/am4372.dtsi | 22 ++++++++++++++++++++++
>>>  1 file changed, 22 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372=
=2Edtsi
>>> index 899c57c..12fb1db 100644
>>> --- a/arch/arm/boot/dts/am4372.dtsi
>>> +++ b/arch/arm/boot/dts/am4372.dtsi
>>> @@ -901,6 +901,28 @@
>>>  			compatible =3D "mmio-sram";
>>>  			reg =3D <0x40300000 0x40000>; /* 256k */
>>>  		};
>>> +
>>> +		dcan0: can@481cc000 {
>>> +			compatible =3D "ti,am3352-d_can";
>>
>> You should add "ti,am4372-d_can" as first compatible here.
>>
> We don't have a separate compatible id for am4372-d_can
> as it the IP exactly same as am3352-d_can.

Having the "ti,am4372-d_can" compatible gives you the freedom to add
some spacial handling for the IP if there turns that you need to without
needing to modify the device tree. (We do this on imx.)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--HQxguQWWOcse30UM1PMuFgoOIvP1puu9q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZMOxAAoJECte4hHFiupURgoP/29GK6hZ/lpJpaxYQOet9SBL
rWT829bnDRzAQUX9U8u7HR79xSipuEwqx6E1w06Bvbc6dxejsCeiKR8PS9FeHbfU
tA9v8ieaxmqPmQ1y3KKIo/Zy/7t0o4jEBdHrcGDsTWhqjjMfGNgh6y6ZMxegpYx6
KmEpFyoTqfwOsR1C5j9FznSpDbd2KXCF9BX4Y5ySVGpjDBLvmw6oTaXDlbvLYiMz
Rd83ReTelr/T98P/sMrvdomyHz2S6X30F8mq4Oaf2QQWF72SiZAGvGz+OmxwSWl5
sDtf1ZzyWZorUvbmmziVMWnyMLMmD/f2Cnwk+PvoDRiHaxxubWMkBIMPCYqBhmIE
RWuANn3/ZNJ0y+OWZtumNWLVsAnzwYiKU7s6jYMypKLGxn6AjQz9DclC7rzy280w
Gwmfz7FBSZFKIqtg6iOCRGecNdID8LjS37jhO+rPXiqm7DVUnqrs+FGJ2dE/ceQO
vgrTVXQ9l7gZhseTKvyvmLR3jizURNuVJbTbApen1d/eE/nYOGnYDSkQej5aGmVy
DE3Y0iUVZNn9+cbpwa35K0PSlHU+VmeX1EId8SGUOkxydcgrx15TX+kqlWG+GAc/
JSoKa7YupfVff8i/ExFfWiGu8LSCfkxVmYpsaOQCS0jO7SahUN9U0ak31P8y7OfT
uYxyFP4ep0sThcLcQt+T
=moDZ
-----END PGP SIGNATURE-----

--HQxguQWWOcse30UM1PMuFgoOIvP1puu9q--
