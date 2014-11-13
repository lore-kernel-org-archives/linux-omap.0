From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4 06/10] ARM: dts: am4372: Add DCAN nodes
Date: Thu, 13 Nov 2014 15:54:01 +0100
Message-ID: <5464C609.9070800@pengutronix.de>
References: <1415881371-4982-1-git-send-email-rogerq@ti.com> <1415881371-4982-7-git-send-email-rogerq@ti.com> <5464BB38.7020402@pengutronix.de> <5464C2C4.2070907@ti.com> <5464C3B1.2030908@pengutronix.de> <5464C4E8.9060103@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VaQqdm9EkN0XFQ0KWMpWIUPLrg0DTF7P3"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <5464C4E8.9060103@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: wg@grandegger.com, wsa@the-dreams.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VaQqdm9EkN0XFQ0KWMpWIUPLrg0DTF7P3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/13/2014 03:49 PM, Roger Quadros wrote:
> On 11/13/2014 04:44 PM, Marc Kleine-Budde wrote:
>> On 11/13/2014 03:40 PM, Roger Quadros wrote:
>>> On 11/13/2014 04:07 PM, Marc Kleine-Budde wrote:
>>>> On 11/13/2014 01:22 PM, Roger Quadros wrote:
>>>>> The SoC contains 2 DCAN modules. Add them.
>>>>>
>>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>>> ---
>>>>>  arch/arm/boot/dts/am4372.dtsi | 22 ++++++++++++++++++++++
>>>>>  1 file changed, 22 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am43=
72.dtsi
>>>>> index 899c57c..12fb1db 100644
>>>>> --- a/arch/arm/boot/dts/am4372.dtsi
>>>>> +++ b/arch/arm/boot/dts/am4372.dtsi
>>>>> @@ -901,6 +901,28 @@
>>>>>  			compatible =3D "mmio-sram";
>>>>>  			reg =3D <0x40300000 0x40000>; /* 256k */
>>>>>  		};
>>>>> +
>>>>> +		dcan0: can@481cc000 {
>>>>> +			compatible =3D "ti,am3352-d_can";
>>>>
>>>> You should add "ti,am4372-d_can" as first compatible here.
>>>>
>>> We don't have a separate compatible id for am4372-d_can
>>> as it the IP exactly same as am3352-d_can.
>>
>> Having the "ti,am4372-d_can" compatible gives you the freedom to add
>> some spacial handling for the IP if there turns that you need to witho=
ut
>> needing to modify the device tree. (We do this on imx.)
>=20
> Agreed. On OMAP platforms we don't add new compatible IDs unless we rea=
lly need to.
> Can we add "ti,am4372-d_can" even if it is not mentioned in Documentati=
on/devicetree/bindings?
>=20
> Tony what is your preference?

I don't insist, do it the Omap way :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--VaQqdm9EkN0XFQ0KWMpWIUPLrg0DTF7P3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZMYJAAoJECte4hHFiupULt0P/iN9oUkk8L3BiQNanfOo/eC3
PKlk+6NLwjeLD7oEDmAI1r4eF3TkXyAkOSO7UWKB3tE8d0CmG0O1aYBFzMCz+kmN
++Lg6VbWIAX4fWLgXC2VRRaMdcUlxIukTsV1hFJz+pwGKIZ219jR8EAKrGP1G5LL
tQDN99T1L9soBGHXnC/1KPH3sjCY6F/yYXB9P+XDL9BIURbMdIxjuXoYwFmZLRTZ
CuezlA/QSfuyLqxRQIxEPoDSD+YY7jnUiVy1fISNhGM5zB2mNbggiHNsrUD4FLZi
yuYimbpDL03PuknywH1KK8ucHZZSDh5ihtTnNDqXggIAtgEZuXUHu1lLiUcaVkLk
rqCdrFc/bDcFSC9VeUAiRlcdpHjwnTMx7xIa7iwEjZvmsUyYZAq0t4PX/ZEkZNSG
t5R1R0tmY+EzuE3nrFl0hWOWoAZXUA/tqy+3rXbuCevKpZkrVkcd6a2bdtsEF29N
K8lQNXaKWuhVRBFUZmql39PXBdgfMS3l6PMEDmVm+WaD74kZ8NGbjhdMN6MPouZ1
Ex3oTgr6hMNnrCN2TfidIJ5czBCONKYjzFBrPvxYQOr6RE4Bmp/ehuqIpa5wxS3r
4/W/dKGU+c+DSTqHFxWY+wbcRPHmvcPkJum3Y+gMnceRa4dNHYKk2+VNzLvdgFAV
R23ViXBlVysHznPDH0o2
=uoSN
-----END PGP SIGNATURE-----

--VaQqdm9EkN0XFQ0KWMpWIUPLrg0DTF7P3--
