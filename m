From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 32/32] ARM: dts: omap3-gta04a5one: define GTA04A5 variant with OneNAND
Date: Wed, 25 Jul 2018 10:29:15 +0200
Message-ID: <96C87F41-C36B-4689-A92C-6A00D86538FA@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com> <51523efb93cd30a233d5c41918d5a08b2231647e.1532501910.git.hns@goldelico.com> <20180725082013.GD7467@lenoch>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725082013.GD7467@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Marek Belisko <marek@goldelico.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org


> Am 25.07.2018 um 10:20 schrieb Ladislav Michl <ladis@linux-mips.org>:
>=20
> On Wed, Jul 25, 2018 at 08:59:04AM +0200, H. Nikolaus Schaller wrote:
>> GTA04A5 has been produced with MCP chips either with
>> 512MB RAM +  512MB NAND
>> 512MB RAM + 1024MB NAND
>> 1024MB RAM +  512MB OneNAND
>>=20
>> RAM setup is done by U-Boot (MLO/SPL) but OneNAND needs
>> a different setup of the GPMC. So we need to derive a
>> DTB variant that modifies the gpmc and nand setup.
>=20
> Just a suggestion... This way your user needs to know which variant is =
dealing
> with. It is similar situation as with IGEPv2 with cames with various =
setup
> either with NAND or OneNAND. Both NAND and OneNAND nodes are present =
in DTB
> and enabled by U-Boot approriately. So single U-Boot binary and DTB is =
enough
> to deal with all variants.

Well, the standard U-Boot used on this type of devices just loads this =
or that
.dtb. It does not modify it or enable/disable nodes. So we'd prefer to =
have it
this way.

>=20
> 	ladis
>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> arch/arm/boot/dts/omap3-gta04a5one.dts | 114 =
+++++++++++++++++++++++++++++++++
>> 1 file changed, 114 insertions(+)
>> create mode 100644 arch/arm/boot/dts/omap3-gta04a5one.dts
>>=20
>> diff --git a/arch/arm/boot/dts/omap3-gta04a5one.dts =
b/arch/arm/boot/dts/omap3-gta04a5one.dts
>> new file mode 100644
>> index 000000000000..9b7bbdc344b3
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/omap3-gta04a5one.dts
>> @@ -0,0 +1,114 @@
>> +/*
>> + * Copyright (C) 2014-18 H. Nikolaus Schaller <hns@goldelico.com>
>> + *
>> + * This program is free software; you can redistribute it and/or =
modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include "omap3-gta04a5.dts"
>> +
>> +&omap3_pmx_core {
>> +	model =3D "Goldelico GTA04A5/Letux 2804 with OneNAND";
>> +
>> +	gpmc_pins: pinmux_gpmc_pins {
>> +		pinctrl-single,pins =3D <
>> +
>> +			/* address lines */
>> +			OMAP3_CORE1_IOPAD(0x207a, PIN_OUTPUT | =
MUX_MODE0)       /* gpmc_a1.gpmc_a1 */
>> +			OMAP3_CORE1_IOPAD(0x207c, PIN_OUTPUT | =
MUX_MODE0)       /* gpmc_a2.gpmc_a2 */
>> +			OMAP3_CORE1_IOPAD(0x207e, PIN_OUTPUT | =
MUX_MODE0)       /* gpmc_a3.gpmc_a3 */
>> +
>> +			/* data lines, gpmc_d0..d7 not muxable according =
to TRM */
>> +			OMAP3_CORE1_IOPAD(0x209e, PIN_INPUT | MUX_MODE0) =
       /* gpmc_d8.gpmc_d8 */
>> +			OMAP3_CORE1_IOPAD(0x20a0, PIN_INPUT | MUX_MODE0) =
       /* gpmc_d9.gpmc_d9 */
>> +			OMAP3_CORE1_IOPAD(0x20a2, PIN_INPUT | MUX_MODE0) =
       /* gpmc_d10.gpmc_d10 */
>> +			OMAP3_CORE1_IOPAD(0x20a4, PIN_INPUT | MUX_MODE0) =
       /* gpmc_d11.gpmc_d11 */
>> +			OMAP3_CORE1_IOPAD(0x20a6, PIN_INPUT | MUX_MODE0) =
       /* gpmc_d12.gpmc_d12 */
>> +			OMAP3_CORE1_IOPAD(0x20a8, PIN_INPUT | MUX_MODE0) =
       /* gpmc_d13.gpmc_d13 */
