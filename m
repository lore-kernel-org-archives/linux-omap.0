From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: Correct misspelling, "emda3" -> "edma3".
Date: Wed, 25 May 2016 22:38:54 +0300
Message-ID: <5031f60b-d586-dcbd-75fe-4ce12ec4b7d2@ti.com>
References: <alpine.LFD.2.20.1605241716520.14369@Device-040570>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.2.20.1605241716520.14369@Device-040570>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Robert P. J. Day" <rpjday-L09J2beyid0N/H6P543EQg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 05/25/2016 12:20 AM, Robert P. J. Day wrote:

Thanks! It shows that in the Linux driver we are not using the mperr in=
terrupt
at all...

Thank you agian for spotting it,

Acked-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>

>=20
> Reported-by: Adam J Allison <adamj.allison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Robert P. J. Day <rpjday-L09J2beyid0N/H6P543EQg@public.gmane.org>
>=20
> ---
>=20
> diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Docu=
mentation/devicetree/bindings/dma/ti-edma.txt
> index 079b42a..18090e7 100644
> --- a/Documentation/devicetree/bindings/dma/ti-edma.txt
> +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
> @@ -15,7 +15,7 @@ Required properties:
>  - reg:		Memory map of eDMA CC
>  - reg-names:	"edma3_cc"
>  - interrupts:	Interrupt lines for CCINT, MPERR and CCERRINT.
> -- interrupt-names: "edma3_ccint", "emda3_mperr" and "edma3_ccerrint"
> +- interrupt-names: "edma3_ccint", "edma3_mperr" and "edma3_ccerrint"
>  - ti,tptcs:	List of TPTCs associated with the eDMA in the following =
form:
>  		<&tptc_phandle TC_priority_number>. The highest priority is 0.
>=20
> @@ -48,7 +48,7 @@ edma: edma@49000000 {
>  	reg =3D	<0x49000000 0x10000>;
>  	reg-names =3D "edma3_cc";
>  	interrupts =3D <12 13 14>;
> -	interrupt-names =3D "edma3_ccint", "emda3_mperr", "edma3_ccerrint";
> +	interrupt-names =3D "edma3_ccint", "edma3_mperr", "edma3_ccerrint";
>  	dma-requests =3D <64>;
>  	#dma-cells =3D <2>;
>=20
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx=
=2Edtsi
> index 52be48b..03521ea 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -187,7 +187,7 @@
>  			reg =3D	<0x49000000 0x10000>;
>  			reg-names =3D "edma3_cc";
>  			interrupts =3D <12 13 14>;
> -			interrupt-names =3D "edma3_ccint", "emda3_mperr",
> +			interrupt-names =3D "edma3_ccint", "edma3_mperr",
>  					  "edma3_ccerrint";
>  			dma-requests =3D <64>;
>  			#dma-cells =3D <2>;
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372=
=2Edtsi
> index 12fcde4..27557b0 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -199,7 +199,7 @@
>  			interrupts =3D <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names =3D "edma3_ccint", "emda3_mperr",
> +			interrupt-names =3D "edma3_ccint", "edma3_mperr",
>  					  "edma3_ccerrint";
>  			dma-requests =3D <64>;
>  			#dma-cells =3D <2>;
> diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x=
=2Edtsi
> index d4537dc..a6e0aebc 100644
> --- a/arch/arm/boot/dts/dm814x.dtsi
> +++ b/arch/arm/boot/dts/dm814x.dtsi
> @@ -448,7 +448,7 @@
>  			reg =3D	<0x49000000 0x10000>;
>  			reg-names =3D "edma3_cc";
>  			interrupts =3D <12 13 14>;
> -			interrupt-names =3D "edma3_ccint", "emda3_mperr",
> +			interrupt-names =3D "edma3_ccint", "edma3_mperr",
>  					  "edma3_ccerrint";
>  			dma-requests =3D <64>;
>  			#dma-cells =3D <2>;
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dts=
i
> index e007401..95c8424 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -341,7 +341,7 @@
>  			interrupts =3D <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names =3D "edma3_ccint", "emda3_mperr",
> +			interrupt-names =3D "edma3_ccint", "edma3_mperr",
>  					  "edma3_ccerrint";
>  			dma-requests =3D <64>;
>  			#dma-cells =3D <2>;
>=20
> rday
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
