From: =?windows-1252?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH] Show proper respect for Heinrich Hertz by using the correct
 unit for frequency
Date: Mon, 11 May 2015 23:39:08 +0200
Message-ID: <5551217C.9090504@suse.de>
References: <20150511131952.GD2067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20150511131952.GD2067@n2100.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Am 11.05.2015 um 15:19 schrieb Russell King - ARM Linux:
> The SI unit of frequency is Hertz, named after Heinrich Hertz, and is
> given the symbol "Hz" to denote this.  "hz" is not the unit of freque=
ncy,
> and is in fact meaningless.
>=20
> Fix arch/arm to correctly use "Hz", thereby acknowledging Heinrich He=
rtz
> contribution to the modern world.
>=20
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Nice. :) Since you're being exact, should it be "Hertz' contribution"?

> diff --git a/arch/arm/boot/dts/omap3-cm-t3517.dts b/arch/arm/boot/dts=
/omap3-cm-t3517.dts
> index f5b5a1d96cd7..53ae04f9104d 100644
> --- a/arch/arm/boot/dts/omap3-cm-t3517.dts
> +++ b/arch/arm/boot/dts/omap3-cm-t3517.dts
> @@ -66,7 +66,7 @@
> =20
>  	otg_drv_vbus: pinmux_otg_drv_vbus {
>  		pinctrl-single,pins =3D <
> -			OMAP3_CORE1_IOPAD(0x2210, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rmii=
_50Mhz_clk.usb0_drvvbus */
> +			OMAP3_CORE1_IOPAD(0x2210, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rmii=
_50MHz_clk.usb0_drvvbus */

This one looks like an identifier - did you check where it comes from
and whether it needs to be fixed there as well?

>  		>;
>  	};
> =20

Rest looks good,

Reviewed-by: Andreas F=E4rber <afaerber@suse.de>

Cheers,
Andreas

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Felix Imend=F6rffer, Jane Smithard, Dilip Upmanyu, Graham Norton; H=
RB
21284 (AG N=FCrnberg)