>> +			OMAP3_CORE1_IOPAD(0x20aa, PIN_INPUT | MUX_MODE0) =
       /* gpmc_d14.gpmc_d14 */
>> +			OMAP3_CORE1_IOPAD(0x20ac, PIN_INPUT | MUX_MODE0) =
       /* gpmc_d15.gpmc_d15 */
>> +
>> +			/*
>> +			 * gpmc_ncs0, gpmc_nadv_ale, gpmc_noe, gpmc_nwe, =
gpmc_wait0 not muxable
>> +			 * according to TRM. OneNAND seems to require =
PIN_INPUT on clock.
>> +			 */
>> +			OMAP3_CORE1_IOPAD(0x20b0, PIN_OUTPUT | =
MUX_MODE0)       /* gpmc_ncs1.gpmc_ncs1 */
>> +			OMAP3_CORE1_IOPAD(0x20be, PIN_INPUT | MUX_MODE0) =
       /* gpmc_clk.gpmc_clk */
>> +		>;
>> +	};
>> +};
>> +
>> +&gpmc {
>> +	/* switch inherited setup to OneNAND */
>> +
>> +	ranges =3D <0 0 0x04000000 0x1000000>;	/* CS0: 16MB for OneNAND =
*/
>> +	pinctrl-names =3D "default";
>> +	pinctrl-0 =3D <&gpmc_pins>;
>> +
>> +	/delete-node/ nand@0,0;
>> +
>> +	onenand@0,0 {
>> +
>> +		#address-cells =3D <1>;
>> +		#size-cells =3D <1>;
>> +		compatible =3D "ti,omap2-onenand";
>> +		reg =3D <0 0 0x20000>;	/* CS0, offset 0, IO size 128K =
*/
>> +
>> +		gpmc,sync-read;
>> +		gpmc,sync-write;
>> +		gpmc,burst-length =3D <16>;
>> +		gpmc,burst-read;
>> +		gpmc,burst-wrap;
>> +		gpmc,burst-write;
>> +		gpmc,device-width =3D <2>;
>> +		gpmc,mux-add-data =3D <2>;
>> +		gpmc,cs-on-ns =3D <0>;
>> +		gpmc,cs-rd-off-ns =3D <87>;
>> +		gpmc,cs-wr-off-ns =3D <87>;
>> +		gpmc,adv-on-ns =3D <0>;
>> +		gpmc,adv-rd-off-ns =3D <10>;
>> +		gpmc,adv-wr-off-ns =3D <10>;
>> +		gpmc,oe-on-ns =3D <15>;
>> +		gpmc,oe-off-ns =3D <87>;
>> +		gpmc,we-on-ns =3D <0>;
>> +		gpmc,we-off-ns =3D <87>;
>> +		gpmc,rd-cycle-ns =3D <112>;
>> +		gpmc,wr-cycle-ns =3D <112>;
>> +		gpmc,access-ns =3D <81>;
>> +		gpmc,page-burst-access-ns =3D <15>;
>> +		gpmc,bus-turnaround-ns =3D <0>;
>> +		gpmc,cycle2cycle-delay-ns =3D <0>;
>> +		gpmc,wait-monitoring-ns =3D <0>;
>> +		gpmc,clk-activation-ns =3D <5>;
>> +		gpmc,wr-data-mux-bus-ns =3D <30>;
>> +		gpmc,wr-access-ns =3D <81>;
>> +		gpmc,sync-clk-ps =3D <15000>;
>> +
>> +		x-loader@0 {
>> +			label =3D "X-Loader";
>> +			reg =3D <0 0x80000>;
>> +		};
>> +
>> +		bootloaders@80000 {
>> +			label =3D "U-Boot";
>> +			reg =3D <0x80000 0x1c0000>;
>> +		};
>> +
>> +		bootloaders_env@240000 {
>> +			label =3D "U-Boot Env";
>> +			reg =3D <0x240000 0x40000>;
>> +		};
>> +
>> +		kernel@280000 {
>> +			label =3D "Kernel";
>> +			reg =3D <0x280000 0x600000>;
>> +		};
>> +
>> +		filesystem@880000 {
>> +			label =3D "File System";
>> +			reg =3D <0x880000 0>;	/* 0 =3D =
MTDPART_SIZ_FULL */
>> +		};
>> +
>> +	};
>> +};
>> --=20
>> 2.12.2
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
