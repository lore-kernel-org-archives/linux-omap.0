From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 01/20] ARM: omap2plus_defconfig: Enable audio related
 config options
Date: Thu, 2 Jul 2015 09:20:58 -0500
Message-ID: <20150702142058.GK5837@saruman.tx.rr.com>
References: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
 <1435845995-19085-2-git-send-email-peter.ujfalusi@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k18oBAwMkTg3OUap"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1435845995-19085-2-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--k18oBAwMkTg3OUap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2015 at 05:06:16PM +0300, Peter Ujfalusi wrote:
> More and more boards are moving to have audio support via simple-card.
> At the same time enable options needed for most am335x and am43xx board f=
or
> audio support: McASP and TLV320AIC3X codecs.
> The later two has been selected by the CONFIG_SND_AM33XX_SOC_EVM option, =
but
> the aim is to convert all boards to use simple card.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>

Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
>  arch/arm/configs/omap2plus_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap=
2plus_defconfig
> index ac521e764d10..b001f7ae67f3 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -324,10 +324,13 @@ CONFIG_SND_USB_AUDIO=3Dm
>  CONFIG_SND_SOC=3Dm
>  CONFIG_SND_EDMA_SOC=3Dm
>  CONFIG_SND_AM33XX_SOC_EVM=3Dm
> +CONFIG_SND_DAVINCI_SOC_MCASP=3Dm
>  CONFIG_SND_OMAP_SOC=3Dm
>  CONFIG_SND_OMAP_SOC_OMAP_TWL4030=3Dm
>  CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=3Dm
>  CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=3Dm
> +CONFIG_SND_SIMPLE_CARD=3Dm
> +CONFIG_SND_SOC_TLV320AIC3X=3Dm
>  CONFIG_HID_GENERIC=3Dm
>  CONFIG_USB_HIDDEV=3Dy
>  CONFIG_USB_KBD=3Dm
> --=20
> 2.4.5
>=20

--=20
balbi

--k18oBAwMkTg3OUap
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVlUjKAAoJEIaOsuA1yqREP8kQAJTgSz5F8Ha3SGRXUMvf2MWu
QMq8DogGJ1mpmKorVN71mQs0LONQh8Pk2QFyRBNlj/LcsM2LtS4gaxhQjnXeSusY
7QLCFS61PbvfkxfNl53MOrCsvQGoUmavEV+rRAx30ShB52O5chVUtu3uKRriSgN/
FpAdsoESKFyy3FW97e/RoAwCPnZnn3KGQs8iegKEUasF3ZmlTxtzN2Ff9tSgJBZu
IlSCFLHSUh/SexdvL0ngN7f6PrKizXcp3dvaSmcS8MXV9FRlNTE41wcLU6e/FbjY
4HQSHUniU2+7K6EK1CJx05WnWi3JWqSwI+fK0IAeo/ItmXOLwwFpKG/rYQ9APuy9
aGkNI1avNSPdfwmUCpJfScJAqFTzPVPgq2Zi+TM4zpNZMxx9aH+6vS6ljvoIQGTV
oI2+monsbzX4f0tZFVoS9JjGRPwFiFkTxmfIMi7X+m2CzMDizqGeOCTwMLjZwXkt
l9yy1vFFu4YQMl4yVWn3FMQd4hIMBCesOrK4vpOtbD3m0DNXquisJ+8A7BVyL+iv
aOzXd86O/83HzV9AIrIcRz44MIgo6b4CwRXqTG3Xbsqo/zD+ANz0iH2Q1/m9mv46
8/BghrZSNbS7BJwHfKSG+H3RISeAlkgJTzTOHuNnVTqFms+Qpp6esETtQ361JHIo
YyeVRXXcrbLEea+rLSN8
=HR50
-----END PGP SIGNATURE-----

--k18oBAwMkTg3OUap--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
