From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH RESEND v5 3/3] arm/dts: AM33XX: Add D_CAN device tree data
Date: Wed, 05 Sep 2012 15:46:58 +0200
Message-ID: <504757D2.90601@pengutronix.de>
References: <1346845260-10978-1-git-send-email-anilkumar@ti.com>
 <1346845260-10978-4-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2089826236823169267=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1346845260-10978-4-git-send-email-anilkumar-l0cyMroinI0@public.gmane.org>
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
To: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bryan.wu-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============2089826236823169267==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig29B910F3C5904AF20D082085"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig29B910F3C5904AF20D082085
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/05/2012 01:41 PM, AnilKumar Ch wrote:
> Add Bosch D_CAN controller device tree data to AM33XX dtsi
> file by adding d_can device nodes with all the necessary
> parameters.
>=20
> Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/boot/dts/am33xx.dtsi |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.d=
tsi
> index bf5f713..ab744d6 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -177,5 +177,23 @@
>  			compatible =3D "ti,omap3-wdt";
>  			ti,hwmods =3D "wd_timer2";
>  		};
> +
> +		dcan0: d_can@481cc000 {
> +			compatible =3D "bosch,d_can";

On imx/mxs we also add a compatible for the current hardware, this may
look like this:

			compatible =3D "ti,am33xx-can", "bosch,d_can";

But I don't know if this is a generic policy or just an imx/mxs thing :)

Marc

> +			ti,hwmods =3D "d_can0";
> +			reg =3D <0x481cc000 0x2000>;
> +			interrupts =3D <52>;
> +			interrupt-parent =3D <&intc>;
> +			status =3D "disabled";
> +		};
> +
> +		dcan1: d_can@481d0000 {
> +			compatible =3D "bosch,d_can";
> +			ti,hwmods =3D "d_can1";
> +			reg =3D <0x481d0000 0x2000>;
> +			interrupts =3D <55>;
> +			interrupt-parent =3D <&intc>;
> +			status =3D "disabled";
> +		};
>  	};
>  };
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig29B910F3C5904AF20D082085
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBHV9UACgkQjTAFq1RaXHN+BQCfVsJm0ab5HWiYeElf9AzSXv0u
KSsAnj7KhzT3553Cup8CCWuZLQIXmQMP
=OStK
-----END PGP SIGNATURE-----

--------------enig29B910F3C5904AF20D082085--

--===============2089826236823169267==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============2089826236823169267==--
