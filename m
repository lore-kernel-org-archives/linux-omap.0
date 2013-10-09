From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 09/10] ARM/dts: am335x-evm: Add audio support for am335x-evm.dts
Date: Wed, 9 Oct 2013 11:12:11 +0300
Message-ID: <52550FDB.4010401@ti.com>
References: <cover.1381259962.git.jsarha@ti.com> <1acef783bb6add9598add8214edd70f15e66e4ad.1381259962.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35071 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952Ab3JIIMW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 04:12:22 -0400
In-Reply-To: <1acef783bb6add9598add8214edd70f15e66e4ad.1381259962.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, mark.rutland@arm.com, joelf@ti.com, Darren Etheridge <detheridge@ti.com>

Hi Jyri,

On 10/08/2013 10:36 PM, Jyri Sarha wrote:
> @@ -407,6 +442,25 @@
> =20
>  #include "tps65910.dtsi"
> =20
> +&mcasp1 {
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&am335x_evm_audio_pins>;
> +
> +		status =3D "okay";
> +
> +		op-mode =3D <0>;          /* MCASP_IIS_MODE */
> +		tdm-slots =3D <2>;
> +		/* 16 serializer */
> +		serial-dir =3D <  /* 0: INACTIVE, 1: TX, 2: RX */
> +			0 0 1 2
> +			0 0 0 0
> +			0 0 0 0
> +			0 0 0 0
> +		>;

The McASP on AM335x have only 4 serializers.

> +		tx-num-evt =3D <1>;
> +		rx-num-evt =3D <1>;
> +};
> +
>  &tps {
>  	vcc1-supply =3D <&vbat>;
>  	vcc2-supply =3D <&vbat>;
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
