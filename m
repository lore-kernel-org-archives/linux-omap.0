From: George Cherian <george.cherian@ti.com>
Subject: Re: [PATCH 3/4] dts: dra7-evm: add USB support
Date: Fri, 2 Aug 2013 20:34:15 +0530
Message-ID: <51FBCA6F.9030503@ti.com>
References: <1375369134-26398-1-git-send-email-rogerq@ti.com> <1375369134-26398-4-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1375369134-26398-4-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, rnayak@ti.com, benoit.cousson@linaro.org, balbi@ti.com, kishon@ti.com, dmurphy@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 8/1/2013 8:28 PM, Roger Quadros wrote:
> Add USB drv_vbus pinctrl information and USB mode
> for the USB controller.
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   arch/arm/boot/dts/dra7-evm.dts |   22 ++++++++++++++++++++++
>   1 files changed, 22 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index cb0703c..acd3c09 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -18,3 +18,25 @@
>   		reg = <0x80000000 0x60000000>; /* 1536 MB */
>   	};
>   };
> +
> +&dra7_pmx_core {
> +        pinctrl-names = "default";
> +        pinctrl-0 = <
> +		&usb_pins
> +	>;
> +
> +	usb_pins: pinmux_usb_pins {
> +                pinctrl-single,pins = <
> +			0x280	0xc0000	/* usb1_drvvbus, SLOW_SLEW | PULLUPEN | MODE0 */
> +			0x284	0xc0000 /* usb2_drvvbus, SLOW_SLEW | PULLUPEN | MODE0 */
> +                >;
> +        };
> +};
> +
> +&dwc3_1 {
> +	dr_mode = "otg";

otg???
> +};
> +
> +&dwc3_2 {
> +	dr_mode = "host";
> +};


-- 
-George
