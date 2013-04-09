From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH, RFC, RFT] ARM/dts: omap4-panda: Add pinmux
 configuration for status leds
Date: Mon, 8 Apr 2013 17:12:30 -0700
Message-ID: <20130409001230.GG10155@atomide.com>
References: <1365181395-23838-1-git-send-email-v-stehle@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28082 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761336Ab3DIAMc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Apr 2013 20:12:32 -0400
Content-Disposition: inline
In-Reply-To: <1365181395-23838-1-git-send-email-v-stehle@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vincent =?utf-8?Q?Stehl=C3=A9?= <v-stehle@ti.com>
Cc: linux-omap@vger.kernel.org, gemini.tran@ti.com, "Cousson, Benoit" <b-cousson@ti.com>

* Vincent Stehl=C3=A9 <v-stehle@ti.com> [130405 10:08]:
> Add pinmux configuration for the OMAP4 PandaBoard & ES status leds. W=
e need to
> introduce an empty leds_core_pins section in the "shared" omap4-panda=
=2Edts for
> this, which is only used in the -es case.
>=20
> While at it, fix the heartbeat led for PandaBoard ES, which is gpio_1=
10.
>=20
> Signed-off-by: Vincent Stehl=C3=A9 <v-stehle@ti.com>
> Reported-by: Gemini Tran <gemini.tran@ti.com>
> ---
>=20
> Hi,
>=20
> Here is a patch to repair the OMAP4 PandaBoard status leds muxing. Co=
uld you
> please give me your feedback on this?

Added Benoit to cc also.
=20
> This is tested on PandaBoard ES only for the moment; so I would appre=
ciate any
> test report on PandaBoard Ax!
>=20
> Note: the empty leds_core_pins / pinmux_leds_core_pins section does n=
ot seem to
> be a problem, but maybe there is a more elegant way?

How about move the common entries to omap4-panda-common.dtsi that Benoi=
t
has queued up as "ARM: dts: omap4-panda: move generic sections to
panda-common"?

That way you can define the muxes in the board specifc .dts files witho=
ut
having to add the empty entries.

Regards,

Tony
=20
>  arch/arm/boot/dts/omap4-panda-es.dts | 21 ++++++++++++++++++++-
>  arch/arm/boot/dts/omap4-panda.dts    | 22 ++++++++++++++++++++--
>  2 files changed, 40 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/omap4-panda-es.dts b/arch/arm/boot/dts=
/omap4-panda-es.dts
> index 73bc1a6..c1d6c0b 100644
> --- a/arch/arm/boot/dts/omap4-panda-es.dts
> +++ b/arch/arm/boot/dts/omap4-panda-es.dts
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti=
=2Ecom/
> + * Copyright (C) 2012-2013 Texas Instruments Incorporated - http://w=
ww.ti.com/
>   *
>   * This program is free software; you can redistribute it and/or mod=
ify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -31,3 +31,22 @@
>  		0x5e 0x100	/* hdmi_sda.hdmi_sda INPUT | MODE 0 */
>  		>;
>  };
> +
> +/* PandaboardES has "half" different status leds gpios compared to P=
andaBoard4430. */
> +&heartbeat {
> +	label =3D "pandaboard::status1";
> +	gpios =3D <&gpio4 14 0>;	/* gpio_110 */
> +	linux,default-trigger =3D "heartbeat";
> +};
> +
> +&leds_core_pins {
> +	pinctrl-single,pins =3D <
> +		0xb6 0x3	/* abe_mcbsp2_clkx.gpio_110 OUTPUT | MODE3 */
> +	>;
> +};
> +
> +&leds_wkup_pins {
> +	pinctrl-single,pins =3D <
> +		0x1c 0x3	/* fref_clk4_out.gpio_wk8 OUTPUT | MODE3 */
> +	>;
> +};
> diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/om=
ap4-panda.dts
> index 4122efe..e645c4e 100644
> --- a/arch/arm/boot/dts/omap4-panda.dts
> +++ b/arch/arm/boot/dts/omap4-panda.dts
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti=
=2Ecom/
> + * Copyright (C) 2011-2013 Texas Instruments Incorporated - http://w=
ww.ti.com/
>   *
>   * This program is free software; you can redistribute it and/or mod=
ify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -21,7 +21,7 @@
> =20
>  	leds {
>  		compatible =3D "gpio-leds";
> -		heartbeat {
> +		heartbeat: heartbeat {
>  			label =3D "pandaboard::status1";
>  			gpios =3D <&gpio1 7 0>;
>  			linux,default-trigger =3D "heartbeat";
> @@ -67,6 +67,7 @@
>  			&mcbsp1_pins
>  			&dss_hdmi_pins
>  			&tpd12s015_pins
> +			&leds_core_pins
>  	>;
> =20
>  	twl6040_pins: pinmux_twl6040_pins {
> @@ -110,6 +111,23 @@
>  			0x58 0x10b	/* hdmi_hpd.gpio_63 INPUT PULLDOWN | MODE3 */
>  		>;
>  	};
> +
> +	leds_core_pins: pinmux_leds_core_pins {
> +	};
> +};
> +
> +&omap4_pmx_wkup {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <
> +			&leds_wkup_pins
> +	>;
> +
> +	leds_wkup_pins: pinmux_leds_wkup_pins {
> +		pinctrl-single,pins =3D <
> +			0x1a 0x3	/* fref_clk4_req.gpio_wk7 OUTPUT | MODE3 */
> +			0x1c 0x3	/* fref_clk4_out.gpio_wk8 OUTPUT | MODE3 */
> +		>;
> +	};
>  };
> =20
>  &i2c1 {
> --=20
> 1.8.1.2
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
