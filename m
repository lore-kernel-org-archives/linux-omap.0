From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCHv2 1/4] ARM: dts: LogicPD Torpedo: Add WiLink UART node
Date: Thu, 3 Oct 2019 16:40:26 -0500
Message-ID: <CAHCN7xLtHcU6q8_dorZOySPaQATce9qbvzcK1Tn0MoEF+tURHA@mail.gmail.com>
References: <20191003134147.9458-1-sre@kernel.org> <20191003134147.9458-2-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191003134147.9458-2-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 3, 2019 at 8:42 AM Sebastian Reichel <sre@kernel.org> wrote:
>
> From: Sebastian Reichel <sebastian.reichel@collabora.com>
>
> Add a node for the UART part of WiLink chip.
Thank you.

hci0:   Type: Primary  Bus: UART
        BD Address: 00:18:30:49:7D:63  ACL MTU: 1021:4  SCO MTU: 180:4
        UP RUNNING
        RX bytes:6185 acl:0 sco:0 events:581 errors:0
        TX bytes:91006 acl:0 sco:0 commands:578 errors:0

>
> This is compile tested only!
>
I am not sure which is more appropriate,

Acked-by: Adam Ford <aford173@gmail.com>
Tested-by: Adam Ford <aford173@gmail.com>

> Cc: Adam Ford <aford173@gmail.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
> index 18c27e85051f..c34ba0ef8b4d 100644
> --- a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
> +++ b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
> @@ -50,6 +50,14 @@
>         };
>  };
>
> +&uart2 {
> +       bluetooth {
> +               compatible = "ti,wl1283-st";
> +               enable-gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>; /* gpio 162 */
> +               max-speed = <3000000>;
> +       };
> +};
> +
>  &omap3_pmx_core {
>         mmc3_pins: pinmux_mm3_pins {
>                 pinctrl-single,pins = <
> --
> 2.23.0
>
