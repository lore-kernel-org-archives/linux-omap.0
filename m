From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] ARM: dts: OMAP5: fix polling intervals for thermal zones
Date: Fri, 27 Feb 2015 17:35:37 -0400
Message-ID: <20150227213535.GA5633@developer.amazonguestwifi.org>
References: <1425045543-19540-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:45364 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340AbbB0Vfm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2015 16:35:42 -0500
Received: by pablf10 with SMTP id lf10so25669626pab.12
        for <linux-omap@vger.kernel.org>; Fri, 27 Feb 2015 13:35:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1425045543-19540-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2015 at 03:59:03PM +0200, Tero Kristo wrote:
> OMAP4 has a finer counter granularity, which allows for a delay of 1000ms
> in the thermal zone polling intervals. OMAP5 has a different counter
> mechanism, which allows at maximum a 500ms timer. Adjust the cpu thermal
> zone polling interval accordingly.
>=20
> Without this patch, the polling interval information is simply ignored,
> and the following thermal warnings are printed during boot (assuming
> thermal is enabled);
>=20
> [    1.545343] ti-soc-thermal 4a0021e0.bandgap: Delay 1000 ms is not supp=
orted
> [    1.552691] ti-soc-thermal 4a0021e0.bandgap: Delay 1000 ms is not supp=
orted
> [    1.560029] ti-soc-thermal 4a0021e0.bandgap: Delay 1000 ms is not supp=
orted
>=20
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>

Acked-by: Eduardo Valentin <edubezval@gmail.com>


> ---
>  arch/arm/boot/dts/omap5-core-thermal.dtsi |    2 +-
>  arch/arm/boot/dts/omap5-gpu-thermal.dtsi  |    2 +-
>  arch/arm/boot/dts/omap5.dtsi              |    4 ++++
>  3 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/omap5-core-thermal.dtsi b/arch/arm/boot/dt=
s/omap5-core-thermal.dtsi
> index 19212ac..de8a3d4 100644
> --- a/arch/arm/boot/dts/omap5-core-thermal.dtsi
> +++ b/arch/arm/boot/dts/omap5-core-thermal.dtsi
> @@ -13,7 +13,7 @@
> =20
>  core_thermal: core_thermal {
>  	polling-delay-passive =3D <250>; /* milliseconds */
> -	polling-delay =3D <1000>; /* milliseconds */
> +	polling-delay =3D <500>; /* milliseconds */
> =20
>  			/* sensor       ID */
>  	thermal-sensors =3D <&bandgap     2>;
> diff --git a/arch/arm/boot/dts/omap5-gpu-thermal.dtsi b/arch/arm/boot/dts=
/omap5-gpu-thermal.dtsi
> index 1b87aca..bc3090f 100644
> --- a/arch/arm/boot/dts/omap5-gpu-thermal.dtsi
> +++ b/arch/arm/boot/dts/omap5-gpu-thermal.dtsi
> @@ -13,7 +13,7 @@
> =20
>  gpu_thermal: gpu_thermal {
>  	polling-delay-passive =3D <250>; /* milliseconds */
> -	polling-delay =3D <1000>; /* milliseconds */
> +	polling-delay =3D <500>; /* milliseconds */
> =20
>  			/* sensor       ID */
>  	thermal-sensors =3D <&bandgap     1>;
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index b321fdf..fee1580 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -1079,4 +1079,8 @@
>  	};
>  };
> =20
> +&cpu_thermal {
> +	polling-delay =3D <500>; /* milliseconds */
> +};
> +
>  /include/ "omap54xx-clocks.dtsi"
> --=20
> 1.7.9.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU8OLMAAoJEMLUO4d9pOJW2LkH/0l8lpDAI1tEnHNxxyWUzolc
Jqg7/Otdl1nr723tu+dlPBmA7PcDlK3pizzafCZYWVFVwUdj8GEh01sA5GyI2RJZ
sr49KWLmp47WoLJ+eV30YxPK3gJhB6C/3XqbLiqcb8tITfLaOULBfossAgJWf12L
wRz1NsO9K8B9xjf8ykbAMEkeJnADfTIRDfPPcPbbp7+FZ47PKNNa5YpEwilUpLMO
Z90Qw5ujcBkzQT8per9j/cbBR5dF2z8+g47oBWunbTI0su1taJxbSrDGRJ2nl6zI
+Wek+wdWso7E6ht8mt0AfkNQup47gi+ZN34I2AtEfhHu+zDXKZUxFbdnsEXN550=
=PlcD
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
