From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V3 5/6] ARM: am4372.dtsi: add omapdss information
Date: Tue, 8 Apr 2014 13:02:54 +0300
Message-ID: <5343C94E.8020100@ti.com>
References: <1395658916-9032-1-git-send-email-sathyap@ti.com> <1395658916-9032-6-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="tFg8i6NgVnjfDSwEjp0BABTG6s4uAIRag"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55440 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756267AbaDHKC5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Apr 2014 06:02:57 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id s38A2umL013361
	for <linux-omap@vger.kernel.org>; Tue, 8 Apr 2014 05:02:56 -0500
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
	by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id s38A2u0x010235
	for <linux-omap@vger.kernel.org>; Tue, 8 Apr 2014 05:02:56 -0500
In-Reply-To: <1395658916-9032-6-git-send-email-sathyap@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sathya Prakash M R <sathyap@ti.com>
Cc: linux-omap@vger.kernel.org

--tFg8i6NgVnjfDSwEjp0BABTG6s4uAIRag
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 24/03/14 13:01, Sathya Prakash M R wrote:
> Add DT data for the display subsystem, which contains the following
> blocks:
>     dss - the wrapper/glue for the display modules
>     dispc - display controller
>     rfbi - MIPI DBI encoder
> dss subsystem of am43x is re use from omap3.
>=20
> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
> ---
>  arch/arm/boot/dts/am4372.dtsi |   35 +++++++++++++++++++++++++++++++++=
++
>  1 file changed, 35 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.d=
tsi
> index ea55a4e..58fb78b 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -684,6 +684,41 @@
>  			num-cs =3D <4>;
>                          status =3D "disabled";
>                  };
> +
> +		dss: dss@4832A000 {
> +			compatible =3D "ti,omap3-dss", "simple-bus";
> +			reg =3D <0x4832A000 0x200>;
> +			status =3D "disabled";
> +			ti,hwmods =3D "dss_core";
> +			clocks =3D <&disp_clk>;
> +			clock-names =3D "fck";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			ranges;
> +
> +			dispc@4832A400 {
> +				compatible =3D "ti,omap3-dispc";
> +				reg =3D <0x4832A400 0x400>;
> +				interrupts =3D <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
> +				ti,hwmods =3D "dss_dispc";
> +				clocks =3D <&disp_clk>;
> +				clock-names =3D "fck";
> +			};
> +
> +			dpi: encoder@0 {
> +				compatible =3D "ti,omap3-dpi";
> +			};
> +
> +			rfbi: rfbi@4832A800 {
> +				compatible =3D "ti,omap3-rfbi";
> +				reg =3D <0x4832A800 0x100>;
> +				ti,hwmods =3D "dss_rfbi";
> +				clocks =3D <&disp_clk>;
> +				clock-names =3D "fck";
> +			};
> +
> +		};
> +

This needs to be updated for the latest DSS DT version. It's not merged
to linus' master branch.

At least the simple-bus and the dpi-node has to be removed.

 Tomi



--tFg8i6NgVnjfDSwEjp0BABTG6s4uAIRag
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTQ8lOAAoJEPo9qoy8lh718bwP/Rg4F2XRU/yXOc9VODsw4Q3x
EzIlnyGCGBeNsyfqa8XpjbX8lph9N1UYPtYmQvlZGR5uXN46fgWCryWJuo6zo5Zd
sBd5rJNvIDlFj7uuKYC9fX1TDqcgRjBwBj1qScorLOBudMCo9dGhmfSSr2kPD9Yo
fYeQGuPn+iR41W1A1DeY0aVnqC9J0NHsCeOVEK+ncCf409Ea7a9ghrcnUAa1tNcv
UKnTy3e1gF89o7Qy2uxckWhSDWsjK+HOeG283kdHL69wN3BnGlUMkaSSAWpHicwW
zshqTe/v9ffQ6T/uzN/TREfuINNVq0SeLu027pQvzNCmR3N/AR7Dsa1mEGPRZPqq
PUz+cllBK/6qE5bIeXsedcLLThUnrC89VKU8T3IjswuzX6+fBdkASY6lvUu0YIDn
1KBVEKquXQKcMhlkQrutBZNpg6p4O26x7cwzrB2FaQmx5rtWEJpPo6qllcj2/YOs
pJSCokP5h0jaFM4N1oJiAgRZt/BsYhDlVR5itoYHKHkmDRT+OMfIVgd6TmlRIGNA
VOEKqY46E5xctREuLqagzkl392J5QuOLgutzxMF5EqIfBrr8Y0O+1WD+8natB/zh
uyt/w4NHV62NnRbKap39TE3p0pte1NE+V02V4+kWNIQqifp+hx3QdK/x0Xw1Wc25
cynxi/Oz3JMH2/s/DepN
=UFre
-----END PGP SIGNATURE-----

--tFg8i6NgVnjfDSwEjp0BABTG6s4uAIRag--
