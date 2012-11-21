From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 3/3] ARM: dts: AM33XX: Add memory resource to d_can node
Date: Wed, 21 Nov 2012 09:20:57 +0100
Message-ID: <50AC8EE9.7040508@pengutronix.de>
References: <1352916505-12343-1-git-send-email-anilkumar@ti.com>
 <1352916505-12343-4-git-send-email-anilkumar@ti.com>
 <50AB57B0.7040502@pengutronix.de>
 <331ABD5ECB02734CA317220B2BBEABC13EA7701D@DBDE01.ent.ti.com>
 <50AB5AD8.7060407@pengutronix.de>
 <331ABD5ECB02734CA317220B2BBEABC13EA778F3@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2821725126585838083=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA778F3-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============2821725126585838083==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9ACA812AAE5026D4C7B34E8E"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9ACA812AAE5026D4C7B34E8E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/21/2012 06:45 AM, AnilKumar, Chimata wrote:
> On Tue, Nov 20, 2012 at 15:56:32, Marc Kleine-Budde wrote:
>> On 11/20/2012 11:23 AM, AnilKumar, Chimata wrote:
>>> On Tue, Nov 20, 2012 at 15:43:04, Marc Kleine-Budde wrote:
>>>> On 11/14/2012 07:08 PM, AnilKumar Ch wrote:
>>>>> Add a new address space/memory resource to d_can device tree node. =
D_CAN
>>>>> RAM initialization is achieved through RAMINIT register which is pa=
rt of
>>>>> AM33XX control module address space. D_CAN RAM init or de-init shou=
ld be
>>>>> done by writing instance corresponding value to control module regi=
ster.
>>>>>
>>>>> Till we have a separate control module driver to write to control m=
odule,
>>>>> d_can driver will handle the register writes to control module by i=
tself.
>>>>> So a new address space to represent this control module register is=
 added
>>>>> to d_can driver.
>>>>>
>>>>> Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
>>>>
>>>> This does not apply to net-next/master:
>>>>
>>>> Applying: ARM: dts: AM33XX: Add memory resource to d_can node
>>>> error: patch failed: arch/arm/boot/dts/am33xx.dtsi:227
>>>> error: arch/arm/boot/dts/am33xx.dtsi: patch does not apply
>>>> Patch failed at 0003 ARM: dts: AM33XX: Add memory resource to d_can =
node
>>>>
>>>
>>> Marc,
>>>
>>> Sorry about this DT changes are present in linux-omap.
>>>
>>> Could you please take the driver changes only and ACK on remaining wi=
ll
>>> help.
>>
>> Will do - I'm currently looking at the driver.
>>
>=20
> Hi Marc,
>=20
> Please ACK this patch as well.

done :)

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig9ACA812AAE5026D4C7B34E8E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlCsjukACgkQjTAFq1RaXHMAqwCeJrpvTirkeBv6ewxKV3Ld/ETa
JmAAnRgI4vLuafNxw2gavEU7b8Mbq6o8
=0nfG
-----END PGP SIGNATURE-----

--------------enig9ACA812AAE5026D4C7B34E8E--

--===============2821725126585838083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============2821725126585838083==--
