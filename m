From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 08/10] ARM/dts: am33xx: mcasp: Add location for data
 port registers to reg-property
Date: Wed, 9 Oct 2013 11:29:44 +0300
Message-ID: <525513F8.1040103@ti.com>
References: <cover.1381259962.git.jsarha@ti.com> <37c7ee5f2eab24df86baba1bd36da66c5a637744.1381259962.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42335 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942Ab3JII34 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 04:29:56 -0400
In-Reply-To: <37c7ee5f2eab24df86baba1bd36da66c5a637744.1381259962.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, mark.rutland@arm.com, joelf@ti.com, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, Darren Etheridge <detheridge@ti.com>

On 10/08/2013 10:36 PM, Jyri Sarha wrote:
> This patch adds a second tuple to reg property. The new property tupl=
e
> describes the memory location for data port registers mapped trough
> L3 bus on am33xx. The both property tuples are named accordingly in
> the reg-names property.
>=20
> Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
> Signed-off-by: Darren Etheridge <detheridge@ti.com>
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  arch/arm/boot/dts/am33xx.dtsi |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx=
=2Edtsi
> index 22659e7..c8ba19e 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -671,7 +671,9 @@
>  		mcasp0: mcasp@48038000 {
>  			compatible =3D "ti,omap2-mcasp-audio";
>  			ti,hwmods =3D "mcasp0";
> -			reg =3D <0x48038000 0x2000>;
> +			reg =3D <0x48038000 0x2000>,
> +			      <0x46400000 0x400000>;

mcasp0 data port is at 0x46000000. 0x46400000 is for mcasp1.

> +			reg-names =3D "mpu", "dat";
>  			interrupts =3D <80>, <81>;
>  			interrupts-names =3D "tx", "rx";
>  			status =3D "disabled";
> @@ -683,7 +685,9 @@
>  		mcasp1: mcasp@4803C000 {
>  			compatible =3D "ti,omap2-mcasp-audio";
>  			ti,hwmods =3D "mcasp1";
> -			reg =3D <0x4803C000 0x2000>;
> +			reg =3D <0x4803C000 0x2000>,
> +			      <0x46400000 0x400000>;
> +			reg-names =3D "mpu", "dat";
>  			interrupts =3D <82>, <83>;
>  			interrupts-names =3D "tx", "rx";
>  			status =3D "disabled";
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
