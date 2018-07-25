From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 20/32] ARM: dts: omap3-gta04: add devconf0 setup for mcbsp1 clock pins
Date: Wed, 25 Jul 2018 10:19:44 +0200
Message-ID: <F5FEB3CE-9ADC-4C21-A4D9-E9FBC20B4DBC@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com> <5dbe024d9465eab668ba9aac3732ded225859e6f.1532501910.git.hns@goldelico.com> <20180725081251.GC7467@lenoch>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725081251.GC7467@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Marek Belisko <marek@goldelico.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org


> Am 25.07.2018 um 10:12 schrieb Ladislav Michl <ladis@linux-mips.org>:
>=20
> On Wed, Jul 25, 2018 at 08:58:52AM +0200, H. Nikolaus Schaller wrote:
>> McBSP1 needs sepcial "pinctrl" for the clocks.
>=20
> Nit: "special" perhaps?

Thanks! Seems to be missing in the spell checker of checkpatch (or I =
didn't notice the message).

BR,
Nikolaus

>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> arch/arm/boot/dts/omap3-gta04.dtsi | 18 ++++++++++++++++++
>> 1 file changed, 18 insertions(+)
>>=20
>> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi =
b/arch/arm/boot/dts/omap3-gta04.dtsi
>> index 935a2a707737..f6abdef556c1 100644
>> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
>> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
>> @@ -187,6 +187,24 @@
>> 		reset-gpios =3D <&tca6507 0 GPIO_ACTIVE_LOW>;	/* =
W2CBW003 reset through tca6507 */
>> 	};
>>=20
>> +	/* devconf0 setup for mcbsp1 clock pins */
>> +	pinmux_mcbsp1@48002274 {
>> +		compatible =3D "pinctrl-single";
>> +		reg =3D <0x48002274 4>;   /* CONTROL_DEVCONF0 */
>> +		#address-cells =3D <1>;
>> +		#size-cells =3D <0>;
>> +		pinctrl-single,bit-per-mux;
>> +		pinctrl-single,register-width =3D <32>;
>> +		pinctrl-single,function-mask =3D <0x7>;	/* MCBSP1 CLK =
pinmux */
>> +		#pinctrl-cells =3D <2>;
>> +		pinctrl-names =3D "default";
>> +		pinctrl-0 =3D <&mcbsp1_devconf0_pins>;
>> +		mcbsp1_devconf0_pins: pinmux_mcbsp1_devconf0_pins {
>> +			/*                   offset bits mask */
>> +			pinctrl-single,bits =3D <0x00 0x08 0x1c>;	=
/* set MCBSP1_CLKR */
>> +		};
>> +	};
>> +
>> 	/* devconf1 setup for tvout pins */
>> 	pinmux_tv_out@480022d8 {
>> 		compatible =3D "pinctrl-single";
>> --=20
>> 2.12.2
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
