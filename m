From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH 02/14] ARM: dts: IGEP: Add WiLink UART node
Date: Mon, 18 Feb 2019 23:04:46 +0100
Message-ID: <CAFqH_50kd4TRg6FTNZ-hZAPN14X8t++zY7mobTmPDfre8x59JQ@mail.gmail.com>
References: <20181221011752.25627-1-sre@kernel.org> <20181221011752.25627-3-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221011752.25627-3-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, linux-bluetooth@vger.kernel.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>
List-Id: linux-omap@vger.kernel.org

Hi Sebastian,

Sorry to take so long to reply

Missatge de Sebastian Reichel <sre@kernel.org> del dia dv., 21 de des.
2018 a les 9:05:
>
> From: Sebastian Reichel <sebastian.reichel@collabora.com>
>
> Add a node for the UART part of WiLink chip.
>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> This is compile tested only!
> ---
>  arch/arm/boot/dts/omap3-igep0020-rev-f.dts | 8 ++++++++
>  arch/arm/boot/dts/omap3-igep0030-rev-g.dts | 8 ++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
> index 285681d7af49..8bb4298ca05e 100644
> --- a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
> +++ b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
> @@ -52,3 +52,11 @@
>                 interrupts = <17 IRQ_TYPE_EDGE_RISING>; /* gpio 177 */
>         };
>  };
> +
> +&uart2 {
> +       bluetooth {
> +               compatible = "ti,wl1835-st";

That should be "ti,wl1831-st"

> +               enable-gpios = <&gpio5 9 GPIO_ACTIVE_HIGH>; /* gpio 137 */
> +               max-speed = <300000>;
> +       };
> +};
> diff --git a/arch/arm/boot/dts/omap3-igep0030-rev-g.dts b/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
> index 1adc73bd2ca0..03be171e9de7 100644
> --- a/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
> +++ b/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
> @@ -74,3 +74,11 @@
>                 interrupts = <8 IRQ_TYPE_EDGE_RISING>; /* gpio 136 */
>         };
>  };
> +
> +&uart2 {
> +       bluetooth {
> +               compatible = "ti,wl1835-st";

That should be "ti,wl1831-st"

> +               enable-gpios = <&gpio5 9 GPIO_ACTIVE_HIGH>; /* gpio 137 */
> +               max-speed = <300000>;
> +       };
> +};
> --
> 2.19.2
>

Apart from that,

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
