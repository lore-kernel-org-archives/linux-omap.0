From: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] dts: Add UARTs to am335x-bone-common.dtsi
Date: Sat, 7 Jun 2014 10:06:13 -0500
Message-ID: <CAOCHtYjFT_96wxbsAUY4-aKAC7LmqVpFEGDfyLTODFQ-uy9e+A@mail.gmail.com>
References: <alpine.LRH.2.00.1406071845220.13290@lnfm1.sai.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LRH.2.00.1406071845220.13290-SOd076a4/EvDFVh2fKDcTw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Matwey V. Kornilov" <matwey-TTlVxmypnbovJsYlp49lxw@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Jun 7, 2014 at 9:48 AM, Matwey V. Kornilov <matwey-TTlVxmypnbovJsYlp49lxw@public.gmane.org> wrote:
> From 739cee0aded1aac80764b3fca4e801464f199f93 Mon Sep 17 00:00:00 2001
> From: "Matwey V. Kornilov" <matwey.kornilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Date: Sat, 7 Jun 2014 17:23:57 +0400
> Subject: [PATCH] Add UARTs to am335x-bone-common.dtsi
>
> Add four UARTs pinouts and ports to beagle bone common dtsi.
>
> Signed-off-by: Matwey V. Kornilov <matwey-TTlVxmypnbovJsYlp49lxw@public.gmane.org>
> ---
>  arch/arm/boot/dts/am335x-bone-common.dtsi | 48
> +++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi
> b/arch/arm/boot/dts/am335x-bone-common.dtsi
> index 2e7d932..da3db9f 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -90,6 +90,30 @@
>                         0x174 (PIN_OUTPUT_PULLDOWN | MUX_MODE0) /*
> uart0_txd.uart0_txd */
>                 >;
>         };
> +       uart1_pins: pinmux_uart1_pins {
> +               pinctrl-single,pins = <
> +                       0x180 (PIN_INPUT_PULLUP | MUX_MODE0)    /*
> uart1_rxd.uart1_rxd */
> +                       0x184 (PIN_OUTPUT_PULLDOWN | MUX_MODE0) /*
> uart1_txd.uart1_txd */
> +               >;
> +       };
> +       uart2_pins: pinmux_uart2_pins {
> +               pinctrl-single,pins = <
> +                       0x150 (PIN_INPUT_PULLUP | MUX_MODE1)    /*
> spi0_sclk.uart2_rxd */
> +                       0x154 (PIN_OUTPUT_PULLDOWN | MUX_MODE1) /*
> spi0_d0.uart2_txd */
> +               >;
> +       };
> +       uart3_pins: pinmux_uart3_pins {
> +               pinctrl-single,pins = <
> +       /* Pin 0x160 spi0_cs1.uart3_rxd is not exported to the expansion
> header. The port is half-duplex */
> +                       0x164 (PIN_OUTPUT_PULLDOWN | MUX_MODE1) /*
> ecap0_in_pwm0_out.uart3_txd */
> +               >;
> +       };
> +       uart4_pins: pinmux_uart4_pins {
> +               pinctrl-single,pins = <
> +                       0x070 (PIN_INPUT_PULLUP | MUX_MODE6)    /*
> gpmc_wait0.uart4_rxd */
> +                       0x074 (PIN_OUTPUT_PULLDOWN | MUX_MODE6) /*
> gpmc_wpn.uart4_txd */
> +               >;
> +       };
>
>         clkout2_pin: pinmux_clkout2_pin {
>                 pinctrl-single,pins = <
> @@ -179,6 +203,30 @@
>
>         status = "okay";
>  };
> +&uart1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart1_pins>;
> +
> +       status = "okay";
> +};
> +&uart2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart2_pins>;
> +
> +       status = "okay";
> +};
> +&uart3 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart3_pins>;
> +
> +       status = "okay";
> +};
> +&uart4 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart4_pins>;
> +
> +       status = "okay";
> +};

These need to stay disabled in mainline, so drop the status = "okay";
, (till we get a working capemgr/overlay). Otherwise the pinmuxing
looks good.

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
