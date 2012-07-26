From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 1/2] arm/dts: AM33XX: Add D_CAN device tree data
Date: Thu, 26 Jul 2012 11:14:57 +0200
Message-ID: <50110A91.2080508@pengutronix.de>
References: <1343219012-19472-1-git-send-email-anilkumar@ti.com>
 <1343219012-19472-2-git-send-email-anilkumar@ti.com>
 <9D2B44C8-820E-4E96-A480-7A650583BC92@dominion.thruhere.net>
 <331ABD5ECB02734CA317220B2BBEABC13EA04433@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3581946412174764816=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA04433-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
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
Cc: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============3581946412174764816==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig279659FE36C48DC57D2D5DF2"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig279659FE36C48DC57D2D5DF2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/26/2012 11:03 AM, AnilKumar, Chimata wrote:
> On Thu, Jul 26, 2012 at 14:16:33, Koen Kooi wrote:
>>
>> Op 25 jul. 2012, om 14:23 heeft AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org> het vo=
lgende geschreven:
>>
>>> Add Bosch D_CAN controller device tree data to AM33XX dtsi file
>>> by adding d_can device node with all the necessary parameters.
>>>
>>> Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
>>> ---
>>> arch/arm/boot/dts/am33xx.dtsi |    5 +++++
>>> 1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx=
=2Edtsi
>>> index 9b974dc..2db2ffb 100644
>>> --- a/arch/arm/boot/dts/am33xx.dtsi
>>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>>> @@ -163,5 +163,10 @@
>>> 			#size-cells =3D <0>;
>>> 			ti,hwmods =3D "i2c3";
>>> 		};
>>> +
>>> +		dcan1: d_can@481D0000 {
>>> +			compatible =3D "bosch,d_can";
>>> +			ti,hwmods =3D "d_can1";
>>> +		};
>>> 	};
>>
>> I scanned the linux-networking mailinglist and l-o-ml, but I can't fin=
d the patchset that actually adds the d_can drivers, could you provide a =
link to that? I have 2 different CAN capes I'd like to test on beaglebone=
=2E
>>
>=20
> You can find it from linux-next or net-next trees, D_CAN support is add=
ed
> to C_CAN driver.
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/davem/net-next.git;
> a=3Dcommitdiff;h=3D69927fccd96b15bd228bb82d356a7a2a0cfaeefb

Meanwhile it's in Linus's git tree.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig279659FE36C48DC57D2D5DF2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlARCpcACgkQjTAFq1RaXHPKVQCeKXK3nVR6k5CyfkP4NBvnQpfi
OgQAn0DBsdSzHniHz3/CEDB6B3PTF6ms
=7Fkl
-----END PGP SIGNATURE-----

--------------enig279659FE36C48DC57D2D5DF2--

--===============3581946412174764816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============3581946412174764816==--
