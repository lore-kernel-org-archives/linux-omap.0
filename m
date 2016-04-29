From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: omap5-igep0050: Correct hdmi regulator
Date: Fri, 29 Apr 2016 13:22:32 +0300
Message-ID: <6ee9d67a-e907-715a-f3f5-d90a470314c3@ti.com>
References: <1461925297-9734-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461925297-9734-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 04/29/16 13:21, Peter Ujfalusi wrote:
> ldo7_reg should not work as regulator since it is set to 'disabled' s=
tate
> in the omap5-board-common.dtsi and the state is not changed to 'okay'
> this means that the ldo7_reg is not available to be used in the igep0=
050
> DTS file.
> ldo4_reg is used by all other OMAP5 boards and this is most likely th=
e
> correct regulator to use with hdmi.
> The hdmi needs 1.8V, but the ldo7_reg, based on the dtsi is 2V only.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> ---
> Tony,
>=20
> I don't have access to the schematics, but I believe tha the ldo7_reg=
 is not the
> correct regulator to be used for hdmi.
>=20
> If you have access and it is really ldo7_reg, then we should have thi=
s in the
> omap5-igep0050.dts file:
>=20
> &ldo5_reg {

ldo7_reg, obviously ;)

> 	status =3D "okay";
> 	regulator-min-microvolt =3D <1800000>;
> 	regulator-max-microvolt =3D <1800000>;
> };
>=20
> Regards,
> Peter
>=20
>  arch/arm/boot/dts/omap5-igep0050.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/omap5-igep0050.dts b/arch/arm/boot/dts=
/omap5-igep0050.dts
> index 46ecb1dd3b5c..6c8d40327c68 100644
> --- a/arch/arm/boot/dts/omap5-igep0050.dts
> +++ b/arch/arm/boot/dts/omap5-igep0050.dts
> @@ -20,7 +20,7 @@
>  };
> =20
>  &hdmi {
> -	vdda-supply =3D <&ldo7_reg>;
> +	vdda-supply =3D <&ldo4_reg>;
>  };
> =20
>  &i2c4 {
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
