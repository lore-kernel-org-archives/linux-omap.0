From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] ARM: dts: omap4-panda: Add USB Host support
Date: Fri, 19 Apr 2013 11:18:33 +0300
Message-ID: <5170FDD9.904@ti.com>
References: <1366015721-25608-1-git-send-email-rogerq@ti.com> <20130418200935.GD10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41421 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757330Ab3DSISt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Apr 2013 04:18:49 -0400
In-Reply-To: <20130418200935.GD10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: b-cousson@ti.com, nm@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, devicetree-discuss@lists.ozlabs.org

On 04/18/2013 11:09 PM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [130415 01:53]:
>> Provide the RESET and Power regulators for the USB PHY,
>> the USB Host port mode and the PHY device.
>>
>> The USB PHY needs AUXCLK3 to operate. Provide this information
>> as well.
>>
>> Also provide pin multiplexer information for the USB host
>> pins.
>>
>> This patch depends on OMAP clock binding introduced in
>> https://lkml.org/lkml/2013/4/12/407
>=20
> Cool looks like EHCI works with this on my panda with linux
> next booting with DT. One comment below.
>=20
> Regards,
>=20
> Tony
>=20
> =20
>> CC: Beno=C3=AEt Cousson <b-cousson@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  arch/arm/boot/dts/omap4-panda-common.dtsi |   58 ++++++++++++++++++=
+++++++++++
>>  arch/arm/boot/dts/omap4.dtsi              |    5 ++
>>  2 files changed, 63 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/bo=
ot/dts/omap4-panda-common.dtsi
>> index 03bd60d..628f744 100644
>> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
>> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
>> @@ -54,6 +54,38 @@
>>  			"AFML", "Line In",
>>  			"AFMR", "Line In";
>>  	};
>> +
>> +	/* HS USB Port 1 RESET */
>> +	hsusb1_reset: hsusb1_reset_reg {
>> +		compatible =3D "regulator-fixed";
>> +		regulator-name =3D "hsusb1_reset";
>> +		regulator-min-microvolt =3D <3300000>;
>> +		regulator-max-microvolt =3D <3300000>;
>> +		gpio =3D <&gpio2 30 0>;	/* gpio_62 */
>> +		startup-delay-us =3D <70000>;
>> +		enable-active-high;
>> +	};
>> +
>> +	/* HS USB Port 1 Power */
>> +	hsusb1_power: hsusb1_power_reg {
>> +		compatible =3D "regulator-fixed";
>> +		regulator-name =3D "hsusb1_vbus";
>> +		regulator-min-microvolt =3D <3300000>;
>> +		regulator-max-microvolt =3D <3300000>;
>> +		gpio =3D <&gpio1 1 0>;	/* gpio_1 */
>> +		startup-delay-us =3D <70000>;
>> +		enable-active-high;
>> +	};
>> +
>> +	/* HS USB Host PHY on PORT 1 */
>> +	hsusb1_phy: hsusb1_phy {
>> +		compatible =3D "usb-nop-xceiv";
>> +		reset-supply =3D <&hsusb1_reset>;
>> +		vcc-supply =3D <&hsusb1_power>;
>> +		clocks =3D <&auxclk3>;
>> +		clock-names =3D "main_clk";
>> +		clock-frequency =3D <19200000>;
>> +	};
>>  };
>> =20
>>  &omap4_pmx_core {
>> @@ -64,6 +96,7 @@
>>  			&mcbsp1_pins
>>  			&dss_hdmi_pins
>>  			&tpd12s015_pins
>> +			&hsusbb1_pins
>>  	>;
>> =20
>>  	twl6040_pins: pinmux_twl6040_pins {
>> @@ -108,6 +141,23 @@
>>  		>;
>>  	};
>> =20
>> +	hsusbb1_pins: pinmux_hsusbb1_pins {
>> +		pinctrl-single,pins =3D <
>> +			0x82 0x10C	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_clk INPUT =
| PULLDOWN */
>> +			0x84 0x4	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_stp OUTPUT *=
/
>> +			0x86 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dir INPUT =
| PULLDOWN */
>> +			0x88 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_nxt INPUT =
| PULLDOWN */
>> +			0x8a 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat0 INPUT=
 | PULLDOWN */
>> +			0x8c 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat1 INPUT=
 | PULLDOWN */
>> +			0x8e 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat2 INPUT=
 | PULLDOWN */
>> +			0x90 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat3 INPUT=
 | PULLDOWN */
>> +			0x92 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat4 INPUT=
 | PULLDOWN */
>> +			0x94 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat5 INPUT=
 | PULLDOWN */
>> +			0x96 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat6 INPUT=
 | PULLDOWN */
>> +			0x98 0x104	/* USBB1_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat7 INPUT=
 | PULLDOWN */
>> +		>;
>> +	};
>> +
>>  	i2c1_pins: pinmux_i2c1_pins {
>>  		pinctrl-single,pins =3D <
>>  			0xe2 0x118        /* i2c1_scl PULLUP | INPUTENABLE | MODE0 */
>=20
> Looks like your comments are wrong above, it's not PULLDOWN? Also

right it's not.

> the naming should be mode0name.modename to be consistent. Here's
> what I dumped out, please check and replace spaces with tabs:
>=20
>                         0x82 0x10c      /* usbb1_ulpitll_clk.usbb1_ul=
piphy_clk gpio84 INPUT_PULLDOWN | MODE4 */
>                         0x84 0x4        /* usbb1_ulpitll_stp.usbb1_ul=
piphy_stp gpio85 OUTPUT | MODE4 */
>                         0x86 0x104      /* usbb1_ulpitll_dir.usbb1_ul=
piphy_dir gpio86 INPUT | MODE4 */
>                         0x88 0x104      /* usbb1_ulpitll_nxt.usbb1_ul=
piphy_nxt gpio87 INPUT | MODE4 */
>                         0x8a 0x104      /* usbb1_ulpitll_dat0.usbb1_u=
lpiphy_dat0 gpio88 INPUT | MODE4 */
>                         0x8c 0x104      /* usbb1_ulpitll_dat1.usbb1_u=
lpiphy_dat1 gpio89 INPUT | MODE4 */
>                         0x8e 0x104      /* usbb1_ulpitll_dat2.usbb1_u=
lpiphy_dat2 gpio90 INPUT | MODE4 */
>                         0x90 0x104      /* usbb1_ulpitll_dat3.usbb1_u=
lpiphy_dat3 gpio91 INPUT | MODE4 */
>                         0x92 0x104      /* usbb1_ulpitll_dat4.usbb1_u=
lpiphy_dat4 gpio92 INPUT | MODE4 */
>                         0x94 0x104      /* usbb1_ulpitll_dat5.usbb1_u=
lpiphy_dat5 gpio93 INPUT | MODE4 */
>                         0x96 0x104      /* usbb1_ulpitll_dat6.usbb1_u=
lpiphy_dat6 gpio94 INPUT | MODE4 */
>                         0x98 0x104      /* usbb1_ulpitll_dat7.usbb1_u=
lpiphy_dat7 gpio95 INPUT | MODE4 */

I don't think gpioXX is necessary as we aren't using any of them as GPI=
Os.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
