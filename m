From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 5/6] ARM: LG Optimus Black (P970) codename sniper support,
 with basic features
Date: Wed, 23 Dec 2015 13:03:17 -0300
Message-ID: <CABxcv=moAUEPo8sq5KhuLZChrQtwjF1aBeNvV1i8HvUnwDXMZA@mail.gmail.com>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
	<1450868319-20513-6-git-send-email-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450868319-20513-6-git-send-email-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Milo Kim <milo.kim@ti.com>, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hello Paul,

[snip]

> +
> +&omap3_pmx_core {
> +       pinctrl-names = "default";
> +
> +       uart3_pins: pinmux_uart3_pins {
> +               pinctrl-single,pins = <
> +                       0x16e (PIN_INPUT | MUX_MODE0)           /* uart3_rx_irrx */
> +                       0x170 (PIN_OUTPUT | MUX_MODE0)          /* uart3_tx_irtx */
> +               >;

Could you please use the IOPAD mux macros from
include/dt-bindings/pinctrl/omap.h instead?

We just did a massive cleanup on the OMAP DTS to use them instead of
an offset from the padconf registers.

Best regards,
Javier
