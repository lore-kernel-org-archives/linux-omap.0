From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 5/5] ARM: dts: am43x-epos-evm: Enable USB
Date: Thu, 13 Mar 2014 12:39:38 +0200
Message-ID: <53218AEA.3060301@ti.com>
References: <1394193422-18242-1-git-send-email-george.cherian@ti.com> <1394193422-18242-6-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394193422-18242-6-git-send-email-george.cherian@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: George Cherian <george.cherian@ti.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: balbi@ti.com, kishon@ti.com, rob@landley.net, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, tony@atomide.com, anatol.pomozov@gmail.com, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

On 03/07/2014 01:57 PM, George Cherian wrote:
> Enable
> 	- ocp2scp
> 	- USB PHY control module
> 	- USB PHY
> 	- dwc3_omap
> 	- USB

we are not enabling "PHY control module" here.

> 
> for am43x-epos-evm
> 
> Signed-off-by: George Cherian <george.cherian@ti.com>

With the description change.

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger

> ---
>  arch/arm/boot/dts/am43x-epos-evm.dts | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
> index a7d0db1..0ced342 100644
> --- a/arch/arm/boot/dts/am43x-epos-evm.dts
> +++ b/arch/arm/boot/dts/am43x-epos-evm.dts
> @@ -251,3 +251,21 @@
>  	pinctrl-0 = <&spi1_pins>;
>  	status = "okay";
>  };
> +
> +&usb2_phy1 {
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	dr_mode = "peripheral";
> +	status = "okay";
> +};
> +
> +&usb2_phy2 {
> +	status = "okay";
> +};
> +
> +&usb2 {
> +	dr_mode = "host";
> +	status = "okay";
> +};
> 
