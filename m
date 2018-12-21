From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH 01/14] ARM: dts: LogicPD Torpedo: Add WiLink UART node
Date: Fri, 21 Dec 2018 14:05:57 -0600
Message-ID: <CAHCN7x+5hq65LpF+G7rsiK89E7F+9fFiukgBA-u3RZZ6ov3xHg@mail.gmail.com>
References: <20181221011752.25627-1-sre@kernel.org> <20181221011752.25627-2-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221011752.25627-2-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 20, 2018 at 7:18 PM Sebastian Reichel <sre@kernel.org> wrote:
>
> From: Sebastian Reichel <sebastian.reichel@collabora.com>
>
> Add a node for the UART part of WiLink chip.
>
> Cc: Adam Ford <aford173@gmail.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> This is compile tested only!


I have tried this a few times, unfortunately, I cannot get the wl1283
to load the BT Firmware without timing out.  The btwilink driver is
the only option that works for me.

[   22.809600] Bluetooth: hci0: command 0xfd1c tx timeout
[   31.206390] Bluetooth: hci0: send command failed
[   31.211334] Bluetooth: hci0: download firmware failed, retrying...
[   31.367767] Bluetooth: hci0: change remote baud rate command in firmware
[   38.166351] Bluetooth: hci0: command 0xfd1c tx timeout
[   46.566375] Bluetooth: hci0: send command failed
[   46.571289] Bluetooth: hci0: download firmware failed, retrying...
[   46.738250] Bluetooth: hci0: change remote baud rate command in firmware
[   53.526336] Bluetooth: hci0: command 0xfd1c tx timeout

It times out, and tries again....and again....

Unless there is a driver fix to the BT UART, I don't think this should
be applied since I don't know what will happen if/when I try to use
the btwilink driver.

Having said that, I have no issues with the wl18xx and a wl127x on
other boards who don't need the btwilink driver.  I think it's somehow
related to the wl1283

adam

> ---
>  arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
> index 9d5d53fbe9c0..2699da12dc2d 100644
> --- a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
> +++ b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
> @@ -54,6 +54,14 @@
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
> 2.19.2
>
