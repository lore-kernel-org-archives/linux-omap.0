From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 12/17] ARM: dts: Add missing aess node and binding for
 omap4
Date: Thu, 31 Aug 2017 08:54:25 +0300
Message-ID: <30241474-5f96-2d94-b1a9-4f163c8a4914@ti.com>
References: <20170830151953.30856-1-tony@atomide.com>
 <20170830151953.30856-13-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170830151953.30856-13-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

=EF=BB=BF


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 2017-08-30 18:19, Tony Lindgren wrote:
> On omap4 we're missing the aess node with it's related "ti,hwmods"
> property that the SoC interconnect code needs.
>=20
> Note that this will only show up as a bug with "doesn't have
> mpu register target base" boot errors when the legacy platform
> data is removed.
>=20
> Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> Cc: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/ti-aess.txt          | 33 ++++++++++++++++=
++++++
>  arch/arm/boot/dts/omap4.dtsi                       |  8 ++++++
>  2 files changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ti-aess.txt
>=20
> diff --git a/Documentation/devicetree/bindings/sound/ti-aess.txt b/Docume=
ntation/devicetree/bindings/sound/ti-aess.txt
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ti-aess.txt
> @@ -0,0 +1,33 @@
> +Texas Instruments Audio Engine Subsystem (AESS) binding
> +
> +AESS performs real-time signal processing on TI SoCs.
> +
> +
> +Required properties:
> +
> +compatible: Shall be one of the following:
> +	    "ti,omap4-aess"
> +
> +reg: Shall contain the device instance IO range
> +
> +interrupts: Shall contain the device instance interrupt
> +
> +
> +Optional properties:
> +
> +reg-names: Shall contain the IO range names if multiple IO
> +	   ranges are used by the SoC
> +
> +ti,hwmods: Shall contain the TI interconnect module name if needed
> +	   by the SoC
> +
> +
> +Example:
> +
> +	aess: aess@401f1000 {
> +		compatible =3D "ti,omap4-aess";
> +		reg =3D <0x401f1000 0x400>, /* MPU private access */
> +		      <0x490f1000 0x400>; /* L3 Interconnect */
> +		reg-names =3D "mpu", "dma";
> +		ti,hwmods =3D "aess";
> +	};
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -793,6 +793,14 @@
>  			ti,hwmods =3D "slimbus1";
>  		};
> =20
> +		aess: aess@401f1000 {
> +			compatible =3D "ti,omap4-aess";
> +			reg =3D <0x401f1000 0x400>, /* MPU private access */
> +			      <0x490f1000 0x400>; /* L3 Interconnect */
> +			reg-names =3D "mpu", "dma";
> +			ti,hwmods =3D "aess";

status =3D "disabled"

> +		};

Similar comment applies to AESS as to the McASP. We don't have driver
for it and we most likely not going to have.
But the binding is not correct in any case. The latest official Android
kernel is 3.4(ish) to support AESS/ABE. I have rewritten the whole thing
as an effort to upstream it and maintained the code up to 3.15. There
the DT node looks like this:

aess: aess@0x401f1000 {
	compatible =3D "ti,omap4-aess";
	reg =3D <0x401f1000 0x3ff>, /* MPU private access */
		<0x40180000 0xffff>, /* DMEM - MPU */
		<0x401a0000 0x1fff>, /* CMEM - MPU */
		<0x401c0000 0x5fff>, /* SMEM - MPU */
		<0x401e0000 0x1fff>, /* PMEM - MPU */
		<0x490f1000 0x3ff>, /* L3 Interconnect */
		<0x49080000 0xffff>, /* DMEM - MPU */
		<0x490a0000 0x1fff>, /* CMEM - MPU */
		<0x490ce000 0x5fff>, /* SMEM - MPU */
		<0x490e0000 0x1fff>; /* PMEM - MPU */
	reg-names =3D "mpu", "dmem", "cmem", "smem", "pmem",
			"dma","dmem_dma", "cmem_dma", "smem_dma",
			"pmem_dma";
	interrupts =3D <0 99 0x4>;
	ti,hwmods =3D "aess";
	dmas =3D <&sdma 101>,
		<&sdma 102>,
		<&sdma 103>,
		<&sdma 104>,
		<&sdma 105>,
		<&sdma 106>,
		<&sdma 107>,
		<&sdma 108>;
	dma-names =3D "fifo0", "fifo1", "fifo2", "fifo3", "fifo4",
			"fifo5", "fifo6", "fifo7";
};

This is more closer to what we might need to describe AESS, but it might
be not correct if I ever have the time to forward port and convert it to
current upstream framework (DPCM, graph, whatever)

> +
>  		mcbsp4: mcbsp@48096000 {
>  			compatible =3D "ti,omap4-mcbsp";
>  			reg =3D <0x48096000 0xff>; /* L4 Interconnect */
>=20

- P=C3=A9ter

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
