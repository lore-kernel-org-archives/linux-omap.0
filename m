From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 2/2] ARM: dts: am5729: beaglebone-ai: adding device tree
Date: Mon, 18 Nov 2019 13:33:29 +0200
Message-ID: <ff7aa0c6-b0d5-c87e-1d96-be77f5a7e2af@ti.com>
References: <20191114170933.12623-1-c-robey@ti.com>
 <20191114170933.12623-3-c-robey@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191114170933.12623-3-c-robey@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Caleb Robey <c-robey@ti.com>, linux-omap@vger.kernel.org
Cc: Jason Kridner <jkridner@gmail.com>, Lokesh Vutla <lokeshvutla@ti.com>, Jason Kridner <jdk@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, "Andrew F . Davis" <afd@ti.com>, Tom Rini <trini@konsulko.com>, Robert Nelson <robertcnelson@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 14/11/2019 19:09, Caleb Robey wrote:
> From: Jason Kridner <jdk@ti.com>
> 
> BeagleBoard.org BeagleBone AI is an open source hardware single
> board computer based on the Texas Instruments AM5729 SoC featuring
> dual-core 1.5GHz Arm Cortex-A15 processor, dual-core C66 digital
> signal processor (DSP), quad-core embedded vision engine (EVE),
> Arm Cortex-M4 processors, dual programmable realtime unit
> industrial control subsystems and more. The board features 1GB
> DDR3L, USB3.0 Type-C, USB HS Type-A, microHDMI, 16GB eMMC flash,
> 1G Ethernet, 802.11ac 2/5GHz, Bluetooth, and BeagleBone expansion
> headers.
> 
> For more information, refer to:
> https://beaglebone.ai
> 
> This patch introduces the BeagleBone AI device tree.
> 
> Note that the device use the "ti,tpd12s016" component which is
> software compatible with "ti,tpd12s015". Thus we only use the
> latter driver.
> 
> Signed-off-by: Jason Kridner <jdk@ti.com>
> Cc: Robert Nelson <robertcnelson@gmail.com>
> Cc: Caleb Robey <c-robey@ti.com>
> 
> ---
>   arch/arm/boot/dts/Makefile                |   1 +
>   arch/arm/boot/dts/am5729-beagleboneai.dts | 733 ++++++++++++++++++++++
>   2 files changed, 734 insertions(+)
>   create mode 100644 arch/arm/boot/dts/am5729-beagleboneai.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b21b3a64641a..b1154dbda73c 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -791,6 +791,7 @@ dtb-$(CONFIG_SOC_DRA7XX) += \
>   	am57xx-beagle-x15.dtb \
>   	am57xx-beagle-x15-revb1.dtb \

[..]

> +
> +&davinci_mdio {
> +	reset-gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
> +	reset-delay-us = <2>;
> +
> +	phy0: ethernet-phy@1 {
> +		reg = <4>;
> +		compatible = "ethernet-phy-id004d.d072",
> +			"ethernet-phy-ieee802.3-c22";

is it really required to have above compatible prop?
It's expected to work without it.

> +		eee-broken-100tx;
> +		eee-broken-1000t;
> +	};
> +};
> +
> +&mac {
> +	slaves = <1>;
> +	status = "okay";
> +};
> +
> +&cpsw_emac0 {
> +	phy-handle = <&phy0>;
> +	phy-mode = "rgmii";
> +};
> +

[...]

-- 
Best regards,
grygorii
