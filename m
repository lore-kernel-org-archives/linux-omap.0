From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 1/1] ARM: dts: am5729: beaglebone-ai: adding device tree
Date: Thu, 21 Nov 2019 13:04:35 +0200
Message-ID: <8465b8c3-db4b-31fd-a299-3d5251ec99cf@ti.com>
References: <20191119202850.18149-1-c-robey@ti.com>
 <20191119202850.18149-2-c-robey@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191119202850.18149-2-c-robey@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Caleb Robey <c-robey@ti.com>, linux-omap@vger.kernel.org
Cc: Jason Kridner <jkridner@gmail.com>, Lokesh Vutla <lokeshvutla@ti.com>, Jason Kridner <jdk@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, "Andrew F . Davis" <afd@ti.com>, Tom Rini <trini@konsulko.com>, Robert Nelson <robertcnelson@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 19/11/2019 22:28, Caleb Robey wrote:
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
> Signed-off-by: Caleb Robey <c-robey@ti.com>
> Cc: Robert Nelson <robertcnelson@gmail.com>
> 
> ---
>   arch/arm/boot/dts/Makefile                |   1 +
>   arch/arm/boot/dts/am5729-beagleboneai.dts | 782 ++++++++++++++++++++++
>   2 files changed, 783 insertions(+)
>   create mode 100644 arch/arm/boot/dts/am5729-beagleboneai.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b21b3a64641a..b1154dbda73c 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile

[..]

> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&davinci_mdio {
> +	reset-gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
> +	reset-delay-us = <2>;
> +
> +	phy0: ethernet-phy@1 {
> +		reg = <4>;
> +		compatible = "ethernet-phy-id004d.d072",
> +			"ethernet-phy-ieee802.3-c22";

Pls, do not ignore my comments.

Above compatible should not be required.

> +		eee-broken-100tx;
> +		eee-broken-1000t;
> +	};
> +};
> +
> +&mac {
> +	slaves = <1>;
> +	status = "okay";
> +};

Pls, move cpsw node here

> +
> +&ocp {
> +	pruss1_shmem: pruss_shmem@4b200000 {
> +		status = "okay";
> +		compatible = "ti,pruss-shmem";
> +		reg = <0x4b200000 0x020000>;
> +	};
> +

[..]

> +
> +&cpsw_emac0 {
> +	phy-handle = <&phy0>;
> +	phy-mode = "rgmii";
> +};

Move it up, pls.

-- 
Best regards,
grygorii
